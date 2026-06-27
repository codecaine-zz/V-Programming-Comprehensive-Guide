module main

struct Point {
	x int
	y int
}

struct Foo {
	a int
	b u8
	c int
}

fn main() {
	// sizeof gives the size of a type in bytes
	println('sizeof(Point) = ${sizeof(Point)} bytes') // 8
	println('sizeof(Foo) = ${sizeof(Foo)} bytes') // 12 (due to alignment/padding in C backend)

	// __offsetof gives the offset in bytes of a struct field
	println('__offsetof(Point, x) = ${__offsetof(Point, x)}') // 0
	println('__offsetof(Point, y) = ${__offsetof(Point, y)}') // 4
	println('__offsetof(Foo, a) = ${__offsetof(Foo, a)}') // 0
	println('__offsetof(Foo, b) = ${__offsetof(Foo, b)}') // 4
	println('__offsetof(Foo, c) = ${__offsetof(Foo, c)}') // 8
}
