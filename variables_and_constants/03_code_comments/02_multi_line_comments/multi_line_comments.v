module main

/*
multiply is a function that accepts two integer arguments (x and y).
It performs multiplication and returns the integer product.

Note: Comments formatted like this (/* ... */) do not show in code hints
using v-analyzer or `v doc`. You must use `//` for each line to enable IDE hints.

/*
Note: In V, block comments can be nested.
This is a nested block comment. In standard C, nesting block comments
would cause a compile error, but V's compiler parses them correctly.
*/
This is the end of the outer block comment.
*/
fn multiply(x int, y int) int {
	return x * y
}

fn main() {
	println(multiply(4, 5))
}
