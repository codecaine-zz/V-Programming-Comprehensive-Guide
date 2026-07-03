module main

// reverse_string reverses a string, properly handling multi-byte UTF-8 characters (runes).
fn reverse_string(s string) string {
	runes := s.runes()
	mut rev_runes := []rune{cap: runes.len}
	for i := runes.len - 1; i >= 0; i-- {
		rev_runes << runes[i]
	}
	return rev_runes.string()
}

// title_case capitalizes the first letter of each word in a string.
fn title_case(s string) string {
	words := s.split(' ')
	mut titled_words := []string{cap: words.len}
	for word in words {
		if word.len == 0 {
			titled_words << ''
			continue
		}
		titled_words << word.capitalize()
	}
	return titled_words.join(' ')
}

// is_palindrome checks if a string reads the same forwards and backwards,
// ignoring case and non-alphanumeric characters.
fn is_palindrome(s string) bool {
	// Filter to lowercase alphanumeric characters
	mut clean_chars := []rune{}
	for r in s.to_lower().runes() {
		if (r >= `a` && r <= `z`) || (r >= `0` && r <= `9`) {
			clean_chars << r
		}
	}

	for i in 0 .. clean_chars.len / 2 {
		if clean_chars[i] != clean_chars[clean_chars.len - 1 - i] {
			return false
		}
	}
	return true
}

// truncate cuts off a string at a specified limit (by rune count) and appends an ellipsis.
fn truncate(s string, limit int) string {
	runes := s.runes()
	if runes.len <= limit {
		return s
	}
	return runes[0..limit].string() + '...'
}

// slugify converts a string into a clean, URL-friendly slug.
fn slugify(s string) string {
	mut res := []rune{}
	mut last_was_dash := false

	for r in s.to_lower().runes() {
		if (r >= `a` && r <= `z`) || (r >= `0` && r <= `9`) {
			res << r
			last_was_dash = false
		} else if r == ` ` || r == `-` || r == `_` {
			if !last_was_dash && res.len > 0 {
				res << `-`
				last_was_dash = true
			}
		}
	}

	// Trim trailing dash if any
	mut slug := res.string()
	if slug.ends_with('-') {
		slug = slug[0..slug.len - 1]
	}
	return slug
}

fn main() {
	println('=== V Custom String Utilities Boilerplate ===')

	// 1. Reverse String (UTF-8 safe)
	phrase := 'Hello, 🚀 World!'
	println('Original:  "${phrase}"')
	println('Reversed:  "${reverse_string(phrase)}"')

	// 2. Title Case (capitalizing every word)
	title := 'v programming language complete textbook guide'
	println('\nOriginal:  "${title}"')
	println('Title Case: "${title_case(title)}"')

	// 3. Palindrome Check
	pal1 := 'A man, a plan, a canal: Panama!'
	pal2 := 'Hello Vlang'
	println('\nIs "${pal1}" a palindrome? ${is_palindrome(pal1)}')
	println('Is "${pal2}" a palindrome? ${is_palindrome(pal2)}')

	// 4. Truncation
	long_text := 'V is a statically typed compiled programming language designed for building maintainable software.'
	println('\nOriginal:  "${long_text}"')
	println('Truncated: "${truncate(long_text, 35)}"')

	// 5. Slugify
	title_to_slug := '  Vlang: Concurrency, Channels, & Web APIs!  '
	println('\nOriginal:  "${title_to_slug}"')
	println('Slugified: "${slugify(title_to_slug)}"')
}
