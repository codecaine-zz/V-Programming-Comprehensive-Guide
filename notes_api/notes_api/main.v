module main

import veb
import db.sqlite

struct App {
mut:
	db sqlite.DB
}

struct Context {
	veb.Context
}

fn main() {
	mut db := sqlite.connect('notes.db') or { panic(err) }
	defer {
		db.close() or {}
	}
	db.exec('drop table if exists Notes') or { panic(err) }
	sql db {
		create table Note
	} or { panic(err) }
	http_port := 8000
	mut app := &App{
		db: db
	}
	veb.run[App, Context](mut app, http_port)
}
