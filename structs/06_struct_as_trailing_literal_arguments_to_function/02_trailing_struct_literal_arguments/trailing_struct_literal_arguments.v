module main

@[params]
struct ButtonConfig {
	text        string
	is_disabled bool
	width       int = 70
	height      int = 20
}

struct Button {
	text   string
	width  int
	height int
}

fn new_button(c ButtonConfig) &Button {
	return &Button{
		width:  c.width
		height: c.height
		text:   c.text
	}
}

fn main() {
	println('=== Trailing Struct Literal Arguments ===')
	// Omitting both the struct name and braces
	button := new_button(text: 'Click me', width: 100)
	println('button: width=${button.width}, height=${button.height}, text="${button.text}"')
	assert button.height == 20
	assert button.width == 100
	assert button.text == 'Click me'
}
