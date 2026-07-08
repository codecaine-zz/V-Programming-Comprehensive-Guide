module main

// The `maps` module adds functional-style helpers on top of V's built-in
// map type: filtering, transforming, inverting, and merging maps without
// writing the loops yourself.
//
// Beginner tip: everything here returns a NEW map/array — the input map is
// never modified (except merge_in_place, which says so in its name).
import maps

fn main() {
	println('=== maps Module Demo ===')

	// The sample map used by most examples below.
	m1 := {
		'apple':  1
		'banana': 2
		'cherry': 3
	}

	// filter(): keep only the entries for which the callback returns true.
	// Here we keep values greater than 1 (banana and cherry).
	filtered := maps.filter(m1, fn (k string, v int) bool {
		return v > 1
	})
	println('filter(): ${filtered}')

	// to_array(): convert each key/value pair into one array element.
	// Useful when you need a list built from map contents.
	keys_upper := maps.to_array(m1, fn (k string, v int) string {
		return k.to_upper()
	})
	println('to_array(): ${keys_upper}')

	// invert(): swap keys and values ({'apple': 1} becomes {1: 'apple'}).
	// Careful: duplicate values would collide after inversion.
	inverted := maps.invert(m1)
	println('invert(): ${inverted}')

	// from_array(): build a map from an array, using each element's index
	// as the key ({0: 'apple', 1: 'banana', ...}).
	fruits := ['apple', 'banana', 'cherry']
	map_from_arr := maps.from_array(fruits)
	println('from_array(): ${map_from_arr}')

	// merge(): combine two maps into a new one. When a key exists in both
	// ('banana' here), the SECOND map's value wins.
	m2 := {
		'banana': 20
		'date':   4
	}
	merged := maps.merge(m1, m2)
	println('merge(): ${merged}')

	// merge_in_place(): like merge(), but updates the first map directly
	// instead of returning a new one (note the `mut` requirement).
	mut mut_map := {
		'a': 1
	}
	maps.merge_in_place(mut mut_map, {
		'b': 2
		'c': 3
	})
	println('merge_in_place(): ${mut_map}')

	// flat_map(): map each key/value pair to a LIST of items, then flatten
	// all the lists into a single array.
	flat_items := maps.flat_map[string, int, string](m1, fn (k string, v int) []string {
		return [k, v.str()]
	})
	println('flat_map(): ${flat_items}')

	// to_map(): transform both keys and values into a brand-new map.
	// Here: uppercase the keys and multiply the values by 10.
	transformed := maps.to_map[string, int, string, int](m1, fn (k string, v int) (string, int) {
		return k.to_upper(), v * 10
	})
	println('to_map(): ${transformed}')
}
