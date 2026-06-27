module main

import crypto.ecdsa
import crypto.ed25519
import crypto.pem

fn main() {
	println('=== V Asymmetric Cryptography Demo ===')

	message := 'Message to sign and verify asymmetric signatures.'.bytes()

	// --- 1. ECDSA ---
	println('\n--- ECDSA ---')

	// Generate key pair
	pub_ec, priv_ec := ecdsa.generate_key() or {
		println('Failed to generate ECDSA key: ${err}')
		return
	}

	// Sign message
	sig_ec := priv_ec.sign(message, ecdsa.SignerOpts{}) or {
		println('ECDSA signing failed: ${err}')
		return
	}
	println('ECDSA Signature (Hex): ${sig_ec.hex()}')

	// Verify message
	verified_ec := pub_ec.verify(message, sig_ec, ecdsa.SignerOpts{}) or {
		println('ECDSA verification error: ${err}')
		return
	}
	println('ECDSA Signature Verified? -> ${verified_ec}')

	// --- 2. Ed25519 ---
	println('\n--- Ed25519 ---')

	// Generate key pair
	pub_ed, priv_ed := ed25519.generate_key() or {
		println('Failed to generate Ed25519 key: ${err}')
		return
	}

	// Sign message
	sig_ed := ed25519.sign(priv_ed, message) or {
		println('Ed25519 signing failed: ${err}')
		return
	}
	println('Ed25519 Signature (Hex): ${sig_ed.hex()}')

	// Verify message
	verified_ed := ed25519.verify(pub_ed, message, sig_ed) or {
		println('Ed25519 verification error: ${err}')
		return
	}
	println('Ed25519 Signature Verified? -> ${verified_ed}')

	// --- 3. PEM Encoding/Decoding ---
	println('\n--- PEM (Privacy Enhanced Mail) Encoding ---')

	pub_bytes := pub_ec.bytes() or {
		println('Failed to get public key bytes: ${err}')
		return
	}

	mut pem_block := pem.Block.new('EC PUBLIC KEY')
	pem_block.data = pub_bytes

	pem_string := pem_block.encode(pem.EncodeConfig{}) or {
		println('PEM encoding failed: ${err}')
		return
	}
	println('Encoded PEM Public Key:')
	println(pem_string)

	// Decode back
	decoded_block, _ := pem.decode(pem_string) or {
		println('PEM decoding failed')
		return
	}
	println('Decoded Block Type: "${decoded_block.block_type}"')
	println('Decoded data size matches? -> ${decoded_block.data.len == pub_bytes.len}')
}
