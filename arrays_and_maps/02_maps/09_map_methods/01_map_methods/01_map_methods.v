module main

fn main() {
	println('--- Map Built-in Methods ---')

	mut m := {
		'one': 1
		'two': 2
	}
	println('initial map: ${m}') // {"one": 1, "two": 2}

	// 1. keys()
	// Returns an array containing all keys in the map.
	println('keys: ${m.keys()}') // ["one", "two"]

	// 2. values()
	// Returns an array containing all values in the map.
	println('values: ${m.values()}') // [1, 2]

	// 3. clone()
	// Returns a deep copy of the map.
	mut m_clone := m.clone()
	println('clone: ${m_clone}') // {"one": 1, "two": 2}

	// 4. delete(key)
	// Removes a key-value pair from the map by key.
	m.delete('one')
	println('delete: ${m}') // {"two": 2}

	// 5. reserve(capacity)
	// Pre-allocates space for at least capacity elements in the map.
	m.reserve(10)
	println('reserve: reserved capacity successfully')

	// 6. clear()
	// Removes all key-value pairs from the map without deallocating data.
	m.clear()
	println('clear: len is ${m.len}') // 0

	// 7. move()
	// Moves the map contents to a new map variable and clears the original map to empty.
	mut m_move := {
		'three': 3
		'four':  4
	}
	moved := m_move.move()
	println('move (new map): ${moved}') // {"three": 3, "four": 4}
	println('move (original map): ${m_move}') // {}

	// 8. free() (unsafe)
	// Deallocates the map memory.
	mut m_free := {
		'temp': 100
	}
	unsafe {
		m_free.free()
	}
	println('free: map freed successfully')
}
