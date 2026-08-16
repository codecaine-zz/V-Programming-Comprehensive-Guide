module main

import json2

struct NotesResponse {
	status  int
	message string
}

const invalid_json = 'Invalid JSON Payload'
const note_not_found = 'Note not found'
const unique_message = 'Please provide a unique message for Note'

fn error_response(status int, message string) string {
	er := NotesResponse{status, message}
	return json2.encode(er)
}
