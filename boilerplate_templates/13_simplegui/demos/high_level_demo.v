module main

import simplegui

fn main() {
	mut win := simplegui.new_simple_window('High-Level Helpers Demo', 760, 720)
	win.set_background_color('#132238')
	win.set_font_color('white')
	win.set_padding(16)
	win.set_spacing(10)

	win.add_heading('Profile')
	win.add_form_field('Name', 'name', 'Ada Lovelace')
	win.add_form_field('City', 'city', 'London')
	win.add_form_textarea('Notes', 'notes', 'This demo uses the short helper API.')
	win.add_toggle('ready', 'Ready to continue', true)
	win.add_number_field('age', 36)

	win.add_heading('Actions')
	win.begin_row('actions')
	win.add_action('save', 'Save', on_save)
	win.add_action('clear', 'Clear', on_clear)
	win.end_row()

	win.set_control_width('name', 280)
	win.set_control_width('city', 280)
	win.set_control_width('notes', 560)
	win.set_control_width('save', 140)
	win.set_control_width('clear', 140)
	win.set_control_font_size('title', 18)
	win.set_status('Use the shortcut helpers to build a form quickly.')

	win.run()
}

fn on_save(mut win &simplegui.SimpleWindow) {
	name := win.get_text('name')
	city := win.get_text('city')
	ready := if win.get_checked('ready') { 'yes' } else { 'no' }
	win.alert('Saved', 'Name: ${name}\nCity: ${city}\nReady: ${ready}')
	win.set_status('Saved the current form values.')
}

fn on_clear(mut win &simplegui.SimpleWindow) {
	win.set_text('name', '')
	win.set_text('city', '')
	win.set_text('notes', '')
	win.set_checked('ready', false)
	win.set_value_int('age', 0)
	win.set_status('Cleared the form fields.')
}
