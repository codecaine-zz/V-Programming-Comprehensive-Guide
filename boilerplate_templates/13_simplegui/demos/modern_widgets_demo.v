module main

import simplegui

fn main() {
	mut win := simplegui.new_simple_window('Modern Widgets Showcase', 780, 580)

	win.set_background_color('#1e1b4b') // Indigo background
		.set_font_color('white')
		.set_padding(20)
		.set_spacing(12)
		.set_title('macOS Rich Controls Showcase')

	win.add_heading('Interactive Rating & Combo Box Demo')

	win.add_label('lbl_combo', 'NSComboBox: Editable Dropdown (type or select):')
	
	// Create ComboBox with auto suggested items
	win.add_combo_box('fruit_combo', ['Apple', 'Banana', 'Cherry', 'Dates', 'Elderberry'], 'Banana')
		.onchange(fn (mut w simplegui.SimpleWindow, value string) {
			w.set_status('ComboBox val: ${value}')
		})

	win.add_label('lbl_rating', 'NSLevelIndicator: Interactive 5-Star Rating:')
	
	// Interactive Rating Stars (Style = 3, range = 0 to 5)
	win.add_rating('app_rating', 4)
		.onchange(fn (mut w simplegui.SimpleWindow, value string) {
			rating_val := w.get_value_int('app_rating')
			w.set_status('Rating changed to: ${rating_val} stars (${value})')
		})

	win.add_label('lbl_level', 'NSLevelIndicator: Discrete Level/Capacity Meter:')
	
	// Discrete Level Selector (Style = 2 is discrete, range = 0 to 10)
	win.add_level_indicator('battery_level', 2, 0, 10, 7)
		.onchange(fn (mut w simplegui.SimpleWindow, value string) {
			level_val := w.get_value_int('battery_level')
			w.set_status('Capacity level: ${level_val}/10 (${value})')
		})

	win.add_label('lbl_info', 'Values read back from V structure:')
	win.add_textarea('info_area', 'Change the values above to see dynamic updates here!')

	// Button row
	win.add_action_row({
		'Inspect States': fn (mut w simplegui.SimpleWindow) {
			combo_val := w.get_text('fruit_combo')
			rating_val := w.get_value_int('app_rating')
			lvl_val := w.get_value_int('battery_level')
			text := 'ComboBox value: ${combo_val}\nRating Stars: ${rating_val}/5\nLevel Capacity: ${lvl_val}/10'
			w.set_text('info_area', text)
			w.toast('Inspected current widget states successfully!')
		}
		'Reset Widgets': fn (mut w simplegui.SimpleWindow) {
			w.set_text('fruit_combo', 'Apple')
			w.set_value_int('app_rating', 2)
			w.set_value_int('battery_level', 4)
			w.set_text('info_area', 'Reset to initial values')
			w.set_status('Widgets reset successfully.')
		}
	})

	win.run()
}
