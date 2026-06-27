module main

import crypto.aes
import crypto.des
import crypto.blowfish
import crypto.rc4
import crypto.cipher

fn main() {
	println('=== V Symmetric Cryptography Demo ===')

	// --- 1. AES with CBC Block Mode ---
	println('\n--- AES (CBC Mode) ---')
	aes_key := [u8(1), 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16] // 16-byte key (AES-128)
	aes_iv := [u8(9), 8, 7, 6, 5, 4, 3, 2, 1, 0, 9, 8, 7, 6, 5, 4] // 16-byte IV

	aes_block := aes.new_cipher(aes_key)
	mut aes_enc := cipher.new_cbc(aes_block, aes_iv)

	// In CBC mode, data must be padded to block size (16 bytes for AES)
	plaintext := 'Hello, V Cryptography! Padding here.'.bytes() // 36 bytes. We need to pad it to 48 bytes (multiple of 16)
	mut padded := plaintext.clone()
	pad_len := 16 - (padded.len % 16)
	for _ in 0 .. pad_len {
		padded << u8(pad_len)
	}

	mut ciphertext := []u8{len: padded.len}
	aes_enc.encrypt_blocks(mut ciphertext, padded)
	println('Ciphertext (Hex): ${ciphertext.hex()}')

	// Decrypt
	mut aes_dec := cipher.new_cbc(aes_block, aes_iv)
	mut decrypted := []u8{len: ciphertext.len}
	aes_dec.decrypt_blocks(mut decrypted, ciphertext)

	// Unpad
	unpadded_len := decrypted.len - int(decrypted.last())
	unpadded_text := decrypted[..unpadded_len].bytestr()
	println('Decrypted Text:   "${unpadded_text}"')

	// --- 2. DES Block Cipher ---
	println('\n--- DES ---')
	des_key := [u8(1), 2, 3, 4, 5, 6, 7, 8] // 8-byte key
	des_block := des.new_cipher(des_key)

	des_plain := 'DESplain'.bytes() // exactly 8 bytes (DES block size)
	mut des_cipher := []u8{len: 8}
	des_block.encrypt(mut des_cipher, des_plain)
	println('DES Ciphertext (Hex): ${des_cipher.hex()}')

	mut des_decrypted := []u8{len: 8}
	des_block.decrypt(mut des_decrypted, des_cipher)
	println('DES Decrypted:        "${des_decrypted.bytestr()}"')

	// --- 3. Blowfish Block Cipher ---
	println('\n--- Blowfish (Encryption Only) ---')
	bf_key := 'blowfish_key'.bytes()
	mut bf := blowfish.new_cipher(bf_key) or { panic(err) }

	bf_plain := 'bf_block'.bytes() // exactly 8 bytes (Blowfish block size)
	mut bf_cipher := []u8{len: 8}
	bf.encrypt(mut bf_cipher, bf_plain)
	println('Blowfish Ciphertext (Hex): ${bf_cipher.hex()}')
	println('(Note: V standard library crypto.blowfish only supports encryption)')

	// --- 4. RC4 Stream Cipher ---
	println('\n--- RC4 (Stream Cipher) ---')
	rc4_key := 'rc4_secret_key'.bytes()
	rc4_plain := 'RC4 is a stream cipher commonly used for legacy operations.'.bytes()

	mut rc4_enc := rc4.new_cipher(rc4_key) or { panic(err) }
	mut rc4_cipher := []u8{len: rc4_plain.len}
	rc4_enc.xor_key_stream(mut rc4_cipher, rc4_plain)
	println('RC4 Ciphertext (Hex): ${rc4_cipher.hex()}')

	mut rc4_dec := rc4.new_cipher(rc4_key) or { panic(err) }
	mut rc4_decrypted := []u8{len: rc4_cipher.len}
	rc4_dec.xor_key_stream(mut rc4_decrypted, rc4_cipher)
	println('RC4 Decrypted:        "${rc4_decrypted.bytestr()}"')
}
