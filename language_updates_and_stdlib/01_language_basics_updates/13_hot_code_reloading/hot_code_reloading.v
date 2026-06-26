module main

import time

// Functions that should be reloaded must have `@[live]` attribute
@[live]
fn print_message() {
	println('Hello! Modify this message while the program is running under -live mode.')
}

fn main() {
	// A simple loop printing the message
	for i in 0 .. 3 {
		print_message()
		time.sleep(100 * time.millisecond)
	}
}
