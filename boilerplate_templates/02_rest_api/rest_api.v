module main

import json
import os
import sync
import veb

// Item represents a data model in our API.
struct Item {
	id   int    @[json: 'id']
	name string @[json: 'name']
	done bool   @[json: 'done']
}

// App holds the global state of the application.
struct App {
mut:
	lock  sync.RwMutex
	items []Item
}

// Context wraps veb's request/response lifecycle.
struct Context {
	veb.Context
}

// 1. GET / - Simple text response index endpoint
fn (mut app App) index(mut ctx Context) veb.Result {
	return ctx.text('Welcome to the V REST API Boilerplate! Use /api/items to interact with the service.')
}

// 2. GET /api/items - Returns list of all items as JSON
@['/api/items'; get]
fn (mut app App) get_items(mut ctx Context) veb.Result {
	app.lock.@rlock()
	defer { app.lock.runlock() }
	return ctx.json(json.encode(app.items))
}

// 3. GET /api/items/:id - Returns a single item by id, or 404
@['/api/items/:id'; get]
fn (mut app App) get_item(mut ctx Context, id int) veb.Result {
	app.lock.@rlock()
	defer { app.lock.runlock() }
	for item in app.items {
		if item.id == id {
			return ctx.json(json.encode(item))
		}
	}
	ctx.res.set_status(.not_found)
	return ctx.json('{"error": "Item not found"}')
}

// 4. POST /api/items - Decodes JSON request body and adds a new item
@['/api/items'; post]
fn (mut app App) create_item(mut ctx Context) veb.Result {
	new_item := json.decode(Item, ctx.req.data) or {
		ctx.res.set_status(.bad_request)
		return ctx.json('{"error": "Invalid JSON format"}')
	}

	app.lock.@lock()
	defer { app.lock.unlock() }

	// Auto-increment ID based on length
	item_to_add := Item{
		id:   app.items.len + 1
		name: new_item.name
		done: new_item.done
	}

	app.items << item_to_add
	ctx.res.set_status(.created)
	return ctx.json(json.encode(item_to_add))
}

fn main() {
	// Initialize App with mock seed data
	mut app := &App{
		items: [
			Item{
				id:   1
				name: 'Learn V syntax'
				done: true
			},
			Item{
				id:   2
				name: 'Build a REST API in V'
				done: false
			},
		]
	}

	// Read port from environment variable or default to 8082 to avoid common conflicts on 8080
	port_env := os.getenv('PORT')
	port := if port_env != '' { port_env.int() } else { 8082 }

	println('Starting REST API server on http://localhost:${port}...')

	// Start veb web server
	veb.run[App, Context](mut app, port)
}
