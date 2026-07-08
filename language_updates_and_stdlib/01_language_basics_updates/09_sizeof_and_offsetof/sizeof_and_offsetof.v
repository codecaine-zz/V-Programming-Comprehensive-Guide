module main

// sizeof() and __offsetof() reveal how V lays out your data in memory.
// They are mostly used for low-level work: C interop, binary file formats,
// network protocols, and performance tuning.
//
// Beginner mental model: a struct is a contiguous block of bytes, and each
// field lives at a fixed "offset" (distance in bytes) from the start.

// Two 4-byte ints, tightly packed: total size is 8 bytes.
struct Point {
	x int
	y int
}

// Field order matters! `b` is a single byte, but the compiler inserts
// 3 bytes of invisible padding after it so that `c` starts on a 4-byte
// boundary (ints are fastest to access when aligned).
struct Foo {
	a int // bytes 0..3
	b u8  // byte 4 (+ 3 padding bytes)
	c int // bytes 8..11
}

fn main() {
	// sizeof gives the total size of a type in bytes, including padding.
	println('sizeof(Point) = ${sizeof(Point)} bytes') // 8
	println('sizeof(Foo) = ${sizeof(Foo)} bytes') // 12 (due to alignment/padding in C backend)

	// __offsetof gives the offset in bytes of a struct field from the
	// start of the struct. Note the "gap" between Foo.b and Foo.c below.
	println('__offsetof(Point, x) = ${__offsetof(Point, x)}') // 0
	println('__offsetof(Point, y) = ${__offsetof(Point, y)}') // 4
	println('__offsetof(Foo, a) = ${__offsetof(Foo, a)}') // 0
	println('__offsetof(Foo, b) = ${__offsetof(Foo, b)}') // 4
	println('__offsetof(Foo, c) = ${__offsetof(Foo, c)}') // 8 (not 5 — padding!)
}
