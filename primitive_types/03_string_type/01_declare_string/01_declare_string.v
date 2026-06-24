module main

fn main() {
	greeting := 'hello'
	name := 'Ada'
	message := greeting + ', ' + name + '!'

	println(message)
	println('Length: ${message.len}')
	println('Type: ${typeof(message).name}')
}
