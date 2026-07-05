module main

import simplegui

fn main() {
	// 1. Initialize window with a theme preset
	mut win := simplegui.new_simple_window('SimpleGUI DX Showcase', 700, 500)
		.set_theme('dracula')
		.set_padding(20)
		.set_spacing(12)

	win.add_heading('Sleek Developer Settings')

	// 2. Closure-based horizontal row layout with fluent chaining modifiers
	win.row('server_config', fn (mut w &simplegui.SimpleWindow) {
		w.add_label('', 'Server Host:')
			.width(100)

		// Nameless helper with styled modifiers
		w.add_input('', '127.0.0.1')
			.width(180)
			.placeholder('e.g. localhost')
			.tooltip('Server ip address or domain')

		w.add_label('', 'Port:')
			.width(40)

		w.add_number('', 8080)
			.width(80)
			.tooltip('Port number to bind')
	})

	// 3. User info inputs with chaining
	win.row('user_details', fn (mut w &simplegui.SimpleWindow) {
		w.add_label('', 'Username:')
			.width(100)

		w.add_input('username', 'ada_lovelace')
			.width(220)
			.placeholder('Pick a unique handle')

		w.add_label('', 'Age:')
			.width(40)

		w.add_number('age', 28)
			.width(80)
	})

	// 4. Custom status alerts & validation styling
	win.add_label('description', 'Configure the server details and click Validate.')
		.font_size(11)
		.font_color('#8be9fd')

	// 5. Button row to trigger validation
	win.row('actions', fn (mut w &simplegui.SimpleWindow) {
		w.add_button('validate_btn', 'Validate Form')
			.width(150)

		w.add_button('theme_btn', 'Cycle Theme')
			.width(120)
	})

	// 6. Connect callbacks (using pointer references)
	win.on_click('validate_btn', on_validate)
	win.on_click('theme_btn', on_cycle_theme)

	win.set_status('Press Validate to run checks.')
	win.run()
}

fn on_validate(mut win &simplegui.SimpleWindow) {
	username := win.get_text('username')
	age := win.get_value_int('age')

	if username.len < 5 {
		win.set_error('username', 'Must be at least 5 chars')
		win.set_status('Validation failed: check errors.')
	} else if age < 18 {
		win.set_error('age', 'Must be 18+')
		win.set_status('Validation failed: check errors.')
	} else {
		// Clear errors
		win.set_error('username', '')
		win.set_error('age', '')
		win.set_status('Form is valid! Username: ${username}, Age: ${age}')
		win.alert('Success', 'Configuration is valid and saved!')
	}
}

fn on_cycle_theme(mut win &simplegui.SimpleWindow) {
	current_bg := win.get_background_color()
	mut theme_name := 'dracula'
	mut desc_color := '#8be9fd'
	if current_bg == '#282a36' { // Dracula
		theme_name = 'nord'
		desc_color = '#88c0d0'
	} else if current_bg == '#2e3440' { // Nord
		theme_name = 'light'
		desc_color = '#0055aa' // Readable dark blue on light bg
	} else if current_bg == '#f5f5f5' { // Light
		theme_name = 'dark'
		desc_color = '#ff6b6b'
	} else {
		theme_name = 'dracula'
		desc_color = '#8be9fd'
	}

	win.set_theme(theme_name)
	win.set_control_font_color('description', desc_color)
	win.set_status('Theme changed to ' + theme_name.capitalize() + '.')
}
