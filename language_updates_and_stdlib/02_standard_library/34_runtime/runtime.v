module main

import runtime

fn main() {
	println('=== runtime Module Demo ===')

	// 1. CPU and job info
	cpus := runtime.nr_cpus()
	jobs := runtime.nr_jobs()
	println('CPU Cores:              ${cpus}')
	println('Concurrent Jobs (VJOBS): ${jobs}')

	// 2. System architecture details
	println('Is 64-bit architecture?  ${runtime.is_64bit()}')
	println('Is 32-bit architecture?  ${runtime.is_32bit()}')
	println('Is Little Endian?        ${runtime.is_little_endian()}')
	println('Is Big Endian?           ${runtime.is_big_endian()}')

	// 3. Memory statistics
	total_mem := runtime.total_memory() or { 0 }
	free_mem := runtime.free_memory() or { 0 }
	used_mem := runtime.used_memory() or { 0 }

	// Format to megabytes
	total_mb := total_mem / (1024 * 1024)
	free_mb := free_mem / (1024 * 1024)
	used_mb := used_mem / (1024 * 1024)

	println('\nPhysical Memory info:')
	println('  Total Memory: ${total_mb} MB')
	println('  Free Memory:  ${free_mb} MB')
	println('  Used (by App): ${used_mb} MB')
}
