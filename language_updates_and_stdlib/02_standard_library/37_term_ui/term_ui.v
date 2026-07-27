module main

// Import the terminal UI module from V's standard library
import term.ui as tui

// Button represents an interactive mouse-clickable TUI button
struct Button {
	id     string
	label  string
	x      int
	y      int
	width  int
	height int
}

// App struct stores complete application state across render frames and events
struct App {
mut:
	tui &tui.Context = unsafe { nil }
	// Navigation Tabs
	active_tab int // 0: Form & Controls, 1: Drawing Primitives, 2: Event Stream Log
	tab_titles []string
	// Form & Widget State
	text_input        string
	input_focused     bool
	counter           int
	show_grid         bool
	dark_mode         bool
	selected_option   int
	radio_options     []string
	// Buttons list
	buttons []Button
	// Event Stream Log (last 10 events)
	event_log []string
	// Mouse tracking
	mouse_x      int
	mouse_y      int
	hovered_btn  string
	clicked_btn  string
	scroll_state string
}

// log_event adds a formatted message to the event log buffer
fn (mut app App) log_event(msg string) {
	app.event_log << msg
	if app.event_log.len > 10 {
		app.event_log.delete(0)
	}
}

// frame_fn is called automatically on every render cycle (at 30 FPS)
fn frame_fn(x voidptr) {
	mut app := unsafe { &App(x) }

	// 1. Clear previous frame contents from screen buffer
	app.tui.clear()

	// 2. Main Color Scheme depending on Dark Mode toggle
	bg_r, bg_g, bg_b := if app.dark_mode { u8(15), u8(18), u8(28) } else { u8(30), u8(45), u8(70) }
	accent_r, accent_g, accent_b := u8(0), u8(180), u8(220)

	// 3. Render Top Navigation Bar & Tabs
	app.tui.set_bg_color(r: bg_r, g: bg_g, b: bg_b)
	app.tui.set_color(r: 255, g: 255, b: 255)
	app.tui.bold()
	header := ' === V term.ui Interactive Widgets & Event Inspector === [Res: ${app.tui.window_width}x${app.tui.window_height}] '
	app.tui.draw_text(2, 1, header)
	app.tui.reset()

	// Draw Tab Buttons (using macOS-friendly standard 1, 2, 3 shortcuts)
	mut tab_x := 4
	for i in 0 .. app.tab_titles.len {
		title := app.tab_titles[i]
		if i == app.active_tab {
			app.tui.set_bg_color(r: accent_r, g: accent_g, b: accent_b)
			app.tui.set_color(r: 255, g: 255, b: 255)
			app.tui.bold()
		} else {
			app.tui.set_bg_color(r: 60, g: 70, b: 90)
			app.tui.set_color(r: 200, g: 200, b: 200)
		}
		tab_btn_text := ' [ ${i + 1} ] ${title} '
		app.tui.draw_text(tab_x, 3, tab_btn_text)
		app.tui.reset()
		tab_x += tab_btn_text.len + 2
	}

	app.tui.horizontal_separator(4)

	// 4. Render Active Tab Content
	match app.active_tab {
		0 {
			// ==========================================
			// TAB 0: Interactive Form, Textbox & Buttons
			// ==========================================
			app.tui.set_color(r: 255, g: 220, b: 0)
			app.tui.bold()
			app.tui.draw_text(4, 6, '1. Interactive Text Input Box (Click or Press TAB to focus)')
			app.tui.reset()

			// Textbox Container
			input_bg_r, input_bg_g, input_bg_b := if app.input_focused {
				u8(40), u8(60), u8(100)
			} else {
				u8(25), u8(30), u8(45)
			}
			app.tui.set_bg_color(r: input_bg_r, g: input_bg_g, b: input_bg_b)
			app.tui.set_color(r: 255, g: 255, b: 255)
			app.tui.draw_rect(4, 7, 54, 9)

			cursor_char := if app.input_focused && (app.tui.frame_count / 15) % 2 == 0 {
				'|'
			} else {
				''
			}
			display_text := if app.text_input == '' {
				'Type text here...'
			} else {
				app.text_input
			}
			app.tui.draw_text(6, 8, '> ${display_text}${cursor_char}')
			app.tui.reset()

			// Interactive Buttons Section
			app.tui.set_color(r: 255, g: 220, b: 0)
			app.tui.bold()
			app.tui.draw_text(4, 11, '2. Clickable UI Buttons & Counter State')
			app.tui.reset()

			// Render Buttons
			for btn in app.buttons {
				is_hover := app.hovered_btn == btn.id
				is_click := app.clicked_btn == btn.id

				b_r, b_g, b_b := if is_click {
					u8(255), u8(140), u8(0)
				} else if is_hover {
					u8(0), u8(150), u8(220)
				} else {
					u8(50), u8(70), u8(100)
				}

				app.tui.set_bg_color(r: b_r, g: b_g, b: b_b)
				app.tui.set_color(r: 255, g: 255, b: 255)
				app.tui.bold()
				app.tui.draw_rect(btn.x, btn.y, btn.x + btn.width, btn.y + btn.height)
				app.tui.draw_text(btn.x + 2, btn.y + 1, btn.label)
				app.tui.reset()
			}

			// Display Counter Value
			app.tui.set_color(r: 0, g: 255, b: 180)
			app.tui.bold()
			app.tui.draw_text(4, 15, 'Current Counter Value: ${app.counter}')
			app.tui.reset()

			// Checkboxes & Radio Selectors Section
			app.tui.set_color(r: 255, g: 220, b: 0)
			app.tui.bold()
			app.tui.draw_text(4, 17, '3. Checkbox & Radio Controls')
			app.tui.reset()

			chk_grid := if app.show_grid { '[X]' } else { '[ ]' }
			chk_dark := if app.dark_mode { '[X]' } else { '[ ]' }
			app.tui.draw_text(4, 18, '${chk_grid} Show Grid (Click to toggle)')
			app.tui.draw_text(32, 18, '${chk_dark} Dark Mode Theme (Click to toggle)')

			app.tui.draw_text(4, 20, 'Select Speed Mode:')
			for idx, opt in app.radio_options {
				selected_str := if idx == app.selected_option { '(•)' } else { '( )' }
				app.tui.draw_text(4 + idx * 16, 21, '${selected_str} ${opt}')
			}
		}
		1 {
			// ==========================================
			// TAB 1: Graphics & Drawing Canvas
			// ==========================================
			app.tui.set_color(r: 0, g: 220, b: 255)
			app.tui.bold()
			app.tui.draw_text(4, 6, '=== Canvas Graphics & Drawing Primitives ===')
			app.tui.reset()

			// Filled Rect
			app.tui.set_bg_color(r: 180, g: 40, b: 80)
			app.tui.draw_rect(4, 8, 30, 12)
			app.tui.reset_bg_color()
			app.tui.set_color(r: 255, g: 255, b: 255)
			app.tui.draw_text(6, 10, 'Filled Rect (draw_rect)')

			// Outline Rect
			app.tui.set_color(r: 0, g: 255, b: 150)
			app.tui.draw_empty_rect(34, 8, 60, 12)
			app.tui.draw_text(36, 10, 'Outline Rect (draw_empty_rect)')

			// Dashed Line & Dashed Rect
			app.tui.set_color(r: 255, g: 200, b: 0)
			app.tui.draw_dashed_line(4, 14, 30, 14)
			app.tui.draw_text(4, 15, 'Dashed Line (draw_dashed_line)')

			app.tui.draw_empty_dashed_rect(34, 14, 60, 17)
			app.tui.draw_text(36, 15, 'Dashed Rect (draw_empty_dashed_rect)')
			app.tui.reset()
		}
		else {
			// ==========================================
			// TAB 2: Real-time Event Log Inspector
			// ==========================================
			app.tui.set_color(r: 255, g: 180, b: 0)
			app.tui.bold()
			app.tui.draw_text(4, 6, '=== Live Input Event Stream (Last 10 Events) ===')
			app.tui.reset()

			app.tui.draw_empty_rect(4, 7, 85, 19)

			for i, log_entry in app.event_log {
				app.tui.set_color(r: 200, g: 220, b: 255)
				app.tui.draw_text(6, 8 + i, '[#${i + 1}] ${log_entry}')
			}
			app.tui.reset()
		}
	}

	// 5. Footer Status & macOS-friendly Shortcuts
	app.tui.horizontal_separator(21)
	app.tui.set_color(r: 180, g: 180, b: 180)
	app.tui.draw_text(4, 22, 'Mouse Pos: X=${app.mouse_x}, Y=${app.mouse_y} | Scroll: ${app.scroll_state} | Active Hover: "${app.hovered_btn}"')
	app.tui.draw_text(4, 23, 'Shortcuts: [1-3] Switch Tabs | [TAB] Focus Textbox | [ESC] or "q" Quit')
	app.tui.reset()

	app.tui.set_cursor_position(0, 0)
	app.tui.reset()
	app.tui.flush()
}

// event_fn handles keyboard, mouse, and window resize events
fn event_fn(e &tui.Event, x voidptr) {
	mut app := unsafe { &App(x) }

	match e.typ {
		.key_down {
			app.log_event('Key Down: Code=${e.code} (${int(e.code)}) | Modifiers=${e.modifiers} | Utf8="${e.utf8}"')

			// Mac-friendly Tab switching shortcuts (1, 2, 3 or Escape/q for quit)
			match e.code {
				.escape, .q {
					if !app.input_focused || e.code == .escape {
						exit(0)
					}
				}
				.tab {
					app.input_focused = !app.input_focused
				}
				._1, .f1 {
					if !app.input_focused || e.code == .f1 {
						app.active_tab = 0
					}
				}
				._2, .f2 {
					if !app.input_focused || e.code == .f2 {
						app.active_tab = 1
					}
				}
				._3, .f3 {
					if !app.input_focused || e.code == .f3 {
						app.active_tab = 2
					}
				}
				else {}
			}

			// Textbox Input Editing
			if app.input_focused {
				match e.code {
					.backspace {
						if app.text_input.len > 0 {
							app.text_input = app.text_input[..app.text_input.len - 1]
						}
					}
					.enter {
						app.log_event('Submitted Text: "${app.text_input}"')
					}
					else {
						if e.utf8.len > 0 && e.code != .tab && e.code != .escape {
							app.text_input += e.utf8
						}
					}
				}
			}
		}
		.mouse_move {
			app.mouse_x = e.x
			app.mouse_y = e.y

			// Detect button hover
			mut found_hover := ''
			for btn in app.buttons {
				if app.active_tab == 0 && e.x >= btn.x && e.x <= btn.x + btn.width
					&& e.y >= btn.y && e.y <= btn.y + btn.height {
					found_hover = btn.id
					break
				}
			}
			app.hovered_btn = found_hover
		}
		.mouse_down {
			app.mouse_x = e.x
			app.mouse_y = e.y
			app.log_event('Mouse Click: Btn=${e.button} at (${e.x}, ${e.y})')

			// 1. Check Tab Clicks
			if e.y == 3 {
				if e.x >= 4 && e.x <= 18 {
					app.active_tab = 0
				} else if e.x >= 20 && e.x <= 36 {
					app.active_tab = 1
				} else if e.x >= 38 && e.x <= 56 {
					app.active_tab = 2
				}
			}

			// 2. Check Textbox Focus Click
			if app.active_tab == 0 && e.x >= 4 && e.x <= 54 && e.y >= 7 && e.y <= 9 {
				app.input_focused = true
			} else if app.active_tab == 0 && (e.y < 7 || e.y > 9) {
				app.input_focused = false
			}

			// 3. Check Button Clicks
			if app.active_tab == 0 {
				for btn in app.buttons {
					if e.x >= btn.x && e.x <= btn.x + btn.width && e.y >= btn.y
						&& e.y <= btn.y + btn.height {
						app.clicked_btn = btn.id
						match btn.id {
							'inc' {
								app.counter++
								app.log_event('Button Click: Counter Incremented to ${app.counter}')
							}
							'dec' {
								app.counter--
								app.log_event('Button Click: Counter Decremented to ${app.counter}')
							}
							'clear' {
								app.text_input = ''
								app.log_event('Button Click: Text Input Cleared')
							}
							'reset' {
								app.counter = 0
								app.log_event('Button Click: Counter Reset to 0')
							}
							else {}
						}
						break
					}
				}

				// Checkbox Toggles
				if e.y == 18 {
					if e.x >= 4 && e.x <= 20 {
						app.show_grid = !app.show_grid
						app.log_event('Toggle Grid: ${app.show_grid}')
					} else if e.x >= 32 && e.x <= 52 {
						app.dark_mode = !app.dark_mode
						app.log_event('Toggle Dark Mode: ${app.dark_mode}')
					}
				}

				// Radio Options
				if e.y == 21 {
					if e.x >= 4 && e.x <= 16 {
						app.selected_option = 0
						app.log_event('Selected Speed: Slow')
					} else if e.x >= 20 && e.x <= 32 {
						app.selected_option = 1
						app.log_event('Selected Speed: Normal')
					} else if e.x >= 36 && e.x <= 48 {
						app.selected_option = 2
						app.log_event('Selected Speed: Fast')
					}
				}
			}
		}
		.mouse_up {
			app.clicked_btn = ''
		}
		.mouse_scroll {
			app.scroll_state = '${e.direction}'
			app.log_event('Mouse Scroll: Direction=${e.direction} at (${e.x}, ${e.y})')
		}
		.resized {
			app.log_event('Window Resized: Width=${app.tui.window_width}, Height=${app.tui.window_height}')
		}
		else {}
	}
}

fn main() {
	mut app := &App{
		tab_titles:    ['Controls & Form', 'Canvas Drawing', 'Event Log Stream']
		text_input:    'Hello Vlang term.ui!'
		counter:       10
		show_grid:     true
		dark_mode:     true
		radio_options: ['Slow', 'Normal', 'Fast']
		buttons:       [
			Button{
				id:     'inc'
				label:  '[ + ] Increment'
				x:      4
				y:      12
				width:  16
				height: 2
			},
			Button{
				id:     'dec'
				label:  '[ - ] Decrement'
				x:      22
				y:      12
				width:  16
				height: 2
			},
			Button{
				id:     'reset'
				label:  '[ R ] Reset'
				x:      40
				y:      12
				width:  12
				height: 2
			},
			Button{
				id:     'clear'
				label:  '[ C ] Clear Text'
				x:      54
				y:      12
				width:  16
				height: 2
			},
		]
	}

	app.tui = tui.init(
		user_data:      app
		frame_fn:       frame_fn
		event_fn:       event_fn
		window_title:   'V Comprehensive Terminal GUI & Widgets'
		hide_cursor:    true
		capture_events: true
		frame_rate:     30
		buffer_size:    256
	)

	app.tui.run()!
}
