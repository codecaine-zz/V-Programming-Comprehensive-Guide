module sqlite

import db.sqlite as dbsqlite

pub type DB = dbsqlite.DB

pub struct Note {
	id    int
	title string
	body  string
}

pub fn connect(path string) !DB {
	mut db := dbsqlite.connect(path)!
	db.exec('PRAGMA foreign_keys = ON;') or {
		return error('failed to enable foreign keys: ${err}')
	}
	return db
}

pub fn connect_in_memory() !DB {
	return connect(':memory:')
}

pub fn init_notes_table(mut db DB) ! {
	db.exec('CREATE TABLE IF NOT EXISTS notes (id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT NOT NULL, body TEXT NOT NULL);') or {
		return error('failed to create notes table: ${err}')
	}
}

pub fn create_note(mut db DB, title string, body string) !int {
	db.exec_param_many('INSERT INTO notes (title, body) VALUES (?, ?);', [title, body]) or {
		return error('failed to insert note: ${err}')
	}
	return db.last_id()
}

pub fn list_notes(mut db DB) ![]Note {
	rows := db.exec('SELECT id, title, body FROM notes ORDER BY id;') or {
		return error('failed to list notes: ${err}')
	}
	mut notes := []Note{}
	for row in rows {
		notes << Note{
			id:    row.vals[0].int()
			title: row.vals[1]
			body:  row.vals[2]
		}
	}
	return notes
}

pub fn update_note(mut db DB, id int, title string, body string) ! {
	db.exec_param_many('UPDATE notes SET title = ?, body = ? WHERE id = ?;', [title, body,
		id.str()]) or { return error('failed to update note: ${err}') }
}

pub fn delete_note(mut db DB, id int) ! {
	db.exec_param_many('DELETE FROM notes WHERE id = ?;', [id.str()]) or {
		return error('failed to delete note: ${err}')
	}
}
