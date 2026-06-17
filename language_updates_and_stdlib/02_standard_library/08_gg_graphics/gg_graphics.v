module main

import gg
import math

// AppContext holds the state of our graphical application.
// Using a state struct is a recommended best practice for gg applications
// to avoid global variables (which V does not support by default).
struct AppContext {
mut:
	ctx          &gg.Context = unsafe { nil }
	width        int  = 800
	height       int  = 600
	// Interactive shape parameters
	shape_x      f32  = 400.0
	shape_y      f32  = 300.0
	shape_size   f32  = 50.0
	shape_color  gg.Color = gg.blue
	active_shape int  // 0 = Circle, 1 = Rectangle, 2 = Triangle
	// Tracking mouse positions and clicks
	mouse_x      f32
	mouse_y      f32
	click_x      f32  = -1.0
	click_y      f32  = -1.0
	click_color  gg.Color = gg.red
	// Last key pressed message
	last_key     string = 'None'
}

fn main() {
	// Initialize state
	mut app := &AppContext{
		width: 800
		height: 600
	}

	// Create a new gg context.
	// You specify callbacks for rendering frames, processing events,
	// and cleanups, along with initial window configurations.
	app.ctx = gg.new_context(
		width:        app.width
		height:       app.height
		window_title: "V's gg graphics module: Tutorial & Interactive Demo"
		bg_color:     gg.rgb(240, 244, 248) // A subtle modern light-blue background
		user_data:    app                 // Pass our state struct to be accessible inside callbacks
		frame_fn:     frame               // Callback called once per frame (to draw shapes/UI)
		event_fn:     on_event            // Callback called for user inputs (mouse & keyboard)
	)

	println('Starting interactive graphics window...')
	println('Controls:')
	println('  - Move the mouse to see cursor position tracking.')
	println('  - Left-Click anywhere to draw a red dot at the click location.')
	println('  - Use Arrow Keys (Up/Down/Left/Right) to move the active shape.')
	println('  - Press [C] or [c] to cycle the active shape\'s color.')
	println('  - Press [S] or [s] to toggle between Circle, Rectangle, and Triangle.')
	println('  - Press [Escape] to close the window.')
	println('\nReal-world Case Study:')
	println('  - Check out a complete journaling application built with gg:')
	println('    https://github.com/codecaine-zz/MindSpace-Journal')

	// Start the application main event loop.
	app.ctx.run()
}

// frame is the drawing function called per frame.
// All rendering code MUST reside between ctx.begin() and ctx.end().
fn frame(data voidptr) {
	mut app := unsafe { &AppContext(data) }
	mut ctx := app.ctx
	ctx.begin()

	// --- 1. Draw Static 2D Shapes ---
	
	// Draw a thick horizontal line dividing the header from the demo workspace
	ctx.draw_line(0, 80, app.width, 80, gg.gray)

	// Draw a filled rectangle (Left)
	ctx.draw_rect_filled(50, 120, 120, 80, gg.green)
	// Draw an empty/outline rectangle just next to it
	ctx.draw_rect_empty(200, 120, 120, 80, gg.dark_gray)

	// Draw a filled circle (Middle-Left)
	ctx.draw_circle_filled(430, 160, 45, gg.orange)
	// Draw an empty/outline circle
	ctx.draw_circle_empty(560, 160, 45, gg.purple)

	// Draw a filled triangle (Middle-Right)
	ctx.draw_triangle_filled(700, 115, 750, 205, 650, 205, gg.pink)

	// Draw a custom convex polygon (a star-like pentagon, bottom right)
	poly_points := [
		f32(650.0), 480.0, // Point 1
		750.0, 480.0,      // Point 2
		780.0, 560.0,      // Point 3
		700.0, 520.0,      // Point 4
		620.0, 560.0       // Point 5
	]
	ctx.draw_convex_poly(poly_points, gg.cyan)

	// --- 2. Render Text using custom configurations (TextCfg) ---

	// Main Title with default configuration
	ctx.draw_text_def(20, 15, "Welcome to V's Simple Graphics (gg) Tutorial!")

	// Instructions and state metadata at the top right
	ctx.draw_text(20, 45, 'Cursor: (${app.mouse_x:.1f}, ${app.mouse_y:.1f}) | Last Key: ${app.last_key}',
		color: gg.dark_blue
		size: 16
		bold: true
	)

	// Context description
	ctx.draw_text(50, 215, 'Filled & Empty Rectangles', size: 12, color: gg.dark_gray)
	ctx.draw_text(400, 215, 'Filled & Empty Circles', size: 12, color: gg.dark_gray)
	ctx.draw_text(650, 215, 'Filled Triangle', size: 12, color: gg.dark_gray)
	ctx.draw_text(630, 570, 'Convex Polygon (Pentagon)', size: 12, color: gg.dark_gray)

	// Help panel explaining key bindings
	ctx.draw_rect_filled(20, 440, 280, 140, gg.Color{r: 255, g: 255, b: 255, a: 180})
	ctx.draw_rect_empty(20, 440, 280, 140, gg.gray)
	ctx.draw_text(35, 450, 'Controls Panel', size: 15, bold: true, color: gg.black)
	ctx.draw_text(35, 475, '- Arrows: Move active shape', size: 13, color: gg.black)
	ctx.draw_text(35, 495, '- C: Cycle shape color', size: 13, color: gg.black)
	ctx.draw_text(35, 515, '- S: Switch shape type', size: 13, color: gg.black)
	ctx.draw_text(35, 535, '- Mouse Click: Draw a dot', size: 13, color: gg.black)
	ctx.draw_text(35, 555, '- Escape: Quit application', size: 13, color: gg.black)

	// Case Study reference
	ctx.draw_text(20, 585, 'Case Study: github.com/codecaine-zz/MindSpace-Journal', size: 10, italic: true, color: gg.dark_blue)

	// --- 3. Draw Dynamic / Interactive Elements ---

	// Draw a dot where the user clicked, if a click has occurred
	if app.click_x >= 0.0 {
		ctx.draw_circle_filled(app.click_x, app.click_y, 8, app.click_color)
		ctx.draw_circle_empty(app.click_x, app.click_y, 12, gg.black)
		ctx.draw_text(int(app.click_x) + 12, int(app.click_y) - 6, 'Last Click: (${app.click_x:.0f}, ${app.click_y:.0f})',
			size: 11
			color: gg.black
		)
	}

	// Draw the active shape controlled by the user
	match app.active_shape {
		0 {
			// Draw interactive Circle
			ctx.draw_circle_filled(app.shape_x, app.shape_y, app.shape_size, app.shape_color)
			ctx.draw_circle_empty(app.shape_x, app.shape_y, app.shape_size, gg.black)
		}
		1 {
			// Draw interactive Rectangle (centered on coordinates)
			half := app.shape_size
			ctx.draw_rect_filled(app.shape_x - half, app.shape_y - half, app.shape_size * 2, app.shape_size * 2, app.shape_color)
			ctx.draw_rect_empty(app.shape_x - half, app.shape_y - half, app.shape_size * 2, app.shape_size * 2, gg.black)
		}
		2 {
			// Draw interactive Equilateral Triangle (centered on coordinates)
			// Using trigonometry to draw an equilateral triangle of size `shape_size`
			h := app.shape_size * f32(math.sqrt(3.0)) / 2.0
			x1 := app.shape_x
			y1 := app.shape_y - (2.0 / 3.0) * h
			x2 := app.shape_x - app.shape_size
			y2 := app.shape_y + (1.0 / 3.0) * h
			x3 := app.shape_x + app.shape_size
			y3 := app.shape_y + (1.0 / 3.0) * h
			ctx.draw_triangle_filled(x1, y1, x2, y2, x3, y3, app.shape_color)
		}
		else {}
	}

	// Draw label above the active shape
	ctx.draw_text(int(app.shape_x) - 40, int(app.shape_y) - int(app.shape_size) - 20, 'Active Shape',
		size: 13
		bold: true
		color: gg.black
	)

	ctx.end()
}

// on_event intercepts and handles all system-level user inputs.
fn on_event(e &gg.Event, data voidptr) {
	mut app := unsafe { &AppContext(data) }
	mut ctx := app.ctx

	match e.typ {
		.mouse_move {
			app.mouse_x = e.mouse_x
			app.mouse_y = e.mouse_y
		}
		.mouse_down {
			app.click_x = e.mouse_x
			app.click_y = e.mouse_y
			// Randomize click dot color slightly for visual variety
			if app.click_color.r == 255 {
				app.click_color = gg.Color{r: 0, g: 180, b: 0, a: 255}
			} else {
				app.click_color = gg.red
			}
		}
		.key_down {
			app.last_key = e.key_code.str()

			match e.key_code {
				.escape {
					ctx.quit()
				}
				// Change Color when 'C' or 'c' is pressed
				.c {
					if app.shape_color.r == 0 && app.shape_color.b == 255 { // blue -> red
						app.shape_color = gg.red
					} else if app.shape_color.r == 255 && app.shape_color.g == 0 { // red -> green
						app.shape_color = gg.green
					} else { // green -> blue
						app.shape_color = gg.blue
					}
				}
				// Toggle shape type when 'S' or 's' is pressed
				.s {
					app.active_shape = (app.active_shape + 1) % 3
				}
				// Use Arrow Keys to move the active shape
				.left {
					app.shape_x -= 15.0
					if app.shape_x < 0 { app.shape_x = 0 }
				}
				.right {
					app.shape_x += 15.0
					if app.shape_x > app.width { app.shape_x = f32(app.width) }
				}
				.up {
					app.shape_y -= 15.0
					if app.shape_y < 80 { app.shape_y = 80 } // Keep below divider line
				}
				.down {
					app.shape_y += 15.0
					if app.shape_y > app.height { app.shape_y = f32(app.height) }
				}
				else {}
			}
		}
		else {}
	}
}
