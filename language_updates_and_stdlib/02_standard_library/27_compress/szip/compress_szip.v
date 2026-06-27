module main

import os
import compress.szip

fn main() {
	println('=== compress.szip Module Demo ===')

	zip_filename := 'demo_archive.zip'
	dest_dir := 'extracted_demo'

	// Ensure cleanup of any temp files/folders
	defer {
		os.rm(zip_filename) or {}
		os.rmdir_all(dest_dir) or {}
		println('\nCleaned up archive and extraction folder.')
	}

	println('\n--- 1. Creating a Zip Archive ---')
	// Open a new zip archive for writing (creating it)
	mut archive := szip.open(zip_filename, .default_compression, .write) or {
		println('Failed to create zip: ${err}')
		return
	}

	// Add first file entry
	archive.open_entry('first_file.txt') or {
		println('Failed to open entry: ${err}')
		return
	}
	archive.write_entry('Hello from the first file inside our zip archive!'.bytes()) or {
		println('Failed to write entry: ${err}')
		return
	}
	archive.close_entry()

	// Add second file entry
	archive.open_entry('docs/second_file.txt') or {
		println('Failed to open entry: ${err}')
		return
	}
	archive.write_entry('This is a second file nested inside a docs directory.'.bytes()) or {
		println('Failed to write entry: ${err}')
		return
	}
	archive.close_entry()

	// Close the zip file
	archive.close()
	println('Successfully created zip archive "${zip_filename}" with 2 entries.')

	println('\n--- 2. Inspecting the Zip Archive ---')
	// Open zip file in read-only mode to inspect its contents
	mut reader := szip.open(zip_filename, .default_compression, .read_only) or {
		println('Failed to open zip for reading: ${err}')
		return
	}

	total_entries := reader.total() or { 0 }
	println('Total entries found in zip: ${total_entries}')

	// Inspect first entry details
	reader.open_entry_by_index(0) or {
		println('Failed to open entry 0: ${err}')
		return
	}
	name := reader.name()
	size := reader.size()
	crc := reader.crc32()
	println('Entry 0 details -> Name: "${name}", Size: ${size} bytes, CRC32: ${crc}')
	reader.close_entry()
	reader.close()

	println('\n--- 3. Extracting Zip Archive contents to Directory ---')
	os.mkdir(dest_dir) or {
		println('Failed to create destination directory: ${err}')
		return
	}

	// Extract the full archive to the target folder
	success := szip.extract_zip_to_dir(zip_filename, dest_dir) or {
		println('Extraction failed: ${err}')
		return
	}

	if success {
		println('Successfully extracted all entries to folder "${dest_dir}".')
		// Read and display content from extracted files
		file1_content := os.read_file(os.join_path(dest_dir, 'first_file.txt')) or { '' }
		file2_content := os.read_file(os.join_path(dest_dir, 'docs', 'second_file.txt')) or { '' }
		println('Extracted first_file.txt: "${file1_content}"')
		println('Extracted docs/second_file.txt: "${file2_content}"')
	} else {
		println('Extraction reported failure.')
	}
}
