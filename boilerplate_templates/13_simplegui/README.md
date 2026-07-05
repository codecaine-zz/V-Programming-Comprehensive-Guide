# V macOS Native Window

A small macOS-native GUI starter project written in V, designed to feel approachable for programmers coming from Python, Delphi, or VBA.

## What this project does

This project combines:

- a lightweight V-side wrapper for creating GUI controls
- a native Cocoa bridge for real macOS windows and controls
- a beginner-friendly API for adding named controls, setting/getting values, and attaching event handlers

It is intended to make GUI programming feel more direct and less manual than the raw Cocoa/Objective-C approach.

## Features

- Create named controls such as labels, text inputs, text areas, buttons, checkboxes, and number fields
- **NSComboBox**: Rich editable dropdown combo box combining a text field with popup select options (freeform typing and suggestions)
- **NSLevelIndicator / Rating**: Beautiful interactive 5-star rating systems and discrete/continuous capacity, level, and value indicators
- **NSTokenField / Tags Entry**: Standard bubble tags & chips entry input field separated by delimiter (comma etc.)
- **NSPathControl**: High-fidelity macOS native breadcrumb item displaying folders and file system links (drag/drop and editable)
- **Activity Loading Spinner**: Native spinning wheel loader for background tasks and asynchronous operations
- Set and read values by control name
- Support multiple controls of the same kind using distinct names
- Attach simple event handlers for clicks and value changes
- Open a real native macOS window with a built-in demo
- Support native keyboard shortcuts: **CMD + F** to toggle full screen, **CMD + Q** to quit the application
- Pin a window above other windows with the new always-on-top API

## Example

```v
import simplegui

fn main() {
    mut gui := simplegui.new_simple_window('My App', 700, 500)

    gui.add_input('name', 'Ada')
    gui.add_button('run', 'Run')

    gui.on_change('name', on_name_changed)
    gui.on_click('run', on_run_clicked)

    gui.run()
}

fn on_name_changed(mut win &simplegui.SimpleWindow, value string) {
    println('name changed: ${value}')
}

fn on_run_clicked(mut win &simplegui.SimpleWindow) {
    println('run clicked')
}
```

## Quick start template

```v
module main

import simplegui

fn main() {
    mut win := simplegui.new_simple_window('Starter', 640, 420)
    win.add_input('name', 'Ada')
    win.add_button('save', 'Save')
    win.on_click('save', fn (mut win &simplegui.SimpleWindow) {
        println("saved: ${win.get_text('name')}")
    })
    win.run()
}
```

## Faster form building

For common forms, a few high-level helpers keep the code short:

```v
mut win := simplegui.new_simple_window('Profile', 640, 420)
win.configure(fn (mut cfg simplegui.WindowConfig) {
    cfg.title = 'Profile'
    cfg.padding = 18
    cfg.spacing = 10
})
win.form('Account', fn (mut w &simplegui.SimpleWindow) {
    w.add_input('email', 'ada@example.com')
    w.add_checkbox('newsletter', 'Subscribe', true)
})
win.section('Preferences', fn (mut w &simplegui.SimpleWindow) {
    w.add_number('experience', 8)
})
win.add_action('save', 'Save', fn (mut win &simplegui.SimpleWindow) {
    println(win.validate_controls({
        'email': simplegui.validate_not_empty
    }))
})
```

## Best Practices & Layout Starters

To build responsive, native applications easily, follow these proven design patterns and structural layouts.

### 1. The Easiest Way to Build (The Golden Rules)

- **Always Configure Early**: Use `.configure(...)` right at the start to declare window geometry, paddings, and alignment spacing.
- **Keep Event Callbacks Stateless**: Avoid global mutability. Pass all parameters or query active states dynamically using `win.get_text()` or `win.get_checked()`.
- **Use Fluent Chaining**: Builder modifiers like `.placeholder()`, `.font_size()`, and `.enabled()` can be chained immediately after creating the control, avoiding any redundant `win.set_...` calls.

---

### 2. Starter Template: Vertical Stack Layout (Default Flow)

Best for simple forms, log views, setup wizards, and linear layouts where controls stack nicely top-to-bottom.

```v
module main

import simplegui

fn main() {
    simplegui.new_simple_window('Vertical Starter', 440, 520)
        .configure(fn (mut cfg simplegui.WindowConfig) {
            cfg.padding = 20
            cfg.spacing = 12
        })
        .add_heading('App Settings')

        .add_label('lbl_user', 'Username')
        .add_input('username', 'ada_lovelace')
            .placeholder('Enter username...')
            .tooltip('At least 3 characters')

        .add_toggle('newsletter', 'Subscribe to daily newsletter', true)

        .add_action('btn_submit', 'Submit Settings', on_submit)
        .run()
}

fn on_submit(mut win &simplegui.SimpleWindow) {
    username := win.get_text('username')
    subscribed := win.get_checked('newsletter')

    win.alert('Status Updated', 'Saved user ${username} (Newsletter: ${subscribed})')
}
```

---

### 3. Starter Template: Side-by-Side Row Layout (Grid Columns)

Best for tabular layouts, calculators, search bars with inline action buttons, or database filter fields aligned horizontally.

```v
module main

import simplegui

fn main() {
    mut win := simplegui.new_simple_window('Row Grid Starter', 640, 320)
        .set_theme('dracula')
        .set_padding(20)

    win.add_heading('Database Lookup Filters')

    // Closure-based row helper aligns children side-by-side automatically
    win.row('filters_row', fn (mut w &simplegui.SimpleWindow) {
        w.add_label('', 'Category:')
        w.add_dropdown('category', ['Engineering', 'Marketing', 'Sales'], 'Engineering')
            .width(150)
            .onchange(on_filter_changed)

        w.add_label('', 'ID:')
        w.add_number('filter_id', 101)
            .width(80)
            .onchange(on_filter_changed)

        w.add_button('btn_search', 'Search')
            .onclick(on_search_clicked)
    })

    win.add_textarea('output', 'Search results will render here...')
        .height(120)

    win.run()
}

fn on_filter_changed(mut win &simplegui.SimpleWindow, value string) {
    category := win.get_text('category')
    id := win.get_value_int('filter_id')
    win.set_status('Active filter: Category=${category}, ID=${id}')
}

fn on_search_clicked(mut win &simplegui.SimpleWindow) {
    category := win.get_text('category')
    id := win.get_value_int('filter_id')

    win.set_text('output', 'Running database query...\nFetched records matching ${category} with minimum ID ${id}!')
    win.toast('Queries fetched successfully')
}
```

---

### 4. Interactive Getting, Setting, and Event Binding Pattern

Use this template to see how to programmatically manipulate labels, checkboxes, text values, sliders, and progress loaders dynamically on click or change.

```v
module main

import simplegui

fn main() {
    simplegui.new_simple_window('State Controller', 520, 480)
        .set_theme('nord')
        .set_padding(18)
        .add_heading('Controller Panel')

        .add_slider('volume_slider', 50)
            .onchange(on_volume_changed)

        .add_label('lbl_volume', 'Current Volume: 50%')

        .add_separator()

        .add_checkbox('mute_toggle', 'Mute output entirely', false)
            .onchange(on_mute_toggled)

        .add_progress_indicator('prog_bar', 50)

        .add_action('reset_btn', 'Reset Back to Factory Defaults', on_reset_clicked)
        .run()
}

fn on_volume_changed(mut win &simplegui.SimpleWindow, value string) {
    // 1. Get mutated value
    vol := win.get_value_int('volume_slider')

    // 2. Set companion label text and progress indicator
    win.set_text('lbl_volume', 'Current Volume: ${vol}%')
    win.set_value_int('prog_bar', vol)
}

fn on_mute_toggled(mut win &simplegui.SimpleWindow, value string) {
    muted := win.get_checked('mute_toggle')

    if muted {
        // Backup volume slider, set visual feedback or disable
        win.set_text('lbl_volume', 'Current Volume: MUTED')
        win.set_value_int('prog_bar', 0)
        win.set_control_enabled('volume_slider', false)
    } else {
        // Re-enable and restore companion status
        vol := win.get_value_int('volume_slider')
        win.set_text('lbl_volume', 'Current Volume: ${vol}%')
        win.set_value_int('prog_bar', vol)
        win.set_control_enabled('volume_slider', true)
    }
}

fn on_reset_clicked(mut win &simplegui.SimpleWindow) {
    // Programmatically overwrite and set states on control handles
    win.set_value_int('volume_slider', 50)
    win.set_text('lbl_volume', 'Current Volume: 50%')
    win.set_value_int('prog_bar', 50)
    win.set_checked('mute_toggle', false)
    win.set_control_enabled('volume_slider', true)

    win.toast('Defaults restored')
}
```

## Developer tips

- Use the built-in control discovery helpers: `has_control`, `list_controls`, and `get_control_kind`.
- Calling `get_value`, `set_value`, `get_checked`, or similar on a missing control now raises a clear panic to make mistakes visible early.
- The API is intentionally lightweight; start with the named control helpers and add layout helpers only when needed.

## Screenshots

The following native macOS windows were captured dynamically by building and running each live V demo:

### High-Fidelity App & Web Studios

- **Web HTML Studio**: `v run demos/web_studio_demo.v`
  ![Web HTML Studio](screenshots/web_studio_demo.png)
- **Markdown Live Editor**: `v run demos/markdown_editor.v`
  ![Markdown Live Editor](screenshots/markdown_editor.png)
- **Product Catalog CRUD Grid**: `v run demos/grid_data_editor.v`
  ![Product Catalog CRUD](screenshots/grid_data_editor.png)

### Layout & Component Showcases

- **Vertical Stack Style (Default Layout)**: `v run demos/stack_style.v`
  ![Vertical Stack Style](screenshots/stack_style.png)
- **Grid Column Layout**: `v run demos/grid_style.v`
  ![Grid Layout](screenshots/grid_style.png)
- **Advanced Preferences Settings**: `v run demos/settings_editor.v`
  ![Settings Editor](screenshots/settings_editor.png)
- **Single-Window All Controls**: `v run demos/all_controls_demo.v`
  ![All Controls Demo](screenshots/all_controls_demo.png)
- **Hierarchical Tree View**: `v run demos/tree_view_demo.v`
  ![Tree View Demo](screenshots/tree_view_demo.png)
- **Interactive Rich Level Indicators & ComboBox**: `v run demos/modern_widgets_demo.v`
  ![Rich Widgets Demo](screenshots/modern_widgets_demo.png)
- **Advanced macOS Rich Controls Showcase**: `v run demos/rich_widgets_demo.v`
  ![Advanced Controls Suite](screenshots/rich_widgets_demo.png)

### Built-in Interactive Utilities

- **Interactive Calculator**: `v run demos/calculator.v`
  ![Calculator](screenshots/calculator.png)
- **Database Query Viewer**: `v run demos/data_viewer.v`
  ![Data Viewer](screenshots/data_viewer.png)
- **Task Timer Loader**: `v run demos/timer_demo.v`
  ![Timer Demo](screenshots/timer_demo.png)
- **List & Image Preview Selector**: `v run demos/list_image_demo.v`
  ![List & Image Demo](screenshots/list_image_demo.png)
- **Events & State Controller**: `v run demos/events_demo.v`
  ![Events Demo](screenshots/events_demo.png)

### Custom & Architectural Patterns

- **Delphi & RAD Inspired Showcase**: `v run demos/delphi_inspired_demo.v`
  ![Delphi Demo](screenshots/delphi_inspired_demo.png)
- **Ergonomic Reflection Form Building**: `v run demos/ergonomic_demo.v`
  ![Ergonomic Demo](screenshots/ergonomic_demo.png)
- **Sticky Yellow Overlay Notepad**: `v run demos/overlay_widget_demo.v`
  ![Overlay Widget Demo](screenshots/overlay_widget_demo.png)
- **Always On Top Window**: `v run demos/always_on_top_demo.v`
  ![Always On Top Demo](screenshots/always_on_top_demo.png)
- **Developer DX Showcase**: `v run demos/dx_showcase.v`
  ![DX Showcase Demo](screenshots/dx_showcase.png)
- **Fluent Window Configurations**: `v run demos/configuration_demo.v`
  ![Window Config Demo](screenshots/configuration_demo.png)
- **Dirty Form Change Tracking**: `v run demos/dirty_form_demo.v`
  ![Dirty Form Demo](screenshots/dirty_form_demo.png)

## Requirements

- macOS
- V installed and available on your PATH
- Xcode Command Line Tools

## Run the demos

This project supports two different layout styles:

1. **Vertical Stack Style**: The default linear, top-to-bottom layout.
2. **Grid / Row-based Style**: Allows grouping multiple controls side-by-side inside rows.

### Run the main demo (which combines both styles)

```bash
v run .
```

### Run the Stack Style demo

```bash
v run demos/stack_style.v
```

### Run the Grid Style demo

```bash
v run demos/grid_style.v
```

### Run the starter template

```bash
v run demos/starter_template.v
```

### Run the Best Practices: Vertical Stack Starter demo

```bash
v run demos/vertical_stack_starter.v
```

### Run the Best Practices: Grid Column Starter demo

```bash
v run demos/grid_column_starter.v
```

### Run the Best Practices: State Controller Pattern demo

```bash
v run demos/state_controller_pattern.v
```

### Run the Calculator demo

```bash
v run demos/calculator.v
```

### Run the Settings Editor demo

```bash
v run demos/settings_editor.v
```

### Run the Data Viewer/Filter demo

```bash
v run demos/data_viewer.v
```

### Run the Timer & Progress loader demo

```bash
v run demos/timer_demo.v
```

### Run the List & Image Preview Selector demo

```bash
v run demos/list_image_demo.v
```

### Run the Interactive Events & States demo

```bash
v run demos/events_demo.v
```

### Run the single-window all-controls demo

```bash
v run demos/all_controls_demo.v
```

### Run the always-on-top demo

```bash
v run demos/always_on_top_demo.v
```

### Run the Hierarchical Tree View demo

```bash
v run demos/tree_view_demo.v
```

### Run the Ergonomic Helpers demo

```bash
v run demos/ergonomic_demo.v
```

### Run the Delphi & C# Inspired RAD Showcase demo

```bash
v run demos/delphi_inspired_demo.v
```

### Run the developer experience (DX) showcase demo

```bash
v run demos/dx_features_demo.v
```

### Run the High-Level Helpers demo

```bash
v run demos/high_level_demo.v
```

### Run the Native Menu Bar & Text Shortcuts demo

```bash
v run demos/menu_demo.v
```

### Run the Advanced Typography & Features demo

```bash
v run demos/advanced_features_demo.v
```

### Run the Beginner Friendly signup demo

```bash
v run demos/beginner_demo.v
```

### Run the Window Configuration demo

```bash
v run demos/configuration_demo.v
```

### Run the Change Tracking & Dirty Form demo

```bash
v run demos/dirty_form_demo.v
```

### Run the Developer Experience DX Showcase

```bash
v run demos/dx_showcase.v
```

### Run the QoL Bulk Binding Features demo

```bash
v run demos/features_demo.v
```

### Run the Product Catalog CRUD Grid Editor demo

```bash
v run demos/grid_data_editor.v
```

### Run the Studio Markdown Live Editor demo

```bash
v run demos/markdown_editor.v
```

### Run the Interactive Web HTML Studio demo

```bash
v run demos/web_studio_demo.v
```

### Run the Native Switch & Custom Controls Showcase

```bash
v run demos/new_controls_demo.v
```

### Run the Sticky Floating Yellow Pad Overlay widget

```bash
v run demos/overlay_widget_demo.v
```

### Run the Interactive Window controller demo

```bash
v run demos/window_controller_demo.v
```

## Run tests

```bash
v test .
```

## Project files

- [main.v](main.v) — example app and demo entry point
- [demos/starter_template.v](demos/starter_template.v) — minimal starter app for new developers
- [simplegui/simplegui.v](simplegui/simplegui.v) — beginner-friendly wrapper API module
- [simplegui/window.m](simplegui/window.m) — native macOS bridge implementation
- [simplegui/window.h](simplegui/window.h) — bridge declarations used by V
- [simplegui_test.v](simplegui_test.v) — regression tests for the wrapper API
- [demos/stack_style.v](demos/stack_style.v) — demo of clean, vertical form stacking
- [demos/grid_style.v](demos/grid_style.v) — demo of side-by-side row-based grids
- [demos/calculator.v](demos/calculator.v) — interactive math calculator showing nested grid rows
- [demos/settings_editor.v](demos/settings_editor.v) — advanced dashboard containing date picker, color wells, modes
- [demos/data_viewer.v](demos/data_viewer.v) — mock database user records lookup table with filters
- [demos/timer_demo.v](demos/timer_demo.v) — background timer tasks updating progress indicators periodically
- [demos/list_image_demo.v](demos/list_image_demo.v) — interactive list selector previewing mockup screenshots in real time
- [demos/events_demo.v](demos/events_demo.v) — advanced event listener triggers for hover, focus, lose focus (blur), and window resizes
- [demos/all_controls_demo.v](demos/all_controls_demo.v) — single-window demo that exercises many controls in one place
- [demos/high_level_demo.v](demos/high_level_demo.v) — showcases the new beginner-friendly helper API for forms and actions
- [demos/menu_demo.v](demos/menu_demo.v) — demo of standard macOS application menus and text editing shortcuts
- [demos/dx_features_demo.v](demos/dx_features_demo.v) — showcases the developer experience (DX) ergonomics improvements (reflection form building, chaining, nameless controls, action rows, and debug mode)
- [demos/advanced_features_demo.v](demos/advanced_features_demo.v) — showcases advanced typography and macOS APIs
- [demos/beginner_demo.v](demos/beginner_demo.v) — beginner-friendly signup form and profile builder
- [demos/configuration_demo.v](demos/configuration_demo.v) — fluent configurations using WindowConfig
- [demos/dirty_form_demo.v](demos/dirty_form_demo.v) — illustrates live form dirty-tracking state and control validation callbacks
- [demos/dx_showcase.v](demos/dx_showcase.v) — demonstrates high-level horizontal rows, layout nesting, and fluent styling modifiers
- [demos/features_demo.v](demos/features_demo.v) — showcases compiling-time struct binding and automatic multi-column tables
- [demos/grid_data_editor.v](demos/grid_data_editor.v) — a fully-functional reactive database inventory-catalog CRUD grid editing dashboard
- [demos/markdown_editor.v](demos/markdown_editor.v) — a complete live Markdown Studio layout using full WebKit render updates
- [demos/new_controls_demo.v](demos/new_controls_demo.v) — exercises advanced segmented menus, popup selections, and search fields
- [demos/overlay_widget_demo.v](demos/overlay_widget_demo.v) — sticky window overlay yellow notepad memo widget with custom styling
- [demos/window_controller_demo.v](demos/window_controller_demo.v) — lets you programmatically resize, move, center, track dimensions, and fade opacity of the main Window at runtime
- [demos/always_on_top_demo.v](demos/always_on_top_demo.v) — a utility app indicating how window z-axis float levels behaves
- [demos/ergonomic_demo.v](demos/ergonomic_demo.v) — showcases lightweight ergonomic helpers for window configuration and forms
- [demos/delphi_inspired_demo.v](demos/delphi_inspired_demo.v) — showcases standard Delphi RAD tool look and event bindings
- [demos/vertical_stack_starter.v](demos/vertical_stack_starter.v) — starter template demonstrating best practices for vertical stack forms
- [demos/grid_column_starter.v](demos/grid_column_starter.v) — starter template demonstrating horizontal row layouts and event handling
- [demos/state_controller_pattern.v](demos/state_controller_pattern.v) — interactive design pattern illustrating state manipulation and reactive controls
- [demos/web_studio_demo.v](demos/web_studio_demo.v) — real-world business intelligence (BI) KPI & Fintech analytics board integrating native V widgets, responsive HTML structures, CSS custom layout properties, and Javascript currency loaders

## Notes

The goal of this project is to provide a simple, high-abstraction GUI layer that feels familiar to people who are used to event-driven environments like Delphi, VBA, or Python-based UI toolkits.
