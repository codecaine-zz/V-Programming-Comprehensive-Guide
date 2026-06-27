module main

import json
import os

fn main() {
	// We will show two ways of writing/reading arrays to/from files:
	// Method 1: Using JSON serialization (great for numeric or structured arrays)
	// Method 2: Using raw text line-by-line reading/writing (great for string lists)

	// --- Method 1: JSON Serialization ---
	println('=== Method 1: JSON Serialization ===')
	json_file_path := 'numbers.json'
	numbers := [10, 20, 30, 40, 50]

	println('Encoding array to JSON...')
	json_str := json.encode(numbers)
	println('JSON string: ${json_str}')

	println('Writing JSON to file "${json_file_path}"...')
	os.write_file(json_file_path, json_str) or {
		eprintln('Failed to write file: ${err}')
		return
	}

	json_content := os.read_file(json_file_path) or {
		eprintln('Failed to read file: ${err}')
		return
	}

	decoded_numbers := json.decode([]int, json_content) or {
		eprintln('Failed to decode array JSON: ${err}')
		return
	}
	println('Decoded array: ${decoded_numbers}')
	os.rm(json_file_path) or {}

	// --- Method 2: Raw Line-by-Line (Plain Text) ---
	println('\n=== Method 2: Raw Line-by-Line ===')
	text_file_path := 'fruits.txt'
	fruits := ['Apple', 'Banana', 'Cherry', 'Date']

	println('Writing array elements to text file "${text_file_path}"...')
	// Join the string array with newlines to write line-by-line
	fruits_content := fruits.join('\n')
	os.write_file(text_file_path, fruits_content) or {
		eprintln('Failed to write file: ${err}')
		return
	}

	println('Reading lines from file "${text_file_path}" using os.read_lines()...')
	// os.read_lines reads a file directly into a []string (line by line)
	read_fruits := os.read_lines(text_file_path) or {
		eprintln('Failed to read lines: ${err}')
		return
	}
	println('Read string array: ${read_fruits}')

	// Clean up created files
	os.rm(text_file_path) or {}
}
