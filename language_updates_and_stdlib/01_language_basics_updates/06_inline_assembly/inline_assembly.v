module main

// add_five adds 5 to the given integer using inline assembly.
// It uses compile-time conditional checks ($if) to select the correct 
// assembly instructions depending on the target CPU architecture.
fn add_five(val int) int {
	mut res := val
	$if arm64 {
		// ARM64 inline assembly for Apple Silicon (macOS M-series) and ARM Linux/Android.
		// - Syntax: add destination, operand1, operand2
		// - Constraints: '; +r (res)' specifies that 'res' is both an input and output register.
		asm arm64 {
			add res, res, 5
			; +r (res)
		}
	} $else $if amd64 {
		// AMD64 (x86_64) inline assembly for Intel/AMD processors.
		// - Syntax: add destination, source
		// - Constraints: '; +r (res)' specifies that 'res' is both an input and output register.
		asm amd64 {
			add res, 5
			; +r (res)
		}
	} $else {
		// Fallback for other architectures (e.g. 32-bit x86, RISC-V, WebAssembly, etc.)
		res += 5
	}
	return res
}

// multiply_by_two multiplies the given integer by 2 using bit shifting in inline assembly.
fn multiply_by_two(val int) int {
	mut res := val
	$if arm64 {
		// ARM64 inline assembly using logical shift left (lsl) by 1 bit.
		asm arm64 {
			lsl res, res, 1
			; +r (res)
		}
	} $else $if amd64 {
		// AMD64 inline assembly using shift arithmetic left (sal).
		asm amd64 {
			sal res, 1
			; +r (res)
		}
	} $else {
		res = res << 1
	}
	return res
}

fn main() {
	println('=== V Inline Assembly (asm) Demo ===')

	// Test 1: Addition using inline assembly
	num := 10
	num_plus_five := add_five(num)
	println('Result of add_five(${num}): ${num_plus_five}')
	assert num_plus_five == 15

	// Test 2: Multiplication (bit-shifting) using inline assembly
	val := 21
	val_double := multiply_by_two(val)
	println('Result of multiply_by_two(${val}): ${val_double}')
	assert val_double == 42

	println('All inline assembly assertions successfully verified!')
}
