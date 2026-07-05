// Lightweight V demo for the Python-like control API.
module main

import simplegui

fn main() {
	// Create the window and give it a title.
	mut gui := simplegui.new_simple_window('V Native GUI Demo', 760, 950)
	gui.set_title('V Native GUI Demo')

	// Add the native controls. Each one gets a name so it can be found/updated from V.
	gui.add_label('intro', 'Create controls with one small call')
	
	// Row 1: Name and City inputs side-by-side with labels
	gui.begin_row('row_inputs')
		gui.add_label('lbl_name', 'Name:')
		gui.add_input('name', 'Ada')
		gui.add_label('lbl_city', 'City:')
		gui.add_input('city', 'London')
	gui.end_row()

	gui.add_textarea('notes', 'You can type here and read it back from V')

	// Row 2: Run and Clear buttons side-by-side
	gui.begin_row('row_buttons')
		gui.add_button('run', 'Run')
		gui.add_button('clear', 'Clear')
	gui.end_row()

	gui.add_checkbox('toggle', 'Enable advanced mode', false)
	gui.add_slider('slider', 5)
	gui.add_theme_menu('theme', 'Light')
	gui.add_number('number', 25)
	gui.add_color_well('color', '#0000FF')
	gui.add_date_picker('date', '2026-07-04')
	gui.add_mode_control('mode', 'Simple')
	gui.add_checkbox('ready', 'Accept terms and conditions', false)
	gui.add_progress_indicator('progress', 35)

	// Connect event handlers to functions.
	gui.on_change('city', on_city_changed)
	gui.on_change('name', on_name_changed)
	gui.on_click('run', on_run_clicked)
	gui.on_click('clear', on_clear_clicked)
	gui.on_change('toggle', on_toggle_changed)
	gui.on_change('slider', on_slider_changed)
	gui.on_change('theme', on_theme_changed)
	gui.on_change('number', on_number_changed)
	gui.on_change('color', on_color_changed)
	gui.on_change('date', on_date_changed)
	gui.on_change('mode', on_mode_changed)
	gui.on_change('ready', on_ready_changed)

	// Make the window look nicer with colors.
	gui.set_background_color('#2B2E2A')
	gui.set_font_color('white')

	// Customize layout dimensions and fonts
	gui.set_control_font_size('intro', 18)
	gui.set_control_width('notes', 500)
	gui.set_control_height('notes', 180)
	gui.set_control_width('run', 200)
	gui.set_control_height('run', 40)
	gui.set_control_font_size('run', 16)

	// Update values from code, even before the window is shown.
	gui.set_text('name', 'Grace')
	gui.set_text('city', 'Paris')
	gui.set_text('notes', 'Values update from V without manual wiring')
	gui.set_checked('ready', false)
	gui.set_value_int('number', 42)
	gui.set_status('Ready for more controls')

	// Read back values and print them to the terminal for demonstration.
	println('name = ${gui.get_text('name')}')
	println('city = ${gui.get_text('city')}')
	println('notes = ${gui.get_text('notes')}')
	println('ready = ${gui.get_checked('ready')}')
	println('number = ${gui.get_value_int('number')}')
	println('status = ${gui.get_status()}')

	// Show the window and start the app loop.
	gui.run()
}

// Event handler callbacks

fn on_city_changed(mut win &simplegui.SimpleWindow, value string) {
	println('city changed -> ${value}')
	win.set_status('City updated: ${value}')
}

fn on_name_changed(mut win &simplegui.SimpleWindow, value string) {
	println('name changed -> ${value}')
	win.set_status('Input updated: ${value}')
}

fn on_run_clicked(mut win &simplegui.SimpleWindow) {
	println('run clicked')
	if win.confirm('Confirmation', 'Do you want to append details to the notes?') {
		prompt_msg := win.prompt('Custom Note', 'Enter a custom note to append:', 'Hello from V!')
		name := win.get_text('name')
		city := win.get_text('city')
		notes := win.get_text('notes')
		mut input_val := name
		if input_val.len == 0 {
			input_val = '<empty>'
		}
		combined := notes + '\nRead name: ' + input_val + ', city: ' + city + ' | Msg: ' + prompt_msg
		win.set_text('notes', combined)
		win.alert('Success', 'Notes updated successfully!')
		win.set_status('Wrote input to the text area.')
	} else {
		win.set_status('User cancelled append operation.')
	}
}

fn on_clear_clicked(mut win &simplegui.SimpleWindow) {
	println('clear clicked')
	win.set_text('name', '')
	win.set_text('city', '')
	win.set_text('notes', '')
	win.set_status('Controls cleared.')
}

fn on_toggle_changed(mut win &simplegui.SimpleWindow, value string) {
	println('toggle changed -> ${value}')
	enabled := value == 'true'
	msg := if enabled { 'Advanced mode enabled.' } else { 'Advanced mode disabled.' }
	win.set_status(msg)
	
	// Dynamically hide/show the Notes textarea based on this toggle checkbox
	win.set_control_visible('notes', enabled)
}

fn on_slider_changed(mut win &simplegui.SimpleWindow, value string) {
	println('slider changed -> ${value}')
	win.set_status('Slider set to ' + value)
}

fn on_theme_changed(mut win &simplegui.SimpleWindow, value string) {
	println('theme changed -> ${value}')
	win.set_status('Theme selected: ' + value)
}

fn on_number_changed(mut win &simplegui.SimpleWindow, value string) {
	println('number changed -> ${value}')
	win.set_status('Number updated to ' + value)
}

fn on_color_changed(mut win &simplegui.SimpleWindow, value string) {
	println('color changed -> ${value}')
	win.set_status('Color changed to ' + value)
}

fn on_date_changed(mut win &simplegui.SimpleWindow, value string) {
	println('date changed -> ${value}')
	win.set_status('Date selected: ' + value)
}

fn on_mode_changed(mut win &simplegui.SimpleWindow, value string) {
	println('mode changed -> ${value}')
	win.set_status('Mode changed to ' + value)
}

fn on_ready_changed(mut win &simplegui.SimpleWindow, value string) {
	println('ready changed -> ${value}')
	checked := value == 'true'
	win.set_status(if checked { 'Terms accepted.' } else { 'Terms not accepted.' })
	progress_val := if checked { 70 } else { 35 }
	win.set_value_int('progress', progress_val)
}
