module main

import encoding.base64
import encoding.hex
import encoding.csv

fn main() {
	println('=== Encoding Modules Examples ===')

	// --- 1. Base64 ---
	println('\n--- Base64 ---')
	raw_str := 'V Programming Language'
	encoded_b64 := base64.encode_str(raw_str)
	println('Encoded Base64: ${encoded_b64}')

	decoded_b64 := base64.decode_str(encoded_b64)
	println('Decoded Base64: ${decoded_b64}')

	// --- 2. Hex ---
	println('\n--- Hex ---')
	raw_bytes := [u8(72), 101, 108, 108, 111] // "Hello"
	encoded_hex := hex.encode(raw_bytes)
	println('Encoded Hex:    ${encoded_hex}')

	decoded_hex := hex.decode(encoded_hex) or { []u8{} }
	println('Decoded Hex:    ${decoded_hex.bytestr()}')

	// --- 3. CSV ---
	println('\n--- CSV ---')
	csv_data := 'Name,Age,City\nAlice,30,New York\nBob,25,San Francisco'

	mut reader := csv.new_reader(csv_data)
	println('Reading CSV rows:')
	for {
		row := reader.read() or { break }
		println('  Row: ${row}')
	}
}
