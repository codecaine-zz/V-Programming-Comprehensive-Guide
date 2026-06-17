module main

import json
import veb

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
fn (mut app App) create(mut ctx Context) veb.Result {
	// malformed json
	n := json.decode(Note, ctx.req.data) or {
		ctx.res.set_status(.bad_request)
		return ctx.json(error_response(400, invalid_json))
	}

	// before we save, we must ensure the note's message is unique
	notes_found := sql app.db {
		select from Note where message == n.message
	} or {
		ctx.res.set_status(.internal_server_error)
		return ctx.json(error_response(500, err.msg()))
	}
	if notes_found.len > 0 {
		ctx.res.set_status(.bad_request)
		return ctx.json(error_response(400, unique_message))
	}

	// save to db
	sql app.db {
		insert n into Note
	} or {
		ctx.res.set_status(.internal_server_error)
		return ctx.json(error_response(500, err.msg()))
	}

	// retrieve the last id from the db to build full Note object
	new_id := app.db.last_id() as int

	// build new note object including the new_id and send it as JSON response
	note_created := Note{new_id, n.message, n.status}
	ctx.res.set_status(.created)
	ctx.res.header.add(.content_location, '/notes/${new_id}')
	return ctx.json(note_created.to_json())
}

@['/notes/:id'; get]
fn (mut app App) read(mut ctx Context, id int) veb.Result {
	n := sql app.db {
		select from Note where id == id
	} or {
		ctx.res.set_status(.internal_server_error)
		return ctx.json(error_response(500, err.msg()))
	}

	// check if note exists
	if n.len == 0 {
		ctx.res.set_status(.not_found)
		return ctx.json(error_response(400, note_not_found))
	}

	// found note, return it
	ret := json.encode(n[0])
	ctx.res.set_status(.ok)
	return ctx.json(ret)
}

@['/notes'; get]
fn (mut app App) read_all(mut ctx Context) veb.Result {
	n := sql app.db {
		select from Note
	} or {
		ctx.res.set_status(.internal_server_error)
		return ctx.json(error_response(500, err.msg()))
	}

	ret := json.encode(n)
	ctx.res.set_status(.ok)
	return ctx.json(ret)
}

@['/notes/:id'; put]
fn (mut app App) update(mut ctx Context, id int) veb.Result {
	// malformed json
	n := json.decode(Note, ctx.req.data) or {
		ctx.res.set_status(.bad_request)
		return ctx.json(error_response(400, invalid_json))
	}

	// check if note to be updated exists
	note_to_update := sql app.db {
		select from Note where id == id
	} or {
		ctx.res.set_status(.internal_server_error)
		return ctx.json(error_response(500, err.msg()))
	}

	if note_to_update.len == 0 {
		ctx.res.set_status(.not_found)
		return ctx.json(error_response(404, note_not_found))
	}

	// before update, we must ensure the note's message is unique
	// id != id for idempotency
	// message == n.message for unique check
	res := sql app.db {
		select from Note where message == n.message && id != id
	} or {
		ctx.res.set_status(.internal_server_error)
		return ctx.json(error_response(500, err.msg()))
	}

	if res.len > 0 {
		ctx.res.set_status(.bad_request)
		return ctx.json(error_response(400, unique_message))
	}

	// update the note
	sql app.db {
		update Note set message = n.message, status = n.status where id == id
	} or {
		ctx.res.set_status(.internal_server_error)
		return ctx.json(error_response(500, err.msg()))
	}

	// build the updated note using the :id and request body
	// instead of making one more db call
	updated_note := Note{id, n.message, n.status}

	ret := json.encode(updated_note)
	ctx.res.set_status(.ok)
	return ctx.json(ret)
}

@['/notes/:id'; delete]
fn (mut app App) delete(mut ctx Context, id int) veb.Result {
	sql app.db {
		delete from Note where id == id
	} or {
		ctx.res.set_status(.internal_server_error)
		return ctx.json(error_response(500, err.msg()))
	}
	ctx.res.set_status(.no_content)
	return ctx.ok('')
}
