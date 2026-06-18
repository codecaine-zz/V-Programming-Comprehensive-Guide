module main

import io

// SimpleReader implements the io.Reader interface
struct SimpleReader {
	data string
mut:
	pos int
}

fn (mut sr SimpleReader) read(mut buf []u8) !int {
	if sr.pos >= sr.data.len {
		// Return io.Eof when the end of the stream is reached
		return io.Eof{}
	}
	mut bytes_read := 0
	for sr.pos < sr.data.len && bytes_read < buf.len {
		buf[bytes_read] = sr.data[sr.pos]
		sr.pos++
		bytes_read++
	}
	return bytes_read
}

// SimpleWriter implements the io.Writer interface
struct SimpleWriter {
mut:
	buf []u8
}

fn (mut sw SimpleWriter) write(buf []u8) !int {
	sw.buf << buf
	return buf.len
}

fn main() {
	println('=== io Module Demo ===')

	// 1. Initialize Reader and Writer
	mut reader := SimpleReader{
		data: 'Vlang standard library: io package demo.'
	}
	mut writer := SimpleWriter{}

	// 2. Use io.cp to copy data from Reader to Writer
	println('Copying data from custom Reader to custom Writer via io.cp...')
	io.cp(mut reader, mut writer) or {
		println('Error copying data: ${err}')
		return
	}

	// 3. Print the written data
	written_str := writer.buf.bytestr()
	println('Writer received: "${written_str}"')
}
