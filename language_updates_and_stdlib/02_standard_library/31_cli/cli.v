module main

// The `cli` module builds structured command-line apps with subcommands,
// flags, and auto-generated --help / --version output — similar in spirit
// to tools like `git` (git commit, git push, ...).
//
// Structure of a cli app:
//   Command (root)  -> describes the tool itself
//     ├─ commands   -> subcommands, each with its own execute function
//     └─ flags      -> options like --name/-n parsed for you
//
// Beginner tip: prefer this over hand-parsing os.args once your tool has
// more than one or two options — you get help text and validation for free.
import cli

fn main() {
	println('=== cli Module Demo ===')

	// The root command: the entry point of the tool.
	mut app := cli.Command{
		name:        'tool'
		description: "A sample CLI tool showing V's cli package."
		version:     '1.0.0' // enables the auto-generated --version flag
		posix_mode:  true    // allows grouped short flags like -abc
		execute:     fn (cmd cli.Command) ! {
			// Runs when the user calls `tool` with no subcommand.
			println('Root command execution. Use --help to see subcommands.')
		}
		commands:    [
			// A subcommand: invoked as `tool greet [flags]`.
			cli.Command{
				name:        'greet'
				description: 'Greet a user with custom options'
				posix_mode:  true
				execute:     fn (cmd cli.Command) ! {
					// Flags are read by name; the `or {}` supplies a
					// default when the user omitted the flag.
					name := cmd.flags.get_string('name') or { 'Guest' }
					verbose := cmd.flags.get_bool('verbose') or { false }

					if verbose {
						println('Log: Initiating greeting process...')
					}
					println('Hello, ${name}!')
				}
				// Flag definitions: type, long name, short abbreviation,
				// and the description shown in --help.
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

	// setup() wires everything together (help/version flags, validation).
	app.setup()

	// Normally you would pass the real arguments: app.parse(os.args).
	// Here we feed a mock argument list so the demo is self-contained.
	println('\nParsing args: tool greet --name Antigravity -v')
	app.parse(['tool', 'greet', '--name', 'Antigravity', '-v'])
}
