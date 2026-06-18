module main

import log
import crypto.sha256
import crypto.md5

fn main() {
	println('=== Log & Crypto Module Examples ===')

	// --- log ---
	println('\n--- log ---')
	// V's log module provides customizable levels (debug, info, warn, error, fatal)
	mut logger := log.Log{}
	logger.set_level(.info) // Set threshold (ignores debug level)
	
	logger.info('Logger initialized.')
	logger.warn('This is a warning message.')
	logger.error('This is an error message.')

	// --- crypto ---
	println('\n--- crypto ---')
	input := 'V language standard library'
	
	// SHA256 Hash
	sha_hash := sha256.hexhash(input)
	println('SHA-256 of "${input}":')
	println('  ${sha_hash}')

	// MD5 Hash
	md5_hash := md5.hexhash(input)
	println('MD5 of "${input}":')
	println('  ${md5_hash}')
}
