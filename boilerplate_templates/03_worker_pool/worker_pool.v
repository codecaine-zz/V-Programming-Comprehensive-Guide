module main

import time

// Task represents the unit of work to be processed.
struct Task {
	id   int
	data string
}

// Result represents the outcome of processing a Task.
struct Result {
	task_id   int
	worker_id int
	output    string
	duration  time.Duration
}

// worker runs in a separate thread, consuming from tasks_chan and producing to results_chan.
fn worker(id int, tasks_chan chan Task, results_chan chan Result) {
	for {
		// Receive a task from the channel.
		// If the channel is closed and empty, it returns `none` (the channel option propagates as an error or closes).
		t := <-tasks_chan or {
			break
		}

		start_time := time.now()

		// Simulate intensive processing/I/O task
		time.sleep(50 * time.millisecond)

		elapsed := time.since(start_time)

		// Send the result to the output channel
		results_chan <- Result{
			task_id: t.id
			worker_id: id
			output: 'Processed: ' + t.data.to_upper()
			duration: elapsed
		}
	}
}

fn main() {
	println('=== V Worker Pool Concurrency Boilerplate ===')

	// 1. Create channels for tasks and results with capacities
	tasks_chan := chan Task{cap: 10}
	results_chan := chan Result{cap: 10}

	num_workers := 3
	num_tasks := 5

	// 2. Spawn concurrent worker threads
	println('Spawning ${num_workers} workers...')
	for i in 0 .. num_workers {
		spawn worker(i + 1, tasks_chan, results_chan)
	}

	// 3. Dispatch tasks to the queue
	println('Dispatching ${num_tasks} tasks to worker pool...')
	for i in 0 .. num_tasks {
		tasks_chan <- Task{
			id: i + 1
			data: 'task-payload-${i + 1}'
		}
	}

	// 4. Close tasks channel to signal workers that no more work is coming
	tasks_chan.close()
	println('Tasks dispatched, queue closed. Collecting results...')

	// 5. Collect results from results channel
	mut results := []Result{}
	for _ in 0 .. num_tasks {
		res := <-results_chan or {
			eprintln('Error: Results channel closed prematurely')
			break
		}
		results << res
		println('Received: Task #${res.task_id} from Worker #${res.worker_id} (took ${res.duration.milliseconds()}ms)')
	}

	results_chan.close()

	// 6. Print summary
	println('\n=== Processing Summary ===')
	for res in results {
		println('- Task #${res.task_id} -> ${res.output} (Worker #${res.worker_id})')
	}
}
