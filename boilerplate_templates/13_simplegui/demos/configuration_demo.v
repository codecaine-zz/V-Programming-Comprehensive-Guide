module main

import simplegui

fn main() {
	mut win := simplegui.new_simple_window('Configured Demo', 620, 720)
		.set_theme('nord')
		.set_padding(16)
		.set_spacing(10)
		.configure(fn (mut cfg simplegui.WindowConfig) {
			cfg.title = 'Fluent Configuration Demo'
			cfg.width = 640
			cfg.height = 760
			cfg.padding = 20
			cfg.spacing = 12
			cfg.background_color = '#2e3440'
			cfg.font_color = '#eceff4'
			cfg.resizable = true
			cfg.minimizable = true
			cfg.maximizable = false
		})

	win.add_heading('Profile Setup')
	win.form('Account', fn (mut w &simplegui.SimpleWindow) {
		w.add_input('email', 'ada@example.com').placeholder('Email address')
		w.add_input('username', 'ada').placeholder('Username')
		w.add_checkbox('newsletter', 'Subscribe to updates', true)
	})

	win.section('Preferences', fn (mut w &simplegui.SimpleWindow) {
		w.add_input('location', 'London').placeholder('Location')
		w.add_number('experience', 8)
	})

	win.add_action('save', 'Save', fn (mut w &simplegui.SimpleWindow) {
		results := w.validate_controls({
			'email': simplegui.validate_not_empty
			'username': simplegui.validate_not_empty
		})
		if results['email'] != '' || results['username'] != '' {
			w.set_status('Please fill in the required fields.')
			return
		}
		w.set_status('Profile saved successfully.')
	})

	win.add_action('reset', 'Reset', fn (mut w &simplegui.SimpleWindow) {
		w.reset_form()
		w.clear_errors()
		w.set_status('Form reset.')
	})
	win.set_status('Use the fluent helpers to configure, section, and validate the form.')
	win.run()
}
