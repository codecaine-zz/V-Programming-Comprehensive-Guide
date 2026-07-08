module main

// The `arrays` module supplies ready-made algorithms for arrays that go
// beyond the built-in .map()/.filter()/.sort() methods: min/max, chunking,
// folding, grouping, searching sorted data, and de-duplication.
//
// Beginner tips:
// - These are plain functions: call arrays.min(arr), not arr.min().
// - Many return a Result/Option (they can fail on an empty array), so you
//   will see `or { fallback }` after the call to supply a default.
// - None of these helpers modify the input array unless they take `mut`.
import arrays

fn main() {
	println('=== arrays Utility Module Examples ===')

	// Sample data reused throughout the examples below.
	nums := [5, 3, 9, 1, 7, 3]
	sorted_nums := [1, 3, 5, 7, 9] // binary search helpers need sorted input
	words := ['apple', 'banana', 'pear', 'banana']
	repeated := [1, 1, 2, 2, 3, 3]
	letters := ['a', 'b', 'c']

	// --- Finding extremes ---
	// min()/max() fail on an empty array, hence the `or { 0 }` fallback.
	min_val := arrays.min(nums) or { 0 }
	max_val := arrays.max(nums) or { 0 }
	println('Array: ${nums}')
	println('Min:   ${min_val}')
	println('Max:   ${max_val}')

	// idx_min()/idx_max() return the POSITION of the extreme, not the value.
	min_idx := arrays.idx_min(nums) or { -1 }
	max_idx := arrays.idx_max(nums) or { -1 }
	println('Index of Min: ${min_idx}')
	println('Index of Max: ${max_idx}')

	// --- Reshaping and combining arrays ---
	// chunk(): split into sub-arrays of (at most) the given size.
	chunked := arrays.chunk(nums, 2)
	println('chunk(): ${chunked}')

	// append(): join two arrays into a new one.
	append_result := arrays.append(nums, [10, 11])
	println('append(): ${append_result}')

	// concat(): join an array with individual extra values.
	concat_result := arrays.concat(nums, 10, 11)
	println('concat(): ${concat_result}')

	// copy(): copy elements into an existing (mut) destination array.
	mut copy_result := []int{}
	copied_count := arrays.copy(mut copy_result, nums)
	println('copy(): ${copied_count} -> ${copy_result}')

	// distinct(): remove duplicates anywhere in the array.
	distinct_result := arrays.distinct(words)
	println('distinct(): ${distinct_result}')

	// --- Iterating with callbacks ---
	// each(): run a function for every element (no return value).
	arrays.each(nums, fn (elem int) {
		println('each(): ${elem}')
	})

	// each_indexed(): same, but the callback also receives the index.
	arrays.each_indexed(nums, fn (i int, elem int) {
		println('each_indexed(): ${i} -> ${elem}')
	})

	// --- Filtering and searching ---
	// filter_indexed(): like .filter(), but the predicate can use the index.
	filtered := arrays.filter_indexed(nums, fn (idx int, elem int) bool {
		return idx % 2 == 0 && elem > 3
	})
	println('filter_indexed(): ${filtered}')

	// find_first()/find_last(): the first/last VALUE matching a predicate.
	first_match := arrays.find_first(nums, fn (elem int) bool {
		return elem > 5
	}) or { 0 }
	println('find_first(): ${first_match}')

	last_match := arrays.find_last(nums, fn (elem int) bool {
		return elem > 5
	}) or { 0 }
	println('find_last(): ${last_match}')

	// --- Mapping and flattening ---
	// flat_map(): map each element to a LIST, then flatten all lists into one.
	flat_mapped := arrays.flat_map[int, string](nums, fn (elem int) []string {
		return [elem.str(), '!']
	})
	println('flat_map(): ${flat_mapped}')

	flat_mapped_indexed := arrays.flat_map_indexed[int, string](nums, fn (idx int, elem int) []string {
		return ['${idx}', elem.str()]
	})
	println('flat_map_indexed(): ${flat_mapped_indexed}')

	// flatten(): turn an array of arrays into one flat array.
	flattened := arrays.flatten([[1, 2], [3, 4], [5]])
	println('flatten(): ${flattened}')

	// --- Reducing to a single value ---
	// fold(): combine all elements into one value, starting from an
	// initial accumulator (0 here). This computes the sum of nums.
	folded := arrays.fold(nums, 0, fn (acc int, elem int) int {
		return acc + elem
	})
	println('fold(): ${folded}')

	folded_indexed := arrays.fold_indexed(nums, 0, fn (idx int, acc int, elem int) int {
		return acc + idx + elem
	})
	println('fold_indexed(): ${folded_indexed}')

	println('group(): skipped in this sample because the helper expects variadic slices and is sensitive to local analyzer parsing')

	// --- Grouping ---
	// group_by(): bucket elements into a map keyed by the callback's result.
	grouped_by_parity := arrays.group_by(nums, fn (val int) string {
		if val % 2 == 0 {
			return 'even'
		}
		return 'odd'
	})
	println('group_by(): ${grouped_by_parity}')

	// --- Searching sorted arrays ---
	// binary_search(): fast O(log n) lookup — the array MUST be sorted.
	binary_search_result := arrays.binary_search(sorted_nums, 7) or { -1 }
	println('binary_search(): ${binary_search_result}')

	// carray_to_varray(): converts a raw C array pointer into a V array;
	// mainly for C interop, shown here with a nil pointer for illustration.
	c_array_example := unsafe { arrays.carray_to_varray[int](nil, 0) }
	println('carray_to_varray(): ${c_array_example}')

	// chunk_while(): start a new chunk whenever the predicate breaks.
	// Here consecutive ascending values stay in the same chunk.
	chunked_while := arrays.chunk_while(nums, fn (before int, after int) bool {
		return before < after
	})
	println('chunk_while(): ${chunked_while}')

	// index_of_first()/index_of_last(): like find_first/find_last, but
	// return the POSITION instead of the value (-1 when not found).
	index_first := arrays.index_of_first(nums, fn (idx int, elem int) bool {
		return idx > 0 && elem == 3
	})
	println('index_of_first(): ${index_first}')

	index_last := arrays.index_of_last(nums, fn (idx int, elem int) bool {
		return idx > 0 && elem == 3
	})
	println('index_of_last(): ${index_last}')

	// join_to_string(): transform each element, then join with a separator.
	joined := arrays.join_to_string(words, ' | ', fn (elem string) string {
		return elem.to_upper()
	})
	println('join_to_string(): ${joined}')

	// lower_bound(): smallest element >= the target (in a sorted array).
	// upper_bound(): largest element <= the target.
	lower := arrays.lower_bound(sorted_nums, 4) or { 0 }
	upper := arrays.upper_bound(sorted_nums, 4) or { 0 }
	println('lower_bound(): ${lower}')
	println('upper_bound(): ${upper}')

	// map_indexed(): like .map(), but the callback also sees the index.
	mapped := arrays.map_indexed(nums, fn (idx int, elem int) int {
		return idx + elem
	})
	println('map_indexed(): ${mapped}')

	// map_of_counts(): how many times each value appears.
	counts := arrays.map_of_counts([1, 2, 2, 3, 1])
	println('map_of_counts(): ${counts}')

	// map_of_indexes(): at which positions each value appears.
	indexes := arrays.map_of_indexes([9, 1, 9, 4])
	println('map_of_indexes(): ${indexes}')

	// merge(): combine two SORTED arrays, keeping the result sorted.
	merge_result := arrays.merge(letters, ['d'])
	println('merge(): ${merge_result}')

	// partition(): split into two arrays — matching and non-matching.
	partition_even, partition_odd := arrays.partition(nums, fn (elem int) bool {
		return elem % 2 == 0
	})
	println('partition(): even=${partition_even}, odd=${partition_odd}')

	// reduce(): like fold(), but uses the first element as the starting
	// accumulator instead of a provided initial value.
	reduce_result := arrays.reduce(nums, fn (acc int, elem int) int {
		return acc + elem
	}) or { 0 }
	println('reduce(): ${reduce_result}')

	reduce_indexed_result := arrays.reduce_indexed(nums, fn (idx int, acc int, elem int) int {
		return acc + idx + elem
	}) or { 0 }
	println('reduce_indexed(): ${reduce_indexed_result}')

	// --- Iterators and in-place rotation ---
	// reverse_iterator(): walk the array backwards without copying it.
	mut reverse_iter := arrays.reverse_iterator(nums)
	println('reverse_iterator():')
	for {
		if value := reverse_iter.next() {
			println('  ${*value}')
		} else {
			break
		}
	}
	reverse_iter.free()

	// rotate_left()/rotate_right(): shift elements around IN PLACE
	// (these are the only helpers here that modify their input).
	mut rotate_left_example := [1, 2, 3, 4, 5]
	arrays.rotate_left(mut rotate_left_example, 2)
	println('rotate_left(): ${rotate_left_example}')

	mut rotate_right_example := [1, 2, 3, 4, 5]
	arrays.rotate_right(mut rotate_right_example, 2)
	println('rotate_right(): ${rotate_right_example}')

	// --- Sums and de-duplication ---
	sum_result := arrays.sum(nums) or { 0 }
	println('sum(): ${sum_result}')

	// The uniq family works on CONSECUTIVE duplicates (sort first if needed):
	// uniq():               collapse runs of duplicates to one ([1,2,3])
	unique_result := arrays.uniq(repeated)
	println('uniq(): ${unique_result}')

	// uniq_all_repeated(): keep ALL copies of values that repeat
	uniq_all_result := arrays.uniq_all_repeated(repeated)
	println('uniq_all_repeated(): ${uniq_all_result}')

	// uniq_only():          keep only values that appear exactly once
	uniq_only_result := arrays.uniq_only(repeated)
	println('uniq_only(): ${uniq_only_result}')

	// uniq_only_repeated(): one copy of each value that repeats
	uniq_only_repeated_result := arrays.uniq_only_repeated(repeated)
	println('uniq_only_repeated(): ${uniq_only_repeated_result}')

	// window(): sliding windows of a given size, advancing by `step`.
	window_result := arrays.window(nums, arrays.WindowAttribute{ size: 2, step: 1 })
	println('window(): ${window_result}')

	println('All arrays examples completed.')
}
