module main

import json
import os

fn main() {
	file_path := 'scores.json'

	// Create a map[string]int
	scores := {
		'Alice':   95
		'Bob':     88
		'Charlie': 92
	}

	// 1. Encode map to JSON string
	println('Encoding map to JSON...')
	json_str := json.encode(scores)
	println('JSON string: ${json_str}')

	// 2. Write JSON string to file
	println('Writing map JSON to file "${file_path}"...')
	os.write_file(file_path, json_str) or {
		eprintln('Failed to write file: ${err}')
		return
	}

	// 3. Read JSON string from file
	println('Reading from file "${file_path}"...')
	content := os.read_file(file_path) or {
		eprintln('Failed to read file: ${err}')
		return
	}

	// 4. Decode JSON string back to map[string]int
	println('Decoding JSON back to map...')
	decoded_scores := json.decode(map[string]int, content) or {
		eprintln('Failed to decode map JSON: ${err}')
		return
	}

	println('Decoded map successfully:')
	for k, v in decoded_scores {
		println('  - ${k}: ${v}')
	}

	// Clean up created file
	os.rm(file_path) or {}
}
