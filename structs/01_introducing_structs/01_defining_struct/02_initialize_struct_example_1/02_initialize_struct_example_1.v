struct Note {
	id      int
	message string
}

fn main() {
	note := Note{1, 'A simple struct demo'}

	println('ID: ${note.id}')
	println('Message: ${note.message}')
}
