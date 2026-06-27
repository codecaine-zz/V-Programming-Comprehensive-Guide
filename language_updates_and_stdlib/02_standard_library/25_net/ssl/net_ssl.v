module main

import net.mbedtls
import net
import os
import time

// generate_certs runs openssl to create a temporary self-signed certificate and key.
fn generate_certs() ! {
	println('Generating temporary self-signed SSL certificate...')
	res := os.execute('openssl req -x509 -newkey rsa:2048 -keyout temp_server.key -out temp_server.crt -days 1 -nodes -subj "/CN=localhost"')
	if res.exit_code != 0 {
		return error('Failed to generate certs: ${res.output}')
	}
}

// cleanup_certs deletes the temporary certificate and key files.
fn cleanup_certs() {
	println('Cleaning up temporary certificate files...')
	os.rm('temp_server.key') or {}
	os.rm('temp_server.crt') or {}
}

// run_server starts the SSL server, accepts a client connection,
// reads a message, responds securely, and exits.
fn run_server(port int) ! {
	config := mbedtls.SSLConnectConfig{
		cert:     'temp_server.crt'
		cert_key: 'temp_server.key'
		validate: false
	}

	mut listener := mbedtls.new_ssl_listener('127.0.0.1:${port}', config) or {
		println('Server: Failed to create listener: ${err}')
		return err
	}
	defer {
		listener.shutdown() or {}
	}

	println('Server: Listening on SSL port ${port}...')

	mut conn := listener.accept() or {
		println('Server: Failed to accept SSL connection: ${err}')
		return err
	}
	defer {
		conn.close() or {}
	}

	println('Server: SSL Client connected!')

	mut buf := []u8{len: 1024}
	n := conn.read(mut buf) or {
		println('Server: Read failed: ${err}')
		return err
	}

	message := buf[..n].bytestr()
	println('Server: Received message: "${message}"')

	// Respond securely
	response := 'Echo Secure: ${message}'
	conn.write(response.bytes()) or {
		println('Server: Write failed: ${err}')
		return err
	}
	println('Server: Sent secure response.')
}

// run_client connects to the server port via TCP first, wraps it in SSL,
// sends a message, reads the secure response, and closes.
fn run_client(port int) ! {
	println('Client: Dialing standard TCP port first...')
	mut tcp_conn := net.dial_tcp('127.0.0.1:${port}') or {
		println('Client: Failed to connect standard TCP: ${err}')
		return err
	}

	println('Client: Initiating SSL handshake on top of TCP connection...')
	config := mbedtls.SSLConnectConfig{
		validate: false
	}

	mut ssl_conn := mbedtls.new_ssl_conn(config) or {
		println('Client: Failed to create SSL connection struct: ${err}')
		return err
	}
	defer {
		ssl_conn.close() or {}
	}

	ssl_conn.connect(mut tcp_conn, 'localhost') or {
		println('Client: SSL handshake failed: ${err}')
		return err
	}

	println('Client: Secure connection established!')

	message := 'Hello V Secure Sockets!'
	println('Client: Sending message: "${message}"')
	ssl_conn.write(message.bytes()) or {
		println('Client: Write failed: ${err}')
		return err
	}

	mut buf := []u8{len: 1024}
	n := ssl_conn.read(mut buf) or {
		println('Client: Read failed: ${err}')
		return err
	}

	response := buf[..n].bytestr()
	println('Client: Received response: "${response}"')
}

fn main() {
	println('=== net.ssl Module Demo ===')
	generate_certs() or {
		println('Error generating certs: ${err}')
		return
	}
	defer {
		cleanup_certs()
	}

	port := 38295
	// Spawn server in background
	spawn fn (p int) {
		run_server(p) or { println('Server thread failed: ${err}') }
	}(port)

	// Wait briefly for server to bind
	time.sleep(200 * time.millisecond)

	// Run client in main thread
	run_client(port) or { println('Client failed: ${err}') }

	time.sleep(50 * time.millisecond)
	println('SSL Demo finished.')
}
