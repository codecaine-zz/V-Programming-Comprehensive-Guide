module main

// A custom comparison function for sorting.
// It accepts references to elements (e.g. &int) and returns -1, 1, or 0.
fn compare_ints(a &int, b &int) int {
	val_a := *a
	val_b := *b
	if val_a < val_b {
		return -1
	}
	if val_a > val_b {
		return 1
	}
	return 0
}

fn main() {
	println('--- Array Built-in Methods ---')

	// 1. ensure_cap(required)
	// Ensures that the array has at least the specified capacity.
	mut a := [10, 20, 30]
	a.ensure_cap(10)
	println('ensure_cap: cap is ${a.cap >= 10}') // true

	// 2. repeat(count)
	// Repeats the array count times and returns a new array.
	rep := a.repeat(2)
	println('repeat: ${rep}') // [10, 20, 30, 10, 20, 30]

	// 3. repeat_to_depth(count, depth) (unsafe)
	// Recursively repeats a multi-dimensional array count times to the specified depth.
	grid := [[1, 2], [3, 4]]
	unsafe {
		rep_grid := grid.repeat_to_depth(2, 1)
		// Cast the raw array struct back to typed [][]int
		typed_grid := *(&[][]int(&rep_grid))
		println('repeat_to_depth: ${typed_grid}') // [[1, 2], [3, 4], [1, 2], [3, 4]]
		rep_grid.free()
	}
	// 4. insert(index, val)
	// Inserts a new element at the specified index.
	a.insert(1, 15)
	println('insert: ${a}') // [10, 15, 20, 30]

	// 5. prepend(val)
	// Prepends a new element at the beginning of the array.
	a.prepend(5)
	println('prepend: ${a}') // [5, 10, 15, 20, 30]

	// 6. delete(index)
	// Deletes the element at the specified index.
	a.delete(1) // Deletes index 1 (which is 10)
	println('delete: ${a}') // [5, 15, 20, 30]

	// 7. delete_many(index, size)
	// Deletes size elements starting from the specified index.
	a.delete_many(1, 2) // Deletes 2 elements starting at index 1
	println('delete_many: ${a}') // [5, 30]

	// 8. clear()
	// Sets the array length to 0, retaining capacity.
	mut a_clear := [1, 2, 3]
	a_clear.clear()
	println('clear: len is ${a_clear.len}') // 0

	// 9. reset() (unsafe)
	// Sets all elements of the array to 0 / empty values without altering len or cap.
	mut a_reset := [1, 2, 3]
	unsafe {
		a_reset.reset()
	}
	println('reset: ${a_reset}') // [0, 0, 0]
	unsafe {
		a_reset.free()
	}

	// 10. trim(index)
	// Truncates the array length to index.
	mut a_trim := [1, 2, 3, 4]
	a_trim.trim(2)
	println('trim: ${a_trim}') // [1, 2]

	// 11. drop(num)
	// Drops the first num elements in-place.
	mut a_drop := [1, 2, 3, 4]
	a_drop.drop(2)
	println('drop: ${a_drop}') // [3, 4]

	// 12. first()
	// Returns the first element of the array.
	println('first: ${a_drop.first()}') // 3

	// 13. last()
	// Returns the last element of the array.
	println('last: ${a_drop.last()}') // 4

	// 14. pop_left()
	// Removes and returns the first element of the array.
	mut a_pop := [1, 2, 3]
	first_val := a_pop.pop_left()
	println('pop_left: value = ${first_val}, array = ${a_pop}') // 1, [2, 3]

	// 15. pop()
	// Removes and returns the last element of the array.
	last_val := a_pop.pop()
	println('pop: value = ${last_val}, array = ${a_pop}') // 3, [2]

	// 16. delete_last()
	// Deletes the last element of the array.
	mut a_del_last := [1, 2, 3]
	a_del_last.delete_last()
	println('delete_last: ${a_del_last}') // [1, 2]

	// 17. clone()
	// Returns a deep copy of the array.
	a_clone := a_del_last.clone()
	println('clone: ${a_clone}') // [1, 2]

	// 18. clone_to_depth(depth) (unsafe)
	// Recursively clones a multi-dimensional array up to the specified depth.
	grid2 := [[1, 2], [3, 4]]
	unsafe {
		grid_clone := grid2.clone_to_depth(1)
		typed_clone := *(&[][]int(&grid_clone))
		println('clone_to_depth: ${typed_clone}') // [[1, 2], [3, 4]]
		grid_clone.free()
	}
	// 19. push_many(val, size) (unsafe)
	// Appends size elements starting from a raw pointer val to the array.
	mut a_push := [1, 2]
	vals := [3, 4]
	unsafe {
		a_push.push_many(vals.data, 2)
	}
	println('push_many: ${a_push}') // [1, 2, 3, 4]
	unsafe {
		a_push.free()
		vals.free()
	}
	// 20. reverse()
	// Returns a new reversed copy of the array.
	a_rev := [1, 2, 3]
	println('reverse: ${a_rev.reverse()}') // [3, 2, 1]

	// 21. reverse_in_place()
	// Reverses the array elements in-place.
	mut a_rev_ip := [1, 2, 3]
	a_rev_ip.reverse_in_place()
	println('reverse_in_place: ${a_rev_ip}') // [3, 2, 1]

	// 22. free() (unsafe)
	// Deallocates the array's buffer.
	mut a_free := [1, 2, 3]
	unsafe {
		a_free.free()
	}
	println('free: array freed')

	// 23. filter(it)
	// Filters elements that satisfy a predicate using compiler-defined `it` expression.
	a_filt := [1, 2, 3, 4]
	filtered := a_filt.filter(it % 2 == 0)
	println('filter: ${filtered}') // [2, 4]

	// 24. any(it)
	// Checks if any element satisfies the predicate.
	println('any: ${a_filt.any(it > 3)}') // true

	// 25. count(it)
	// Counts how many elements satisfy the predicate.
	println('count: ${a_filt.count(it % 2 == 0)}') // 2

	// 26. all(it)
	// Checks if all elements satisfy the predicate.
	println('all: ${a_filt.all(it > 0)}') // true

	// 27. map(it)
	// Maps elements to a new array using a transformation expression.
	mapped := a_filt.map(it * 10)
	println('map: ${mapped}') // [10, 20, 30, 40]

	// 28. sort() & sort(custom)
	// Sorts elements in-place. Uses optional boolean expression for custom order (uses magic vars a and b).
	mut a_sort := [3, 1, 4, 2]
	a_sort.sort()
	println('sort (default ascending): ${a_sort}') // [1, 2, 3, 4]
	a_sort.sort(a > b)
	println('sort (custom descending): ${a_sort}') // [4, 3, 2, 1]

	// 29. sorted() & sorted(custom)
	// Returns a sorted copy of the array. Uses optional boolean expression for custom order (uses magic vars a and b).
	a_sorted := [3, 1, 4, 2]
	println('sorted (default): ${a_sorted.sorted()}') // [1, 2, 3, 4]
	println('sorted (custom): ${a_sorted.sorted(a > b)}') // [4, 3, 2, 1]

	// 30. sort_with_compare(callback)
	// Sorts the array in-place using a custom comparison function.
	mut a_compare := [3, 1, 4, 2]
	a_compare.sort_with_compare(compare_ints)
	println('sort_with_compare: ${a_compare}') // [1, 2, 3, 4]

	// 31. sorted_with_compare(callback)
	// Returns a sorted copy of the array using a custom comparison function.
	a_sorted_comp := [3, 1, 4, 2]
	println('sorted_with_compare: ${a_sorted_comp.sorted_with_compare(compare_ints)}') // [1, 2, 3, 4]

	// 32. contains(value)
	// Checks if the array contains value.
	println('contains: ${a_filt.contains(3)}') // true

	// 33. index(value)
	// Returns the index of the first occurrence of value, or -1 if not found.
	println('index: ${a_filt.index(3)}') // 2

	// 34. last_index(value)
	// Returns the index of the last occurrence of value, or -1 if not found.
	a_dup := [1, 2, 3, 2]
	println('last_index: ${a_dup.last_index(2)}') // 3

	// 35. grow_cap(amount)
	// Increases the array capacity by the specified amount.
	mut a_grow := [1, 2]
	a_grow.grow_cap(10)
	println('grow_cap: cap is ${a_grow.cap >= 12}') // true

	// 36. grow_len(amount) (unsafe)
	// Increases the array length by the specified amount.
	unsafe {
		a_grow.grow_len(3)
	}
	println('grow_len: ${a_grow}') // [1, 2, 0, 0, 0]
	unsafe {
		a_grow.free()
	}

	// 37. pointers() (unsafe)
	// Returns an array of void pointers (pointers()) pointing to each element.
	a_ptrs := [10, 20]
	unsafe {
		ptrs := a_ptrs.pointers()
		println('pointers (first element): ${*(&int(ptrs[0]))}') // 10
		ptrs.free()
		a_ptrs.free()
	}
}
