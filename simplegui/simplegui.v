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

// Dialogs and Message boxes
fn C.window_show_alert(&WindowInfo, &u8, &u8)
fn C.window_show_confirm(&WindowInfo, &u8, &u8) int
fn C.window_show_prompt(&WindowInfo, &u8, &u8, &u8) &u8

// File Panels
fn C.window_select_file(&WindowInfo) &u8
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

// System Menu Bar/Tray App Mode
fn C.window_enable_status_bar(&WindowInfo, &u8)
fn C.window_show(&WindowInfo)

// Thread Safety Runner
fn C.window_run_on_main_thread(voidptr, voidptr)

pub type StringEventCallback = fn (mut win SimpleWindow, value string)

pub type VoidEventCallback = fn (mut win SimpleWindow)

pub type FileDropCallback = fn (mut win SimpleWindow, files []string)

pub struct WindowParams {
	title             string
	width             int
	height            int
	win_ptr           voidptr
	padding           int
	spacing           int
	always_on_top     int
	responsive_layout int
}

pub struct WindowInfo {
	app          voidptr
	app_delegate voidptr
}

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
	}
	win.placeholders = map[string]string{}
	win.errors = map[string]string{}
	win.ensure_window()
	return win
}

fn (mut win SimpleWindow) ensure_window() {
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
		}
		win.window_info = C.window_app_init(&params)
	}
}

pub fn (win SimpleWindow) has_control(name string) bool {
	return win.find_control(name) >= 0
}

pub fn (win SimpleWindow) list_controls() []string {
	mut names := []string{}
	for control in win.controls {
		names << control.name
	}
	return names
}

pub fn (win SimpleWindow) get_control_kind(name string) string {
	idx := win.find_control(name)
	if idx >= 0 {
		return win.controls[idx].kind
	}
	return ''
}

pub fn (win SimpleWindow) require_control(name string) string {
	if win.has_control(name) {
		return name
	}
	panic('Control "${name}" was not found. Create it first with add_input/add_button/etc.')
}

fn (win SimpleWindow) find_control(name string) int {
	for i, control in win.controls {
		if control.name == name {
			return i
		}
	}
	return -1
}

fn (win SimpleWindow) find_handler(control_name string, event_name string) int {
	for i, handler in win.handlers {
		if handler.control_name == control_name && handler.event_name == event_name
			&& handler.filter_value == '' {
			return i
		}
	}
	return -1
}

fn (win SimpleWindow) find_handler_by_filter(control_name string, event_name string, filter_value string) int {
	for i, handler in win.handlers {
		if handler.control_name == control_name && handler.event_name == event_name
			&& (handler.filter_value == '' || handler.filter_value == filter_value) {
			return i
		}
	}
	return -1
}

fn (mut win SimpleWindow) upsert_control(name string, kind string, label string, value string, checked bool, number int) {
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
	if idx >= 0 {
		entry = win.controls[idx]
		entry.kind = kind
		entry.label = label
		entry.value = value
		entry.checked = checked
		entry.number = number
		entry.background_color = win.controls[idx].background_color
		entry.font_color = win.controls[idx].font_color
		win.controls[idx] = entry
	} else {
		win.controls << entry
	}
}

// Control creation methods
pub fn (mut win SimpleWindow) add_label(name string, text string) {
	win.upsert_control(name, 'label', text, text, false, 0)
	if win.window_info != unsafe { nil } {
		C.window_add_label_control(win.window_info, name.str, text.str)
	}
}

pub fn (mut win SimpleWindow) add_input(name string, value string) {
	win.upsert_control(name, 'input', '', value, false, 0)
	if win.window_info != unsafe { nil } {
		C.window_add_input_control(win.window_info, name.str, value.str)
	}
}

pub fn (mut win SimpleWindow) add_password(name string, value string) {
	win.upsert_control(name, 'password', '', value, false, 0)
	if win.window_info != unsafe { nil } {
		C.window_add_password_control(win.window_info, name.str, value.str)
	}
}

pub fn (mut win SimpleWindow) add_textarea(name string, value string) {
	win.upsert_control(name, 'textarea', '', value, false, 0)
	if win.window_info != unsafe { nil } {
		C.window_add_textarea_control(win.window_info, name.str, value.str)
	}
}

pub fn (mut win SimpleWindow) add_html_view(name string, html string) {
	win.upsert_control(name, 'htmlview', '', html, false, 0)
	if win.window_info != unsafe { nil } {
		C.window_add_html_view_control(win.window_info, name.str, html.str)
	}
}

pub fn (mut win SimpleWindow) add_drop_zone(name string, label string) {
	win.upsert_control(name, 'dropzone', label, '', false, 0)
	if win.window_info != unsafe { nil } {
		C.window_add_drop_zone_control(win.window_info, name.str, label.str)
	}
}

pub fn (mut win SimpleWindow) add_button(name string, title string) {
	win.upsert_control(name, 'button', title, '', false, 0)
	if win.window_info != unsafe { nil } {
		C.window_add_button_control(win.window_info, name.str, title.str)
	}
}

pub fn (mut win SimpleWindow) add_checkbox(name string, label string, checked bool) {
	win.upsert_control(name, 'checkbox', label, '', checked, 0)
	if win.window_info != unsafe { nil } {
		checked_val := if checked { 1 } else { 0 }
		C.window_add_checkbox_control(win.window_info, name.str, label.str, checked_val)
	}
}

pub fn (mut win SimpleWindow) add_number(name string, value int) {
	win.upsert_control(name, 'number', '', '', false, value)
	if win.window_info != unsafe { nil } {
		C.window_add_number_control(win.window_info, name.str, value)
	}
}

pub fn (mut win SimpleWindow) add_slider(name string, value int) {
	win.upsert_control(name, 'slider', '', value.str(), false, value)
	if win.window_info != unsafe { nil } {
		C.window_add_slider_control(win.window_info, name.str, value)
	}
}

pub fn (mut win SimpleWindow) add_theme_menu(name string, selected string) {
	win.upsert_control(name, 'theme', '', selected, false, 0)
	if win.window_info != unsafe { nil } {
		C.window_add_theme_menu_control(win.window_info, name.str, selected.str)
	}
}

pub fn (mut win SimpleWindow) add_color_well(name string, color string) {
	win.upsert_control(name, 'color', '', color, false, 0)
	if win.window_info != unsafe { nil } {
		C.window_add_color_well_control(win.window_info, name.str, color.str)
	}
}

pub fn (mut win SimpleWindow) add_date_picker(name string, date string) {
	win.upsert_control(name, 'date', '', date, false, 0)
	if win.window_info != unsafe { nil } {
		C.window_add_date_picker_control(win.window_info, name.str, date.str)
	}
}

pub fn (mut win SimpleWindow) add_mode_control(name string, selected string) {
	win.upsert_control(name, 'mode', '', selected, false, 0)
	if win.window_info != unsafe { nil } {
		C.window_add_mode_control_control(win.window_info, name.str, selected.str)
	}
}

pub fn (mut win SimpleWindow) add_progress_indicator(name string, value int) {
	win.upsert_control(name, 'progress', '', value.str(), false, value)
	if win.window_info != unsafe { nil } {
		C.window_add_progress_indicator_control(win.window_info, name.str, value)
	}
}

// High-level helpers for common beginner-friendly form building
pub fn (mut win SimpleWindow) add_form_field(label string, name string, value string) {
	win.begin_row('${name}_row')
	win.add_label('${name}_label', label)
	win.add_input(name, value)
	win.end_row()
}

pub fn (mut win SimpleWindow) add_form_textarea(label string, name string, value string) {
	win.begin_row('${name}_row')
	win.add_label('${name}_label', label)
	win.add_textarea(name, value)
	win.end_row()
}

pub fn (mut win SimpleWindow) add_toggle(name string, label string, checked bool) {
	win.add_checkbox(name, label, checked)
}

pub fn (mut win SimpleWindow) add_number_field(name string, value int) {
	win.add_number(name, value)
}

pub fn (mut win SimpleWindow) add_action(name string, title string, callback VoidEventCallback) {
	win.add_button(name, title)
	win.on_click(name, callback)
}

pub fn (mut win SimpleWindow) add_heading(title string) {
	heading_name := 'heading_${win.controls.len}'
	win.add_label(heading_name, title)
	win.add_separator()
}

// Value setters and getters calling the generic name-based C bridge
pub fn (mut win SimpleWindow) set_value(name string, value string) {
	win.require_control(name)
	idx := win.find_control(name)
	if idx >= 0 {
		mut entry := win.controls[idx]
		entry.value = value
		win.controls[idx] = entry
	}
	if win.window_info != unsafe { nil } {
		C.window_set_control_text_by_name(win.window_info, name.str, value.str)
	}
	win.dispatch_event(name, 'change', value)
}

pub fn (win SimpleWindow) get_value(name string) string {
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

pub fn (mut win SimpleWindow) set_bool(name string, checked bool) {
	win.require_control(name)
	idx := win.find_control(name)
	if idx >= 0 {
		mut entry := win.controls[idx]
		entry.checked = checked
		win.controls[idx] = entry
	}
	if win.window_info != unsafe { nil } {
		C.window_set_control_bool_by_name(win.window_info, name.str, int(checked))
	}
	value := if checked { 'true' } else { 'false' }
	win.dispatch_event(name, 'change', value)
}

pub fn (win SimpleWindow) get_bool(name string) bool {
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

pub fn (mut win SimpleWindow) set_number_value(name string, value int) {
	win.require_control(name)
	idx := win.find_control(name)
	if idx >= 0 {
		mut entry := win.controls[idx]
		entry.number = value
		win.controls[idx] = entry
	}
	if win.window_info != unsafe { nil } {
		C.window_set_control_int_by_name(win.window_info, name.str, value)
	}
	win.dispatch_event(name, 'change', value.str())
}

pub fn (win SimpleWindow) get_number_value(name string) int {
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
pub fn (mut win SimpleWindow) set_text(name string, text string) {
	win.set_value(name, text)
}

pub fn (mut win SimpleWindow) set_html(name string, html string) {
	idx := win.find_control(name)
	if idx >= 0 {
		mut entry := win.controls[idx]
		entry.value = html
		win.controls[idx] = entry
	}
	if win.window_info != unsafe { nil } {
		C.window_set_control_text_by_name(win.window_info, name.str, html.str)
	}
}

pub fn (win SimpleWindow) get_text(name string) string {
	return win.get_value(name)
}

pub fn (mut win SimpleWindow) set_checked(name string, checked bool) {
	win.set_bool(name, checked)
}

pub fn (win SimpleWindow) get_checked(name string) bool {
	return win.get_bool(name)
}

pub fn (mut win SimpleWindow) set_value_int(name string, val int) {
	win.set_number_value(name, val)
}

pub fn (win SimpleWindow) get_value_int(name string) int {
	return win.get_number_value(name)
}

// Input Control Helper
pub fn (mut win SimpleWindow) input(value string) {
	win.add_input('default_input', value)
	win.set_input(value)
}

pub fn (mut win SimpleWindow) set_input(value string) {
	win.set_value('name', value)
}

pub fn (win SimpleWindow) get_input() string {
	return win.get_value('name')
}

// Textarea Control Helper
pub fn (mut win SimpleWindow) textarea(text string) {
	win.add_textarea('default_textarea', text)
	win.set_textarea(text)
}

pub fn (mut win SimpleWindow) set_textarea(text string) {
	win.set_value('notes', text)
}

pub fn (win SimpleWindow) get_textarea() string {
	return win.get_value('notes')
}

// Checkbox Control Helper
pub fn (mut win SimpleWindow) checkbox(title string, checked bool) {
	win.add_checkbox('default_checkbox', title, checked)
	win.set_checkbox(title, checked)
}

pub fn (mut win SimpleWindow) set_checkbox(title string, checked bool) {
	win.set_bool('ready', checked)
	win.set_value('ready', title)
}

pub fn (win SimpleWindow) get_checkbox() bool {
	return win.get_bool('ready')
}

// Number Control Helper
pub fn (mut win SimpleWindow) set_number(value int) {
	win.set_number_value('number', value)
}

pub fn (win SimpleWindow) get_number() int {
	return win.get_number_value('number')
}

// Button Control Helper
pub fn (mut win SimpleWindow) button(title string) {
	win.add_button('default_button', title)
	win.set_button(title)
}

pub fn (mut win SimpleWindow) set_button(title string) {
	win.set_value('run', title)
}

pub fn (mut win SimpleWindow) set_responsive_layout(enabled bool) {
	win.responsive_layout = enabled
	if win.window_info != unsafe { nil } {
		C.window_set_responsive_layout(win.window_info, if enabled { 1 } else { 0 })
	}
}

pub fn (win SimpleWindow) get_responsive_layout() bool {
	return win.responsive_layout
}

pub fn (mut win SimpleWindow) set_padding(padding int) {
	win.padding = padding
	if win.window_info != unsafe { nil } {
		C.window_set_padding(win.window_info, padding)
	}
}

pub fn (win SimpleWindow) get_padding() int {
	return win.padding
}

pub fn (mut win SimpleWindow) set_spacing(spacing int) {
	win.spacing = spacing
	if win.window_info != unsafe { nil } {
		C.window_set_spacing(win.window_info, spacing)
	}
}

pub fn (win SimpleWindow) get_spacing() int {
	return win.spacing
}

pub fn (mut win SimpleWindow) add_group_box(name string, title string) {
	win.upsert_control(name, 'groupbox', title, '', false, 0)
	if win.window_info != unsafe { nil } {
		C.window_add_group_box_control(win.window_info, name.str, title.str)
	}
}

pub fn (mut win SimpleWindow) add_tabs(name string, titles []string) {
	mut joined := ''
	for i, title in titles {
		if i > 0 {
			joined += ','
		}
		joined += title
	}
	win.upsert_control(name, 'tabs', joined, '', false, 0)
	if win.window_info != unsafe { nil } {
		mut c_titles := []&u8{}
		for title in titles {
			c_titles << title.str
		}
		C.window_add_tabs_control(win.window_info, name.str, c_titles.data, titles.len)
	}
}

pub fn (mut win SimpleWindow) add_scroll_view(name string, height int) {
	win.upsert_control(name, 'scrollview', '', '', false, 0)
	if win.window_info != unsafe { nil } {
		C.window_add_scroll_view_control(win.window_info, name.str, height)
	}
}

pub fn (mut win SimpleWindow) set_focus(name string) {
	if win.window_info != unsafe { nil } {
		C.window_focus_control(win.window_info, name.str)
	}
}

pub fn (mut win SimpleWindow) clear(name string) {
	idx := win.find_control(name)
	if idx < 0 {
		return
	}
	if idx >= 0 {
		entry := win.controls[idx]
		if entry.kind == 'checkbox' {
			win.set_checked(name, false)
		} else if entry.kind in ['number', 'slider', 'progress'] {
			win.set_value_int(name, 0)
		} else {
			win.set_text(name, '')
		}
		return
	}
	win.set_text(name, '')
}

pub fn (mut win SimpleWindow) clear_all() {
	for control in win.controls {
		win.clear(control.name)
	}
}

pub fn (mut win SimpleWindow) reset_form() {
	for i in 0 .. win.controls.len {
		mut entry := win.controls[i]
		if entry.kind == 'checkbox' {
			win.set_checked(entry.name, entry.initial_checked)
		} else if entry.kind in ['number', 'slider', 'progress'] {
			win.set_value_int(entry.name, entry.initial_number)
		} else {
			win.set_text(entry.name, entry.initial_value)
		}
	}
}

pub fn (mut win SimpleWindow) set_placeholder(name string, text string) {
	if win.placeholders.len == 0 {
		win.placeholders = map[string]string{}
	}
	win.placeholders[name] = text
	if win.window_info != unsafe { nil } {
		C.window_set_placeholder_by_name(win.window_info, name.str, text.str)
	}
}

pub fn (mut win SimpleWindow) set_error(name string, text string) {
	if win.errors.len == 0 {
		win.errors = map[string]string{}
	}
	win.errors[name] = text
	if win.window_info != unsafe { nil } {
		C.window_set_error_by_name(win.window_info, name.str, text.str)
	}
}

pub fn (mut win SimpleWindow) set_tooltip(name string, text string) {
	if win.window_info != unsafe { nil } {
		C.window_set_tooltip_by_name(win.window_info, name.str, text.str)
	}
}

pub fn (mut win SimpleWindow) set_default_button(name string) {
	win.default_button = name
	if win.window_info != unsafe { nil } {
		C.window_set_default_button_by_name(win.window_info, name.str)
	}
}

pub fn (mut win SimpleWindow) on_enter(name string, callback VoidEventCallback) {
	win.handlers << ControlEventHandler{
		control_name: name
		event_name:   'enter'
		void_cb:      callback
	}
}

pub fn (mut win SimpleWindow) on_key(key string, callback StringEventCallback) {
	win.handlers << ControlEventHandler{
		control_name: 'window'
		event_name:   'key'
		filter_value: key
		string_cb:    callback
	}
}

pub fn (mut win SimpleWindow) on_close(callback VoidEventCallback) {
	win.handlers << ControlEventHandler{
		control_name: 'window'
		event_name:   'close'
		void_cb:      callback
	}
}

pub fn (mut win SimpleWindow) run_after(ms int, callback VoidEventCallback) {
	win.handlers << ControlEventHandler{
		control_name: 'window'
		event_name:   'run_after'
		void_cb:      callback
	}
	if win.window_info != unsafe { nil } {
		C.window_run_after(win.window_info, ms, c'window')
	}
}

pub fn (mut win SimpleWindow) toast(message string) {
	if win.window_info != unsafe { nil } {
		C.window_show_toast(win.window_info, message.str)
	}
}

pub fn (mut win SimpleWindow) open_url(url string) {
	if win.window_info != unsafe { nil } {
		C.window_open_url(win.window_info, url.str)
	}
}

pub fn (mut win SimpleWindow) copy_to_clipboard(text string) {
	if win.window_info != unsafe { nil } {
		C.window_copy_to_clipboard(win.window_info, text.str)
	}
}

pub fn (win SimpleWindow) inspect_controls() string {
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

pub fn (mut win SimpleWindow) dump_values() map[string]string {
	return win.get_values()
}

// Window styling
pub fn (mut win SimpleWindow) set_title(text string) {
	win.title = text
	if win.window_info != unsafe { nil } {
		C.window_set_title_text(win.window_info, text.str)
	}
}

pub fn (mut win SimpleWindow) set_always_on_top(enabled bool) {
	win.always_on_top = enabled
	if win.window_info != unsafe { nil } {
		val := if enabled { 1 } else { 0 }
		C.window_set_always_on_top(win.window_info, val)
	}
}

pub fn (win SimpleWindow) get_always_on_top() bool {
	if win.window_info != unsafe { nil } {
		return C.window_get_always_on_top(win.window_info) == 1
	}
	return win.always_on_top
}

pub fn (mut win SimpleWindow) set_background_color(color string) {
	win.background_color = color
	if win.window_info != unsafe { nil } {
		C.window_set_background_color(win.window_info, color.str)
	}
}

pub fn (win SimpleWindow) get_background_color() string {
	return win.background_color
}

pub fn (mut win SimpleWindow) set_font_color(color string) {
	win.font_color = color
	if win.window_info != unsafe { nil } {
		C.window_set_font_color(win.window_info, color.str)
	}
}

pub fn (win SimpleWindow) get_font_color() string {
	return win.font_color
}

pub fn (mut win SimpleWindow) set_control_background_color(name string, color string) {
	idx := win.find_control(name)
	if idx >= 0 {
		mut entry := win.controls[idx]
		entry.background_color = color
		win.controls[idx] = entry
	}
	if win.window_info != unsafe { nil } {
		C.window_set_control_background_color_by_name(win.window_info, name.str, color.str)
	}
}

pub fn (win SimpleWindow) get_control_background_color(name string) string {
	idx := win.find_control(name)
	if idx >= 0 {
		return win.controls[idx].background_color
	}
	return ''
}

pub fn (mut win SimpleWindow) set_control_font_color(name string, color string) {
	idx := win.find_control(name)
	if idx >= 0 {
		mut entry := win.controls[idx]
		entry.font_color = color
		win.controls[idx] = entry
	}
	if win.window_info != unsafe { nil } {
		C.window_set_control_font_color_by_name(win.window_info, name.str, color.str)
	}
}

pub fn (win SimpleWindow) get_control_font_color(name string) string {
	idx := win.find_control(name)
	if idx >= 0 {
		return win.controls[idx].font_color
	}
	return ''
}

pub fn (mut win SimpleWindow) set_control_width(name string, width int) {
	idx := win.find_control(name)
	if idx >= 0 {
		mut entry := win.controls[idx]
		entry.width = width
		win.controls[idx] = entry
	}
	if win.window_info != unsafe { nil } {
		C.window_set_control_width_by_name(win.window_info, name.str, width)
	}
}

pub fn (win SimpleWindow) get_control_width(name string) int {
	idx := win.find_control(name)
	if idx >= 0 {
		return win.controls[idx].width
	}
	return 0
}

pub fn (mut win SimpleWindow) set_control_height(name string, height int) {
	idx := win.find_control(name)
	if idx >= 0 {
		mut entry := win.controls[idx]
		entry.height = height
		win.controls[idx] = entry
	}
	if win.window_info != unsafe { nil } {
		C.window_set_control_height_by_name(win.window_info, name.str, height)
	}
}

pub fn (win SimpleWindow) get_control_height(name string) int {
	idx := win.find_control(name)
	if idx >= 0 {
		return win.controls[idx].height
	}
	return 0
}

pub fn (mut win SimpleWindow) set_control_font_size(name string, size int) {
	idx := win.find_control(name)
	if idx >= 0 {
		mut entry := win.controls[idx]
		entry.font_size = size
		win.controls[idx] = entry
	}
	if win.window_info != unsafe { nil } {
		C.window_set_control_font_size_by_name(win.window_info, name.str, size)
	}
}

pub fn (win SimpleWindow) get_control_font_size(name string) int {
	idx := win.find_control(name)
	if idx >= 0 {
		return win.controls[idx].font_size
	}
	return 0
}

// Status text
pub fn (mut win SimpleWindow) set_status(text string) {
	win.status_text = text
	if win.window_info != unsafe { nil } {
		C.window_set_status_text(win.window_info, text.str)
	}
}

pub fn (win SimpleWindow) get_status() string {
	return win.status_text
}

pub fn (mut win SimpleWindow) status(text string) {
	win.set_status(text)
}

// Event registration
pub fn (mut win SimpleWindow) on_click(name string, callback VoidEventCallback) {
	idx := win.find_handler(name, 'click')
	mut handler := ControlEventHandler{
		control_name: name
		event_name:   'click'
		void_cb:      callback
	}
	if idx >= 0 {
		win.handlers[idx] = handler
	} else {
		win.handlers << handler
	}
}

pub fn (mut win SimpleWindow) on_change(name string, callback StringEventCallback) {
	idx := win.find_handler(name, 'change')
	mut handler := ControlEventHandler{
		control_name: name
		event_name:   'change'
		string_cb:    callback
	}
	if idx >= 0 {
		win.handlers[idx] = handler
	} else {
		win.handlers << handler
	}
}

pub fn (mut win SimpleWindow) dispatch_event(name string, event_name string, value string) bool {
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
		handler.file_drop_cb(mut win, files)
		return true
	} else if handler.void_cb != unsafe { nil } {
		handler.void_cb(mut win)
		return true
	} else if handler.string_cb != unsafe { nil } {
		handler.string_cb(mut win, value)
		return true
	}
	return false
}

pub fn (mut win SimpleWindow) click(name string) bool {
	return win.dispatch_event(name, 'click', '')
}

pub fn (mut win SimpleWindow) run() {
	win.ensure_window()
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

pub fn (mut win SimpleWindow) begin_row(name string) {
	if win.window_info != unsafe { nil } {
		C.window_begin_row(win.window_info, name.str)
	}
}

pub fn (mut win SimpleWindow) end_row() {
	if win.window_info != unsafe { nil } {
		C.window_end_row(win.window_info)
	}
}

// Dialogs & Popups
pub fn (mut win SimpleWindow) alert(title string, message string) {
	if win.window_info != unsafe { nil } {
		C.window_show_alert(win.window_info, title.str, message.str)
	}
}

pub fn (mut win SimpleWindow) confirm(title string, message string) bool {
	if win.window_info != unsafe { nil } {
		return C.window_show_confirm(win.window_info, title.str, message.str) == 1
	}
	return false
}

pub fn (mut win SimpleWindow) prompt(title string, message string, default_val string) string {
	if win.window_info != unsafe { nil } {
		res := C.window_show_prompt(win.window_info, title.str, message.str, default_val.str)
		return unsafe { res.vstring() }
	}
	return ''
}

// File and Folder Panels
pub fn (mut win SimpleWindow) select_file() string {
	if win.window_info != unsafe { nil } {
		res := C.window_select_file(win.window_info)
		return unsafe { res.vstring() }
	}
	return ''
}

pub fn (mut win SimpleWindow) select_folder() string {
	if win.window_info != unsafe { nil } {
		res := C.window_select_folder(win.window_info)
		return unsafe { res.vstring() }
	}
	return ''
}

pub fn (mut win SimpleWindow) save_file_picker() string {
	if win.window_info != unsafe { nil } {
		res := C.window_save_file_picker(win.window_info)
		return unsafe { res.vstring() }
	}
	return ''
}

// Visibility & Enabled state controls
pub fn (mut win SimpleWindow) set_control_visible(name string, visible bool) {
	if win.window_info != unsafe { nil } {
		vis_val := if visible { 1 } else { 0 }
		C.window_set_control_visible_by_name(win.window_info, name.str, vis_val)
	}
}

pub fn (win SimpleWindow) get_control_visible(name string) bool {
	if win.window_info != unsafe { nil } {
		return C.window_get_control_visible_by_name(win.window_info, name.str) == 1
	}
	return true
}

pub fn (mut win SimpleWindow) set_control_enabled(name string, enabled bool) {
	if win.window_info != unsafe { nil } {
		en_val := if enabled { 1 } else { 0 }
		C.window_set_control_enabled_by_name(win.window_info, name.str, en_val)
	}
}

pub fn (win SimpleWindow) get_control_enabled(name string) bool {
	if win.window_info != unsafe { nil } {
		return C.window_get_control_enabled_by_name(win.window_info, name.str) == 1
	}
	return true
}

// Timers
pub fn (mut win SimpleWindow) set_interval(timer_name string, ms int, callback VoidEventCallback) {
	win.handlers << ControlEventHandler{
		control_name: timer_name
		event_name:   'timer'
		void_cb:      callback
	}
	if win.window_info != unsafe { nil } {
		C.window_set_interval(win.window_info, ms, timer_name.str)
	}
}

pub fn (mut win SimpleWindow) stop_interval(timer_name string) {
	if win.window_info != unsafe { nil } {
		C.window_stop_interval(win.window_info, timer_name.str)
	}
}

// List Box and Image View Controls
pub fn (mut win SimpleWindow) add_list_box(name string, items []string) {
	win.controls << ControlEntry{
		name:  name
		kind:  'listbox'
		value: ''
	}
	if win.window_info != unsafe { nil } {
		mut c_items := []&u8{}
		for item in items {
			c_items << item.str
		}
		C.window_add_list_box_control(win.window_info, name.str, c_items.data, items.len)
	}
}

pub fn (mut win SimpleWindow) update_list_items(name string, items []string) {
	if win.window_info != unsafe { nil } {
		mut c_items := []&u8{}
		for item in items {
			c_items << item.str
		}
		C.window_update_list_items(win.window_info, name.str, c_items.data, items.len)
	}
}

pub fn (mut win SimpleWindow) set_list_selected(name string, index int) {
	if win.window_info != unsafe { nil } {
		C.window_set_list_selected(win.window_info, name.str, index)
	}
}

pub fn (win SimpleWindow) get_list_selected(name string) int {
	if win.window_info != unsafe { nil } {
		return C.window_get_list_selected(win.window_info, name.str)
	}
	return -1
}

pub fn (mut win SimpleWindow) add_image(name string, file_path string) {
	win.controls << ControlEntry{
		name:  name
		kind:  'image'
		value: file_path
	}
	if win.window_info != unsafe { nil } {
		C.window_add_image_control(win.window_info, name.str, file_path.str)
	}
}

pub fn (mut win SimpleWindow) set_image_path(name string, file_path string) {
	idx := win.find_control(name)
	if idx >= 0 {
		mut entry := win.controls[idx]
		entry.value = file_path
		win.controls[idx] = entry
	}
	if win.window_info != unsafe { nil } {
		C.window_set_image_path(win.window_info, name.str, file_path.str)
	}
}

// Focus & Blur Event Listeners (for text field inputs)
pub fn (mut win SimpleWindow) on_focus(name string, callback VoidEventCallback) {
	win.handlers << ControlEventHandler{
		control_name: name
		event_name:   'focus'
		void_cb:      callback
	}
}

// Focus lost (blur)
pub fn (mut win SimpleWindow) on_blur(name string, callback VoidEventCallback) {
	win.handlers << ControlEventHandler{
		control_name: name
		event_name:   'blur'
		void_cb:      callback
	}
}

// Hover Event Listeners (Mouse Entered & Mouse Exited)
pub fn (mut win SimpleWindow) on_hover(name string, callback VoidEventCallback) {
	win.handlers << ControlEventHandler{
		control_name: name
		event_name:   'hover_enter'
		void_cb:      callback
	}
	if win.window_info != unsafe { nil } {
		C.window_enable_hover_events(win.window_info, name.str)
	}
}

pub fn (mut win SimpleWindow) on_hover_exit(name string, callback VoidEventCallback) {
	win.handlers << ControlEventHandler{
		control_name: name
		event_name:   'hover_exit'
		void_cb:      callback
	}
	if win.window_info != unsafe { nil } {
		C.window_enable_hover_events(win.window_info, name.str)
	}
}

// Window Resize Event Listener
pub fn (mut win SimpleWindow) on_resize(callback StringEventCallback) {
	win.handlers << ControlEventHandler{
		control_name: 'window'
		event_name:   'resize'
		string_cb:    callback
	}
}

// Custom Menu Items
pub fn (mut win SimpleWindow) add_menu_item(menu_name string, item_title string, shortcut string, callback VoidEventCallback) {
	handler_name := 'menu_${menu_name}_${item_title}'
	win.on_click(handler_name, callback)
	if win.window_info != unsafe { nil } {
		C.window_add_menu_item(win.window_info, menu_name.str, item_title.str, shortcut.str,
			handler_name.str)
	}
}

pub fn (mut win SimpleWindow) on_file_drop(callback FileDropCallback) {
	win.handlers << ControlEventHandler{
		control_name: 'window'
		event_name:   'file_drop'
		file_drop_cb: callback
	}
}

pub fn (mut win SimpleWindow) add_vertical_spacer(height int) {
	if win.window_info != unsafe { nil } {
		C.window_add_vertical_spacer(win.window_info, height)
	}
}

pub fn (mut win SimpleWindow) add_horizontal_spacer(width int) {
	if win.window_info != unsafe { nil } {
		C.window_add_horizontal_spacer(win.window_info, width)
	}
}

pub fn (mut win SimpleWindow) add_separator() {
	if win.window_info != unsafe { nil } {
		C.window_add_separator(win.window_info)
	}
}

pub fn (mut win SimpleWindow) add_table(name string, columns []string) {
	win.controls << ControlEntry{
		name:  name
		kind:  'table'
		value: ''
	}
	if win.window_info != unsafe { nil } {
		mut c_cols := []&u8{}
		for col in columns {
			c_cols << col.str
		}
		C.window_add_table_control(win.window_info, name.str, c_cols.data, columns.len)
	}
}

pub fn (mut win SimpleWindow) set_table_rows(name string, rows [][]string) {
	if win.window_info != unsafe { nil } {
		if rows.len == 0 {
			C.window_set_table_rows(win.window_info, name.str, unsafe { nil }, 0, 0)
			return
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
}

pub fn (win SimpleWindow) get_values() map[string]string {
	mut values := map[string]string{}
	for control in win.controls {
		if control.kind in ['table', 'image', 'progress'] {
			continue
		}
		values[control.name] = win.get_text(control.name)
	}
	return values
}

pub fn (mut win SimpleWindow) set_values(values map[string]string) {
	for name, val in values {
		win.set_text(name, val)
	}
}

pub fn (mut win SimpleWindow) bind_to_struct[T](mut data T) {
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
}

pub fn (mut win SimpleWindow) load_from_struct[T](data T) {
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
}

pub fn (mut win SimpleWindow) enable_status_bar(icon_path string) {
	if win.window_info != unsafe { nil } {
		C.window_enable_status_bar(win.window_info, icon_path.str)
	}
}

pub fn (mut win SimpleWindow) show_window() {
	if win.window_info != unsafe { nil } {
		C.window_show(win.window_info)
	}
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

pub fn (mut win SimpleWindow) run_on_main_thread(callback VoidEventCallback) {
	if win.window_info != unsafe { nil } {
		data := &MainThreadCallback{
			win: win
			cb:  callback
		}
		C.window_run_on_main_thread(vlang_main_thread_dispatcher, data)
	}
}
