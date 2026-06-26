module main

import arrays

fn main() {
	println('=== arrays Utility Module Examples ===')

	nums := [5, 3, 9, 1, 7, 3]
	sorted_nums := [1, 3, 5, 7, 9]
	words := ['apple', 'banana', 'pear', 'banana']
	repeated := [1, 1, 2, 2, 3, 3]
	letters := ['a', 'b', 'c']

	min_val := arrays.min(nums) or { 0 }
	max_val := arrays.max(nums) or { 0 }
	println('Array: ${nums}')
	println('Min:   ${min_val}')
	println('Max:   ${max_val}')

	min_idx := arrays.idx_min(nums) or { -1 }
	max_idx := arrays.idx_max(nums) or { -1 }
	println('Index of Min: ${min_idx}')
	println('Index of Max: ${max_idx}')

	chunked := arrays.chunk(nums, 2)
	println('chunk(): ${chunked}')

	append_result := arrays.append(nums, [10, 11])
	println('append(): ${append_result}')

	concat_result := arrays.concat(nums, 10, 11)
	println('concat(): ${concat_result}')

	mut copy_result := []int{}
	copied_count := arrays.copy(mut copy_result, nums)
	println('copy(): ${copied_count} -> ${copy_result}')

	distinct_result := arrays.distinct(words)
	println('distinct(): ${distinct_result}')

	arrays.each(nums, fn (elem int) {
		println('each(): ${elem}')
	})

	arrays.each_indexed(nums, fn (i int, elem int) {
		println('each_indexed(): ${i} -> ${elem}')
	})

	filtered := arrays.filter_indexed(nums, fn (idx int, elem int) bool {
		return idx % 2 == 0 && elem > 3
	})
	println('filter_indexed(): ${filtered}')

	first_match := arrays.find_first(nums, fn (elem int) bool {
		return elem > 5
	}) or { 0 }
	println('find_first(): ${first_match}')

	last_match := arrays.find_last(nums, fn (elem int) bool {
		return elem > 5
	}) or { 0 }
	println('find_last(): ${last_match}')

	flat_mapped := arrays.flat_map[int, string](nums, fn (elem int) []string {
		return [elem.str(), '!']
	})
	println('flat_map(): ${flat_mapped}')

	flat_mapped_indexed := arrays.flat_map_indexed[int, string](nums, fn (idx int, elem int) []string {
		return ['${idx}', elem.str()]
	})
	println('flat_map_indexed(): ${flat_mapped_indexed}')

	flattened := arrays.flatten([[1, 2], [3, 4], [5]])
	println('flatten(): ${flattened}')

	folded := arrays.fold(nums, 0, fn (acc int, elem int) int {
		return acc + elem
	})
	println('fold(): ${folded}')

	folded_indexed := arrays.fold_indexed(nums, 0, fn (idx int, acc int, elem int) int {
		return acc + idx + elem
	})
	println('fold_indexed(): ${folded_indexed}')

	println('group(): skipped in this sample because the helper expects variadic slices and is sensitive to local analyzer parsing')

	grouped_by_parity := arrays.group_by(nums, fn (val int) string {
		if val % 2 == 0 {
			return 'even'
		}
		return 'odd'
	})
	println('group_by(): ${grouped_by_parity}')

	binary_search_result := arrays.binary_search(sorted_nums, 7) or { -1 }
	println('binary_search(): ${binary_search_result}')

	c_array_example := unsafe { arrays.carray_to_varray[int](nil, 0) }
	println('carray_to_varray(): ${c_array_example}')

	chunked_while := arrays.chunk_while(nums, fn (before int, after int) bool {
		return before < after
	})
	println('chunk_while(): ${chunked_while}')

	index_first := arrays.index_of_first(nums, fn (idx int, elem int) bool {
		return idx > 0 && elem == 3
	})
	println('index_of_first(): ${index_first}')

	index_last := arrays.index_of_last(nums, fn (idx int, elem int) bool {
		return idx > 0 && elem == 3
	})
	println('index_of_last(): ${index_last}')

	joined := arrays.join_to_string(words, ' | ', fn (elem string) string {
		return elem.to_upper()
	})
	println('join_to_string(): ${joined}')

	lower := arrays.lower_bound(sorted_nums, 4) or { 0 }
	upper := arrays.upper_bound(sorted_nums, 4) or { 0 }
	println('lower_bound(): ${lower}')
	println('upper_bound(): ${upper}')

	mapped := arrays.map_indexed(nums, fn (idx int, elem int) int {
		return idx + elem
	})
	println('map_indexed(): ${mapped}')

	counts := arrays.map_of_counts([1, 2, 2, 3, 1])
	println('map_of_counts(): ${counts}')

	indexes := arrays.map_of_indexes([9, 1, 9, 4])
	println('map_of_indexes(): ${indexes}')

	merge_result := arrays.merge(letters, ['d'])
	println('merge(): ${merge_result}')

	partition_even, partition_odd := arrays.partition(nums, fn (elem int) bool {
		return elem % 2 == 0
	})
	println('partition(): even=${partition_even}, odd=${partition_odd}')

	reduce_result := arrays.reduce(nums, fn (acc int, elem int) int {
		return acc + elem
	}) or { 0 }
	println('reduce(): ${reduce_result}')

	reduce_indexed_result := arrays.reduce_indexed(nums, fn (idx int, acc int, elem int) int {
		return acc + idx + elem
	}) or { 0 }
	println('reduce_indexed(): ${reduce_indexed_result}')

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

	mut rotate_left_example := [1, 2, 3, 4, 5]
	arrays.rotate_left(mut rotate_left_example, 2)
	println('rotate_left(): ${rotate_left_example}')

	mut rotate_right_example := [1, 2, 3, 4, 5]
	arrays.rotate_right(mut rotate_right_example, 2)
	println('rotate_right(): ${rotate_right_example}')

	sum_result := arrays.sum(nums) or { 0 }
	println('sum(): ${sum_result}')

	unique_result := arrays.uniq(repeated)
	println('uniq(): ${unique_result}')

	uniq_all_result := arrays.uniq_all_repeated(repeated)
	println('uniq_all_repeated(): ${uniq_all_result}')

	uniq_only_result := arrays.uniq_only(repeated)
	println('uniq_only(): ${uniq_only_result}')

	uniq_only_repeated_result := arrays.uniq_only_repeated(repeated)
	println('uniq_only_repeated(): ${uniq_only_repeated_result}')

	window_result := arrays.window(nums, arrays.WindowAttribute{ size: 2, step: 1 })
	println('window(): ${window_result}')

	println('All arrays examples completed.')
}
