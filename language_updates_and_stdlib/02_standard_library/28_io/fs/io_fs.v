module main

import os
import io

fn main() {
	println('=== io & File System (os.File) Demo ===')

	src_path := 'temp_src_file.txt'
	dst_path := 'temp_dst_file.txt'

	// Ensure files are cleaned up on completion
	defer {
		os.rm(src_path) or {}
		os.rm(dst_path) or {}
		println('\nCleaned up temporary files.')
	}

	println('\n--- 1. Creating and Writing to File via io.Writer ---')
	// os.create returns an os.File struct, which implements the io.Writer interface.
	mut src_file := os.create(src_path) or {
		println('Failed to create file: ${err}')
		return
	}
	
	// Write data using the io.Writer write() method
	content_to_write := 'Hello! This is a file system demo.\nIt demonstrates how os.File integrates with the io module.\n'
	written_bytes := src_file.write(content_to_write.bytes()) or {
		println('Failed to write to file: ${err}')
		return
	}
	println('Wrote ${written_bytes} bytes to "${src_path}" using the io.Writer interface.')
	src_file.close()

	println('\n--- 2. Reading from File via io.BufferedReader ---')
	// os.open opens a file for reading, returning an os.File (which implements io.Reader).
	mut read_file := os.open(src_path) or {
		println('Failed to open file: ${err}')
		return
	}

	// Wrap os.File in io.BufferedReader for convenient line-by-line reading
	mut buf_reader := io.new_buffered_reader(reader: read_file)
	
	// Read lines until EOF
	for {
		line := buf_reader.read_line() or {
			break
		}
		println('Buffered Read Line: "${line}"')
	}
	read_file.close()

	println('\n--- 3. Copying File Contents using io.cp ---')
	// Re-open source file for reading (implements io.Reader)
	mut src_to_copy := os.open(src_path) or {
		println('Failed to open source file: ${err}')
		return
	}
	defer { src_to_copy.close() }

	// Create a new destination file for writing (implements io.Writer)
	mut dst_file := os.create(dst_path) or {
		println('Failed to create destination file: ${err}')
		return
	}
	defer { dst_file.close() }

	// Copy all contents from reader to writer using io.cp
	io.cp(mut src_to_copy, mut dst_file) or {
		println('Failed to copy file content: ${err}')
		return
	}
	// Explicitly close files so data is flushed and readable
	src_to_copy.close()
	dst_file.close()
	println('Copied content from "${src_path}" to "${dst_path}" via io.cp.')

	// Verify the destination file contents
	copied_content := os.read_file(dst_path) or {
		println('Failed to read destination file: ${err}')
		return
	}
	println('Copied File Contents:\n${copied_content.trim_space()}')
}
