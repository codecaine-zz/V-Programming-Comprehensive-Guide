module main

import json

// User struct defines field attributes for custom JSON serialization/deserialization.
struct User {
	name string @[json: 'username']
	age  int    @[json: 'user_age']
}

// @[deprecated] warns the developer at compile time that the function shouldn't be used.
@[deprecated: 'use modern_greet instead']
fn old_greet() {
	println('Hello from the old greeting!')
}

fn modern_greet() {
	println('Hello from the modern greeting!')
}

// @[inline] suggests the compiler to inline the function body.
@[inline]
fn add(a int, b int) int {
	return a + b
}

fn main() {
	// 1. JSON serialization/deserialization using @[json] mapping
	u := User{
		name: 'Bob'
		age:  30
	}
	encoded := json.encode(u)
	println('Encoded JSON: ${encoded}')

	decoded := json.decode(User, '{"username":"Alice","user_age":25}') or {
		println('JSON error: ${err}')
		User{}
	}
	println('Decoded User -> Name: ${decoded.name}, Age: ${decoded.age}')

	// 2. Calling inline function
	sum := add(10, 20)
	println('Sum: ${sum}')

	// 3. Calling modern function
	modern_greet()

	// Note: Calling old_greet() will compile successfully but output a warning:
	// warning: old_greet has been deprecated. use modern_greet instead
	// old_greet()
}
