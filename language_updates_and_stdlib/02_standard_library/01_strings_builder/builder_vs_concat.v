module main

import strings

fn main() {
	// This example shows a common beginner question:
	// when should you use strings.Builder instead of repeated string concatenation?
	// For many small cases, simple concatenation is fine, but builders are better
	// when you add many pieces inside a loop or when performance matters.

	mut message := ''
	for i in 0 .. 5 {
		message += 'step ${i} '
	}
	println('Concatenation result: ${message}')

	mut builder := strings.new_builder(100)
	for i in 0 .. 5 {
		builder.write_string('step ${i} ')
	}
	println('Builder result: ${builder.str()}')
}
