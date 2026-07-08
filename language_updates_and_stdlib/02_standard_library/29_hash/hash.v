module main

// The `hash` module provides FAST, NON-cryptographic hashes.
//
// When to use which:
// - fnv1a: quick fingerprints for hash tables, caches, and deduplication.
// - crc32: checksums to detect accidental corruption (downloads, storage).
// - NEITHER is safe for passwords or security — for that, use the
//   `crypto` modules (sha256, blake2, etc.) instead.
import hash.fnv1a
import hash.crc32

fn main() {
	println('=== hash Module Demo ===')

	input := 'V language standard library'
	println('Input string: "${input}"')

	// 1. FNV-1a hashing: the same input always yields the same number,
	//    and tiny input changes produce completely different hashes.
	//    32-bit is smaller/faster; 64-bit has far fewer collisions.
	fnv_32 := fnv1a.sum32_string(input)
	fnv_64 := fnv1a.sum64_string(input)
	println('FNV-1a 32-bit hash: ${fnv_32}')
	println('FNV-1a 64-bit hash: ${fnv_64}')

	// 2. CRC32 IEEE checksum — the classic integrity check used by
	//    zip/gzip. Note it works on bytes, hence input.bytes().
	crc_val := crc32.sum(input.bytes())
	println('CRC32 checksum:     ${crc_val}')
}
