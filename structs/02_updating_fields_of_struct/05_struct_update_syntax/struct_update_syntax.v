module main

struct User {
	name          string
	age           int
	is_registered bool
}

fn register(u User) User {
	// Returns a modified copy using the struct update syntax
	return User{
		...u
		is_registered: true
	}
}

fn main() {
	println('=== Struct Update Syntax ===')

	user1 := User{
		name: 'Ada'
		age:  36
	}

	user2 := register(user1)

	println('user1: ${user1}') // User{name: 'Ada', age: 36, is_registered: false}
	println('user2: ${user2}') // User{name: 'Ada', age: 36, is_registered: true}

	assert user1.is_registered == false
	assert user2.is_registered == true
	assert user2.name == 'Ada'
	assert user2.age == 36
}
