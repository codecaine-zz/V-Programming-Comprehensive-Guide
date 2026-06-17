module main

// Speaker is an interface. Any struct that implements a `speak() string` method
// implicitly implements Speaker. There is no `implements` keyword.
interface Speaker {
	speak() string
}

struct Dog {
	name string
}

// speak implements Speaker for Dog
fn (d Dog) speak() string {
	return 'Woof! My name is ${d.name}.'
}

struct Cat {
	name string
}

// speak implements Speaker for Cat
fn (c Cat) speak() string {
	return 'Meow! My name is ${c.name}.'
}

// perform_speak accepts any type implementing the Speaker interface
fn perform_speak(s Speaker) {
	println(s.speak())
}

fn main() {
	d := Dog{
		name: 'Buddy'
	}
	c := Cat{
		name: 'Whiskers'
	}

	// 1. Passing structs directly to functions expecting an interface
	perform_speak(d)
	perform_speak(c)

	// 2. Creating an array of interfaces
	speakers := [Speaker(d), Speaker(c)]
	for speaker in speakers {
		println('From array: ${speaker.speak()}')
	}
}
