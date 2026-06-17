module main

import json

struct NotesResponse {
	status  int
	message string
}

fn (c NotesResponse) to_json() string {
	return json.encode(c)
}

const (
	invalid_json   = 'Invalid JSON Payload'
	note_not_found = 'Note not found'
	unique_message = 'Please provide a unique message for Note'
)

fn error_response(status int, message string) string {
	er := NotesResponse{status, message}
	return er.to_json()
}
