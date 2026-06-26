fn main() {
	mut sports := ['cricket', 'hockey', 'football', 'basketball', 'tennis']

	// Positive slicing: from index 1 to 3 (excluding index 3)
	println(sports[1..3]) // ['hockey', 'football']

	// V does not support negative indices natively in slices (e.g., sports[-2..] will not compile).
	// To achieve "negative slicing" (indexing from the end of the array), use the `.len` property:

	// Slice up to the last element (excluding it): Python's sports[..-1]
	println(sports[..sports.len - 1]) // ['cricket', 'hockey', 'football', 'basketball']

	// Slice from 3rd to last up to 1st to last (excluding it): Python's sports[-3..-1]
	println(sports[sports.len - 3..sports.len - 1]) // ['football', 'basketball']

	// Slice the last two elements: Python's sports[-2..]
	println(sports[sports.len - 2..]) // ['basketball', 'tennis']

	// --- REFERENCE VS VALUE BEHAVIOR ---
	// In V, slices are reference views of the original array.
	// If you modify an element of a slice, it affects the original array.
	// Note: To prevent unsafe behavior, assigning a slice to a variable requires an `unsafe` block
	// if you want it by-reference, or an explicit `.clone()` to get a copy by-value.

	// 1. Modifying by reference (using unsafe)
	mut original := [10, 20, 30, 40, 50]
	mut ref_slice := unsafe { original[1..4] }
	ref_slice[0] = 99
	println(original) // [10, 99, 30, 40, 50] (Original is modified!)

	// 2. Modifying by value (using .clone())
	mut original_two := [10, 20, 30, 40, 50]
	mut val_slice := original_two[1..4].clone()
	val_slice[0] = 99
	println(original_two) // [10, 20, 30, 40, 50] (Original remains unchanged!)
}
