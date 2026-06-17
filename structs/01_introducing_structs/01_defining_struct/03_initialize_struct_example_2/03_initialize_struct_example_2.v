struct Note {
	id      int
	message string
}

fn main() {
	n := Note{
		message: 'a simple struct demo'
		id:      1
	}

	println(typeof(n).name)
	// Note
}
