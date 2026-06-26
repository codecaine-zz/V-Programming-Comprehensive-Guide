module main

fn main() {
	mut nums := [1, 3, 2, 5, 4]
	
	// Sort descending using a lambda expression
	nums.sort(|a, b| b < a)
	println('Sorted: ${nums}') // [5, 4, 3, 2, 1]

	// Map using lambda to multiply by 10
	doubled := nums.map(|x| x * 10)
	println('Doubled: ${doubled}') // [50, 40, 30, 20, 10]

	// Filter using lambda to keep only elements > 20
	filtered := doubled.filter(|x| x > 20)
	println('Filtered (>20): ${filtered}') // [50, 40, 30]
}
