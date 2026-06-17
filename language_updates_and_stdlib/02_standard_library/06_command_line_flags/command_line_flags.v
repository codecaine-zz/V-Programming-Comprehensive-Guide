module main

import flag
import os

fn main() {
	// 1. Initialize the flag parser with command line arguments (os.args)
	mut fp := flag.new_flag_parser(os.args)
	fp.application('greet-tool')
	fp.version('1.0.0')
	fp.description("A simple CLI greeting utility demonstrating V's flag module.")

	// 2. Skip the executable name during parsing
	fp.skip_executable()

	// 3. Define flags with their types, short abbreviations, default values, and descriptions
	// The second argument is a u8 rune for the short flag (e.g. `n` for -n), or `0` for none.
	name := fp.string('name', `n`, 'Guest', 'The name of the person to greet')
	verbose := fp.bool('verbose', `v`, false, 'Enable verbose logging output')
	count := fp.int('count', `c`, 1, 'Number of times to print the greeting')

	// 4. Finalize parsing. This returns remaining non-flag arguments or an error.
	additional_args := fp.finalize() or {
		println('Error: ${err}')
		println(fp.usage())
		return
	}

	if verbose {
		println('Verbose Mode: ON')
		println('Parsing completed successfully.')
	}

	// 5. Use the parsed variables
	for i in 0 .. count {
		println('Hello, ${name}! (greeting ${i + 1}/${count})')
	}

	if additional_args.len > 0 {
		println('Additional non-flag arguments: ${additional_args}')
	}
}
