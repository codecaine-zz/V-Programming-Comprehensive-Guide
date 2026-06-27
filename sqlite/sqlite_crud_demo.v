module sqlite

pub fn run_demo() {
	mut db := connect_in_memory() or {
		eprintln('failed to connect to database: ${err}')
		return
	}

	init_notes_table(mut db) or {
		eprintln('failed to initialize notes table: ${err}')
		return
	}

	note_id := create_note(mut db, 'Demo note', 'Created by the runnable main function.') or {
		eprintln('failed to create note: ${err}')
		return
	}
	println('created note id: ${note_id}')

	notes := list_notes(mut db) or {
		eprintln('failed to list notes: ${err}')
		return
	}
	println('notes after create: ${notes}')

	update_note(mut db, note_id, 'Updated demo note', 'This note was updated by the runnable main function.') or {
		eprintln('failed to update note: ${err}')
		return
	}

	delete_note(mut db, note_id) or {
		eprintln('failed to delete note: ${err}')
		return
	}

	remaining_notes := list_notes(mut db) or {
		eprintln('failed to list notes after delete: ${err}')
		return
	}
	println('notes after delete: ${remaining_notes}')
}
