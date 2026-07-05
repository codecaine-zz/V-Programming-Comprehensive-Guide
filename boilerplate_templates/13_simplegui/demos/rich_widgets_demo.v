module main

import simplegui

fn main() {
	mut win := simplegui.new_simple_window('macOS Rich Controls Suite', 800, 680)

	win.set_background_color('#0b0f19') // Modern Slate/Navy
		.set_font_color('white')
		.set_padding(20)
		.set_spacing(10)
		.set_title('macOS Standard & Custom Widgets')

	win.add_heading('macOS Advanced Components & Indicators')

	// 1. Path Control
	win.add_label('lbl_path', 'NSPathControl (Native OS Path Breadcrumbs - Drag files / click / change):')
	win.add_path_control('file_path', '/Users/developer/Projects/vlang_simplegui/simplegui/window.m')
		.onchange(fn (mut w simplegui.SimpleWindow, value string) {
			w.set_status('Path Changed: ${value}')
			w.set_text('report_area', 'Updated Path URL:\n${value}')
		})

	// 2. Token Field
	win.add_label('lbl_tokens', 'NSTokenField (Enter tags/chips separated by commas):')
	win.add_token_field('tags_input', 'swift,vlang,cocoa,ui,native')
		.onchange(fn (mut w simplegui.SimpleWindow, value string) {
			w.set_status('Tags Updated: ${value}')
		})

	win.begin_row('widgets_row')
		// 3. ComboBox
		win.begin_row('combo_col')
			win.add_label('lbl_combo', 'NSComboBox:')
			win.add_combo_box('fruit_selection', ['Apple', 'Banana', 'Cherry', 'Durian'], 'Cherry')
				.width(160)
				.onchange(fn (mut w simplegui.SimpleWindow, value string) {
					w.set_status('Selected Fruit: ${value}')
				})
		win.end_row()

		// 4. Rating Stars
		win.begin_row('rating_col')
			win.add_label('lbl_rating', 'Rating Stars:')
			win.add_rating('star_rating', 4)
				.onchange(fn (mut w simplegui.SimpleWindow, value string) {
					w.set_status('Star level: ${value}/5')
				})
		win.end_row()
	win.end_row()

	win.begin_row('more_widgets_row')
		// 5. Level Indicator
		win.begin_row('level_col')
			win.add_label('lbl_level', 'Discrete Level Gauge:')
			win.add_level_indicator('discrete_level', 2, 0, 10, 6)
				.width(160)
				.onchange(fn (mut w simplegui.SimpleWindow, value string) {
					w.set_status('Gauge level: ${value}/10')
				})
		win.end_row()

		// 6. Loading Activity Spinner
		win.begin_row('spinner_col')
			win.add_label('lbl_spin', 'Activity Spinner:')
			win.add_spinner('loading_spinner', true)
				.width(32)
		win.end_row()
	win.end_row()

	// Control Row for Spinner
	win.begin_row('controls_row')
		win.add_checkbox('toggle_spinning', 'Running spinner thread animation', true)
			.onchange(fn (mut w simplegui.SimpleWindow, value string) {
				is_running := w.get_checked('toggle_spinning')
				w.set_bool('loading_spinner', is_running)
				if is_running {
					w.set_status('Spinner animation active')
				} else {
					w.set_status('Spinner animation stopped (control hidden)')
				}
			})
	win.end_row()

	win.add_separator()

	// Text reports
	win.add_label('lbl_report', 'States Inspector:')
	win.add_textarea('report_area', 'Inspect or manipulate states below!')

	// Button row
	win.add_action_row({
		'Audit Controls': fn (mut w simplegui.SimpleWindow) {
			path := w.get_text('file_path')
			tags := w.get_text('tags_input')
			fruit := w.get_text('fruit_selection')
			rating := w.get_value_int('star_rating')
			lvl := w.get_value_int('discrete_level')
			spinner_active := w.get_bool('loading_spinner')
			
			summary := 'Path Control: ${path}\nTags (Tokens): ${tags}\nCombo Box: ${fruit}\nLevel Indicator: ${lvl}/10\nRating Star: ${rating}/5 stars\nSpinner Animating: ${spinner_active}'
			w.set_text('report_area', summary)
			w.toast('Fetched all rich control values successfully!')
		}
		'Restore Defaults': fn (mut w simplegui.SimpleWindow) {
			w.set_text('file_path', '/Users/developer/Projects/vlang_simplegui/simplegui/window.m')
			w.set_text('tags_input', 'swift,vlang,cocoa,ui,native')
			w.set_text('fruit_selection', 'Cherry')
			w.set_value_int('star_rating', 4)
			w.set_value_int('discrete_level', 6)
			w.set_checked('toggle_spinning', true)
			w.set_bool('loading_spinner', true)
			w.set_text('report_area', 'Restored back to base defaults!')
			w.set_status('Defaults restored successfully.')
		}
	})

	win.run()
}
