module main

fn main() {
	println('=== Assert with Message ===')
	for i in 0 .. 5 {
		// This assertion is true for all i < 5, but demonstrates how to supply a message
		assert i * 2 < 10, 'assertion failed for i: ${i}'
	}
	println('All assertions passed!')
}
