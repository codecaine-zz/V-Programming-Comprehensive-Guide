module main

fn main() {
	// isize and usize methods
	sz := isize(100)
	usz := usize(200)

	// str() returns string representation
	println(sz.str()) // "100"
	println(usz.str()) // "200"

	// voidptr methods
	x := 42
	p := voidptr(&x)

	// str() returns the memory address as string
	println(p.str().starts_with('0x')) // true

	// hex_full() returns full-width hex representation of address
	println(p.hex_full().len > 0) // true

	// vbytes(len) returns a byte array representation of the memory pointed to (must be called in unsafe block)
	unsafe {
		bytes := p.vbytes(int(sizeof(int)))
		println(bytes) // [42, 0, 0, 0]
	}
}
