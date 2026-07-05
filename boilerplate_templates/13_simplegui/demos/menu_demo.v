module main

import simplegui

fn main() {
	mut gui := simplegui.new_simple_window('macOS Native Menu Bar Demo', 450, 350)
	gui.set_title('Native Menu Bar Demo')

	// Add custom menu items
	gui.add_menu_item('Custom Actions', 'Greet Me', 'g', fn (mut win &simplegui.SimpleWindow) {
		win.alert('Greetings', 'Hello from a custom menu action!')
	})

	gui.add_menu_item('Custom Actions', 'Toggle Test Input', 't', fn (mut win &simplegui.SimpleWindow) {
		visible := win.get_control_visible('test_input')
		win.set_control_visible('test_input', !visible)
		win.set_status('Test input visibility toggled!')
	})

	gui.add_label('header', 'Native macOS Menu Bar & Shortcuts')
	gui.set_control_font_size('header', 16)

	gui.add_label('instructions', 'Click the fields below and use native menu shortcuts:\n• CMD + Z (Undo)  • CMD + Shift + Z (Redo)\n• CMD + X (Cut)   • CMD + C (Copy)\n• CMD + V (Paste)  • CMD + A (Select All)\n\nAlso check the Custom Actions menu in the top-left menu bar:\n• Greet Me (CMD+G)\n• Toggle Test Input (CMD+T)')
	gui.set_control_font_size('instructions', 12)

	gui.add_label('input_lbl', 'Test Input Field:')
	gui.add_input('test_input', 'Type something here...')
	gui.set_control_width('test_input', 400)

	gui.add_label('text_lbl', 'Test Text Area:')
	gui.add_textarea('test_area', 'Multi-line native text view supports undo/redo and editing shortcuts perfectly.')
	gui.set_control_width('test_area', 400)
	gui.set_control_height('test_area', 100)

	gui.set_background_color('#2C3E50')
	gui.set_font_color('white')

	gui.run()
}
