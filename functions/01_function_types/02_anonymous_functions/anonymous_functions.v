module main

fn main() {
	// Create an anonymous function and assign it to a variable.
	greet := fn (name string) {
		println('Hello, ${name}')
	}

	// Invoke the function twice with different names.
	greet('Pavan')
	greet('Sahithi')
}
