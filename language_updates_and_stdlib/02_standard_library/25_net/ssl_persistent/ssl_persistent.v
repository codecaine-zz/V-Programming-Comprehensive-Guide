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
// and processes incoming messages in a loop until the client sends "Goodbye".
fn run_server(port int) ! {
	config := mbedtls.SSLConnectConfig{
		cert: 'temp_server.crt'
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

	// Loop to handle back-and-forth messages on the same secure connection
	for {
		mut buf := []u8{len: 1024}
		n := conn.read(mut buf) or {
			println('Server: Secure connection closed or read error: ${err}')
			break
		}
		if n == 0 {
			println('Server: Client disconnected.')
			break
		}

		message := buf[..n].bytestr()
		println('Server received secure: "${message}"')

		if message == 'Goodbye' {
			println('Server received Goodbye. Replying and closing secure connection...')
			conn.write('Goodbye!'.bytes()) or {
				println('Server: Write failed: ${err}')
			}
			break
		}

		response := 'Echo: ${message}'
		println('Server sending secure: "${response}"')
		conn.write(response.bytes()) or {
			println('Server: Write failed: ${err}')
			break
		}
	}
	println('Server finished.')
}

// run_client connects to the server port via TCP first, wraps it in SSL,
// and sends multiple messages in a loop before ending the secure session cleanly.
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

	// Exchange multiple messages
	for i in 1 .. 4 {
		message := 'Ping ${i}'
		println('Client sending secure: "${message}"')
		ssl_conn.write(message.bytes()) or {
			println('Client: Write failed: ${err}')
			return err
		}

		// Read response
		mut buf := []u8{len: 1024}
		n := ssl_conn.read(mut buf) or {
			println('Client: Read failed: ${err}')
			return err
		}
		if n == 0 {
			println('Client: Server closed secure connection.')
			return error('Server closed connection unexpectedly')
		}

		response := buf[..n].bytestr()
		println('Client received secure response: "${response}"')
		
		time.sleep(50 * time.millisecond)
	}

	// Send Goodbye to cleanly terminate the persistent session
	println('Client sending: "Goodbye"')
	ssl_conn.write('Goodbye'.bytes()) or {
		println('Client: Write failed: ${err}')
		return err
	}

	mut buf := []u8{len: 1024}
	n := ssl_conn.read(mut buf) or {
		println('Client: Read failed: ${err}')
		return err
	}
	if n > 0 {
		response := buf[..n].bytestr()
		println('Client received secure response: "${response}"')
	}
	println('Client finished.')
}

fn main() {
	println('=== Persistent SSL Demo ===')
	generate_certs() or {
		println('Error generating certs: ${err}')
		return
	}
	defer {
		cleanup_certs()
	}

	port := 38296
	// Spawn the server in a background thread
	spawn fn (p int) {
		run_server(p) or {
			println('Server thread failed: ${err}')
		}
	}(port)

	// Allow the server thread a short time to start and bind
	time.sleep(200 * time.millisecond)

	// Run the client in the main thread
	run_client(port) or {
		println('Client failed: ${err}')
	}

	// Give the server a small window to finish deferred cleanups
	time.sleep(50 * time.millisecond)
	println('SSL Sockets Demo finished.')
}
