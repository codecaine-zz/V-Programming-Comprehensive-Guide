import json

struct Note {
	id      int
	message string
	status  bool
}

fn main() {
	// Decode a JSON payload into a struct instance.
	n := json.decode(Note, '{"id":1,"message":"Plan a holiday","status":false}') or {
		panic('invalid json data')
	}

	// Print the type name and the decoded data for inspection.
	println(typeof(n).name) // Note
	println(n)
}
