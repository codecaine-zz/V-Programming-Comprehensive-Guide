module main

import sync
import time

fn worker(id int, mut wg sync.WaitGroup) {
	defer {
		wg.done()
	}
	println('Worker ${id} starting...')
	time.sleep(50 * time.millisecond)
	println('Worker ${id} done!')
}

fn main() {
	println('=== Sync & Concurrency Examples ===')

	// 1. WaitGroup (Wait for multiple goroutines/tasks)
	mut wg := sync.new_waitgroup()
	for i in 1 .. 4 {
		wg.add(1)
		go worker(i, mut wg)
	}
	wg.wait()
	println('All workers completed!')

	// 2. Mutex (Thread-safe shared state access)
	println('\n=== Mutex Demo ===')
	mut mu := sync.new_mutex()
	mu.@lock()
	println('Mutex locked')
	mu.unlock()
	println('Mutex unlocked')
}
