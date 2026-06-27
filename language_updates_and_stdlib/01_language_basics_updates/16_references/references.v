module main

struct Foo {
mut:
	abc int
}

// 1. A method receiving a reference. The receiver type is &Foo.
// Even though it is a reference, `foo` is immutable and cannot be changed here.
fn (foo &Foo) print_abc() {
	println('print_abc: foo.abc = ${foo.abc}')
}

// 2. A regular function receiving a reference to Foo.
fn show_foo(foo &Foo) {
	println('show_foo: foo.abc = ${foo.abc}')
}

// 3. To modify a reference, we must pass it as mutable.
// Note that mutable parameters are passed by reference under the hood.
fn modify_foo(mut foo Foo, new_val int) {
	foo.abc = new_val
}

// 4. References are crucial for recursive types (like trees or linked lists).
// Since the size of Node must be known at compile time, recursive fields must be references.
// To allow optional/empty references (like leaf node terminations), V uses optional references (?&Node[T]).
struct Node[T] {
	val   T
	left  ?&Node[T]
	right ?&Node[T]
}

fn main() {
	println('=== V References & Pointers Demo ===')

	// Creating a struct instance
	mut my_foo := Foo{
		abc: 100
	}

	// Calling method on reference. V automatically takes the address of my_foo.
	my_foo.print_abc()

	// Calling a function expecting a reference using & operator.
	show_foo(&my_foo)

	// Modifying the struct via a mutable receiver/argument.
	modify_foo(mut my_foo, 200)
	println('After modify_foo: my_foo.abc = ${my_foo.abc}')

	// 5. Dereferencing a reference using the `*` operator.
	ref_to_foo := &my_foo
	// To copy the value of the struct pointed to by ref_to_foo:
	copied_foo := *ref_to_foo
	println('Copied foo abc: ${copied_foo.abc}')

	// 6. Generic Tree structure using optional references
	// Optional references are auto-initialized to `none`, so we don't need dummy nodes or `unsafe` blocks.
	left_leaf := Node[int]{
		val: 5
	}

	right_leaf := Node[int]{
		val: 15
	}

	// Create root node pointing to leaf references
	root := Node[int]{
		val:   10
		left:  &left_leaf
		right: &right_leaf
	}

	println('Root val: ${root.val}')

	// Access the optional child nodes safely using if guards
	if left := root.left {
		println('Left leaf val: ${left.val}')
	}
	if right := root.right {
		println('Right leaf val: ${right.val}')
	}
}
