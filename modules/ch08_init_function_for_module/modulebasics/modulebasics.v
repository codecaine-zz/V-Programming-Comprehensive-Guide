module main

import mod1
import config

fn main() {
	println('Main function started.')
	mod1.hello()
	println('Using config directly in main: v${config.version}')
	println('Main function ending.')
}

