module main

import db.sqlite

struct User {
	id    int
	name  string
	email string
	age   int
}

fn connect_db(path string) !sqlite.DB {
	return sqlite.connect(path)
}

fn init_schema(mut db sqlite.DB) ! {
	db.exec('CREATE TABLE IF NOT EXISTS users (id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT NOT NULL, email TEXT UNIQUE, age INTEGER);') or {
		return error('Could not create table: ${err}')
	}
}

fn reset_users(mut db sqlite.DB) ! {
	db.exec('DELETE FROM users;') or { return error('Could not clear users: ${err}') }
}

fn insert_user(mut db sqlite.DB, name string, email string, age int) !int {
	db.exec_param_many('INSERT INTO users (name, email, age) VALUES (?, ?, ?);', [
		name,
		email,
		age.str(),
	]) or { return error('Insert failed: ${err}') }
	return db.last_id()
}

fn fetch_users(mut db sqlite.DB) ![]User {
	rows := db.exec('SELECT id, name, email, age FROM users ORDER BY id;') or {
		return error('Select failed: ${err}')
	}
	mut users := []User{}
	for row in rows {
		users << User{
			id:    row.vals[0].int()
			name:  row.vals[1]
			email: row.vals[2]
			age:   row.vals[3].int()
		}
	}
	return users
}

// Reusable CRUD helpers for the SQLite boilerplate example.

fn main() {
	println('=== V SQLite CRUD Boilerplate ===')

	mut db := connect_db('demo.db') or {
		eprintln('${err}')
		return
	}
	defer {
		db.close() or { eprintln('Failed to close database: ${err}') }
	}

	init_schema(mut db) or {
		eprintln('${err}')
		return
	}

	reset_users(mut db) or {
		eprintln('${err}')
		return
	}

	user_id := insert_user(mut db, 'Ada', 'ada@example.com', 36) or {
		eprintln('${err}')
		return
	}
	println('Inserted user id: ${user_id}')

	users := fetch_users(mut db) or {
		eprintln('${err}')
		return
	}
	for user in users {
		println('User: ${user.id} ${user.name} (${user.email}, age ${user.age})')
	}
}
