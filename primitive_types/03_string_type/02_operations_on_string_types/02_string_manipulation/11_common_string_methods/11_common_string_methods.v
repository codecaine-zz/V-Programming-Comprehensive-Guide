module main

fn main() {
	s := '  Hello, V!  '

	// to_lower() returns the lowercase version of the string
	println(s.to_lower()) // "  hello, v!  "

	// to_upper() returns the uppercase version of the string
	println(s.to_upper()) // "  HELLO, V!  "

	// trim_space() trims leading and trailing whitespaces
	println(s.trim_space()) // "Hello, V!"

	// trim(cutset) trims leading and trailing characters that match any character in the cutset
	println(s.trim(' ')) // "Hello, V!"

	// replace(old, new) replaces all occurrences of old with new
	println(s.replace('V', 'World')) // "  Hello, World!  "

	// replace_once(old, new) replaces the first occurrence of old with new
	println(s.replace_once('l', 'x')) // "  Hexlo, V!  "

	// index(sub) returns the start index of the first occurrence of sub as an optional ?int
	idx := s.index('Hello') or { -1 }
	println(idx) // 2

	// last_index(sub) returns the start index of the last occurrence of sub as an optional ?int
	last_idx := s.last_index('l') or { -1 }
	println(last_idx) // 5

	// starts_with(prefix) checks if the string starts with the prefix
	println(s.starts_with('  ')) // true

	// ends_with(suffix) checks if the string ends with the suffix
	println(s.ends_with('!')) // false (ends with spaces)

	// is_pure_ascii() checks if all characters in the string are pure ASCII
	println(s.is_pure_ascii()) // true

	// split_into_lines() splits a string into an array of lines
	multiline := "line 1\nline 2"
	println(multiline.split_into_lines()) // ["line 1", "line 2"]

	// split_by_space() splits a string by space as delimiter
	println(s.split_by_space()) // ["Hello,", "V!"]
}
