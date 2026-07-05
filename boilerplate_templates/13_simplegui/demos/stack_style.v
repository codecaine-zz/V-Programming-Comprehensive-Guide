module main

import simplegui

fn main() {
	// Create the window (it will auto-fit to the controls at startup)
	mut gui := simplegui.new_simple_window('Vertical Stack Style Demo', 500, 700)
	gui.set_title('Vertical Stack Style')

	gui.add_label('header', 'User Profile Settings')
	gui.add_input('username', 'grace_hopper')
	gui.add_input('email', 'grace@example.com')
	gui.add_textarea('bio', 'Computer scientist and US Navy rear admiral.')
	gui.add_checkbox('newsletter', 'Subscribe to weekly updates', true)
	gui.add_button('save', 'Save Profile')

	// Set event handlers
	gui.on_click('save', fn (mut win &simplegui.SimpleWindow) {
		win.set_status('Profile saved for: ' + win.get_text('username'))
		println('Saved! username: ' + win.get_text('username') + ', email: ' + win.get_text('email'))
	})

	// Apply styling
	gui.set_background_color('#1E1E24')
	gui.set_font_color('white')

	// Show window and run loop
	gui.run()
}
