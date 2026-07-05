module main

import simplegui

fn main() {
	simplegui.new_simple_window('Vertical Starter', 440, 520)
		.configure(fn (mut cfg simplegui.WindowConfig) {
			cfg.padding = 20
			cfg.spacing = 12
		})
		.add_heading('App Settings')

		.add_label('lbl_user', 'Username')
		.add_input('username', 'ada_lovelace')
			.placeholder('Enter username...')
			.tooltip('At least 3 characters')

		.add_toggle('newsletter', 'Subscribe to daily newsletter', true)

		.add_action('btn_submit', 'Submit Settings', on_submit)
		.run()
}

fn on_submit(mut win &simplegui.SimpleWindow) {
	username := win.get_text('username')
	subscribed := win.get_checked('newsletter')

	win.alert('Status Updated', 'Saved user ${username} (Newsletter: ${subscribed})')
}
