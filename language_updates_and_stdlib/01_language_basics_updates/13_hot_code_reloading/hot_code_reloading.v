module main

import time

// Hot code reloading lets you edit a running program and see the change
// WITHOUT restarting it. This is great for tweaking game loops, UI drawing
// code, or any tight feedback loop.
//
// How to try it:
//   1. Run this file with:  v -live run hot_code_reloading.v
//   2. While it is running, edit the message inside print_message() and save.
//   3. The next loop iteration prints your new text — no restart needed.
//
// Only functions marked with @[live] are swapped at runtime; main() itself
// and the program's data keep running untouched.
@[live]
fn print_message() {
	println('Hello! Modify this message while the program is running under -live mode.')
}

fn main() {
	// Loop a few times so there is a window to edit the live function.
	// (In a real live-coding session you would usually loop forever.)
	for i in 0 .. 3 {
		print_message()
		time.sleep(100 * time.millisecond)
	}
}
