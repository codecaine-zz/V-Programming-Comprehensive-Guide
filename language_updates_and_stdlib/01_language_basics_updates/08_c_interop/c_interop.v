module main

// 1. Include C standard headers.
// V compiles directly to C, so we can use C preprocessor directives like `#include`
// to bring in C standard library definitions or external C headers.
#include <math.h>
#include <stdlib.h>

// 2. Declare C functions.
// We declare C functions using the `fn C.name(args) return_type` syntax.
// The V compiler translates calls to these functions directly to the native C functions.
fn C.abs(x int) int
fn C.sqrt(x f64) f64

// 3. Declare C Structs.
// V can also interact with C structs. We use `struct C.name` to define them.
// The `@[typedef]` attribute tells the V compiler that `div_t` is a typedef structure
// in C (defined in <stdlib.h>) so it does not prefix it with the `struct` keyword in the C output.
@[typedef]
struct C.div_t {
	quot int
	rem  int
}

// Declare C.div function from stdlib.h which returns a C.div_t struct.
fn C.div(numer int, denom int) C.div_t

fn main() {
	println('=== V C Interop Demo ===')

	// 4. Calling C.abs
	negative_val := -42
	absolute_val := C.abs(negative_val)
	println('C.abs(${negative_val}) = ${absolute_val}')
	assert absolute_val == 42

	// 5. Calling C.sqrt
	float_val := 16.0
	square_root := C.sqrt(float_val)
	println('C.sqrt(${float_val}) = ${square_root}')
	assert square_root == 4.0

	// 6. Working with C Structs and functions returning C Structs
	numerator := 10
	denominator := 3
	div_result := C.div(numerator, denominator)
	println('C.div(${numerator}, ${denominator}) -> Quotient: ${div_result.quot}, Remainder: ${div_result.rem}')
	assert div_result.quot == 3
	assert div_result.rem == 1

	println('All C Interop functions successfully executed and verified!')
}
