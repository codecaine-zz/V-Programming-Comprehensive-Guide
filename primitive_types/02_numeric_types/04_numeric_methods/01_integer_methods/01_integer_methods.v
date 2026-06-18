module main

fn main() {
	x := 42

	// str() returns string representation of the integer
	println(x.str()) // "42"

	// hex() returns hexadecimal representation without prefix
	println(x.hex()) // "2a"

	// hex2() returns hexadecimal representation with "0x" prefix
	println(x.hex2()) // "0x2a"

	// hex_full() returns hexadecimal representation with full width padding for the type (8 digits for 32-bit int)
	println(x.hex_full()) // "0000002a"
}
