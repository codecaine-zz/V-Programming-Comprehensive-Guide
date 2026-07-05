module main

import simplegui

fn main() {
	mut win := simplegui.new_simple_window('Change Tracking & Validation Demo', 550, 480)
		.set_theme('dracula')
		.set_padding(20)
		.set_spacing(12)

	win.add_heading('User Profile Settings')

	// 1. Inputs with change event listeners
	win.row('row_username', fn (mut w &simplegui.SimpleWindow) {
		w.add_label('', 'Username:')
			.width(100)
		w.add_input('username', 'ada_lovelace')
			.width(250)
			.placeholder('Min 5 characters')
	})

	win.row('row_email', fn (mut w &simplegui.SimpleWindow) {
		w.add_label('', 'Email:')
			.width(100)
		w.add_input('email', 'ada@example.com')
			.width(250)
			.placeholder('Required')
	})

	win.row('row_newsletter', fn (mut w &simplegui.SimpleWindow) {
		w.add_checkbox('newsletter', '', true)
			.tooltip('Subscribe to simplegui newsletter updates')
		w.add_label('', 'Receive product newsletter updates')
	})

	// 2. Unsaved changes warning banner (shows/hides based on dirty status)
	win.add_label('dirty_banner', '   No unsaved changes.')
		.font_size(11)
		.font_color('#50fa7b')

	// 3. Actions Row
	win.row('actions', fn (mut w &simplegui.SimpleWindow) {
		w.add_button('save_btn', 'Save Settings')
			.width(130)
		w.add_button('validate_btn', 'Validate Form')
			.width(130)
		w.add_button('revert_btn', 'Revert (Reset)')
			.width(130)
	})

	// 4. Attach event listeners
	win.on_change('username', on_field_changed)
	win.on_change('email', on_field_changed)
	win.on_change('newsletter', on_field_changed)

	win.on_click('save_btn', on_save)
	win.on_click('validate_btn', on_validate)
	win.on_click('revert_btn', on_revert)

	win.set_status('Form ready.')
	win.run()
}

// Live change listener: checks if form is dirty and updates the status banner
fn on_field_changed(mut win &simplegui.SimpleWindow, value string) {
	if win.is_dirty() {
		win.set_text('dirty_banner', '⚠️ Unsaved changes exist!')
		win.set_control_font_color('dirty_banner', '#ff5555') // Red
	} else {
		win.set_text('dirty_banner', '   No unsaved changes.')
		win.set_control_font_color('dirty_banner', '#50fa7b') // Green
	}
}

fn on_validate(mut win &simplegui.SimpleWindow) {
	username := win.get_text('username').trim_space()
	email := win.get_text('email').trim_space()

	// Clear any previous errors
	win.clear_errors()

	mut has_error := false

	if username.len < 5 {
		win.set_error('username', 'Username must be at least 5 characters')
		has_error = true
	}
	if email == '' {
		win.set_error('email', 'Email address is required')
		has_error = true
	}

	if has_error {
		win.set_status('Validation failed: check highlighted fields.')
	} else {
		win.set_status('All fields are valid.')
		win.toast('Validation passed!')
	}
}

fn on_save(mut win &simplegui.SimpleWindow) {
	// First validate
	username := win.get_text('username').trim_space()
	email := win.get_text('email').trim_space()

	if username.len < 5 || email == '' {
		win.alert('Cannot Save', 'Please fix validation errors before saving.')
		return
	}

	// Commit changes to reset the dirty tracking baseline
	win.commit_changes()
	win.clear_errors()

	// Update banner
	win.set_text('dirty_banner', '   No unsaved changes.')
	win.set_control_font_color('dirty_banner', '#50fa7b') // Green

	win.set_status('Profile saved successfully.')
	win.alert('Saved', 'Changes committed as the new baseline state!')
}

fn on_revert(mut win &simplegui.SimpleWindow) {
	if !win.is_dirty() {
		win.toast('No changes to revert.')
		return
	}

	if win.confirm('Revert Changes?', 'Are you sure you want to discard your unsaved edits?') {
		win.reset_form()  // Reverts all controls back to the last committed state
		win.clear_errors()

		// Update banner
		win.set_text('dirty_banner', '   No unsaved changes.')
		win.set_control_font_color('dirty_banner', '#50fa7b') // Green
		win.set_status('Reverted edits.')
	}
}
