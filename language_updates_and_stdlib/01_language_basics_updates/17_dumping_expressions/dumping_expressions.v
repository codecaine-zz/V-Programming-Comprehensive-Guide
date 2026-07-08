module main

// dump(expr) is a built-in debugging helper. It prints the source location,
// the expression text, and its value — then returns the value unchanged.
// Because it "passes through" the value, you can wrap almost any expression
// with dump() without changing your program's behavior.
//
// Beginner tip: dump() is great for tracing recursion or intermediate values
// without sprinkling temporary println() calls everywhere. Remove the dump()
// wrappers when you are done debugging.

fn factorial(n u32) u32 {
	// dump() prints the condition result each time this line runs,
	// so you can watch the recursion unwind step by step.
	if dump(n <= 1) {
		// Base case: dump(1) prints "1" and still returns 1 to the caller.
		return dump(1)
	}
	// Each recursive step prints the partial product before returning it.
	return dump(n * factorial(n - 1))
}

fn main() {
	// Simple values and expressions can be dumped too.
	x := dump(10 + 5) // prints: [.../dumping_expressions.v:...] 10 + 5: 15
	name := dump('V') // works with any type, not just numbers
	println('x = ${x}, name = ${name}')

	// Watch the whole recursive call tree print itself:
	println(factorial(5)) // 120
}
