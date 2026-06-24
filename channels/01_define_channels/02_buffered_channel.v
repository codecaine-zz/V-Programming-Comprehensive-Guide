module main

fn main() {
	// 1. Declare a buffered channel of type 'string' with a capacity of 2.
	// We specify capacity using the `cap` initialization field.
	bc := chan string{cap: 2}

	// 2. Query the capacity of the channel.
	// For buffered channels, this returns the size of the buffer.
	// The sending thread will NOT block when pushing items into the channel
	// until the buffer is completely full (in this case, containing 2 elements).
	println('Buffered channel capacity: ${bc.cap}') // Outputs: 2

	// 3. Print the type name of the channel.
	println('Type of channel: ${typeof(bc).name}') // Outputs: chan string
}
