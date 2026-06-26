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
	println('bloom exists apple: ${bloom.exists('apple')}')
	println('bloom exists cherry: ${bloom.exists('cherry')}')

	mut bloom_fast := datatypes.new_bloom_filter[string](hash_string, 64, 3) or { panic(err) }
	bloom_fast.add('date')
	println('fast bloom exists date: ${bloom_fast.exists('date')}')

	// The union and intersection methods combine two bloom filters.
	union_bloom := bloom.@union(bloom_fast) or { panic(err) }
	println('union bloom exists banana: ${union_bloom.exists('banana')}')
	intersection_bloom := bloom.intersection(bloom_fast) or { panic(err) }
	println('intersection bloom exists apple: ${intersection_bloom.exists('apple')}')

	// BSTree stores values in sorted order and supports tree traversal.
	println('\n--- BSTree ---')
	mut bst := datatypes.BSTree[int]{}
	println('empty before inserts: ${bst.is_empty()}')
	bst.insert(10)
	bst.insert(5)
	bst.insert(15)
	bst.insert(12)
	println('contains 12: ${bst.contains(12)}')
	println('in_order: ${bst.in_order_traversal()}')
	println('pre_order: ${bst.pre_order_traversal()}')
	println('post_order: ${bst.post_order_traversal()}')
	println('left of 10: ${bst.to_left(10) or { -1 }}')
	println('right of 10: ${bst.to_right(10) or { -1 }}')
	println('min: ${bst.min() or { -1 }}')
	println('max: ${bst.max() or { -1 }}')
	bst.remove(5)
	println('contains 5 after remove: ${bst.contains(5)}')

	// DoublyLinkedList supports inserting and iterating from both ends.
	println('\n--- DoublyLinkedList ---')
	mut dll := datatypes.DoublyLinkedList[string]{}
	dll.push_back('one')
	dll.push_front('zero')
	dll.push_many(['two', 'three'], datatypes.Direction.back)
	println('dll array: ${dll.array()}')
	println('dll first: ${dll.first() or { 'none' }}')
	println('dll last: ${dll.last() or { 'none' }}')
	println('dll index of two: ${dll.index('two') or { -1 }}')
	dll.insert(2, 'inserted') or { panic(err) }
	println('dll after insert: ${dll.array()}')
	dll.delete(1)
	println('dll after delete: ${dll.array()}')
	println('dll str: ${dll.str()}')
	println('dll next: ${dll.next() or { 'none' }}')
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
	println('dll pop_front: ${dll.pop_front() or { 'none' }}')
	println('dll pop_back: ${dll.pop_back() or { 'none' }}')
	println('dll final: ${dll.array()}')

	// LinkedList shows a simple singly linked sequence with push/pop helpers.
	println('\n--- LinkedList ---')
	mut linked_list := datatypes.LinkedList[int]{}
	println('linked list empty: ${linked_list.is_empty()}')
	linked_list.push(1)
	linked_list.push(2)
	linked_list.push_many([3, 4])
	linked_list.prepend(0)
	linked_list.insert(2, 5) or { panic(err) }
	println('linked list array: ${linked_list.array()}')
	println('linked list first: ${linked_list.first() or { -1 }}')
	println('linked list last: ${linked_list.last() or { -1 }}')
	println('linked list index 3: ${linked_list.index(3) or { -1 }}')
	println('linked list str: ${linked_list.str()}')
	println('linked list pop: ${linked_list.pop() or { -1 }}')
	println('linked list shift: ${linked_list.shift() or { -1 }}')
	println('linked list next: ${linked_list.next() or { -1 }}')
	mut list_iter := linked_list.iterator()
	for {
		if value := list_iter.next() {
			println('linked list iter: ${value}')
		} else {
			break
		}
	}
	println('linked list len: ${linked_list.len()}')

	// MinHeap keeps the smallest value at the front.
	println('\n--- MinHeap ---')
	mut heap := datatypes.MinHeap[int]{}
	heap.insert(8)
	heap.insert(3)
	heap.insert_many([5, 1, 7])
	println('heap len: ${heap.len()}')
	println('heap peek: ${heap.peek() or { -1 }}')
	println('heap pop: ${heap.pop() or { -1 }}')
	println('heap pop: ${heap.pop() or { -1 }}')

	// Queue shows FIFO behavior and the standard enqueue/dequeue helpers.
	println('\n--- Queue ---')
	mut queue := datatypes.Queue[int]{}
	println('queue empty: ${queue.is_empty()}')
	queue.push(100)
	queue.push(200)
	queue.push(300)
	println('queue len: ${queue.len()}')
	println('queue array: ${queue.array()}')
	println('queue peek: ${queue.peek() or { -1 }}')
	println('queue last: ${queue.last() or { -1 }}')
	println('queue index 2: ${queue.index(2) or { -1 }}')
	println('queue str: ${queue.str()}')
	println('queue pop: ${queue.pop() or { -1 }}')
	println('queue pop: ${queue.pop() or { -1 }}')

	// RingBuffer provides bounded storage with wraparound behavior.
	println('\n--- RingBuffer ---')
	mut rb := datatypes.new_ringbuffer[string](4)
	println('rb empty: ${rb.is_empty()}')
	rb.push('first') or { panic(err) }
	rb.push('second') or { panic(err) }
	rb.push('third') or { panic(err) }
	println('rb occupied: ${rb.occupied()}')
	println('rb remaining: ${rb.remaining()}')
	println('rb pop: ${rb.pop() or { 'empty' }}')
	println('rb pop_many: ${rb.pop_many(2) or { []string{} }}')
	println('rb full: ${rb.is_full()}')
	rb.clear()
	println('rb after clear: ${rb.is_empty()}')

	// Set demonstrates unique values and set algebra operations.
	println('\n--- Set ---')
	mut set_a := datatypes.Set[string]{}
	set_a.add_all(['apple', 'banana', 'cherry', 'apple'])
	println('set_a: ${set_a.array()}')
	println('set_a size: ${set_a.size()}')
	println('contains banana: ${set_a.exists('banana')}')
	set_a.remove('banana')
	println('after remove: ${set_a.array()}')
	println('pick: ${set_a.pick() or { 'empty' }}')
	println('rest: ${set_a.rest() or { []string{} }}')
	println('pop: ${set_a.pop() or { 'empty' }}')
	println('is_empty: ${set_a.is_empty()}')
	set_a.clear()
	println('cleared: ${set_a.is_empty()}')

	mut set_b := datatypes.Set[string]{}
	set_b.add_all(['apple', 'cherry'])
	mut set_c := datatypes.Set[string]{}
	set_c.add_all(['cherry', 'date'])
	println('union: ${set_b.@union(set_c).array()}')
	println('intersection: ${set_b.intersection(set_c).array()}')
	println('difference: ${(set_b - set_c).array()}')
	println('subset: ${set_b.subset(set_c)}')
	println('copy: ${set_b.copy().array()}')

	// Stack demonstrates LIFO behavior with push/pop operations.
	println('\n--- Stack ---')
	mut stack := datatypes.Stack[string]{}
	println('stack empty: ${stack.is_empty()}')
	stack.push('first')
	stack.push('second')
	stack.push('third')
	println('stack len: ${stack.len()}')
	println('stack contents: ${stack.array()}')
	println('stack peek: ${stack.peek() or { 'empty' }}')
	println('stack str: ${stack.str()}')
	println('stack pop: ${stack.pop() or { 'empty' }}')
	println('stack pop: ${stack.pop() or { 'empty' }}')
}
