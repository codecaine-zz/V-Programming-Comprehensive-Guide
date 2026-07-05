module main

import simplegui

fn main() {
	mut win := simplegui.new_simple_window('Native macOS Window Controller', 640, 720)
	win.set_background_color('#1e1e24')
	win.set_font_color('#fafafa')
	win.set_padding(20)
	win.set_spacing(12)
	win.set_status('Control the native macOS window properties in real-time!')

	win.add_heading('geometry & positioning')

	win.begin_row('row_size')
		win.add_label('lbl_width', 'width:')
		win.add_number('win_width', 640)
		win.add_label('lbl_height', 'height:')
		win.add_number('win_height', 720)
		win.add_button('apply_size', 'apply size')
	win.end_row()

	win.begin_row('row_coords')
		win.add_label('lbl_x', 'pos x:')
		win.add_number('win_x', 200)
		win.add_label('lbl_y', 'pos y:')
		win.add_number('win_y', 200)
		win.add_button('apply_pos', 'apply pos')
	win.end_row()

	win.add_button('center_win', 'center window on screen')

	win.add_heading('effects & style')

	win.begin_row('row_opacity')
		win.add_label('lbl_op', 'window opacity:')
		win.add_slider('win_opacity', 100) // 0 to 100 which we map to 0.0 - 1.0
	win.end_row()

	win.begin_row('row_toggles')
		win.add_checkbox('show_titlebar', 'show titlebar', true)
		win.add_checkbox('always_on_top', 'always on top', false)
	win.end_row()

	win.add_heading('window actions & status')

	win.begin_row('row_actions')
		win.add_button('trigger_fullscreen', 'fullscreen')
		win.add_button('trigger_minimize', 'minimize')
		win.add_button('trigger_maximize', 'zoom / maximize')
	win.end_row()

	win.add_label('info_label', 'live telemetry (updated every 150ms):')
	win.set_control_font_size('info_label', 14)
	win.set_control_font_color('info_label', '#38bdf8')

	win.begin_row('row_status_labels_1')
		win.add_label('lbl_stat_pos', 'bounds: reading...')
		win.add_label('lbl_stat_state', 'state: reading...')
	win.end_row()

	win.begin_row('row_status_labels_2')
		win.add_label('lbl_stat_focus', 'active window: reading...')
		win.add_label('lbl_stat_opacity', 'opacity: reading...')
	win.end_row()

	// Setup Event Callbacks
	win.on_click('apply_size', fn (mut win &simplegui.SimpleWindow) {
		w := win.get_value_int('win_width')
		h := win.get_value_int('win_height')
		win.set_size(w, h)
		win.set_status('Resized window content to ${w}x${h}')
	})

	win.on_click('apply_pos', fn (mut win &simplegui.SimpleWindow) {
		x := win.get_value_int('win_x')
		y := win.get_value_int('win_y')
		win.set_position(x, y)
		win.set_status('Moved window position to coord: (${x}, ${y})')
	})

	win.on_click('center_win', fn (mut win &simplegui.SimpleWindow) {
		win.center()
		win.set_status('Centered window on main display.')
	})

	win.on_change('win_opacity', fn (mut win &simplegui.SimpleWindow, value string) {
		percentage := value.int()
		opacity := f64(percentage) / 100.0
		win.set_opacity(opacity)
		win.set_status('Window opacity set to ${percentage}%')
	})

	win.on_change('show_titlebar', fn (mut win &simplegui.SimpleWindow, value string) {
		show := value == 'true'
		win.set_titlebar_visible(show)
		win.set_status('Titlebar visibility modified.')
	})

	win.on_change('always_on_top', fn (mut win &simplegui.SimpleWindow, value string) {
		top := value == 'true'
		win.set_always_on_top(top)
		win.set_status('Always-on-top mode toggled.')
	})

	win.on_click('trigger_fullscreen', fn (mut win &simplegui.SimpleWindow) {
		win.toggle_fullscreen()
		win.set_status('Toggled macOS native full screen.')
	})

	win.on_click('trigger_minimize', fn (mut win &simplegui.SimpleWindow) {
		win.minimize()
	})

	win.on_click('trigger_maximize', fn (mut win &simplegui.SimpleWindow) {
		win.maximize()
	})

	// Setup low-latency interval timer for live telemetry updates!
	win.set_interval('telemetry_timer', 150, fn (mut win &simplegui.SimpleWindow) {
		// Read values using new macOS APIs
		x := win.get_x()
		y := win.get_y()
		w := win.get_width()
		h := win.get_height()
		opacity := win.get_opacity()

		minimized := win.is_minimized()
		maximized := win.is_maximized()
		fullscreen := win.is_fullscreen()
		active := win.is_active()

		bounds_str := 'bounds: ${w}x${h} at (${x}, ${y})'
		
		mut state_parts := []string{}
		if minimized { state_parts << 'minimized' }
		if maximized { state_parts << 'maximized' }
		if fullscreen { state_parts << 'fullscreen' }
		if state_parts.len == 0 { state_parts << 'normal style' }
		state_str := 'state: ' + state_parts.join(', ')

		focus_str := if active { 'active window: YES (focused)' } else { 'active window: NO' }
		opacity_str := 'opacity: ' + ((opacity * 100.0) + 0.5).str().split('.')[0] + '%'

		// Update GUI labels dynamically
		win.set_text('lbl_stat_pos', bounds_str)
		win.set_text('lbl_stat_state', state_str)
		win.set_text('lbl_stat_focus', focus_str)
		win.set_text('lbl_stat_opacity', opacity_str)

		// Synchronize coordinate inputs if not currently selected
		if !win.is_dirty() {
			win.set_value_int('win_x', x)
			win.set_value_int('win_y', y)
			win.set_value_int('win_width', w)
			win.set_value_int('win_height', h)
		}
	})

	win.run()
}
