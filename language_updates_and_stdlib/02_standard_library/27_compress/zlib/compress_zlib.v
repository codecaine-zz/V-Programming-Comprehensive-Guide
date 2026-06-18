module main

import compress.zlib

fn main() {
	println('=== compress.zlib Module Demo ===')

	// 1. Data to compress
	original_text := 'V programming language standard library zlib compression demo. Zlib uses the deflate algorithm with headers and checksum.'
	println('Original Text length: ${original_text.len} bytes')

	// 2. Compress the data using zlib.compress
	compressed_bytes := zlib.compress(original_text.bytes()) or {
		println('Compression failed: ${err}')
		return
	}
	println('Compressed size:      ${compressed_bytes.len} bytes')

	// 3. Decompress the data using zlib.decompress
	decompressed_bytes := zlib.decompress(compressed_bytes) or {
		println('Decompression failed: ${err}')
		return
	}
	println('Decompressed size:    ${decompressed_bytes.len} bytes')

	// 4. Verify the result
	decompressed_text := decompressed_bytes.bytestr()
	println('Decompressed text equals original? -> ${decompressed_text == original_text}')
	println('Decompressed Text: "${decompressed_text}"')
}
