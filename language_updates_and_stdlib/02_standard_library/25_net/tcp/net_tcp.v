module main

import net
import time

// run_server starts the TCP server on the specified port, accepts a connection,
// reads a message, responds, and closes the connection.
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

// run_client connects to the TCP server, sends a message, reads the response,
// and closes the connection.
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

	// Send message to the server
	message := 'Hello V TCP Sockets!'
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
	println('=== net.tcp Module Demo ===')
	port := 38290

	// Spawn the server in a background thread
	spawn fn (p int) {
		run_server(p) or { println('Server thread failed: ${err}') }
	}(port)

	// Allow the server thread a short time to start and bind
	time.sleep(100 * time.millisecond)

	// Run the client in the main thread
	run_client(port) or { println('Client failed: ${err}') }

	// Give the server a small window to finish deferred cleanups
	time.sleep(50 * time.millisecond)
	println('TCP Demo finished.')
}
