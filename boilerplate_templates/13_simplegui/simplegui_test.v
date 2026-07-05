module main

import simplegui

fn test_named_controls_are_stored_and_accessible() {
	mut win := simplegui.SimpleWindow{}
	win.add_input('first_name', 'Ada')
	win.add_input('last_name', 'Lovelace')
	win.add_textarea('notes', 'hello world')
	win.add_checkbox('ready', 'Ready', true)

	win.set_value('first_name', 'Grace')
	win.set_value('notes', 'updated note')
	win.set_bool('ready', false)

	assert win.get_value('first_name') == 'Grace'
	assert win.get_value('last_name') == 'Lovelace'
	assert win.get_value('notes') == 'updated note'
	assert win.get_bool('ready') == false
}

fn test_responsive_layout_api_is_available() {
	mut win := simplegui.SimpleWindow{}
	assert win.get_responsive_layout() == true
	win.set_responsive_layout(false)
	assert win.get_responsive_layout() == false
	win.set_responsive_layout(true)
	assert win.get_responsive_layout() == true
}

fn test_control_discovery_helpers_are_available() {
	mut win := simplegui.SimpleWindow{}
	win.add_input('name', 'Ada')
	win.add_button('run', 'Run')

	assert win.has_control('name') == true
	assert win.has_control('missing') == false
	assert win.list_controls().contains('name')
	assert win.list_controls().contains('run')
	assert win.get_control_kind('name') == 'input'
	assert win.get_control_kind('missing') == ''
}

fn test_event_callbacks_can_be_registered_and_dispatched() {
	mut win := simplegui.SimpleWindow{}
	win.add_input('default_input', 'Ada')
	win.add_button('default_button', 'Run')

	win.on_change('default_input', on_test_change)
	win.on_click('default_button', on_test_click)

	assert win.dispatch_event('default_input', 'change', 'Grace') == true
	assert win.dispatch_event('default_button', 'click', '') == true
	assert win.dispatch_event('missing', 'click', '') == false
}

fn test_status_updates_create_a_status_control() {
	mut win := simplegui.SimpleWindow{}
	win.set_status('Saving...')

	assert win.get_status() == 'Saving...'
	assert win.has_control('status') == true
	assert win.get_control_kind('status') == 'label'
}

fn test_color_methods_store_values() {
	mut win := simplegui.SimpleWindow{}
	win.set_background_color('#112233')
	win.set_font_color('white')

	assert win.get_background_color() == '#112233'
	assert win.get_font_color() == 'white'
}

fn test_window_always_on_top_state_is_stored() {
	mut win := simplegui.SimpleWindow{}

	assert win.get_always_on_top() == false
	win.set_always_on_top(true)
	assert win.get_always_on_top() == true
	win.set_always_on_top(false)
	assert win.get_always_on_top() == false
}

fn test_control_color_methods_store_values() {
	mut win := simplegui.SimpleWindow{}
	win.add_input('name', 'Ada')
	win.add_button('run', 'Run')

	win.set_control_background_color('name', '#112233')
	win.set_control_font_color('name', 'white')
	win.set_control_background_color('run', '#ffcc00')
	win.set_control_font_color('run', 'black')

	assert win.get_control_background_color('name') == '#112233'
	assert win.get_control_font_color('name') == 'white'
	assert win.get_control_background_color('run') == '#ffcc00'
	assert win.get_control_font_color('run') == 'black'
}

fn test_control_sizing_methods_store_values() {
	mut win := simplegui.SimpleWindow{}
	win.add_input('name', 'Ada')
	win.add_button('run', 'Run')

	win.set_control_width('name', 250)
	win.set_control_height('name', 35)
	win.set_control_font_size('name', 14)
	win.set_control_width('run', 180)
	win.set_control_height('run', 45)
	win.set_control_font_size('run', 16)

	assert win.get_control_width('name') == 250
	assert win.get_control_height('name') == 35
	assert win.get_control_font_size('name') == 14
	assert win.get_control_width('run') == 180
	assert win.get_control_height('run') == 45
	assert win.get_control_font_size('run') == 16
}

struct BindingExample {
	username         string
	age              int
	wants_newsletter bool
}

struct CallbackState {
mut:
	called bool
}

fn test_qol_helpers_support_struct_binding_and_tables() {
	mut win := simplegui.SimpleWindow{}
	win.add_input('username', 'Ada')
	win.add_number('age', 28)
	win.add_checkbox('wants_newsletter', 'Subscribe', true)
	win.add_vertical_spacer(10)
	win.add_horizontal_spacer(20)
	win.add_separator()
	win.add_table('processes', ['PID', 'Name'])
	win.set_table_rows('processes', [['1', 'V']])
	win.set_values({
		'username': 'Grace'
	})

	assert win.get_values()['username'] == 'Grace'
	assert win.get_values()['username'] == 'Grace'

	mut data := BindingExample{}
	win.bind_to_struct(mut data)
	assert data.username == 'Grace'
	assert data.age == 28
	assert data.wants_newsletter == true

	win.load_from_struct(BindingExample{ username: 'Linus', age: 54, wants_newsletter: false })
	assert win.get_text('username') == 'Linus'
	assert win.get_value_int('age') == 54
	assert win.get_checked('wants_newsletter') == false

	win.enable_status_bar('')
	win.show_window()
	win.run_on_main_thread(fn (mut w simplegui.SimpleWindow) {})
}

fn test_ergonomic_helpers_are_available_and_resettable() {
	mut win := simplegui.SimpleWindow{}
	win.add_input('name', 'Ada')
	win.add_password('secret', 's3cr3t')
	win.add_html_view('preview', '<h1>Preview</h1>')
	win.add_drop_zone('dropzone', 'Drop files here')
	win.add_checkbox('ready', 'Ready', true)
	win.add_number('age', 30)
	win.add_button('run', 'Run')

	win.set_padding(16)
	win.set_spacing(10)
	win.add_group_box('profile', 'Profile')
	win.add_tabs('mode', ['Simple', 'Advanced'])
	win.add_scroll_view('details', 120)
	win.set_focus('name')
	win.set_placeholder('name', 'Type here')
	win.set_error('name', 'Required')
	win.set_tooltip('secret', 'Use a strong password')
	win.set_default_button('run')
	win.on_enter('name', fn (mut w simplegui.SimpleWindow) {})
	win.on_key('a', fn (mut w simplegui.SimpleWindow, value string) {})
	win.on_close(fn (mut w simplegui.SimpleWindow) {})
	win.run_after(5, fn (mut w simplegui.SimpleWindow) {})
	win.toast('Saved')
	win.copy_to_clipboard('hello')
	win.open_url('https://example.com')

	assert win.get_padding() == 16
	assert win.get_spacing() == 10
	assert win.get_text('secret') == 's3cr3t'
	win.set_html('preview', '<p>Updated</p>')
	assert win.inspect_controls().contains('profile')
	assert win.inspect_controls().contains('mode')
	assert win.inspect_controls().contains('details')

	win.clear('name')
	assert win.get_text('name') == ''

	win.set_text('name', 'Grace')
	win.set_checked('ready', false)
	win.set_value_int('age', 42)
	win.reset_form()
	assert win.get_text('name') == 'Ada'
	assert win.get_checked('ready') == true
	assert win.get_value_int('age') == 30
	assert win.dump_values()['name'] == 'Ada'
}

fn test_high_level_form_helpers_are_available() {
	mut win := simplegui.SimpleWindow{}
	win.add_heading('Profile')
	win.add_form_field('Name', 'name', 'Ada')
	win.add_form_field('City', 'city', 'London')
	win.add_form_textarea('Notes', 'notes', 'Hello')
	win.add_toggle('ready', 'Ready', true)
	win.add_number_field('age', 42)
	win.add_action('run', 'Run', fn (mut w simplegui.SimpleWindow) {})

	assert win.has_control('heading_0') == true
	assert win.has_control('name') == true
	assert win.has_control('city') == true
	assert win.has_control('notes') == true
	assert win.has_control('ready') == true
	assert win.has_control('age') == true
	assert win.has_control('run') == true
	assert win.get_text('name') == 'Ada'
	assert win.get_text('notes') == 'Hello'
	assert win.get_checked('ready') == true
	assert win.get_value_int('age') == 42
	assert win.dispatch_event('run', 'click', '') == true
}

fn test_config_form_and_validation_helpers_are_available() {
	mut win := simplegui.new_simple_window('Test Window', 100, 100)
	win.configure(fn (mut cfg simplegui.WindowConfig) {
		cfg.title = 'Configured Window'
		cfg.width = 420
		cfg.height = 320
		cfg.padding = 18
		cfg.spacing = 8
		cfg.background_color = '#112233'
		cfg.font_color = 'white'
		cfg.resizable = false
	})
	win.form('Profile', fn (mut w simplegui.SimpleWindow) {
		w.add_input('email', 'ada@example.com')
		w.add_checkbox('newsletter', 'Newsletter', true)
	})
	win.section('Account', fn (mut w simplegui.SimpleWindow) {
		w.add_input('username', 'ada')
	})

	assert win.get_title() == 'Configured Window'
	assert win.get_padding() == 18
	assert win.get_spacing() == 8
	assert win.get_background_color() == '#112233'
	assert win.get_font_color() == 'white'
	assert win.get_resizable() == false
	assert win.has_control('email') == true
	assert win.has_control('username') == true

	win.set_text('email', '')
	errs := win.validate_controls({
		'email':    simplegui.validate_not_empty
		'username': simplegui.validate_not_empty
	})
	assert errs['email'] == 'Required'
	assert errs['username'] == ''
	assert win.get_error('email') == 'Required'
}

fn test_file_drop_events_are_forwarded_to_window_handlers() {
	mut win := simplegui.SimpleWindow{}
	mut state := &CallbackState{}

	win.on_file_drop(fn [mut state] (mut w simplegui.SimpleWindow, files []string) {
		state.called = true
		assert files.len == 2
		assert files[0] == '/tmp/a.txt'
		assert files[1] == '/tmp/b.txt'
	})

	assert win.dispatch_event('dropzone', 'file_drop', '/tmp/a.txt|/tmp/b.txt') == true
	assert state.called == true
}

fn on_test_change(mut win simplegui.SimpleWindow, value string) {
	println('test change: ${value}')
}

fn on_test_click(mut win simplegui.SimpleWindow) {
	println('test click')
}

fn test_method_chaining() {
	mut win := simplegui.new_simple_window('Test Window', 100, 100)

	win.add_input('first', 'Ada')
		.add_input('second', 'Lovelace')
		.set_text('first', 'Grace')
		.set_text('second', 'Hopper')
		.add_vertical_spacer(10)
		.add_separator()

	assert win.get_text('first') == 'Grace'
	assert win.get_text('second') == 'Hopper'
}

fn test_new_control_helpers_and_window_constraints() {
	mut win := simplegui.new_simple_window('Test Window', 100, 100)

	win.dropdown(['Low', 'High'], 'High')
		.segmented(['Simple', 'Advanced'], 'Advanced')
		.radio_group(['Admin', 'User'], 'User')
		.toggle_switch('Enable alerts', true)
		.search_field('Search here')
		.set_resizable(false)
		.set_min_size(320, 240)
		.set_max_size(800, 600)
		.set_minimizable(false)
		.set_maximizable(false)

	assert win.has_control('default_dropdown') == true
	assert win.get_text('default_dropdown') == 'High'
	assert win.has_control('default_segmented') == true
	assert win.get_value_int('default_segmented') == 1
	assert win.has_control('default_radiogroup') == true
	assert win.get_text('default_radiogroup') == 'User'
	assert win.has_control('default_switch') == true
	assert win.get_bool('default_switch') == true
	assert win.has_control('default_search') == true
	assert win.get_text('default_search') == ''
	assert win.get_resizable() == false
	assert win.get_minimizable() == false
	assert win.get_maximizable() == false

	// Test new window operations
	win.set_opacity(0.85)
	assert win.get_opacity() == 0.85

	win.set_size(640, 480)
	assert win.get_width() == 640
	assert win.get_height() == 480

	win.set_position(150, 150)
	assert win.get_x() >= 0
	assert win.get_y() >= 0

	win.set_titlebar_visible(false)
	_ = win.is_minimized()
	_ = win.is_maximized()
	_ = win.is_fullscreen()
	_ = win.is_active()

	win.center()
	win.minimize()
	win.maximize()
	win.toggle_fullscreen()
}

fn test_native_macos_control_wrappers_are_available() {
	mut win := simplegui.new_simple_window('Test Window', 100, 100)
	win.add_dropdown('priority', ['Low', 'Medium', 'High'], 'Medium')
	win.add_segmented_control('analysis_mode', ['Simple', 'Advanced', 'Expert'], 'Advanced')
	win.add_radio_group('role', ['Viewer', 'Editor', 'Admin'], 'Editor')
	win.add_switch('notifications', 'Notify', true)
	win.add_search_field('search', 'Find')
	win.add_group_box('profile_box', 'Profile')
	win.add_tabs('workspace_tabs', ['Overview', 'Details'])
	win.add_scroll_view('details', 140)
	win.add_list_box('items', ['One', 'Two'])
	win.add_image('preview', 'screenshots/stack_style.png')
	win.add_table('events', ['Action', 'Value'])

	assert win.has_control('priority') == true
	assert win.has_control('analysis_mode') == true
	assert win.has_control('role') == true
	assert win.has_control('notifications') == true
	assert win.has_control('search') == true
	assert win.has_control('profile_box') == true
	assert win.has_control('workspace_tabs') == true
	assert win.has_control('details') == true
	assert win.has_control('items') == true
	assert win.has_control('preview') == true
	assert win.has_control('events') == true

	assert win.get_control_kind('priority') == 'dropdown'
	assert win.get_control_kind('analysis_mode') == 'segmented'
	assert win.get_control_kind('role') == 'radiogroup'
	assert win.get_control_kind('notifications') == 'switch'
	assert win.get_control_kind('search') == 'search'
	assert win.get_control_kind('profile_box') == 'groupbox'
	assert win.get_control_kind('workspace_tabs') == 'tabs'
	assert win.get_control_kind('details') == 'scrollview'
	assert win.get_control_kind('items') == 'listbox'
	assert win.get_control_kind('preview') == 'image'
	assert win.get_control_kind('events') == 'table'

	win.set_text('priority', 'High')
	win.set_text('analysis_mode', 'Expert')
	win.set_text('role', 'Admin')
	win.set_checked('notifications', false)
	win.set_text('search', 'demo')

	assert win.get_text('priority') == 'High'
	assert win.get_text('analysis_mode') == 'Expert'
	assert win.get_text('role') == 'Admin'
	assert win.get_checked('notifications') == false
	assert win.get_text('search') == 'demo'
}

fn test_auto_naming() {
	mut win := simplegui.new_simple_window('Test Window', 100, 100)

	win.add_label('', 'Hello')
		.add_input('', 'World')

	assert win.list_controls().len == 2
	assert win.list_controls()[0].starts_with('auto_label_')
	assert win.list_controls()[1].starts_with('auto_input_')
}

fn test_consistent_nameless_helpers() {
	mut win := simplegui.new_simple_window('Test Window', 100, 100)

	win.input('My Input')
		.textarea('My Textarea')
		.checkbox('My Checkbox', true)
		.number(123)
		.button('My Button')

	assert win.get_input() == 'My Input'
	assert win.get_textarea() == 'My Textarea'
	assert win.get_checkbox() == true
	assert win.get_number() == 123

	win.set_input('Updated Input')
		.set_textarea('Updated Textarea')
		.set_checkbox(false)
		.set_number(456)
		.set_button('Updated Button')

	assert win.get_input() == 'Updated Input'
	assert win.get_textarea() == 'Updated Textarea'
	assert win.get_checkbox() == false
	assert win.get_number() == 456
}

fn test_layout_rows() {
	mut win := simplegui.new_simple_window('Test Window', 100, 100)
	win.add_fields_row({
		'First Name': 'fn'
		'Last Name':  'ln'
	})

	assert win.has_control('fn') == true
	assert win.has_control('ln') == true
	assert win.has_control('fn_label') == true
	assert win.has_control('ln_label') == true
}

struct TestProfile {
	username string
	score    int
	active   bool
}

fn test_form_generation_from_struct() {
	mut win := simplegui.new_simple_window('Test Window', 100, 100)
	p := TestProfile{
		username: 'Grace'
		score:    100
		active:   true
	}
	win.add_form_from_struct(p)

	assert win.has_control('username') == true
	assert win.has_control('score') == true
	assert win.has_control('active') == true

	assert win.get_text('username') == 'Grace'
	assert win.get_value_int('score') == 100
	assert win.get_checked('active') == true
}

fn test_debug_mode() {
	mut win := simplegui.new_simple_window('Test Window', 100, 100)
	win.set_debug_mode(true)
	assert win.get_debug_mode() == true

	win.add_input('username', 'Ada')
	win.dispatch_event('username', 'change', 'Grace')
	assert win.get_status().contains('[DEBUG] change on "username"')
}

fn test_reset_form_does_not_clear_buttons_or_labels() {
	mut win := simplegui.new_simple_window('Test Window', 100, 100)
	win.add_button('my_button', 'Button Title')
	win.add_input('my_input', 'Input Value')

	// Modify their values manually to simulate change
	win.set_text('my_button', 'Changed Title')
	win.set_text('my_input', 'Changed Value')

	win.reset_form()
	// Button was not reset because it is not an input control
	assert win.get_text('my_button') == 'Changed Title'
	// Input was reset to its initial value
	assert win.get_text('my_input') == 'Input Value'

	win.clear_all()
	// Button was not cleared because it is not an input control
	assert win.get_text('my_button') == 'Changed Title'
	// Input was cleared
	assert win.get_text('my_input') == ''
}

fn test_row_closure_layout() {
	mut win := simplegui.new_simple_window('Test Window', 100, 100)
	win.row('settings', fn (mut w simplegui.SimpleWindow) {
		w.add_input('db_host', 'localhost')
		w.add_number('db_port', 3306)
	})

	assert win.has_control('db_host') == true
	assert win.has_control('db_port') == true
	assert win.get_text('db_host') == 'localhost'
	assert win.get_value_int('db_port') == 3306
}

fn test_last_control_chaining_modifiers() {
	mut win := simplegui.new_simple_window('Test Window', 100, 100)

	win.add_input('username', 'Ada')
		.width(200)
		.height(40)
		.font_size(14)
		.placeholder('Username here')
		.tooltip('Enter username')
		.visible(true)
		.enabled(true)

	assert win.get_control_width('username') == 200
	assert win.get_control_height('username') == 40
	assert win.get_control_font_size('username') == 14
	assert win.get_control_visible('username') == true
	assert win.get_control_enabled('username') == true
}

fn test_theme_presets() {
	mut win := simplegui.new_simple_window('Test Window', 100, 100)
	win.set_theme('dracula')

	assert win.get_background_color() == '#282a36'
	assert win.get_font_color() == '#f8f8f2'
}

fn test_validation_clear_errors() {
	mut win := simplegui.new_simple_window('Test Window', 100, 100)
	win.add_input('username', 'Ada')

	win.set_error('username', 'Required')
	// Check that it tracks the error internally
	assert win.get_error('username') == 'Required'

	win.clear_errors()
	assert win.get_error('username') == ''
}

fn test_dirty_state_tracking() {
	mut win := simplegui.new_simple_window('Test Window', 100, 100)
	win.add_input('username', 'Ada')
	win.add_checkbox('agree', 'Agree to terms', false)
	win.add_number('age', 25)

	// Not dirty initially
	assert win.is_dirty() == false
	assert win.is_control_dirty('username') == false
	assert win.is_control_dirty('agree') == false
	assert win.is_control_dirty('age') == false

	// Modify a control value
	win.set_text('username', 'Grace')
	assert win.is_control_dirty('username') == true
	assert win.is_dirty() == true

	// Commit changes sets new baseline
	win.commit_changes()
	assert win.is_control_dirty('username') == false
	assert win.is_dirty() == false

	// Modify checkbox
	win.set_checked('agree', true)
	assert win.is_control_dirty('agree') == true
	assert win.is_dirty() == true

	// Reset to initial (which was committed)
	win.set_checked('agree', false)
	assert win.is_control_dirty('agree') == false
	assert win.is_dirty() == false
}

fn test_shorthand_get_set() {
	mut win := simplegui.new_simple_window('Test Window', 100, 100)
	win.add_input('username', 'Ada')
	assert win.get('username') == 'Ada'
	win.set('username', 'Grace')
	assert win.get('username') == 'Grace'
}

struct EventChainState {
mut:
	clicked     bool
	changed_val string
}

fn test_fluent_event_chaining() {
	mut win := simplegui.new_simple_window('Test Window', 100, 100)
	mut state := &EventChainState{}

	win.add_button('save', 'Save')
		.onclick(fn [mut state] (mut w simplegui.SimpleWindow) {
			state.clicked = true
		})

	win.add_input('name', '')
		.onchange(fn [mut state] (mut w simplegui.SimpleWindow, val string) {
			state.changed_val = val
		})

	win.dispatch_event('save', 'click', '')
	win.dispatch_event('name', 'change', 'Grace')

	assert state.clicked == true
	assert state.changed_val == 'Grace'
}

fn test_clear_error_individually() {
	mut win := simplegui.new_simple_window('Test Window', 100, 100)
	win.add_input('username', 'Ada')
	win.add_input('email', 'ada@example.com')

	win.set_error('username', 'Name required')
	win.set_error('email', 'Email invalid')

	assert win.get_error('username') == 'Name required'
	assert win.get_error('email') == 'Email invalid'

	win.clear_error('username')
	assert win.get_error('username') == ''
	assert win.get_error('email') == 'Email invalid'
}

fn test_group_layout_nesting() {
	mut win := simplegui.new_simple_window('Test Window', 100, 100)
	win.group('profile', 'Profile Details', fn (mut w simplegui.SimpleWindow) {
		w.add_input('first_name', 'Ada')
		w.add_input('last_name', 'Lovelace')
	})

	assert win.has_control('profile') == true
	assert win.has_control('first_name') == true
	assert win.has_control('last_name') == true
	assert win.get('first_name') == 'Ada'
}

fn test_control_font_customization_and_dialog_choices() {
	mut win := simplegui.new_simple_window('Test Window', 100, 100)
	win.add_label('header', 'Welcome')
		.bold(true)
		.font_name('Courier')
		.bold(false)

	// We won't call win.choice_dialog during automated tests because it opens a native modal dialog
	// and blocks the test execution.

	// Context menu click
	mut state := &CallbackState{}
	win.add_context_menu_item('header', 'Do Action', fn [mut state] (mut w simplegui.SimpleWindow) {
		state.called = true
	})
	assert win.dispatch_event('context_header_Do Action', 'click', '') == true
	assert state.called == true
}

struct ProjectRow {
	id          int
	name        string
	is_active   bool
}

fn test_reflection_table_loading_and_styles() {
	mut win := simplegui.new_simple_window('Test Window', 100, 100)
	win.add_table('projects', ['ID', 'Name', 'Active'])
	
	items_list := [
		ProjectRow{ id: 101, name: "Delphi Compiler", is_active: true },
		ProjectRow{ id: 102, name: "Turbo Pascal", is_active: false },
	]
	win.load_table_from_structs('projects', items_list)
	
	// Test alert style compilability
	win.alert_with_style('Warning Title', 'Warning Message', 'warning')
	win.alert_with_style('Error Title', 'Critical Error', 'error')

	// Test file picker signature
	_ = win.select_file_with_extensions('.txt, .png')
}
