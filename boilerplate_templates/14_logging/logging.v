module main

import os
import time

enum LogLevel {
	debug
	info
	warn
	error
}

struct Logger {
	log_file string
	level    LogLevel
}

fn (logger Logger) log(level LogLevel, message string) {
	if int(level) < int(logger.level) {
		return
	}

	timestamp := time.now().str()
	prefix := match level {
		.debug { '[DEBUG]' }
		.info { '[INFO]' }
		.warn { '[WARN]' }
		.error { '[ERROR]' }
	}

	line := '${timestamp} ${prefix} ${message}'
	println(line)
	if logger.log_file != '' {
		existing := os.read_file(logger.log_file) or { '' }
		os.write_file(logger.log_file, existing + line + '\n') or {
			eprintln('Failed to append log: ${err}')
		}
	}
}

fn main() {
	println('=== V Logging Boilerplate ===')

	logger := Logger{
		log_file: 'app.log'
		level:    .info
	}

	logger.log(.debug, 'This debug message is filtered out')
	logger.log(.info, 'Application started')
	logger.log(.warn, 'Configuration value is missing')
	logger.log(.error, 'Something went wrong')
}
