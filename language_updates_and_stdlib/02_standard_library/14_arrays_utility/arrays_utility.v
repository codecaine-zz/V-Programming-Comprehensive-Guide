module main

import arrays

fn main() {
	println('=== arrays Utility Module Examples ===')

	nums := [5, 3, 9, 1, 7, 3]

	// Find min and max
	min_val := arrays.min(nums) or { 0 }
	max_val := arrays.max(nums) or { 0 }
	println('Array: ${nums}')
	println('Min:   ${min_val}') // 1
	println('Max:   ${max_val}') // 9

	// Find index of min/max
	min_idx := arrays.idx_min(nums) or { -1 }
	max_idx := arrays.idx_max(nums) or { -1 }
	println('Index of Min: ${min_idx}') // 3
	println('Index of Max: ${max_idx}') // 2

	// Chunking
	chunked := arrays.chunk(nums, 2)
	println('Chunked into sizes of 2: ${chunked}') // [[5, 3], [9, 1], [7, 3]]

	// Uniq (remove consecutive duplicates)
	consecutive_dups := [1, 1, 2, 2, 3, 1, 1]
	unique := arrays.uniq(consecutive_dups)
	println('Consecutive duplicates array: ${consecutive_dups}')
	println('After uniq():                 ${unique}') // [1, 2, 3, 1]
}
