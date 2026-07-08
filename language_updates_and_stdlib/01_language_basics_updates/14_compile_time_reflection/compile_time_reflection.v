module main

// Compile-time reflection lets your code inspect types (fields, methods,
// attributes) while the program is being compiled — not at runtime.
// The `$for` loop below is unrolled by the compiler, so there is zero
// runtime cost. This is how V's own json encoder/decoder works internally.
//
// Beginner tip: anything starting with `$` in V ($for, $if, $method)
// happens at compile time, not while your program runs.

// A custom attribute attached to the struct. Attributes are metadata that
// reflection code can read (e.g. an ORM could read a @[table: 'users'] tag).
@[COLOR]
struct User {
	name string
	age  int
}

// A regular method — we will discover and call it via reflection below.
fn (u User) greet() string {
	return 'Hello ${u.name}'
}

fn main() {
	println('--- Struct Fields Reflection ---')
	// Iterate over every field defined on User at compile time.
	// `field.name` is the field's name, `field.typ` is its type id.
	$for field in User.fields {
		println('Field: ${field.name} | Typ: ${field.typ}')
	}
	println('\n--- Struct Attributes Reflection ---')
	// Read the attributes (like @[COLOR]) placed above the struct.
	$for attr in User.attributes {
		println('Attribute name: ${attr.name}')
	}
	println('\n--- Struct Methods Reflection ---')
	user := User{
		name: 'Alice'
		age:  30
	}
	// Loop over User's methods and call every one that returns a string.
	// `user.$method()` dynamically invokes the method currently being visited.
	$for m in User.methods {
		$if m.return_type is string {
			println(user.$method())
		}
	}
}
