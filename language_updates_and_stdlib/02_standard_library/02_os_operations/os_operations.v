module main

import os

fn main() {
	filename := 'temp_book_example.txt'
	content := 'V standard library makes OS operations very straightforward.'

	// 1. Writing to a file
	println('Writing text to ${filename}...')
	os.write_file(filename, content) or {
		println('Failed to write file: ${err}')
		return
	}

	// 2. Checking file existence
	if os.exists(filename) {
		println('Confirmed: File exists.')
	}

	// 3. Reading from a file
	read_content := os.read_file(filename) or {
		println('Failed to read file: ${err}')
		return
	}
	println('Read content from file: "${read_content}"')

	// 4. Listing directory contents
	println('Listing files in current directory:')
	files := os.ls('.') or {
		println('Failed to list directory: ${err}')
		[]
	}
	for file in files {
		// Filter and print temp file
		if file == filename {
			println('- Found file: ${file}')
		}
	}

	// 5. Reading environment variables
	home_dir := os.getenv('HOME')
	println('User HOME directory: ${home_dir}')

	// 6. Executing OS commands
	// os.execute runs command in a subshell and returns a Result struct containing exit_code and output.
	println('Running command "uname"...')
	res := os.execute('uname')
	if res.exit_code == 0 {
		println('Operating System: ${res.output.trim_space()}')
	} else {
		println('Command execution failed with code ${res.exit_code}: ${res.output}')
	}

	// 7. Deleting a file
	println('Removing temporary file...')
	os.rm(filename) or {
		println('Failed to remove file: ${err}')
		return
	}
	println('File removed successfully.')
}
