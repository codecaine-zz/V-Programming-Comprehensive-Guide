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
	// Decode request parameters into MathParams struct
	params := req.decode_params[MathParams]() or {
		wr.write_error(jsonrpc.invalid_params)
		return
	}

	result := MathResult{
		sum:        params.a + params.b
		difference: params.a - params.b
	}

	// Write the successful result back
	wr.write(result)
}

// Start JSON-RPC 2.0 Server over Unix Socket
fn run_rpc_server(socket_path string) ! {
	// Ensure cleanup of any old socket file
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

	// Accept client connection
	mut conn := listener.accept() or {
		println('Server: Accept failed: ${err}')
		return err
	}
	defer {
		conn.close() or {}
	}

	println('Server: Client connected, initiating JSON-RPC protocol.')

	// Setup JSON-RPC router and register math method
	mut router := jsonrpc.Router{}
	router.register('math.compute', handle_math)

	// Create JSON-RPC server wrapping the Unix socket connection stream
	mut server := jsonrpc.new_server(jsonrpc.ServerConfig{
		stream:  conn
		handler: router.handle_jsonrpc
	})

	// Process incoming request and respond
	server.respond() or {
		println('Server: Error processing request: ${err}')
		return err
	}
	println('Server: Successfully processed request and shut down.')
}

// Start JSON-RPC 2.0 Client over Unix Socket
fn run_rpc_client(socket_path string) ! {
	println('Client: Connecting to server at ${socket_path}...')
	mut conn := unix.connect_stream(socket_path) or {
		println('Client: Connection failed: ${err}')
		return err
	}
	defer {
		conn.close() or {}
	}

	// Create JSON-RPC client wrapping the Unix socket connection stream
	mut client := jsonrpc.new_client(jsonrpc.ClientConfig{
		stream: conn
	})

	params := MathParams{
		a: 45
		b: 17
	}

	println('Client: Sending request "math.compute" with params {a: ${params.a}, b: ${params.b}}')

	// Execute JSON-RPC request (method, parameters, request ID)
	resp := client.request('math.compute', params, 'req_math_1') or {
		println('Client: Request execution failed: ${err}')
		return err
	}

	// Decode response result
	result := resp.decode_result[MathResult]() or {
		println('Client: Failed to decode response result: ${err}')
		return err
	}

	println('Client received response:')
	println('  Request ID: ${resp.id}')
	println('  Result sum:        ${result.sum}')
	println('  Result difference: ${result.difference}')
}

fn main() {
	println('=== net.jsonrpc Module Demo ===')
	socket_path := os.join_path(os.temp_dir(), 'v_jsonrpc_example_socket')

	// Spawn JSON-RPC server in background thread
	spawn fn (path string) {
		run_rpc_server(path) or { println('Server thread failed: ${err}') }
	}(socket_path)

	// Wait briefly for the server socket to bind
	time.sleep(100 * time.millisecond)

	// Run JSON-RPC client in main thread
	run_rpc_client(socket_path) or { println('Client thread failed: ${err}') }

	// Wait briefly for server post-handling cleanups
	time.sleep(50 * time.millisecond)
	println('JSON-RPC Demo finished.')
}
