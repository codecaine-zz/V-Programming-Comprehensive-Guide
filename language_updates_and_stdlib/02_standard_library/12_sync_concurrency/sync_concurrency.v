module main

// The `sync` module provides the classic building blocks for coordinating
// concurrent work: WaitGroups (wait for tasks to finish) and Mutexes
// (protect shared data from simultaneous access).
//
// Beginner tips:
// - spawn/go starts a function on another thread; main() will NOT wait for
//   it unless you make it wait — that is what the WaitGroup is for.
// - Any data written by more than one thread needs protection (a mutex),
//   otherwise you get race conditions: unpredictable, corrupted results.
import sync
import time

// A worker that signals the WaitGroup when it finishes.
// `defer` guarantees wg.done() runs even if the worker returns early.
fn worker(id int, mut wg sync.WaitGroup) {
	defer {
		wg.done()
	}
	println('Worker ${id} starting...')
	time.sleep(50 * time.millisecond)
	println('Worker ${id} done!')
}

// A shared counter guarded by a mutex. Only one thread at a time may hold
// the lock, so increments can never interleave and lose updates.
struct SafeCounter {
mut:
	mu    sync.Mutex
	value int
}

fn (mut c SafeCounter) increment() {
	// `lock` is a V keyword, so the method is escaped as @lock().
	c.mu.@lock()
	c.value++
	c.mu.unlock()
}

fn main() {
	println('=== Sync & Concurrency Examples ===')

	// 1. WaitGroup: wait for multiple concurrent tasks.
	//    Pattern: add(1) before each spawn, done() inside each task,
	//    wait() blocks until the counter returns to zero.
	mut wg := sync.new_waitgroup()
	for i in 1 .. 4 {
		wg.add(1)
		go worker(i, mut wg)
	}
	wg.wait()
	println('All workers completed!')

	// 2. Mutex: protect shared state that several threads modify.
	println('\n=== Mutex Demo ===')
	mut counter := &SafeCounter{}
	mut wg2 := sync.new_waitgroup()
	for _ in 0 .. 4 {
		wg2.add(1)
		go fn (mut c SafeCounter, mut wg sync.WaitGroup) {
			defer {
				wg.done()
			}
			// Each thread increments 1000 times. Without the mutex, some
			// increments would be lost and the total would be < 4000.
			for _ in 0 .. 1000 {
				c.increment()
			}
		}(mut counter, mut wg2)
	}
	wg2.wait()
	println('Final counter value (expected 4000): ${counter.value}')
}
