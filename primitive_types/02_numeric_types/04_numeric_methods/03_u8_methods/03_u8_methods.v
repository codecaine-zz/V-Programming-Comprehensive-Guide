module main

fn main() {
	b := u8(65) // ASCII code for 'A'

	// str() returns string representation of the numeric value
	println(b.str()) // "65"

	// ascii_str() returns string of length 1 containing the character
	println(b.ascii_str()) // "A"

	// hex() returns hexadecimal representation
	println(b.hex()) // "41"

	// hex_full() returns hexadecimal representation (same as hex() for u8)
	println(b.hex_full()) // "41"

	// is_alnum() checks if the character is alphanumeric
	println(b.is_alnum()) // true

	// is_bin_digit() checks if the character is a binary digit ('0' or '1')
	println(b.is_bin_digit()) // false

	// is_capital() checks if the character is an uppercase letter
	println(b.is_capital()) // true

	// is_digit() checks if the character is a decimal digit ('0'-'9')
	println(b.is_digit()) // false

	// is_hex_digit() checks if the character is a hexadecimal digit ('0'-'9', 'a'-'f', 'A'-'F')
	println(b.is_hex_digit()) // true

	// is_letter() checks if the character is an alphabetic letter
	println(b.is_letter()) // true

	// is_oct_digit() checks if the character is an octal digit ('0'-'7')
	println(b.is_oct_digit()) // false

	// is_space() checks if the character is a whitespace character
	println(b.is_space()) // false

	// repeat(count) repeats the character count times and returns a string
	println(b.repeat(3)) // "AAA"

	// str_escaped() returns an escaped string representation of the character
	println(b.str_escaped()) // "A"
}
