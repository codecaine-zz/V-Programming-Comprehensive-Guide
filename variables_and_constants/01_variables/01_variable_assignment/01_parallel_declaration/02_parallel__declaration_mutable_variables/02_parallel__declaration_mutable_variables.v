fn main() {
	mut greeting, mut recipient := 'Hi', 'world'
	println('${greeting}, ${recipient}!')

	greeting, recipient = 'Hello', 'Ada'
	println('${greeting}, ${recipient}!')
}
