module main

import datatypes

// This helper creates a stable hash value for the bloom filter demo.
fn hash_string(value string) u32 {
	mut hash := u32(2166136261)
	for ch in value {
		hash ^= u32(ch)
		hash *= 16777619
	}
	return hash
}

fn main() {
	println('=== datatypes collection demo ===')

	// BloomFilter is a probabilistic structure used to test membership quickly.
	println('\n--- BloomFilter ---')
	mut bloom := datatypes.new_bloom_filter[string](hash_string, 64, 3) or { panic(err) }
	bloom.add('apple')
	bloom.add('banana')
	bloom_exists_apple := bloom.exists('apple')
	println('bloom exists apple: ${bloom_exists_apple}')
	bloom_exists_cherry := bloom.exists('cherry')
	println('bloom exists cherry: ${bloom_exists_cherry}')

	mut bloom_fast := datatypes.new_bloom_filter[string](hash_string, 64, 3) or { panic(err) }
	bloom_fast.add('date')
	fast_exists_date := bloom_fast.exists('date')
	println('fast bloom exists date: ${fast_exists_date}')

	// The union and intersection methods combine two bloom filters.
	union_bloom := bloom.@union(bloom_fast) or { panic(err) }
	union_exists_banana := union_bloom.exists('banana')
	println('union bloom exists banana: ${union_exists_banana}')
	intersection_bloom := bloom.intersection(bloom_fast) or { panic(err) }
	intersection_exists_apple := intersection_bloom.exists('apple')
	println('intersection bloom exists apple: ${intersection_exists_apple}')

	// BSTree stores values in sorted order and supports tree traversal.
	println('\n--- BSTree ---')
	mut bst := datatypes.BSTree[int]{}
	bst_is_empty := bst.is_empty()
	println('empty before inserts: ${bst_is_empty}')
	bst.insert(10)
	bst.insert(5)
	bst.insert(15)
	bst.insert(12)
	bst_contains_12 := bst.contains(12)
	println('contains 12: ${bst_contains_12}')
	in_order := bst.in_order_traversal()
	println('in_order: ${in_order}')
	pre_order := bst.pre_order_traversal()
	println('pre_order: ${pre_order}')
	post_order := bst.post_order_traversal()
	println('post_order: ${post_order}')
	left_val := bst.to_left(10) or { -1 }
	println('left of 10: ${left_val}')
	right_val := bst.to_right(10) or { -1 }
	println('right of 10: ${right_val}')
	min_val := bst.min() or { -1 }
	println('min: ${min_val}')
	max_val := bst.max() or { -1 }
	println('max: ${max_val}')
	bst.remove(5)
	bst_contains_5_after_remove := bst.contains(5)
	println('contains 5 after remove: ${bst_contains_5_after_remove}')

	// DoublyLinkedList supports inserting and iterating from both ends.
	println('\n--- DoublyLinkedList ---')
	mut dll := datatypes.DoublyLinkedList[string]{}
	dll.push_back('one')
	dll.push_front('zero')
	dll.push_many(['two', 'three'], datatypes.Direction.back)
	dll_array := dll.array()
	println('dll array: ${dll_array}')
	dll_first := dll.first() or { 'none' }
	println('dll first: ${dll_first}')
	dll_last := dll.last() or { 'none' }
	println('dll last: ${dll_last}')
	dll_index_two := dll.index('two') or { -1 }
	println('dll index of two: ${dll_index_two}')
	dll.insert(2, 'inserted') or { panic(err) }
	dll_after_insert := dll.array()
	println('dll after insert: ${dll_after_insert}')
	dll.delete(1)
	dll_after_delete := dll.array()
	println('dll after delete: ${dll_after_delete}')
	dll_str := dll.str()
	println('dll str: ${dll_str}')
	dll_next := dll.next() or { 'none' }
	println('dll next: ${dll_next}')
	mut dll_iter := dll.iterator()
	for {
		if value := dll_iter.next() {
			println('dll iter: ${value}')
		} else {
			break
		}
	}
	mut dll_back_iter := dll.back_iterator()
	for {
		if value := dll_back_iter.next() {
			println('dll back iter: ${value}')
		} else {
			break
		}
	}
	dll_pop_front := dll.pop_front() or { 'none' }
	println('dll pop_front: ${dll_pop_front}')
	dll_pop_back := dll.pop_back() or { 'none' }
	println('dll pop_back: ${dll_pop_back}')
	dll_final := dll.array()
	println('dll final: ${dll_final}')

	// LinkedList shows a simple singly linked sequence with push/pop helpers.
	println('\n--- LinkedList ---')
	mut linked_list := datatypes.LinkedList[int]{}
	linked_list_is_empty := linked_list.is_empty()
	println('linked list empty: ${linked_list_is_empty}')
	linked_list.push(1)
	linked_list.push(2)
	linked_list.push_many([3, 4])
	linked_list.prepend(0)
	linked_list.insert(2, 5) or { panic(err) }
	linked_list_array := linked_list.array()
	println('linked list array: ${linked_list_array}')
	linked_list_first := linked_list.first() or { -1 }
	println('linked list first: ${linked_list_first}')
	linked_list_last := linked_list.last() or { -1 }
	println('linked list last: ${linked_list_last}')
	linked_list_index_3 := linked_list.index(3) or { -1 }
	println('linked list index 3: ${linked_list_index_3}')
	linked_list_str := linked_list.str()
	println('linked list str: ${linked_list_str}')
	linked_list_pop := linked_list.pop() or { -1 }
	println('linked list pop: ${linked_list_pop}')
	linked_list_shift := linked_list.shift() or { -1 }
	println('linked list shift: ${linked_list_shift}')
	linked_list_next := linked_list.next() or { -1 }
	println('linked list next: ${linked_list_next}')
	mut list_iter := linked_list.iterator()
	for {
		if value := list_iter.next() {
			println('linked list iter: ${value}')
		} else {
			break
		}
	}
	linked_list_len := linked_list.len()
	println('linked list len: ${linked_list_len}')

	// MinHeap keeps the smallest value at the front.
	println('\n--- MinHeap ---')
	mut heap := datatypes.MinHeap[int]{}
	heap.insert(8)
	heap.insert(3)
	heap.insert_many([5, 1, 7])
	heap_len := heap.len()
	println('heap len: ${heap_len}')
	heap_peek := heap.peek() or { -1 }
	println('heap peek: ${heap_peek}')
	heap_pop_1 := heap.pop() or { -1 }
	println('heap pop: ${heap_pop_1}')
	heap_pop_2 := heap.pop() or { -1 }
	println('heap pop: ${heap_pop_2}')

	// Queue shows FIFO behavior and the standard enqueue/dequeue helpers.
	println('\n--- Queue ---')
	mut queue := datatypes.Queue[int]{}
	queue_is_empty := queue.is_empty()
	println('queue empty: ${queue_is_empty}')
	queue.push(100)
	queue.push(200)
	queue.push(300)
	queue_len := queue.len()
	println('queue len: ${queue_len}')
	queue_array := queue.array()
	println('queue array: ${queue_array}')
	queue_peek := queue.peek() or { -1 }
	println('queue peek: ${queue_peek}')
	queue_last := queue.last() or { -1 }
	println('queue last: ${queue_last}')
	queue_index_2 := queue.index(2) or { -1 }
	println('queue index 2: ${queue_index_2}')
	queue_str := queue.str()
	println('queue str: ${queue_str}')
	queue_pop_1 := queue.pop() or { -1 }
	println('queue pop: ${queue_pop_1}')
	queue_pop_2 := queue.pop() or { -1 }
	println('queue pop: ${queue_pop_2}')

	// RingBuffer provides bounded storage with wraparound behavior.
	println('\n--- RingBuffer ---')
	mut rb := datatypes.new_ringbuffer[string](4)
	rb_is_empty := rb.is_empty()
	println('rb empty: ${rb_is_empty}')
	rb.push('first') or { panic(err) }
	rb.push('second') or { panic(err) }
	rb.push('third') or { panic(err) }
	rb_occupied := rb.occupied()
	println('rb occupied: ${rb_occupied}')
	rb_remaining := rb.remaining()
	println('rb remaining: ${rb_remaining}')
	rb_pop := rb.pop() or { 'empty' }
	println('rb pop: ${rb_pop}')
	rb_pop_many := rb.pop_many(2) or { []string{} }
	println('rb pop_many: ${rb_pop_many}')
	rb_is_full := rb.is_full()
	println('rb full: ${rb_is_full}')
	rb.clear()
	rb_after_clear := rb.is_empty()
	println('rb after clear: ${rb_after_clear}')

	// Set demonstrates unique values and set algebra operations.
	println('\n--- Set ---')
	mut set_a := datatypes.Set[string]{}
	set_a.add_all(['apple', 'banana', 'cherry', 'apple'])
	set_a_array := set_a.array()
	println('set_a: ${set_a_array}')
	set_a_size := set_a.size()
	println('set_a size: ${set_a_size}')
	set_a_contains_banana := set_a.exists('banana')
	println('contains banana: ${set_a_contains_banana}')
	set_a.remove('banana')
	set_a_after_remove := set_a.array()
	println('after remove: ${set_a_after_remove}')
	set_a_pick := set_a.pick() or { 'empty' }
	println('pick: ${set_a_pick}')
	set_a_rest := set_a.rest() or { []string{} }
	println('rest: ${set_a_rest}')
	set_a_pop := set_a.pop() or { 'empty' }
	println('pop: ${set_a_pop}')
	set_a_is_empty := set_a.is_empty()
	println('is_empty: ${set_a_is_empty}')
	set_a.clear()
	set_a_after_clear := set_a.is_empty()
	println('cleared: ${set_a_after_clear}')

	mut set_b := datatypes.Set[string]{}
	set_b.add_all(['apple', 'cherry'])
	mut set_c := datatypes.Set[string]{}
	set_c.add_all(['cherry', 'date'])
	union_set := set_b.@union(set_c).array()
	println('union: ${union_set}')
	intersection_set := set_b.intersection(set_c).array()
	println('intersection: ${intersection_set}')

	// Compute the difference manually to avoid V compiler/analyzer issues with generic operator overloading (-)
	mut diff_set := set_b.copy()
	for item in set_c.array() {
		diff_set.remove(item)
	}
	diff_array := diff_set.array()
	println('difference: ${diff_array}')

	is_subset := set_b.subset(set_c)
	println('subset: ${is_subset}')
	copied_set := set_b.copy().array()
	println('copy: ${copied_set}')

	// Stack demonstrates LIFO behavior with push/pop operations.
	println('\n--- Stack ---')
	mut stack := datatypes.Stack[string]{}
	stack_is_empty := stack.is_empty()
	println('stack empty: ${stack_is_empty}')
	stack.push('first')
	stack.push('second')
	stack.push('third')
	stack_len := stack.len()
	println('stack len: ${stack_len}')
	stack_array := stack.array()
	println('stack contents: ${stack_array}')
	stack_peek := stack.peek() or { 'empty' }
	println('stack peek: ${stack_peek}')
	stack_str := stack.str()
	println('stack str: ${stack_str}')
	stack_pop_1 := stack.pop() or { 'empty' }
	println('stack pop: ${stack_pop_1}')
	stack_pop_2 := stack.pop() or { 'empty' }
	println('stack pop: ${stack_pop_2}')
}
