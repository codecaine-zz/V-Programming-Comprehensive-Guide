module main

fn main() {
	println('=== Array Update Syntax ===')

	base := [1, 2]
	a := [...base, 3, 4]

	println('base: ${base}') // [1, 2]
	println('a: ${a}')       // [1, 2, 3, 4]

	assert base == [1, 2]
	assert a == [1, 2, 3, 4]
}
