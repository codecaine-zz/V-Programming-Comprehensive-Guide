module main

@[COLOR]
struct User {
	name string
	age  int
}

fn (u User) greet() string {
	return 'Hello ${u.name}'
}

fn main() {
	println('--- Struct Fields Reflection ---')
	$for field in User.fields {
		println('Field: ${field.name} | Typ: ${field.typ}')
	}
	println('\n--- Struct Attributes Reflection ---')
	$for attr in User.attributes {
		println('Attribute name: ${attr.name}')
	}
	println('\n--- Struct Methods Reflection ---')
	user := User{
		name: 'Alice'
		age:  30
	}
	$for m in User.methods {
		$if m.return_type is string {
			println(user.$method())
		}
	}
}
