module main

fn main() {
	println('=== V Compile-Time Directives Demo ===')

	// 1. $if Directive (Conditional Compilation)
	println('\n--- 1. Conditional Compilation (\$if) ---')
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

	// 2. $env Directive (Compile-time Environment Variables)
	println('\n--- 2. Compile-Time Environment (\$env) ---')
	// Retrieves the value of the environment variable at compilation time
	compile_path := $env('PATH')
	println('PATH length at compile-time: ${compile_path.len} bytes')

	// 3. $embed_file Directive (Compile-time Asset Embedding)
	println('\n--- 3. Asset Embedding (\$embed_file) ---')
	// Embeds the file content directly into the binary at compile time.
	// Returns an embed_file.EmbedFileData struct which we convert to string.
	embedded_file := $embed_file('temp_embed.txt')
	content := embedded_file.to_string()
	println('Embedded File Content:')
	println(content)

	// 4. $tmpl Directive (Compile-time Template Interpolation)
	println('\n--- 4. Template Interpolation (\$tmpl) ---')
	// Interpolates local variables inside the template file at compile time.
	name := 'Developer'
	status := 'active'
	
	// Renders the template with the variables in the current scope
	rendered_template := $tmpl('template.html')
	println('Rendered Template Output:')
	println(rendered_template)
}
