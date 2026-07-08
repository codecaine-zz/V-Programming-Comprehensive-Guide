module main

// A static variable keeps its value between function calls — it is created
// once and lives for the whole program, but is only visible inside the
// function that declares it.
//
// Beginner notes:
// - V deliberately makes this harder to use than in C: the function must be
//   marked @[unsafe], and callers must wrap calls in an `unsafe { }` block.
//   That is because hidden mutable state makes code harder to reason about
//   and is not thread-safe.
// - Prefer passing state explicitly (arguments, struct fields, closures).
//   Reach for `static` only for low-level or C-interop scenarios.
@[unsafe]
fn counter() int {
	// `static` means: initialize x to 42 the FIRST time only.
	// Every later call reuses the same x, remembering the previous value.
	mut static x := 42
	x++
	return x
}

fn main() {
	// Each call increments the same persistent variable.
	println(unsafe { counter() }) // 43
	println(unsafe { counter() }) // 44
	println(unsafe { counter() }) // 45
}
