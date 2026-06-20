module main

import net.websocket
import time

// ClientState maintains state across client callbacks
struct ClientState {
mut:
	count int
}

fn main() {
	println('=== Persistent WebSocket Demo ===')
	port := 38292
	uri := 'ws://localhost:${port}'

	// 1. Initialize and run a local WebSocket server
	mut ws_server := websocket.new_server(.ip, port, '/')
	
	ws_server.on_connect(fn (mut s websocket.ServerClient) !bool {
		println('Server: Client connected from ${s.client_key}')
		return true
	})!

	// Server message handler responds back to ping messages
	ws_server.on_message(fn (mut ws websocket.Client, msg &websocket.Message) ! {
		if msg.opcode == .text_frame {
			payload := msg.payload.bytestr()
			println('Server received text: "${payload}"')
			
			if payload.starts_with('Ping ') {
				num := payload.replace('Ping ', '')
				response := 'Pong ${num}'
				println('Server responding with: "${response}"')
				ws.write_string(response)!
			} else if payload == 'Goodbye' {
				println('Server received goodbye. Sending confirmation and closing...')
				ws.write_string('Goodbye!')!
			}
		}
	})

	// Start the server listen loop in a background thread
	spawn fn [mut ws_server] () {
		ws_server.listen() or {
			println('Server error: ${err}')
		}
	}()

	// Allow the server a moment to start
	time.sleep(100 * time.millisecond)

	// 2. Initialize the WebSocket client
	mut ws_client := websocket.new_client(uri) or {
		println('Client init failed: ${err}')
		return
	}

	mut state := &ClientState{
		count: 0
	}

	ws_client.on_open(fn (mut c websocket.Client) ! {
		println('Client: Connection opened!')
		// Initiate the first Ping message
		c.write_string('Ping 1')!
	})

	// Client message handler processes the Pong responses and decides
	// whether to send another Ping, or bid Goodbye.
	ws_client.on_message(fn [mut state] (mut c websocket.Client, msg &websocket.Message) ! {
		if msg.opcode == .text_frame {
			payload := msg.payload.bytestr()
			println('Client received response: "${payload}"')

			if payload.starts_with('Pong ') {
				state.count++
				if state.count < 3 {
					next_msg := 'Ping ${state.count + 1}'
					println('Client sending next message: "${next_msg}"')
					c.write_string(next_msg)!
				} else {
					println('Client sending goodbye: "Goodbye"')
					c.write_string('Goodbye')!
				}
			} else if payload == 'Goodbye!' {
				println('Client received goodbye response. Closing connection...')
				c.close(1000, 'Done') or {
					println('Client close error: ${err}')
				}
			}
		}
	})

	ws_client.on_close(fn (mut c websocket.Client, code int, reason string) ! {
		println('Client: Connection closed (code: ${code}, reason: "${reason}")')
	})

	ws_client.on_error(fn (mut c websocket.Client, error_msg string) ! {
		println('Client error: ${error_msg}')
	})

	// Connect and run the client listener
	ws_client.connect() or {
		println('Client failed to connect: ${err}')
		return
	}

	// Start the client listen loop in a background thread
	spawn ws_client.listen()

	// Wait for the conversational flow to finish
	time.sleep(1000 * time.millisecond)
	println('WebSocket Demo finished.')
}
