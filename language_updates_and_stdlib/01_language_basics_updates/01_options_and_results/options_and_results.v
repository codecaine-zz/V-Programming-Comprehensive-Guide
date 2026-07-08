module main

// Result type (!T) is used when a function can succeed or fail for a reason that matters.
// A good rule of thumb is: use Result when the operation can fail and you want to preserve the error.
fn divide(a f64, b f64) !f64 {
	if b == 0 {
		return error('division by zero')
	}
	return a / b
}

// Option type (?T) is used when a value may be missing.
// This is a better fit than Result when there is no error, just "no value".
fn find_user(id int) ?string {
	if id == 1 {
		return 'Alice'
	}
	return none
}

fn main() {
	// 1. Handling a Result type with an `or` block
	// `or` gives you a fallback path and keeps the error available in the special `err` variable.
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
	// This is a common beginner pattern when a lookup may legitimately return no result.
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
