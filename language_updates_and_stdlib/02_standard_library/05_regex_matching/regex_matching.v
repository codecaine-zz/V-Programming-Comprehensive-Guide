module main

import regex

fn main() {
	// 1. Compile a regex pattern
	// r'...' specifies a raw string literal, avoiding excessive escaping
	mut re := regex.regex_opt(r'\d+') or {
		println('Failed to compile regex: ${err}')
		return
	}

	text := 'We have 15 apples, 32 bananas, and 120 oranges.'

	// 2. Find the first match in the text
	// `find()` searches anywhere in the string and returns (start_index, end_index)
	start, end := re.find(text)
	if start >= 0 {
		matched := text[start..end]
		println('First match found: "${matched}" at range (${start}, ${end})')
	} else {
		println('No match found.')
	}

	// 3. Find all matches in the text
	// `find_all_str()` returns an array of all matching substrings
	all_matches := re.find_all_str(text)
	println('All matches: ${all_matches}')

	// 4. Replace matches in the text
	// `replace()` replaces all occurrences matching the regex pattern
	replaced := re.replace(text, 'NUM')
	println('Replaced text: "${replaced}"')
}
