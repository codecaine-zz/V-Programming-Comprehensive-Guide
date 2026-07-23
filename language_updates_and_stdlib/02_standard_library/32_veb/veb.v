module main

import json
import net.http
import os
import sync
import time
import veb

// Task represents our data model stored in the JSON database.
struct Task {
mut:
	id        int    @[json: 'id']
	title     string @[json: 'title']
	details   string @[json: 'details']
	completed bool   @[json: 'completed']
}

// Database handles reading and writing tasks to a local JSON file.
struct Database {
mut:
	file_path string
	tasks     []Task
}

// load reads the JSON file from disk into memory. If the file does not exist, it initializes an empty slice.
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

// save serializes memory tasks back into the JSON file on disk.
fn (mut db Database) save() ! {
	encoded := json.encode_pretty(db.tasks)
	os.write_file(db.file_path, encoded)!
}

// App holds global web application state and the database access layer.
struct App {
mut:
	lock sync.RwMutex
	db   Database
}

// Context wraps veb's per-request context.
pub struct Context {
	veb.Context
}

// 1. GET / - Index welcome page
pub fn (app &App) index(mut ctx Context) veb.Result {
	return ctx.text('Welcome to veb CRUD API with JSON File DB!')
}

// 2. GET /api/tasks - Retrieve all tasks (READ)
@['/api/tasks'; get]
pub fn (mut app App) get_tasks(mut ctx Context) veb.Result {
	app.lock.@rlock()
	defer { app.lock.runlock() }
	return ctx.json(json.encode(app.db.tasks))
}

// 3. GET /api/tasks/:id - Retrieve a single task by ID (READ)
@['/api/tasks/:id'; get]
pub fn (mut app App) get_task_by_id(mut ctx Context, id int) veb.Result {
	app.lock.@rlock()
	defer { app.lock.runlock() }
	for task in app.db.tasks {
		if task.id == id {
			return ctx.json(json.encode(task))
		}
	}
	ctx.res.set_status(.not_found)
	return ctx.json('{"error": "Task not found"}')
}

// 4. POST /api/tasks - Create a new task (CREATE)
@['/api/tasks'; post]
pub fn (mut app App) create_task(mut ctx Context) veb.Result {
	payload := json.decode(Task, ctx.req.data) or {
		ctx.res.set_status(.bad_request)
		return ctx.json('{"error": "Invalid JSON payload"}')
	}

	app.lock.@lock()
	defer { app.lock.unlock() }

	mut max_id := 0
	for task in app.db.tasks {
		if task.id > max_id {
			max_id = task.id
		}
	}

	new_task := Task{
		id:        max_id + 1
		title:     payload.title
		details:   payload.details
		completed: payload.completed
	}

	app.db.tasks << new_task
	app.db.save() or {
		ctx.res.set_status(.internal_server_error)
		return ctx.json('{"error": "Failed to persist to JSON DB"}')
	}

	ctx.res.set_status(.created)
	return ctx.json(json.encode(new_task))
}

// 5. PUT /api/tasks/:id - Update an existing task (UPDATE)
@['/api/tasks/:id'; put]
pub fn (mut app App) update_task(mut ctx Context, id int) veb.Result {
	payload := json.decode(Task, ctx.req.data) or {
		ctx.res.set_status(.bad_request)
		return ctx.json('{"error": "Invalid JSON payload"}')
	}

	app.lock.@lock()
	defer { app.lock.unlock() }

	for i in 0 .. app.db.tasks.len {
		if app.db.tasks[i].id == id {
			if payload.title != '' {
				app.db.tasks[i].title = payload.title
			}
			if payload.details != '' {
				app.db.tasks[i].details = payload.details
			}
			app.db.tasks[i].completed = payload.completed

			app.db.save() or {
				ctx.res.set_status(.internal_server_error)
				return ctx.json('{"error": "Failed to persist to JSON DB"}')
			}

			return ctx.json(json.encode(app.db.tasks[i]))
		}
	}

	ctx.res.set_status(.not_found)
	return ctx.json('{"error": "Task not found"}')
}

// 6. DELETE /api/tasks/:id - Remove a task by ID (DELETE)
@['/api/tasks/:id'; delete]
pub fn (mut app App) delete_task(mut ctx Context, id int) veb.Result {
	app.lock.@lock()
	defer { app.lock.unlock() }

	mut found_index := -1
	for i, task in app.db.tasks {
		if task.id == id {
			found_index = i
			break
		}
	}

	if found_index >= 0 {
		app.db.tasks.delete(found_index)
		app.db.save() or {
			ctx.res.set_status(.internal_server_error)
			return ctx.json('{"error": "Failed to persist to JSON DB"}')
		}
		return ctx.json('{"message": "Task deleted successfully"}')
	}

	ctx.res.set_status(.not_found)
	return ctx.json('{"error": "Task not found"}')
}

fn main() {
	println('=== veb Web Framework Full CRUD Demo (JSON DB) ===')

	db_file := 'veb_tasks_db.json'
	defer {
		if os.exists(db_file) {
			os.rm(db_file) or {}
			println('Cleaned up temporary database file: ${db_file}')
		}
	}

	// Initialize database
	mut db := Database{ file_path: db_file }
	db.load() or {
		println('Warning: Could not load DB, starting fresh: ${err}')
	}

	mut app := &App{
		db: db
	}

	port := 30088

	// Run veb server in a background thread
	spawn fn [mut app, port] () {
		println('Starting veb server on http://localhost:${port}/...')
		veb.run[App, Context](mut app, port)
	}()

	// Give the server time to start up
	time.sleep(250 * time.millisecond)

	base_url := 'http://localhost:${port}'

	// --- Demonstration of HTTP Requests ---
	println('\n--- 1. GET / (Index Route) ---')
	resp_index := http.get('${base_url}/') or { panic(err) }
	println('Status: ${resp_index.status_code} | Body: ${resp_index.body}')

	println('\n--- 2. GET /api/tasks (Initial state) ---')
	resp_get_empty := http.get('${base_url}/api/tasks') or { panic(err) }
	println('Status: ${resp_get_empty.status_code} | Body: ${resp_get_empty.body}')

	println('\n--- 3. POST /api/tasks (Create Task 1) ---')
	task1_json := '{"title": "Learn V veb", "details": "Explore veb framework routes", "completed": false}'
	resp_post1 := http.post_json('${base_url}/api/tasks', task1_json) or { panic(err) }
	println('Status: ${resp_post1.status_code} | Body: ${resp_post1.body}')

	println('\n--- 4. POST /api/tasks (Create Task 2) ---')
	task2_json := '{"title": "Build CRUD API", "details": "Persist data into JSON database", "completed": false}'
	resp_post2 := http.post_json('${base_url}/api/tasks', task2_json) or { panic(err) }
	println('Status: ${resp_post2.status_code} | Body: ${resp_post2.body}')

	println('\n--- 5. GET /api/tasks (List all created tasks) ---')
	resp_get_all := http.get('${base_url}/api/tasks') or { panic(err) }
	println('Status: ${resp_get_all.status_code} | Body:\n${resp_get_all.body}')

	println('\n--- 6. GET /api/tasks/1 (Fetch single task by ID) ---')
	resp_get_1 := http.get('${base_url}/api/tasks/1') or { panic(err) }
	println('Status: ${resp_get_1.status_code} | Body: ${resp_get_1.body}')

	println('\n--- 7. PUT /api/tasks/1 (Update Task 1 to completed) ---')
	update_json := '{"title": "Learn V veb (Completed)", "completed": true}'
	resp_put := http.fetch(http.FetchConfig{
		url: '${base_url}/api/tasks/1'
		method: .put
		header: http.new_header(http.HeaderConfig{ key: .content_type, value: 'application/json' })
		data: update_json
	}) or { panic(err) }
	println('Status: ${resp_put.status_code} | Body: ${resp_put.body}')

	println('\n--- 8. DELETE /api/tasks/2 (Delete Task 2) ---')
	resp_del := http.fetch(http.FetchConfig{
		url: '${base_url}/api/tasks/2'
		method: .delete
	}) or { panic(err) }
	println('Status: ${resp_del.status_code} | Body: ${resp_del.body}')

	println('\n--- 9. GET /api/tasks (Verify final list after delete) ---')
	resp_final := http.get('${base_url}/api/tasks') or { panic(err) }
	println('Status: ${resp_final.status_code} | Body: ${resp_final.body}')

	println('\n--- 10. Check JSON File Content on Disk ---')
	if os.exists(db_file) {
		db_content := os.read_file(db_file) or { '' }
		println('JSON DB File (${db_file}) Content:\n${db_content}')
	}

	println('\nveb Full CRUD with JSON DB demo completed successfully!')
}
