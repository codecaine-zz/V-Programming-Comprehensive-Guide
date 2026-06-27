module main

import crypto.bcrypt
import crypto.scrypt
import crypto.pbkdf2
import crypto.sha256

fn main() {
	println('=== V Key Derivation Functions Demo ===')

	// --- 1. Bcrypt ---
	println('\n--- Bcrypt ---')
	password := 'super_secure_password'.bytes()
	hash := bcrypt.generate_from_password(password, bcrypt.default_cost) or {
		println('Bcrypt failed: ${err}')
		return
	}
	println('Bcrypt hash: ${hash}')

	bcrypt.compare_hash_and_password(password, hash.bytes()) or {
		println('Bcrypt verification failed: ${err}')
		return
	}
	println('Bcrypt verification successful!')

	// --- 2. Scrypt ---
	println('\n--- Scrypt ---')
	scrypt_pass := 'my_scrypt_pass'.bytes()
	scrypt_salt := 'scrypt_salt'.bytes()

	// N=16384, r=8, p=1, key_len=32 (N must be power of 2)
	scrypt_key := scrypt.scrypt(scrypt_pass, scrypt_salt, 16384, 8, 1, 32) or {
		println('Scrypt failed: ${err}')
		return
	}
	println('Scrypt Key (Hex): ${scrypt_key.hex()}')

	// --- 3. PBKDF2 ---
	println('\n--- PBKDF2 ---')
	pbkdf2_pass := 'my_pbkdf2_pass'.bytes()
	pbkdf2_salt := 'pbkdf2_salt'.bytes()

	// pbkdf2.key(password, salt, iterations, key_len, hash_fn)
	pbkdf2_key := pbkdf2.key(pbkdf2_pass, pbkdf2_salt, 4096, 32, sha256.new()) or {
		println('PBKDF2 failed: ${err}')
		return
	}
	println('PBKDF2 Key (Hex): ${pbkdf2_key.hex()}')
}
