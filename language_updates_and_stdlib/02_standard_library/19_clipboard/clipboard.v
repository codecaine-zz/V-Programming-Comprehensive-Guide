module main

import clipboard

fn main() {
	println('=== clipboard Module Demo ===')

	// 1. Initialize clipboard
	mut cb := clipboard.new()
	defer {
		cb.destroy()
	}

	if !cb.is_available() {
		println('Clipboard is not available on this platform/session.')
		return
	}

	// 2. Backup current clipboard content so we do not overwrite user data permanently
	original_text := cb.paste()
	println('Backed up original clipboard text (length: ${original_text.len})')

	// 3. Copy new text to clipboard
	test_message := 'Hello from Vlang standard library!'
	println('Copying text to clipboard: "${test_message}"')
	if cb.copy(test_message) {
		println('Text successfully copied!')
	} else {
		println('Failed to copy text.')
	}

	// 4. Paste back to verify
	pasted_text := cb.paste()
	println('Pasted text from clipboard:  "${pasted_text}"')

	// 5. Restore original clipboard content
	println('Restoring original clipboard content...')
	cb.copy(original_text)
	println('Clipboard restore completed successfully.')
}
