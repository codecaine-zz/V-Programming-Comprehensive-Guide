module main

// `math` covers the classic calculator functions (trig, powers, rounding),
// while `rand` produces random numbers, strings, and unique IDs.
//
// Beginner tips:
// - math functions work with f64 (64-bit floats); pass 2.0, not 2.
// - Trig functions expect RADIANS, not degrees — see the conversion below.
// - Many rand functions return a Result (they can fail), so they need
//   `or { fallback }` to provide a default value on error.
import math
import rand

fn main() {
	println('=== Math & Rand Module Examples ===')

	println('\n--- math ---')
	// Well-known constants, ready to use.
	println('Pi constant: ${math.pi}')
	println('E constant:  ${math.e}')

	// Trigonometry: convert degrees to radians first (deg * pi / 180).
	// `:.4f` in the interpolation formats the float to 4 decimal places.
	angle := 45.0 * (math.pi / 180.0)
	println('sin(45 deg): ${math.sin(angle):.4f}')
	println('cos(45 deg): ${math.cos(angle):.4f}')
	println('tan(45 deg): ${math.tan(angle):.4f}')

	// Powers, roots, and logarithms.
	println('2^10:        ${math.pow(2.0, 10.0)}')
	println('sqrt(144):   ${math.sqrt(144.0)}')
	println('ln(e):       ${math.log(math.e)}') // natural log (base e)
	println('log10(100):  ${math.log10(100.0)}') // base-10 log

	// Everyday helpers: absolute value, min/max, and rounding modes.
	println('abs(-5.5):   ${math.abs(-5.5)}')
	println('max(10, 20): ${math.max(10.0, 20.0)}')
	println('min(10, 20): ${math.min(10.0, 20.0)}')
	println('ceil(4.2):   ${math.ceil(4.2)}') // always rounds UP
	println('floor(4.8):  ${math.floor(4.8)}') // always rounds DOWN
	println('round(4.5):  ${math.round(4.5)}') // rounds to nearest
	println('cbrt(27):    ${math.cbrt(27.0):.2f}') // cube root
	println('clamp(12, 0, 10): ${math.clamp(12.0, 0.0, 10.0)}') // limit to a range
	println('exp(1):      ${math.exp(1.0):.4f}') // e^x
	println('exp2(3):     ${math.exp2(3.0):.4f}') // 2^x
	println('hypot(3, 4): ${math.hypot(3.0, 4.0):.4f}') // sqrt(x²+y²) — distance
	println('log2(8):     ${math.log2(8.0):.4f}') // base-2 log
	println('trunc(4.9):  ${math.trunc(4.9)}') // chop off the decimals

	println('\n--- rand ---')
	// Random integer in a half-open range: 1 is possible, 100 is not.
	random_int := rand.int_in_range(1, 100) or { 0 }
	println('Random integer in [1, 100): ${random_int}')

	// Random float between 0.0 (inclusive) and 1.0 (exclusive) —
	// the classic building block for probabilities and percentages.
	random_f64 := rand.f64()
	println('Random f64 in [0.0, 1.0):   ${random_f64:.4f}')

	// Coin flip: intn(2) yields 0 or 1.
	random_bool := (rand.intn(2) or { 0 }) == 0
	println('Random boolean:             ${random_bool}')

	// Pick a random element from any array.
	items := ['Apple', 'Banana', 'Cherry', 'Date']
	chosen := rand.element(items) or { 'None' }
	println('Randomly chosen fruit:      ${chosen}')

	// Raw random bytes — useful for tokens, salts, and test data.
	random_bytes := rand.bytes(4) or { []u8{} }
	println('Random bytes:               ${random_bytes}')

	// Convenience string generators.
	random_hex := rand.hex(8) // 8 random hex characters
	println('Random hex string:          ${random_hex}')

	random_string := rand.string(8) // 8 random ASCII letters
	println('Random ascii string:        ${random_string}')

	// ULIDs are sortable unique IDs (timestamp + randomness).
	random_ulid := rand.ulid()
	println('Random ULID:                ${random_ulid}')

	// Ranges also work for 64-bit integers, including negatives.
	random_i64 := rand.i64_in_range(i64(-10), i64(10)) or { 0 }
	println('Random i64 in [-10, 10]:    ${random_i64}')

	// UUID v4 is fully random; UUID v7 embeds a timestamp so ids sort
	// roughly by creation time — handy for database keys.
	mut uuid_str := rand.uuid_v4()
	println('Random UUID v4:             ${uuid_str}')
	uuid_str = rand.uuid_v7()
	println('Random UUID v7:             ${uuid_str}')
}
