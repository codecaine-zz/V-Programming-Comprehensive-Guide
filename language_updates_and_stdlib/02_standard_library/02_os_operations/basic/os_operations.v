module main

import os

fn main() {
	filename := 'temp_book_example.txt'
	content := 'V standard library makes OS operations very straightforward.'

	// ==========================================
	// 1. Basic File Operations (Writing, Reading, Existence)
	// ==========================================

	// os.write_file writes a string to a file. It overwrites the file if it already exists.
	// We handle errors using V's explicit "or" block.
	println('Writing text to ${filename}...')
	os.write_file(filename, content) or {
		println('Failed to write file: ${err}')
		return
	}

	// os.exists checks if a file or directory exists at the given path.
	if os.exists(filename) {
		println('Confirmed: File exists.')
	}

	// os.read_file reads the entire content of a file and returns it as a string.
	read_content := os.read_file(filename) or {
		println('Failed to read file: ${err}')
		return
	}
	println('Read content from file: "${read_content}"')

	// os.write_lines writes an array of strings to a file, separating them with newlines.
	lines := ['Line 1: V has simple OS functions.', 'Line 2: Supporting multiple lines.']
	lines_file := 'temp_lines_example.txt'
	os.write_lines(lines_file, lines) or { println('Failed to write lines: ${err}') }

	// os.read_lines reads a file line-by-line and returns an array of strings.
	read_lines := os.read_lines(lines_file) or {
		println('Failed to read lines: ${err}')
		[]
	}
	println('Read lines: ${read_lines}')
	os.rm(lines_file) or {}

	// os.write_bytes and os.read_bytes handle raw binary byte arrays.
	// os.file_last_mod_unix retrieves the Unix timestamp of when the file was last modified.
	// os.is_file returns true if the path points to a file (not a directory).
	bytes_file := 'temp_bytes_example.bin'
	os.write_bytes(bytes_file, 'V handles raw bytes.'.bytes()) or {
		println('Failed to write bytes: ${err}')
	}
	read_bytes := os.read_bytes(bytes_file) or { []u8{} }
	println('Read bytes: "${read_bytes.bytestr()}"')
	println('Last modified time (epoch): ${os.file_last_mod_unix(bytes_file)}')
	println('Is a file? ${os.is_file(bytes_file)}')
	os.rm(bytes_file) or {}

	// os.create creates a new empty file for writing and returns a File handle.
	// os.open_append opens an existing file or creates one, positioning the cursor at the end to append data.
	// os.open opens an existing file in read-only mode.
	handle_file := 'temp_handle_example.txt'
	mut f_create := os.create(handle_file) or { panic(err) }
	f_create.write_string('Line 1 from file handle\n') or {}
	f_create.close()

	mut f_append := os.open_append(handle_file) or { panic(err) }
	f_append.write_string('Line 2 appended\n') or {}
	f_append.close()

	mut f_read := os.open(handle_file) or { panic(err) }
	mut buf := []u8{len: 100}
	n_read := f_read.read(mut buf) or { 0 }
	println('Content via file handle:\n${buf[..n_read].bytestr().trim_space()}')
	f_read.close()
	os.rm(handle_file) or {}

	// os.ls returns a list of file and directory names inside the target directory path.
	println('Listing files in current directory:')
	files := os.ls('.') or {
		println('Failed to list directory: ${err}')
		[]
	}
	for file in files {
		if file == filename {
			println('- Found file: ${file}')
		}
	}

	// os.getenv retrieves the value of a system environment variable.
	home_dir := os.getenv('HOME')
	println('User HOME directory: ${home_dir}')

	// os.exists_in_system_path checks if a command binary is present in the system's PATH.
	if os.exists_in_system_path('git') {
		println('Confirmed: Git executable exists in system PATH.')
	}

	// os.execute runs a system command in a shell and returns a Result struct.
	// The Result contains both the command exit_code and stdout/stderr output.
	println('Running command "uname"...')
	res := os.execute('uname')
	if res.exit_code == 0 {
		println('Operating System: ${res.output.trim_space()}')
	} else {
		println('Command execution failed with code ${res.exit_code}: ${res.output}')
	}

	// ==========================================
	// 2. Directory Tree Operations
	// ==========================================
	println('\n--- Directory Tree Operations ---')

	// os.mkdir_all recursively creates a full nested directory path (similar to mkdir -p).
	nested_dir := os.join_path('temp_parent', 'temp_child')
	println('Creating nested directory structure: ${nested_dir}...')
	os.mkdir_all(nested_dir) or { println('Failed to create directory structure: ${err}') }

	// os.mkdir creates a single new directory.
	// os.is_dir checks if a path points to a directory.
	// os.is_dir_empty checks if the directory has no files or subfolders.
	// os.rmdir deletes a single empty directory.
	single_dir := 'temp_single_dir'
	os.mkdir(single_dir) or { println('Failed to create directory: ${err}') }
	println('Is directory? ${os.is_dir(single_dir)}')
	println('Is empty?     ${os.is_dir_empty(single_dir)}')
	os.rmdir(single_dir) or { println('Failed to remove directory: ${err}') }

	// ==========================================
	// 3. Path Manipulation & Extraction
	// ==========================================
	println('\n--- Path Manipulation & Extraction ---')
	sample_path := '/usr/local/bin/v.exe'

	// Path parsing helpers:
	// os.dir returns the parent directory.
	// os.base returns the last element of the path.
	// os.file_ext returns the file suffix including dot.
	// os.file_name returns the filename without the path.
	// os.is_abs_path checks if the path starts with root.
	// os.real_path resolves symlinks and relative references to return the absolute canonical path.
	// os.norm_path cleans up and normalizes path separators.
	// os.split_path splits a path into (dir, file_name, file_extension).
	println('Sample path: ${sample_path}')
	println('Directory:   ${os.dir(sample_path)}')
	println('Base name:   ${os.base(sample_path)}')
	println('Extension:   ${os.file_ext(sample_path)}')
	println('File name:   ${os.file_name(sample_path)}')
	println('Is absolute? ${os.is_abs_path(sample_path)}')
	println('Real path:   ${os.real_path('.')}')
	println('Norm path:   ${os.norm_path('/usr/local/../bin/v')}')
	p_dir, p_file, p_ext := os.split_path(sample_path)
	println('Split path -> dir: ${p_dir}, file: ${p_file}, ext: ${p_ext}')

	// ==========================================
	// 4. Working Directory Traversal
	// ==========================================
	println('\n--- Working Directory Traversal ---')

	// os.getwd returns the current active working directory.
	// os.chdir changes the current active working directory.
	original_wd := os.getwd()
	println('Original working directory: ${original_wd}')

	println('Changing directory to: temp_parent...')
	os.chdir('temp_parent') or { println('Failed to change directory: ${err}') }
	println('New working directory: ${os.getwd()}')

	// Restore original working directory
	os.chdir(original_wd) or { println('Failed to restore directory: ${err}') }

	// ==========================================
	// 5. Advanced File Operations (Copying, Moving)
	// ==========================================
	println('\n--- Advanced File Actions ---')
	copied_file := 'temp_book_copy.txt'
	moved_file := 'temp_book_moved.txt'

	// os.cp copies a file from source to destination.
	println('Copying ${filename} to ${copied_file}...')
	os.cp(filename, copied_file) or { println('Failed to copy file: ${err}') }

	// os.mv moves or renames a file.
	println('Moving ${copied_file} to ${moved_file}...')
	os.mv(copied_file, moved_file) or { println('Failed to move file: ${err}') }

	// ==========================================
	// 6. Symbolic Links & Nix-Specific Operations
	// ==========================================
	println('\n--- Nix-Specific Operations ---')
	symlink_name := 'temp_book_link.txt'

	// os.symlink creates a symbolic link pointing to a target file.
	// os.is_link checks if the path points to a symbolic link.
	println('Creating symbolic link from ${moved_file} to ${symlink_name}...')
	os.symlink(moved_file, symlink_name) or { println('Failed to create symlink: ${err}') }

	if os.is_link(symlink_name) {
		println('Confirmed: ${symlink_name} is a symbolic link.')
	}

	// os.chmod changes permission bits on a file (using octal representation).
	// os.is_readable, os.is_writable, os.is_executable check specific accessibility bits.
	println('Setting file permissions to 0o644 (read/write for owner, read-only for others)...')
	os.chmod(moved_file, 0o644) or { println('Failed to change permissions: ${err}') }

	println('Is readable?   ${os.is_readable(moved_file)}')
	println('Is writable?   ${os.is_writable(moved_file)}')
	println('Is executable? ${os.is_executable(moved_file)}')

	// os.getuid and os.getgid get current user and group IDs.
	// os.chown changes the user and group owner IDs on a file.
	uid := os.getuid()
	gid := os.getgid()
	println('Setting ownership of ${moved_file} to UID: ${uid}, GID: ${gid}...')
	os.chown(moved_file, uid, gid) or { println('Failed to change ownership: ${err}') }

	// ==========================================
	// 7. File Globbing (glob)
	// ==========================================
	println('\n--- File Globbing ---')

	// os.glob finds all files matching a wildcard pattern (e.g. *.txt).
	os.write_file('glob_test_1.txt', '1') or {}
	os.write_file('glob_test_2.txt', '2') or {}
	globbed_files := os.glob('glob_test_*.txt') or { [] }
	println('Glob results: ${globbed_files}')
	os.rm('glob_test_1.txt') or {}
	os.rm('glob_test_2.txt') or {}

	// ==========================================
	// 8. Cleanup
	// ==========================================
	println('\n--- Cleanup ---')

	// os.rm deletes a file.
	// os.rmdir_all recursively removes a directory and all of its contents.
	os.rm(filename) or { println('Failed to remove ${filename}: ${err}') }
	os.rm(moved_file) or { println('Failed to remove ${moved_file}: ${err}') }
	os.rm(symlink_name) or { println('Failed to remove symlink ${symlink_name}: ${err}') }
	os.rmdir_all('temp_parent') or { println('Failed to remove temp_parent directory: ${err}') }

	println('Cleanup completed successfully.')
}
