module simplegui

#include <Cocoa/Cocoa.h>
#include "@VMODROOT/simplegui/window.h"
#flag -framework Cocoa
#flag -framework WebKit
#flag @VMODROOT/simplegui/window.m

fn C.window_app_init(&WindowParams) &WindowInfo
fn C.window_app_run(&WindowInfo)
fn C.window_set_title_text(&WindowInfo, &u8)
fn C.window_set_status_text(&WindowInfo, &u8)
fn C.window_set_always_on_top(&WindowInfo, int)
fn C.window_get_always_on_top(&WindowInfo) int
fn C.window_set_background_color(&WindowInfo, &u8)
fn C.window_set_padding(&WindowInfo, int)
fn C.window_set_spacing(&WindowInfo, int)
fn C.window_set_responsive_layout(&WindowInfo, int)
fn C.window_add_group_box_control(&WindowInfo, &u8, &u8) voidptr
fn C.window_add_tabs_control(&WindowInfo, &u8, &&u8, int) voidptr
fn C.window_add_scroll_view_control(&WindowInfo, &u8, int) voidptr
fn C.window_focus_control(&WindowInfo, &u8)
fn C.window_set_placeholder_by_name(&WindowInfo, &u8, &u8)
fn C.window_set_error_by_name(&WindowInfo, &u8, &u8)
fn C.window_set_tooltip_by_name(&WindowInfo, &u8, &u8)
fn C.window_set_default_button_by_name(&WindowInfo, &u8)
fn C.window_run_after(&WindowInfo, int, &u8)
fn C.window_show_toast(&WindowInfo, &u8)
fn C.window_open_url(&WindowInfo, &u8)
fn C.window_copy_to_clipboard(&WindowInfo, &u8)
fn C.window_set_font_color(&WindowInfo, &u8)
fn C.window_set_control_background_color_by_name(&WindowInfo, &u8, &u8)
fn C.window_set_control_font_color_by_name(&WindowInfo, &u8, &u8)
fn C.window_set_control_width_by_name(&WindowInfo, &u8, int)
fn C.window_set_control_height_by_name(&WindowInfo, &u8, int)
fn C.window_set_control_font_size_by_name(&WindowInfo, &u8, int)
fn C.window_set_control_font_bold_by_name(&WindowInfo, &u8, int)
fn C.window_set_control_font_name_by_name(&WindowInfo, &u8, &u8)
fn C.window_show_choice_dialog(&WindowInfo, &u8, &u8, &&u8, int) int
fn C.window_add_context_menu_item(&WindowInfo, &u8, &u8, &u8)

// Dialogs and Message boxes
fn C.window_show_alert(&WindowInfo, &u8, &u8)
fn C.window_show_alert_with_style(&WindowInfo, &u8, &u8, &u8)
fn C.window_show_confirm(&WindowInfo, &u8, &u8) int
fn C.window_show_prompt(&WindowInfo, &u8, &u8, &u8) &u8

// File Panels
fn C.window_select_file(&WindowInfo) &u8
fn C.window_select_file_with_extensions(&WindowInfo, &u8) &u8
fn C.window_select_folder(&WindowInfo) &u8
fn C.window_save_file_picker(&WindowInfo) &u8

// Visibility & Enabled
fn C.window_set_control_visible_by_name(&WindowInfo, &u8, int)
fn C.window_get_control_visible_by_name(&WindowInfo, &u8) int
fn C.window_set_control_enabled_by_name(&WindowInfo, &u8, int)
fn C.window_get_control_enabled_by_name(&WindowInfo, &u8) int

// Timers
fn C.window_set_interval(&WindowInfo, int, &u8)
fn C.window_stop_interval(&WindowInfo, &u8)

// List Box and Image View Controls
fn C.window_add_list_box_control(&WindowInfo, &u8, &&u8, int) voidptr
fn C.window_update_list_items(&WindowInfo, &u8, &&u8, int)
fn C.window_set_list_selected(&WindowInfo, &u8, int)
fn C.window_get_list_selected(&WindowInfo, &u8) int
fn C.window_add_image_control(&WindowInfo, &u8, &u8) voidptr
fn C.window_set_image_path(&WindowInfo, &u8, &u8)

// Hover tracking
fn C.window_enable_hover_events(&WindowInfo, &u8)

// Menu Customization
fn C.window_add_menu_item(&WindowInfo, &u8, &u8, &u8, &u8)

// Name-based generic control accessors
fn C.window_set_control_text_by_name(&WindowInfo, &u8, &u8)
fn C.window_get_control_text_by_name(&WindowInfo, &u8) &u8
fn C.window_set_control_bool_by_name(&WindowInfo, &u8, int)
fn C.window_get_control_bool_by_name(&WindowInfo, &u8) int
fn C.window_set_control_int_by_name(&WindowInfo, &u8, int)
fn C.window_get_control_int_by_name(&WindowInfo, &u8) int

// Dynamic control creation bridges
fn C.window_add_label_control(&WindowInfo, &u8, &u8) voidptr
fn C.window_add_input_control(&WindowInfo, &u8, &u8) voidptr
fn C.window_add_password_control(&WindowInfo, &u8, &u8) voidptr
fn C.window_add_textarea_control(&WindowInfo, &u8, &u8) voidptr
fn C.window_add_html_view_control(&WindowInfo, &u8, &u8) voidptr
fn C.window_add_drop_zone_control(&WindowInfo, &u8, &u8) voidptr
fn C.window_add_checkbox_control(&WindowInfo, &u8, &u8, int) voidptr
fn C.window_add_button_control(&WindowInfo, &u8, &u8) voidptr
fn C.window_add_number_control(&WindowInfo, &u8, int) voidptr
fn C.window_add_slider_control(&WindowInfo, &u8, int) voidptr
fn C.window_add_theme_menu_control(&WindowInfo, &u8, &u8) voidptr
fn C.window_add_color_well_control(&WindowInfo, &u8, &u8) voidptr
fn C.window_add_date_picker_control(&WindowInfo, &u8, &u8) voidptr
fn C.window_add_mode_control_control(&WindowInfo, &u8, &u8) voidptr
fn C.window_add_progress_indicator_control(&WindowInfo, &u8, int) voidptr

// Layout row groupings
fn C.window_begin_row(&WindowInfo, &u8)
fn C.window_end_row(&WindowInfo)

// Spacers and Separators
fn C.window_add_vertical_spacer(&WindowInfo, int)
fn C.window_add_horizontal_spacer(&WindowInfo, int)
fn C.window_add_separator(&WindowInfo)

// Multi-Column Table Controls
fn C.window_add_table_control(&WindowInfo, &u8, &&u8, int) voidptr
fn C.window_set_table_rows(&WindowInfo, &u8, &&u8, int, int)

// Tree View Controls
fn C.window_add_tree_view_control(&WindowInfo, &u8, int) voidptr
fn C.window_set_tree_nodes(&WindowInfo, &u8, &&u8, int)
fn C.window_get_tree_selected(&WindowInfo, &u8) &u8
fn C.window_set_tree_selected(&WindowInfo, &u8, &u8)

// System Menu Bar/Tray App Mode
fn C.window_enable_status_bar(&WindowInfo, &u8)
fn C.window_show(&WindowInfo)

// Thread Safety Runner
fn C.window_run_on_main_thread(voidptr, voidptr)

// New general-purpose controls
fn C.window_add_dropdown_control(&WindowInfo, &u8, &&u8, int, &u8) voidptr
fn C.window_add_segmented_control_custom(&WindowInfo, &u8, &&u8, int, &u8) voidptr
fn C.window_add_radio_group_control(&WindowInfo, &u8, &&u8, int, &u8) voidptr
fn C.window_add_switch_control(&WindowInfo, &u8, &u8, int) voidptr
fn C.window_add_search_field_control(&WindowInfo, &u8, &u8) voidptr
fn C.window_add_combo_box_control(&WindowInfo, &u8, &&u8, int, &u8) voidptr
fn C.window_add_level_indicator_control(&WindowInfo, &u8, int, int, int, int) voidptr
fn C.window_add_spinner_control(&WindowInfo, &u8, int) voidptr
fn C.window_add_path_control(&WindowInfo, &u8, &u8) voidptr
fn C.window_add_token_field_control(&WindowInfo, &u8, &u8) voidptr

// Window constraints and behavior options
fn C.window_set_min_size(&WindowInfo, int, int)
fn C.window_set_max_size(&WindowInfo, int, int)
fn C.window_set_resizable(&WindowInfo, int)
fn C.window_set_minimizable(&WindowInfo, int)
fn C.window_set_maximizable(&WindowInfo, int)

// Additional Window Operations
fn C.window_close(&WindowInfo)
fn C.window_hide(&WindowInfo)
fn C.window_center(&WindowInfo)
fn C.window_set_size(&WindowInfo, int, int)
fn C.window_get_width(&WindowInfo) int
fn C.window_get_height(&WindowInfo) int
fn C.window_set_position(&WindowInfo, int, int)
fn C.window_get_x(&WindowInfo) int
fn C.window_get_y(&WindowInfo) int
fn C.window_set_opacity(&WindowInfo, f64)
fn C.window_get_opacity(&WindowInfo) f64
fn C.window_toggle_fullscreen(&WindowInfo)
fn C.window_minimize(&WindowInfo)
fn C.window_deminimize(&WindowInfo)
fn C.window_maximize(&WindowInfo)
fn C.window_is_minimized(&WindowInfo) int
fn C.window_is_maximized(&WindowInfo) int
fn C.window_is_fullscreen(&WindowInfo) int
fn C.window_is_active(&WindowInfo) int
fn C.window_set_titlebar_visible(&WindowInfo, int)

pub type StringEventCallback = fn (mut win SimpleWindow, value string)

pub type VoidEventCallback = fn (mut win SimpleWindow)

pub type FileDropCallback = fn (mut win SimpleWindow, files []string)

pub type ControlValidator = fn (value string) string

pub struct WindowConfig {
	pub mut:
		title             string
		width             int
		height            int
		padding           int
		spacing           int
		background_color  string
		font_color        string
		always_on_top     bool
		responsive_layout bool
		resizable         bool
		minimizable       bool
		maximizable       bool
}

pub struct WindowParams {
	title             string
	width             int
	height            int
	win_ptr           voidptr
	padding           int
	spacing           int
	always_on_top     int
	responsive_layout int
	resizable         int
	minimizable       int
	maximizable       int
}

pub struct WindowInfo {
	app          voidptr
	app_delegate voidptr
}

@[heap]
pub struct SimpleWindow {
mut:
	window_info       &WindowInfo = unsafe { nil }
	width             int
	height            int
	title             string
	controls          []ControlEntry
	status_text       string
	handlers          []ControlEventHandler
	background_color  string
	font_color        string
	padding           int
	spacing           int
	always_on_top     bool
	responsive_layout bool = true
	placeholders      map[string]string
	errors            map[string]string
	default_button    string
	debug_mode        bool
	last_control      string
	min_width         int
	min_height        int
	max_width         int
	max_height        int
	resizable         bool = true
	minimizable       bool = true
	maximizable       bool = true
}

struct ControlEntry {
mut:
	name             string
	kind             string
	label            string
	value            string
	checked          bool
	number           int
	background_color string
	font_color       string
	width            int
	height           int
	font_size        int
	initial_value    string
	initial_checked  bool
	initial_number   int
	placeholder      string
	error_text       string
}

struct ControlEventHandler {
mut:
	control_name string
	event_name   string
	filter_value string
	string_cb    StringEventCallback = unsafe { nil }
	void_cb      VoidEventCallback   = unsafe { nil }
	file_drop_cb FileDropCallback    = unsafe { nil }
}

pub fn new_simple_window(title string, width int, height int) &SimpleWindow {
	mut win := &SimpleWindow{
		width:             width
		height:            height
		title:             title
		responsive_layout: true
		resizable:         true
		minimizable:       true
		maximizable:       true
	}
	win.placeholders = map[string]string{}
	win.errors = map[string]string{}
	win.ensure_window()
	return win
}

fn (win &SimpleWindow) ensure_window() {
	if win.window_info == unsafe { nil } {
		params := WindowParams{
			title:             win.title
			width:             win.width
			height:            win.height
			win_ptr:           win
			padding:           win.padding
			spacing:           win.spacing
			always_on_top:     if win.always_on_top { 1 } else { 0 }
			responsive_layout: if win.responsive_layout { 1 } else { 0 }
			resizable:         if win.resizable { 1 } else { 0 }
			minimizable:       if win.minimizable { 1 } else { 0 }
			maximizable:       if win.maximizable { 1 } else { 0 }
		}
		unsafe {
			mut w := &SimpleWindow(win)
			w.window_info = C.window_app_init(&params)
		}
	}
}

pub fn (win &SimpleWindow) has_control(name string) bool {
	return win.find_control(name) >= 0
}

pub fn (win &SimpleWindow) list_controls() []string {
	mut names := []string{}
	for control in win.controls {
		names << control.name
	}
	return names
}

pub fn (win &SimpleWindow) get_control_kind(name string) string {
	idx := win.find_control(name)
	if idx >= 0 {
		return win.controls[idx].kind
	}
	return ''
}

pub fn (win &SimpleWindow) require_control(name string) string {
	if win.has_control(name) {
		return name
	}
	panic('Control "${name}" was not found. Create it first with add_input/add_button/etc.')
}

fn (win &SimpleWindow) find_control(name string) int {
	for i, control in win.controls {
		if control.name == name {
			return i
		}
	}
	return -1
}

fn (win &SimpleWindow) find_handler(control_name string, event_name string) int {
	for i, handler in win.handlers {
		if handler.control_name == control_name && handler.event_name == event_name
			&& handler.filter_value == '' {
			return i
		}
	}
	return -1
}

fn (win &SimpleWindow) find_handler_by_filter(control_name string, event_name string, filter_value string) int {
	for i, handler in win.handlers {
		if handler.control_name == control_name && handler.event_name == event_name
			&& (handler.filter_value == '' || handler.filter_value == filter_value) {
			return i
		}
	}
	return -1
}

fn (win &SimpleWindow) auto_name(kind string) string {
	return 'auto_${kind}_${win.controls.len}'
}

fn (win &SimpleWindow) upsert_control(name string, kind string, label string, value string, checked bool, number int) {
	idx := win.find_control(name)
	mut entry := ControlEntry{
		name:            name
		kind:            kind
		label:           label
		value:           value
		checked:         checked
		number:          number
		initial_value:   value
		initial_checked: checked
		initial_number:  number
	}
	unsafe {
		mut w := &SimpleWindow(win)
		w.last_control = name
		if idx >= 0 {
			entry = w.controls[idx]
			entry.kind = kind
			entry.label = label
			entry.value = value
			entry.checked = checked
			entry.number = number
			entry.background_color = w.controls[idx].background_color
			entry.font_color = w.controls[idx].font_color
			w.controls[idx] = entry
		} else {
			w.controls << entry
		}
	}
}

// Control creation methods
pub fn (win &SimpleWindow) add_label(name string, text string) &SimpleWindow {
	mut real_name := name
	if real_name == '' {
		real_name = win.auto_name('label')
	}
	if win.debug_mode {
		println('[simplegui DEBUG] Created Control: "${real_name}" (Type: "label", Value: "${text}")')
	}
	unsafe {
		mut w := &SimpleWindow(win)
		w.upsert_control(real_name, 'label', text, text, false, 0)
	}
	if win.window_info != unsafe { nil } {
		C.window_add_label_control(win.window_info, real_name.str, text.str)
	}
	return win
}

pub fn (win &SimpleWindow) add_input(name string, value string) &SimpleWindow {
	mut real_name := name
	if real_name == '' {
		real_name = win.auto_name('input')
	}
	if win.debug_mode {
		println('[simplegui DEBUG] Created Control: "${real_name}" (Type: "input", Value: "${value}")')
	}
	unsafe {
		mut w := &SimpleWindow(win)
		w.upsert_control(real_name, 'input', '', value, false, 0)
	}
	if win.window_info != unsafe { nil } {
		C.window_add_input_control(win.window_info, real_name.str, value.str)
	}
	return win
}

pub fn (win &SimpleWindow) add_password(name string, value string) &SimpleWindow {
	mut real_name := name
	if real_name == '' {
		real_name = win.auto_name('password')
	}
	if win.debug_mode {
		println('[simplegui DEBUG] Created Control: "${real_name}" (Type: "password")')
	}
	unsafe {
		mut w := &SimpleWindow(win)
		w.upsert_control(real_name, 'password', '', value, false, 0)
	}
	if win.window_info != unsafe { nil } {
		C.window_add_password_control(win.window_info, real_name.str, value.str)
	}
	return win
}

pub fn (win &SimpleWindow) add_textarea(name string, value string) &SimpleWindow {
	mut real_name := name
	if real_name == '' {
		real_name = win.auto_name('textarea')
	}
	if win.debug_mode {
		println('[simplegui DEBUG] Created Control: "${real_name}" (Type: "textarea", Value: "${value}")')
	}
	unsafe {
		mut w := &SimpleWindow(win)
		w.upsert_control(real_name, 'textarea', '', value, false, 0)
	}
	if win.window_info != unsafe { nil } {
		C.window_add_textarea_control(win.window_info, real_name.str, value.str)
	}
	return win
}

pub fn (win &SimpleWindow) add_html_view(name string, html string) &SimpleWindow {
	mut real_name := name
	if real_name == '' {
		real_name = win.auto_name('htmlview')
	}
	if win.debug_mode {
		println('[simplegui DEBUG] Created Control: "${real_name}" (Type: "htmlview")')
	}
	unsafe {
		mut w := &SimpleWindow(win)
		w.upsert_control(real_name, 'htmlview', '', html, false, 0)
	}
	if win.window_info != unsafe { nil } {
		C.window_add_html_view_control(win.window_info, real_name.str, html.str)
	}
	return win
}

pub fn (win &SimpleWindow) add_drop_zone(name string, label string) &SimpleWindow {
	mut real_name := name
	if real_name == '' {
		real_name = win.auto_name('dropzone')
	}
	if win.debug_mode {
		println('[simplegui DEBUG] Created Control: "${real_name}" (Type: "dropzone", Label: "${label}")')
	}
	unsafe {
		mut w := &SimpleWindow(win)
		w.upsert_control(real_name, 'dropzone', label, '', false, 0)
	}
	if win.window_info != unsafe { nil } {
		C.window_add_drop_zone_control(win.window_info, real_name.str, label.str)
	}
	return win
}

pub fn (win &SimpleWindow) add_button(name string, title string) &SimpleWindow {
	mut real_name := name
	if real_name == '' {
		real_name = win.auto_name('button')
	}
	if win.debug_mode {
		println('[simplegui DEBUG] Created Control: "${real_name}" (Type: "button", Title: "${title}")')
	}
	unsafe {
		mut w := &SimpleWindow(win)
		w.upsert_control(real_name, 'button', title, '', false, 0)
	}
	if win.window_info != unsafe { nil } {
		C.window_add_button_control(win.window_info, real_name.str, title.str)
	}
	return win
}

pub fn (win &SimpleWindow) add_checkbox(name string, label string, checked bool) &SimpleWindow {
	mut real_name := name
	if real_name == '' {
		real_name = win.auto_name('checkbox')
	}
	if win.debug_mode {
		println('[simplegui DEBUG] Created Control: "${real_name}" (Type: "checkbox", Label: "${label}", Checked: ${checked})')
	}
	unsafe {
		mut w := &SimpleWindow(win)
		w.upsert_control(real_name, 'checkbox', label, '', checked, 0)
	}
	if win.window_info != unsafe { nil } {
		checked_val := if checked { 1 } else { 0 }
		C.window_add_checkbox_control(win.window_info, real_name.str, label.str, checked_val)
	}
	return win
}

pub fn (win &SimpleWindow) add_number(name string, value int) &SimpleWindow {
	mut real_name := name
	if real_name == '' {
		real_name = win.auto_name('number')
	}
	if win.debug_mode {
		println('[simplegui DEBUG] Created Control: "${real_name}" (Type: "number", Value: ${value})')
	}
	unsafe {
		mut w := &SimpleWindow(win)
		w.upsert_control(real_name, 'number', '', '', false, value)
	}
	if win.window_info != unsafe { nil } {
		C.window_add_number_control(win.window_info, real_name.str, value)
	}
	return win
}

pub fn (win &SimpleWindow) add_slider(name string, value int) &SimpleWindow {
	mut real_name := name
	if real_name == '' {
		real_name = win.auto_name('slider')
	}
	if win.debug_mode {
		println('[simplegui DEBUG] Created Control: "${real_name}" (Type: "slider", Value: ${value})')
	}
	unsafe {
		mut w := &SimpleWindow(win)
		w.upsert_control(real_name, 'slider', '', value.str(), false, value)
	}
	if win.window_info != unsafe { nil } {
		C.window_add_slider_control(win.window_info, real_name.str, value)
	}
	return win
}

pub fn (win &SimpleWindow) add_theme_menu(name string, selected string) &SimpleWindow {
	mut real_name := name
	if real_name == '' {
		real_name = win.auto_name('theme')
	}
	if win.debug_mode {
		println('[simplegui DEBUG] Created Control: "${real_name}" (Type: "theme", Selected: "${selected}")')
	}
	unsafe {
		mut w := &SimpleWindow(win)
		w.upsert_control(real_name, 'theme', '', selected, false, 0)
	}
	if win.window_info != unsafe { nil } {
		C.window_add_theme_menu_control(win.window_info, real_name.str, selected.str)
	}
	return win
}

pub fn (win &SimpleWindow) add_color_well(name string, color string) &SimpleWindow {
	mut real_name := name
	if real_name == '' {
		real_name = win.auto_name('color')
	}
	if win.debug_mode {
		println('[simplegui DEBUG] Created Control: "${real_name}" (Type: "color", Color: "${color}")')
	}
	unsafe {
		mut w := &SimpleWindow(win)
		w.upsert_control(real_name, 'color', '', color, false, 0)
	}
	if win.window_info != unsafe { nil } {
		C.window_add_color_well_control(win.window_info, real_name.str, color.str)
	}
	return win
}

pub fn (win &SimpleWindow) add_date_picker(name string, date string) &SimpleWindow {
	mut real_name := name
	if real_name == '' {
		real_name = win.auto_name('date')
	}
	if win.debug_mode {
		println('[simplegui DEBUG] Created Control: "${real_name}" (Type: "date", Date: "${date}")')
	}
	unsafe {
		mut w := &SimpleWindow(win)
		w.upsert_control(real_name, 'date', '', date, false, 0)
	}
	if win.window_info != unsafe { nil } {
		C.window_add_date_picker_control(win.window_info, real_name.str, date.str)
	}
	return win
}

pub fn (win &SimpleWindow) add_mode_control(name string, selected string) &SimpleWindow {
	mut real_name := name
	if real_name == '' {
		real_name = win.auto_name('mode')
	}
	if win.debug_mode {
		println('[simplegui DEBUG] Created Control: "${real_name}" (Type: "mode", Selected: "${selected}")')
	}
	unsafe {
		mut w := &SimpleWindow(win)
		w.upsert_control(real_name, 'mode', '', selected, false, 0)
	}
	if win.window_info != unsafe { nil } {
		C.window_add_mode_control_control(win.window_info, real_name.str, selected.str)
	}
	return win
}

pub fn (win &SimpleWindow) add_progress_indicator(name string, value int) &SimpleWindow {
	mut real_name := name
	if real_name == '' {
		real_name = win.auto_name('progress')
	}
	if win.debug_mode {
		println('[simplegui DEBUG] Created Control: "${real_name}" (Type: "progress", Value: ${value})')
	}
	unsafe {
		mut w := &SimpleWindow(win)
		w.upsert_control(real_name, 'progress', '', value.str(), false, value)
	}
	if win.window_info != unsafe { nil } {
		C.window_add_progress_indicator_control(win.window_info, real_name.str, value)
	}
	return win
}

pub fn (win &SimpleWindow) add_dropdown(name string, items []string, selected string) &SimpleWindow {
	mut real_name := name
	if real_name == '' {
		real_name = win.auto_name('dropdown')
	}
	if win.debug_mode {
		println('[simplegui DEBUG] Created Control: "${real_name}" (Type: "dropdown", Selected: "${selected}")')
	}
	unsafe {
		mut w := &SimpleWindow(win)
		w.upsert_control(real_name, 'dropdown', selected, selected, false, 0)
	}
	if win.window_info != unsafe { nil } {
		mut c_items := []&u8{}
		for item in items {
			c_items << item.str
		}
		C.window_add_dropdown_control(win.window_info, real_name.str, c_items.data, items.len,
			selected.str)
	}
	return win
}

pub fn (win &SimpleWindow) add_segmented_control(name string, items []string, selected string) &SimpleWindow {
	mut real_name := name
	if real_name == '' {
		real_name = win.auto_name('segmented')
	}
	if win.debug_mode {
		println('[simplegui DEBUG] Created Control: "${real_name}" (Type: "segmented", Selected: "${selected}")')
	}
	mut sel_idx := -1
	for idx, val in items {
		if val == selected {
			sel_idx = idx
			break
		}
	}
	unsafe {
		mut w := &SimpleWindow(win)
		w.upsert_control(real_name, 'segmented', selected, selected, false, sel_idx)
	}
	if win.window_info != unsafe { nil } {
		mut c_items := []&u8{}
		for item in items {
			c_items << item.str
		}
		C.window_add_segmented_control_custom(win.window_info, real_name.str, c_items.data,
			items.len, selected.str)
	}
	return win
}

pub fn (win &SimpleWindow) add_radio_group(name string, items []string, selected string) &SimpleWindow {
	mut real_name := name
	if real_name == '' {
		real_name = win.auto_name('radiogroup')
	}
	if win.debug_mode {
		println('[simplegui DEBUG] Created Control: "${real_name}" (Type: "radiogroup", Selected: "${selected}")')
	}
	mut sel_idx := -1
	for idx, val in items {
		if val == selected {
			sel_idx = idx
			break
		}
	}
	unsafe {
		mut w := &SimpleWindow(win)
		w.upsert_control(real_name, 'radiogroup', selected, selected, false, sel_idx)
	}
	if win.window_info != unsafe { nil } {
		mut c_items := []&u8{}
		for item in items {
			c_items << item.str
		}
		C.window_add_radio_group_control(win.window_info, real_name.str, c_items.data,
			items.len, selected.str)
	}
	return win
}

pub fn (win &SimpleWindow) add_switch(name string, label string, checked bool) &SimpleWindow {
	mut real_name := name
	if real_name == '' {
		real_name = win.auto_name('switch')
	}
	if win.debug_mode {
		println('[simplegui DEBUG] Created Control: "${real_name}" (Type: "switch", Label: "${label}", Checked: ${checked})')
	}
	unsafe {
		mut w := &SimpleWindow(win)
		w.upsert_control(real_name, 'switch', label, '', checked, 0)
	}
	if win.window_info != unsafe { nil } {
		checked_val := if checked { 1 } else { 0 }
		C.window_add_switch_control(win.window_info, real_name.str, label.str, checked_val)
	}
	return win
}

pub fn (win &SimpleWindow) add_search_field(name string, placeholder string) &SimpleWindow {
	mut real_name := name
	if real_name == '' {
		real_name = win.auto_name('search')
	}
	if win.debug_mode {
		println('[simplegui DEBUG] Created Control: "${real_name}" (Type: "search", Placeholder: "${placeholder}")')
	}
	unsafe {
		mut w := &SimpleWindow(win)
		w.upsert_control(real_name, 'search', '', '', false, 0)
		w.set_placeholder(real_name, placeholder)
	}
	if win.window_info != unsafe { nil } {
		C.window_add_search_field_control(win.window_info, real_name.str, placeholder.str)
	}
	return win
}

pub fn (win &SimpleWindow) add_combo_box(name string, items []string, selected string) &SimpleWindow {
	mut real_name := name
	if real_name == '' {
		real_name = win.auto_name('combobox')
	}
	if win.debug_mode {
		println('[simplegui DEBUG] Created Control: "${real_name}" (Type: "combobox", Selected: "${selected}")')
	}
	unsafe {
		mut w := &SimpleWindow(win)
		w.upsert_control(real_name, 'combobox', selected, selected, false, 0)
	}
	if win.window_info != unsafe { nil } {
		mut c_items := []&u8{}
		for item in items {
			c_items << item.str
		}
		C.window_add_combo_box_control(win.window_info, real_name.str, c_items.data, items.len, selected.str)
	}
	return win
}

pub fn (win &SimpleWindow) add_level_indicator(name string, style int, min_val int, max_val int, value int) &SimpleWindow {
	mut real_name := name
	if real_name == '' {
		real_name = win.auto_name('levelindicator')
	}
	if win.debug_mode {
		println('[simplegui DEBUG] Created Control: "${real_name}" (Type: "levelindicator", Style: ${style}, Min: ${min_val}, Max: ${max_val}, Value: ${value})')
	}
	unsafe {
		mut w := &SimpleWindow(win)
		w.upsert_control(real_name, 'levelindicator', '', value.str(), false, value)
	}
	if win.window_info != unsafe { nil } {
		C.window_add_level_indicator_control(win.window_info, real_name.str, style, min_val, max_val, value)
	}
	return win
}

pub fn (win &SimpleWindow) add_rating(name string, value int) &SimpleWindow {
	return win.add_level_indicator(name, 3, 0, 5, value)
}

pub fn (win &SimpleWindow) add_spinner(name string, active bool) &SimpleWindow {
	mut real_name := name
	if real_name == '' {
		real_name = win.auto_name('spinner')
	}
	if win.debug_mode {
		println('[simplegui DEBUG] Created Control: "${real_name}" (Type: "spinner", Active: ${active})')
	}
	unsafe {
		mut w := &SimpleWindow(win)
		w.upsert_control(real_name, 'spinner', '', if active { 'true' } else { 'false' }, active, 0)
	}
	if win.window_info != unsafe { nil } {
		act_val := if active { 1 } else { 0 }
		C.window_add_spinner_control(win.window_info, real_name.str, act_val)
	}
	return win
}

pub fn (win &SimpleWindow) add_path_control(name string, path string) &SimpleWindow {
	mut real_name := name
	if real_name == '' {
		real_name = win.auto_name('pathcontrol')
	}
	if win.debug_mode {
		println('[simplegui DEBUG] Created Control: "${real_name}" (Type: "pathcontrol", Path: "${path}")')
	}
	unsafe {
		mut w := &SimpleWindow(win)
		w.upsert_control(real_name, 'pathcontrol', '', path, false, 0)
	}
	if win.window_info != unsafe { nil } {
		C.window_add_path_control(win.window_info, real_name.str, path.str)
	}
	return win
}

pub fn (win &SimpleWindow) add_token_field(name string, value string) &SimpleWindow {
	mut real_name := name
	if real_name == '' {
		real_name = win.auto_name('tokenfield')
	}
	if win.debug_mode {
		println('[simplegui DEBUG] Created Control: "${real_name}" (Type: "tokenfield", Value: "${value}")')
	}
	unsafe {
		mut w := &SimpleWindow(win)
		w.upsert_control(real_name, 'tokenfield', '', value, false, 0)
	}
	if win.window_info != unsafe { nil } {
		C.window_add_token_field_control(win.window_info, real_name.str, value.str)
	}
	return win
}

pub fn (win &SimpleWindow) configure(callback fn (mut cfg WindowConfig)) &SimpleWindow {
	mut cfg := WindowConfig{
		title:             win.title
		width:             win.width
		height:            win.height
		padding:           win.padding
		spacing:           win.spacing
		background_color:  win.background_color
		font_color:        win.font_color
		always_on_top:     win.always_on_top
		responsive_layout: win.responsive_layout
		resizable:         win.resizable
		minimizable:       win.minimizable
		maximizable:       win.maximizable
	}
	callback(mut cfg)
	win.set_title(cfg.title)
	win.set_padding(cfg.padding)
	win.set_spacing(cfg.spacing)
	win.set_background_color(cfg.background_color)
	win.set_font_color(cfg.font_color)
	win.set_always_on_top(cfg.always_on_top)
	win.set_responsive_layout(cfg.responsive_layout)
	win.set_resizable(cfg.resizable)
	win.set_minimizable(cfg.minimizable)
	win.set_maximizable(cfg.maximizable)
	unsafe {
		mut w := &SimpleWindow(win)
		w.width = cfg.width
		w.height = cfg.height
	}
	return win
}

pub fn (win &SimpleWindow) form(title string, callback VoidEventCallback) &SimpleWindow {
	win.group('form_${win.controls.len}', title, callback)
	return win
}

pub fn (win &SimpleWindow) section(title string, callback VoidEventCallback) &SimpleWindow {
	win.group('section_${win.controls.len}', title, callback)
	return win
}

pub fn (win &SimpleWindow) validate_controls(validators map[string]ControlValidator) map[string]string {
	mut results := map[string]string{}
	for name, validator in validators {
		if !win.has_control(name) {
			results[name] = ''
			continue
		}
		value := win.get_text(name)
		err := validator(value)
		results[name] = err
		if err != '' {
			win.set_error(name, err)
		} else {
			win.clear_error(name)
		}
	}
	return results
}

pub fn validate_not_empty(value string) string {
	if value.trim_space() == '' {
		return 'Required'
	}
	return ''
}

// High-level helpers for common beginner-friendly form building
pub fn (win &SimpleWindow) add_form_field(label string, name string, value string) &SimpleWindow {
	mut real_name := name
	if real_name == '' {
		real_name = win.auto_name('field')
	}
	win.begin_row('${real_name}_row')
	win.add_label('${real_name}_label', label)
	win.add_input(real_name, value)
	win.end_row()
	return win
}

pub fn (win &SimpleWindow) add_form_textarea(label string, name string, value string) &SimpleWindow {
	mut real_name := name
	if real_name == '' {
		real_name = win.auto_name('textarea')
	}
	win.begin_row('${real_name}_row')
	win.add_label('${real_name}_label', label)
	win.add_textarea(real_name, value)
	win.end_row()
	return win
}

pub fn (win &SimpleWindow) add_toggle(name string, label string, checked bool) &SimpleWindow {
	win.add_checkbox(name, label, checked)
	return win
}

pub fn (win &SimpleWindow) add_number_field(name string, value int) &SimpleWindow {
	win.add_number(name, value)
	return win
}

pub fn (win &SimpleWindow) add_action(name string, title string, callback VoidEventCallback) &SimpleWindow {
	mut real_name := name
	if real_name == '' {
		real_name = win.auto_name('action')
	}
	win.add_button(real_name, title)
	win.on_click(real_name, callback)
	return win
}

pub fn (win &SimpleWindow) add_heading(title string) &SimpleWindow {
	heading_name := 'heading_${win.controls.len}'
	win.add_label(heading_name, title)
	win.add_separator()
	return win
}

// Value setters and getters calling the generic name-based C bridge
pub fn (win &SimpleWindow) set_debug_mode(enabled bool) &SimpleWindow {
	unsafe {
		mut w := &SimpleWindow(win)
		w.debug_mode = enabled
	}
	return win
}

pub fn (win &SimpleWindow) get_debug_mode() bool {
	return win.debug_mode
}

// Value setters and getters calling the generic name-based C bridge
pub fn (win &SimpleWindow) set_value(name string, value string) &SimpleWindow {
	if win.debug_mode {
		println('[simplegui DEBUG] set_value("${name}", "${value}")')
	}
	win.require_control(name)
	idx := win.find_control(name)
	if idx >= 0 {
		unsafe {
			mut w := &SimpleWindow(win)
			mut entry := w.controls[idx]
			entry.value = value
			w.controls[idx] = entry
		}
	}
	if win.window_info != unsafe { nil } {
		C.window_set_control_text_by_name(win.window_info, name.str, value.str)
	}
	unsafe {
		mut w := &SimpleWindow(win)
		w.dispatch_event(name, 'change', value)
	}
	return win
}

pub fn (win &SimpleWindow) get_value(name string) string {
	win.require_control(name)
	if win.window_info != unsafe { nil } {
		res := C.window_get_control_text_by_name(win.window_info, name.str)
		return unsafe { res.vstring() }
	}
	idx := win.find_control(name)
	if idx >= 0 {
		return win.controls[idx].value
	}
	return ''
}

pub fn (win &SimpleWindow) set_bool(name string, checked bool) &SimpleWindow {
	if win.debug_mode {
		println('[simplegui DEBUG] set_bool("${name}", ${checked})')
	}
	win.require_control(name)
	idx := win.find_control(name)
	if idx >= 0 {
		unsafe {
			mut w := &SimpleWindow(win)
			mut entry := w.controls[idx]
			entry.checked = checked
			w.controls[idx] = entry
		}
	}
	if win.window_info != unsafe { nil } {
		C.window_set_control_bool_by_name(win.window_info, name.str, int(checked))
	}
	value := if checked { 'true' } else { 'false' }
	unsafe {
		mut w := &SimpleWindow(win)
		w.dispatch_event(name, 'change', value)
	}
	return win
}

pub fn (win &SimpleWindow) get_bool(name string) bool {
	win.require_control(name)
	if win.window_info != unsafe { nil } {
		return C.window_get_control_bool_by_name(win.window_info, name.str) != 0
	}
	idx := win.find_control(name)
	if idx >= 0 {
		return win.controls[idx].checked
	}
	return false
}

pub fn (win &SimpleWindow) set_number_value(name string, value int) &SimpleWindow {
	if win.debug_mode {
		println('[simplegui DEBUG] set_number_value("${name}", ${value})')
	}
	win.require_control(name)
	idx := win.find_control(name)
	if idx >= 0 {
		unsafe {
			mut w := &SimpleWindow(win)
			mut entry := w.controls[idx]
			entry.number = value
			w.controls[idx] = entry
		}
	}
	if win.window_info != unsafe { nil } {
		C.window_set_control_int_by_name(win.window_info, name.str, value)
	}
	unsafe {
		mut w := &SimpleWindow(win)
		w.dispatch_event(name, 'change', value.str())
	}
	return win
}

pub fn (win &SimpleWindow) get_number_value(name string) int {
	win.require_control(name)
	if win.window_info != unsafe { nil } {
		return C.window_get_control_int_by_name(win.window_info, name.str)
	}
	idx := win.find_control(name)
	if idx >= 0 {
		return win.controls[idx].number
	}
	return 0
}

// High-level Delphi/VB/C# style properties/helpers
pub fn (win &SimpleWindow) set_text(name string, text string) &SimpleWindow {
	win.set_value(name, text)
	return win
}

pub fn (win &SimpleWindow) set_html(name string, html string) &SimpleWindow {
	idx := win.find_control(name)
	if idx >= 0 {
		unsafe {
			mut w := &SimpleWindow(win)
			mut entry := w.controls[idx]
			entry.value = html
			w.controls[idx] = entry
		}
	}
	if win.window_info != unsafe { nil } {
		C.window_set_control_text_by_name(win.window_info, name.str, html.str)
	}
	return win
}

pub fn (win &SimpleWindow) get_text(name string) string {
	return win.get_value(name)
}

pub fn (win &SimpleWindow) set_checked(name string, checked bool) &SimpleWindow {
	win.set_bool(name, checked)
	return win
}

pub fn (win &SimpleWindow) get_checked(name string) bool {
	return win.get_bool(name)
}

pub fn (win &SimpleWindow) set_value_int(name string, val int) &SimpleWindow {
	win.set_number_value(name, val)
	return win
}

pub fn (win &SimpleWindow) get_value_int(name string) int {
	return win.get_number_value(name)
}

// Input Control Helper
pub fn (win &SimpleWindow) input(value string) &SimpleWindow {
	win.add_input('default_input', value)
	return win
}

pub fn (win &SimpleWindow) set_input(value string) &SimpleWindow {
	win.set_value('default_input', value)
	return win
}

pub fn (win &SimpleWindow) get_input() string {
	return win.get_value('default_input')
}

// Textarea Control Helper
pub fn (win &SimpleWindow) textarea(text string) &SimpleWindow {
	win.add_textarea('default_textarea', text)
	return win
}

pub fn (win &SimpleWindow) set_textarea(text string) &SimpleWindow {
	win.set_value('default_textarea', text)
	return win
}

pub fn (win &SimpleWindow) get_textarea() string {
	return win.get_value('default_textarea')
}

// Checkbox Control Helper
pub fn (win &SimpleWindow) checkbox(title string, checked bool) &SimpleWindow {
	win.add_checkbox('default_checkbox', title, checked)
	return win
}

pub fn (win &SimpleWindow) set_checkbox(checked bool) &SimpleWindow {
	win.set_bool('default_checkbox', checked)
	return win
}

pub fn (win &SimpleWindow) get_checkbox() bool {
	return win.get_bool('default_checkbox')
}

// Number Control Helper
pub fn (win &SimpleWindow) number(value int) &SimpleWindow {
	win.add_number('default_number', value)
	return win
}

pub fn (win &SimpleWindow) set_number(value int) &SimpleWindow {
	win.set_number_value('default_number', value)
	return win
}

pub fn (win &SimpleWindow) get_number() int {
	return win.get_number_value('default_number')
}

// Button Control Helper
pub fn (win &SimpleWindow) button(title string) &SimpleWindow {
	win.add_button('default_button', title)
	return win
}

pub fn (win &SimpleWindow) set_button(title string) &SimpleWindow {
	win.set_value('default_button', title)
	return win
}

pub fn (win &SimpleWindow) dropdown(items []string, selected string) &SimpleWindow {
	win.add_dropdown('default_dropdown', items, selected)
	return win
}

pub fn (win &SimpleWindow) segmented(items []string, selected string) &SimpleWindow {
	win.add_segmented_control('default_segmented', items, selected)
	return win
}

pub fn (win &SimpleWindow) radio_group(items []string, selected string) &SimpleWindow {
	win.add_radio_group('default_radiogroup', items, selected)
	return win
}

pub fn (win &SimpleWindow) toggle_switch(label string, checked bool) &SimpleWindow {
	win.add_switch('default_switch', label, checked)
	return win
}

pub fn (win &SimpleWindow) search_field(placeholder string) &SimpleWindow {
	win.add_search_field('default_search', placeholder)
	return win
}

pub fn (win &SimpleWindow) combo_box(items []string, selected string) &SimpleWindow {
	win.add_combo_box('default_combobox', items, selected)
	return win
}

pub fn (win &SimpleWindow) rating(value int) &SimpleWindow {
	win.add_rating('default_rating', value)
	return win
}

pub fn (win &SimpleWindow) spinner(active bool) &SimpleWindow {
	win.add_spinner('default_spinner', active)
	return win
}

pub fn (win &SimpleWindow) path_control(path string) &SimpleWindow {
	win.add_path_control('default_pathcontrol', path)
	return win
}

pub fn (win &SimpleWindow) token_field(value string) &SimpleWindow {
	win.add_token_field('default_tokenfield', value)
	return win
}

pub fn (win &SimpleWindow) set_responsive_layout(enabled bool) &SimpleWindow {
	unsafe {
		mut w := &SimpleWindow(win)
		w.responsive_layout = enabled
	}
	if win.window_info != unsafe { nil } {
		C.window_set_responsive_layout(win.window_info, if enabled { 1 } else { 0 })
	}
	return win
}

pub fn (win &SimpleWindow) get_responsive_layout() bool {
	return win.responsive_layout
}

pub fn (win &SimpleWindow) set_padding(padding int) &SimpleWindow {
	unsafe {
		mut w := &SimpleWindow(win)
		w.padding = padding
	}
	if win.window_info != unsafe { nil } {
		C.window_set_padding(win.window_info, padding)
	}
	return win
}

pub fn (win &SimpleWindow) get_padding() int {
	return win.padding
}

pub fn (win &SimpleWindow) set_spacing(spacing int) &SimpleWindow {
	unsafe {
		mut w := &SimpleWindow(win)
		w.spacing = spacing
	}
	if win.window_info != unsafe { nil } {
		C.window_set_spacing(win.window_info, spacing)
	}
	return win
}

pub fn (win &SimpleWindow) get_spacing() int {
	return win.spacing
}

pub fn (win &SimpleWindow) add_group_box(name string, title string) &SimpleWindow {
	mut real_name := name
	if real_name == '' {
		real_name = win.auto_name('groupbox')
	}
	unsafe {
		mut w := &SimpleWindow(win)
		w.upsert_control(real_name, 'groupbox', title, '', false, 0)
	}
	if win.window_info != unsafe { nil } {
		C.window_add_group_box_control(win.window_info, real_name.str, title.str)
	}
	return win
}

pub fn (win &SimpleWindow) add_tabs(name string, titles []string) &SimpleWindow {
	mut real_name := name
	if real_name == '' {
		real_name = win.auto_name('tabs')
	}
	mut joined := ''
	for i, title in titles {
		if i > 0 {
			joined += ','
		}
		joined += title
	}
	unsafe {
		mut w := &SimpleWindow(win)
		w.upsert_control(real_name, 'tabs', joined, '', false, 0)
	}
	if win.window_info != unsafe { nil } {
		mut c_titles := []&u8{}
		for title in titles {
			c_titles << title.str
		}
		C.window_add_tabs_control(win.window_info, real_name.str, c_titles.data, titles.len)
	}
	return win
}

pub fn (win &SimpleWindow) add_scroll_view(name string, height int) &SimpleWindow {
	mut real_name := name
	if real_name == '' {
		real_name = win.auto_name('scrollview')
	}
	unsafe {
		mut w := &SimpleWindow(win)
		w.upsert_control(real_name, 'scrollview', '', '', false, 0)
	}
	if win.window_info != unsafe { nil } {
		C.window_add_scroll_view_control(win.window_info, real_name.str, height)
	}
	return win
}

pub fn (win &SimpleWindow) set_focus(name string) &SimpleWindow {
	if win.window_info != unsafe { nil } {
		C.window_focus_control(win.window_info, name.str)
	}
	return win
}

pub fn (win &SimpleWindow) clear(name string) &SimpleWindow {
	idx := win.find_control(name)
	if idx < 0 {
		return win
	}
	entry := win.controls[idx]
	if entry.kind in ['checkbox', 'switch', 'spinner'] {
		win.set_checked(name, false)
	} else if entry.kind in ['number', 'slider', 'progress', 'levelindicator'] {
		win.set_value_int(name, 0)
	} else if entry.kind in ['input', 'password', 'textarea', 'date', 'mode', 'theme', 'listbox',
		'color', 'search', 'dropdown', 'segmented', 'radiogroup', 'combobox', 'pathcontrol', 'tokenfield'] {
		win.set_text(name, '')
	}
	return win
}

pub fn (win &SimpleWindow) clear_all() &SimpleWindow {
	for control in win.controls {
		win.clear(control.name)
	}
	return win
}

pub fn (win &SimpleWindow) reset_form() &SimpleWindow {
	for i in 0 .. win.controls.len {
		entry := win.controls[i]
		if entry.kind in ['checkbox', 'switch', 'spinner'] {
			win.set_checked(entry.name, entry.initial_checked)
		} else if entry.kind in ['number', 'slider', 'progress', 'levelindicator'] {
			win.set_value_int(entry.name, entry.initial_number)
		} else if entry.kind in ['input', 'password', 'textarea', 'date', 'mode', 'theme', 'listbox',
			'color', 'search', 'dropdown', 'segmented', 'radiogroup', 'combobox', 'pathcontrol', 'tokenfield'] {
			win.set_text(entry.name, entry.initial_value)
		}
	}
	return win
}

pub fn (win &SimpleWindow) set_placeholder(name string, text string) &SimpleWindow {
	unsafe {
		mut w := &SimpleWindow(win)
		if w.placeholders.len == 0 {
			w.placeholders = map[string]string{}
		}
		w.placeholders[name] = text
	}
	if win.window_info != unsafe { nil } {
		C.window_set_placeholder_by_name(win.window_info, name.str, text.str)
	}
	return win
}

pub fn (win &SimpleWindow) set_error(name string, text string) &SimpleWindow {
	unsafe {
		mut w := &SimpleWindow(win)
		if w.errors.len == 0 {
			w.errors = map[string]string{}
		}
		w.errors[name] = text
	}
	if win.window_info != unsafe { nil } {
		C.window_set_error_by_name(win.window_info, name.str, text.str)
	}
	return win
}

pub fn (win &SimpleWindow) get_error(name string) string {
	return win.errors[name] or { '' }
}

pub fn (win &SimpleWindow) set_tooltip(name string, text string) &SimpleWindow {
	if win.window_info != unsafe { nil } {
		C.window_set_tooltip_by_name(win.window_info, name.str, text.str)
	}
	return win
}

pub fn (win &SimpleWindow) set_default_button(name string) &SimpleWindow {
	unsafe {
		mut w := &SimpleWindow(win)
		w.default_button = name
	}
	if win.window_info != unsafe { nil } {
		C.window_set_default_button_by_name(win.window_info, name.str)
	}
	return win
}

pub fn (win &SimpleWindow) on_enter(name string, callback VoidEventCallback) &SimpleWindow {
	unsafe {
		mut w := &SimpleWindow(win)
		w.handlers << ControlEventHandler{
			control_name: name
			event_name:   'enter'
			void_cb:      callback
		}
	}
	return win
}

pub fn (win &SimpleWindow) on_key(key string, callback StringEventCallback) &SimpleWindow {
	unsafe {
		mut w := &SimpleWindow(win)
		w.handlers << ControlEventHandler{
			control_name: 'window'
			event_name:   'key'
			filter_value: key
			string_cb:    callback
		}
	}
	return win
}

pub fn (win &SimpleWindow) on_close(callback VoidEventCallback) &SimpleWindow {
	unsafe {
		mut w := &SimpleWindow(win)
		w.handlers << ControlEventHandler{
			control_name: 'window'
			event_name:   'close'
			void_cb:      callback
		}
	}
	return win
}

pub fn (win &SimpleWindow) run_after(ms int, callback VoidEventCallback) &SimpleWindow {
	unsafe {
		mut w := &SimpleWindow(win)
		w.handlers << ControlEventHandler{
			control_name: 'window'
			event_name:   'run_after'
			void_cb:      callback
		}
	}
	if win.window_info != unsafe { nil } {
		C.window_run_after(win.window_info, ms, c'window')
	}
	return win
}

pub fn (win &SimpleWindow) toast(message string) &SimpleWindow {
	if win.window_info != unsafe { nil } {
		C.window_show_toast(win.window_info, message.str)
	}
	return win
}

pub fn (win &SimpleWindow) open_url(url string) &SimpleWindow {
	if win.window_info != unsafe { nil } {
		C.window_open_url(win.window_info, url.str)
	}
	return win
}

pub fn (win &SimpleWindow) copy_to_clipboard(text string) &SimpleWindow {
	if win.window_info != unsafe { nil } {
		C.window_copy_to_clipboard(win.window_info, text.str)
	}
	return win
}

pub fn (win &SimpleWindow) inspect_controls() string {
	mut names := []string{}
	for control in win.controls {
		names << control.name
	}
	mut joined := ''
	for i, name in names {
		if i > 0 {
			joined += ','
		}
		joined += name
	}
	return joined
}

pub fn (win &SimpleWindow) dump_values() map[string]string {
	return win.get_values()
}

// Window styling
pub fn (win &SimpleWindow) get_title() string {
	return win.title
}

pub fn (win &SimpleWindow) set_title(text string) &SimpleWindow {
	unsafe {
		mut w := &SimpleWindow(win)
		w.title = text
	}
	if win.window_info != unsafe { nil } {
		C.window_set_title_text(win.window_info, text.str)
	}
	return win
}

pub fn (win &SimpleWindow) set_always_on_top(enabled bool) &SimpleWindow {
	unsafe {
		mut w := &SimpleWindow(win)
		w.always_on_top = enabled
	}
	if win.window_info != unsafe { nil } {
		val := if enabled { 1 } else { 0 }
		C.window_set_always_on_top(win.window_info, val)
	}
	return win
}

pub fn (win &SimpleWindow) get_always_on_top() bool {
	if win.window_info != unsafe { nil } {
		return C.window_get_always_on_top(win.window_info) == 1
	}
	return win.always_on_top
}

pub fn (win &SimpleWindow) set_min_size(width int, height int) &SimpleWindow {
	unsafe {
		mut w := &SimpleWindow(win)
		w.min_width = width
		w.min_height = height
	}
	if win.window_info != unsafe { nil } {
		C.window_set_min_size(win.window_info, width, height)
	}
	return win
}

pub fn (win &SimpleWindow) set_max_size(width int, height int) &SimpleWindow {
	unsafe {
		mut w := &SimpleWindow(win)
		w.max_width = width
		w.max_height = height
	}
	if win.window_info != unsafe { nil } {
		C.window_set_max_size(win.window_info, width, height)
	}
	return win
}

pub fn (win &SimpleWindow) set_resizable(enabled bool) &SimpleWindow {
	unsafe {
		mut w := &SimpleWindow(win)
		w.resizable = enabled
	}
	if win.window_info != unsafe { nil } {
		C.window_set_resizable(win.window_info, if enabled { 1 } else { 0 })
	}
	return win
}

pub fn (win &SimpleWindow) set_minimizable(enabled bool) &SimpleWindow {
	unsafe {
		mut w := &SimpleWindow(win)
		w.minimizable = enabled
	}
	if win.window_info != unsafe { nil } {
		C.window_set_minimizable(win.window_info, if enabled { 1 } else { 0 })
	}
	return win
}

pub fn (win &SimpleWindow) set_maximizable(enabled bool) &SimpleWindow {
	unsafe {
		mut w := &SimpleWindow(win)
		w.maximizable = enabled
	}
	if win.window_info != unsafe { nil } {
		C.window_set_maximizable(win.window_info, if enabled { 1 } else { 0 })
	}
	return win
}

pub fn (win &SimpleWindow) get_resizable() bool {
	return win.resizable
}

pub fn (win &SimpleWindow) get_minimizable() bool {
	return win.minimizable
}

pub fn (win &SimpleWindow) get_maximizable() bool {
	return win.maximizable
}

pub fn (win &SimpleWindow) close() &SimpleWindow {
	if win.window_info != unsafe { nil } {
		C.window_close(win.window_info)
	}
	return win
}

pub fn (win &SimpleWindow) close_window() &SimpleWindow {
	return win.close()
}

pub fn (win &SimpleWindow) hide() &SimpleWindow {
	if win.window_info != unsafe { nil } {
		C.window_hide(win.window_info)
	}
	return win
}

pub fn (win &SimpleWindow) hide_window() &SimpleWindow {
	return win.hide()
}

pub fn (win &SimpleWindow) center() &SimpleWindow {
	if win.window_info != unsafe { nil } {
		C.window_center(win.window_info)
	}
	return win
}

pub fn (win &SimpleWindow) center_window() &SimpleWindow {
	return win.center()
}

pub fn (win &SimpleWindow) set_size(width int, height int) &SimpleWindow {
	unsafe {
		mut w := &SimpleWindow(win)
		w.width = width
		w.height = height
	}
	if win.window_info != unsafe { nil } {
		C.window_set_size(win.window_info, width, height)
	}
	return win
}

pub fn (win &SimpleWindow) resize(width int, height int) &SimpleWindow {
	return win.set_size(width, height)
}

pub fn (win &SimpleWindow) get_width() int {
	if win.window_info != unsafe { nil } {
		return C.window_get_width(win.window_info)
	}
	return win.width
}

pub fn (win &SimpleWindow) get_height() int {
	if win.window_info != unsafe { nil } {
		return C.window_get_height(win.window_info)
	}
	return win.height
}

pub fn (win &SimpleWindow) set_position(x int, y int) &SimpleWindow {
	if win.window_info != unsafe { nil } {
		C.window_set_position(win.window_info, x, y)
	}
	return win
}

pub fn (win &SimpleWindow) get_x() int {
	if win.window_info != unsafe { nil } {
		return C.window_get_x(win.window_info)
	}
	return 0
}

pub fn (win &SimpleWindow) get_y() int {
	if win.window_info != unsafe { nil } {
		return C.window_get_y(win.window_info)
	}
	return 0
}

pub fn (win &SimpleWindow) set_opacity(opacity f64) &SimpleWindow {
	if win.window_info != unsafe { nil } {
		C.window_set_opacity(win.window_info, opacity)
	}
	return win
}

pub fn (win &SimpleWindow) get_opacity() f64 {
	if win.window_info != unsafe { nil } {
		return C.window_get_opacity(win.window_info)
	}
	return 1.0
}

pub fn (win &SimpleWindow) toggle_fullscreen() &SimpleWindow {
	if win.window_info != unsafe { nil } {
		C.window_toggle_fullscreen(win.window_info)
	}
	return win
}

pub fn (win &SimpleWindow) minimize() &SimpleWindow {
	if win.window_info != unsafe { nil } {
		C.window_minimize(win.window_info)
	}
	return win
}

pub fn (win &SimpleWindow) deminimize() &SimpleWindow {
	if win.window_info != unsafe { nil } {
		C.window_deminimize(win.window_info)
	}
	return win
}

pub fn (win &SimpleWindow) maximize() &SimpleWindow {
	if win.window_info != unsafe { nil } {
		C.window_maximize(win.window_info)
	}
	return win
}

pub fn (win &SimpleWindow) zoom() &SimpleWindow {
	return win.maximize()
}

pub fn (win &SimpleWindow) is_minimized() bool {
	if win.window_info != unsafe { nil } {
		return C.window_is_minimized(win.window_info) == 1
	}
	return false
}

pub fn (win &SimpleWindow) is_maximized() bool {
	if win.window_info != unsafe { nil } {
		return C.window_is_maximized(win.window_info) == 1
	}
	return false
}

pub fn (win &SimpleWindow) is_fullscreen() bool {
	if win.window_info != unsafe { nil } {
		return C.window_is_fullscreen(win.window_info) == 1
	}
	return false
}

pub fn (win &SimpleWindow) is_active() bool {
	if win.window_info != unsafe { nil } {
		return C.window_is_active(win.window_info) == 1
	}
	return false
}

pub fn (win &SimpleWindow) set_titlebar_visible(visible bool) &SimpleWindow {
	if win.window_info != unsafe { nil } {
		C.window_set_titlebar_visible(win.window_info, if visible { 1 } else { 0 })
	}
	return win
}

pub fn (win &SimpleWindow) set_background_color(color string) &SimpleWindow {
	unsafe {
		mut w := &SimpleWindow(win)
		w.background_color = color
	}
	if win.window_info != unsafe { nil } {
		C.window_set_background_color(win.window_info, color.str)
	}
	return win
}

pub fn (win &SimpleWindow) get_background_color() string {
	return win.background_color
}

pub fn (win &SimpleWindow) set_font_color(color string) &SimpleWindow {
	unsafe {
		mut w := &SimpleWindow(win)
		w.font_color = color
	}
	if win.window_info != unsafe { nil } {
		C.window_set_font_color(win.window_info, color.str)
	}
	return win
}

pub fn (win &SimpleWindow) get_font_color() string {
	return win.font_color
}

pub fn (win &SimpleWindow) set_control_background_color(name string, color string) &SimpleWindow {
	idx := win.find_control(name)
	if idx >= 0 {
		unsafe {
			mut w := &SimpleWindow(win)
			mut entry := w.controls[idx]
			entry.background_color = color
			w.controls[idx] = entry
		}
	}
	if win.window_info != unsafe { nil } {
		C.window_set_control_background_color_by_name(win.window_info, name.str, color.str)
	}
	return win
}

pub fn (win &SimpleWindow) get_control_background_color(name string) string {
	idx := win.find_control(name)
	if idx >= 0 {
		return win.controls[idx].background_color
	}
	return ''
}

pub fn (win &SimpleWindow) set_control_font_color(name string, color string) &SimpleWindow {
	idx := win.find_control(name)
	if idx >= 0 {
		unsafe {
			mut w := &SimpleWindow(win)
			mut entry := w.controls[idx]
			entry.font_color = color
			w.controls[idx] = entry
		}
	}
	if win.window_info != unsafe { nil } {
		C.window_set_control_font_color_by_name(win.window_info, name.str, color.str)
	}
	return win
}

pub fn (win &SimpleWindow) get_control_font_color(name string) string {
	idx := win.find_control(name)
	if idx >= 0 {
		return win.controls[idx].font_color
	}
	return ''
}

pub fn (win &SimpleWindow) set_control_width(name string, width int) &SimpleWindow {
	idx := win.find_control(name)
	if idx >= 0 {
		unsafe {
			mut w := &SimpleWindow(win)
			mut entry := w.controls[idx]
			entry.width = width
			w.controls[idx] = entry
		}
	}
	if win.window_info != unsafe { nil } {
		C.window_set_control_width_by_name(win.window_info, name.str, width)
	}
	return win
}

pub fn (win &SimpleWindow) get_control_width(name string) int {
	idx := win.find_control(name)
	if idx >= 0 {
		return win.controls[idx].width
	}
	return 0
}

pub fn (win &SimpleWindow) set_control_height(name string, height int) &SimpleWindow {
	idx := win.find_control(name)
	if idx >= 0 {
		unsafe {
			mut w := &SimpleWindow(win)
			mut entry := w.controls[idx]
			entry.height = height
			w.controls[idx] = entry
		}
	}
	if win.window_info != unsafe { nil } {
		C.window_set_control_height_by_name(win.window_info, name.str, height)
	}
	return win
}

pub fn (win &SimpleWindow) get_control_height(name string) int {
	idx := win.find_control(name)
	if idx >= 0 {
		return win.controls[idx].height
	}
	return 0
}

pub fn (win &SimpleWindow) set_control_font_size(name string, size int) &SimpleWindow {
	idx := win.find_control(name)
	if idx >= 0 {
		unsafe {
			mut w := &SimpleWindow(win)
			mut entry := w.controls[idx]
			entry.font_size = size
			w.controls[idx] = entry
		}
	}
	if win.window_info != unsafe { nil } {
		C.window_set_control_font_size_by_name(win.window_info, name.str, size)
	}
	return win
}

pub fn (win &SimpleWindow) get_control_font_size(name string) int {
	idx := win.find_control(name)
	if idx >= 0 {
		return win.controls[idx].font_size
	}
	return 0
}

pub fn (win &SimpleWindow) set_control_font_bold(name string, bold bool) &SimpleWindow {
	win.require_control(name)
	if win.window_info != unsafe { nil } {
		b_val := if bold { 1 } else { 0 }
		C.window_set_control_font_bold_by_name(win.window_info, name.str, b_val)
	}
	return win
}

pub fn (win &SimpleWindow) set_control_font_name(name string, font_name string) &SimpleWindow {
	win.require_control(name)
	if win.window_info != unsafe { nil } {
		C.window_set_control_font_name_by_name(win.window_info, name.str, font_name.str)
	}
	return win
}

// Status text
pub fn (win &SimpleWindow) set_status(text string) &SimpleWindow {
	unsafe {
		mut w := &SimpleWindow(win)
		w.status_text = text
	}
	if !win.has_control('status') {
		win.add_label('status', text)
	}
	if win.window_info != unsafe { nil } {
		C.window_set_status_text(win.window_info, text.str)
	}
	return win
}

pub fn (win &SimpleWindow) get_status() string {
	return win.status_text
}

pub fn (win &SimpleWindow) status(text string) &SimpleWindow {
	win.set_status(text)
	return win
}

// Event registration
pub fn (win &SimpleWindow) on_click(name string, callback VoidEventCallback) &SimpleWindow {
	idx := win.find_handler(name, 'click')
	mut handler := ControlEventHandler{
		control_name: name
		event_name:   'click'
		void_cb:      callback
	}
	unsafe {
		mut w := &SimpleWindow(win)
		if idx >= 0 {
			w.handlers[idx] = handler
		} else {
			w.handlers << handler
		}
	}
	return win
}

pub fn (win &SimpleWindow) on_change(name string, callback StringEventCallback) &SimpleWindow {
	idx := win.find_handler(name, 'change')
	mut handler := ControlEventHandler{
		control_name: name
		event_name:   'change'
		string_cb:    callback
	}
	unsafe {
		mut w := &SimpleWindow(win)
		if idx >= 0 {
			w.handlers[idx] = handler
		} else {
			w.handlers << handler
		}
	}
	return win
}

pub fn (win &SimpleWindow) dispatch_event(name string, event_name string, value string) bool {
	if win.debug_mode {
		println('[simplegui DEBUG] Dispatching Event: "${event_name}" on Control: "${name}" (Value: "${value}")')
		win.set_status('[DEBUG] ${event_name} on "${name}" -> "${value}"')
	}
	mut handler_idx := -1
	if event_name == 'file_drop' {
		handler_idx = win.find_handler_by_filter(name, event_name, value)
		if handler_idx < 0 {
			handler_idx = win.find_handler_by_filter('window', event_name, value)
		}
	} else {
		handler_idx = win.find_handler_by_filter(name, event_name, value)
	}
	if handler_idx < 0 {
		return false
	}
	handler := win.handlers[handler_idx]
	if event_name == 'file_drop' {
		files := value.split('|')
		unsafe {
			mut w := &SimpleWindow(win)
			handler.file_drop_cb(mut w, files)
		}
		return true
	} else if handler.void_cb != unsafe { nil } {
		unsafe {
			mut w := &SimpleWindow(win)
			handler.void_cb(mut w)
		}
		return true
	} else if handler.string_cb != unsafe { nil } {
		unsafe {
			mut w := &SimpleWindow(win)
			handler.string_cb(mut w, value)
		}
		return true
	}
	return false
}

pub fn (win &SimpleWindow) click(name string) bool {
	return win.dispatch_event(name, 'click', '')
}

pub fn (win &SimpleWindow) run() {
	if win.window_info == unsafe { nil } {
		unsafe {
			mut w := &SimpleWindow(win)
			w.ensure_window()
		}
	}
	C.window_app_run(win.window_info)
}

// Cocoa event dispatcher to V
@[export: 'vlang_dispatch_event']
fn vlang_dispatch_event(win_ptr voidptr, name_str &u8, event_str &u8, value_str &u8) {
	mut win := unsafe { &SimpleWindow(win_ptr) }
	name := unsafe { name_str.vstring() }
	event := unsafe { event_str.vstring() }
	value := unsafe { value_str.vstring() }

	// Update V struct state with the new value from Cocoa
	if event == 'change' {
		idx := win.find_control(name)
		if idx >= 0 {
			kind := win.controls[idx].kind
			if kind == 'checkbox' || kind == 'toggle' {
				win.controls[idx].checked = (value == 'true')
			} else if kind == 'number' || kind == 'slider' || kind == 'progress' {
				win.controls[idx].number = value.int()
			}
			win.controls[idx].value = value
		}
	}

	win.dispatch_event(name, event, value)
}

pub fn (win &SimpleWindow) begin_row(name string) &SimpleWindow {
	if win.window_info != unsafe { nil } {
		C.window_begin_row(win.window_info, name.str)
	}
	return win
}

pub fn (win &SimpleWindow) end_row() &SimpleWindow {
	if win.window_info != unsafe { nil } {
		C.window_end_row(win.window_info)
	}
	return win
}

// Dialogs & Popups
pub fn (win &SimpleWindow) alert(title string, message string) &SimpleWindow {
	if win.window_info != unsafe { nil } {
		C.window_show_alert(win.window_info, title.str, message.str)
	}
	return win
}

pub fn (win &SimpleWindow) alert_with_style(title string, message string, style string) &SimpleWindow {
	if win.window_info != unsafe { nil } {
		C.window_show_alert_with_style(win.window_info, title.str, message.str, style.str)
	}
	return win
}

pub fn (win &SimpleWindow) confirm(title string, message string) bool {
	if win.window_info != unsafe { nil } {
		return C.window_show_confirm(win.window_info, title.str, message.str) == 1
	}
	return false
}

pub fn (win &SimpleWindow) prompt(title string, message string, default_val string) string {
	if win.window_info != unsafe { nil } {
		res := C.window_show_prompt(win.window_info, title.str, message.str, default_val.str)
		return unsafe { res.vstring() }
	}
	return ''
}

pub fn (win &SimpleWindow) choice_dialog(title string, message string, choices []string) int {
	if win.window_info != unsafe { nil } {
		mut c_choices := []&u8{}
		for choice in choices {
			c_choices << choice.str
		}
		return C.window_show_choice_dialog(win.window_info, title.str, message.str, c_choices.data, choices.len)
	}
	return -1
}

// File and Folder Panels
pub fn (win &SimpleWindow) select_file() string {
	if win.window_info != unsafe { nil } {
		res := C.window_select_file(win.window_info)
		return unsafe { res.vstring() }
	}
	return ''
}

pub fn (win &SimpleWindow) select_file_with_extensions(extensions string) string {
	if win.window_info != unsafe { nil } {
		res := C.window_select_file_with_extensions(win.window_info, extensions.str)
		return unsafe { res.vstring() }
	}
	return ''
}

pub fn (win &SimpleWindow) select_folder() string {
	if win.window_info != unsafe { nil } {
		res := C.window_select_folder(win.window_info)
		return unsafe { res.vstring() }
	}
	return ''
}

pub fn (win &SimpleWindow) save_file_picker() string {
	if win.window_info != unsafe { nil } {
		res := C.window_save_file_picker(win.window_info)
		return unsafe { res.vstring() }
	}
	return ''
}

// Visibility & Enabled state controls
pub fn (win &SimpleWindow) set_control_visible(name string, visible bool) &SimpleWindow {
	if win.window_info != unsafe { nil } {
		vis_val := if visible { 1 } else { 0 }
		C.window_set_control_visible_by_name(win.window_info, name.str, vis_val)
	}
	return win
}

pub fn (win &SimpleWindow) get_control_visible(name string) bool {
	if win.window_info != unsafe { nil } {
		return C.window_get_control_visible_by_name(win.window_info, name.str) == 1
	}
	return true
}

pub fn (win &SimpleWindow) set_control_enabled(name string, enabled bool) &SimpleWindow {
	if win.window_info != unsafe { nil } {
		en_val := if enabled { 1 } else { 0 }
		C.window_set_control_enabled_by_name(win.window_info, name.str, en_val)
	}
	return win
}

pub fn (win &SimpleWindow) get_control_enabled(name string) bool {
	if win.window_info != unsafe { nil } {
		return C.window_get_control_enabled_by_name(win.window_info, name.str) == 1
	}
	return true
}

// Timers
pub fn (win &SimpleWindow) set_interval(timer_name string, ms int, callback VoidEventCallback) &SimpleWindow {
	unsafe {
		mut w := &SimpleWindow(win)
		w.handlers << ControlEventHandler{
			control_name: timer_name
			event_name:   'timer'
			void_cb:      callback
		}
	}
	if win.window_info != unsafe { nil } {
		C.window_set_interval(win.window_info, ms, timer_name.str)
	}
	return win
}

pub fn (win &SimpleWindow) stop_interval(timer_name string) &SimpleWindow {
	if win.window_info != unsafe { nil } {
		C.window_stop_interval(win.window_info, timer_name.str)
	}
	return win
}

// List Box and Image View Controls
pub fn (win &SimpleWindow) add_list_box(name string, items []string) &SimpleWindow {
	mut real_name := name
	if real_name == '' {
		real_name = win.auto_name('listbox')
	}
	unsafe {
		mut w := &SimpleWindow(win)
		w.controls << ControlEntry{
			name:  real_name
			kind:  'listbox'
			value: ''
		}
	}
	if win.window_info != unsafe { nil } {
		mut c_items := []&u8{}
		for item in items {
			c_items << item.str
		}
		C.window_add_list_box_control(win.window_info, real_name.str, c_items.data, items.len)
	}
	return win
}

pub fn (win &SimpleWindow) update_list_items(name string, items []string) &SimpleWindow {
	if win.window_info != unsafe { nil } {
		mut c_items := []&u8{}
		for item in items {
			c_items << item.str
		}
		C.window_update_list_items(win.window_info, name.str, c_items.data, items.len)
	}
	return win
}

pub fn (win &SimpleWindow) set_list_selected(name string, index int) &SimpleWindow {
	if win.window_info != unsafe { nil } {
		C.window_set_list_selected(win.window_info, name.str, index)
	}
	return win
}

pub fn (win &SimpleWindow) get_list_selected(name string) int {
	if win.window_info != unsafe { nil } {
		return C.window_get_list_selected(win.window_info, name.str)
	}
	return -1
}

pub fn (win &SimpleWindow) add_image(name string, file_path string) &SimpleWindow {
	mut real_name := name
	if real_name == '' {
		real_name = win.auto_name('image')
	}
	unsafe {
		mut w := &SimpleWindow(win)
		w.controls << ControlEntry{
			name:  real_name
			kind:  'image'
			value: file_path
		}
	}
	if win.window_info != unsafe { nil } {
		C.window_add_image_control(win.window_info, real_name.str, file_path.str)
	}
	return win
}

pub fn (win &SimpleWindow) set_image_path(name string, file_path string) &SimpleWindow {
	idx := win.find_control(name)
	if idx >= 0 {
		unsafe {
			mut w := &SimpleWindow(win)
			mut entry := w.controls[idx]
			entry.value = file_path
			w.controls[idx] = entry
		}
	}
	if win.window_info != unsafe { nil } {
		C.window_set_image_path(win.window_info, name.str, file_path.str)
	}
	return win
}

// Focus & Blur Event Listeners (for text field inputs)
pub fn (win &SimpleWindow) on_focus(name string, callback VoidEventCallback) &SimpleWindow {
	unsafe {
		mut w := &SimpleWindow(win)
		w.handlers << ControlEventHandler{
			control_name: name
			event_name:   'focus'
			void_cb:      callback
		}
	}
	return win
}

// Focus lost (blur)
pub fn (win &SimpleWindow) on_blur(name string, callback VoidEventCallback) &SimpleWindow {
	unsafe {
		mut w := &SimpleWindow(win)
		w.handlers << ControlEventHandler{
			control_name: name
			event_name:   'blur'
			void_cb:      callback
		}
	}
	return win
}

// Hover Event Listeners (Mouse Entered & Mouse Exited)
pub fn (win &SimpleWindow) on_hover(name string, callback VoidEventCallback) &SimpleWindow {
	unsafe {
		mut w := &SimpleWindow(win)
		w.handlers << ControlEventHandler{
			control_name: name
			event_name:   'hover_enter'
			void_cb:      callback
		}
	}
	if win.window_info != unsafe { nil } {
		C.window_enable_hover_events(win.window_info, name.str)
	}
	return win
}

pub fn (win &SimpleWindow) on_hover_exit(name string, callback VoidEventCallback) &SimpleWindow {
	unsafe {
		mut w := &SimpleWindow(win)
		w.handlers << ControlEventHandler{
			control_name: name
			event_name:   'hover_exit'
			void_cb:      callback
		}
	}
	if win.window_info != unsafe { nil } {
		C.window_enable_hover_events(win.window_info, name.str)
	}
	return win
}

// Window Resize Event Listener
pub fn (win &SimpleWindow) on_resize(callback StringEventCallback) &SimpleWindow {
	unsafe {
		mut w := &SimpleWindow(win)
		w.handlers << ControlEventHandler{
			control_name: 'window'
			event_name:   'resize'
			string_cb:    callback
		}
	}
	return win
}

// Custom Menu Items
pub fn (win &SimpleWindow) add_menu_item(menu_name string, item_title string, shortcut string, callback VoidEventCallback) &SimpleWindow {
	handler_name := 'menu_${menu_name}_${item_title}'
	win.on_click(handler_name, callback)
	if win.window_info != unsafe { nil } {
		C.window_add_menu_item(win.window_info, menu_name.str, item_title.str, shortcut.str,
			handler_name.str)
	}
	return win
}

pub fn (win &SimpleWindow) add_context_menu_item(control_name string, item_title string, callback VoidEventCallback) &SimpleWindow {
	handler_name := 'context_${control_name}_${item_title}'
	win.on_click(handler_name, callback)
	if win.window_info != unsafe { nil } {
		C.window_add_context_menu_item(win.window_info, control_name.str, item_title.str, handler_name.str)
	}
	return win
}

pub fn (win &SimpleWindow) on_file_drop(callback FileDropCallback) &SimpleWindow {
	unsafe {
		mut w := &SimpleWindow(win)
		w.handlers << ControlEventHandler{
			control_name: 'window'
			event_name:   'file_drop'
			file_drop_cb: callback
		}
	}
	return win
}

pub fn (win &SimpleWindow) add_vertical_spacer(height int) &SimpleWindow {
	if win.window_info != unsafe { nil } {
		C.window_add_vertical_spacer(win.window_info, height)
	}
	return win
}

pub fn (win &SimpleWindow) add_horizontal_spacer(width int) &SimpleWindow {
	if win.window_info != unsafe { nil } {
		C.window_add_horizontal_spacer(win.window_info, width)
	}
	return win
}

pub fn (win &SimpleWindow) add_separator() &SimpleWindow {
	if win.window_info != unsafe { nil } {
		C.window_add_separator(win.window_info)
	}
	return win
}

pub struct TreeNode {
pub mut:
	id        string
	parent_id string
	text      string
}

pub fn (win &SimpleWindow) add_tree_view(name string, height int) &SimpleWindow {
	mut real_name := name
	if real_name == '' {
		real_name = win.auto_name('treeview')
	}
	unsafe {
		mut w := &SimpleWindow(win)
		w.controls << ControlEntry{
			name:  real_name
			kind:  'treeview'
			value: ''
		}
	}
	if win.window_info != unsafe { nil } {
		C.window_add_tree_view_control(win.window_info, real_name.str, height)
	}
	return win
}

pub fn (win &SimpleWindow) set_tree_nodes(name string, nodes []TreeNode) &SimpleWindow {
	if win.window_info != unsafe { nil } {
		if nodes.len == 0 {
			C.window_set_tree_nodes(win.window_info, name.str, unsafe { nil }, 0)
			return win
		}
		mut flat := []&u8{}
		for node in nodes {
			flat << node.id.str
			flat << node.parent_id.str
			flat << node.text.str
		}
		C.window_set_tree_nodes(win.window_info, name.str, flat.data, flat.len)
	}
	return win
}

pub fn (win &SimpleWindow) get_tree_selected(name string) string {
	if win.window_info != unsafe { nil } {
		res := C.window_get_tree_selected(win.window_info, name.str)
		return unsafe { res.vstring() }
	}
	return ''
}

pub fn (win &SimpleWindow) set_tree_selected(name string, node_id string) &SimpleWindow {
	if win.window_info != unsafe { nil } {
		C.window_set_tree_selected(win.window_info, name.str, node_id.str)
	}
	return win
}

pub fn (win &SimpleWindow) add_table(name string, columns []string) &SimpleWindow {
	mut real_name := name
	if real_name == '' {
		real_name = win.auto_name('table')
	}
	unsafe {
		mut w := &SimpleWindow(win)
		w.controls << ControlEntry{
			name:  real_name
			kind:  'table'
			value: ''
		}
	}
	if win.window_info != unsafe { nil } {
		mut c_cols := []&u8{}
		for col in columns {
			c_cols << col.str
		}
		C.window_add_table_control(win.window_info, real_name.str, c_cols.data, columns.len)
	}
	return win
}

pub fn (win &SimpleWindow) set_table_rows(name string, rows [][]string) &SimpleWindow {
	if win.window_info != unsafe { nil } {
		if rows.len == 0 {
			C.window_set_table_rows(win.window_info, name.str, unsafe { nil }, 0, 0)
			return win
		}
		cols_count := rows[0].len
		mut flat := []&u8{}
		for row in rows {
			for val in row {
				flat << val.str
			}
		}
		C.window_set_table_rows(win.window_info, name.str, flat.data, flat.len, cols_count)
	}
	return win
}

pub fn (win &SimpleWindow) load_table_from_structs[T](name string, items []T) &SimpleWindow {
	mut rows := [][]string{}
	for item in items {
		mut row := []string{}
		$for field in T.fields {
			$if field.typ is string {
				row << item.$(field.name)
			} $else $if field.typ is int {
				row << item.$(field.name).str()
			} $else $if field.typ is bool {
				row << item.$(field.name).str()
			}
		}
		rows << row
	}
	win.set_table_rows(name, rows)
	return win
}

pub fn (win &SimpleWindow) get_values() map[string]string {
	mut values := map[string]string{}
	for control in win.controls {
		if control.kind in ['table', 'image', 'progress'] {
			continue
		}
		values[control.name] = win.get_text(control.name)
	}
	return values
}

pub fn (win &SimpleWindow) set_values(values map[string]string) &SimpleWindow {
	for name, val in values {
		win.set_text(name, val)
	}
	return win
}

pub fn (win &SimpleWindow) bind_to_struct[T](mut data T) &SimpleWindow {
	$for field in T.fields {
		name := field.name
		$if field.typ is string {
			data.$(field.name) = win.get_text(name)
		} $else $if field.typ is int {
			data.$(field.name) = win.get_value_int(name)
		} $else $if field.typ is bool {
			data.$(field.name) = win.get_checked(name)
		}
	}
	return win
}

pub fn (win &SimpleWindow) load_from_struct[T](data T) &SimpleWindow {
	$for field in T.fields {
		name := field.name
		$if field.typ is string {
			win.set_text(name, data.$(field.name))
		} $else $if field.typ is int {
			win.set_value_int(name, data.$(field.name))
		} $else $if field.typ is bool {
			win.set_checked(name, data.$(field.name))
		}
	}
	return win
}

// Layout Rows and Form Generation Helpers
pub fn (win &SimpleWindow) add_action_row(actions map[string]VoidEventCallback) &SimpleWindow {
	row_name := win.auto_name('action_row')
	win.begin_row(row_name)
	for title, cb in actions {
		btn_name := win.auto_name('btn')
		win.add_action(btn_name, title, cb)
	}
	win.end_row()
	return win
}

pub fn (win &SimpleWindow) add_fields_row(fields map[string]string) &SimpleWindow {
	row_name := win.auto_name('fields_row')
	win.begin_row(row_name)
	for label, name in fields {
		win.add_form_field(label, name, '')
	}
	win.end_row()
	return win
}

pub fn (win &SimpleWindow) add_form_from_struct[T](default_data T) &SimpleWindow {
	$for field in T.fields {
		name := field.name
		label := name.capitalize()
		$if field.typ is string {
			val := default_data.$(field.name)
			win.add_form_field(label, name, val)
		} $else $if field.typ is int {
			val := default_data.$(field.name)
			win.begin_row('${name}_row')
			win.add_label('${name}_label', label)
			win.add_number(name, val)
			win.end_row()
		} $else $if field.typ is bool {
			val := default_data.$(field.name)
			win.add_toggle(name, label, val)
		}
	}
	return win
}

pub fn (win &SimpleWindow) enable_status_bar(icon_path string) &SimpleWindow {
	if win.window_info != unsafe { nil } {
		C.window_enable_status_bar(win.window_info, icon_path.str)
	}
	return win
}

pub fn (win &SimpleWindow) show_window() &SimpleWindow {
	if win.window_info != unsafe { nil } {
		C.window_show(win.window_info)
	}
	return win
}

struct MainThreadCallback {
mut:
	win &SimpleWindow     = unsafe { nil }
	cb  VoidEventCallback = unsafe { nil }
}

fn vlang_main_thread_dispatcher(ctx voidptr) {
	mut data := unsafe { &MainThreadCallback(ctx) }
	cb := data.cb
	mut win := data.win
	cb(mut win)
	unsafe {
		free(data)
	}
}

pub fn (win &SimpleWindow) run_on_main_thread(callback VoidEventCallback) &SimpleWindow {
	if win.window_info != unsafe { nil } {
		data := &MainThreadCallback{
			win: win
			cb:  callback
		}
		C.window_run_on_main_thread(vlang_main_thread_dispatcher, data)
	}
	return win
}

// Closure-based row layout container
pub fn (win &SimpleWindow) row(name string, callback VoidEventCallback) &SimpleWindow {
	win.begin_row(name)
	unsafe {
		mut w := &SimpleWindow(win)
		callback(mut w)
	}
	win.end_row()
	return win
}

// Theme preset helper
pub fn (win &SimpleWindow) set_theme(theme_name string) &SimpleWindow {
	match theme_name.to_lower() {
		'dark' {
			win.set_background_color('#1e1e1e')
			win.set_font_color('white')
		}
		'light' {
			win.set_background_color('#f5f5f5')
			win.set_font_color('black')
		}
		'nord' {
			win.set_background_color('#2e3440')
			win.set_font_color('#eceff4')
		}
		'dracula' {
			win.set_background_color('#282a36')
			win.set_font_color('#f8f8f2')
		}
		else {}
	}
	return win
}

// last-control chaining modifiers
pub fn (win &SimpleWindow) width(w int) &SimpleWindow {
	if win.last_control != '' {
		win.set_control_width(win.last_control, w)
	}
	return win
}

pub fn (win &SimpleWindow) height(h int) &SimpleWindow {
	if win.last_control != '' {
		win.set_control_height(win.last_control, h)
	}
	return win
}

pub fn (win &SimpleWindow) font_size(size int) &SimpleWindow {
	if win.last_control != '' {
		win.set_control_font_size(win.last_control, size)
	}
	return win
}

pub fn (win &SimpleWindow) color(hex_color string) &SimpleWindow {
	if win.last_control != '' {
		win.set_control_background_color(win.last_control, hex_color)
	}
	return win
}

pub fn (win &SimpleWindow) font_color(hex_color string) &SimpleWindow {
	if win.last_control != '' {
		win.set_control_font_color(win.last_control, hex_color)
	}
	return win
}

pub fn (win &SimpleWindow) bold(b bool) &SimpleWindow {
	if win.last_control != '' {
		win.set_control_font_bold(win.last_control, b)
	}
	return win
}

pub fn (win &SimpleWindow) font_name(font_name string) &SimpleWindow {
	if win.last_control != '' {
		win.set_control_font_name(win.last_control, font_name)
	}
	return win
}

pub fn (win &SimpleWindow) placeholder(text string) &SimpleWindow {
	if win.last_control != '' {
		win.set_placeholder(win.last_control, text)
	}
	return win
}

pub fn (win &SimpleWindow) error(text string) &SimpleWindow {
	if win.last_control != '' {
		win.set_error(win.last_control, text)
	}
	return win
}

pub fn (win &SimpleWindow) tooltip(text string) &SimpleWindow {
	if win.last_control != '' {
		win.set_tooltip(win.last_control, text)
	}
	return win
}

pub fn (win &SimpleWindow) visible(visible bool) &SimpleWindow {
	if win.last_control != '' {
		win.set_control_visible(win.last_control, visible)
	}
	return win
}

pub fn (win &SimpleWindow) enabled(enabled bool) &SimpleWindow {
	if win.last_control != '' {
		win.set_control_enabled(win.last_control, enabled)
	}
	return win
}

// Fluent event chaining modifiers (attaching to the last created control)
pub fn (win &SimpleWindow) onclick(callback VoidEventCallback) &SimpleWindow {
	if win.last_control != '' {
		win.on_click(win.last_control, callback)
	}
	return win
}

pub fn (win &SimpleWindow) onchange(callback StringEventCallback) &SimpleWindow {
	if win.last_control != '' {
		win.on_change(win.last_control, callback)
	}
	return win
}

pub fn (win &SimpleWindow) onfocus(callback VoidEventCallback) &SimpleWindow {
	if win.last_control != '' {
		win.on_focus(win.last_control, callback)
	}
	return win
}

pub fn (win &SimpleWindow) onblur(callback VoidEventCallback) &SimpleWindow {
	if win.last_control != '' {
		win.on_blur(win.last_control, callback)
	}
	return win
}

pub fn (win &SimpleWindow) onenter(callback VoidEventCallback) &SimpleWindow {
	if win.last_control != '' {
		win.on_enter(win.last_control, callback)
	}
	return win
}

pub fn (win &SimpleWindow) onhover(callback VoidEventCallback) &SimpleWindow {
	if win.last_control != '' {
		win.on_hover(win.last_control, callback)
	}
	return win
}

pub fn (win &SimpleWindow) onhover_exit(callback VoidEventCallback) &SimpleWindow {
	if win.last_control != '' {
		win.on_hover_exit(win.last_control, callback)
	}
	return win
}

// Shorthand aliases for value access
pub fn (win &SimpleWindow) get(name string) string {
	return win.get_text(name)
}

pub fn (win &SimpleWindow) set(name string, value string) &SimpleWindow {
	return win.set_text(name, value)
}

// Clears the validation error state on a single control
pub fn (win &SimpleWindow) clear_error(name string) &SimpleWindow {
	unsafe {
		mut w := &SimpleWindow(win)
		w.errors.delete(name)
	}
	if win.window_info != unsafe { nil } {
		C.window_set_error_by_name(win.window_info, name.str, c'')
	}
	return win
}

// Starts a visual group box, executes the callback for child controls, and returns the window
pub fn (win &SimpleWindow) group(name string, title string, callback VoidEventCallback) &SimpleWindow {
	win.add_group_box(name, title)
	unsafe {
		mut w := &SimpleWindow(win)
		callback(mut w)
	}
	return win
}

// Validation error clearing
pub fn (win &SimpleWindow) clear_errors() &SimpleWindow {
	unsafe {
		mut w := &SimpleWindow(win)
		for name, _ in w.errors {
			if win.window_info != nil {
				C.window_set_error_by_name(win.window_info, name.str, c'')
			}
		}
		w.errors = map[string]string{}
	}
	return win
}

// Change/Dirty state tracking helpers
pub fn (win &SimpleWindow) is_control_dirty(name string) bool {
	idx := win.find_control(name)
	if idx < 0 {
		return false
	}
	entry := win.controls[idx]
	if entry.kind in ['label', 'button', 'image', 'html_view', 'progress'] {
		return false
	}
	if entry.kind in ['checkbox', 'toggle', 'spinner'] {
		return entry.checked != entry.initial_checked
	}
	if entry.kind in ['number', 'slider', 'levelindicator'] {
		return entry.number != entry.initial_number
	}
	return entry.value != entry.initial_value
}

pub fn (win &SimpleWindow) is_dirty() bool {
	for entry in win.controls {
		if win.is_control_dirty(entry.name) {
			return true
		}
	}
	return false
}

// Set current control values as the baseline initial state
pub fn (win &SimpleWindow) commit_changes() &SimpleWindow {
	unsafe {
		mut w := &SimpleWindow(win)
		for i in 0 .. w.controls.len {
			w.controls[i].initial_value = w.controls[i].value
			w.controls[i].initial_checked = w.controls[i].checked
			w.controls[i].initial_number = w.controls[i].number
		}
	}
	return win
}
