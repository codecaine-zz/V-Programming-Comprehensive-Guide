module main

import math
import rand

fn main() {
	println('=== Math & Rand Module Examples ===')

	println('\n--- math ---')
	println('Pi constant: ${math.pi}')
	println('E constant:  ${math.e}')

	angle := 45.0 * (math.pi / 180.0)
	println('sin(45 deg): ${math.sin(angle):.4f}')
	println('cos(45 deg): ${math.cos(angle):.4f}')
	println('tan(45 deg): ${math.tan(angle):.4f}')

	println('2^10:        ${math.pow(2.0, 10.0)}')
	println('sqrt(144):   ${math.sqrt(144.0)}')
	println('ln(e):       ${math.log(math.e)}')
	println('log10(100):  ${math.log10(100.0)}')

	println('abs(-5.5):   ${math.abs(-5.5)}')
	println('max(10, 20): ${math.max(10.0, 20.0)}')
	println('min(10, 20): ${math.min(10.0, 20.0)}')
	println('ceil(4.2):   ${math.ceil(4.2)}')
	println('floor(4.8):  ${math.floor(4.8)}')
	println('round(4.5):  ${math.round(4.5)}')
	println('cbrt(27):    ${math.cbrt(27.0):.2f}')
	println('clamp(12, 0, 10): ${math.clamp(12.0, 0.0, 10.0)}')
	println('exp(1):      ${math.exp(1.0):.4f}')
	println('exp2(3):     ${math.exp2(3.0):.4f}')
	println('hypot(3, 4): ${math.hypot(3.0, 4.0):.4f}')
	println('log2(8):     ${math.log2(8.0):.4f}')
	println('trunc(4.9):  ${math.trunc(4.9)}')

	println('\n--- rand ---')
	random_int := rand.int_in_range(1, 100) or { 0 }
	println('Random integer in [1, 100): ${random_int}')

	random_f64 := rand.f64()
	println('Random f64 in [0.0, 1.0):   ${random_f64:.4f}')

	random_bool := (rand.intn(2) or { 0 }) == 0
	println('Random boolean:             ${random_bool}')

	items := ['Apple', 'Banana', 'Cherry', 'Date']
	chosen := rand.element(items) or { 'None' }
	println('Randomly chosen fruit:      ${chosen}')

	random_bytes := rand.bytes(4) or { []u8{} }
	println('Random bytes:               ${random_bytes}')

	random_hex := rand.hex(8)
	println('Random hex string:          ${random_hex}')

	random_string := rand.string(8)
	println('Random ascii string:        ${random_string}')

	random_ulid := rand.ulid()
	println('Random ULID:                ${random_ulid}')

	random_i64 := rand.i64_in_range(i64(-10), i64(10)) or { 0 }
	println('Random i64 in [-10, 10]:    ${random_i64}')

	mut uuid_str := rand.uuid_v4()
	println('Random UUID v4:             ${uuid_str}')
	uuid_str = rand.uuid_v7()
	println('Random UUID v7:             ${uuid_str}')
}
