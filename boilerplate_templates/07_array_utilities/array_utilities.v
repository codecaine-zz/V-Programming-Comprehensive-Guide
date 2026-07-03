module main

import rand

// unique returns a new array with duplicate elements removed.
fn unique[T](arr []T) []T {
	mut result := []T{cap: arr.len}
	for item in arr {
		if item !in result {
			result << item
		}
	}
	return result
}

// chunk splits an array into sub-arrays of the specified size.
fn chunk[T](arr []T, size int) [][]T {
	if size <= 0 || arr.len == 0 {
		return [][]T{}
	}
	mut result := [][]T{}
	mut current_chunk := []T{}

	for item in arr {
		current_chunk << item
		if current_chunk.len == size {
			result << current_chunk
			current_chunk = []T{}
		}
	}
	if current_chunk.len > 0 {
		result << current_chunk
	}
	return result
}

// intersection returns a new array containing elements present in both arrays.
fn intersection[T](a []T, b []T) []T {
	mut result := []T{}
	for item in a {
		if item in b && item !in result {
			result << item
		}
	}
	return result
}

// difference returns a new array containing elements present in a but not in b.
fn difference[T](a []T, b []T) []T {
	mut result := []T{}
	for item in a {
		if item !in b && item !in result {
			result << item
		}
	}
	return result
}

// flatten flattens a 2D array into a 1D array.
fn flatten[T](arr [][]T) []T {
	mut result := []T{}
	for sub_arr in arr {
		for item in sub_arr {
			result << item
		}
	}
	return result
}

// shuffle randomizes the order of elements in-place using the Fisher-Yates algorithm.
fn shuffle[T](mut arr []T) {
	for i := arr.len - 1; i > 0; i-- {
		j := rand.intn(i + 1) or { 0 }
		temp := arr[i]
		arr[i] = arr[j]
		arr[j] = temp
	}
}

// weighted_choice returns an element from `values` based on their corresponding `weights`.
// The lengths of `values` and `weights` must be equal and non-zero.
// All weights must be non-negative.
fn weighted_choice[T](values []T, weights []int) !T {
	if values.len != weights.len {
		return error('values and weights must have the same length')
	}
	if values.len == 0 {
		return error('cannot pick from empty arrays')
	}

	mut total_weight := 0
	for w in weights {
		if w < 0 {
			return error('weights must be non-negative')
		}
		total_weight += w
	}

	if total_weight <= 0 {
		return error('sum of weights must be greater than zero')
	}

	// Pick a random number in [0, total_weight)
	r := rand.intn(total_weight) or { return error('failed to generate random number: ${err}') }

	mut running_sum := 0
	for i, w in weights {
		running_sum += w
		if r < running_sum {
			return values[i]
		}
	}

	return values[values.len - 1]
}

fn main() {
	println('=== V Custom Array Utilities Boilerplate ===')

	// 1. Unique / Deduplication Demo
	duplicates := [1, 2, 2, 3, 1, 4, 3, 5, 2]
	println('Original:    ${duplicates}')
	println('Deduplicated: ${unique(duplicates)}')

	// 2. Chunking Demo
	to_chunk := ['a', 'b', 'c', 'd', 'e', 'f', 'g']
	chunk_size := 3
	println('\nOriginal:    ${to_chunk}')
	println('Chunked (${chunk_size}): ${chunk[string](to_chunk, chunk_size)}')

	// 3. Intersection & Difference Demo
	arr_a := [1, 2, 3, 4, 5]
	arr_b := [4, 5, 6, 7, 8]
	println('\nArray A:     ${arr_a}')
	println('Array B:     ${arr_b}')
	println('Intersection: ${intersection(arr_a, arr_b)}')
	println('Difference:  ${difference(arr_a, arr_b)}')

	// 4. Flattening Demo
	nested := [[1, 2], [3, 4, 5], [6]]
	println('\nNested:      ${nested}')
	println('Flattened:   ${flatten(nested)}')

	// 5. In-place Shuffling Demo
	mut to_shuffle := [10, 20, 30, 40, 50, 60, 70]
	println('\nBefore Shuffle: ${to_shuffle}')
	shuffle(mut to_shuffle)
	println('After Shuffle:  ${to_shuffle}')

	// 6. Weighted Random Choice Demo (picking with bias)
	items := ['Common', 'Uncommon', 'Rare', 'Legendary']
	weights := [70, 20, 9, 1] // Sum is 100
	println('\nWeighted Choice Demo (picking with bias):')
	println('Items:   ${items}')
	println('Weights: ${weights}')

	// Simulate 10,000 picks to demonstrate that the distribution matches the weights
	mut stats := map[string]int{}
	for _ in 0 .. 10000 {
		picked := weighted_choice[string](items, weights) or {
			eprintln('Error: ${err}')
			continue
		}
		stats[picked]++
	}

	println('Simulation results (out of 10,000 picks):')
	for item in items {
		println('- ${item}: ${stats[item]} picks (~${(f64(stats[item]) / 100.0):.1f}%)')
	}
}
