module main

import simplegui

fn main() {
	simplegui.new_simple_window('Starter', 640, 420)
		.add_input('name', 'Ada')
		.add_button('save', 'Save')
			.onclick(fn (mut win &simplegui.SimpleWindow) {
				println('saved: ${win.get('name')}')
			})
		.run()
}
