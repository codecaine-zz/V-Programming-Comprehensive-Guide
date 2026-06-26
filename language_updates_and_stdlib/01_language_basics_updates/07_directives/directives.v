module main

fn main() {
	println('=== V Compile-Time Directives Demo ===')

	// $if selects code at compile time based on the target platform or build mode.
	println('\n--- 1. Conditional Compilation (compile-time if) ---')
	$if macos {
		println('Compiled specifically for macOS.')
	}
	$if windows {
		println('Compiled specifically for Windows.')
	}
	$if linux {
		println('Compiled specifically for Linux.')
	}

	$if debug {
		println('Debug mode is active.')
	} $else {
		println('Running in standard release/dev mode.')
	}

	// $env reads environment values while the program is being compiled.
	println('\n--- 2. Compile-Time Environment (compile-time env) ---')
	compile_path := $env('PATH')
	println('PATH length at compile-time: ${compile_path.len} bytes')
	println('PATH starts with: ${compile_path.split(':')[0]}')

	// $embed_file stores a file's contents inside the compiled binary.
	println('\n--- 3. Asset Embedding (compile-time embed) ---')
	embedded_file := $embed_file('temp_embed.txt')
	content := embedded_file.to_string()
	println('Embedded File Content:')
	println(content)

	// $tmpl renders a template file and injects the current variables.
	println('\n--- 4. Template Interpolation (compile-time template) ---')
	name := 'Developer'
	status := 'active'
	rendered_template := $tmpl('template.html')
	println('Rendered Template Output:')
	println(rendered_template)

	// This last example combines compile-time values into a single message.
	println('\n--- 5. Compile-Time String Concatenation (env + tmpl) ---')
	message := $env('HOME') + ' :: ' + rendered_template
	println(message)
}
