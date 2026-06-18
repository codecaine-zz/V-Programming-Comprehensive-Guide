module main

import db.sqlite

@[table: 'Notes']
struct Note {
	id      int    @[primary; sql: serial]
	message string @[sql: 'detail'; unique]
	status  bool
}

fn main() {
	// Establishing a connection to the database

	mut db := sqlite.connect('NotesDB.db') or { panic(err) }
	defer {
		db.close() or {}
	}
	db.exec('drop table if exists Notes') or { panic(err) }

	// Creating a table
	sql db {
		create table Note
	} or { panic(err) }

	// Inserting record(s)
	n1 := Note{
		message: 'Get some milk'
		status: false
	}

	n2 := Note{
		message: 'Get groceries'
		status: false
	}
	sql db {
		insert n1 into Note
		insert n2 into Note
	} or { panic(err) }

	println(db.last_id() as int)

	// Select records
	all_notes := sql db {
		select from Note
	} or { panic(err) }

	println(all_notes)
	println('Type of all_notes is : ${typeof(all_notes).name}')

	// Select using order by clause
	notes_sorted := sql db {
		select from Note order by id desc
	} or { panic(err) }
	println(notes_sorted)

	// Select using the limit clause
	notes_limited := sql db {
		select from Note order by id desc limit 1
	} or { panic(err) }

	println(notes_limited)
	println('Type returned by select when limit is 1:  ${typeof(notes_limited).name}')

	// Select using where clause
	notes_latest := sql db {
		select from Note where id > 1
	} or { panic(err) }

	println(notes_latest)

	// Update record(s)
	sql db {
		update Note set status = true where id == 2
	} or { panic(err) }

	notes_updated := sql db {
		select from Note where id == 2
	} or { panic(err) }
	println(notes_updated)

	// Delete record(s)
	sql db {
		delete from Note where id == 2
	} or { panic(err) }

	notes_leftover := sql db {
		select from Note
	} or { panic(err) }
	println(notes_leftover)

	sql db {
		drop table Note
	} or { panic(err) }
	println('Dropped the Note table from database!')
}
