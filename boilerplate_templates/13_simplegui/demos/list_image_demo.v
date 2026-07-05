module main

import simplegui
import os

fn main() {
	mut gui := simplegui.new_simple_window('Local Image Browser', 480, 520)
	gui.set_title('Image Gallery Browser')

	// Hidden label to store the active folder path state
	gui.add_label('folder_state', '')
	gui.set_control_visible('folder_state', false)

	gui.begin_row('row_top')
		gui.add_button('btn_select', 'Open Folder...')
		gui.add_label('lbl_folder', 'No folder selected')
	gui.end_row()

	// List box of files (starts empty)
	gui.add_list_box('file_list', [])
	gui.set_control_width('file_list', 440)
	gui.set_control_height('file_list', 120)

	gui.add_label('lbl_info', 'Select an image file above to view preview:')

	// Image view to show the selected preview
	gui.add_image('img_view', '')
	gui.set_control_width('img_view', 300)
	gui.set_control_height('img_view', 300)

	// Callback when "Open Folder..." button is clicked
	gui.on_click('btn_select', fn (mut win &simplegui.SimpleWindow) {
		selected := win.select_folder()
		if selected.len == 0 {
			win.set_status('Folder selection cancelled.')
			return
		}

		// Save the folder path in our hidden state label
		win.set_text('folder_state', selected)
		win.set_text('lbl_folder', os.base(selected))

		// Scan the directory for image files
		files := os.ls(selected) or { [] }
		mut image_files := []string{}
		for f in files {
			ext := os.file_ext(f).to_lower()
			if ext in ['.png', '.jpg', '.jpeg', '.gif', '.bmp'] {
				image_files << f
			}
		}

		if image_files.len == 0 {
			win.update_list_items('file_list', [])
			win.set_image_path('img_view', '')
			win.set_text('lbl_info', 'No image files found in selected folder.')
			win.set_status('No images found.')
			return
		}

		// Populate the list box with the image files
		win.update_list_items('file_list', image_files)
		win.set_list_selected('file_list', 0)
		win.set_status('Found ${image_files.len} images.')
	})

	// Callback when selection changes in the file list box
	gui.on_change('file_list', fn (mut win &simplegui.SimpleWindow, index string) {
		folder := win.get_text('folder_state')
		if folder.len == 0 {
			return
		}

		// Get the filename of the selected list item
		filename := win.get_text('file_list')
		if filename.len == 0 {
			return
		}

		// Build absolute path to the image
		full_path := os.join_path(folder, filename)
		win.set_text('lbl_info', 'File: ${filename}')
		win.set_image_path('img_view', full_path)
		win.set_status('Displaying: ${filename}')
	})

	// Add default settings
	gui.set_background_color('#2C3E50')
	gui.set_font_color('white')
	gui.set_status('Select a folder to begin browsing images')

	gui.run()
}
