module main

struct Node {
	a &Node
	b &Node = unsafe { nil } // Auto-initialized to nil
}

fn main() {
	println('=== Struct Reference Fields ===')
	foo := Node{
		a: unsafe { nil }
	}
	bar := Node{
		a: &foo
	}
	println('foo: ${foo}')
	println('bar: ${bar}')
	assert bar.a == &foo
}
