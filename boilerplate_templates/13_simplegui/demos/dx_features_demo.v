module main

import simplegui

// 1. Define a struct representing form data
struct Configuration {
	app_name     string
	enable_cache bool
	max_threads  int
}

fn main() {
	// 2. Setup the window with builder-style chaining & enable Developer Debug Mode
	simplegui.new_simple_window('Developer Ergonomics Showcase', 720, 800)
		.set_background_color('#1b263b')
		.set_font_color('white')
		.set_padding(18)
		.set_spacing(12)
		.set_debug_mode(true) // Highlights events and control lifecycles

		// 3. Add auto-named headers & dividers (no names required!)
		.add_heading('1. Form Generation from Struct (Reflection)')

		// 4. Automatically generate form fields from struct definition
		.add_form_from_struct(Configuration{
			app_name:     'SuperServer'
			enable_cache: true
			max_threads:  8
		})

		// 5. Add custom rows of fields side-by-side (Horizontal Layouts)
		.add_heading('2. Labeled Horizontal Rows')
		.add_fields_row({
			'Deployment Port': 'port'
			'Database Host':   'db_host'
		})
		.set_text('port', '8080')
		.set_text('db_host', 'localhost')

		// 6. Demonstrate nameless control helpers (consistent default keys)
		.add_heading('3. Nameless Controls (Single-instance helpers)')
		.input('Nameless Input Value')
		.textarea('Nameless Textarea Description')

		// 7. Add action buttons horizontally in one call
		.add_heading('4. Action Rows & Event Handlers')
		.add_action_row({
			'Print Values': on_print
			'Reset Form':  on_reset
			'Toggle HUD':  on_toggle_hud
		})

		.set_status('Check terminal for debug logs as you click buttons and edit fields.')
		.run()
}

fn on_print(mut win &simplegui.SimpleWindow) {
	// Read struct fields using reflection
	mut config := Configuration{}
	win.bind_to_struct(mut config)

	// Read nameless and custom fields
	port := win.get_text('port')
	db_host := win.get_text('db_host')
	nameless_in := win.get_input()
	nameless_txt := win.get_textarea()

	summary := 'Struct config:\n' +
		'  App Name: ${config.app_name}\n' +
		'  Cache Enabled: ${config.enable_cache}\n' +
		'  Max Threads: ${config.max_threads}\n\n' +
		'Custom Row:\n' +
		'  Port: ${port}\n' +
		'  DB Host: ${db_host}\n\n' +
		'Nameless Controls:\n' +
		'  Input: ${nameless_in}\n' +
		'  Textarea: ${nameless_txt}'

	win.alert('Current Values Summary', summary)
}

fn on_reset(mut win &simplegui.SimpleWindow) {
	win.reset_form()
	win.set_status('Form controls reset to initial values.')
}

fn on_toggle_hud(mut win &simplegui.SimpleWindow) {
	new_state := !win.get_debug_mode()
	win.set_debug_mode(new_state)
	status_text := if new_state { 'ON' } else { 'OFF' }
	win.toast('Debug HUD is now ${status_text}')
	win.set_status('Debug HUD toggled ${status_text}')
}
