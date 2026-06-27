module main

import net.websocket
import time

fn main() {
	println('=== net.websocket Module Demo ===')

	port := 30099
	uri := 'ws://localhost:${port}'

	// 1. Initialize and run a local WebSocket server in a separate thread
	mut ws_server := websocket.new_server(.ip, port, '/')

	ws_server.on_connect(fn (mut s websocket.ServerClient) !bool {
		println('Server: Client connecting from ${s.client_key}')
		return true
	})!

	ws_server.on_message(fn (mut ws websocket.Client, msg &websocket.Message) ! {
		if msg.opcode == .text_frame {
			payload := msg.payload.bytestr()
			println('Server received text: "${payload}"')

			// Echo message back to client
			ws.write_string('Echo: ' + payload)!
		}
	})

	// Run the server listening loop in a background thread
	spawn fn [mut ws_server] () {
		ws_server.listen() or { println('Server error: ${err}') }
	}()

	// Allow the server a moment to start
	time.sleep(100 * time.millisecond)

	// 2. Initialize the WebSocket client
	mut ws_client := websocket.new_client(uri) or {
		println('Client init failed: ${err}')
		return
	}

	ws_client.on_open(fn (mut c websocket.Client) ! {
		println('Client: Connection opened!')
	})

	ws_client.on_message(fn (mut c websocket.Client, msg &websocket.Message) ! {
		if msg.opcode == .text_frame {
			payload := msg.payload.bytestr()
			println('Client received text response: "${payload}"')
		}
	})

	ws_client.on_error(fn (mut c websocket.Client, error_msg string) ! {
		println('Client error: ${error_msg}')
	})

	// 3. Connect and run the client
	ws_client.connect() or {
		println('Client failed to connect: ${err}')
		return
	}

	// Start the client listen loop in a background thread
	spawn ws_client.listen()

	// 4. Send a test message
	time.sleep(50 * time.millisecond)
	msg_to_send := 'Hello WebSocket Server!'
	println('Client sending: "${msg_to_send}"')
	ws_client.write_string(msg_to_send) or { println('Client failed to send: ${err}') }

	// Wait for echo to arrive
	time.sleep(200 * time.millisecond)

	// Clean close
	println('Client closing connection...')
	ws_client.close(1000, 'Done') or { println('Client close error: ${err}') }
	time.sleep(50 * time.millisecond)
	println('WebSocket Demo finished.')
}
