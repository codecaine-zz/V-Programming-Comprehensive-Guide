module main

import datatypes

fn main() {
	// 1. Stack (LIFO - Last In First Out)
	println('=== Stack Demo ===')
	mut stack := datatypes.Stack[string]{}
	stack.push('first')
	stack.push('second')
	stack.push('third')
	println('Stack size: ${stack.len()}')
	println('Stack contents: ${stack.array()}')

	// peek() and pop() return Result (!T), so we handle with "or" block
	top := stack.peek() or { 'empty' }
	println('Peek top element: ${top}')

	for !stack.is_empty() {
		val := stack.pop() or { 'error' }
		println('Popped: ${val}')
	}

	// 2. Queue (FIFO - First In First Out)
	println('\n=== Queue Demo ===')
	mut queue := datatypes.Queue[int]{}
	queue.push(100)
	queue.push(200)
	queue.push(300)
	println('Queue size: ${queue.len()}')
	println('Queue contents: ${queue.array()}')

	// peek() and pop() return Result (!T)
	front := queue.peek() or { -1 }
	println('Peek front element: ${front}')

	for !queue.is_empty() {
		val := queue.pop() or { -1 }
		println('Dequeued: ${val}')
	}

	// 3. Set (Unique Elements)
	println('\n=== Set Demo ===')
	mut set_a := datatypes.Set[string]{}
	set_a.add_all(['apple', 'banana', 'cherry', 'apple']) // 'apple' is duplicate and ignored
	println('Set A elements: ${set_a.array()}')
	println('Set A size: ${set_a.size()}')
	println('Contains "banana": ${set_a.exists('banana')}')

	mut set_b := datatypes.Set[string]{}
	set_b.add_all(['cherry', 'date', 'elderberry'])
	println('Set B elements: ${set_b.array()}')

	// Union of Set A and Set B (note: 'union' is a V keyword, so we write '@union')
	union_set := set_a.@union(set_b)
	println('Union (A + B): ${union_set.array()}')

	// Intersection of Set A and Set B
	intersection_set := set_a.intersection(set_b)
	println('Intersection (A and B): ${intersection_set.array()}')

	// Difference of Set A and Set B (A - B)
	diff_set := set_a - set_b
	println('Difference (A - B): ${diff_set.array()}')
}
