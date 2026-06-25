module main

import net.unix
import os
import time

const max_message_size = 8192

// write_msg sends a message using a 4-byte magic signature and a 4-byte big-endian length in a single write syscall.
fn write_msg(mut conn unix.StreamConn, payload string) ! {
	mut buf := []u8{len: 8 + payload.len}
	buf[0] = `M`
	buf[1] = `S`
	buf[2] = `G`
	buf[3] = `0`
	buf[4] = u8((u32(payload.len) >> 24) & 0xff)
	buf[5] = u8((u32(payload.len) >> 16) & 0xff)
	buf[6] = u8((u32(payload.len) >> 8) & 0xff)
	buf[7] = u8(u32(payload.len) & 0xff)
	if payload.len > 0 {
		unsafe {
			C.memcpy(&buf[8], payload.str, payload.len)
		}
	}
	// Send consolidated buffer in a single system call
	conn.write(buf) or { return err }
}

// read_exact reads exactly `size` bytes from the connection, processing data in chunks.
// Real-world performance optimization: Reads directly into mutable slice views of our pre-allocated
// buffer to achieve zero-allocation reads inside the chunking loop.
fn read_exact(mut conn unix.StreamConn, size int) ![]u8 {
	mut data := []u8{len: size}
	mut read_bytes := 0
	for read_bytes < size {
		remaining := size - read_bytes
		// Use a small buffer chunk limit (e.g. 512 bytes) to demonstrate reading in chunks
		chunk_limit := if remaining > 512 { 512 } else { remaining }
		n := conn.read(mut data[read_bytes .. read_bytes + chunk_limit]) or { return err }
		if n == 0 {
			if read_bytes == 0 {
				return error('EOF')
			}
			return error('unexpected end of stream')
		}
		read_bytes += n
	}
	return data
}

// read_msg reads a single framed message.
fn read_msg(mut conn unix.StreamConn, max_size int) !string {
	// Read header: 4 magic bytes + 4 length bytes = 8 bytes
	header_bytes := read_exact(mut conn, 8) or { return err }
	
	// Validate protocol magic bytes
	if header_bytes[0] != `M` || header_bytes[1] != `S` || header_bytes[2] != `G` || header_bytes[3] != `0` {
		return error('invalid protocol magic bytes')
	}
	
	// Reconstruct big-endian length
	len := int((u32(header_bytes[4]) << 24) |
	           (u32(header_bytes[5]) << 16) |
	           (u32(header_bytes[6]) << 8) |
	           u32(header_bytes[7]))
	       
	// Real-world security boundary: Reject messages larger than allowed limit to prevent DoS (OOM)
	if len > max_size {
		return error('message size ${len} exceeds limit of ${max_size} bytes')
	}
	if len < 0 {
		return error('invalid negative message length')
	}
	
	// Read the actual payload
	payload_bytes := read_exact(mut conn, len) or { return err }
	return payload_bytes.bytestr()
}

// run_server starts the Unix socket server, accepts a connection,
// and processes incoming messages in a loop according to our framing protocol.
fn run_server(socket_path string) ! {
	// Clean up any stale socket file from a previous run
	if os.exists(socket_path) {
		os.rm(socket_path)!
	}

	// Listen on the Unix socket path
	mut listener := unix.listen_stream(socket_path, unix.ListenOptions{}) or {
		println('Server: Failed to listen on ${socket_path}: ${err}')
		return err
	}
	defer {
		listener.close() or {}
		listener.unlink() or {}
	}

	println('Server: Listening on socket path: ${socket_path}')

	mut conn := listener.accept() or {
		println('Server: Failed to accept connection: ${err}')
		return err
	}
	defer {
		conn.close() or {}
	}

	println('Server: Client connected!')

	// Real-world safety practice: Set read and write timeouts to prevent connection hang-ups (Slowloris DoS)
	conn.set_read_timeout(time.second * 5)
	conn.set_write_timeout(time.second * 5)

	for {
		message := read_msg(mut conn, max_message_size) or {
			if err.msg() == 'EOF' {
				println('Server: Client disconnected cleanly (EOF).')
			} else {
				println('Server: Connection closed or protocol error: ${err}')
			}
			break
		}
		
		// Preview message content
		preview_len := if message.len > 30 { 30 } else { message.len }
		println('Server received message (len: ${message.len}): "${message[..preview_len]}"...')

		if message == 'Goodbye' {
			println('Server received Goodbye. Replying and closing connection...')
			write_msg(mut conn, 'Goodbye!') or {
				println('Server: Write failed: ${err}')
			}
			break
		}

		response := 'Echo: ${message}'
		write_msg(mut conn, response) or {
			println('Server: Write failed: ${err}')
			break
		}
	}
	println('Server finished.')
}

// run_client connects to the Unix socket server, sends multiple messages (including
// a large chunked message and an invalid/overflow message), and validates responses.
fn run_client(socket_path string) ! {
	println('Client: Connecting to ${socket_path}...')
	mut conn := unix.connect_stream(socket_path) or {
		println('Client: Failed to connect: ${err}')
		return err
	}
	defer {
		conn.close() or {}
	}

	println('Client: Connected!')

	// Set connection timeouts for the client too
	conn.set_read_timeout(time.second * 5)
	conn.set_write_timeout(time.second * 5)

	// 1. Send a standard small message
	msg1 := 'Ping 1'
	println('Client sending small message: "${msg1}"')
	write_msg(mut conn, msg1)!
	resp1 := read_msg(mut conn, max_message_size)!
	println('Client received response: "${resp1}"')

	time.sleep(50 * time.millisecond)

	// 2. Send a large message within limit (5000 bytes) to trigger chunked read assembly
	msg2 := 'A'.repeat(5000)
	println('Client sending large message of length ${msg2.len}...')
	write_msg(mut conn, msg2)!
	resp2 := read_msg(mut conn, max_message_size)!
	println('Client received response of length ${resp2.len} successfully!')

	time.sleep(50 * time.millisecond)

	// 3. Attempt to send an invalid/overflow message (header length > max_message_size)
	println('Client sending invalid header claiming 100,000 bytes payload...')
	magic := [u8(`M`), `S`, `G`, `0`]
	bad_len_bytes := [u8(0), 1, 134, 160] // 100,000 big-endian
	conn.write(magic)!
	conn.write(bad_len_bytes)!

	// The server must reject the message and terminate the connection
	mut buf := []u8{len: 1}
	n := conn.read(mut buf) or {
		println('Client: Successfully verified server rejected overflow and closed connection: ${err}')
		return
	}
	if n == 0 {
		println('Client: Successfully verified server rejected overflow (EOF received).')
	} else {
		println('Client: Warning - Server did not close connection on overflow!')
	}
}

fn main() {
	println('=== Persistent Unix Sockets Protocol Demo ===')
	socket_path := os.join_path(os.temp_dir(), 'v_unix_socket_persistent')

	// Spawn the server in a background thread
	spawn fn (path string) {
		run_server(path) or {
			println('Server thread failed: ${err}')
		}
	}(socket_path)

	// Allow the server thread a short time to start and bind
	time.sleep(100 * time.millisecond)

	// Run the client in the main thread
	run_client(socket_path) or {
		println('Client failed: ${err}')
	}

	// Give the server a small window to finish deferred cleanups
	time.sleep(50 * time.millisecond)
	println('Unix Sockets Protocol Demo finished.')
}
