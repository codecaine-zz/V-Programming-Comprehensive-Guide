module main

import simplegui

fn main() {
	// Create the window (it will auto-fit to the controls at startup)
	mut gui := simplegui.new_simple_window('System Settings Editor', 550, 600)
	gui.set_title('System Settings')

	gui.add_label('header', 'Preferences Dashboard')

	// Row 1: Workspace Accent Color & Mode Segment Control
	gui.begin_row('row_colors')
		gui.add_label('lbl_accent', 'Accent Color:')
		gui.add_color_well('accent', '#FF3B30')
		gui.add_label('lbl_mode', 'Select Mode:')
		gui.add_mode_control('mode', 'Advanced')
	gui.end_row()

	// Row 2: Theme Dropdown selection & System volume level
	gui.begin_row('row_system')
		gui.add_label('lbl_theme', 'Active Theme:')
		gui.add_theme_menu('theme', 'Dark')
		gui.add_label('lbl_vol', 'Volume (%):')
		gui.add_number('volume', 75)
	gui.end_row()

	// Row 3: Backup Date & Notification schedule
	gui.begin_row('row_dates')
		gui.add_label('lbl_date', 'Backup Date:')
		gui.add_date_picker('backup_date', '2026-07-05')
		gui.add_checkbox('notifs', 'Enable Notifications', true)
	gui.end_row()

	// Row 4: Action button and progress bar
	gui.begin_row('row_progress')
		gui.add_button('apply', 'Apply Settings')
		gui.add_progress_indicator('progress', 100)
	gui.end_row()

	// Connect event handlers
	gui.on_click('apply', fn (mut win &simplegui.SimpleWindow) {
		accent := win.get_text('accent')
		mode := win.get_text('mode')
		theme := win.get_text('theme')
		volume := win.get_value_int('volume')
		date := win.get_text('backup_date')
		notifs := win.get_checked('notifs')

		win.set_status('Settings applied! Accent: ${accent}, Mode: ${mode}, Theme: ${theme}')
		println('Applied Settings -> Accent: ${accent}, Mode: ${mode}, Theme: ${theme}, Volume: ${volume}, Backup: ${date}, Notifications: ${notifs}')
	})

	gui.on_change('notifs', fn (mut win &simplegui.SimpleWindow, value string) {
		checked := value == 'true'
		prog_val := if checked { 100 } else { 0 }
		win.set_value_int('progress', prog_val)
		win.set_status('Notifications toggled: ' + value)
	})

	gui.on_change('theme', fn (mut win &simplegui.SimpleWindow, value string) {
		win.set_theme(value)
		win.set_status('Theme change applied: ' + value)
	})

	gui.on_change('accent', fn (mut win &simplegui.SimpleWindow, value string) {
		win.set_control_background_color('apply', value)
		win.set_status('Accent color applied: ' + value)
	})

	// Premium dark slate theme
	gui.set_background_color('#2C3E50')
	gui.set_font_color('white')
	gui.set_status('Waiting for configuration updates')

	gui.run()
}
