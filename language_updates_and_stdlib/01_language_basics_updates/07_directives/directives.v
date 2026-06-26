module main

fn main() {
	println('=== V Compile-Time Directives & Code Demo ===')

	// 1. Conditional Compilation ($if) and multiple conditions
	println('\n--- 1. Conditional Compilation (compile-time \$if) ---')
	$if macos {
		println('OS target: macOS')
	}
	$if windows {
		println('OS target: Windows')
	}
	$if linux {
		println('OS target: Linux')
	}

	// Multiple conditions in one branch
	$if ios || android {
		println('Target platform is a mobile device (iOS/Android).')
	} $else $if macos || linux || windows {
		println('Target platform is a desktop OS.')
	}

	$if linux && x64 {
		println('Running specifically on 64-bit Linux.')
	}

	// 2. $if as an expression
	println('\n--- 2. \$if Used as an Expression ---')
	os_family := $if windows { 'Windows' } $else { 'Unix-like' }
	println('OS Family expression: ${os_family}')

	// 3. $else-$if compiler branches
	println('\n--- 3. Compiler Type Detection (\$else-\$if) ---')
	$if tinyc {
		println('Compiled with: TinyC')
	} $else $if clang {
		println('Compiled with: Clang')
	} $else $if gcc {
		println('Compiled with: GCC')
	} $else $if msvc {
		println('Compiled with: MSVC')
	} $else {
		println('Compiled with a different/unspecified compiler')
	}

	// 4. Custom Compile-time Flag defines ($d) with defaults
	println('\n--- 4. Compile-Time Flags (\$d) with Default Values ---')
	// $d brings values defined via compiler flags (-d flag=val or -d flag)
	// Default value must be a pure literal (boolean, int, float, string, or rune)
	custom_str := $d('custom_str', 'Default Text')
	custom_bool := $d('custom_bool', false)
	custom_int := $d('custom_int', 42)
	custom_float := $d('custom_float', 3.14159)
	custom_char := $d('custom_char', `v`)

	println('custom_str: ${custom_str}')
	println('custom_bool: ${custom_bool}')
	println('custom_int: ${custom_int}')
	println('custom_float: ${custom_float}')
	println('custom_char: ${rune(custom_char)}')

	// We can also use $d('ident', false) inside $if condition to conditionally enable/disable code:
	$if $d('enable_feature', false) {
		println('Special feature is ENABLED at compile-time!')
	} $else {
		println('Special feature is DISABLED (default). Compile with `v -d enable_feature run directives.v` to enable.')
	}

	// 5. Compile-time custom errors and warnings
	println('\n--- 5. Compile-Time Errors and Warnings (\$compile_error, \$compile_warn) ---')
	// These only trigger if the enclosing $if branch is active/evaluated at compile time.
	$if $d('trigger_error', false) {
		$compile_error('Explicit compile-time error triggered')
	}
	$if $d('trigger_warn', false) {
		$compile_warn('Explicit compile-time warning triggered')
	}
	println('No compile-time errors/warnings triggered during this compilation run.')

	// 6. $env reads environment values while the program is being compiled.
	println('\n--- 6. Compile-Time Environment (compile-time env) ---')
	compile_path := $env('PATH')
	println('PATH length at compile-time: ${compile_path.len} bytes')

	// 7. $embed_file stores a file's contents inside the compiled binary.
	println('\n--- 7. Asset Embedding (compile-time embed) ---')
	embedded_file := $embed_file('temp_embed.txt')
	content := embedded_file.to_string()
	println('Embedded File Content:')
	println(content)

	// 8. $tmpl renders a template file and injects the current variables.
	println('\n--- 8. Template Interpolation (compile-time template) ---')
	name := 'Developer'
	status := 'active'
	rendered_template := $tmpl('template.html')
	println('Rendered Template Output:')
	println(rendered_template)
}
