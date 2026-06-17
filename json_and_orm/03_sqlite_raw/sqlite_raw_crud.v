module main

import db.sqlite

fn main() {
	// 1. Database Connection
	// Connects to a SQLite database. ':memory:' creates a temporary in-memory database.
	println('Connecting to database...')
	mut db := sqlite.connect(':memory:') or {
		println('Connection failed: ${err}')
		return
	}
	defer {
		db.close() or { println('Failed to close database: ${err}') }
		println('Database connection closed.')
	}

	// 2. Schema Creation (DDL)
	println('Creating "users" table...')
	db.exec('CREATE TABLE users (id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT NOT NULL, email TEXT UNIQUE, age INTEGER);') or {
		println('Table creation failed: ${err}')
		return
	}

	// 3. Create (Insert Records using Parameterized Queries)
	println('\n--- CREATE: Inserting records securely ---')
	
	// SAFE APPROACH: Use `exec_param_many` with '?' placeholders to prevent SQL Injection.
	// Parameters are passed as an array of strings: []string
	db.exec_param_many("INSERT INTO users (name, email, age) VALUES (?, ?, ?);", ['Alice', 'alice@example.com', '30']) or {
		println('Insert failed: ${err}')
	}
	db.exec_param_many("INSERT INTO users (name, email, age) VALUES (?, ?, ?);", ['Bob', 'bob@example.com', '25']) or {
		println('Insert failed: ${err}')
	}
	db.exec_param_many("INSERT INTO users (name, email, age) VALUES (?, ?, ?);", ['Charlie', 'charlie@example.com', '40']) or {
		println('Insert failed: ${err}')
	}

	println('Last inserted row ID: ${db.last_id()}')

	// 4. Read (Select Records using Parameterized Queries)
	println('\n--- READ: Querying records securely ---')
	
	// Querying with parameters: only retrieve users older than 20
	rows := db.exec_param_many('SELECT id, name, email, age FROM users WHERE age > ?;', ['20']) or {
		println('Select failed: ${err}')
		[]sqlite.Row{}
	}

	// Iterate and extract column values by index
	for row in rows {
		// Each sqlite.Row has two string arrays: `vals` (values) and `names` (column names)
		id := row.vals[0]
		name := row.vals[1]
		email := row.vals[2]
		age := row.vals[3]
		println('User [ID: ${id}] -> Name: ${name}, Email: ${email}, Age: ${age}')
	}

	// 5. Update (Modify Records using Parameterized Queries)
	println('\n--- UPDATE: Modifying Bob\'s email and age securely ---')
	db.exec_param_many("UPDATE users SET email = ?, age = ? WHERE name = ?;", ['bob_new@example.com', '26', 'Bob']) or {
		println('Update failed: ${err}')
	}

	// Verify update
	updated_rows := db.exec_param_many("SELECT email, age FROM users WHERE name = ?;", ['Bob']) or { []sqlite.Row{} }
	if updated_rows.len > 0 {
		println("Bob's new email: ${updated_rows[0].vals[0]}")
		println("Bob's new age:   ${updated_rows[0].vals[1]}")
	}

	// 6. Delete (Remove Records using Parameterized Queries)
	println('\n--- DELETE: Removing Charlie securely ---')
	db.exec_param_many("DELETE FROM users WHERE name = ?;", ['Charlie']) or {
		println('Delete failed: ${err}')
	}

	// Verify delete
	remaining_rows := db.exec('SELECT name FROM users;') or { []sqlite.Row{} }
	print('Remaining users: ')
	for row in remaining_rows {
		print('${row.vals[0]} ')
	}
	println('')

	// 7. Cleanup
	println('\nDropping "users" table...')
	db.exec('DROP TABLE users;') or {
		println('Drop table failed: ${err}')
	}
}
