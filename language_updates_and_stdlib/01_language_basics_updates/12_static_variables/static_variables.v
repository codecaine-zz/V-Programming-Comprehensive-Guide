module main

// V supports function-scoped static variables inside unsafe functions
@[unsafe]
fn counter() int {
	// static variables are initialized only once
	mut static x := 42
	x++
	return x
}

fn main() {
	println(unsafe { counter() }) // 43
	println(unsafe { counter() }) // 44
	println(unsafe { counter() }) // 45
}
