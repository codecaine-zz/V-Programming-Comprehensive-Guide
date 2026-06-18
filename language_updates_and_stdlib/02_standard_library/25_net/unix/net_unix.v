module main

import net.unix
import os
import time

// run_server starts the Unix socket server, accepts one client connection,
// echoes back the received message, and exits.
fn run_server(socket_path string) ! {
	// Clean up any stale socket file from a previous run
	if os.exists(socket_path) {
		os.rm(socket_path)!
	}

	// Listen on the Unix socket path with default options
	mut listener := unix.listen_stream(socket_path, unix.ListenOptions{}) or {
		println('Server: Failed to listen on ${socket_path}: ${err}')
		return err
	}
	defer {
		listener.close() or {}
		listener.unlink() or {}
	}

	println('Server: Listening on socket path: ${socket_path}')

	// Accept an incoming connection
	mut conn := listener.accept() or {
		println('Server: Failed to accept connection: ${err}')
		return err
	}
	defer {
		conn.close() or {}
	}

	println('Server: Client connected!')

	// Read client's message
	mut buf := []u8{len: 1024}
	n := conn.read(mut buf) or {
		println('Server: Read failed: ${err}')
		return err
	}

	message := buf[..n].bytestr()
	println('Server: Received message: "${message}"')

	// Write response back to the client
	response := 'Echo: ${message}'
	conn.write(response.bytes()) or {
		println('Server: Write failed: ${err}')
		return err
	}
	println('Server: Sent echo response.')
}

// run_client connects to the Unix socket server, sends a message,
// reads the echo response, and closes the connection.
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

	// Send message to the server
	message := 'Hello V Unix Domain Sockets!'
	println('Client: Sending message: "${message}"')
	conn.write(message.bytes()) or {
		println('Client: Write failed: ${err}')
		return err
	}

	// Read server response
	mut buf := []u8{len: 1024}
	n := conn.read(mut buf) or {
		println('Client: Read failed: ${err}')
		return err
	}

	response := buf[..n].bytestr()
	println('Client: Received response: "${response}"')
}

fn main() {
	println('=== net.unix Module Demo ===')
	
	// Create a unique temporary socket path
	socket_path := os.join_path(os.temp_dir(), 'v_unix_socket_example')

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
