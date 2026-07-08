module main

// Atomics are special CPU operations that read/modify/write a value as one
// indivisible step. When multiple threads touch the same variable, ordinary
// reads and writes can interleave and corrupt data — atomics prevent that
// without needing a full mutex.
//
// Beginner guidance:
// - For most programs, prefer channels or sync.Mutex; they are easier to
//   reason about. Atomics are the low-level tool for counters and flags.
// - V exposes atomics via its bundled C stdatomic headers, so the calls
//   below are C functions (prefixed with C.) and must run inside `unsafe`.

// Pick the correct bundled atomic header for the current OS at compile time.
$if windows {
	#include "@VEXEROOT/thirdparty/stdatomic/win/atomic.h"
} $else {
	#include "@VEXEROOT/thirdparty/stdatomic/nix/atomic.h"
}

// Declare the C functions we want to use (V needs their signatures).
fn C.atomic_store_u32(&u32, u32)
fn C.atomic_load_u32(&u32) u32
fn C.atomic_compare_exchange_strong_u32(&u32, &u32, u32) bool

fn main() {
	// Ordinary local variable, treated as atomic by passing its reference.
	mut atom := u32(0)

	unsafe {
		// Atomically write 17 into atom.
		C.atomic_store_u32(&atom, 17)

		mut expected := u32(17)
		// Compare-And-Swap (CAS) — the building block of lock-free code:
		// "If atom still equals `expected`, replace it with 23 and return true.
		//  Otherwise leave it alone and return false."
		// This check-and-update happens as ONE atomic step, so no other
		// thread can sneak in between the comparison and the write.
		if C.atomic_compare_exchange_strong_u32(&atom, &expected, 23) {
			println('Exchange successful, atom is now 23')
		} else {
			println('Exchange failed, atom is ${C.atomic_load_u32(&atom)}')
		}

		// Atomic read — guaranteed not to observe a half-written value.
		println('Final value: ${C.atomic_load_u32(&atom)}')
	}
}
