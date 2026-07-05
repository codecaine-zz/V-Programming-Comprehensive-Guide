module main

import simplegui

fn main() {
	// Create the window (it will auto-fit to the controls at startup)
	mut gui := simplegui.new_simple_window('Calculator Demo', 300, 420)
	gui.set_title('Calculator')

	gui.add_input('display', '0')
	
	// Row 1: 7, 8, 9, /
	gui.begin_row('row1')
		gui.add_button('btn_7', '7')
		gui.add_button('btn_8', '8')
		gui.add_button('btn_9', '9')
		gui.add_button('btn_div', '/')
	gui.end_row()

	// Row 2: 4, 5, 6, *
	gui.begin_row('row2')
		gui.add_button('btn_4', '4')
		gui.add_button('btn_5', '5')
		gui.add_button('btn_6', '6')
		gui.add_button('btn_mul', '*')
	gui.end_row()

	// Row 3: 1, 2, 3, -
	gui.begin_row('row3')
		gui.add_button('btn_1', '1')
		gui.add_button('btn_2', '2')
		gui.add_button('btn_3', '3')
		gui.add_button('btn_sub', '-')
	gui.end_row()

	// Row 4: 0, C, =, +
	gui.begin_row('row4')
		gui.add_button('btn_0', '0')
		gui.add_button('btn_clear', 'C')
		gui.add_button('btn_equal', '=')
		gui.add_button('btn_add', '+')
	gui.end_row()

	// Register event handlers
	gui.on_click('btn_0', fn (mut win &simplegui.SimpleWindow) { press_digit(mut win, '0') })
	gui.on_click('btn_1', fn (mut win &simplegui.SimpleWindow) { press_digit(mut win, '1') })
	gui.on_click('btn_2', fn (mut win &simplegui.SimpleWindow) { press_digit(mut win, '2') })
	gui.on_click('btn_3', fn (mut win &simplegui.SimpleWindow) { press_digit(mut win, '3') })
	gui.on_click('btn_4', fn (mut win &simplegui.SimpleWindow) { press_digit(mut win, '4') })
	gui.on_click('btn_5', fn (mut win &simplegui.SimpleWindow) { press_digit(mut win, '5') })
	gui.on_click('btn_6', fn (mut win &simplegui.SimpleWindow) { press_digit(mut win, '6') })
	gui.on_click('btn_7', fn (mut win &simplegui.SimpleWindow) { press_digit(mut win, '7') })
	gui.on_click('btn_8', fn (mut win &simplegui.SimpleWindow) { press_digit(mut win, '8') })
	gui.on_click('btn_9', fn (mut win &simplegui.SimpleWindow) { press_digit(mut win, '9') })

	gui.on_click('btn_add', fn (mut win &simplegui.SimpleWindow) { press_op(mut win, '+') })
	gui.on_click('btn_sub', fn (mut win &simplegui.SimpleWindow) { press_op(mut win, '-') })
	gui.on_click('btn_mul', fn (mut win &simplegui.SimpleWindow) { press_op(mut win, '*') })
	gui.on_click('btn_div', fn (mut win &simplegui.SimpleWindow) { press_op(mut win, '/') })

	gui.on_click('btn_clear', press_clear)
	gui.on_click('btn_equal', press_equal)

	// Custom color theme matching calculator device styles
	gui.set_background_color('#1C1C1E')
	gui.set_font_color('white')
	gui.set_status('Calculator ready')

	gui.run()
}

fn press_digit(mut win &simplegui.SimpleWindow, digit string) {
	curr := win.get_text('display')
	if curr == '0' || curr == 'Error' {
		win.set_text('display', digit)
	} else {
		win.set_text('display', curr + digit)
	}
}

fn press_op(mut win &simplegui.SimpleWindow, op string) {
	curr := win.get_text('display')
	win.set_text('display', curr + ' ' + op + ' ')
}

fn press_clear(mut win &simplegui.SimpleWindow) {
	win.set_text('display', '0')
	win.set_status('Cleared')
}

fn press_equal(mut win &simplegui.SimpleWindow) {
	expr := win.get_text('display')
	parts := expr.split(' ')
	if parts.len < 3 {
		return
	}
	mut result := parts[0].int()
	mut i := 1
	for i < parts.len - 1 {
		op := parts[i]
		next_val := parts[i + 1].int()
		match op {
			'+' { result += next_val }
			'-' { result -= next_val }
			'*' { result *= next_val }
			'/' {
				if next_val == 0 {
					win.set_text('display', 'Error')
					win.set_status('Error: Division by zero')
					return
				}
				result /= next_val
			}
			else {}
		}
		i += 2
	}
	win.set_text('display', result.str())
	win.set_status('Calculated result')
}
