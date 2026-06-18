module main

import archive.tar
import os

// CustomReader implements the tar.Reader interface
struct CustomReader {
pub mut:
	files_found int
}

fn (mut cr CustomReader) dir_block(mut read tar.Read, size u64) {
	println('Directory in tar: ${read.get_path()}')
}

fn (mut cr CustomReader) file_block(mut read tar.Read, size u64) {
	println('File in tar:      ${read.get_path()} (${size} bytes)')
	cr.files_found++
}

fn (mut cr CustomReader) data_block(mut read tar.Read, data []u8, pending int) {
	// Trim content bytes to display them cleanly
	content := data.bytestr().trim_space()
	println('  Content snippet: "${content}"')
}

fn (mut cr CustomReader) other_block(mut read tar.Read, details string) {
	// Ignore details for this demo
}

fn main() {
	println('=== archive.tar Module Demo ===')

	// 1. Create a dummy file to archive
	temp_file := 'temp_file_for_tar.txt'
	os.write_file(temp_file, 'Hello standard archive tar from Vlang!') or {
		println('Failed to write temp file: ${err}')
		return
	}
	defer {
		os.rm(temp_file) or {}
	}

	// 2. Create the tar.gz archive using system tar
	tar_archive := 'temp_archive.tar.gz'
	println('Creating tar archive using system tar...')
	tar_cmd := if os.user_os() == 'macos' { 'COPYFILE_DISABLE=1 tar -czf' } else { 'tar -czf' }
	os.execute('${tar_cmd} ${tar_archive} ${temp_file}')
	defer {
		os.rm(tar_archive) or {}
	}

	// 3. Read and parse the tar.gz archive using V's archive.tar module
	println('Reading archive using vlib/archive/tar:')
	mut reader := CustomReader{}
	
	// Read and parse
	tar.read_tar_gz_file(tar_archive, reader) or {
		println('Failed to read tar archive: ${err}')
		return
	}

	println('Total files found in archive: ${reader.files_found}')
}
