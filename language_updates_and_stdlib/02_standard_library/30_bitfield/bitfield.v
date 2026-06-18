module main

import bitfield

fn main() {
	println('=== bitfield Module Demo ===')

	// 1. Create bitfield from string
	mut bf1 := bitfield.from_str('101100')
	println('BitField 1 (from str):  ${bf1.str()}')
	println('Size of BitField 1:      ${bf1.get_size()}')
	println('Number of 1s (pop_count): ${bf1.pop_count()}')

	// 2. Accessing and modifying individual bits
	println('\nModifying individual bits:')
	println('  Bit at index 1 before:  ${bf1.get_bit(1)}')
	bf1.set_bit(1)
	println('  Bit at index 1 after set: ${bf1.get_bit(1)}')
	bf1.clear_bit(0)
	println('  Bitfield after changes: ${bf1.str()}')

	// 3. Logical bitwise operations
	mut bf2 := bitfield.from_str('011010')
	println('\nLogical operations on ${bf1.str()} and ${bf2.str()}:')
	
	and_result := bitfield.bf_and(bf1, bf2)
	or_result  := bitfield.bf_or(bf1, bf2)
	xor_result := bitfield.bf_xor(bf1, bf2)
	not_result := bitfield.bf_not(bf1)

	println('  AND: ${and_result.str()}')
	println('  OR:  ${or_result.str()}')
	println('  XOR: ${xor_result.str()}')
	println('  NOT: ${not_result.str()}')
}
