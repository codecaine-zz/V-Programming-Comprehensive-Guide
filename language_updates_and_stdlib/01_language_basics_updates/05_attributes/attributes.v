module main

import json

// User uses attributes to control JSON field names and to hide a field from encoding.
struct User {
	name   string @[json: 'username']
	age    int    @[json: 'user_age']
	secret string @[json: '-']
}

// Note shows how database-related attributes can describe a schema shape.
struct Note {
	id      int    @[primary; sql: serial]
	message string @[sql: 'detail'; unique]
}

// deprecated warns developers when they call this function.
@[deprecated: 'use modern_greet instead']
fn old_greet() {
	println('Hello from the old greeting!')
}

// modern_greet is the preferred replacement for old_greet.
fn modern_greet() {
	println('Hello from the modern greeting!')
}

// inline hints the compiler that this small function should be inlined.
@[inline]
fn add(a int, b int) int {
	return a + b
}

// required marks a function parameter as something that should be supplied explicitly.
@[required]
fn greet_user(name string) string {
	return 'Hello, ${name}!'
}

fn main() {
	println('=== attributes demo ===')

	// Build a User instance and encode it to JSON.
	u := User{
		name:   'Bob'
		age:    30
		secret: 'hidden'
	}
	encoded := json.encode(u)
	println('Encoded JSON: ${encoded}')

	// Decode a JSON payload that uses the custom field names from the attributes.
	decoded := json.decode(User, '{"username":"Alice","user_age":25}') or {
		println('JSON error: ${err}')
		User{}
	}
	println('Decoded User -> Name: ${decoded.name}, Age: ${decoded.age}')

	// The inline attribute is only a hint, but the example shows the function call.
	sum := add(10, 20)
	println('Sum: ${sum}')

	// Call the modern function and the required-parameter helper.
	modern_greet()
	println(greet_user('Ada'))

	// The Note struct is only used to demonstrate the attribute syntax here.
	println('Note schema fields: ${Note{}.id} / ${Note{}.message}')
	// Calling old_greet() will compile successfully but output a warning:
	// warning: old_greet has been deprecated. use modern_greet instead
	// old_greet()
}
