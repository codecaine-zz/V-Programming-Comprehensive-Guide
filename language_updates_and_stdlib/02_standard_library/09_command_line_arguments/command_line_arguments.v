module main

import os

fn main() {
	// os.args is a []string containing all command line arguments.
	// os.args[0] is always the name of the executable (or the script path if run via v run).
	// os.args[1..] contains the actual command-line arguments passed to the program.
	println('Executable / script path: ${os.args[0]}')
	println('Total arguments count:    ${os.args.len}')
	println('All arguments list:       ${os.args}')

	if os.args.len < 2 {
		println('\nUsage: v run command_line_arguments.v <command> [arguments...]')
		println('Try running: v run command_line_arguments.v greet Alice')
		println('Try running: v run command_line_arguments.v sum 3 5 8')
		return
	}

	command := os.args[1]
	args := os.args[2..]

	println('\nProcessing command: "${command}" with args: ${args}')

	match command {
		'greet' {
			if args.len < 1 {
				println('Error: greet command requires a name.')
				return
			}
			name := args[0]
			println('Hello, ${name}!')
		}
		'sum' {
			if args.len < 1 {
				println('Error: sum command requires at least one number.')
				return
			}
			mut total := 0
			for arg in args {
				num := arg.int()
				total += num
			}
			println('Sum of numbers: ${total}')
		}
		else {
			println('Unknown command: "${command}". Allowed commands: "greet", "sum".')
		}
	}
}
