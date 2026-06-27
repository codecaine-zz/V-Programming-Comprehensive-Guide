module main

import os

fn main() {
	filename := 'temp_book_example.txt'
	content := 'V standard library makes OS operations very straightforward.'

	// ==========================================
	// 1. Basic File Operations (Writing, Reading, Existence)
	// ==========================================
	println('Writing text to ${filename}...')
	os.write_file(filename, content) or {
		println('Failed to write file: ${err}')
		return
	}

	// Checking file existence
	if os.exists(filename) {
		println('Confirmed: File exists.')
	}

	// Reading from a file
	read_content := os.read_file(filename) or {
		println('Failed to read file: ${err}')
		return
	}
	println('Read content from file: "${read_content}"')

	// Writing and reading lines
	lines := ['Line 1: V has simple OS functions.', 'Line 2: Supporting multiple lines.']
	lines_file := 'temp_lines_example.txt'
	os.write_lines(lines_file, lines) or { println('Failed to write lines: ${err}') }
	read_lines := os.read_lines(lines_file) or {
		println('Failed to read lines: ${err}')
		[]
	}
	println('Read lines: ${read_lines}')
	os.rm(lines_file) or {}

	// Listing directory contents
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

	// Reading environment variables
	home_dir := os.getenv('HOME')
	println('User HOME directory: ${home_dir}')

	// Checking if a binary exists in the system PATH
	if os.exists_in_system_path('git') {
		println('Confirmed: Git executable exists in system PATH.')
	}

	// Executing OS commands
	// os.execute runs command in a subshell and returns a Result struct containing exit_code and output.
	println('Running command "uname"...')
	res := os.execute('uname')
	if res.exit_code == 0 {
		println('Operating System: ${res.output.trim_space()}')
	} else {
		println('Command execution failed with code ${res.exit_code}: ${res.output}')
	}

	// ==========================================
	// 2. Directory Tree Operations (Nix/CLI Focus)
	// ==========================================
	println('\n--- Directory Tree Operations ---')

	// Create nested directories (like `mkdir -p`)
	nested_dir := os.join_path('temp_parent', 'temp_child')
	println('Creating nested directory structure: ${nested_dir}...')
	os.mkdir_all(nested_dir) or { println('Failed to create directory structure: ${err}') }

	// ==========================================
	// 3. Path Manipulation & Extraction
	// ==========================================
	println('\n--- Path Manipulation & Extraction ---')
	sample_path := '/usr/local/bin/v.exe'
	println('Sample path: ${sample_path}')
	println('Directory:   ${os.dir(sample_path)}') // /usr/local/bin
	println('Base name:   ${os.base(sample_path)}') // v.exe
	println('Extension:   ${os.file_ext(sample_path)}') // .exe

	// ==========================================
	// 4. Working Directory Traversal
	// ==========================================
	println('\n--- Working Directory Traversal ---')
	original_wd := os.getwd()
	println('Original working directory: ${original_wd}')

	println('Changing directory to: temp_parent...')
	os.chdir('temp_parent') or { println('Failed to change directory: ${err}') }
	println('New working directory: ${os.getwd()}')

	// Change back to original directory
	os.chdir(original_wd) or { println('Failed to restore directory: ${err}') }

	// ==========================================
	// 5. Advanced File Operations (Copying, Moving)
	// ==========================================
	println('\n--- Advanced File Actions ---')
	copied_file := 'temp_book_copy.txt'
	moved_file := 'temp_book_moved.txt'

	println('Copying ${filename} to ${copied_file}...')
	os.cp(filename, copied_file) or { println('Failed to copy file: ${err}') }

	println('Moving ${copied_file} to ${moved_file}...')
	os.mv(copied_file, moved_file) or { println('Failed to move file: ${err}') }

	// ==========================================
	// 6. Symbolic Links & Nix-Specific Operations
	// ==========================================
	println('\n--- Nix-Specific Operations ---')
	symlink_name := 'temp_book_link.txt'

	// Create symlink
	println('Creating symbolic link from ${moved_file} to ${symlink_name}...')
	os.symlink(moved_file, symlink_name) or { println('Failed to create symlink: ${err}') }

	// Check if path is a link
	if os.is_link(symlink_name) {
		println('Confirmed: ${symlink_name} is a symbolic link.')
	}

	// Change file permissions (chmod)
	// 0o644 = Owner: read/write, Group: read, Others: read
	println('Setting file permissions to 0o644 (read/write for owner, read-only for others)...')
	os.chmod(moved_file, 0o644) or { println('Failed to change permissions: ${err}') }

	// Check permissions
	println('Is readable?   ${os.is_readable(moved_file)}')
	println('Is writable?   ${os.is_writable(moved_file)}')
	println('Is executable? ${os.is_executable(moved_file)}')

	// Change ownership (chown)
	// Safe demo using our current user's UID and GID to avoid permission errors
	uid := os.getuid()
	gid := os.getgid()
	println('Setting ownership of ${moved_file} to UID: ${uid}, GID: ${gid}...')
	os.chown(moved_file, uid, gid) or { println('Failed to change ownership: ${err}') }

	// ==========================================
	// 7. Cleanup
	// ==========================================
	println('\n--- Cleanup ---')

	// Remove original file
	os.rm(filename) or { println('Failed to remove ${filename}: ${err}') }

	// Remove moved file
	os.rm(moved_file) or { println('Failed to remove ${moved_file}: ${err}') }

	// Remove symlink
	os.rm(symlink_name) or { println('Failed to remove symlink ${symlink_name}: ${err}') }

	// Remove nested directory structure recursively
	os.rmdir_all('temp_parent') or { println('Failed to remove temp_parent directory: ${err}') }

	println('Cleanup completed successfully.')
}
