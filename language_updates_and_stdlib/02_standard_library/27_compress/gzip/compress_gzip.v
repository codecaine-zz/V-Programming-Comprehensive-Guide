module main

import compress.gzip

fn main() {
	println('=== compress.gzip Module Demo ===')

	// 1. Original text data
	original_text := 'V programming language standard library gzip compression and decompression demonstration. This string is long enough to show compression.'
	println('Original Text length: ${original_text.len} bytes')

	// 2. Compress the data
	compressed_bytes := gzip.compress(original_text.bytes()) or {
		println('Compression failed: ${err}')
		return
	}
	println('Compressed size:      ${compressed_bytes.len} bytes')

	// 3. Decompress the data
	decompressed_bytes := gzip.decompress(compressed_bytes) or {
		println('Decompression failed: ${err}')
		return
	}
	println('Decompressed size:    ${decompressed_bytes.len} bytes')

	// 4. Convert back to string and verify
	decompressed_text := decompressed_bytes.bytestr()
	println('Decompressed text equals original? -> ${decompressed_text == original_text}')
	println('Decompressed Text: "${decompressed_text}"')
}
