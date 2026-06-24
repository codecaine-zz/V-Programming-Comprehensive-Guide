module main

import time

pub struct Note {
pub:
	id      int
	created time.Time = time.now()
pub mut:
	message string @[required]
	status  bool
	due     time.Time = time.now().add_days(1)
}

// 1. Define a Mutable Struct Method.
// To modify fields of a struct inside a method, the receiver must be marked mutable: `(mut n Note)`.
// Under the hood, this passes a pointer/mutable reference, allowing the method to update
// the original struct instance fields directly.
pub fn (mut n Note) mark_as_completed() {
	n.status = true
	println('Note [ID: ${n.id}] marked as completed.')
}

// 2. Define another Mutable Method to update the message.
pub fn (mut n Note) update_message(new_msg string) {
	if new_msg.len > 0 {
		n.message = new_msg
		println('Note [ID: ${n.id}] message updated to: "${new_msg}"')
	}
}

fn main() {
	// 3. Instantiate a mutable struct instance.
	// To call mutable methods on a struct, the variable MUST be declared as mutable (`mut`).
	// If `n` was immutable, calling `n.mark_as_completed()` would result in a compilation error.
	mut n := Note{
		id:      42
		message: 'Learn V programming'
		status:  false
	}

	println('Initial state - Message: "${n.message}", Completed: ${n.status}')

	// 4. Call the mutable methods.
	n.update_message('Master V programming and C interop!')
	n.mark_as_completed()

	// 5. Verify the updates.
	println('Final state - Message: "${n.message}", Completed: ${n.status}')
	assert n.status == true
}
