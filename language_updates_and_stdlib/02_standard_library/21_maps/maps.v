module main

import maps

fn main() {
	println('=== maps Module Demo ===')

	m1 := {
		'apple':  1
		'banana': 2
		'cherry': 3
	}

	filtered := maps.filter(m1, fn (k string, v int) bool {
		return v > 1
	})
	println('filter(): ${filtered}')

	keys_upper := maps.to_array(m1, fn (k string, v int) string {
		return k.to_upper()
	})
	println('to_array(): ${keys_upper}')

	inverted := maps.invert(m1)
	println('invert(): ${inverted}')

	fruits := ['apple', 'banana', 'cherry']
	map_from_arr := maps.from_array(fruits)
	println('from_array(): ${map_from_arr}')

	m2 := {
		'banana': 20
		'date':   4
	}
	merged := maps.merge(m1, m2)
	println('merge(): ${merged}')

	mut mut_map := {
		'a': 1
	}
	maps.merge_in_place(mut mut_map, {
		'b': 2
		'c': 3
	})
	println('merge_in_place(): ${mut_map}')

	flat_items := maps.flat_map[string, int, string](m1, fn (k string, v int) []string {
		return [k, v.str()]
	})
	println('flat_map(): ${flat_items}')

	transformed := maps.to_map[string, int, string, int](m1, fn (k string, v int) (string, int) {
		return k.to_upper(), v * 10
	})
	println('to_map(): ${transformed}')
}
