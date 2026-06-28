module main

import xiusin.vredis

fn main() {
	println('==================================================')
	println('     V + Redis Namespaced Helper Easy Demo        ')
	println('==================================================')

	println('Connecting to local Redis at 127.0.0.1:6379...')
	mut client := vredis.new_client(host: '127.0.0.1', port: 6379) or {
		eprintln('\n[ERROR] Failed to connect to Redis server: ${err}')
		eprintln('Please make sure Redis is running locally on port 6379.')
		return
	}
	defer {
		client.close() or {}
		println('\n==================================================')
		println('Demo completed. Redis connection closed.')
		println('==================================================')
	}

	println('Connected successfully!\n')

	// Create a namespaced client wrapper for "cache"
	println('Initializing "cache" namespace wrapper...')
	mut cache := new_namespaced_redis(client, 'cache')

	// Create another namespaced client wrapper for "session"
	println('Initializing "session" namespace wrapper...\n')
	mut session := new_namespaced_redis(client, 'session')

	// 1. Store value in cache namespace (key will be "cache:user_123")
	println('1. Storing data in "cache" namespace (key: "user_123")...')
	cache.set('user_123', '{"name": "Alice", "role": "Admin"}') or { panic(err) }

	// 2. Store value in session namespace (key will be "session:user_123")
	println('2. Storing data in "session" namespace (key: "user_123")...')
	session.set('user_123', 'active_session_token_xyz987') or { panic(err) }

	println('\n--- Retrieval ---')

	// 3. Retrieve values using the namespace helpers
	cache_val := cache.get('user_123') or { panic(err) }
	session_val := session.get('user_123') or { panic(err) }

	println('Retrieved from cache:   "${cache_val}"')
	println('Retrieved from session: "${session_val}"')

	println('\n--- Verification (Direct Raw Lookups) ---')

	// 4. Retrieve values using the raw client directly to show the actual keys stored
	raw_cache := client.get('cache:user_123') or { panic(err) }
	raw_session := client.get('session:user_123') or { panic(err) }
	println('Raw key "cache:user_123" directly:   "${raw_cache}"')
	println('Raw key "session:user_123" directly: "${raw_session}"')

	// Cleanup
	println('\nCleaning up keys...')
	cache.del('user_123') or {}
	session.del('user_123') or {}
	println('Cleanup done.')
}
