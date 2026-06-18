module main

import compress.deflate

fn main() {
	println('=== compress.deflate Module Demo ===')

	// 1. Data to compress
	original_text := 'V programming language standard library deflate compression demo. Deflate is a lossless data compression algorithm.'
	println('Original Text length: ${original_text.len} bytes')

	// 2. Compress the data using deflate.compress
	compressed_bytes := deflate.compress(original_text.bytes()) or {
		println('Compression failed: ${err}')
		return
	}
	println('Compressed size:      ${compressed_bytes.len} bytes')

	// 3. Decompress the data using deflate.decompress
	decompressed_bytes := deflate.decompress(compressed_bytes) or {
		println('Decompression failed: ${err}')
		return
	}
	println('Decompressed size:    ${decompressed_bytes.len} bytes')

	// 4. Verify the result
	decompressed_text := decompressed_bytes.bytestr()
	println('Decompressed text equals original? -> ${decompressed_text == original_text}')
	println('Decompressed Text: "${decompressed_text}"')
}
