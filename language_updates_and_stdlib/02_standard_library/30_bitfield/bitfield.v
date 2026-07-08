module main

// A BitField stores many true/false values packed into single bits —
// 8x more compact than an array of bools. Typical uses: feature flags,
// permission sets, bitmap indexes, and "seen" markers for large ranges.
//
// Beginner mental model: a BitField is a row of switches. You can flip
// one switch (set_bit/clear_bit), inspect one (get_bit), or combine two
// whole rows at once with AND/OR/XOR/NOT.
import bitfield

fn main() {
	println('=== bitfield Module Demo ===')

	// 1. Create a bitfield from a string of 0s and 1s.
	mut bf1 := bitfield.from_str('101100')
	println('BitField 1 (from str):  ${bf1.str()}')
	println('Size of BitField 1:      ${bf1.get_size()}') // number of bits
	println('Number of 1s (pop_count): ${bf1.pop_count()}') // how many are set

	// 2. Accessing and modifying individual bits (indexes start at 0).
	println('\nModifying individual bits:')
	println('  Bit at index 1 before:  ${bf1.get_bit(1)}')
	bf1.set_bit(1) // turn bit 1 ON
	println('  Bit at index 1 after set: ${bf1.get_bit(1)}')
	bf1.clear_bit(0) // turn bit 0 OFF
	println('  Bitfield after changes: ${bf1.str()}')

	// 3. Logical bitwise operations combine two bitfields bit-by-bit:
	//    AND — 1 only where BOTH are 1 (intersection)
	//    OR  — 1 where EITHER is 1 (union)
	//    XOR — 1 where they DIFFER
	//    NOT — flips every bit
	mut bf2 := bitfield.from_str('011010')
	println('\nLogical operations on ${bf1.str()} and ${bf2.str()}:')

	and_result := bitfield.bf_and(bf1, bf2)
	or_result := bitfield.bf_or(bf1, bf2)
	xor_result := bitfield.bf_xor(bf1, bf2)
	not_result := bitfield.bf_not(bf1)

	println('  AND: ${and_result.str()}')
	println('  OR:  ${or_result.str()}')
	println('  XOR: ${xor_result.str()}')
	println('  NOT: ${not_result.str()}')
}
