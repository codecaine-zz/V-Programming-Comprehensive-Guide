module main

import simplegui

@[heap]
struct AppState {
mut:
	nodes []simplegui.TreeNode
}

fn (mut state AppState) refresh(mut win &simplegui.SimpleWindow) {
	win.set_tree_nodes('my_tree', state.nodes)
}

fn main() {
	mut state := &AppState{
		nodes: [
			simplegui.TreeNode{ id: 'root', parent_id: '', text: 'Enterprise Services' },
			simplegui.TreeNode{ id: 'dept_engineering', parent_id: 'root', text: 'Engineering Division' },
			simplegui.TreeNode{ id: 'team_frontend', parent_id: 'dept_engineering', text: 'Frontend Team' },
			simplegui.TreeNode{ id: 'team_backend', parent_id: 'dept_engineering', text: 'Backend Systems Team' },
			simplegui.TreeNode{ id: 'team_devops', parent_id: 'dept_engineering', text: 'DevOps & Infra' },
			simplegui.TreeNode{ id: 'dept_design', parent_id: 'root', text: 'Product Design Division' },
			simplegui.TreeNode{ id: 'team_ux', parent_id: 'dept_design', text: 'UX Research' },
			simplegui.TreeNode{ id: 'team_ui', parent_id: 'dept_design', text: 'UI / Design Systems' },
			simplegui.TreeNode{ id: 'dept_hr', parent_id: 'root', text: 'Human Resources' },
		]
	}

	mut win := simplegui.new_simple_window('Native TreeView & Hierarchy Demo', 720, 520)
	
	win.set_debug_mode(true)
	win.set_padding(20)
	win.set_spacing(10)
	win.set_theme('dracula')

	win.add_heading('Hierarchical Tree View Control')
	win.add_label('description', 'This demo showcases the implementation of a recursive native TreeView (NSOutlineView) control in V SimpleGUI.')
		.font_size(12)

	win.begin_row('main_row')
		// Left: The Tree View container
		win.add_tree_view('my_tree', 200)
			.width(340)

		// Right: Tree Actions
		win.add_group_box('actions_box', 'Manage Tree Nodes')
			win.group('actions_group', '', fn [mut state] (mut w &simplegui.SimpleWindow) {
				w.add_label('lbl_info', 'Fill fields below to add child nodes:')
				w.add_form_field('Node Name:', 'new_node_text', 'New Sub-Team')
				w.add_form_field('Parent ID:', 'new_node_parent', '')
				w.add_form_field('Node ID:', 'new_node_id', 'dynamic_node')
				
				w.add_button('btn_add', 'Add Node')
					.onclick(fn [mut state] (mut w &simplegui.SimpleWindow) {
						id := w.get('new_node_id').trim_space()
						parent := w.get('new_node_parent').trim_space()
						text := w.get('new_node_text').trim_space()

						if id == '' || text == '' {
							w.alert('Verification Error', 'Both ID and text of the node must have a value.')
							return
						}

						// Check for duplicates
						for node in state.nodes {
							if node.id == id {
								w.alert('Duplication Error', 'A node with ID "${id}" already exists.')
								return
							}
						}

						state.nodes << simplegui.TreeNode{
							id: id
							parent_id: parent
							text: text
						}
						state.refresh(mut w)
						w.toast('Node Added Successfully')
					})
			})
	win.end_row()

	// Selection and showing controls
	win.add_label('selection_lbl', 'Selected Node ID: None')
		.bold(true)

	win.begin_row('actions_row')
		win.add_button('expand_custom', 'Select Front-End')
			.onclick(fn (mut w &simplegui.SimpleWindow) {
				w.set_tree_selected('my_tree', 'team_frontend')
			})

		win.add_button('expand_devops', 'Select DevOps')
			.onclick(fn (mut w &simplegui.SimpleWindow) {
				w.set_tree_selected('my_tree', 'team_devops')
			})

		win.add_button('btn_clear', 'Clear Selection')
			.onclick(fn (mut w &simplegui.SimpleWindow) {
				w.set_tree_selected('my_tree', '')
				w.set_text('selection_lbl', 'Selected Node ID: None')
				w.set_text('new_node_parent', '')
			})
	win.end_row()

	// Sync tree nodes selection event
	win.on_change('my_tree', fn (mut w &simplegui.SimpleWindow, selected_id string) {
		if selected_id == '' {
			w.set_text('selection_lbl', 'Selected Node ID: None')
			w.set_text('new_node_parent', '')
		} else {
			w.set_text('selection_lbl', 'Selected Node ID: ${selected_id}')
			w.set_text('new_node_parent', selected_id)
		}
	})

	// Initial tree data display
	state.refresh(mut win)

	win.run()
}
