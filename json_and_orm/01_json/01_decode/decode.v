import json2

struct Note {
	id      int
	message string
	status  bool
}

fn main() {
	// Decode a JSON payload into a struct instance.
	n := json2.decode[Note]('{"id":1,"message":"Plan a holiday","status":false}') or {
		panic('invalid json data')
	}

	// Print the type name and the decoded data for inspection.
	println(typeof(n).name) // Note
	println(n)
}
