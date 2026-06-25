module main

import net
import time

// UdpReassembler stores state for reassembling fragmented UDP packets.
struct UdpReassembler {
mut:
	fragments map[int][]u8
	total     int
}

// write_udp_msg fragments and sends a message to dialed destination.
fn write_udp_msg(mut socket net.UdpConn, payload string) ! {
	chunk_size := 1024
	payload_bytes := payload.bytes()
	total_frags := (payload_bytes.len + chunk_size - 1) / chunk_size
	
	if total_frags == 0 {
		header := [u8(`U`), `D`, `P`, `0`, 0, 1, 0, 0]
		socket.write(header) or { return err }
		return
	}
	
	for i in 0 .. total_frags {
		start := i * chunk_size
		mut end := (i + 1) * chunk_size
		if end > payload_bytes.len {
			end = payload_bytes.len
		}
		frag_payload := payload_bytes[start..end]
		frag_len := frag_payload.len
		
		header := [
			u8(`U`), `D`, `P`, `0`,
			u8(i),
			u8(total_frags),
			u8((u32(frag_len) >> 8) & 0xff),
			u8(u32(frag_len) & 0xff),
		]
		
		mut packet := []u8{cap: 8 + frag_len}
		packet << header
		packet << frag_payload
		
		socket.write(packet) or { return err }
		// Sleep briefly to avoid packet loss during loopback transmission
		time.sleep(2 * time.millisecond)
	}
}

// write_udp_msg_to fragments and sends a message to a specific address using write_to.
fn write_udp_msg_to(mut socket net.UdpConn, addr net.Addr, payload string) ! {
	chunk_size := 1024
	payload_bytes := payload.bytes()
	total_frags := (payload_bytes.len + chunk_size - 1) / chunk_size
	
	if total_frags == 0 {
		header := [u8(`U`), `D`, `P`, `0`, 0, 1, 0, 0]
		socket.write_to(addr, header) or { return err }
		return
	}
	
	for i in 0 .. total_frags {
		start := i * chunk_size
		mut end := (i + 1) * chunk_size
		if end > payload_bytes.len {
			end = payload_bytes.len
		}
		frag_payload := payload_bytes[start..end]
		frag_len := frag_payload.len
		
		header := [
			u8(`U`), `D`, `P`, `0`,
			u8(i),
			u8(total_frags),
			u8((u32(frag_len) >> 8) & 0xff),
			u8(u32(frag_len) & 0xff),
		]
		
		mut packet := []u8{cap: 8 + frag_len}
		packet << header
		packet << frag_payload
		
		socket.write_to(addr, packet) or { return err }
		time.sleep(2 * time.millisecond)
	}
}

// read_udp_msg reads packets from a socket and reassembles them into a single string.
fn read_udp_msg(mut socket net.UdpConn, max_allowed_fragments int) !(string, net.Addr) {
	mut fragments := map[int][]u8{}
	mut total_frags := -1
	mut remote_addr := net.Addr{}
	mut buf := []u8{len: 2048}

	for {
		read, addr := socket.read(mut buf) or { return err }
		if read == 0 {
			return error('empty packet read')
		}
		if read < 8 {
			return error('packet too small to contain header')
		}
		if buf[0] != `U` || buf[1] != `D` || buf[2] != `P` || buf[3] != `0` {
			return error('invalid packet magic bytes')
		}

		frag_idx := int(buf[4])
		total := int(buf[5])
		frag_len := int((u32(buf[6]) << 8) | u32(buf[7]))

		if read < 8 + frag_len {
			return error('packet payload length mismatch')
		}

		if total > max_allowed_fragments {
			return error('incoming message total fragments ${total} exceeds limit of ${max_allowed_fragments}')
		}

		if total_frags == -1 {
			total_frags = total
			remote_addr = addr
		}

		fragments[frag_idx] = buf[8 .. 8 + frag_len].clone()

		if fragments.len == total_frags {
			mut full_payload := []u8{}
			for i in 0 .. total_frags {
				if i !in fragments {
					return error('missing fragment ${i} in reassembly')
				}
				full_payload << fragments[i]
			}
			return full_payload.bytestr(), remote_addr
		}
	}
	return error('unexpected read loop termination')
}

// run_server starts the UDP server, processes fragments, reassembles them,
// and echoes back the full message or an error if size is exceeded.
fn run_server(port int) ! {
	mut socket := net.listen_udp('127.0.0.1:${port}') or {
		println('Server: Failed to listen on port ${port}: ${err}')
		return err
	}
	defer {
		socket.close() or {}
	}

	println('Server: Listening for UDP packets on port ${port}...')

	mut reassemblers := map[string]UdpReassembler{}
	mut buf := []u8{len: 2048}

	for {
		read, addr := socket.read(mut buf) or {
			println('Server: Read failed: ${err}')
			break
		}
		if read == 0 {
			break
		}

		if read < 8 {
			println('Server: Received packet too small to contain header')
			continue
		}

		// Verify header magic bytes
		if buf[0] != `U` || buf[1] != `D` || buf[2] != `P` || buf[3] != `0` {
			println('Server: Invalid packet magic bytes')
			continue
		}

		frag_idx := int(buf[4])
		total_frags := int(buf[5])
		frag_len := int((u32(buf[6]) << 8) | u32(buf[7]))

		if read < 8 + frag_len {
			println('Server: Packet payload length mismatch')
			continue
		}

		// Real-world safety limit check: Reject if fragment count exceeds threshold (max 5 fragments = 5KB)
		max_allowed_fragments := 5
		if total_frags > max_allowed_fragments {
			println('Server: Rejected message from ${addr}. Total fragments ${total_frags} exceeds limit of ${max_allowed_fragments}.')
			// Only send one error packet (on the first fragment index) to avoid flooding the client's socket queue
			if frag_idx == 0 {
				write_udp_msg_to(mut socket, addr, 'Error: Message size exceeds limit') or {}
			}
			continue
		}

		addr_str := addr.str()
		if addr_str !in reassemblers {
			reassemblers[addr_str] = UdpReassembler{
				total: total_frags
			}
		}

		mut r := reassemblers[addr_str]
		r.fragments[frag_idx] = buf[8 .. 8 + frag_len].clone()

		if r.fragments.len == r.total {
			mut full_payload := []u8{}
			mut success := true
			for i in 0 .. r.total {
				if i !in r.fragments {
					success = false
					break
				}
				full_payload << r.fragments[i]
			}

			// Clean up reassembler state
			reassemblers.delete(addr_str)

			if success {
				message := full_payload.bytestr()
				preview_len := if message.len > 30 { 30 } else { message.len }
				println('Server received full message from ${addr} (len: ${message.len}): "${message[..preview_len]}"...')

				if message == 'Goodbye' {
					println('Server received Goodbye. Replying and exiting...')
					write_udp_msg_to(mut socket, addr, 'Goodbye!') or {
						println('Server: Write failed: ${err}')
					}
					break
				}

				response := 'Echo: ${message}'
				write_udp_msg_to(mut socket, addr, response) or {
					println('Server: Write failed: ${err}')
					break
				}
			}
		} else {
			reassemblers[addr_str] = r
		}
	}
	println('Server finished.')
}

// run_client connects to the UDP server and runs test cases (small, fragmented, overflow, goodbye).
fn run_client(port int) ! {
	mut socket := net.dial_udp('127.0.0.1:${port}') or {
		println('Client: Failed to dial server: ${err}')
		return err
	}
	defer {
		socket.close() or {}
	}

	println('Client: Bound to server destination.')

	// 1. Send standard small message
	msg1 := 'Ping 1'
	println('Client sending small message: "${msg1}"')
	write_udp_msg(mut socket, msg1)!
	resp1, _ := read_udp_msg(mut socket, 5)!
	println('Client received response: "${resp1}"')

	time.sleep(50 * time.millisecond)

	// 2. Send fragmented message within limit (3000 bytes -> 3 fragments)
	msg2 := 'A'.repeat(3000)
	println('Client sending fragmented message of length ${msg2.len} (3 fragments)...')
	write_udp_msg(mut socket, msg2)!
	resp2, _ := read_udp_msg(mut socket, 5)!
	println('Client received response of length ${resp2.len} successfully!')

	time.sleep(50 * time.millisecond)

	// 3. Attempt to send message exceeding fragments limit (5500 bytes -> 6 fragments)
	msg3 := 'B'.repeat(5500)
	println('Client sending large message of length ${msg3.len} (6 fragments)...')
	write_udp_msg(mut socket, msg3)!
	resp3, _ := read_udp_msg(mut socket, 10)!
	println('Client received response for overflow message: "${resp3}"')

	time.sleep(50 * time.millisecond)

	// 4. Send Goodbye to exit
	println('Client sending: "Goodbye"')
	write_udp_msg(mut socket, 'Goodbye')!
	resp4, _ := read_udp_msg(mut socket, 5)!
	println('Client received response: "${resp4}"')
}

fn main() {
	println('=== Persistent UDP Protocol Demo ===')
	port := 38294

	// Spawn the server in a background thread
	spawn fn (p int) {
		run_server(p) or {
			println('Server thread failed: ${err}')
		}
	}(port)

	// Allow the server thread a short time to start and bind
	time.sleep(100 * time.millisecond)

	// Run the client in the main thread
	run_client(port) or {
		println('Client failed: ${err}')
	}

	// Give the server a small window to finish deferred cleanups
	time.sleep(50 * time.millisecond)
	println('UDP Protocol Demo finished.')
}
