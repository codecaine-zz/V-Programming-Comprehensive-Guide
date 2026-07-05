module main

import simplegui

fn main() {
	mut gui := simplegui.new_simple_window('GUI Events & Enable States', 450, 260)
	gui.set_title('Advanced GUI Events')

	gui.add_label('header', 'Interactive Events Dashboard')
	gui.set_control_font_size('header', 16)

	// Username input field
	gui.add_input('username', 'Alice')
	gui.set_control_width('username', 350)

	// Action button
	gui.add_button('action_btn', 'Submit Data')
	gui.set_control_width('action_btn', 350)
	gui.set_control_background_color('action_btn', '#3498DB')
	gui.set_control_font_color('action_btn', 'white')

	// Checkbox to toggle enabled states
	gui.add_checkbox('enable_toggle', 'Enable Form Controls', true)

	// 1. Focus & Blur (Lost Focus) events on the text field
	gui.on_focus('username', fn (mut win &simplegui.SimpleWindow) {
		win.set_status('Input field focused: ready for text entry.')
		win.set_control_background_color('username', '#FCF3CF') // Highlight yellow
	})

	gui.on_blur('username', fn (mut win &simplegui.SimpleWindow) {
		win.set_status('Input field lost focus.')
		win.set_control_background_color('username', '#FFFFFF') // Reset white
	})

	// 2. Hover enter & exit events on the button
	gui.on_hover('action_btn', fn (mut win &simplegui.SimpleWindow) {
		win.set_status('Hover: Mouse entered Submit Button area!')
		win.set_control_background_color('action_btn', '#E67E22') // Accent highlight orange
	})

	gui.on_hover_exit('action_btn', fn (mut win &simplegui.SimpleWindow) {
		win.set_status('Hover: Mouse left button area.')
		win.set_control_background_color('action_btn', '#3498DB') // Revert blue
	})

	// 3. Enabling / disabling form controls dynamically
	gui.on_change('enable_toggle', fn (mut win &simplegui.SimpleWindow, value string) {
		enabled := value == 'true'
		win.set_control_enabled('username', enabled)
		win.set_control_enabled('action_btn', enabled)
		
		status_msg := if enabled { 'Form controls enabled.' } else { 'Form controls disabled.' }
		win.set_status(status_msg)
	})

	// 4. Window Resize event tracking
	gui.on_resize(fn (mut win &simplegui.SimpleWindow, new_size string) {
		win.set_status('Window resized to: ${new_size}')
	})

	gui.set_background_color('#2C3E50')
	gui.set_font_color('white')
	gui.set_status('Resize window or interact with controls to trigger events')

	gui.run()
}
