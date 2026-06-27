module main

import net.urllib

fn main() {
	println('=== net.urllib Module Demo ===')

	// 1. Parsing a URL
	raw_url := 'https://user:pass@vlang.io:8080/docs/stdlib?lang=v&version=0.5.1#intro'
	println('Parsing URL: ${raw_url}')

	u := urllib.parse(raw_url) or {
		println('Failed to parse URL: ${err}')
		return
	}

	println('Parsed URL parts:')
	println('  Scheme:   ${u.scheme}')
	println('  Host:     ${u.host}')
	println('  Path:     ${u.path}')
	println('  Query:    ${u.raw_query}')
	println('  Fragment: ${u.fragment}')

	// 2. Query escaping and unescaping
	original_query := 'V compiler version 0.5.1 & details'
	escaped := urllib.query_escape(original_query)
	unescaped := urllib.query_unescape(escaped) or { 'failed' }

	println('\nQuery Escaping:')
	println('  Original:  ${original_query}')
	println('  Escaped:   ${escaped}')
	println('  Unescaped: ${unescaped}')

	// 3. Managing Query Parameters using urllib.Values
	println('\nManaging Query Values:')
	mut query_params := urllib.new_values()
	query_params.add('format', 'json')
	query_params.add('tags', 'programming')
	query_params.add('tags', 'tutorial')
	query_params.set('version', '0.5.1')

	// Encode to raw query string
	encoded_query := query_params.encode()
	println('  Encoded query string: ${encoded_query}')

	// Parse it back
	parsed_params := urllib.parse_query(encoded_query) or { urllib.new_values() }
	println('  Parsed format tag:    ${parsed_params.get('format') or { 'none' }}')
	println('  Parsed tags:          ${parsed_params.get_all('tags')}')
}
