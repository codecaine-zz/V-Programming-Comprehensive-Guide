module main

import json
import os

struct Book {
	title  string
	author string
	year   int
}

fn main() {
	file_path := 'book.json'

	// Create an object instance
	book := Book{
		title:  'The V Programming Language'
		author: 'Alex Medvednikov'
		year:   2019
	}

	// 1. Encode object to JSON string
	println('Encoding object to JSON...')
	json_str := json.encode(book)
	println('JSON string: ${json_str}')

	// 2. Write JSON string to file
	println('Writing JSON to file "${file_path}"...')
	os.write_file(file_path, json_str) or {
		eprintln('Failed to write file: ${err}')
		return
	}

	// 3. Read JSON string from file
	println('Reading JSON from file "${file_path}"...')
	content := os.read_file(file_path) or {
		eprintln('Failed to read file: ${err}')
		return
	}

	// 4. Decode JSON string back to Book object
	println('Decoding JSON back to object...')
	decoded_book := json.decode(Book, content) or {
		eprintln('Failed to decode JSON: ${err}')
		return
	}

	println('Decoded book: Title: "${decoded_book.title}", Author: "${decoded_book.author}", Year: ${decoded_book.year}')

	// Clean up created file
	os.rm(file_path) or {}
}
