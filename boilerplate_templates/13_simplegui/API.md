# SimpleGUI API Documentation

`simplegui` is a beginner-friendly, rapid application development (RAD) framework for building native macOS Cocoa applications in V. It uses a dynamic auto-layout engine to automatically build, size, and layout controls.

All layout, control creation, styling, and event registration APIs support a **fluent builder pattern** (method chaining) to keep your code clean and concise.

---

## 1. Window Operations

### Quick Start

```v
module main

import simplegui

fn main() {
    simplegui.new_simple_window('Starter', 640, 420)
        .add_input('name', 'Ada')
        .add_button('save', 'Save')
        .on_click('save', fn (mut win &simplegui.SimpleWindow) {
            println("saved: ${win.get_text('name')}")
        })
        .run()
}
```

### Developer Helpers

- `win.has_control(name string) bool` checks whether a named control exists.
- `win.list_controls() []string` returns the registered control names.
- `win.get_control_kind(name string) string` reports the control type.
- `win.require_control(name string) string` returns the control name if it exists, otherwise raises an explicit panic.
- `win.get_title() string` returns the current window title.
- `win.get_resizable() bool` returns whether window scale resizability is enabled.
- `win.get_minimizable() bool` returns whether window minimizability is enabled.
- `win.get_maximizable() bool` returns whether window maximizability is enabled.
- Missing control access now raises a clear panic so mistakes surface early.

### `new_simple_window(title string, width int, height int) &SimpleWindow`

Initializes a new macOS window delegate.

- **Parameters**:
  - `title`: The window title string.
  - `width`: Default initial width.
  - `height`: Default initial height.
- **Notes**: By default, the window automatically resizes its height/width to wrap snugly around the registered controls at startup.

### `win.set_debug_mode(enabled bool) &SimpleWindow`

Enables or disables visual debug logging in stdout and prints events to the window status footer.

### `win.get_debug_mode() bool`

Returns whether debug mode is currently enabled.

### `win.set_title(title string) &SimpleWindow`

Updates the window title bar text.

### `win.set_always_on_top(enabled bool) &SimpleWindow`

Keeps the window above other application windows while the app is running.

### `win.get_always_on_top() bool`

Returns whether the window is currently configured to stay on top.

### `win.set_background_color(hex_color string) &SimpleWindow`

Applies a background theme color to the window content view.

- **Format**: `#RRGGBB` or `#RGB`.

### `win.set_font_color(color string) &SimpleWindow`

Sets the default font text color for labels and form controls.

- **Values**: `'white'`, `'black'`, or hex format.

### `win.set_theme(theme_name string) &SimpleWindow`

Applies a pre-configured theme preset for both the window background and font colors.

- **Values**: `'dark'`, `'light'`, `'nord'`, or `'dracula'`.

### `win.set_padding(padding int) &SimpleWindow`

Sets the window content margin padding.

### `win.get_padding() int`

Gets the current window content margin padding.

### `win.set_spacing(spacing int) &SimpleWindow`

Sets the vertical spacing between stacked controls.

### `win.get_spacing() int`

Gets the current vertical spacing between stacked controls.

### `win.set_responsive_layout(enabled bool) &SimpleWindow`

Enables or disables responsive auto-layout so controls grow and shrink with the window.

### `win.get_responsive_layout() bool`

Returns whether responsive auto-layout is currently enabled.

### `win.set_min_size(width int, height int) &SimpleWindow`

Sets the minimum allowed width and height limits for the window resize action.

### `win.set_max_size(width int, height int) &SimpleWindow`

Sets the maximum allowed width and height limits for the window resize action.

### `win.set_resizable(enabled bool) &SimpleWindow`

Enables or disables window resizability using the dragging border/corners.

### `win.set_minimizable(enabled bool) &SimpleWindow`

Enables or disables the native minimize window titlebar button.

### `win.set_maximizable(enabled bool) &SimpleWindow`

Enables or disables the native zoom/maximize window titlebar button.

### `win.close()` / `win.close_window()` &SimpleWindow

Programmatically closes the native window delegate.

### `win.hide()` / `win.hide_window()` &SimpleWindow

Temporarily hides the window from view.

### `win.center()` / `win.center_window()` &SimpleWindow

Centers the window on the active display.

### `win.set_size(width int, height int)` / `win.resize(width int, height int)` &SimpleWindow

Programmatically resizes the active window content area.

### `win.get_width() int` / `win.get_height() int`

Gets the current width/height of the window.

### `win.set_position(x int, y int)` &SimpleWindow

Repositions the top-left corner of the window on the desktop.

### `win.get_x() int` / `win.get_y() int`

Gets the current screen coordinates of the window position.

### `win.set_opacity(opacity f64)` &SimpleWindow

Applies window transparency / alpha opacity channel (range `0.0` to `1.0`).

### `win.get_opacity() f64`

Gets the current window translucency.

### `win.set_titlebar_visible(visible bool)` &SimpleWindow

Toggles titlebar visibility for custom clean-bordered or borderless overlay look.

### `win.toggle_fullscreen()` &SimpleWindow

Toggles native macOS full screen mode programmatically.

### `win.minimize()` &SimpleWindow

Minimizes the window to the dock.

### `win.deminimize()` &SimpleWindow

Restores the window from the dock.

### `win.maximize()` / `win.zoom()` &SimpleWindow

Toggles native maximized/zoomed window scale.

### `win.is_minimized() bool` / `win.is_maximized() bool` / `win.is_fullscreen() bool`

Queries the active window states to check if it's minimized, maximized, or in full-screen mode.

### `win.is_active() bool`

Returns whether simplegui's window is currently the key focused window on the desktop.

### `win.run()`

Launches the native NSApplication event loop and displays the centered window.

#### Keyboard Shortcuts (Global Window Actions)

- **`CMD + F`**: Toggles native full screen mode.
- **`CMD + Q`**: Quits the application immediately.

---

## 2. Control Layout & Grid Rows

By default, all controls stack vertically. You can group multiple controls side-by-side on the same horizontal row, or group them in layout containers:

### `win.begin_row(name string) &SimpleWindow`

Starts a horizontal layout container. Any subsequent widgets added will align horizontally.

### `win.end_row() &SimpleWindow`

Closes the active horizontal container. Subsequent controls return to vertical stacking.

### `win.add_action_row(actions map[string]VoidEventCallback) &SimpleWindow`

Lays out a set of buttons horizontally in a single call, binding each to its respective click event callback.

### `win.add_fields_row(fields map[string]string) &SimpleWindow`

Lays out a set of labeled input fields side-by-side. The map maps label text to input control name (e.g. `{"First Name": "fn"}`).

### `win.add_group_box(name string, title string) &SimpleWindow`

Adds a visual framed box container with an optional title label. Subsequent controls added will be nested inside this visual group.

### `win.add_tabs(name string, titles []string) &SimpleWindow`

Adds a tabbed container choice selector displaying the tab panes matching the provided `titles`.

### `win.add_scroll_view(name string, height int) &SimpleWindow`

Adds a scrollable layout viewport container with a fixed vertical height constraint.

### `win.row(name string, callback VoidEventCallback) &SimpleWindow`

Starts a horizontal row stack container, executes the callback closure passing the window reference, and automatically closes the horizontal container. Any widgets added inside the closure align horizontally.

### `win.group(name string, title string, callback VoidEventCallback) &SimpleWindow`

Starts a visual group box container, executes the callback closure passing the window reference, allowing nested layout code.

---

## 3. Adding Controls

Each control requires a `name` handle to get/set its value or listen to events. If you pass an empty string `""` as the `name`, a unique control name (e.g. `'auto_input_1'`) will be auto-generated under the hood.

### High-level form helpers

For common forms, these helpers reduce boilerplate and keep the API friendly for beginners:

- `win.add_form_field(label string, name string, value string) &SimpleWindow` creates a label plus input in a row.
- `win.add_form_textarea(label string, name string, value string) &SimpleWindow` creates a label plus textarea in a row.
- `win.add_toggle(name string, label string, checked bool) &SimpleWindow` creates a checkbox.
- `win.add_number_field(name string, value int) &SimpleWindow` creates a numeric input.
- `win.add_action(name string, title string, callback VoidEventCallback) &SimpleWindow` creates a button and wires its click handler.
- `win.add_heading(title string) &SimpleWindow` inserts a large, prominent title label followed by a separator line.
- `win.add_form_from_struct[T](default_data T) &SimpleWindow` automatically generates input/checkbox/numeric fields side-by-side and vertically from a V struct using compile-time reflection.
- `win.configure(callback fn (mut cfg WindowConfig)) &SimpleWindow` applies a small fluent configuration block for window title, dimensions, spacing, colors, and resize behavior.
- `win.form(title string, callback VoidEventCallback) &SimpleWindow` and `win.section(title string, callback VoidEventCallback) &SimpleWindow` create grouped form containers with a lightweight builder feel.
- `win.validate_controls(validators map[string]ControlValidator) map[string]string` validates named controls and stores inline errors, while `simplegui.validate_not_empty(value string) string` provides a ready-made required-field validator.

### Nameless default control helpers

If your application only needs a single control of a specific type (or you do not want to manage control names), you can use nameless helpers which default to pre-configured keys (`'default_input'`, `'default_textarea'`, `'default_checkbox'`, `'default_number'`, `'default_button'`):

- `win.input(value string) &SimpleWindow`
- `win.set_input(value string) &SimpleWindow` / `win.get_input() string`
- `win.textarea(text string) &SimpleWindow`
- `win.set_textarea(text string) &SimpleWindow` / `win.get_textarea() string`
- `win.checkbox(title string, checked bool) &SimpleWindow`
- `win.set_checkbox(checked bool) &SimpleWindow` / `win.get_checkbox() bool`
- `win.number(value int) &SimpleWindow`
- `win.set_number(value int) &SimpleWindow` / `win.get_number() int`
- `win.button(title string) &SimpleWindow`
- `win.set_button(title string) &SimpleWindow`
- `win.dropdown(items []string, selected string) &SimpleWindow`
- `win.segmented(items []string, selected string) &SimpleWindow`
- `win.radio_group(items []string, selected string) &SimpleWindow`
- `win.toggle_switch(label string, checked bool) &SimpleWindow`
- `win.search_field(placeholder string) &SimpleWindow`
- `win.combo_box(items []string, selected string) &SimpleWindow`
- `win.rating(value int) &SimpleWindow`
- `win.spinner(active bool) &SimpleWindow`
- `win.path_control(path string) &SimpleWindow`
- `win.token_field(value string) &SimpleWindow`

### `win.add_label(name string, text string) &SimpleWindow`

Adds a read-only text description label.

### `win.add_input(name string, value string) &SimpleWindow`

Adds a single-line text input field.

### `win.add_password(name string, value string) &SimpleWindow`

Adds a secure password entry field.

### `win.add_textarea(name string, value string) &SimpleWindow`

Adds a scrollable, multi-line rich text area.

### `win.add_html_view(name string, html string) &SimpleWindow`

Adds a lightweight HTML preview panel using WebKit.

### `win.add_drop_zone(name string, label string) &SimpleWindow`

Adds a drag-and-drop target for file paths and other dropped content.

### `win.add_checkbox(name string, label string, checked bool) &SimpleWindow`

Adds a toggle checkbox.

### `win.add_button(name string, title string) &SimpleWindow`

Adds a clickable push button.

### `win.add_number(name string, value int) &SimpleWindow`

Adds a numeric input field bound to an increment/decrement stepper.

### `win.add_slider(name string, value int) &SimpleWindow`

Adds a horizontal slider control (range `0` to `100`).

### `win.add_theme_menu(name string, selected string) &SimpleWindow`

Adds a standard popup dropdown menu selection for active theme (options: `Light`, `Dark`, `System`).

### `win.add_color_well(name string, color_hex string) &SimpleWindow`

Adds a native macOS color well block. Clicking it launches the macOS Color Picker.

### `win.add_date_picker(name string, date string) &SimpleWindow`

Adds a calendar date picker input (input format: `yyyy-mm-dd`).

### `win.add_mode_control(name string, selected string) &SimpleWindow`

Adds a segmented control choice selector (choices: `Simple`, `Advanced`, `Expert`).

### `win.add_progress_indicator(name string, value int) &SimpleWindow`

Adds a horizontal progress bar loader (range `0` to `100`).

### `win.add_list_box(name string, items []string) &SimpleWindow`

Adds a scrollable table list box control displaying the array items. Selection changes trigger change events.

### `win.add_image(name string, file_path string) &SimpleWindow`

Adds an image box displaying a local PNG or JPEG file. Custom widths/heights can resize it.

### `win.add_dropdown(name string, items []string, selected string) &SimpleWindow`

Adds a generic popup dropdown choice selector with custom `items`. The selected item can be got/set using `win.get_text()` or `win.set_text()`.

### `win.add_segmented_control(name string, items []string, selected string) &SimpleWindow`

Adds a generic segmented control choice selector containing custom `items`. Choice updates can be set/got via label strings (`win.get_text()`) or 0-indexed segment positions (`win.get_value_int()`).

### `win.add_radio_group(name string, items []string, selected string) &SimpleWindow`

Adds a vertical radio button group layout. Choice updates can be retrieved/set via label strings (`win.get_text()`) or 0-indexed positions (`win.get_value_int()`).

### `win.add_switch(name string, label string, checked bool) &SimpleWindow`

Adds a native horizontal toggle switch. Its active state can be got/set using `win.get_bool()` or `win.set_bool()`.

### `win.add_search_field(name string, placeholder string) &SimpleWindow`

Adds a native magnifying glass search bar textfield.

### `win.add_combo_box(name string, items []string, selected string) &SimpleWindow`

Adds an editable combobox dropdown choice selector containing custom `items`. Users can both type freeform choices and choose from suggestions list. The input text can be get/set using `win.get_text()` or `win.set_text()`.

### `win.add_level_indicator(name string, style int, min_val int, max_val int, value int) &SimpleWindow`

Adds a versatile native macOS level and capacity gauge indicator.

- **Styles**:
  - `0`: Relevancy indicator
  - `1`: Continuous capacity meter
  - `2`: Discrete capacity meter (ticks block)
  - `3`: Star Rating selector

### `win.add_rating(name string, value int) &SimpleWindow`

Convenient shorthand wrapper for `add_level_indicator` that creates an interactive 5-star rating control (min = 0, max = 5, style = 3). Users can click stars directly to change values, which triggers and registers change event callbacks.

### `win.add_spinner(name string, active bool) &SimpleWindow`

Adds an indeterminate activity loading spinner.

- **Parameters**:
  - `active`: If true, the spinner immediately visible and plays its spinning animation loop. If false, the animation stops and the control hides.
- **Toggling**: You can turn the animation on or off programmatically using `win.set_bool(name, true/false)`.

### `win.add_path_control(name string, path string) &SimpleWindow`

Adds a modern breadcrumb path control.

- **Features**: Displays folder tracks beautifully using standard macOS system icons. If `editable` is set to true (default), users can click on links or double-click to invoke standard file dialogues, or drag files direct into the field to populate it.
- **Accessing**: Retrieve or update path text directly using the standard `win.get_text(name)` vs `win.set_text(name, path)`.

### `win.add_token_field(name string, value string) &SimpleWindow`

Adds a token bubble tags editor input field.

- **Features**: Converts typical text phrases into tag chips or tag buttons when users press comma.
- **Reading**: Standard `win.get_text()` returns a clean comma-separated sequence.

---

## 4. Control Sizing & Styling

Customize individual control dimensions and appearance by their registered name.

### `win.set_control_width(name string, width int) &SimpleWindow`

Overwrites the control's Auto Layout width constraint.

### `win.set_control_height(name string, height int) &SimpleWindow`

Overwrites the control's Auto Layout height constraint.

### `win.set_control_font_size(name string, size int) &SimpleWindow`

Changes the control's font size (handles labels, text fields, textareas, and buttons).

### `win.set_control_font_bold(name string, bold bool) &SimpleWindow`

Configures the control's font to Bold weight (supports labels, text fields, textareas, and buttons).

### `win.set_control_font_name(name string, font_name string) &SimpleWindow`

Sets a custom font family/name (e.g. `"Courier"`, `"Helvetica"`, or `"Arial"`) for the control. Falls back to system font if unavailable.

### `win.set_control_background_color(name string, hex_color string) &SimpleWindow`

Sets a custom background color for the individual control.

### `win.set_control_font_color(name string, hex_color string) &SimpleWindow`

Sets a custom text font color for the individual control.

### `win.set_control_visible(name string, visible bool) &SimpleWindow`

Toggles whether the control is shown on screen.

- **Notes**: Hidden controls will automatically collapse within `NSStackView` layouts, dynamically shifting surrounding elements.

### `win.get_control_visible(name string) bool`

Checks if the control is currently visible.

### `win.set_control_enabled(name string, enabled bool) &SimpleWindow`

Enables/disables user interaction on the control. Disabled controls will render greyed out.

### `win.get_control_enabled(name string) bool`

Checks if the control is currently enabled.

### `win.get_control_background_color(name string) string`

Gets the custom background HEX color string of the specified control, or an empty string if none is set.

### `win.get_control_font_color(name string) string`

Gets the custom font HEX color string of the specified control, or an empty string if none is set.

### `win.get_control_width(name string) int`

Gets the custom layout width constraint of the specified control, or `0` if not explicitly constrained.

### `win.get_control_height(name string) int`

Gets the custom layout height constraint of the specified control, or `0` if not explicitly constrained.

### `win.get_control_font_size(name string) int`

Gets the custom font size of the specified control, or `0` if not explicitly configured.

### `win.set_placeholder(name string, text string) &SimpleWindow`

Sets placeholder text for text-based controls such as inputs and password fields.

### `win.set_error(name string, text string) &SimpleWindow`

Applies validation/error feedback to a control and highlights it visually.

### `win.clear_errors() &SimpleWindow`

Clears all active visual validation error states and error messages across all controls at once.

### `win.clear_error(name string) &SimpleWindow`

Clears the visual validation error state and error message for a specific named control.

### `win.get_error(name string) string`

Gets the validation error text currently associated with the specified control, or an empty string if there is no error.

### `win.set_tooltip(name string, text string) &SimpleWindow`

Sets a hover tooltip for any control.

### `win.set_default_button(name string) &SimpleWindow`

Marks a button as the default Enter-key action for the window.

### `win.set_html(name string, html string) &SimpleWindow`

Updates the content shown inside an HTML preview panel.

### Fluent Chaining Modifiers (Last-Control Helpers)

You can chain these modifiers directly onto control creation methods to style or customize the last created control without referencing its name/ID string:

- **`.width(w int) &SimpleWindow`**: Sets the last control's Auto Layout width constraint.
- **`.height(h int) &SimpleWindow`**: Sets the last control's Auto Layout height constraint.
- **`.font_size(size int) &SimpleWindow`**: Changes the last control's font text size.
- **`.bold(b bool) &SimpleWindow`**: Sets the last control's font weight to Bold.
- **`.font_name(font_name string) &SimpleWindow`**: Applies a custom font family (e.g. `"Courier"`) directly to the last control.
- **`.color(hex_color string) &SimpleWindow`**: Sets a custom background color for the last control.
- **`.font_color(hex_color string) &SimpleWindow`**: Sets a custom font color for the last control.
- **`.placeholder(text string) &SimpleWindow`**: Sets placeholder text for the last text-based control.
- **`.error(text string) &SimpleWindow`**: Highlights the last control with validation/error text.
- **`.tooltip(text string) &SimpleWindow`**: Attaches a hover tooltip to the last control.
- **`.visible(visible bool) &SimpleWindow`**: Toggles visibility of the last control.
- **`.enabled(enabled bool) &SimpleWindow`**: Enables or disables user interaction on the last control.
- **`.onclick(callback VoidEventCallback) &SimpleWindow`**: Attaches a click handler to the last created control.
- **`.onchange(callback StringEventCallback) &SimpleWindow`**: Attaches a change handler to the last created control.
- **`.onenter(callback VoidEventCallback) &SimpleWindow`**: Attaches an enter-key handler to the last created control.
- **`.onfocus(callback VoidEventCallback) &SimpleWindow`**: Attaches a focus handler to the last created control.
- **`.onblur(callback VoidEventCallback) &SimpleWindow`**: Attaches a blur handler to the last created control.
- **`.onhover(callback VoidEventCallback) &SimpleWindow`**: Attaches a hover-enter handler to the last created control.
- **`.onhover_exit(callback VoidEventCallback) &SimpleWindow`**: Attaches a hover-exit handler to the last created control.

---

## 5. Dialogs, Popups, & File Pickers

### `win.alert(title string, message string) &SimpleWindow`

Shows a native modal information alert dialog with an OK button.

### `win.alert_with_style(title string, message string, style string) &SimpleWindow`

Shows a native modal alert dialog with a specific visual severity style preset (options: `'info'`, `'warning'`, `'critical'`).

### `win.confirm(title string, message string) bool`

Shows a warning confirmation popup with Yes/No actions, returning a boolean.

### `win.prompt(title string, message string, default_val string) string`

Shows a popup prompt requesting input from the user, returning the entered string (or empty if cancelled).

### `win.choice_dialog(title string, message string, choices []string) int`

Displays a native macOS alert with multiple custom button choices. Returns the 0-indexed choice clicked by the user (or `-1` if cancelled/dismissed).

### `win.select_file() string`

Launches the native macOS file picker panel, returning the chosen file path (or empty if cancelled).

### `win.select_file_with_extensions(extensions string) string`

Launches the native macOS file picker panel filtered by specific file extension constraints (e.g. `'png,txt,pdf'`), returning the chosen file path (or empty if cancelled).

### `win.select_folder() string`

Launches the native macOS folder selection panel, returning the chosen folder path (or empty if cancelled).

### `win.save_file_picker() string`

Launches the native macOS file save panel, returning the target path (or empty if cancelled).

---

## 6. Utilities & System Actions

### `win.toast(message string) &SimpleWindow`

Shows a self-dismissing native overlay toast notification containing the message text.

### `win.open_url(url string) &SimpleWindow`

Opens a web URL in the user's default web browser.

### `win.copy_to_clipboard(text string) &SimpleWindow`

Copies the specified text to the macOS system clipboard.

---

## 7. List Box & Image View Operations

### `win.update_list_items(name string, items []string) &SimpleWindow`

Updates the entire set of rows displayed inside the list box. This is useful for search filters or dynamic updates.

### `win.set_list_selected(name string, index int) &SimpleWindow`

Sets the selected row index in the list box.

### `win.get_list_selected(name string) int`

Returns the 0-indexed selected row in the list box (or `-1` if no row is selected).

### `win.set_image_path(name string, file_path string) &SimpleWindow`

Updates the active image shown in the specified image view control.

---

## 8. Scheduled Timers & Delays

### `win.set_interval(timer_name string, ms int, callback VoidEventCallback) &SimpleWindow`

Starts a recurring main-loop timer that triggers the callback function every `N` milliseconds.

- **Timer Callbacks**: Attaches to `timer_name` trigger. Callback is executed on main V thread.

### `win.stop_interval(timer_name string) &SimpleWindow`

Cancels and invalidates the active interval timer.

### `win.run_after(ms int, callback VoidEventCallback) &SimpleWindow`

Schedules a one-shot delay, executing the callback once after `ms` milliseconds have elapsed.

---

## 9. Reading & Writing Values

### `win.get_text(name string) string`

Reads the string value of any text input, textarea, label, color well, popup, or date picker (including list boxes, returning the text of the selected row).

### `win.get(name string) string`

Beginner-friendly shorthand alias for `win.get_text(name)`.

### `win.set_text(name string, text string) &SimpleWindow`

Sets/updates the text content of any input, textarea, or label.

### `win.set(name string, value string) &SimpleWindow`

Beginner-friendly shorthand alias for `win.set_text(name, value)`.

### `win.get_checked(name string) bool`

Gets the toggle state of a checkbox.

### `win.set_checked(name string, checked bool) &SimpleWindow`

Sets the toggle state of a checkbox.

### `win.get_value_int(name string) int`

Gets the integer value of a slider, progress bar, list box selected index, or number/stepper input.

### `win.set_value_int(name string, value int) &SimpleWindow`

Sets the integer value of a slider, progress bar, list box selected index, or number/stepper input.

### `win.get_status() string`

Reads the current text value of the window status footer.

### `win.set_status(text string) &SimpleWindow`

Updates the text display of the window status footer.

### `win.status(text string) &SimpleWindow`

Alias for `set_status(text)`, updating the window status footer.

### `win.clear(name string) &SimpleWindow`

Clears the value of a specific named control. Text inputs and textareas are set to `""`, checkboxes to `false`, and numeric controls to `0`.

### `win.clear_all() &SimpleWindow`

Clears all input controls in the window.

### `win.reset_form() &SimpleWindow`

Resets all form input controls back to their initial/default values at registration time.

### Name-based generic control accessors

For advanced operations, these methods bypass type assumptions and directly set or read the primitive state value of controls by their named handles:

- **`win.get_value(name string) string`** / **`win.set_value(name string, value string) &SimpleWindow`**: Directly sets or retrieves the raw string value representing any text/HTML-based control content.
- **`win.get_bool(name string) bool`** / **`win.set_bool(name string, checked bool) &SimpleWindow`**: Gets or sets the toggle boolean state of checkbox and switch controls.
- **`win.get_number_value(name string) int`** / **`win.set_number_value(name string, value int) &SimpleWindow`**: Gets or sets the primitive integer value of sliders, progress bars, list boxes selection/indexing, or numeric box steppers.

---

## 10. Event Handling

Callbacks can be attached to any interactive control.

### `win.on_click(name string, callback VoidEventCallback) &SimpleWindow`

Attaches an event handler for button click events.

- **Callback Signature**: `fn (mut win &SimpleWindow)`

### `win.on_change(name string, callback StringEventCallback) &SimpleWindow`

Attaches an event handler for input changes (inputs, checkboxes, sliders, dropdowns, segmented controls, list boxes).

- **Callback Signature**: `fn (mut win &simplegui.SimpleWindow, value string)`

### `win.on_hover(name string, callback VoidEventCallback) &SimpleWindow`

Attaches an event handler when the mouse pointer enters the bounding area of the control.

### `win.on_hover_exit(name string, callback VoidEventCallback) &SimpleWindow`

Attaches an event handler when the mouse pointer exits the bounding area of the control.

### `win.on_focus(name string, callback VoidEventCallback) &SimpleWindow`

Attaches an event handler when a text field input control gains active focus.

### `win.on_blur(name string, callback VoidEventCallback) &SimpleWindow`

Attaches an event handler when a text field input control loses focus.

### `win.on_enter(name string, callback VoidEventCallback) &SimpleWindow`

Attaches an event handler triggered when the Enter/Return key is pressed inside a text input field.

### `win.on_key(key string, callback StringEventCallback) &SimpleWindow`

Attaches a global window-wide keyboard shortcut event listener. The callback value receives the key string.

### `win.on_close(callback VoidEventCallback) &SimpleWindow`

Attaches an event handler executed right before the window is closed and terminated.

### `win.on_resize(callback StringEventCallback) &SimpleWindow`

Attaches an event handler when the application window is resized by the user.

- **Callback Signature**: `fn (mut win &simplegui.SimpleWindow, new_size string)` (where `new_size` has format `"widthxheight"`, e.g. `"640x480"`)

### `win.on_file_drop(callback FileDropCallback) &SimpleWindow`

Attaches an event handler when files are dragged and dropped onto the window or onto a drop zone control.

- **Callback Signature**: `fn (mut win &simplegui.SimpleWindow, files []string)`

---

## 11. Custom Application Menus & Context Menus

### `win.add_menu_item(menu_name string, item_title string, shortcut string, callback VoidEventCallback) &SimpleWindow`

Adds a custom drop-down menu item under the main macOS application menu bar (e.g. under a custom menu tab like "Actions"). Binds the menu click action directly to the callback.

### `win.add_context_menu_item(control_name string, item_title string, callback VoidEventCallback) &SimpleWindow`

Binds a native right-click Context Menu item directly to any control by its `name` handle (or `"window"` to bind it to the general window background). Clicking the triggered choice executes the callback function.

---

## 12. Multi-Column Table / Data Grid

### `win.add_table(name string, columns []string) &SimpleWindow`

Adds a scrollable multi-column table view widget with column headers.

### `win.set_table_rows(name string, rows [][]string) &SimpleWindow`

Updates the entire set of row cells displayed inside the table grid.

### `win.load_table_from_structs[T](name string, items []T) &SimpleWindow`

Populates and renders a scrollable multi-column table widget automatically using field names and values from an array of V structs of generic type `T`. Supports compile-time reflection of `string`, `int`, and `bool` fields.

---

## 12b. Hierarchical Tree View

### `TreeNode` struct

Describes a single node in the tree hierarchy:

- `id`: Unique identifier string.
- `parent_id`: ID of parent node (leave empty `""` for root nodes).
- `text`: Label/text displayed for the node.

```v
pub struct TreeNode {
pub mut:
    id        string
    parent_id string
    text      string
}
```

### `win.add_tree_view(name string, height int) &SimpleWindow`

Adds a scrollable, native hierarchal tree view control with a defined vertical height.

### `win.set_tree_nodes(name string, nodes []TreeNode) &SimpleWindow`

Builds and populates the tree hierarchy from a flat array of nodes. It automatically resolves parent-child relations and expands the nodes by default.

### `win.get_tree_selected(name string) string`

Returns the `id` of the currently selected tree view node, or `""` if no cell is selected.

### `win.set_tree_selected(name string, node_id string) &SimpleWindow`

Programmatically expands parent items as needed, selects the specified node by its `node_id`, and scrolls it into view.

---

---

## 13. Bulk Data Binding

### `win.get_values() map[string]string`

Serializes and returns a map containing all input control names matched to their current text values.

### `win.set_values(values map[string]string) &SimpleWindow`

Sets/updates multiple control text values from a name-value map.

### `win.inspect_controls() string`

Returns a comma-separated string containing the names of all currently registered controls.

### `win.dump_values() map[string]string`

Alias for `get_values()`, serializing all form inputs to a name-value string map.

### `win.bind_to_struct[T](mut data T) &SimpleWindow`

Queries all input control values and populates the matching field names on a mutable struct using compile-time reflection. Supports `string`, `int`, and `bool` fields.

### `win.load_from_struct[T](data T) &SimpleWindow`

Populates GUI controls using matching field name values from the passed struct.

---

## 14. Layout Spacers & Visual Separators

### `win.add_vertical_spacer(height int) &SimpleWindow`

Inserts an empty spacing box of the specified height in the layout stack.

### `win.add_horizontal_spacer(width int) &SimpleWindow`

Inserts an empty spacing box of the specified width in horizontal layout rows.

### `win.add_separator() &SimpleWindow`

Draws a native horizontal visual line divider.

---

## 15. System Status Tray Mode & Thread Safety

### `win.enable_status_bar(icon_path string) &SimpleWindow`

Hides the main window and runs the application as a background macOS menu bar accessory with a dropdown status menu.

### `win.show_window() &SimpleWindow`

Restores window visibility and brings the window to the front.

### `win.run_on_main_thread(callback VoidEventCallback) &SimpleWindow`

Safely queues a UI update callback to execute on the main event thread, bridging background execution threads.

---

## 16. Form Change & Dirty Tracking

You can track if users have modified form fields compared to their baseline state:

### `win.is_dirty() bool`

Returns `true` if any input control (text input, checkbox, toggle, slider, number) has a value different from its last committed baseline state.

### `win.is_control_dirty(name string) bool`

Returns `true` if the specific named control has changed compared to its baseline state.

### `win.commit_changes() &SimpleWindow`

Sets the current control values as the new baseline state, causing `is_dirty()` to reset to `false` without needing to reload the window. Typical use case is after a successful save action.
