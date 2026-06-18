module main

import compress.zstd

fn main() {
	println('=== compress.zstd Module Demo ===')

	// 1. Check version details
	version := zstd.version_string()
	println('ZSTD Library Version: ${version}')

	// 2. Data to compress
	original_text := 'Zstd, short for Zstandard, is a fast lossless compression algorithm developed by Facebook. It offers high compression ratios.'
	println('\nOriginal Text length: ${original_text.len} bytes')

	// 3. Compress using zstd.compress (specifying standard parameters)
	compressed_bytes := zstd.compress(original_text.bytes(), compression_level: 3) or {
		println('Compression failed: ${err}')
		return
	}
	println('Compressed size:      ${compressed_bytes.len} bytes')

	// 4. Decompress using zstd.decompress
	decompressed_bytes := zstd.decompress(compressed_bytes) or {
		println('Decompression failed: ${err}')
		return
	}
	println('Decompressed size:    ${decompressed_bytes.len} bytes')

	// 5. Verify and display result
	decompressed_text := decompressed_bytes.bytestr()
	println('Decompressed text equals original? -> ${decompressed_text == original_text}')
	println('Decompressed Text: "${decompressed_text}"')
}
