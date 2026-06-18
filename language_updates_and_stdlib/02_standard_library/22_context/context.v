module main

import context
import time

fn main() {
	println('=== context Module Demo ===')

	// 1. Context with Value
	// Useful for passing metadata (e.g. Request ID) through call chains
	mut ctx_bg := context.background()
	mut ctx_val := context.with_value(ctx_bg, 'request_id', 'REQ-101')

	if req_id := ctx_val.value('request_id') {
		if req_id is string {
			println('Request ID in context: ${req_id}')
		}
	}

	// 2. Context with Cancellation
	mut ctx_cancel, cancel := context.with_cancel(mut ctx_val)
	
	// Check if canceled
	println('Before cancel - Done channel is open')
	cancel() // trigger cancellation
	
	// Select block to read from done channel
	done_ch := ctx_cancel.done()
	select {
		_ := <-done_ch {
			println('Context cancellation detected successfully!')
		}
		1 * time.second {
			println('Timeout waiting for cancellation.')
		}
	}

	// 3. Context with Timeout
	// Abandon execution after a duration
	mut ctx_timeout, cancel_timeout := context.with_timeout(mut ctx_bg, 50 * time.millisecond)
	defer {
		cancel_timeout()
	}

	println('Waiting for context timeout (50ms)...')
	start := time.now()
	timeout_ch := ctx_timeout.done()
	select {
		_ := <-timeout_ch {
			elapsed := time.since(start)
			println('Timeout triggered after ${elapsed.milliseconds()} ms!')
		}
		1 * time.second {
			println('Error: Timeout did not trigger in time.')
		}
	}
}
