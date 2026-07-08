module main

// Encodings convert data between representations. Three you will meet
// constantly in real projects:
// - Base64: pack ANY bytes into safe ASCII text (email attachments, JSON
//   payloads, data URLs). NOT encryption — anyone can decode it!
// - Hex:    show bytes as human-readable pairs of 0-9/a-f characters
//   (hashes, checksums, debugging binary data).
// - CSV:    the classic rows-and-columns text format used by spreadsheets.
import encoding.base64
import encoding.hex
import encoding.csv

fn main() {
	println('=== Encoding Modules Examples ===')

	// --- 1. Base64 ---
	println('\n--- Base64 ---')
	raw_str := 'V Programming Language'
	// encode_str(): string in, base64 text out. Output is ~33% larger.
	encoded_b64 := base64.encode_str(raw_str)
	println('Encoded Base64: ${encoded_b64}')

	// Decoding reverses it exactly — base64 is a reversible ENCODING,
	// not a way to hide secrets.
	decoded_b64 := base64.decode_str(encoded_b64)
	println('Decoded Base64: ${decoded_b64}')

	// --- 2. Hex ---
	println('\n--- Hex ---')
	// Each byte becomes two hex characters: 72 -> "48", 101 -> "65", ...
	raw_bytes := [u8(72), 101, 108, 108, 111] // "Hello"
	encoded_hex := hex.encode(raw_bytes)
	println('Encoded Hex:    ${encoded_hex}')

	// decode() can fail on malformed input (odd length, bad chars),
	// so it returns a Result handled with `or {}`.
	decoded_hex := hex.decode(encoded_hex) or { []u8{} }
	println('Decoded Hex:    ${decoded_hex.bytestr()}')

	// --- 3. CSV ---
	println('\n--- CSV ---')
	// First line is a header row; each following line is one record.
	csv_data := 'Name,Age,City\nAlice,30,New York\nBob,25,San Francisco'

	mut reader := csv.new_reader(csv_data)
	println('Reading CSV rows:')
	// read() returns one row (as []string) per call and errors at
	// end-of-data — which is our signal to break out of the loop.
	for {
		row := reader.read() or { break }
		println('  Row: ${row}')
	}
}
