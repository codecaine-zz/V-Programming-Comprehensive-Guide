module main

import os
import time

fn main() {
	println('=== V OS Processes, Pipes & Signals (POSIX/Nix) ===')

	// --- 1. Spawning and Controlling Processes ---
	println('\n--- 1. Asynchronous Child Process (Process) ---')

	// Spawning '/bin/cat' as a child process
	mut p := os.new_process('/bin/cat')
	p.set_args([])
	p.set_environment({
		'CUSTOM_ENV_VAR': 'V-OS-Demo'
	})

	// Enable standard I/O redirection to interact with the process
	p.set_redirect_stdio()
	p.use_stdio_ctl = true

	// Start the process asynchronously
	p.run()
	println('Child process spawned with PID: ${p.pid}')
	println('Is alive? -> ${p.is_alive()}')

	// Write to the process's standard input
	p.stdin_write('Line 1: Hello from the parent process!\n')
	p.stdin_write('Line 2: WebAssembly and V standard libraries rule.\n')

	// Allow child process buffer to receive and echo the lines
	time.sleep(100 * time.millisecond)

	// Read output currently available in the stdout pipe
	output := p.stdout_read()
	println('Read from child stdout:\n${output.trim_space()}')

	// --- 2. POSIX Signaling ---
	println('\n--- 2. POSIX Signals ---')

	// Suspend the child process (SIGSTOP)
	println('Suspending child process (SIGSTOP)...')
	p.signal_stop()
	time.sleep(50 * time.millisecond)

	// Resume the child process (SIGCONT)
	println('Resuming child process (SIGCONT)...')
	p.signal_continue()
	time.sleep(50 * time.millisecond)

	// Terminate the child process (SIGTERM)
	println('Terminating child process (SIGTERM)...')
	p.signal_term()
	p.wait()

	println('Child process exited with status: ${p.status} (Code: ${p.code})')
	p.close()

	// --- 3. Pipes ---
	println('\n--- 3. Low-Level Descriptor Pipes (Pipe) ---')

	// Create a new pipe
	mut my_pipe := os.pipe() or {
		println('Failed to create pipe: ${err}')
		return
	}

	// Write to the pipe
	pipe_msg := 'IPC via Pipe'.bytes()
	written := my_pipe.write(pipe_msg) or {
		println('Failed to write to pipe: ${err}')
		0
	}
	println('Wrote ${written} bytes to pipe.')

	// Read from the pipe
	mut pipe_buf := []u8{len: 32}
	bytes_read := my_pipe.read(mut pipe_buf) or {
		println('Failed to read from pipe: ${err}')
		0
	}
	println('Read message from pipe: "${pipe_buf[..bytes_read].bytestr()}"')
	my_pipe.close()

	// --- 4. Capture Stdout/Stderr ---
	println('\n--- 4. Capture Stdout and Stderr (IOCapture) ---')

	// Flush stdout to prevent capturing existing print statements
	os.flush()

	// Capture all stdout/stderr output within this block
	mut cap := os.stdio_capture() or {
		println('Failed to initialize capture: ${err}')
		return
	}

	// Anything printed here will be redirected to the capture buffer
	print('Captured standard output data.')
	eprint('Captured standard error data.')

	// Restore standard streams and retrieve captured data
	captured_out, captured_err := cap.finish()

	println('Captured stdout lines: ${captured_out}')
	println('Captured stderr lines: ${captured_err}')
}
