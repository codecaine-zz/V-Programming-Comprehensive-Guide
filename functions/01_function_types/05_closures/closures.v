module main

fn new_counter() fn () int {
	mut count := 0
	// The closure inherits `count` by reference (read-write) using explicit list `[mut count]`
	return fn [mut count] () int {
		count++
		return count
	}
}

fn main() {
	counter := new_counter()
	println(counter()) // 1
	println(counter()) // 2
	println(counter()) // 3

	// An immutable capture closure
	factor := 10
	multiplier := fn [factor] (x int) int {
		return x * factor
	}
	println(multiplier(5)) // 50
}
