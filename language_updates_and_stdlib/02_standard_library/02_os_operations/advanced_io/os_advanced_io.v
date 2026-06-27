module main

import os

struct Config {
mut:
	id   int
	val  f64
	name [20]u8 // fixed-size array of bytes for safe serialization
}

fn main() {
	println('=== V Advanced File I/O & Directory Walking ===')

	file_path := 'temp_advanced_io.bin'

	// --- 1. Struct Reading & Writing (Binary Serialization) ---
	println('\n--- 1. Struct Binary Serialization ---')

	// Create a mutable file in write/read mode
	mut f := os.open_file(file_path, 'w+') or {
		println('Failed to open file: ${err}')
		return
	}

	mut cfg := Config{
		id:   101
		val:  99.99
		name: [u8(0), 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]!
	}

	// Populate name
	name_str := 'V-OS-Advanced-IO'
	for i in 0 .. name_str.len {
		if i < 20 {
			cfg.name[i] = name_str[i]
		}
	}

	// Write struct representation directly to the file
	f.write_struct(cfg) or { println('Failed to write struct: ${err}') }
	println('Struct successfully serialized to file.')

	// --- 2. Seeking & Cursor Position (seek/tell) ---
	println('\n--- 2. File Seeking & Cursor Position ---')

	// Retrieve current position in the file (should be size of struct)
	pos := f.tell() or { 0 }
	println('Current file cursor position: ${pos} bytes')

	// Seek back to the beginning of the file (.start)
	println('Seeking back to the start of the file...')
	f.seek(0, .start) or { println('Failed to seek: ${err}') }

	// Read struct back from file
	mut read_cfg := Config{
		name: [u8(0), 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]!
	}
	f.read_struct(mut read_cfg) or { println('Failed to read struct: ${err}') }

	// Extract string from fixed-size byte array
	mut bytes := []u8{}
	for b in read_cfg.name {
		if b == 0 {
			break
		}
		bytes << b
	}
	name_read := bytes.bytestr()

	println('Deserialized Struct:')
	println('  ID:   ${read_cfg.id}')
	println('  Val:  ${read_cfg.val}')
	println('  Name: ${name_read}')

	f.close()

	// --- 3. Truncating Files ---
	println('\n--- 3. File Truncation (truncate) ---')

	// Note: V's os.truncate opens the file with O_TRUNC, resetting it first before sizing.
	// Shrinking/sizing a file directly using os.truncate:
	println('Truncating file "${file_path}" to 10 bytes...')
	os.truncate(file_path, 10) or { println('Failed to truncate: ${err}') }
	println('File size after truncation: ${os.file_size(file_path)} bytes')

	// Clean up binary file
	os.rm(file_path) or {}

	// --- 4. Recursive Directory Tree Walking ---
	println('\n--- 4. Directory Tree Walking (walk) ---')

	// Create a dummy tree for traversal
	walk_root := 'temp_walk_root'
	sub_dir := os.join_path(walk_root, 'docs')
	os.mkdir_all(sub_dir) or {}
	os.write_file(os.join_path(walk_root, 'file1.txt'), 'content1') or {}
	os.write_file(os.join_path(sub_dir, 'file2.log'), 'content2') or {}
	os.write_file(os.join_path(sub_dir, 'file3.txt'), 'content3') or {}

	// Recursive walk using a callback
	println('Recursive walk using os.walk (all files):')
	os.walk(walk_root, fn (path string) {
		println('  Found file: ${path}')
	})

	// Walk with file extension filter
	println('Walk with file extension filter using os.walk_ext (.txt only):')
	txt_files := os.walk_ext(walk_root, '.txt', os.WalkParams{})
	for path in txt_files {
		println('  Found .txt file: ${path}')
	}

	// Cleanup directory tree
	os.rmdir_all(walk_root) or {}
	println('Directory tree cleanup complete.')
}
