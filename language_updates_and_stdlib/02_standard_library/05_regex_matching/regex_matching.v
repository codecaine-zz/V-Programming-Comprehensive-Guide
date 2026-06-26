module main

import regex

// replace_callback is used by replace_by_fn() to show how a match can be rewritten.
fn replace_callback(re regex.RE, in_txt string, start int, end int) string {
	return '[${start}-${end}]'
}

fn main() {
	// This sample text contains numbers and words that the regex API will inspect.
	text := 'We have 15 apples, 32 bananas, and 120 oranges.'

	// Compile a regex that finds one or more digits.
	mut re := regex.regex_opt(r'\d+') or {
		println('Failed to compile regex: ${err}')
		return
	}

	// Create another regex object and compile a word-matching pattern.
	mut re_from_new := regex.new()
	re_from_new.compile_opt(r'\w+') or {
		println('compile_opt() failed: ${err}')
		return
	}

	// regex_base() returns the compiled regex plus a status code and error message.
	base_re, base_code, base_err := regex.regex_base(r'\d+')
	println('regex_base(): ${base_code}, ${base_err}')
	println('regex_base query: ${base_re.get_query()}')

	println('=== regex module demo ===')
	println('query: ${re.get_query()}')

	// find() returns the first match position and span.
	start, end := re.find(text)
	if start >= 0 {
		matched := text[start..end]
		println('find(): "${matched}" at (${start}, ${end})')
	} else {
		println('find(): no match')
	}

	// The next calls demonstrate the other common regex helpers.
	println('find_from(): ${re.find_from(text, 10)}')
	println('find_all(): ${re.find_all(text)}')
	println('find_all_str(): ${re.find_all_str(text)}')
	println('match_string(): ${re.match_string(text)}')
	println('matches_string(): ${re.matches_string(text)}')
	println('replace(): ${re.replace(text, 'NUM')}')
	println('replace_n(): ${re.replace_n(text, 'NUM', 2)}')
	println('replace_simple(): ${re.replace_simple(text, 'NUM')}')
	println('replace_by_fn(): ${re.replace_by_fn(text, replace_callback)}')
	println('split(): ${re.split(text)}')
	println('get_group_list(): ${re.get_group_list()}')
	println('get_code(): ${re.get_code()}')
	println('get_group_by_id(): ${re.get_group_by_id(text, 0)}')
	println('get_group_by_name(): ${re.get_group_by_name(text, '')}')
	println('get_group_bounds_by_id(): ${re.get_group_bounds_by_id(0)}')
	println('get_group_bounds_by_name(): ${re.get_group_bounds_by_name('')}')
	println('match_base(): ${unsafe { re.match_base(text.str, text.len) }}')

	// reset() clears the regex state so we can reuse the object.
	re.reset()
	println('reset() query: ${re.get_query()}')
	println('new() compile_opt query: ${re_from_new.get_query()}')
}
