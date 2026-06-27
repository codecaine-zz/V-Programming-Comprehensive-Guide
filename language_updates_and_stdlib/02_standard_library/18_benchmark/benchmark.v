module main

import benchmark
import time

fn main() {
	println('=== benchmark Module Demo ===')

	// Example 1: Using benchmark.start() and measure()
	println('--- Simple Measurement ---')
	mut b := benchmark.start()

	// Simulate work chunk 1
	time.sleep(50 * time.millisecond)
	b.measure('Simulated task 1 (50ms sleep)')

	// Simulate work chunk 2
	time.sleep(100 * time.millisecond)
	b.measure('Simulated task 2 (100ms sleep)')

	// Example 2: Using structured new_benchmark()
	println('\n--- Structured Step-by-Step Benchmarking ---')
	mut bmark := benchmark.new_benchmark()

	// Step 1: Ok step
	bmark.step()
	time.sleep(30 * time.millisecond)
	bmark.ok()
	println(bmark.step_message('Step 1 (successful arithmetic)'))

	// Step 2: Failed step demo
	bmark.step()
	time.sleep(10 * time.millisecond)
	bmark.fail()
	println(bmark.step_message('Step 2 (simulated failure verification)'))

	// Finalize and print results summary
	bmark.stop()
	println(bmark.total_message('Final summary of execution stages'))
}
