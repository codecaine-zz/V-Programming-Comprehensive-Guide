module main

import flag
import os

// Config holds the validated configuration settings for the application.
struct Config {
	input_file  string
	output_file string
	verbose     bool
	retries     int
	mode        string
}

fn main() {
	// 1. Initialize the flag parser with command-line arguments (os.args)
	mut fp := flag.new_flag_parser(os.args)
	fp.application('v-cli-boilerplate')
	fp.version('1.0.0')
	fp.description('A professional CLI boilerplate showing flag parsing, validation, and structured configurations in V.')

	// 2. Skip the executable path during parsing
	fp.skip_executable()

	// 3. Define flags with short abbreviations, default values, and descriptions
	input_file := fp.string('input', `i`, '', 'Path to the input file (required)')
	output_file := fp.string('output', `o`, 'output.txt', 'Path to the output file')
	verbose := fp.bool('verbose', `v`, false, 'Enable verbose logging')
	retries := fp.int('retries', `r`, 3, 'Number of retries for operation')
	mode := fp.string('mode', `m`, 'default', 'Operation mode (default, fast, safe)')

	// 4. Finalize parsing. This returns remaining non-flag arguments or an error.
	additional_args := fp.finalize() or {
		eprintln('Error: ${err}')
		println(fp.usage())
		exit(1)
	}

	// 5. Validate required flags and values
	if input_file == '' {
		eprintln('Error: --input (-i) flag is required.')
		println(fp.usage())
		exit(1)
	}

	// Validate allowed values for a string enum
	if mode !in ['default', 'fast', 'safe'] {
		eprintln('Error: Invalid mode "${mode}". Must be one of: default, fast, safe.')
		println(fp.usage())
		exit(1)
	}

	// 6. Map parsed arguments to the Config struct for clean division of concerns
	config := Config{
		input_file: input_file
		output_file: output_file
		verbose: verbose
		retries: retries
		mode: mode
	}

	// 7. Run the application logic
	run_app(config, additional_args)
}

fn run_app(cfg Config, args []string) {
	if cfg.verbose {
		println('[DEBUG] Starting application execution...')
		println('[DEBUG] Config: ${cfg}')
		if args.len > 0 {
			println('[DEBUG] Positional Arguments: ${args}')
		}
	}

	println('Processing input file: ${cfg.input_file}')
	println('Operation mode: ${cfg.mode}')
	println('Retries configured: ${cfg.retries}')

	// Perform work here...
	println('Writing results to output file: ${cfg.output_file}')

	println('Success: Application executed successfully!')
}
