module main

// Stack[T] represents a generic stack structure.
struct Stack[T] {
mut:
	items []T
}

// push appends an item of type T to the stack.
fn (mut s Stack[T]) push(item T) {
	s.items << item
}

// pop removes and returns the top item of type T from the stack,
// or returns `none` (Option type) if the stack is empty.
fn (mut s Stack[T]) pop() ?T {
	if s.items.len == 0 {
		return none
	}
	return s.items.pop()
}

// print_val is a generic function that takes any type T and prints it.
fn print_val[T](val T) {
	println('Value: ${val}')
}

fn main() {
	// 1. Using a generic struct with integers
	mut int_stack := Stack[int]{}
	int_stack.push(10)
	int_stack.push(20)
	println('Popped: ${int_stack.pop() or { 0 }}')
	println('Popped: ${int_stack.pop() or { 0 }}')
	println('Popped from empty stack: ${int_stack.pop() or { -1 }}')

	// 2. Using the same generic struct with strings
	mut str_stack := Stack[string]{}
	str_stack.push('V')
	str_stack.push('lang')
	println('Popped: ${str_stack.pop() or { 'empty' }}')
	println('Popped: ${str_stack.pop() or { 'empty' }}')

	// 3. Calling a generic function with different types
	print_val[string]('V monomorphizes generics at compile-time!')
	print_val[f64](3.14159)
}
