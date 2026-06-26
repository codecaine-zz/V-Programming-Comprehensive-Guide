module main

// Define a union sharing the same memory location, marked mutable
union Data {
mut:
	f f64
	i int
}

fn main() {
	mut d := Data{i: 10}
	
	// Accessing union members must be performed in an unsafe block
	unsafe {
		println('Union int value: ${d.i}')
		
		// Modifying one member automatically modifies the other since they share memory
		d.f = 5.5
		println('Union float value: ${d.f}')
		println('Union int value after float update: ${d.i} (shared memory representation)')
	}
}
