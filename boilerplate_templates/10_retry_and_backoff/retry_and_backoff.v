module main

import os
import time
import rand

// RetryConfig configures the retry and backoff behavior.
struct RetryConfig {
	attempts      int           = 3
	initial_delay time.Duration = 100 * time.millisecond
	factor        f64           = 2.0
	max_delay     time.Duration = 3 * time.second
	jitter        bool          = true
}

// retry executes the operation `op` up to `cfg.attempts` times.
// It uses exponential backoff with optional random jitter.
fn retry[T](cfg RetryConfig, op fn () !T) !T {
	mut delay := cfg.initial_delay
	for attempt in 1 .. cfg.attempts + 1 {
		res := op() or {
			if attempt == cfg.attempts {
				return error('Operation failed after ${cfg.attempts} attempts. Last error: ${err}')
			}

			eprintln('Attempt ${attempt}/${cfg.attempts} failed: ${err}. Retrying in ${delay.milliseconds()}ms...')

			// Sleep with optional jitter to prevent thundering herd problems
			mut sleep_dur := delay
			if cfg.jitter {
				jitter_ms := rand.intn(100) or { 0 }
				sleep_dur += jitter_ms * time.millisecond
			}
			time.sleep(sleep_dur)

			// Increase the delay for the next attempt, up to max_delay
			delay = time.Duration(i64(f64(delay) * cfg.factor))
			if delay > cfg.max_delay {
				delay = cfg.max_delay
			}
			continue
		}
		return res
	}
	return error('Unreachable')
}

fn main() {
	println('=== V Retry & Backoff Boilerplate ===')

	// Create a dummy file to read successfully on the 3rd attempt
	file_path := 'temp_retry_demo.txt'
	defer {
		if os.exists(file_path) {
			os.rm(file_path) or {}
		}
	}

	// Spawn a thread to create the file after a short delay
	spawn fn [file_path] () {
		time.sleep(300 * time.millisecond)
		os.write_file(file_path, 'Success: Data retrieved from temporary file!') or {}
		println('[System] File created on disk.')
	}()

	// Define our retry configuration
	cfg := RetryConfig{
		attempts:      4
		initial_delay: 150 * time.millisecond
		factor:        1.5
		jitter:        true
	}

	// Define the retriable operation closure
	op := fn [file_path] () !string {
		if !os.exists(file_path) {
			return error('File does not exist yet')
		}
		return os.read_file(file_path)
	}

	// Run the retry loop
	println('Starting resilient file read operation...')
	content := retry[string](cfg, op) or {
		eprintln('Final failure: ${err}')
		return
	}

	println('\nOperation Succeeded!')
	println('Read content: "${content}"')
}
