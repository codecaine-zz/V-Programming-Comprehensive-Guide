module main

$if windows {
	#include "@VEXEROOT/thirdparty/stdatomic/win/atomic.h"
} $else {
	#include "@VEXEROOT/thirdparty/stdatomic/nix/atomic.h"
}

// declare the C functions we want to use
fn C.atomic_store_u32(&u32, u32)
fn C.atomic_load_u32(&u32) u32
fn C.atomic_compare_exchange_strong_u32(&u32, &u32, u32) bool

fn main() {
	// Ordinary local variable, treated as atomic by passing its reference
	mut atom := u32(0)

	// Initialize atomic variable
	unsafe {
		C.atomic_store_u32(&atom, 17)
		
		mut expected := u32(17)
		// Atomic CAS: if atom == expected, set atom to 23 and return true
		if C.atomic_compare_exchange_strong_u32(&atom, &expected, 23) {
			println('Exchange successful, atom is now 23')
		} else {
			println('Exchange failed, atom is ${C.atomic_load_u32(&atom)}')
		}
		
		println('Final value: ${C.atomic_load_u32(&atom)}')
	}
}
