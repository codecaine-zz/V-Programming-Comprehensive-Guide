module main

import simplegui

fn main() {
	mut win := simplegui.new_simple_window('V Advanced Features Showcase', 600, 480)

	win.set_background_color('#0f172a')
		.set_font_color('white')
		.set_padding(18)
		.set_spacing(12)
		.set_title('Advanced Features Showcase')

	win.add_heading('Typography & Advanced macOS APIs')

	// 1. Typography Showcase
	win.add_label('header_styled', 'Styled Header (Courier Bold 18pt)')
		.bold(true)
		.font_name('Courier')
		.font_size(18)
		.font_color('#38bdf8')

	win.add_label('instruction_lbl', 'Right-click the labels Below to open native Context Menus!')
		.font_size(12)
		.font_color('#94a3b8')

	// 2. Context Menu Showcase
	win.add_label('context_target', 'Right-Click Me: Options for Colors')
		.bold(true)
		.font_size(14)
		.font_color('#f43f5e')

	win.add_context_menu_item('context_target', 'Green Text', fn (mut w simplegui.SimpleWindow) {
		w.set_control_font_color('context_target', '#10b981')
		w.set_status('Context Menu Action: Set text color to Green')
	})

	win.add_context_menu_item('context_target', 'Blue Text', fn (mut w simplegui.SimpleWindow) {
		w.set_control_font_color('context_target', '#3b82f6')
		w.set_status('Context Menu Action: Set text color to Blue')
	})

	win.add_context_menu_item('context_target', 'Reset Text', fn (mut w simplegui.SimpleWindow) {
		w.set_control_font_color('context_target', '#f43f5e')
		w.set_status('Context Menu Action: Reset color')
	})

	win.add_separator()

	// 3. Choice Dialog with multiple buttons
	win.add_label('choice_lbl', 'Multiple Choice native macOS Modal Dialogs:')
	win.add_action('choice_btn', 'Try Multi-Choice alert', fn (mut w simplegui.SimpleWindow) {
		choices := ['Nordic Theme', 'Dracula Theme', 'Reset Slate', 'Cancel']
		choice_index := w.choice_dialog(
			'Theme Switcher',
			'Choose a color preset layout to apply to this window and all of its elements dynamically:',
			choices
		)
		match choice_index {
			0 {
				w.set_theme('nord')
				w.set_control_font_color('header_styled', '#88c0d0')
				w.set_status('Choice dialog: Nordic Theme applied!')
			}
			1 {
				w.set_theme('dracula')
				w.set_control_font_color('header_styled', '#ff79c6')
				w.set_status('Choice dialog: Dracula Theme applied!')
			}
			2 {
				w.set_background_color('#0f172a')
				w.set_font_color('white')
				w.set_control_font_color('header_styled', '#38bdf8')
				w.set_status('Choice dialog: Reset to slate!')
			}
			else {
				w.set_status('Choice dialog: Cancelled!')
			}
		}
	})

	win.add_separator()

	// 4. Tray / Status Bar accessory demo
	win.add_label('tray_lbl', 'Seamless Status Bar Mode Integration:')
	win.add_action('tray_btn', 'Minimize to Tray Menu Bar Accessory', fn (mut w simplegui.SimpleWindow) {
		w.alert('Accessory Mode Switch', 'The main window will now minimize/hide.\n\nClick the tray applet in your macOS Status Bar to restore the window any time!')
		w.enable_status_bar('') // Launches macOS Tray status item

		// Add custom items directly to the status bar dropdown menu
		w.add_menu_item('Tray', 'Restore Window View', 'r', fn (mut w2 simplegui.SimpleWindow) {
			w2.show_window()
			w2.set_status('Window restored from System Tray successfully!')
		})
		w.add_menu_item('Tray', 'Quit App Completely', 'q', fn (mut w2 simplegui.SimpleWindow) {
			exit(0)
		})
	})

	win.set_status('Advanced native features ready.')
	win.run()
}
