module main

import math

// Stats holds the computed statistical properties of a dataset.
struct Stats {
	count    int
	min      f64
	max      f64
	sum      f64
	mean     f64
	median   f64
	variance f64
	std_dev  f64
}

// calculate_stats calculates standard descriptive statistics on a float dataset (not built into V arrays).
fn calculate_stats(numbers []f64) ?Stats {
	if numbers.len == 0 {
		return none
	}

	mut sum := 0.0
	mut min := numbers[0]
	mut max := numbers[0]

	for val in numbers {
		sum += val
		if val < min {
			min = val
		}
		if val > max {
			max = val
		}
	}

	mean := sum / numbers.len

	// Calculate median (requires a sorted copy of the numbers)
	mut sorted := numbers.clone()
	sorted.sort()

	mut median := 0.0
	mid := sorted.len / 2
	if sorted.len % 2 == 0 {
		median = (sorted[mid - 1] + sorted[mid]) / 2.0
	} else {
		median = sorted[mid]
	}

	// Calculate variance and standard deviation
	mut variance_sum := 0.0
	for val in numbers {
		diff := val - mean
		variance_sum += diff * diff
	}
	variance := variance_sum / numbers.len
	std_dev := math.sqrt(variance)

	return Stats{
		count:    numbers.len
		min:      min
		max:      max
		sum:      sum
		mean:     mean
		median:   median
		variance: variance
		std_dev:  std_dev
	}
}

// factorial calculates the factorial of a number iteratively, with overflow checks.
fn factorial(n int) !u64 {
	if n < 0 {
		return error('Factorial is not defined for negative numbers')
	}
	if n > 20 {
		return error('Factorial of ${n} overflows 64-bit unsigned integer limit (max n is 20)')
	}
	mut result := u64(1)
	for i in 2 .. n + 1 {
		result *= u64(i)
	}
	return result
}

// fibonacci generates the first n Fibonacci numbers, with overflow checks.
fn fibonacci(n int) ![]u64 {
	if n < 0 {
		return error('Count must be non-negative')
	}
	if n > 93 {
		return error('Fibonacci sequence beyond 93 elements overflows 64-bit unsigned integer limit')
	}
	if n == 0 {
		return []u64{}
	}
	if n == 1 {
		return [u64(0)]
	}
	mut sequence := []u64{cap: n}
	sequence << u64(0)
	sequence << u64(1)
	for i in 2 .. n {
		sequence << sequence[i - 1] + sequence[i - 2]
	}
	return sequence
}

// is_prime checks if a number is prime.
fn is_prime(n int) bool {
	if n <= 1 {
		return false
	}
	if n <= 3 {
		return true
	}
	if n % 2 == 0 || n % 3 == 0 {
		return false
	}
	mut i := 5
	for i * i <= n {
		if n % i == 0 || n % (i + 2) == 0 {
			return false
		}
		i += 6
	}
	return true
}

// gcd computes the Greatest Common Divisor of two integers.
fn gcd(a int, b int) int {
	mut x := math.abs(a)
	mut y := math.abs(b)
	for y != 0 {
		temp := y
		y = x % y
		x = temp
	}
	return x
}

// lcm computes the Least Common Multiple of two integers.
fn lcm(a int, b int) int {
	if a == 0 || b == 0 {
		return 0
	}
	return (math.abs(a) * math.abs(b)) / gcd(a, b)
}

fn main() {
	println('=== V Custom Math & Statistics Boilerplate ===')

	// 1. Descriptive Statistics Demo
	data := [72.5, 81.0, 68.5, 90.0, 75.5, 78.0, 85.5]
	println('Dataset: ${data}')

	stats := calculate_stats(data) or {
		println('Error: Empty dataset')
		return
	}

	println('\nStatistical Results:')
	println('- Count:              ${stats.count}')
	println('- Minimum:            ${stats.min:.2f}')
	println('- Maximum:            ${stats.max:.2f}')
	println('- Sum:                ${stats.sum:.2f}')
	println('- Mean (Average):     ${stats.mean:.2f}')
	println('- Median:             ${stats.median:.2f}')
	println('- Variance:           ${stats.variance:.2f}')
	println('- Standard Deviation: ${stats.std_dev:.2f}')

	// 2. Custom Math Functions Demo
	n := 10
	println('\nCustom Number Functions:')

	fact := factorial(n) or {
		eprintln('Error: ${err}')
		u64(0)
	}
	println('- Factorial of ${n}:    ${fact}')

	fib := fibonacci(n) or {
		eprintln('Error: ${err}')
		[]u64{}
	}
	println('- Fibonacci first ${n}: ${fib}')

	test_primes := [7, 12, 19, 25, 97]
	for p in test_primes {
		println('  Is ${p} prime?       ${is_prime(p)}')
	}

	a, b := 24, 36
	println('\nCommon Number Relations:')
	println('- GCD of ${a} and ${b}:    ${gcd(a, b)}')
	println('- LCM of ${a} and ${b}:    ${lcm(a, b)}')
}
