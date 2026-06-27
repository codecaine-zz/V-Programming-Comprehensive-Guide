module main

import json
import os

struct Task {
	id    int
	title string
	done  bool
}

fn main() {
	file_path := 'tasks.json'

	// Create an array of objects
	tasks := [
		Task{
			id:    1
			title: 'Read V Guide'
			done:  false
		},
		Task{
			id:    2
			title: 'Write JSON helper examples'
			done:  true
		},
	]

	// 1. Encode array of objects to JSON string
	println('Encoding array of objects to JSON...')
	json_str := json.encode(tasks)
	println('JSON string:\n${json_str}')

	// 2. Write JSON string to file
	println('\nWriting JSON array to file "${file_path}"...')
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

	// 4. Decode JSON string back to an array of Task objects
	println('Decoding JSON back to array of objects...')
	decoded_tasks := json.decode([]Task, content) or {
		eprintln('Failed to decode JSON: ${err}')
		return
	}

	println('Decoded array of tasks successfully!')
	for task in decoded_tasks {
		println('  - Task #${task.id}: "${task.title}" [Done: ${task.done}]')
	}

	// Clean up created file
	os.rm(file_path) or {}
}
