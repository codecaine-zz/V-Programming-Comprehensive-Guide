module main

import maps

fn main() {
	println('--- Import Maps Module Helpers ---')

	// Start with a simple map of fruit counts.
	m1 := {
		'apple':  1
		'banana': 2
		'cherry': 3
	}

	// filter() keeps only the entries that satisfy the callback condition.
	filtered := maps.filter(m1, fn (k string, v int) bool {
		return v > 1
	})
	println('filter(): ${filtered}')

	// to_array() builds a new array by transforming each entry.
	keys_upper := maps.to_array(m1, fn (k string, v int) string {
		return k.to_upper()
	})
	println('to_array(): ${keys_upper}')

	// invert() swaps each key/value pair so the values become the keys.
	inverted := maps.invert(m1)
	println('invert(): ${inverted}')

	// from_array() creates a map from a list of strings.
	fruits := ['apple', 'banana', 'cherry']
	map_from_arr := maps.from_array(fruits)
	println('from_array(): ${map_from_arr}')

	// merge() combines two maps and lets the second map override duplicates.
	m2 := {
		'banana': 20
		'date':   4
	}
	merged := maps.merge(m1, m2)
	println('merge(): ${merged}')

	// merge_in_place() mutates the first map directly.
	mut mut_map := {
		'a': 1
	}
	maps.merge_in_place(mut mut_map, {
		'b': 2
		'c': 3
	})
	println('merge_in_place(): ${mut_map}')

	// flat_map() can expand each entry into multiple output values.
	flat_items := maps.flat_map[string, int, string](m1, fn (k string, v int) []string {
		return [k, v.str()]
	})
	println('flat_map(): ${flat_items}')

	// to_map() transforms each entry into a new key/value pair.
	transformed := maps.to_map[string, int, string, int](m1, fn (k string, v int) (string, int) {
		return k.to_upper(), v * 10
	})
	println('to_map(): ${transformed}')
}
