module main

import net
import time

// run_server starts the UDP server on the specified port, listens for a packet,
// prints the message, sends a response back to the sender, and exits.
fn run_server(port int) ! {
	mut socket := net.listen_udp('127.0.0.1:${port}') or {
		println('Server: Failed to listen on port ${port}: ${err}')
		return err
	}
	defer {
		socket.close() or {}
	}

	println('Server: Listening for UDP packets on port ${port}...')

	mut buf := []u8{len: 1024}
	read, addr := socket.read(mut buf) or {
		println('Server: Read failed: ${err}')
		return err
	}

	message := buf[..read].bytestr()
	println('Server: Received message from ${addr}: "${message}"')

	// Send echo response
	response := 'Echo: ${message}'
	socket.write_to(addr, response.bytes()) or {
		println('Server: Send failed: ${err}')
		return err
	}
	println('Server: Sent echo response.')
}

// run_client creates a UDP client socket, sends a datagram, and waits for a response.
fn run_client(port int) ! {
	mut socket := net.dial_udp('127.0.0.1:${port}') or {
		println('Client: Failed to dial server: ${err}')
		return err
	}
	defer {
		socket.close() or {}
	}

	message := 'Hello V UDP Sockets!'
	println('Client: Sending message: "${message}"')
	socket.write(message.bytes()) or {
		println('Client: Write failed: ${err}')
		return err
	}

	// Read server response
	mut buf := []u8{len: 1024}
	read, addr := socket.read(mut buf) or {
		println('Client: Read failed: ${err}')
		return err
	}

	response := buf[..read].bytestr()
	println('Client: Received response from ${addr}: "${response}"')
}

fn main() {
	println('=== net.udp Module Demo ===')
	port := 38291

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
	println('UDP Demo finished.')
}
