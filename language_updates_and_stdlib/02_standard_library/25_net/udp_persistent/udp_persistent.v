module main

import net
import time

// run_server starts the UDP server on the specified port, listens for packets,
// prints incoming messages and their source addresses, and responds to each
// in a loop until the client sends "Goodbye".
fn run_server(port int) ! {
	mut socket := net.listen_udp('127.0.0.1:${port}') or {
		println('Server: Failed to listen on port ${port}: ${err}')
		return err
	}
	defer {
		socket.close() or {}
	}

	println('Server: Listening for UDP packets on port ${port}...')

	// Loop to handle incoming UDP datagrams continuously
	for {
		mut buf := []u8{len: 1024}
		read, addr := socket.read(mut buf) or {
			println('Server: Read failed: ${err}')
			break
		}
		if read == 0 {
			break
		}

		message := buf[..read].bytestr()
		println('Server received from ${addr}: "${message}"')

		if message == 'Goodbye' {
			println('Server received Goodbye. Replying and exiting...')
			socket.write_to(addr, 'Goodbye!'.bytes()) or {
				println('Server: Write failed: ${err}')
			}
			break
		}

		response := 'Echo: ${message}'
		println('Server sending to ${addr}: "${response}"')
		socket.write_to(addr, response.bytes()) or {
			println('Server: Write failed: ${err}')
			break
		}
	}
	println('Server finished.')
}

// run_client creates a UDP socket bound to a remote destination address,
// and sends multiple messages in sequence, receiving responses from the server.
fn run_client(port int) ! {
	mut socket := net.dial_udp('127.0.0.1:${port}') or {
		println('Client: Failed to dial server: ${err}')
		return err
	}
	defer {
		socket.close() or {}
	}

	// Exchange multiple messages
	for i in 1 .. 4 {
		message := 'Ping ${i}'
		println('Client sending: "${message}"')
		socket.write(message.bytes()) or {
			println('Client: Write failed: ${err}')
			return err
		}

		// Read response
		mut buf := []u8{len: 1024}
		read, addr := socket.read(mut buf) or {
			println('Client: Read failed: ${err}')
			return err
		}

		response := buf[..read].bytestr()
		println('Client received response from ${addr}: "${response}"')
		
		time.sleep(50 * time.millisecond)
	}

	// Send Goodbye to cleanly terminate the session
	println('Client sending: "Goodbye"')
	socket.write('Goodbye'.bytes()) or {
		println('Client: Write failed: ${err}')
		return err
	}

	mut buf := []u8{len: 1024}
	read, addr := socket.read(mut buf) or {
		println('Client: Read failed: ${err}')
		return err
	}
	if read > 0 {
		response := buf[..read].bytestr()
		println('Client received response from ${addr}: "${response}"')
	}
	println('Client finished.')
}

fn main() {
	println('=== Persistent UDP Demo ===')
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
	println('UDP Sockets Demo finished.')
}
