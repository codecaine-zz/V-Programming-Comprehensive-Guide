module main

fn main() {
	// 1. Declare an unbuffered channel of type 'int'.
	// In V, channels are declared using the `chan` keyword followed by the type.
	// An empty initializer `{}` defaults the capacity (`cap`) to 0.
	uc := chan int{}

	// 2. Query the capacity of the channel.
	// For unbuffered channels, the capacity is always 0.
	// This means any send operation (pushing data) will block the sending thread
	// until another thread is actively reading (popping data) from the channel.
	println('Unbuffered channel capacity: ${uc.cap}') // Outputs: 0

	// 3. Print the type name of the channel.
	// V's `typeof().name` provides runtime type reflection names.
	println('Type of channel: ${typeof(uc).name}') // Outputs: chan int
}
