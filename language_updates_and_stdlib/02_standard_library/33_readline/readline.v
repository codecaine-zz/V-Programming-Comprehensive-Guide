module main

// `readline` reads a line of text from the user with a prompt.
// Compared to plain os.input(), a Readline instance supports line editing
// (arrow keys, backspace) and can keep input history between prompts in
// interactive terminals.
//
// Beginner tip: reading input can fail (e.g. the user presses Ctrl+D to
// signal end-of-file), so read_line() returns a Result that needs `or {}`.
import readline

fn main() {
	println('=== readline Module Demo ===')

	// Create a reusable reader. One instance can serve many prompts and
	// remembers history across calls.
	mut r := readline.Readline{}
	println('Simulating readline input (feed via stdin if non-interactive):')

	// Read a line from standard input. The string argument is the prompt
	// shown before the cursor. The trailing newline is NOT included.
	line := r.read_line('Enter text: ') or {
		// Reached on read errors or EOF (Ctrl+D / empty stdin).
		println('Error or EOF: ${err}')
		return
	}
	println('You entered: "${line}"')
}
