module main

import os
import io.util

fn main() {
	println('=== io.util Module Demo ===')

	println('\n--- 1. Creating a Temporary File ---')
	// Create a temporary file. The '*' character in the pattern is replaced by a random number.
	// tfo.path defaults to the system temp directory if not specified.
	mut temp_file, temp_file_path := util.temp_file(pattern: 'v_guide_demo_*.txt') or {
		println('Failed to create temp file: ${err}')
		return
	}
	// Close the returned file handle immediately so we can open it with a clean write mode
	temp_file.close()

	defer {
		os.rm(temp_file_path) or {}
		println('Cleaned up temporary file: ${temp_file_path}')
	}
	println('Created temporary file at: ${temp_file_path}')

	// Reopen the temp file for writing explicitly
	mut f := os.open_file(temp_file_path, 'w') or {
		println('Failed to open temp file for writing: ${err}')
		return
	}

	// Write content into the temporary file
	f.write('This is some temporary data written to a temp file.'.bytes()) or {
		println('Failed to write to temp file: ${err}')
		f.close()
		return
	}
	f.close() // Close file to flush buffer and allow reading

	// Read content to verify
	content := os.read_file(temp_file_path) or {
		println('Failed to read temp file: ${err}')
		return
	}
	println('Temp file content: "${content}"')

	println('\n--- 2. Creating a Temporary Directory ---')
	// Create a temporary directory using a pattern
	temp_dir_path := util.temp_dir(pattern: 'v_guide_dir_*') or {
		println('Failed to create temp directory: ${err}')
		return
	}
	
	// Register cleanup on function exit
	defer {
		os.rmdir_all(temp_dir_path) or {}
		println('Cleaned up temporary directory: ${temp_dir_path}')
	}
	println('Created temporary directory at: ${temp_dir_path}')

	// Create a sub-file inside the temporary directory
	sub_file_path := os.join_path(temp_dir_path, 'sub_file.txt')
	os.write_file(sub_file_path, 'Data saved inside temporary directory.') or {
		println('Failed to create sub-file: ${err}')
		return
	}
	println('Created sub-file: ${sub_file_path}')

	// List files in the temporary directory to verify
	dir_files := os.ls(temp_dir_path) or {
		println('Failed to list temp directory: ${err}')
		return
	}
	println('Temporary directory contents: ${dir_files}')
}
