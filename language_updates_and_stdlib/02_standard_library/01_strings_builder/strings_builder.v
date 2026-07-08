module main

import strings

fn main() {
	// 1. Create a builder with some space reserved up front.
	// A builder is useful when you assemble a string piece by piece, such as inside a loop.
	// This avoids repeatedly creating new strings, which can be slower for larger outputs.
	mut sb := strings.new_builder(100)

	// 2. Append strings and runes to the buffer.
	// This pattern is easier to read than writing many `+` operations in a long chain.
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

	// 3. Convert the accumulated content into one final string.
	result := sb.str()
	println(result)

	// 4. Reuse the builder after clearing it.
	// This is handy when you need to build several strings in sequence.
	sb.clear()
	sb.write_string('New content in builder.')
	println(sb.str())
}
