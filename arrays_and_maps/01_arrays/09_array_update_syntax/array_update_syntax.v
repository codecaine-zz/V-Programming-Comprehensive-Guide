module main

fn main() {
	println('=== Array Update Syntax ===')
	
	// NOTE: Array spread update syntax `[...base, 3, 4]` is defined in the V language specification (docs.md)
	// but is not fully supported in V 0.5.1 parser.
	// Below is the specification representation:
	/*
	base := [1, 2]
	a := [...base, 3, 4]
	assert a == [1, 2, 3, 4]
	*/
	
	// Equivalent cloning & appending representation for V 0.5.1:
	base := [1, 2]
	mut a := base.clone()
	a << 3
	a << 4
	println('base: ${base}') // [1, 2]
	println('a: ${a}')       // [1, 2, 3, 4]
	assert a == [1, 2, 3, 4]
}
