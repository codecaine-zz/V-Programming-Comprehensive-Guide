module main

import net.unix
import net.jsonrpc
import os
import time

// Define structs for request parameters and response results
struct MathParams {
pub:
	a int
	b int
}

struct MathResult {
pub:
	sum        int
	difference int
}

// Router handler to compute mathematical operations
fn handle_math(req &jsonrpc.Request, mut wr jsonrpc.ResponseWriter) {
	params := req.decode_params[MathParams]() or {
		wr.write_error(jsonrpc.invalid_params)
		return
	}

	result := MathResult{
		sum:        params.a + params.b
		difference: params.a - params.b
	}

	wr.write(result)
}

// Start JSON-RPC 2.0 Server over Unix Socket in a persistent loop
fn run_rpc_server(socket_path string) ! {
	if os.exists(socket_path) {
		os.rm(socket_path)!
	}

	mut listener := unix.listen_stream(socket_path, unix.ListenOptions{}) or {
		println('Server: Failed to listen: ${err}')
		return err
	}
	defer {
		listener.close() or {}
		listener.unlink() or {}
	}

	println('Server: Listening and waiting for connections...')

	mut conn := listener.accept() or {
		println('Server: Accept failed: ${err}')
		return err
	}
	defer {
		conn.close() or {}
	}

	println('Server: Client connected, starting persistent JSON-RPC loop.')

	mut router := jsonrpc.Router{}
	router.register('math.compute', handle_math)

	mut server := jsonrpc.new_server(jsonrpc.ServerConfig{
		stream:  conn
		handler: router.handle_jsonrpc
	})

	// Start the server processing loop (calls s.respond() in a loop)
	server.start()
	println('Server: Loop finished.')
}

// Start JSON-RPC 2.0 Client and make multiple requests over the same connection
fn run_rpc_client(socket_path string) ! {
	println('Client: Connecting to server at ${socket_path}...')
	mut conn := unix.connect_stream(socket_path) or {
		println('Client: Connection failed: ${err}')
		return err
	}
	defer {
		conn.close() or {}
	}

	mut client := jsonrpc.new_client(jsonrpc.ClientConfig{
		stream: conn
	})

	// Perform multiple requests over the same persistent connection
	for i in 1 .. 4 {
		params := MathParams{
			a: 10 * i
			b: 5 * i
		}
		req_id := 'req_math_${i}'
		println('Client: Sending request "${req_id}" for math.compute with {a: ${params.a}, b: ${params.b}}')

		resp := client.request('math.compute', params, req_id) or {
			println('Client: Request failed: ${err}')
			return err
		}

		result := resp.decode_result[MathResult]() or {
			println('Client: Failed to decode result: ${err}')
			return err
		}

		println('Client received response for ${resp.id}:')
		println('  sum:        ${result.sum}')
		println('  difference: ${result.difference}')
		
		time.sleep(50 * time.millisecond)
	}
}

fn main() {
	println('=== Persistent net.jsonrpc Module Demo ===')
	socket_path := os.join_path(os.temp_dir(), 'v_jsonrpc_persistent_socket')

	// Spawn JSON-RPC server in background thread
	spawn fn (path string) {
		run_rpc_server(path) or {
			println('Server thread failed: ${err}')
		}
	}(socket_path)

	// Wait briefly for the server socket to bind
	time.sleep(100 * time.millisecond)

	// Run JSON-RPC client in main thread
	run_rpc_client(socket_path) or {
		println('Client thread failed: ${err}')
	}

	// Wait briefly for server post-handling cleanups
	time.sleep(50 * time.millisecond)
	println('Persistent JSON-RPC Demo finished.')
}
