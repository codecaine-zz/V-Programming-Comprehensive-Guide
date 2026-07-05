module main

import simplegui

fn main() {
	mut win := simplegui.new_simple_window('New Controls Demo', 760, 560)

	win.set_background_color('#0f172a')
		.set_font_color('white')
		.set_padding(16)
		.set_spacing(10)
		.set_title('Native Controls Showcase')

	win.add_heading('Native macOS Controls')

	win.add_input('name', 'Ada Lovelace')
		.placeholder('Your name')
		.tooltip('Type a name for the demo')

	win.add_dropdown('priority', ['Low', 'Normal', 'High'], 'Normal')
		.onchange(fn (mut w simplegui.SimpleWindow, value string) {
			w.set_status('Priority changed to ${value}')
		})

	win.add_segmented_control('mode', ['Simple', 'Advanced', 'Expert'], 'Advanced')
		.onchange(fn (mut w simplegui.SimpleWindow, value string) {
			w.set_status('Mode changed to ${value}')
		})

	win.add_radio_group('role', ['Viewer', 'Editor', 'Admin'], 'Editor')
		.onchange(fn (mut w simplegui.SimpleWindow, value string) {
			w.set_status('Role changed to ${value}')
		})

	win.add_switch('alerts', 'Enable alerts', true)
		.onchange(fn (mut w simplegui.SimpleWindow, value string) {
			w.set_status('Alerts ${value}')
		})

	win.add_search_field('query', 'Search items')
		.onchange(fn (mut w simplegui.SimpleWindow, value string) {
			w.set_status('Search: ${value}')
		})

	win.add_action_row({
		'Lock Resize':  fn (mut w simplegui.SimpleWindow) {
			w.set_resizable(false)
			w.set_status('Window resizing locked')
		}
		'Apply Limits': fn (mut w simplegui.SimpleWindow) {
			w.set_min_size(480, 320)
			w.set_max_size(980, 720)
			w.set_status('Size constraints applied')
		}
	})

	win.on_click('lock_resize', fn (mut w simplegui.SimpleWindow) {
		w.set_resizable(false)
		w.set_status('Window resizing locked')
	})
	win.on_click('apply_limits', fn (mut w simplegui.SimpleWindow) {
		w.set_min_size(480, 320)
		w.set_max_size(980, 720)
		w.set_status('Size constraints applied')
	})

	win.run()
}
