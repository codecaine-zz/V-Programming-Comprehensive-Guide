module mod1

import config

pub fn hello() {
	println('Hello from mod1! (using config v${config.version})')
}

fn init() {
	println('Initializing mod1 module (C library stub initialized)...')
}

fn cleanup() {
	println('Cleaning up mod1 module (C library stub released)...')
}
