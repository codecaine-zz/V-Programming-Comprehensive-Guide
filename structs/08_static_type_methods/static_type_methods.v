module main

struct User {
	name string
	age  int
}

// Defining a static type method on User
fn User.new(name string, age int) User {
	return User{
		name: name
		age:  age
	}
}

// Another static method
fn User.default_user() User {
	return User.new('Guest', 18)
}

fn main() {
	// Call static type methods using StructName.method_name()
	user1 := User.new('Bob', 25)
	user2 := User.default_user()

	println('User 1: ${user1.name}, Age: ${user1.age}')
	println('User 2: ${user2.name}, Age: ${user2.age}')
}
