module main

import maps

fn main() {
	println('=== maps Module Demo ===')

	m1 := {
		'apple':  1
		'banana': 2
		'cherry': 3
	}

	// 1. Filter elements by condition
	filtered := maps.filter(m1, fn (k string, v int) bool {
		return v > 1
	})
	println('Filtered (values > 1): ${filtered}')

	// 2. Transform map entries to an array
	keys_upper := maps.to_array(m1, fn (k string, v int) string {
		return k.to_upper()
	})
	println('Transformed keys to upper array: ${keys_upper}')

	// 3. Invert map (swap keys and values)
	inverted := maps.invert(m1)
	println('Inverted map: ${inverted}')

	// 4. Construct a map from an array
	fruits := ['apple', 'banana', 'cherry']
	map_from_arr := maps.from_array(fruits)
	println('Map from array (index to element): ${map_from_arr}')

	// 5. Merge two maps
	m2 := {
		'banana': 20
		'date':   4
	}
	merged := maps.merge(m1, m2)
	println('Merged map (m2 overwrites duplicates): ${merged}')

	// 6. Merge in place (mutates the target map)
	mut mut_map := {
		'a': 1
	}
	maps.merge_in_place(mut mut_map, {'b': 2, 'c': 3})
	println('In-place merged map: ${mut_map}')
}
