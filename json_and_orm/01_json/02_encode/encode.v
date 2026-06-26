import json

struct Note {
	id      int
	message string
	status  bool
}

fn main() {
	// Create a note object that will be converted to JSON.
	m := Note{
		id:      2
		message: 'Get groceries'
		status:  false
	}

	// Encode the struct to a compact JSON string.
	mut j := json.encode(m)
	println(j)

	// Encode the same object with pretty formatting for readability.
	j = json.encode_pretty(m)
	println(j)
}
