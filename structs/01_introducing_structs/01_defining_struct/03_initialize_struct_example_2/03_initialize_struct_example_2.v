struct Note {
	id      int
	message string
}

fn main() {
	note := Note{
		message: 'A named-field struct demo'
		id:      2
	}

	println(typeof(note).name)
	println(note)
}
