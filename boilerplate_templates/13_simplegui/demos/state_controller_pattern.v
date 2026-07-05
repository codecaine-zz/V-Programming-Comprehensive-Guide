module main

import simplegui

fn main() {
	simplegui.new_simple_window('State Controller', 520, 480)
		.set_theme('nord')
		.set_padding(18)
		.add_heading('Controller Panel')

		.add_slider('volume_slider', 50)
			.onchange(on_volume_changed)

		.add_label('lbl_volume', 'Current Volume: 50%')

		.add_separator()

		.add_checkbox('mute_toggle', 'Mute output entirely', false)
			.onchange(on_mute_toggled)

		.add_progress_indicator('prog_bar', 50)

		.add_action('reset_btn', 'Reset Back to Factory Defaults', on_reset_clicked)
		.run()
}

fn on_volume_changed(mut win &simplegui.SimpleWindow, value string) {
	// 1. Get mutated value
	vol := win.get_value_int('volume_slider')

	// 2. Set companion label text and progress indicator
	win.set_text('lbl_volume', 'Current Volume: ${vol}%')
	win.set_value_int('prog_bar', vol)
}

fn on_mute_toggled(mut win &simplegui.SimpleWindow, value string) {
	muted := win.get_checked('mute_toggle')

	if muted {
		// Backup volume slider, set visual feedback or disable
		win.set_text('lbl_volume', 'Current Volume: MUTED')
		win.set_value_int('prog_bar', 0)
		win.set_control_enabled('volume_slider', false)
	} else {
		// Re-enable and restore companion status
		vol := win.get_value_int('volume_slider')
		win.set_text('lbl_volume', 'Current Volume: ${vol}%')
		win.set_value_int('prog_bar', vol)
		win.set_control_enabled('volume_slider', true)
	}
}

fn on_reset_clicked(mut win &simplegui.SimpleWindow) {
	// Programmatically overwrite and set states on control handles
	win.set_value_int('volume_slider', 50)
	win.set_text('lbl_volume', 'Current Volume: 50%')
	win.set_value_int('prog_bar', 50)
	win.set_checked('mute_toggle', false)
	win.set_control_enabled('volume_slider', true)

	win.toast('Defaults restored')
}
