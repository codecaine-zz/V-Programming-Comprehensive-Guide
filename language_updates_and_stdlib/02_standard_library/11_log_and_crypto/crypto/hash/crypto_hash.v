module main

import crypto.md5
import crypto.sha1
import crypto.sha256
import crypto.sha512
import crypto.sha3
import crypto.ripemd160
import crypto.blake2b
import crypto.blake2s
import crypto.blake3

fn main() {
	println('=== V Cryptographic Hash Algorithms ===')

	input := 'V Language Crypto Guide'.bytes()
	input_str := 'V Language Crypto Guide'

	// 1. MD5 (128-bit)
	md5_hex := md5.hexhash(input_str)
	println('MD5:       ${md5_hex}')

	// 2. SHA-1 (160-bit)
	sha1_hex := sha1.hexhash(input_str)
	println('SHA-1:     ${sha1_hex}')

	// 3. SHA-256 (256-bit)
	sha256_hex := sha256.hexhash(input_str)
	println('SHA-256:   ${sha256_hex}')

	// 4. SHA-512 (512-bit)
	sha512_hex := sha512.hexhash(input_str)
	println('SHA-512:   ${sha512_hex}')

	// 5. SHA-3 (Keccak-based, 256 and 512 bit sums)
	sha3_256 := sha3.sum256(input)
	sha3_512 := sha3.sum512(input)
	println('SHA3-256:  ${sha3_256.hex()}')
	println('SHA3-512:  ${sha3_512.hex()}')

	// 6. RIPEMD-160 (160-bit)
	ripemd_hex := ripemd160.hexhash(input_str)
	println('RIPEMD160: ${ripemd_hex}')

	// 7. BLAKE2b (commonly 512-bit / 256-bit)
	blake2b_256 := blake2b.sum256(input)
	blake2b_512 := blake2b.sum512(input)
	println('BLAKE2b-256: ${blake2b_256.hex()}')
	println('BLAKE2b-512: ${blake2b_512.hex()}')

	// 8. BLAKE2s (commonly 256-bit)
	blake2s_256 := blake2s.sum256(input)
	println('BLAKE2s-256: ${blake2s_256.hex()}')

	// 9. BLAKE3 (256-bit, highly optimized)
	blake3_256 := blake3.sum256(input)
	println('BLAKE3-256:  ${blake3_256.hex()}')
}
