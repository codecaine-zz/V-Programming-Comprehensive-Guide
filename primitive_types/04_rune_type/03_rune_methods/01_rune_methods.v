module main

fn main() {
	r := `A`

	// bytes() returns the byte representation (UTF-8 bytes) of the rune
	println(r.bytes()) // [65]

	// hex() returns the hexadecimal representation of the rune code point
	println(r.hex()) // "41"

	// length_in_bytes() returns the size of the rune in bytes (1 to 4)
	println(r.length_in_bytes()) // 1

	// repeat(count) returns a string with the rune repeated count times
	println(r.repeat(3)) // "AAA"

	// str() returns the string representation of the rune
	println(r.str()) // "A"

	// to_lower() returns the lowercase rune
	println(r.to_lower().str()) // "a"

	// to_upper() returns the uppercase rune
	println(r.to_upper().str()) // "A"

	// to_title() returns the titlecase rune
	println(r.to_title().str()) // "A"

	// Testing with a multi-byte UTF-8 rune (dog emoji 🐕)
	r2 := `🐕`
	println(r2.bytes()) // [240, 159, 144, 149]
	println(r2.hex()) // "1f415" (Unicode code point in hex)
	println(r2.length_in_bytes()) // 4
	println(r2.repeat(2)) // "🐕🐕"
	println(r2.str()) // "🐕"
}
