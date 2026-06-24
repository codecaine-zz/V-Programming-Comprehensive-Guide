module main

import time

// 1. Define a Struct.
// Structs are defined with the `struct` keyword. By default, structs are private
// (only accessible within the current module) and all fields are immutable.
// The `pub` keyword makes the struct visible to other modules.
pub struct Note {
// 2. Struct Access Modifiers:
// - `pub:` makes the fields readable from outside the module, but still immutable.
pub:
	id      int
	// Fields can have default values assigned at declaration.
	created time.Time = time.now()

// - `pub mut:` makes the fields readable and writable from outside the module.
pub mut:
	// Attributes can be attached to struct fields.
	// `@[required]` specifies that this field must be explicitly provided when instantiating.
	message string @[required]
	status  bool
	due     time.Time = time.now().add_days(1)
}

// 3. Define a Method (Value Receiver).
// In V, a method is a function with a receiver argument.
// The receiver is specified in parentheses before the function name: `(n Note)`.
// This is a "value receiver" method, meaning it receives a copy of the struct instance.
// It cannot modify fields on the original struct instance.
pub fn (n Note) is_empty_message() bool {
	return n.message.len < 1
}

fn main() {
	// 4. Instantiate a Struct.
	// We use the struct name and curly braces, listing field initializations.
	// Because `message` is marked `@[required]`, we must specify it.
	// The variable `n` is marked `mut` because we might want to update its `pub mut` fields.
	mut n := Note{
		id:      1
		message: ''
	}

	// 5. Invoke Struct Methods.
	// Methods are called on struct instances using the dot operator.
	if n.is_empty_message() {
		println('message is empty')
	} else {
		println('message not empty')
	}
}
