module main

import strconv

fn main() {
	println('=== strconv Module Demo ===')

	// 1. Convert string to integer types (with error propagation/handling)
	val_int := strconv.atoi('12345') or {
		println('Error parsing int: ${err}')
		0
	}
	println('Parsed int: ${val_int}')

	val_i64 := strconv.atoi64('9223372036854775807') or {
		println('Error parsing i64: ${err}')
		0
	}
	println('Parsed i64: ${val_i64}')

	// 2. Parse unsigned and specific bases/bit-sizes
	// parse_int(s string, base int, bit_size int) !i64
	val_hex := strconv.parse_int('0xff', 0, 64) or {
		println('Error parsing hex: ${err}')
		0
	}
	println('Parsed hex (0xff in base 0): ${val_hex}')

	val_bin := strconv.parse_uint('101010', 2, 32) or {
		println('Error parsing binary: ${err}')
		0
	}
	println('Parsed binary (101010 in base 2): ${val_bin}')

	// 3. Convert string to float (atof64)
	val_f64 := strconv.atof64('3.14159265') or {
		println('Error parsing f64: ${err}')
		0.0
	}
	println('Parsed float64: ${val_f64}')

	// 4. Convert number to base string representation
	// format_int(n i64, radix int) string
	binary_str := strconv.format_int(42, 2)
	hex_str := strconv.format_int(255, 16)
	println('42 in binary: ${binary_str}')
	println('255 in hex:   ${hex_str}')
}
