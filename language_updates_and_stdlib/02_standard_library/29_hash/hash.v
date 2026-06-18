module main

import hash.fnv1a
import hash.crc32

fn main() {
	println('=== hash Module Demo ===')

	input := 'V language standard library'
	println('Input string: "${input}"')

	// 1. FNV-1a 32-bit and 64-bit string hashing
	fnv_32 := fnv1a.sum32_string(input)
	fnv_64 := fnv1a.sum64_string(input)
	println('FNV-1a 32-bit hash: ${fnv_32}')
	println('FNV-1a 64-bit hash: ${fnv_64}')

	// 2. CRC32 IEEE checksum
	crc_val := crc32.sum(input.bytes())
	println('CRC32 checksum:     ${crc_val}')
}
