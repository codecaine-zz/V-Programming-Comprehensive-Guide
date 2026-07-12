module main

fn main() {
	println('=== Map Update Syntax ===')

	base_map := {
		'a': 4
		'b': 5
	}

	// Create a new map by updating elements of base_map
	foo := {
		...base_map
		'b': 88
		'c': 99
	}

	println('base_map: ${base_map}') // {'a': 4, 'b': 5}
	println('foo: ${foo}')           // {'a': 4, 'b': 88, 'c': 99}
	
	assert base_map['b'] == 5
	assert foo['a'] == 4
	assert foo['b'] == 88
	assert foo['c'] == 99
}
