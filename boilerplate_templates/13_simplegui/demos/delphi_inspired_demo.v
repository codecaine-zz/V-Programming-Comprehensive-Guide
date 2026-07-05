module main

import simplegui

// Struct inspired by Anders Hejlsberg's type system & data model conventions (C# / Delphi)
struct DeveloperTask {
	id       int
	task     string
	priority string
	done     bool
}

fn main() {
	// Setup our main Window
	mut win := simplegui.new_simple_window('RAD Delphi & C# Inspired Demo', 720, 680)

	win.set_background_color('#0f172a')
		.set_font_color('white')
		.set_padding(20)
		.set_spacing(12)
		.set_title('Delphi & C# Inspired RAD Showcase')

	// Header
	win.add_heading('Delphi & C# RAD Developer Studio')

	// 1. Custom Dialog Alerts with Icons / Severity
	win.add_label('dialog_lbl', '1. High-Level Native Alert Dialogs (Severity Styles)')
		.bold(true)
		.font_size(14)
		.font_color('#38bdf8')

	win.begin_row('styles_row')
	win.add_action('info_btn', 'Show Info Alert', fn (mut w simplegui.SimpleWindow) {
		w.alert_with_style(
			'Information',
			'Success! The component compiled and linked correctly.',
			'info'
		)
	})
	win.add_action('warn_btn', 'Show Warning Alert', fn (mut w simplegui.SimpleWindow) {
		w.alert_with_style(
			'Caution Required',
			'Deprecations found. Please upgrade to the latest macOS target framework.',
			'warning'
		)
	})
	win.add_action('error_btn', 'Show Critical Error', fn (mut w simplegui.SimpleWindow) {
		w.alert_with_style(
			'Linker Error (Visual debug)',
			'Undefined symbol found! Missing Cocoa framework references in your build script.',
			'error'
		)
	})
	win.end_row()

	win.add_separator()

	// 2. Filtered Open File Dialog
	win.add_label('filter_lbl', '2. Filtered macOS File Open Dialog (Delphi TFilter style)')
		.bold(true)
		.font_size(14)
		.font_color('#38bdf8')

	win.begin_row('picker_row')
	win.add_action('choose_text_btn', 'Choose Text/Markdown (*.txt, *.md)', fn (mut w simplegui.SimpleWindow) {
		path := w.select_file_with_extensions('.txt, .md')
		if path != '' {
			w.set_text('file_output', path)
			w.set_status('Chosen document: ${path}')
		} else {
			w.set_status('Cancelled choosing text document.')
		}
	})
	win.add_action('choose_img_btn', 'Choose Image (*.png, *.jpg)', fn (mut w simplegui.SimpleWindow) {
		path := w.select_file_with_extensions('.png, .jpg, .jpeg')
		if path != '' {
			w.set_text('file_output', path)
			w.set_status('Chosen photo: ${path}')
		} else {
			w.set_status('Cancelled choosing photo.')
		}
	})
	win.end_row()

	win.add_input('file_output', 'Selected File Path will show here...')
	win.set_control_enabled('file_output', false)

	win.add_separator()

	// 3. Easy-To-Use ListView load from Struct list (Anders' Reflection philosophy)
	win.add_label('table_lbl', '3. ListView Autowired from Array of Structs (Load compile-time reflection)')
		.bold(true)
		.font_size(14)
		.font_color('#f43f5e')

	win.add_table('tasks', ['ID', 'Task Name', 'Priority Mode', 'Completed'])
	win.set_control_height('tasks', 140)

	// Custom DeveloperTask structures list
	tasks := [
		DeveloperTask{ id: 101, task: 'Implement Context Menus', priority: 'High', done: true },
		DeveloperTask{ id: 102, task: 'Write Filtered File Selector Dialog', priority: 'Medium', done: true },
		DeveloperTask{ id: 103, task: 'Extract generic loader reflection', priority: 'High', done: true },
		DeveloperTask{ id: 104, task: 'Design Pascal UI Demo', priority: 'Low', done: false },
	]

	// Single line load of an array of structs into our grid with fully automatic type checking!
	win.load_table_from_structs('tasks', tasks)

	win.add_label('hint_lbl', 'Right-click anywhere to invoke Context Actions!')
		.font_size(11)
		.font_color('#64748b')

	// Context actions for the window
	win.add_context_menu_item('window', 'Reset Table Grid', fn (mut w simplegui.SimpleWindow) {
		w.load_table_from_structs('tasks', [
			DeveloperTask{ id: 201, task: 'Refactor components', priority: 'High', done: false }
		])
		w.set_status('Grid reset to custom view!')
	})

	win.add_context_menu_item('window', 'Light Background Theme', fn (mut w simplegui.SimpleWindow) {
		w.set_background_color('#f1f5f9')
		w.set_font_color('black')
		w.set_status('Theme set to Light Slate!')
	})

	win.add_context_menu_item('window', 'Dark Background Theme', fn (mut w simplegui.SimpleWindow) {
		w.set_background_color('#0f172a')
		w.set_font_color('white')
		w.set_status('Theme set to Dark Slate!')
	})

	win.set_status('Delphi/C#-style components loaded.')
	win.run()
}
