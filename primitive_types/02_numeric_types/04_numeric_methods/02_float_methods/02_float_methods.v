module main

fn main() {
	f := 12345.6789

	// str() returns string representation of the float
	println(f.str()) // "12345.6789"

	// strg() returns string representation (often identical to str())
	println(f.strg()) // "12345.6789"

	// strlong() returns a full/long string representation of the float
	println(f.strlong()) // "12345.6789"

	// strsci(precision) returns scientific notation with specified precision/decimal places
	println(f.strsci(4)) // "1.2346e+04"

	// eq_epsilon(other) performs a comparison using machine epsilon (for near-equality)
	f2 := 12345.678900000001
	println(f.eq_epsilon(f2)) // true
}
