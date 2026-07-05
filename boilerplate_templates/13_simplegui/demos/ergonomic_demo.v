module main

import simplegui

struct DeveloperProfile {
	name             string
	wants_newsletter bool
	years_experience int
}

fn main() {
	// 1. Setup the window with style chaining, theme preset, and debug mode
	mut win := simplegui.new_simple_window('Ergonomic Helpers Demo', 720, 780)
		.set_theme('dracula')
		.set_padding(16)
		.set_spacing(10)
		.set_debug_mode(true)

	// 2. Add an auto-generated title heading (nameless label + separator)
	win.add_heading('Ergonomic Developer Form')

	// 3. Automatically build the form fields from the DeveloperProfile struct!
	default_profile := DeveloperProfile{
		name:             'Ada Lovelace'
		wants_newsletter: true
		years_experience: 12
	}
	win.add_form_from_struct(default_profile)

	// 3.5. Closure-based row layout and last-control chaining modifiers
	win.add_heading('Additional Configuration')
		.row('extra_config', fn (mut w &simplegui.SimpleWindow) {
			w.add_input('nickname', 'Ada')
				.width(200)
				.placeholder('Enter nickname...')
			w.add_number('level', 10)
				.width(80)
				.tooltip('Account Level')
		})

	// 4. Chain layout rows and actions
	win.add_heading('Actions')
		.add_action_row({
			'Save Profile': on_save
			'Reset Form':   on_reset
			'Clear All':    on_clear
		})
		.add_heading('Utility Links')
		.add_action_row({
			'Copy Name': on_copy
			'Open Repo': on_docs
		})

	// 5. Stylings & placeholders
	win.set_control_width('name', 320)
		.set_control_width('years_experience', 100)
		.set_placeholder('name', 'Type your name')
		.set_tooltip('wants_newsletter', 'Subscribe to get simplegui updates')
		.set_focus('name')

	// 6. Set status footer
	win.set_status('Ready. Form generated automatically via struct reflection.')

	// 7. Add enter key & close hooks
	win.on_enter('name', fn (mut w &simplegui.SimpleWindow) {
		w.set_status('Enter pressed in name field')
	})
	win.on_close(fn (mut w &simplegui.SimpleWindow) {
		println('Ergonomic demo window closed')
	})

	win.run()
}

fn on_save(mut win &simplegui.SimpleWindow) {
	mut profile := DeveloperProfile{}
	win.bind_to_struct(mut profile)
	newsletter := if profile.wants_newsletter { 'Yes' } else { 'No' }
	win.alert('Saved Profile', 'Name: ${profile.name}\nExperience: ${profile.years_experience} years\nNewsletter: ${newsletter}')
}

fn on_reset(mut win &simplegui.SimpleWindow) {
	win.reset_form()
	win.set_status('Form reset to initial struct values.')
}

fn on_clear(mut win &simplegui.SimpleWindow) {
	win.clear_all()
	win.set_status('Cleared all form fields.')
}

fn on_copy(mut win &simplegui.SimpleWindow) {
	win.copy_to_clipboard(win.get_text('name'))
	win.toast('Copied name to clipboard!')
}

fn on_docs(mut win &simplegui.SimpleWindow) {
	win.open_url('https://github.com/codecaine-zz/vlang_simplegui')
}
