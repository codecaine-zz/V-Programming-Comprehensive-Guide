module main

import readline

fn main() {
	println('=== readline Module Demo ===')

	mut r := readline.Readline{}
	println('Simulating readline input (feed via stdin if non-interactive):')

	// Read a line from standard input
	line := r.read_line('Enter text: ') or {
		println('Error or EOF: ${err}')
		return
	}
	println('You entered: "${line}"')
}
