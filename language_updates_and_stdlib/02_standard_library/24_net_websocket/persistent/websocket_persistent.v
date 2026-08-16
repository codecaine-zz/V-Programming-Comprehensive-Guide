module main

import net.websocket
import time
import json2

// WsMessage represents a structured application-level WebSocket message.
struct WsMessage {
pub:
	action string
	data   string
}

// ClientState maintains state for the WebSocket client across callbacks.
struct ClientState {
mut:
	count int
}

fn main() {
	println('=== Persistent WebSocket Protocol Demo ===')
	port := 38292
	uri := 'ws://localhost:${port}'

	// 1. Initialize and run local WebSocket server
	mut ws_server := websocket.new_server(.ip, port, '/')

	ws_server.on_connect(fn (mut s websocket.ServerClient) !bool {
		println('Server: Client connected from ${s.client_key}')
		return true
	})!

	// Server message handler: validates payload size, decodes JSON, and routes actions.
	ws_server.on_message(fn (mut ws websocket.Client, msg &websocket.Message) ! {
		if msg.opcode == .text_frame {
			payload := msg.payload.bytestr()

			// Safety check: Enforce maximum payload size limit (e.g., 2048 bytes) to prevent DoS (OOM)
			max_allowed_len := 2048
			if payload.len > max_allowed_len {
				println('Server: Rejected message of size ${payload.len} (exceeds ${max_allowed_len} limit)')
				// Close connection with code 1009 (Message Too Big)
				ws.close(1009, 'Message size exceeds limit') or {}
				return
			}

			// Decode the JSON protocol message
			ws_msg := json2.decode[WsMessage](payload) or {
				println('Server: Invalid JSON protocol: ${err}')
				err_resp := json2.encode(WsMessage{ action: 'error', data: 'invalid json' })
				ws.write_string(err_resp) or {}
				return
			}

			println('Server received action "${ws_msg.action}" with data (len: ${ws_msg.data.len})')

			match ws_msg.action {
				'ping' {
					resp := json2.encode(WsMessage{ action: 'pong', data: ws_msg.data })
					ws.write_string(resp)!
				}
				'goodbye' {
					println('Server received goodbye action. Replying and closing...')
					resp := json2.encode(WsMessage{ action: 'goodbye_ack', data: 'Goodbye!' })
					ws.write_string(resp)!
					// Clean close from server side
					ws.close(1000, 'Normal Closure') or {}
				}
				else {
					println('Server: Unknown action: ${ws_msg.action}')
				}
			}
		}
	})

	ws_server.on_close(fn (mut ws websocket.Client, code int, reason string) ! {
		println('Server: Client disconnected (code: ${code}, reason: "${reason}")')
	})

	// Start server listening in background thread
	spawn ws_server.listen()

	// Allow server time to bind and listen
	time.sleep(200 * time.millisecond)

	// 2. Client 1: Demonstrates persistent conversational ping-pong loop
	println('\n--- Starting Client 1 (Conversational Loop) ---')
	mut ws_client1 := websocket.new_client(uri)!

	mut state1 := &ClientState{
		count: 0
	}

	ws_client1.on_open(fn (mut c websocket.Client) ! {
		println('Client 1: Connection opened!')
		// Initiate the first Ping message
		ping_msg := json2.encode(WsMessage{ action: 'ping', data: '1' })
		c.write_string(ping_msg)!
	})

	ws_client1.on_message(fn [mut state1] (mut c websocket.Client, msg &websocket.Message) ! {
		if msg.opcode == .text_frame {
			payload := msg.payload.bytestr()
			ws_msg := json2.decode[WsMessage](payload) or { return }
			println('Client 1 received response action "${ws_msg.action}" with data: "${ws_msg.data}"')

			if ws_msg.action == 'pong' {
				state1.count++
				if state1.count < 3 {
					next_ping := json2.encode(WsMessage{ action: 'ping', data: '${state1.count + 1}' })
					println('Client 1 sending: "${next_ping}"')
					c.write_string(next_ping)!
				} else {
					goodbye := json2.encode(WsMessage{ action: 'goodbye', data: 'Goodbye' })
					println('Client 1 sending goodbye: "${goodbye}"')
					c.write_string(goodbye)!
				}
			} else if ws_msg.action == 'goodbye_ack' {
				println('Client 1 received goodbye ack. Client closing connection.')
				c.close(1000, 'Done') or {}
			}
		}
	})

	ws_client1.on_close(fn (mut c websocket.Client, code int, reason string) ! {
		println('Client 1: Connection closed (code: ${code}, reason: "${reason}")')
	})

	ws_client1.on_error(fn (mut c websocket.Client, error_msg string) ! {
		println('Client 1 error: ${error_msg}')
	})

	ws_client1.connect() or {
		println('Client 1 failed to connect: ${err}')
		return
	}
	spawn ws_client1.listen()

	// Wait for the first flow to complete
	time.sleep(600 * time.millisecond)

	// 3. RUN CLIENT CONNECTION 2: Reject oversized message
	println('\n--- Connection 2: Security Validation (Oversized Message) ---')
	mut ws_client2 := websocket.new_client(uri) or {
		println('Client 2 init failed: ${err}')
		return
	}

	ws_client2.on_open(fn (mut c websocket.Client) ! {
		println('Client 2: Connection opened!')
		// Send oversized data (3000 bytes, exceeding server 2048-byte limit)
		large_payload := 'A'.repeat(3000)
		large_msg := json2.encode(WsMessage{ action: 'ping', data: large_payload })
		println('Client 2 sending oversized payload (size: ${large_msg.len} bytes)...')
		c.write_string(large_msg)!
	})

	ws_client2.on_close(fn (mut c websocket.Client, code int, reason string) ! {
		println('Client 2: Connection closed (code: ${code}, reason: "${reason}")')
		if code == 1009 {
			println('Client 2: Successfully verified server rejected oversized message with code 1009!')
		} else if code == 1000 {
			// Ignore standard teardown close
		} else {
			println('Client 2: Unexpected close code: ${code}')
		}
	})

	ws_client2.on_error(fn (mut c websocket.Client, error_msg string) ! {
		println('Client 2 error: ${error_msg}')
	})

	ws_client2.connect() or {
		println('Client 2 failed to connect: ${err}')
		return
	}
	spawn ws_client2.listen()

	// Wait for the second flow to finish
	time.sleep(500 * time.millisecond)

	// Clean close of server listener
	println('\nWebSocket Protocol Demo finished.')
}
