module main

import simplegui

fn main() {
	mut win := simplegui.new_simple_window('Always on Top Demo', 560, 320)
	win.set_background_color('#1f2937')
	win.set_font_color('white')

	win.add_label('title', 'This window stays above other windows')
	win.set_control_font_size('title', 16)
	win.add_vertical_spacer(8)
	win.add_label('hint', 'Toggle the checkbox to pin or unpin the window.')
	win.add_vertical_spacer(12)

	win.add_checkbox('stay_on_top', 'Keep window on top', true)
	win.set_always_on_top(true)
	win.set_status('Window is pinned above other windows')

	win.on_change('stay_on_top', fn (mut win &simplegui.SimpleWindow, value string) {
		enabled := value == 'true'
		win.set_always_on_top(enabled)
		if enabled {
			win.set_status('Window is pinned above other windows')
		} else {
			win.set_status('Window is no longer pinned')
		}
	})

	win.add_vertical_spacer(16)
	win.add_button('close', 'Close')
	win.on_click('close', fn (mut win &simplegui.SimpleWindow) {
		win.alert('Demo', 'The window is closing now.')
		exit(0)
	})

	win.run()
}
