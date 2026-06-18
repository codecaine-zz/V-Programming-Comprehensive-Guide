module main

import term

fn main() {
	println('=== term Module Demo ===')

	// 1. Get terminal size
	width, height := term.get_terminal_size()
	println('Terminal size: ${width} columns x ${height} rows')

	// 2. Colored text helpers
	println(term.green('This text is green!'))
	println(term.red('This text is red!'))
	println(term.yellow('This text is yellow!'))
	println(term.blue('This text is blue!'))

	// 3. Text styling modifiers
	println(term.bold('This text is bold!'))
	println(term.underline('This text is underlined!'))
	println(term.strikethrough('This text has a strikethrough!'))

	// 4. Background styling
	println(term.bg_blue(' This has a blue background! '))

	// 5. Message box helper formats
	println(term.ok_message('Operation succeeded!'))
	println(term.warn_message('This is a warning!'))
	println(term.fail_message('Operation failed!'))
}
