module main

import time

fn main() {
	// 1. Getting current local time
	now := time.now()
	println('Current local time: ${now}')
	println('Components -> Year: ${now.year}, Month: ${now.month}, Day: ${now.day}')

	// 2. Custom time formatting
	formatted := now.custom_format('YYYY-MM-DD HH:mm:ss')
	println('Custom formatted: ${formatted}')

	// 3. Time calculations (adding/subtracting durations)
	// V provides constants like time.hour, time.minute, time.second, etc.
	two_hours := 2 * time.hour
	future := now.add(two_hours)
	println('Time in 2 hours: ${future}')

	// 4. Measuring elapsed time using a Stopwatch
	println('Starting stopwatch...')
	mut sw := time.new_stopwatch()

	// Sleep for a short duration to simulate work
	time.sleep(150 * time.millisecond)

	elapsed := sw.elapsed()
	println('Elapsed time: ${elapsed.milliseconds()} ms')
}
