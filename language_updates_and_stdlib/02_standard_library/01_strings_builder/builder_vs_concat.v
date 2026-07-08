module main

import strings

fn main() {
	// This example answers a common beginner question:
	// when should you use strings.Builder instead of repeated string concatenation?
	// For very small cases, simple concatenation is fine, but builders are more efficient
	// when you append many pieces inside a loop or build larger outputs step by step.

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
