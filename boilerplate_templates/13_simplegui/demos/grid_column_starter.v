module main

import simplegui

fn main() {
	mut win := simplegui.new_simple_window('Row Grid Starter', 640, 320)
		.set_theme('dracula')
		.set_padding(20)

	win.add_heading('Database Lookup Filters')

	// Closure-based row helper aligns children side-by-side automatically
	win.row('filters_row', fn (mut w &simplegui.SimpleWindow) {
		w.add_label('', 'Category:')
		w.add_dropdown('category', ['Engineering', 'Marketing', 'Sales'], 'Engineering')
			.width(150)
			.onchange(on_filter_changed)

		w.add_label('', 'ID:')
		w.add_number('filter_id', 101)
			.width(80)
			.onchange(on_filter_changed)

		w.add_button('btn_search', 'Search')
			.onclick(on_search_clicked)
	})

	win.add_textarea('output', 'Search results will render here...')
		.height(120)

	win.run()
}

fn on_filter_changed(mut win &simplegui.SimpleWindow, value string) {
	category := win.get_text('category')
	id := win.get_value_int('filter_id')
	win.set_status('Active filter: Category=${category}, ID=${id}')
}

fn on_search_clicked(mut win &simplegui.SimpleWindow) {
	category := win.get_text('category')
	id := win.get_value_int('filter_id')

	win.set_text('output', 'Running database query...\nFetched records matching ${category} with minimum ID ${id}!')
	win.toast('Queries fetched successfully')
}
