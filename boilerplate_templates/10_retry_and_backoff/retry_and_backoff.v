module main

import os
import time

fn read_with_retry(path string, attempts int, delay time.Duration) !string {
	for attempt in 1 .. attempts + 1 {
		content := os.read_file(path) or {
			eprintln('Attempt ${attempt}/${attempts} failed: ${err}')
			if attempt < attempts {
				time.sleep(delay)
			}
			continue
		}
		return content
	}
	return error('Unable to read ${path} after ${attempts} attempts')
}

fn main() {
	println('=== V Retry & Backoff Boilerplate ===')

	path := 'missing.txt'
	content := read_with_retry(path, 3, 100 * time.millisecond) or {
		eprintln('Final failure: ${err}')
		return
	}

	println('Read content:')
	println(content)
}
