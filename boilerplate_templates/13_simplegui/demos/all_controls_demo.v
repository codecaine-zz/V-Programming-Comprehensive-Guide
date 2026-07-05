module main

import simplegui

fn main() {
	mut win := simplegui.new_simple_window('All Controls Demo', 860, 750)
	win.set_background_color('#17202A')
	win.set_font_color('white')
	win.set_padding(16)
	win.set_spacing(10)
	win.set_status('Interact with each control to see the demo in action.')

	win.add_label('header', 'Single-window control showcase')
	win.set_control_font_size('header', 18)
	win.add_separator()

	win.add_label('text_heading', 'Text and entry controls')
	win.begin_row('row_text')
	win.add_label('name_label', 'Name')
	win.add_input('name', 'Ada Lovelace')
	win.add_label('password_label', 'Password')
	win.add_password('password', 'secret123')
	win.end_row()

	win.add_label('notes_label', 'Notes')
	win.add_textarea('notes', 'This window exercises most of the built-in controls.')

	win.add_label('html_label', 'HTML view')
	win.add_html_view('html', '<html><body style="font-family: -apple-system, sans-serif; font-size: 13px; color: #f8fafc; background-color: transparent; margin: 0;"><h3 style="color:#5eead4; margin-top: 0; margin-bottom: 4px;">Native HTML preview</h3><p style="margin: 0;">Useful for lightweight rich content.</p></body></html>')
	win.set_control_width('html', 720)
	win.set_control_height('html', 110)

	win.add_label('drop_label', 'Drop zone')
	win.add_drop_zone('drop', 'Drop a file here')
	win.set_control_width('drop', 720)
	win.set_control_height('drop', 70)

	win.add_label('action_heading', 'Buttons and toggles')
	win.begin_row('row_actions')
	win.add_button('snapshot', 'Show snapshot')
	win.add_button('clear', 'Clear values')
	win.end_row()
	win.add_checkbox('agree', 'Agree to the demo terms', true)
	win.add_checkbox('alerts', 'Enable extra status messages', false)

	win.add_label('value_heading', 'Numbers and sliders')
	win.begin_row('row_values')
	win.add_number('age', 31)
	win.add_slider('volume', 64)
	win.end_row()

	win.add_label('picker_heading', 'Selectors')
	win.begin_row('row_selectors')
	win.add_theme_menu('theme', 'System')
	win.add_color_well('accent', '#5B8DEF')
	win.add_date_picker('date', '2026-07-04')
	win.add_mode_control('mode', 'Advanced')
	win.end_row()

	win.add_label('progress_heading', 'Progress indicator')
	win.add_progress_indicator('progress', 42)
	win.set_control_width('progress', 720)

	win.add_label('layout_heading', 'Containers and composite controls')
	win.add_group_box('profile_box', 'Profile details')
	win.add_input('profile_name', 'Ada')
	win.add_checkbox('profile_accept', 'Accept terms', true)
	win.add_separator()

	win.add_tabs('workspace_tabs', ['Overview', 'Settings'])
	win.add_label('tabs_note', 'Tab-based layouts are great for grouped workflows.')
	win.begin_row('tabs_row')
	win.add_button('tabs_snapshot', 'Tab snapshot')
	win.add_button('tabs_reset', 'Reset')
	win.end_row()

	win.add_label('advanced_heading', 'Dropdowns, segmented, radio, switch and search')
	win.begin_row('advanced_row')
	win.add_dropdown('priority', ['Low', 'Medium', 'High'], 'Medium')
	win.add_segmented_control('analysis_mode', ['Simple', 'Advanced', 'Expert'], 'Advanced')
	win.end_row()
	win.add_radio_group('role', ['Viewer', 'Editor', 'Admin'], 'Editor')
	win.add_switch('notifications', 'Enable notifications', true)
	win.add_search_field('search', 'Search the demo')
	win.set_control_width('search', 720)

	win.add_label('scroll_heading', 'Scrollable content')
	win.add_scroll_view('details_scroll', 160)
	win.add_label('scroll_intro', 'This scroll view keeps long layouts manageable.')
	win.add_progress_indicator('scroll_progress', 58)
	win.add_number('scroll_count', 7)
	win.add_slider('scroll_slider', 33)
	win.set_control_width('scroll_progress', 720)

	win.add_label('list_heading', 'List box and image')
	win.begin_row('row_lists')
	win.add_list_box('items', ['Alpha', 'Beta', 'Gamma', 'Delta', 'Epsilon', 'Zeta', 'Eta', 'Theta'])
	win.add_image('preview', 'screenshots/stack_style.png')
	win.end_row()
	win.set_control_width('items', 260)
	win.set_control_height('items', 120)
	win.set_control_width('preview', 220)
	win.set_control_height('preview', 140)

	win.add_label('table_heading', 'Table view')
	win.add_table('events', ['Action', 'Value'])
	win.set_control_width('events', 720)
	win.set_control_height('events', 110)
	win.set_table_rows('events', [
		['Input changed', 'Ada Lovelace'],
		['Theme changed', 'System'],
	])

	win.on_click('snapshot', on_snapshot_clicked)
	win.on_click('clear', on_clear_clicked)
	win.on_change('name', on_name_changed)
	win.on_change('password', on_password_changed)
	win.on_change('notes', on_notes_changed)
	win.on_change('agree', on_agree_changed)
	win.on_change('alerts', on_alerts_changed)
	win.on_change('age', on_age_changed)
	win.on_change('volume', on_volume_changed)
	win.on_change('theme', on_theme_changed)
	win.on_change('accent', on_accent_changed)
	win.on_change('date', on_date_changed)
	win.on_change('mode', on_mode_changed)
	win.on_change('items', on_items_changed)
	win.on_change('priority', on_priority_changed)
	win.on_change('analysis_mode', on_analysis_mode_changed)
	win.on_change('role', on_role_changed)
	win.on_change('notifications', on_notifications_changed)
	win.on_change('search', on_search_changed)
	win.on_click('tabs_snapshot', on_tabs_snapshot_clicked)
	win.on_click('tabs_reset', on_tabs_reset_clicked)

	win.on_file_drop(fn (mut win &simplegui.SimpleWindow, files []string) {
		joined := files.join(', ')
		win.set_text('notes', 'Dropped files: ${joined}')
		win.set_status('Dropped ${joined}')
	})

	win.run()
}

fn on_snapshot_clicked(mut win &simplegui.SimpleWindow) {
	summary := 'Name: ${win.get_text('name')}\nPassword: ${win.get_text('password')}\nNotes: ${win.get_text('notes')}\nAgree: ${win.get_checked('agree')}\nAlerts: ${win.get_checked('alerts')}\nAge: ${win.get_value_int('age')}\nVolume: ${win.get_value_int('volume')}\nTheme: ${win.get_text('theme')}\nAccent: ${win.get_text('accent')}\nDate: ${win.get_text('date')}\nMode: ${win.get_text('mode')}\nSelection: ${win.get_text('items')}\nPriority: ${win.get_text('priority')}\nAnalysis: ${win.get_text('analysis_mode')}\nRole: ${win.get_text('role')}\nNotifications: ${win.get_checked('notifications')}\nSearch: ${win.get_text('search')}'
	win.alert('Snapshot', summary)
	win.set_status('Snapshot captured.')
}

fn on_clear_clicked(mut win &simplegui.SimpleWindow) {
	win.set_text('name', '')
	win.set_text('password', '')
	win.set_text('notes', '')
	win.set_checked('agree', false)
	win.set_checked('alerts', false)
	win.set_value_int('age', 0)
	win.set_value_int('volume', 0)
	win.set_text('theme', 'System')
	win.set_text('accent', '#5B8DEF')
	win.set_text('date', '2026-07-04')
	win.set_text('mode', 'Advanced')
	win.set_value_int('progress', 0)
	win.set_text('profile_name', 'Ada')
	win.set_checked('profile_accept', true)
	win.set_text('priority', 'Medium')
	win.set_text('analysis_mode', 'Advanced')
	win.set_text('role', 'Editor')
	win.set_checked('notifications', true)
	win.set_text('search', '')
	win.set_value_int('scroll_count', 7)
	win.set_value_int('scroll_slider', 33)
	win.set_value_int('scroll_progress', 0)
	win.set_status('Cleared the demo values.')
}

fn on_name_changed(mut win &simplegui.SimpleWindow, value string) {
	win.set_status('Name changed to ${value}')
}

fn on_password_changed(mut win &simplegui.SimpleWindow, value string) {
	win.set_status('Password updated.')
}

fn on_notes_changed(mut win &simplegui.SimpleWindow, value string) {
	win.set_status('Notes updated.')
}

fn on_agree_changed(mut win &simplegui.SimpleWindow, value string) {
	win.set_status(if value == 'true' { 'Terms accepted.' } else { 'Terms cleared.' })
}

fn on_alerts_changed(mut win &simplegui.SimpleWindow, value string) {
	win.set_status(if value == 'true' { 'Extra alerts enabled.' } else { 'Extra alerts disabled.' })
}

fn on_age_changed(mut win &simplegui.SimpleWindow, value string) {
	win.set_status('Age set to ${value}')
}

fn on_volume_changed(mut win &simplegui.SimpleWindow, value string) {
	win.set_status('Volume set to ${value}')
}

fn on_theme_changed(mut win &simplegui.SimpleWindow, value string) {
	win.set_theme(value)
	
	mut body_fg := '#f8fafc'
	mut heading_color := '#5eead4'
	if value.to_lower() == 'light' {
		body_fg = '#1e293b'
		heading_color = '#0284c7'
	}
	
	html_content := '<html><body style="font-family: -apple-system, sans-serif; font-size: 13px; color: ${body_fg}; background-color: transparent; margin: 0;"><h3 style="color:${heading_color}; margin-top: 0; margin-bottom: 4px;">Native HTML preview</h3><p style="margin: 0;">Useful for lightweight rich content.</p></body></html>'
	win.set_html('html', html_content)
	
	win.set_status('Theme changed to ${value}')
}

fn on_accent_changed(mut win &simplegui.SimpleWindow, value string) {
	win.set_control_background_color('snapshot', value)
	win.set_control_background_color('clear', value)
	win.set_control_background_color('progress', value)
	win.set_status('Accent color changed to ${value}')
}

fn on_date_changed(mut win &simplegui.SimpleWindow, value string) {
	win.set_status('Date changed to ${value}')
}

fn on_mode_changed(mut win &simplegui.SimpleWindow, value string) {
	win.set_status('Mode changed to ${value}')
}

fn on_items_changed(mut win &simplegui.SimpleWindow, value string) {
	win.set_status('Selection changed to ${value}')
}

fn on_priority_changed(mut win &simplegui.SimpleWindow, value string) {
	win.set_status('Priority changed to ${value}')
}

fn on_analysis_mode_changed(mut win &simplegui.SimpleWindow, value string) {
	win.set_status('Analysis mode changed to ${value}')
}

fn on_role_changed(mut win &simplegui.SimpleWindow, value string) {
	win.set_status('Role changed to ${value}')
}

fn on_notifications_changed(mut win &simplegui.SimpleWindow, value string) {
	win.set_status(if value == 'true' { 'Notifications enabled.' } else { 'Notifications disabled.' })
}

fn on_search_changed(mut win &simplegui.SimpleWindow, value string) {
	win.set_status('Search updated to ${value}')
}

fn on_tabs_snapshot_clicked(mut win &simplegui.SimpleWindow) {
	win.set_status('Tab snapshot requested.')
}

fn on_tabs_reset_clicked(mut win &simplegui.SimpleWindow) {
	win.set_text('profile_name', 'Ada')
	win.set_checked('profile_accept', true)
	win.set_text('priority', 'Medium')
	win.set_text('analysis_mode', 'Advanced')
	win.set_text('role', 'Editor')
	win.set_checked('notifications', true)
	win.set_text('search', '')
	win.set_status('Tab demo reset.')
}
