module main

import json
import vweb

@[table: 'Notes']
struct Note {
	id      int    @[primary; sql: serial]
	message string @[sql: 'detail'; unique]
	status  bool
}

fn (n Note) to_json() string {
	return json.encode(n)
}

@['/notes'; post]
fn (mut app App) create() vweb.Result {
	// malformed json
	n := json.decode(Note, app.req.data) or {
		app.set_status(400, 'Bad Request')
		return app.json(error_response(400, invalid_json))
	}

	// before we save, we must ensure the note's message is unique
	notes_found := sql app.db {
		select from Note where message == n.message
	} or {
		app.set_status(500, 'Internal Server Error')
		return app.json(error_response(500, err.msg()))
	}
	if notes_found.len > 0 {
		app.set_status(400, 'Bad Request')
		return app.json(error_response(400, unique_message))
	}

	// save to db
	sql app.db {
		insert n into Note
	} or {
		app.set_status(500, 'Internal Server Error')
		return app.json(error_response(500, err.msg()))
	}

	// retrieve the last id from the db to build full Note object
	new_id := app.db.last_id() as int

	// build new note object including the new_id and send it as JSON response
	note_created := Note{new_id, n.message, n.status}
	app.set_status(201, 'created')
	app.add_header('Content-Location', '/notes/$new_id')
	return app.json(note_created.to_json())
}

@['/notes/:id'; get]
fn (mut app App) read(id int) vweb.Result {
	n := sql app.db {
		select from Note where id == id
	} or {
		app.set_status(500, 'Internal Server Error')
		return app.json(error_response(500, err.msg()))
	}

	// check if note exists
	if n.len == 0 {
		app.set_status(404, 'Not Found')
		return app.json(error_response(400, note_not_found))
	}

	// found note, return it
	ret := json.encode(n[0])
	app.set_status(200, 'OK')
	return app.json(ret)
}

@['/notes/'; get]
fn (mut app App) read_all() vweb.Result {
	n := sql app.db {
		select from Note
	} or {
		app.set_status(500, 'Internal Server Error')
		return app.json(error_response(500, err.msg()))
	}

	ret := json.encode(n)
	app.set_status(200, 'OK')
	return app.json(ret)
}

@['/notes/:id'; put]
fn (mut app App) update(id int) vweb.Result {
	// malformed json
	n := json.decode(Note, app.req.data) or {
		app.set_status(400, 'Bad Request')
		return app.json(error_response(400, invalid_json))
	}

	// check if note to be updated exists
	note_to_update := sql app.db {
		select from Note where id == id
	} or {
		app.set_status(500, 'Internal Server Error')
		return app.json(error_response(500, err.msg()))
	}

	if note_to_update.len == 0 {
		app.set_status(404, 'Not Found')
		return app.json(error_response(404, note_not_found))
	}

	// before update, we must ensure the note's message is unique
	// id != id for idempotency
	// message == n.message for unique check
	res := sql app.db {
		select from Note where message == n.message && id != id
	} or {
		app.set_status(500, 'Internal Server Error')
		return app.json(error_response(500, err.msg()))
	}

	if res.len > 0 {
		app.set_status(400, 'Bad Request')
		return app.json(error_response(400, unique_message))
	}

	// update the note
	sql app.db {
		update Note set message = n.message, status = n.status where id == id
	} or {
		app.set_status(500, 'Internal Server Error')
		return app.json(error_response(500, err.msg()))
	}

	// build the updated note using the :id and request body
	// instead of making one more db call
	updated_note := Note{id, n.message, n.status}

	ret := json.encode(updated_note)
	app.set_status(200, 'OK')
	return app.json(ret)
}

@['/notes/:id'; delete]
fn (mut app App) delete(id int) vweb.Result {
	sql app.db {
		delete from Note where id == id
	} or {
		app.set_status(500, 'Internal Server Error')
		return app.json(error_response(500, err.msg()))
	}
	app.set_status(204, 'No Content')
	return app.ok('')
}
