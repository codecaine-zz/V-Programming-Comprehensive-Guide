module main

import term

fn main() {
	println('=== term Module Demo ===')

	// ==========================================
	// 1. Terminal Size Metadata
	// ==========================================

	// term.get_terminal_size() returns the (width, height) of the active terminal session in columns and rows.
	width, height := term.get_terminal_size()
	println('Terminal size: ${width} columns x ${height} rows')

	// ==========================================
	// 2. Colored Text (Foreground Styling)
	// ==========================================

	// Foreground color helpers wrap the string with ANSI escape codes to change the text color.
	println(term.green('This text is green!'))
	println(term.red('This text is red!'))
	println(term.yellow('This text is yellow!'))
	println(term.blue('This text is blue!'))

	// ==========================================
	// 3. Text Styles & Modifiers
	// ==========================================

	// Text modifiers add visual decorations like bold, underline, or strikethrough.
	println(term.bold('This text is bold!'))
	println(term.underline('This text is underlined!'))
	println(term.strikethrough('This text has a strikethrough!'))

	// ==========================================
	// 4. Background Styling
	// ==========================================

	// Background color helpers fill the background area behind the printed characters.
	println(term.bg_blue(' This has a blue background! '))

	// ==========================================
	// 5. Mixed Styling & Layering
	// ==========================================

	// We can combine text color, style (bold/underline), and background color by nesting the calls.
	println(term.bg_blue(term.yellow(' Yellow text on a blue background ')))
	println(term.bg_red(term.white(term.bold(' Bold white text on a red background '))))
	println(term.bg_green(term.black(term.underline(' Underlined black text on a green background '))))

	// ==========================================
	// 6. Preformatted Status Messages
	// ==========================================

	// V's term module provides built-in preformatted status message helper templates.
	// These automatically print colored status stamps like [OK], [WARNING], or [FAILED] followed by the message.
	println(term.ok_message('Operation succeeded!'))
	println(term.warn_message('This is a warning!'))
	println(term.fail_message('Operation failed!'))
}
