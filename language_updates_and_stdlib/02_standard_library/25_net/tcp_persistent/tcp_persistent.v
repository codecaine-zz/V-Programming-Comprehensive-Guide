module main

import net
import time

// run_server starts the TCP server on the specified port, accepts a connection,
// and processes incoming messages in a loop until the client sends "Goodbye".
fn run_server(port int) ! {
	mut listener := net.listen_tcp(.ip, '127.0.0.1:${port}') or {
		println('Server: Failed to listen on port ${port}: ${err}')
		return err
	}
	defer {
		listener.close() or {}
	}

	println('Server: Listening on 127.0.0.1:${port}...')

	mut conn := listener.accept() or {
		println('Server: Failed to accept connection: ${err}')
		return err
	}
	defer {
		conn.close() or {}
	}

	println('Server: Client connected!')

	// Loop to handle back-and-forth messages on the same connection
	for {
		mut buf := []u8{len: 1024}
		n := conn.read(mut buf) or {
			println('Server: Connection closed or read error: ${err}')
			break
		}
		if n == 0 {
			println('Server: Client disconnected.')
			break
		}

		message := buf[..n].bytestr()
		println('Server received: "${message}"')

		if message == 'Goodbye' {
			println('Server received Goodbye. Replying and closing connection...')
			conn.write('Goodbye!'.bytes()) or {
				println('Server: Write failed: ${err}')
			}
			break
		}

		response := 'Echo: ${message}'
		println('Server sending: "${response}"')
		conn.write(response.bytes()) or {
			println('Server: Write failed: ${err}')
			break
		}
	}
	println('Server finished.')
}

// run_client connects to the TCP server, sends multiple messages,
// receives replies, and finally sends a goodbye message.
fn run_client(port int) ! {
	println('Client: Connecting to 127.0.0.1:${port}...')
	mut conn := net.dial_tcp('127.0.0.1:${port}') or {
		println('Client: Failed to connect: ${err}')
		return err
	}
	defer {
		conn.close() or {}
	}

	println('Client: Connected!')

	// Exchange multiple messages
	for i in 1 .. 4 {
		message := 'Ping ${i}'
		println('Client sending: "${message}"')
		conn.write(message.bytes()) or {
			println('Client: Write failed: ${err}')
			return err
		}

		// Read response
		mut buf := []u8{len: 1024}
		n := conn.read(mut buf) or {
			println('Client: Read failed: ${err}')
			return err
		}
		if n == 0 {
			println('Client: Server closed connection.')
			return error('Server closed connection unexpectedly')
		}

		response := buf[..n].bytestr()
		println('Client received response: "${response}"')
		
		time.sleep(50 * time.millisecond)
	}

	// Send Goodbye to cleanly terminate the persistent session
	println('Client sending: "Goodbye"')
	conn.write('Goodbye'.bytes()) or {
		println('Client: Write failed: ${err}')
		return err
	}

	mut buf := []u8{len: 1024}
	n := conn.read(mut buf) or {
		println('Client: Read failed: ${err}')
		return err
	}
	if n > 0 {
		response := buf[..n].bytestr()
		println('Client received response: "${response}"')
	}
	println('Client finished.')
}

fn main() {
	println('=== Persistent TCP Demo ===')
	port := 38293

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
	println('TCP Sockets Demo finished.')
}
