struct Note {
	id      int
	message string
}

fn main() {
	note := Note{
		id:      1
		message: 'A simple struct demo'
	}

	println(note)
}
