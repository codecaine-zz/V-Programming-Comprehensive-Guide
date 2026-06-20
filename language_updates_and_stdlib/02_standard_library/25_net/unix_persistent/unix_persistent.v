module main

import net.unix
import os
import time

// run_server starts the Unix socket server, accepts one client connection,
// and processes incoming messages in a loop until the client says "Goodbye".
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

	// Accept a connection
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
			println('Server received Goodbye. Replying and shutting down connection...')
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

// run_client connects to the Unix socket server, sends multiple messages,
// receives replies, and finally sends a goodbye message.
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
	println('=== Persistent Unix Sockets Demo ===')
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
	println('Unix Sockets Demo finished.')
}
