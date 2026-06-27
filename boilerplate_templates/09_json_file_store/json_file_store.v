module main

import json
import os

struct TodoItem {
	id    int
	title string
mut:
	done bool
}

struct TodoStore {
mut:
	items []TodoItem
}

fn load_store(path string) TodoStore {
	if !os.exists(path) {
		return TodoStore{}
	}

	raw := os.read_file(path) or {
		eprintln('Could not read store: ${err}')
		return TodoStore{}
	}

	decoded := json.decode(TodoStore, raw) or {
		eprintln('Could not decode store: ${err}')
		return TodoStore{}
	}

	return decoded
}

fn save_store(path string, store TodoStore) {
	data := json.encode(store)
	os.write_file(path, data) or { eprintln('Could not save store: ${err}') }
}

fn add_item(mut store TodoStore, title string) TodoItem {
	item := TodoItem{
		id:    store.items.len + 1
		title: title
		done:  false
	}
	store.items << item
	return item
}

fn mark_done(mut store TodoStore, id int) bool {
	for i, item in store.items {
		if item.id == id {
			store.items[i].done = true
			return true
		}
	}
	return false
}

fn list_items(store TodoStore) {
	for item in store.items {
		status := if item.done { '[x]' } else { '[ ]' }
		println('${status} ${item.id}. ${item.title}')
	}
}

fn main() {
	println('=== V JSON File Store Boilerplate ===')

	store_path := 'todos.json'
	mut store := load_store(store_path)

	add_item(mut store, 'Write a V tutorial')
	add_item(mut store, 'Ship a new boilerplate example')

	println('Current todos:')
	list_items(store)

	if mark_done(mut store, 1) {
		println('Marked todo #1 as done.')
	} else {
		println('Todo #1 was not found.')
	}

	save_store(store_path, store)
	println('Saved todos to ${store_path}')
}
