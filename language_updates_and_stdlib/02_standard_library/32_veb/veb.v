module main

import json
import net.http
import os
import sync
import time
import veb

// ============================================================================
// 1. DATA MODEL & VALIDATION
// ============================================================================

// Task represents a item in our system stored in a JSON file.
struct Task {
mut:
	id        int    @[json: 'id']
	title     string @[json: 'title']
	details   string @[json: 'details']
	completed bool   @[json: 'completed']
}

// validate checks that incoming task data meets our business rules.
fn (t Task) validate() ! {
	if t.title.trim_space() == '' {
		return error('Task title cannot be empty')
	}
}

// ============================================================================
// 2. DATABASE LAYER (JSON FILE PERSISTENCE)
// ============================================================================

struct Database {
mut:
	file_path string
	tasks     []Task
}

fn (mut db Database) load() ! {
	if !os.exists(db.file_path) {
		db.tasks = []Task{}
		return
	}
	content := os.read_file(db.file_path)!
	if content.trim_space() == '' {
		db.tasks = []Task{}
		return
	}
	db.tasks = json.decode([]Task, content)!
}

fn (mut db Database) save() ! {
	encoded := json.encode_pretty(db.tasks)
	os.write_file(db.file_path, encoded)!
}

// CRUD operations on the database
fn (db &Database) get_all() []Task {
	return db.tasks
}

fn (db &Database) get_by_id(id int) ?Task {
	for task in db.tasks {
		if task.id == id {
			return task
		}
	}
	return none
}

fn (mut db Database) add(new_task Task) !Task {
	new_task.validate()!
	mut max_id := 0
	for t in db.tasks {
		if t.id > max_id {
			max_id = t.id
		}
	}
	created := Task{
		id:        max_id + 1
		title:     new_task.title.trim_space()
		details:   new_task.details.trim_space()
		completed: new_task.completed
	}
	db.tasks << created
	db.save()!
	return created
}

fn (mut db Database) update(id int, update_data Task) !Task {
	update_data.validate()!
	for i in 0 .. db.tasks.len {
		if db.tasks[i].id == id {
			db.tasks[i].title = update_data.title.trim_space()
			db.tasks[i].details = update_data.details.trim_space()
			db.tasks[i].completed = update_data.completed
			db.save()!
			return db.tasks[i]
		}
	}
	return error('Task with ID ${id} not found')
}

fn (mut db Database) delete(id int) ! {
	for i, t in db.tasks {
		if t.id == id {
			db.tasks.delete(i)
			db.save()!
			return
		}
	}
	return error('Task with ID ${id} not found')
}

// ============================================================================
// 3. HTTP APP & CONTEXT DEFINITION
// ============================================================================

struct App {
mut:
	lock sync.RwMutex
	db   Database
}

pub struct Context {
	veb.Context
}

// ============================================================================
// 4. REQUEST & RESPONSE HELPERS (ABSTRACTION LAYER)
// ============================================================================

// parse_and_validate_task parses JSON request body and validates field constraints.
fn parse_and_validate_task(mut ctx Context) !Task {
	if ctx.req.data.trim_space() == '' {
		return error('Request body cannot be empty')
	}
	task := json.decode(Task, ctx.req.data) or {
		return error('Invalid JSON payload structure')
	}
	task.validate()!
	return task
}

// send_json encodes data as JSON and sets the HTTP status code.
fn send_json[T](mut ctx Context, data T, status http.Status) veb.Result {
	ctx.res.set_status(status)
	return ctx.json(json.encode(data))
}

// send_error sets an HTTP error status code and returns a JSON error response.
fn send_error(mut ctx Context, message string, status http.Status) veb.Result {
	ctx.res.set_status(status)
	return ctx.json('{"error": "${message}"}')
}

// send_message sets an HTTP status code and returns a success JSON message.
fn send_message(mut ctx Context, message string, status http.Status) veb.Result {
	ctx.res.set_status(status)
	return ctx.json('{"message": "${message}"}')
}

// ============================================================================
// 5. ROUTE HANDLERS (CLEAN & CONCISE)
// ============================================================================

// GET / - Index welcome page
pub fn (app &App) index(mut ctx Context) veb.Result {
	return ctx.text('Welcome to veb Clean CRUD API!')
}

// GET /api/tasks - Retrieve all tasks (READ)
@['/api/tasks'; get]
pub fn (mut app App) get_tasks(mut ctx Context) veb.Result {
	app.lock.@rlock()
	defer { app.lock.runlock() }
	return send_json(mut ctx, app.db.get_all(), .ok)
}

// GET /api/tasks/:id - Retrieve a task by ID (READ)
@['/api/tasks/:id'; get]
pub fn (mut app App) get_task_by_id(mut ctx Context, id int) veb.Result {
	app.lock.@rlock()
	defer { app.lock.runlock() }

	task := app.db.get_by_id(id) or {
		return send_error(mut ctx, 'Task not found', .not_found)
	}
	return send_json(mut ctx, task, .ok)
}

// POST /api/tasks - Create a new task (CREATE)
@['/api/tasks'; post]
pub fn (mut app App) create_task(mut ctx Context) veb.Result {
	payload := parse_and_validate_task(mut ctx) or {
		return send_error(mut ctx, err.msg(), .bad_request)
	}

	app.lock.@lock()
	defer { app.lock.unlock() }

	created := app.db.add(payload) or {
		return send_error(mut ctx, err.msg(), .internal_server_error)
	}
	return send_json(mut ctx, created, .created)
}

// PUT /api/tasks/:id - Update an existing task (UPDATE)
@['/api/tasks/:id'; put]
pub fn (mut app App) update_task(mut ctx Context, id int) veb.Result {
	payload := parse_and_validate_task(mut ctx) or {
		return send_error(mut ctx, err.msg(), .bad_request)
	}

	app.lock.@lock()
	defer { app.lock.unlock() }

	updated := app.db.update(id, payload) or {
		status := if err.msg().contains('not found') { http.Status.not_found } else { http.Status.internal_server_error }
		return send_error(mut ctx, err.msg(), status)
	}
	return send_json(mut ctx, updated, .ok)
}

// DELETE /api/tasks/:id - Delete a task by ID (DELETE)
@['/api/tasks/:id'; delete]
pub fn (mut app App) delete_task(mut ctx Context, id int) veb.Result {
	app.lock.@lock()
	defer { app.lock.unlock() }

	app.db.delete(id) or {
		return send_error(mut ctx, err.msg(), .not_found)
	}
	return send_message(mut ctx, 'Task deleted successfully', .ok)
}

// ============================================================================
// 6. MAIN DEMONSTRATION SUITE
// ============================================================================

fn main() {
	println('=== veb Web Framework Full CRUD Demo (Clean Abstractions) ===')

	db_file := 'veb_tasks_db.json'
	defer {
		if os.exists(db_file) {
			os.rm(db_file) or {}
			println('Cleaned up temporary database file: ${db_file}')
		}
	}

	mut db := Database{ file_path: db_file }
	db.load() or {}

	mut app := &App{ db: db }
	port := 30088

	// Start server in background thread
	spawn fn [mut app, port] () {
		println('Starting veb server on http://localhost:${port}/...')
		veb.run[App, Context](mut app, port)
	}()

	time.sleep(250 * time.millisecond)
	base_url := 'http://localhost:${port}'

	println('\n--- 1. POST /api/tasks (Validation Failure Test) ---')
	invalid_json := '{"title": "   ", "details": "No title provided"}'
	resp_invalid := http.post_json('${base_url}/api/tasks', invalid_json) or { panic(err) }
	println('Status: ${resp_invalid.status_code} | Body: ${resp_invalid.body}')

	println('\n--- 2. POST /api/tasks (Create Task 1) ---')
	valid_json1 := '{"title": "Learn V veb Abstractions", "details": "Clean helper functions for CRUD", "completed": false}'
	resp_create1 := http.post_json('${base_url}/api/tasks', valid_json1) or { panic(err) }
	println('Status: ${resp_create1.status_code} | Body: ${resp_create1.body}')

	println('\n--- 3. POST /api/tasks (Create Task 2) ---')
	valid_json2 := '{"title": "Build Clean REST API", "details": "Abstracted validation and responses", "completed": false}'
	resp_create2 := http.post_json('${base_url}/api/tasks', valid_json2) or { panic(err) }
	println('Status: ${resp_create2.status_code} | Body: ${resp_create2.body}')

	println('\n--- 4. GET /api/tasks (List All Tasks) ---')
	resp_all := http.get('${base_url}/api/tasks') or { panic(err) }
	println('Status: ${resp_all.status_code} | Body:\n${resp_all.body}')

	println('\n--- 5. GET /api/tasks/1 (Fetch Task by ID) ---')
	resp_get := http.get('${base_url}/api/tasks/1') or { panic(err) }
	println('Status: ${resp_get.status_code} | Body: ${resp_get.body}')

	println('\n--- 6. PUT /api/tasks/1 (Update Task 1 to completed) ---')
	update_json := '{"title": "Learn V veb Abstractions (Completed)", "details": "Clean helper functions for CRUD", "completed": true}'
	resp_put := http.fetch(http.FetchConfig{
		url: '${base_url}/api/tasks/1'
		method: .put
		header: http.new_header(http.HeaderConfig{ key: .content_type, value: 'application/json' })
		data: update_json
	}) or { panic(err) }
	println('Status: ${resp_put.status_code} | Body: ${resp_put.body}')

	println('\n--- 7. DELETE /api/tasks/2 (Delete Task 2) ---')
	resp_del := http.fetch(http.FetchConfig{
		url: '${base_url}/api/tasks/2'
		method: .delete
	}) or { panic(err) }
	println('Status: ${resp_del.status_code} | Body: ${resp_del.body}')

	println('\n--- 8. GET /api/tasks (Final Task List) ---')
	resp_final := http.get('${base_url}/api/tasks') or { panic(err) }
	println('Status: ${resp_final.status_code} | Body: ${resp_final.body}')

	println('\n--- 9. Check JSON File Content on Disk ---')
	if os.exists(db_file) {
		db_content := os.read_file(db_file) or { '' }
		println('JSON DB File (${db_file}) Content:\n${db_content}')
	}

	println('\nveb Full CRUD with clean abstractions completed successfully!')
}
