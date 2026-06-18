module main

import math
import rand

fn main() {
	println('=== Math & Rand Module Examples ===')

	// --- math ---
	println('\n--- math ---')
	println('Pi constant: ${math.pi}')
	println('E constant:  ${math.e}')
	
	// Trigonometry
	angle := 45.0 * (math.pi / 180.0) // 45 degrees in radians
	println('sin(45 deg): ${math.sin(angle):.4f}')
	println('cos(45 deg): ${math.cos(angle):.4f}')
	println('tan(45 deg): ${math.tan(angle):.4f}')

	// Power, Square Root, Logarithms
	println('2^10:        ${math.pow(2.0, 10.0)}')
	println('sqrt(144):   ${math.sqrt(144.0)}')
	println('ln(e):       ${math.log(math.e)}')
	println('log10(100):  ${math.log10(100.0)}')

	// Absolute, Min/Max, Rounding
	println('abs(-5.5):   ${math.abs(-5.5)}')
	println('max(10, 20): ${math.max(10.0, 20.0)}')
	println('min(10, 20): ${math.min(10.0, 20.0)}')
	println('ceil(4.2):   ${math.ceil(4.2)}')
	println('floor(4.8):  ${math.floor(4.8)}')
	println('round(4.5):  ${math.round(4.5)}')

	// --- rand ---
	println('\n--- rand ---')
	// Random integers and floats
	random_int := rand.int_in_range(1, 100) or { 0 }
	println('Random integer in [1, 100): ${random_int}')

	random_f64 := rand.f64()
	println('Random f64 in [0.0, 1.0):   ${random_f64:.4f}')

	// Random boolean simulated using rand.intn
	random_bool := (rand.intn(2) or { 0 }) == 0
	println('Random boolean:             ${random_bool}')

	// Choosing a random element from an array
	items := ['Apple', 'Banana', 'Cherry', 'Date']
	chosen := rand.element(items) or { 'None' }
	println('Randomly chosen fruit:      ${chosen}')

	// Random UUID generation (commonly used)
	uuid_str := rand.uuid_v4()
	println('Random UUID v4:             ${uuid_str}')
}
