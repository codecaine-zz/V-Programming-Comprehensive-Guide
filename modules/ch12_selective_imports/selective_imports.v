module main

import os { input, user_os }

fn main() {
	println('=== Selective Imports ===')
	// We can use the imported functions directly without os. prefix:
	name := 'Ada'
	println('Hello, ${name}!')
	current_os := user_os()
	println('Your OS is ${current_os}.')
	assert current_os.len > 0
}
