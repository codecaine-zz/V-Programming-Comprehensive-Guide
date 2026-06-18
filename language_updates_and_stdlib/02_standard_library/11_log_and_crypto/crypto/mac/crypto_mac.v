module main

import crypto.hmac
import crypto.sha256

fn main() {
	println('=== V Message Authentication Codes (MAC) Demo ===')

	// --- 1. HMAC-SHA256 Signature Generation ---
	println('\n--- HMAC-SHA256 Signature ---')
	key := 'secret_signing_key'.bytes()
	message := 'This is a message to be authenticated using HMAC.'.bytes()

	// hmac.new(key, data, hash_func, blocksize)
	mac := hmac.new(key, message, sha256.sum, sha256.block_size)
	println('HMAC (Hex): ${mac.hex()}')

	// --- 2. HMAC Verification ---
	println('\n--- HMAC Verification ---')
	
	// Re-compute to verify
	computed_mac := hmac.new(key, message, sha256.sum, sha256.block_size)
	
	// hmac.equal performs constant-time comparison to prevent timing attacks
	is_valid := hmac.equal(mac, computed_mac)
	println('Signature matches? -> ${is_valid}')

	// Verify with a tampered message
	tampered_message := 'This is a message to be authenticated using HMAC!'.bytes()
	tampered_mac := hmac.new(key, tampered_message, sha256.sum, sha256.block_size)
	is_tampered_valid := hmac.equal(mac, tampered_mac)
	println('Tampered signature matches? -> ${is_tampered_valid}')
}
