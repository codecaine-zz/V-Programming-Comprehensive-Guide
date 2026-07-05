module main

import simplegui
import time

struct UserForm {
mut:
	username         string
	age              int
	wants_newsletter bool
}

fn main() {
	// Create the window
	mut gui := simplegui.new_simple_window('V QoL Features Demo', 500, 620)

	// Add custom menu items
	gui.add_menu_item('Tray Mode', 'Switch to Status Menu Bar', 's', fn (mut win &simplegui.SimpleWindow) {
		win.alert('Status Bar Mode Enabled', 'The window will now hide. Look for the system tray menu in your top right macOS bar!')
		win.enable_status_bar('') // pass empty for default title

		// Add status bar specific items (these go to tray menu now)
		win.add_menu_item('Tray', 'Restore Window', 'r', fn (mut w &simplegui.SimpleWindow) {
			w.show_window()
		})
		win.add_menu_item('Tray', 'Quit App', 'q', fn (mut w &simplegui.SimpleWindow) {
			exit(0)
		})
	})

	gui.add_label('header', 'QoL Features Demo App')
	gui.set_control_font_size('header', 16)
	gui.add_vertical_spacer(10)
	gui.add_separator()
	gui.add_vertical_spacer(15)

	// Drag & Drop Area
	gui.add_label('drop_lbl', 'File Drag & Drop Target:')
	gui.add_input('drop_target', 'Drag and drop any file(s) here...')
	gui.set_control_enabled('drop_target', false)
	gui.set_control_width('drop_target', 450)

	gui.on_file_drop(fn (mut win &simplegui.SimpleWindow, files []string) {
		joined := files.join(', ')
		win.set_text('drop_target', joined)
		win.set_status('File dropped: ${files[0]}')
	})

	gui.add_vertical_spacer(15)
	gui.add_separator()
	gui.add_vertical_spacer(15)

	// Form Struct Binding
	gui.add_label('form_lbl', 'Interactive Form Fields (Data Binding):')
	gui.begin_row('form_row')
	gui.add_label('lbl_user', 'Username:')
	gui.add_input('username', 'coder_ada')
	gui.add_label('lbl_age', 'Age:')
	gui.add_number('age', 28)
	gui.end_row()

	gui.add_checkbox('wants_newsletter', 'Subscribe to coding newsletters', true)

	gui.begin_row('form_buttons')
	gui.add_button('bind_btn', 'Dump Struct State')
	gui.add_horizontal_spacer(10)
	gui.add_button('load_btn', 'Load Default Struct')
	gui.end_row()

	gui.on_click('bind_btn', fn (mut win &simplegui.SimpleWindow) {
		mut user := UserForm{}
		win.bind_to_struct(mut user)
		println('--- Struct State Dump ---')
		println('Username: ${user.username}')
		println('Age:      ${user.age}')
		println('Newsletter: ${user.wants_newsletter}')
		println('------------------------')
		win.alert('Struct Binding Output', 'Struct State Printed to Console!\n\nUsername: ${user.username}\nAge: ${user.age}')
	})

	gui.on_click('load_btn', fn (mut win &simplegui.SimpleWindow) {
		default_user := UserForm{
			username:         'grace_hopper'
			age:              85
			wants_newsletter: false
		}
		win.load_from_struct(default_user)
		win.set_status('Loaded default struct data!')
	})

	gui.add_vertical_spacer(15)
	gui.add_separator()
	gui.add_vertical_spacer(15)

	// Multi-column Grid Table
	gui.add_label('tbl_lbl', 'Process Manager Table Grid:')
	gui.add_table('processes', ['PID', 'Name', 'Status', 'CPU %'])
	gui.set_control_width('processes', 450)
	gui.set_control_height('processes', 130)

	// Populate initial rows
	gui.set_table_rows('processes', [
		['1024', 'V Compiler', 'Running', '0.2'],
		['4950', 'Safari', 'Suspended', '0.0'],
		['8901', 'Xcode Command Line Tools', 'Running', '15.4'],
	])

	gui.add_vertical_spacer(15)
	gui.add_progress_indicator('progress', 0)

	gui.begin_row('action_row')
	gui.add_button('worker_btn', 'Start Async Worker Thread')
	gui.end_row()

	gui.on_click('worker_btn', fn (mut win &simplegui.SimpleWindow) {
		win.set_control_enabled('worker_btn', false)
		win.set_status('Running background calculations...')
		go run_async_worker(mut win)
	})

	// Colors
	gui.set_background_color('#1F2421')
	gui.set_font_color('white')
	gui.set_status('Ready.')

	gui.run()
}

fn run_async_worker(mut win &simplegui.SimpleWindow) {
	for _ in 1 .. 6 {
		time.sleep(800 * time.millisecond)
		// Safely dispatch table update & progress bar change to the main Cocoa thread
		win.run_on_main_thread(fn (mut w &simplegui.SimpleWindow) {
			val := w.get_value_int('progress') + 20
			w.set_value_int('progress', val)

			// Dynamically update the table grid from background job
			cpu := '${f64(val) * 1.2}'
			w.set_table_rows('processes', [
				['1024', 'V Compiler', 'Running', cpu],
				['4950', 'Safari', 'Suspended', '0.0'],
				['8901', 'Xcode Command Line Tools', 'Completed', '0.0'],
			])

			if val >= 100 {
				w.set_status('Background job completed successfully!')
				w.set_control_enabled('worker_btn', true)
			} else {
				w.set_status('Background job progress: ${val}%')
			}
		})
	}
}
