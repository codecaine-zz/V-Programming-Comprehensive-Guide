module main

import simplegui

fn main() {
	// Create the window (it will auto-fit to the controls at startup)
	mut gui := simplegui.new_simple_window('Data Viewer Demo', 550, 600)
	gui.set_title('Database Query Explorer')

	gui.add_label('header', 'Search and Filter Registered Accounts')

	// Row 1: Search box and Filter Category Selector
	gui.begin_row('search_row')
		gui.add_label('lbl_query', 'Search Name:')
		gui.add_input('query', 'Ada')
		gui.add_label('lbl_role', 'Filter Role:')
		gui.add_mode_control('role_filter', 'Simple')
	gui.end_row()

	// Row 2: Search Button and Record Limit Slider
	gui.begin_row('buttons_row')
		gui.add_button('search_btn', 'Query Database')
		gui.add_slider('limit', 3)
	gui.end_row()

	// Results box (textarea)
	gui.add_label('lbl_results', 'Query Output Window:')
	gui.add_textarea('output', 'Click Query Database to pull data records...')

	// Connect event handlers
	gui.on_click('search_btn', fn (mut win &simplegui.SimpleWindow) {
		query := win.get_text('query').to_lower()
		role := win.get_text('role_filter')
		limit := win.get_value_int('limit')
		
		win.set_status('Running query for name: "${query}" in role: ${role}...')
		println('Executing SQL query: SELECT * FROM users WHERE name LIKE "%${query}%" LIMIT ${limit}')

		// Mocked database records
		all_records := [
			'ID: 101 | Name: Ada Lovelace | Role: Simple | Status: Active',
			'ID: 102 | Name: Alan Turing | Role: Advanced | Status: Active',
			'ID: 103 | Name: Grace Hopper | Role: Expert | Status: Active',
			'ID: 104 | Name: Claude Shannon | Role: Simple | Status: Inactive',
			'ID: 105 | Name: John von Neumann | Role: Advanced | Status: Active'
		]

		mut filtered := []string{}
		for record in all_records {
			if record.to_lower().contains(query) && record.contains(role) {
				filtered << record
			}
		}

		if filtered.len > limit {
			filtered = filtered[0..limit].clone()
		}

		if filtered.len == 0 {
			win.set_text('output', 'No matching records found for name: "${query}" with role: ${role}.')
			win.set_status('No records matched.')
		} else {
			display_text := 'Fetched ' + filtered.len.str() + ' records:\n\n' + filtered.join('\n')
			win.set_text('output', display_text)
			win.set_status('Fetched ' + filtered.len.str() + ' records successfully.')
		}
	})

	// Premium dark theme
	gui.set_background_color('#2A2D34')
	gui.set_font_color('white')
	gui.set_status('Database connection active')

	gui.run()
}
