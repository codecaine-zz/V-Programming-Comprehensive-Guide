module main

fn main() {
	a := 'Camel'

	// Method 1: Using the substr(start, end) method
	// Extracts characters from index 0 up to (but not including) index 3
	b := a.substr(0, 3)
	println(b) // Output: Cam

	// Method 2: Using idiomatic range slicing syntax [start..end] (similar to Go/Rust)
	// Slices from index 1 up to (but not including) index 4
	c := a[1..4]
	println(c) // Output: ame

	// Method 3: Slicing from start to index [..end]
	// If the start index is omitted, it defaults to 0
	d := a[..3]
	println(d) // Output: Cam

	// Method 4: Slicing from index to end [start..]
	// If the end index is omitted, it defaults to the string length
	e := a[2..]
	println(e) // Output: mel
}
