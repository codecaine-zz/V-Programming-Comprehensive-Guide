module main

import simplegui

fn main() {
	// Create the window (it will auto-fit to the controls at startup)
	mut gui := simplegui.new_simple_window('Grid and Row Layout Demo', 600, 500)
	gui.set_title('Grid and Row Layout')

	gui.add_label('header', 'Configure Server Environment')

	// Row 1: Host and Port
	gui.begin_row('host_port_row')
		gui.add_label('lbl_host', 'Host:')
		gui.add_input('host', '127.0.0.1')
		gui.add_label('lbl_port', 'Port:')
		gui.add_input('port', '8080')
	gui.end_row()

	// Row 2: SSL toggle and Auth Token
	gui.begin_row('ssl_token_row')
		gui.add_checkbox('ssl', 'Use SSL', false)
		gui.add_label('lbl_token', 'Token:')
		gui.add_input('token', 'xyz-789-abc')
	gui.end_row()

	// Row 3: Action Buttons
	gui.begin_row('actions')
		gui.add_button('test_conn', 'Test Connection')
		gui.add_button('deploy', 'Deploy Server')
	gui.end_row()

	// Event handlers
	gui.on_click('test_conn', fn (mut win &simplegui.SimpleWindow) {
		host := win.get_text('host')
		port := win.get_text('port')
		win.set_status('Connecting to ' + host + ':' + port + '...')
		println('Testing connection to ' + host + ':' + port)
	})

	gui.on_click('deploy', fn (mut win &simplegui.SimpleWindow) {
		win.set_status('Deploying to server...')
		println('Deploying!')
	})

	// Apply styling
	gui.set_background_color('#2D3142')
	gui.set_font_color('white')

	// Show window and run loop
	gui.run()
}
