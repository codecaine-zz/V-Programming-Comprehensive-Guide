module main

import simplegui

fn main() {
	mut win := simplegui.new_simple_window('macOS Sticky Widget', 320, 320)
	win.set_background_color('#fef08a') // Light yellow sticky notes background style
	win.set_font_color('#111827')       // Jet black text
	win.set_padding(12)
	win.set_spacing(10)
	win.set_always_on_top(true)         // Sticky should be always-on-top

	win.add_label('header', '📌 sticky memo widget')
	win.set_control_font_size('header', 16)
	
	win.add_textarea('memo_notes', 'Type a quick desktop thought/TODO here...')
	win.set_control_font_size('memo_notes', 14)
	win.set_control_background_color('memo_notes', '#fef9c3') // Slightly lighter yellow for editing pad
	win.set_control_font_color('memo_notes', '#1e293b')

	win.begin_row('op_row')
		win.add_label('lbl_op', 'widget opacity:')
		win.add_slider('opacity_sl', 85)
	win.end_row()

	win.begin_row('row_size_toggles')
		win.add_button('make_tiny', 'tiny style')
		win.add_button('make_normal', 'normal style')
	win.end_row()

	win.begin_row('row_bar_toggles')
		win.add_button('toggle_bar', 'toggle header')
		win.add_button('center_sticky', 're-center')
	win.end_row()

	win.add_button('exit_widget', 'dismiss widget')

	// Initial opacity setup
	win.set_opacity(0.85)
	win.set_status('Sticky widget initialized.')

	// Wire events
	win.on_change('opacity_sl', fn (mut win &simplegui.SimpleWindow, value string) {
		pct := value.int()
		win.set_opacity(f64(pct) / 100.0)
	})

	win.on_click('make_tiny', fn (mut win &simplegui.SimpleWindow) {
		win.set_size(240, 200)
		win.set_control_visible('memo_notes', false)
		win.set_control_visible('op_row', false)
		win.set_status('Compressed mode.')
	})

	win.on_click('make_normal', fn (mut win &simplegui.SimpleWindow) {
		win.set_size(320, 320)
		win.set_control_visible('memo_notes', true)
		win.set_control_visible('op_row', true)
		win.set_status('Expanded mode.')
	})

	mut titlebar_state := true
	win.on_click('toggle_bar', fn [mut titlebar_state] (mut win &simplegui.SimpleWindow) {
		titlebar_state = !titlebar_state
		win.set_titlebar_visible(titlebar_state)
	})

	win.on_click('center_sticky', fn (mut win &simplegui.SimpleWindow) {
		win.center()
	})

	win.on_click('exit_widget', fn (mut win &simplegui.SimpleWindow) {
		win.close()
	})

	win.run()
}
