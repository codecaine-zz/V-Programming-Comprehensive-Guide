module main

import os

fn main() {
	println('=== V OS & File Utilities Boilerplate ===')

	// 1. Join paths safely across different operating systems using os.join_path
	// V's home_dir() gives the user's home directory. Let's use it as a base path inside a temporary subfolder in workspace.
	cwd := os.getwd()
	temp_dir := os.join_path(cwd, 'temp_file_demo')
	println('Target directory: ${temp_dir}')

	// 2. Check if a directory exists, and create it recursively if not
	if !os.exists(temp_dir) {
		println('Directory does not exist. Creating...')
		os.mkdir_all(temp_dir) or {
			eprintln('Failed to create directory: ${err}')
			exit(1)
		}
	}

	target_file := os.join_path(temp_dir, 'sample.txt')
	println('Target file path: ${target_file}')

	// 3. Write data to a file (overwrites if it already exists)
	content_to_write := 'Hello V Developers!\nThis is a sample file created by the OS and File utilities boilerplate.'
	os.write_file(target_file, content_to_write) or {
		eprintln('Failed to write to file: ${err}')
		exit(1)
	}
	println('File written successfully.')

	// 4. Read data from a file back into memory
	read_content := os.read_file(target_file) or {
		eprintln('Failed to read file: ${err}')
		exit(1)
	}
	println('\n--- Read Content ---')
	println(read_content)
	println('--------------------\n')

	// 5. Query file metadata
	size := os.file_size(target_file)
	is_file := os.is_file(target_file)
	is_dir := os.is_dir(temp_dir)
	println('File properties:')
	println('- Size: ${size} bytes')
	println('- Is File: ${is_file}')
	println('- Is Directory: ${is_dir}')

	// 6. List all files and folders inside a directory
	println('\nListing contents of directory: ${temp_dir}')
	files := os.ls(temp_dir) or { []string{} }
	for file in files {
		full_path := os.join_path(temp_dir, file)
		file_type := if os.is_dir(full_path) { '[DIR]' } else { '[FILE]' }
		println('  ${file_type} ${file}')
	}

	// 7. Clean up by deleting the file and directory
	println('\nCleaning up temporary files and directories...')
	os.rm(target_file) or { eprintln('Failed to delete file: ${err}') }
	os.rmdir(temp_dir) or { eprintln('Failed to delete directory: ${err}') }
	println('Cleanup completed successfully.')
}
