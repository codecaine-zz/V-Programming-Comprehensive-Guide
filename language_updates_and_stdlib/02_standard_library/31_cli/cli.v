module main

import cli

fn main() {
	println('=== cli Module Demo ===')

	mut app := cli.Command{
		name:        'tool'
		description: 'A sample CLI tool showing V\'s cli package.'
		version:     '1.0.0'
		posix_mode:  true
		execute:     fn (cmd cli.Command) ! {
			println('Root command execution. Use --help to see subcommands.')
		}
		commands:    [
			cli.Command{
				name:        'greet'
				description: 'Greet a user with custom options'
				posix_mode:  true
				execute:     fn (cmd cli.Command) ! {
					name := cmd.flags.get_string('name') or { 'Guest' }
					verbose := cmd.flags.get_bool('verbose') or { false }
					
					if verbose {
						println('Log: Initiating greeting process...')
					}
					println('Hello, ${name}!')
				}
				flags: [
					cli.Flag{
						flag:        .string
						name:        'name'
						abbrev:      'n'
						description: 'Name of person to greet'
					},
					cli.Flag{
						flag:        .bool
						name:        'verbose'
						abbrev:      'v'
						description: 'Enable verbose logging'
					},
				]
			},
		]
	}

	app.setup()
	
	// Test by parsing args mock
	println('\nParsing args: tool greet --name Antigravity -v')
	app.parse(['tool', 'greet', '--name', 'Antigravity', '-v'])
}
