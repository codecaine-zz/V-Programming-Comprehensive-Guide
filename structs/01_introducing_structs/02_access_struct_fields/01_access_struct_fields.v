struct Note {
	id      int
	message string
}

fn main() {
	n := Note{1, 'a simple struct demo'}
	println(n.message)
}
