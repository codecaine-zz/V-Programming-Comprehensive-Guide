module main

// Result type (!T) is used when a function can return an error.
fn divide(a f64, b f64) !f64 {
	if b == 0 {
		return error('division by zero')
	}
	return a / b
}

// Option type (?T) is used when a function can return nothing (none).
fn find_user(id int) ?string {
	if id == 1 {
		return 'Alice'
	}
	return none
}

fn main() {
	// 1. Handling a Result type with an `or` block
	// Inside the `or` block, the special variable `err` is available.
	val1 := divide(10.0, 2.0) or {
		println('Error: ${err}')
		0.0
	}
	println('Result 1: ${val1}')

	// 2. Handling a failed Result
	val2 := divide(10.0, 0.0) or {
		println('Error: ${err}')
		0.0
	}
	println('Result 2: ${val2}')

	// 3. Handling an Option type with an `or` block
	// For Option types, the value is unwrapped or the fallback value is returned.
	user1 := find_user(1) or { 'Guest' }
	println('User 1: ${user1}')

	user2 := find_user(99) or { 'Guest' }
	println('User 2: ${user2}')

	// 4. Using if-let syntax to check Options
	if name := find_user(1) {
		println('Found user: ${name}')
	} else {
		println('User not found')
	}
}
