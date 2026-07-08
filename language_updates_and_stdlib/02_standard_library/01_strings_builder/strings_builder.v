module main

import strings

fn main() {
	// 1. Initialize a new Builder with pre-allocated buffer size (e.g. 100 bytes).
	// Pre-allocation is highly recommended for performance to reduce memory allocations.
	// A builder is a good choice when you are building a string incrementally in a loop.
	mut sb := strings.new_builder(100)

	// 2. Write strings and runes to the buffer
	sb.write_string('Welcome ')
	sb.write_string('to ')
	sb.write_string('the V standard library!')
	sb.write_rune(`\n`)

	sb.write_string('V is:\n')
	features := ['Fast', 'Simple', 'Statically Typed', 'Safe']
	for feature in features {
		sb.write_string('- ')
		sb.write_string(feature)
		sb.write_rune(`\n`)
	}

	// 3. Extract the final constructed string
	result := sb.str()
	println(result)

	// 4. Reset/Clear the builder to reuse it
	// In V, `clear()` clears the builder's buffer.
	sb.clear()
	sb.write_string('New content in builder.')
	println(sb.str())
}
