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
		mut f := os.open_file(logger.log_file, 'a') or {
			eprintln('Failed to open log file: ${err}')
			return
		}
		f.write((line + '\n').bytes()) or { eprintln('Failed to append log: ${err}') }
		f.close()
	}
}

fn main() {
	println('=== V Logging Boilerplate ===')

	log_path := 'app.log'
	defer {
		if os.exists(log_path) {
			os.rm(log_path) or {}
			println('Cleaned up temporary log file: ${log_path}')
		}
	}

	logger := Logger{
		log_file: log_path
		level:    .info
	}

	logger.log(.debug, 'This debug message is filtered out')
	logger.log(.info, 'Application started')
	logger.log(.warn, 'Configuration value is missing')
	logger.log(.error, 'Something went wrong')
}
