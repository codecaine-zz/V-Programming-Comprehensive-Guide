module main

import simplegui

struct Product {
mut:
	id       string
	name     string
	category string
	stock    int
	price    f64
}

// AppState holds the reactive model of the application
struct AppState {
mut:
	products         []Product
	selected_row_idx int = -1
	selected_col_idx int
	filter_query     string
	filtered_indices []int
}

// Helper to filter products list and format data into table string rows
fn filter_and_format_rows(mut state AppState) [][]string {
	state.filtered_indices = []int{}
	mut rows := [][]string{}
	for i, p in state.products {
		id_match := p.id.to_lower().contains(state.filter_query.to_lower())
		name_match := p.name.to_lower().contains(state.filter_query.to_lower())
		cat_match := p.category.to_lower().contains(state.filter_query.to_lower())
		if state.filter_query == '' || id_match || name_match || cat_match {
			state.filtered_indices << i
			rows << [
				p.id,
				p.name,
				p.category,
				p.stock.str(),
				f64_to_currency(p.price)
			]
		}
	}
	return rows
}

// Friendly currency formatting helper
fn f64_to_currency(val f64) string {
	return '$' + val.str()
}

// Standard column title helper
fn get_column_header(col_idx int) string {
	return match col_idx {
		0 { 'ID' }
		1 { 'Name' }
		2 { 'Category' }
		3 { 'Stock' }
		4 { 'Price' }
		else { 'None' }
	}
}

// sync_selection_to_ui refreshes the side editor and cell highlights from current state indices
fn sync_selection_to_ui(mut win &simplegui.SimpleWindow, mut state AppState) {
	if state.selected_row_idx >= 0 && state.selected_row_idx < state.filtered_indices.len {
		prod_idx := state.filtered_indices[state.selected_row_idx]
		p := state.products[prod_idx]

		// Update Row Form Editor fields
		win.set_text('id_input', p.id)
		win.set_text('name_input', p.name)
		win.set_text('category_input', p.category)
		win.set_value_int('stock_input', p.stock)
		win.set_text('price_input', p.price.str())

		// Update Cell Spot Editor fields based on selected column index
		cell_val := match state.selected_col_idx {
			0 { p.id }
			1 { p.name }
			2 { p.category }
			3 { p.stock.str() }
			4 { p.price.str() }
			else { '' }
		}

		win.set_text('cell_coords_label', 'Coordinate: [Row ' + (state.selected_row_idx + 1).str() + ', Column: ' + get_column_header(state.selected_col_idx) + ']')
		win.set_text('cell_value_input', cell_val)
		win.set_text('info_label', 'Currently Selected: Product ' + p.id + ' (' + p.name + ')')
		
		win.set_control_enabled('delete_row_btn', true)
		win.set_control_enabled('save_row_btn', true)
		win.set_control_enabled('update_cell_btn', true)
	} else {
		// Clear Row Form Editor
		win.set_text('id_input', '')
		win.set_text('name_input', '')
		win.set_text('category_input', '')
		win.set_value_int('stock_input', 0)
		win.set_text('price_input', '')

		// Clear Cell Spot Editor
		win.set_text('cell_coords_label', 'Coordinate: [No Row Selected]')
		win.set_text('cell_value_input', '')
		win.set_text('info_label', 'Select a row in the table above to start interactively editing.')
		
		win.set_control_enabled('delete_row_btn', false)
		win.set_control_enabled('save_row_btn', false)
		win.set_control_enabled('update_cell_btn', false)
	}
}

fn main() {
	// 1. Initial State Definition with Mock Data
	mut state := AppState{
		products: [
			Product{ id: 'P101', name: 'MacBook Pro M3', category: 'Laptops', stock: 45, price: 1999.99 },
			Product{ id: 'P102', name: 'iPhone 15 Pro', category: 'Phones', stock: 82, price: 999.49 },
			Product{ id: 'P103', name: 'iPad Air Retina', category: 'Tablets', stock: 30, price: 599.00 },
			Product{ id: 'P104', name: 'Ultra Studio Display', category: 'Monitors', stock: 12, price: 1499.95 },
			Product{ id: 'P105', name: 'AirPods Max Hifi', category: 'Audio', stock: 64, price: 549.00 },
		]
	}

	// 2. Main Window setup with Auto-sizing and responsive grids
	mut win := simplegui.new_simple_window('Product Inventory Grid Editor', 750, 620)
	win.set_title('Product Stock & Price Grid Editor')

	// Heading labels
	win.add_label('header', 'Product Inventory Table Editor')
		.bold(true)
		.font_size(18)
		.font_color('#0ea5e9') // Bright sky-blue header
	
	win.add_label('sys_intro', 'Select rows in the grid to sync field editors, edit cell-level values, or apply bulk updates.')
		.font_size(11)
		.font_color('#94a3b8')

	// Real-time Search Panel Row
	win.begin_row('search_row')
		win.add_label('search_lbl', 'Fuzzy Filter:').width(80)
		win.add_input('search_input', '').placeholder('Type to search ID, Name, or Category in real-time...')
	win.end_row()

	// 3. Grid Row Multi-Column Table view (The central spreadsheet)
	win.add_table('products_table', ['ID', 'Product Name', 'Category', 'Stock Level', 'Unit Price'])
	win.set_control_height('products_table', 140)

	// Status description label showing selection context
	win.add_label('info_label', 'Select a row in the table above to start interactively editing.')
		.bold(true)
		.font_size(12)
		.font_color('#38bdf8')
	
	win.add_separator()

	// Bottom Editors section wrapped side-by-side using rows and group containers
	win.begin_row('multi_editor_pane')
		
		// COLUMN 1: Entire Row Details Form Editor Group
		win.add_group_box('row_group', 'Row-Level Form Details')
		win.add_label('lbl_id', 'Product Code/ID:').font_size(11)
		win.add_input('id_input', '')
		
		win.add_label('lbl_name', 'Product Name:').font_size(11)
		win.add_input('name_input', '')
		
		win.begin_row('cat_stock_row')
			win.add_label('lbl_category', 'Category:').font_size(11).width(60)
			win.add_input('category_input', '')
			win.add_label('lbl_stock', 'Stock Qty:').font_size(11).width(60)
			win.add_number('stock_input', 0)
		win.end_row()
		
		win.add_label('lbl_price', 'Price Value ($):').font_size(11)
		win.add_input('price_input', '')
		
		// Row Form Action buttons
		win.begin_row('form_actions')
			win.add_button('save_row_btn', 'Save Row Changes')
			win.add_button('add_row_btn', 'Add as New Product')
			win.add_button('delete_row_btn', 'Delete Row')
		win.end_row()
		
		// COLUMN 2: Cell Spot Column Selector and Bulk Ops Group Box
		win.add_group_box('cell_group', 'Cell-Level Spot & Bulk Editor')
		
		win.add_label('cell_coords_label', 'Coordinate: [No Row Selected]')
			.bold(true)
			.font_size(12)
			.font_color('#f43f5e')

		win.begin_row('col_choose_row')
			win.add_label('col_lbl', 'Spot Column:').font_size(11).width(80)
			win.add_dropdown('col_select', ['0: ID', '1: Name', '2: Category', '3: Stock', '4: Price'], '0: ID')
		win.end_row()

		win.add_label('lbl_cell_val', 'Cell Value Input:').font_size(11)
		win.begin_row('cell_input_row')
			win.add_input('cell_value_input', '')
			win.add_button('update_cell_btn', 'Apply Cell Update')
		win.end_row()

		win.add_separator()

		win.add_label('bulk_title', 'Grid Bulk Automation Tasks:').bold(true).font_size(12).font_color('#fbbf24')
		
		win.begin_row('bulk_actions')
			win.add_button('bulk_stock_btn', 'Increase Filtered Stock (+10)')
			win.add_button('bulk_discount_btn', 'Apply 15% Category Discount')
			win.add_button('reset_grid_btn', 'Reset to Clean Data')
		win.end_row()

	win.end_row()

	// Initial table population
	rows := filter_and_format_rows(mut state)
	win.set_table_rows('products_table', rows)
	sync_selection_to_ui(mut win, mut state)

	// --- 4. Event Handlers Configuration ---

	// A. Table selection change handler
	win.on_change('products_table', fn [mut state] (mut w &simplegui.SimpleWindow, value string) {
		selected := w.get_list_selected('products_table')
		state.selected_row_idx = selected
		sync_selection_to_ui(mut w, mut state)
		w.set_status('Row ' + (selected + 1).str() + ' selected.')
	})

	// B. Column Dropdown Selection Change handler
	win.on_change('col_select', fn [mut state] (mut w &simplegui.SimpleWindow, value string) {
		// Map text selection to numeric column index
		col_idx := if value.starts_with('0') {
			0
		} else if value.starts_with('1') {
			1
		} else if value.starts_with('2') {
			2
		} else if value.starts_with('3') {
			3
		} else if value.starts_with('4') {
			4
		} else {
			0
		}
		state.selected_col_idx = col_idx
		sync_selection_to_ui(mut w, mut state)
		w.set_status('Column selection changed to: ' + get_column_header(col_idx))
	})

	// C. Fuzzy Search Text Field handler
	win.on_change('search_input', fn [mut state] (mut w &simplegui.SimpleWindow, value string) {
		state.filter_query = value
		state.selected_row_idx = -1 // Reset selection on query changes to avoid mismatch
		
		filtered := filter_and_format_rows(mut state)
		w.set_table_rows('products_table', filtered)
		sync_selection_to_ui(mut w, mut state)
		w.set_status('Filtered results count: ' + filtered.len.str() + ' rows.')
	})

	// D. "Save Row Changes" button handler
	win.on_click('save_row_btn', fn [mut state] (mut w &simplegui.SimpleWindow) {
		if state.selected_row_idx < 0 || state.selected_row_idx >= state.filtered_indices.len {
			w.alert('Row Update Info', 'Please select a row first to make changes.')
			return
		}
		
		prod_idx := state.filtered_indices[state.selected_row_idx]
		
		id := w.get_text('id_input').trim_space()
		name := w.get_text('name_input').trim_space()
		category := w.get_text('category_input').trim_space()
		stock := w.get_value_int('stock_input')
		price_str := w.get_text('price_input').trim_space()

		if id == '' || name == '' || category == '' {
			w.alert('Validation Error', 'ID, Name, and Category cannot be empty!')
			return
		}

		price := price_str.f64()
		if price <= 0.0 {
			w.alert('ValidationError', 'Please specify a valid numeric price!')
			return
		}

		// Mutate product record at original index
		state.products[prod_idx] = Product{
			id: id
			name: name
			category: category
			stock: stock
			price: price
		}

		rows_list := filter_and_format_rows(mut state)
		w.set_table_rows('products_table', rows_list)
		sync_selection_to_ui(mut w, mut state)
		
		w.alert('Success', 'Product updated successfully!')
		w.set_status('Product ' + id + ' saved.')
	})

	// E. "Add as New Product" button handler
	win.on_click('add_row_btn', fn [mut state] (mut w &simplegui.SimpleWindow) {
		id := w.get_text('id_input').trim_space()
		name := w.get_text('name_input').trim_space()
		category := w.get_text('category_input').trim_space()
		stock := w.get_value_int('stock_input')
		price_str := w.get_text('price_input').trim_space()

		if id == '' || name == '' || category == '' {
			w.alert('Validation Error', 'To create a product, please provide of an ID, Name, and Category!')
			return
		}

		price := price_str.f64()
		if price <= 0.0 {
			w.alert('Validation Error', 'Price must be a valid positive float number!')
			return
		}

		// Add code checks to prevent duplication
		for p in state.products {
			if p.id.to_lower() == id.to_lower() {
				w.alert('Duplicate Detected', 'A product with ID ' + id + ' already exists!')
				return
			}
		}

		// Append
		new_item := Product{
			id: id
			name: name
			category: category
			stock: stock
			price: price
		}
		state.products << new_item
		state.selected_row_idx = -1 // Reset selection

		rows_list := filter_and_format_rows(mut state)
		w.set_table_rows('products_table', rows_list)
		sync_selection_to_ui(mut w, mut state)
		
		w.alert('Product Created', 'New item ' + id + ' added to inventory.')
		w.set_status('Created Product: ' + id)
	})

	// F. "Delete Row" button handler
	win.on_click('delete_row_btn', fn [mut state] (mut w &simplegui.SimpleWindow) {
		if state.selected_row_idx < 0 || state.selected_row_idx >= state.filtered_indices.len {
			w.alert('Deletion Error', 'No product row selected.')
			return
		}

		prod_idx := state.filtered_indices[state.selected_row_idx]
		target_id := state.products[prod_idx].id

		if w.confirm('Confirm Deletion', 'Are you sure you want to permanently delete product ' + target_id + '?') {
			state.products.delete(prod_idx)
			state.selected_row_idx = -1

			rows_list := filter_and_format_rows(mut state)
			w.set_table_rows('products_table', rows_list)
			sync_selection_to_ui(mut w, mut state)
			
			w.set_status('Deleted Product: ' + target_id)
		}
	})

	// G. "Apply Cell Update" button handler
	win.on_click('update_cell_btn', fn [mut state] (mut w &simplegui.SimpleWindow) {
		if state.selected_row_idx < 0 || state.selected_row_idx >= state.filtered_indices.len {
			w.alert('Update Cell Info', 'Select a row to pinpoint the target cell.')
			return
		}

		prod_idx := state.filtered_indices[state.selected_row_idx]
		cell_text := w.get_text('cell_value_input').trim_space()

		if cell_text == '' {
			w.alert('Cell Error', 'Cell content cannot be entirely blank!')
			return
		}

		// Edit specific property of selected struct
		match state.selected_col_idx {
			0 { 
				state.products[prod_idx].id = cell_text 
			}
			1 { 
				state.products[prod_idx].name = cell_text 
			}
			2 { 
				state.products[prod_idx].category = cell_text 
			}
			3 { 
				state.products[prod_idx].stock = cell_text.int() 
			}
			4 { 
				state.products[prod_idx].price = cell_text.f64() 
			}
			else {}
		}

		rows_list := filter_and_format_rows(mut state)
		w.set_table_rows('products_table', rows_list)
		sync_selection_to_ui(mut w, mut state)
		w.set_status('Cell updated directly on original records.')
	})

	// H. Bulk Stock Increase (+10) Task
	win.on_click('bulk_stock_btn', fn [mut state] (mut w &simplegui.SimpleWindow) {
		if state.filtered_indices.len == 0 {
			w.alert('Bulk Actions', 'No filtered records in current grid view to update!')
			return
		}

		if w.confirm('Bulk Update Confirm', 'Add +10 Stock quantity directly to all ' + state.filtered_indices.len.str() + ' visible items?') {
			for idx in state.filtered_indices {
				state.products[idx].stock += 10
			}

			rows_list := filter_and_format_rows(mut state)
			w.set_table_rows('products_table', rows_list)
			sync_selection_to_ui(mut w, mut state)
			
			w.alert('Success', 'Added stock quantity bulk update.')
			w.set_status('Applied stock increase (+10) to visible items.')
		}
	})

	// I. Apply 15% Category Discount Task
	win.on_click('bulk_discount_btn', fn [mut state] (mut w &simplegui.SimpleWindow) {
		selected_cat := w.get_text('category_input').trim_space()
		if selected_cat == '' {
			w.alert('Selection Required', 'Please select a row or fill in "Category" under Row Details to state which category gets the 15% discount!')
			return
		}

		if w.confirm('Apply Discount', 'Apply a 15% bulk discount to all products of category "' + selected_cat + '"?') {
			mut count := 0
			for mut p in state.products {
				if p.category.to_lower() == selected_cat.to_lower() {
					discounted := p.price * 0.85
					// Rounded to two decimal places
					p.price = f64(int(discounted * 100 + 0.5)) / 100.0
					count++
				}
			}

			rows_list := filter_and_format_rows(mut state)
			w.set_table_rows('products_table', rows_list)
			sync_selection_to_ui(mut w, mut state)
			
			w.alert('Success', 'Discounted ' + count.str() + ' products of category: ' + selected_cat)
			w.set_status('Bulk 15% discount applied to category: ' + selected_cat)
		}
	})

	// J. Reset Grid clean state button
	win.on_click('reset_grid_btn', fn [mut state] (mut w &simplegui.SimpleWindow) {
		if w.confirm('Reset Grid Confirm', 'Discard all local changes and reset to defaults?') {
			state.products = [
				Product{ id: 'P101', name: 'MacBook Pro M3', category: 'Laptops', stock: 45, price: 1999.99 },
				Product{ id: 'P102', name: 'iPhone 15 Pro', category: 'Phones', stock: 82, price: 999.49 },
				Product{ id: 'P103', name: 'iPad Air Retina', category: 'Tablets', stock: 30, price: 599.00 },
				Product{ id: 'P104', name: 'Ultra Studio Display', category: 'Monitors', stock: 12, price: 1499.95 },
				Product{ id: 'P105', name: 'AirPods Max Hifi', category: 'Audio', stock: 64, price: 549.00 },
			]
			state.selected_row_idx = -1
			state.filter_query = ''
			w.set_text('search_input', '')

			rows_list := filter_and_format_rows(mut state)
			w.set_table_rows('products_table', rows_list)
			sync_selection_to_ui(mut w, mut state)
			
			w.set_status('Grid editor state reset to defaults.')
		}
	})

	// 5. Stylize look and feel
	win.set_background_color('#1e293b') // Mid-Dark slate background
	win.set_font_color('#f8fafc') // White text
	win.set_status('Grid Editor Initialized. Double-click or select items.')

	win.run()
}
