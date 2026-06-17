fn greet_and_message_length(name string) (string, int) {
	mut greeting := 'Hello, ' + name + '!'
	return greeting, greeting.len
}

fn main() {
	i, j := greet_and_message_length('Navule')
	println(i)
	println(j)
}
