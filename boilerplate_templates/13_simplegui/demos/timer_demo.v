module main

import simplegui

fn main() {
	// Create the window (it will auto-fit to the controls at startup)
	mut gui := simplegui.new_simple_window('Timer & Progress Demo', 450, 300)
	gui.set_title('Timer & Progress Loader')

	gui.add_label('header', 'Async Task Background Loader')
	gui.set_control_font_size('header', 18)

	// Loading status label
	gui.add_label('info', 'Status: Idle. Click Start to begin loading.')

	// Progress indicator bar
	gui.add_progress_indicator('prog', 0)
	gui.set_control_width('prog', 400)

	// Action buttons in a row
	gui.begin_row('btn_row')
		gui.add_button('start_btn', 'Start Task')
		gui.add_button('stop_btn', 'Pause Task')
		gui.add_button('reset_btn', 'Reset')
	gui.end_row()

	// Register event handlers
	gui.on_click('start_btn', fn (mut win &simplegui.SimpleWindow) {
		win.set_status('Running background timer...')
		win.set_control_enabled('start_btn', false)
		win.set_control_enabled('stop_btn', true)
		
		// Set a timer callback named 'loader' firing every 200 milliseconds
		win.set_interval('loader', 200, on_timer_tick)
	})

	gui.on_click('stop_btn', fn (mut win &simplegui.SimpleWindow) {
		win.stop_interval('loader')
		win.set_status('Background task paused.')
		win.set_control_enabled('start_btn', true)
		win.set_control_enabled('stop_btn', false)
	})

	gui.on_click('reset_btn', fn (mut win &simplegui.SimpleWindow) {
		win.stop_interval('loader')
		win.set_value_int('prog', 0)
		win.set_text('info', 'Status: Reset complete. Ready to start.')
		win.set_status('Progress reset.')
		win.set_control_enabled('start_btn', true)
		win.set_control_enabled('stop_btn', false)
	})

	// Initial button states
	gui.set_control_enabled('stop_btn', false)

	// Theme color settings
	gui.set_background_color('#2C3E50')
	gui.set_font_color('white')
	gui.set_status('Task loader ready')

	gui.run()
}

fn on_timer_tick(mut win &simplegui.SimpleWindow) {
	curr := win.get_value_int('prog')
	next_val := curr + 5
	
	if next_val >= 100 {
		win.set_value_int('prog', 100)
		win.set_text('info', 'Status: Load complete (100%)!')
		win.stop_interval('loader')
		
		win.set_control_enabled('start_btn', true)
		win.set_control_enabled('stop_btn', false)
		
		// Trigger native macOS prompt alert modal
		win.alert('Task Complete', 'The background processing task finished successfully!')
		win.set_status('Task finished.')
	} else {
		win.set_value_int('prog', next_val)
		win.set_text('info', 'Status: Processing data (${next_val}%)...')
		win.set_status('Task loading progress: ${next_val}%')
	}
}
