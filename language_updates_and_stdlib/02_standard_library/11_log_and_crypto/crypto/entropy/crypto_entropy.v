module main

import crypto.rand
import math.big

fn main() {
	println('=== V Secure Randomness (Entropy) Demo ===')

	// --- 1. Generating Secure Random Bytes ---
	println('\n--- Secure Random Bytes ---')
	// Generates securely generated random bytes from the OS entropy pool
	random_bytes := rand.bytes(16) or {
		println('Failed to generate secure bytes: ${err}')
		return
	}
	println('Generated 16 secure bytes (Hex): ${random_bytes.hex()}')

	// --- 2. Generating Secure Random u64 ---
	println('\n--- Secure Random u64 ---')
	// Generates a random u64 in the range [0, max)
	limit_u64 := u64(10_000)
	random_val := rand.int_u64(limit_u64) or {
		println('Failed to generate random u64: ${err}')
		return
	}
	println('Secure random u64 in [0, ${limit_u64}): ${random_val}')

	// --- 3. Generating Secure Random Big Integer ---
	println('\n--- Secure Random big.Integer ---')
	// Generates a random big.Integer in the range [0, limit)
	limit_str := '10000000000000000000000000000000000000000' // 10^40
	limit_big := big.integer_from_string(limit_str) or {
		println('Failed to parse big integer string: ${err}')
		return
	}

	random_big := rand.int_big(limit_big) or {
		println('Failed to generate random big integer: ${err}')
		return
	}
	println('Secure random big.Integer in [0, 10^40):')
	println(random_big.str())
}
