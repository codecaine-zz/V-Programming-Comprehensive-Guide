module main

import rand

// 1. Define a shared struct type.
// Structs that are intended to be shared across multiple threads should be defined normally.
// Mutability of fields is indicated as usual (e.g., total and num_donors under mut:).
struct Fund {
	name   string
	target f32
mut:
	total      f32
	num_donors int
}

// 2. Define a method on a shared receiver.
// In V, a receiver can be marked as 'shared' to indicate that the struct instance
// passed to it will be accessed concurrently.
fn (shared f Fund) collect(amt f32) {
	// 3. Acquire a write lock.
	// The `lock` block ensures exclusive (read-write) access to the shared object 'f'.
	// Only one thread can execute within the lock block at a time. Other threads attempting
	// to lock 'f' will block until this block exits.
	lock f {
		if f.total < f.target {
			f.num_donors += 1
			f.total += amt
			// We can safely read and write to the struct fields inside the lock block.
			println('${f.num_donors} \t before: ${f.total - amt} \t funds received: ${amt} \t total: ${f.total}')
		}
	}
}

// donation simulates generating a random donation amount.
fn donation() f32 {
	// rand.f32_in_range returns a result/option type, so we use `or` to handle default.
	return rand.f32_in_range(100.00, 250.00) or { 100.00 }
}

fn main() {
	// 4. Declare a shared variable.
	// The `shared` keyword before the variable name makes it a shared object.
	// Under the hood, V automatically associates a mutex with this object.
	shared fund := Fund{
		name:   'A noble cause'
		target: 1000.00
	}

	for {
		// 5. Acquire a read lock (rlock).
		// A read lock allows multiple threads to read the shared object concurrently
		// but prevents any thread from writing to it.
		rlock fund {
			if fund.total >= fund.target {
				break
			}
		}

		// 6. Spawn concurrent tasks.
		// The `go` keyword (interchangeable with `spawn`) starts a function in a new thread.
		// `go donation()` returns a thread handle `h`.
		h := go donation()

		// Spawning `fund.collect` concurrently and passing the result of `h.wait()`.
		// `h.wait()` blocks the main loop until the `donation()` thread finishes and returns its f32 value.
		go fund.collect(h.wait())
	}

	// 7. Final output with read lock.
	rlock fund {
		println('${fund.num_donors} donors donated for ${fund.name}')
		println('${fund.name} raised total fund amount: \$ ${fund.total}')
	}
}
