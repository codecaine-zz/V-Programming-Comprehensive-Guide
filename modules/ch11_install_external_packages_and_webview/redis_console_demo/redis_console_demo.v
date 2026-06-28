module main

import xiusin.vredis

fn main() {
	println('==================================================')
	println('       V + Redis Console API Learning Demo        ')
	println('==================================================')

	println('Connecting to local Redis at 127.0.0.1:6379...')
	mut r := vredis.new_client(host: '127.0.0.1', port: 6379) or {
		eprintln('\n[ERROR] Failed to connect to Redis server: ${err}')
		eprintln('Please make sure Redis is running locally on port 6379.')
		return
	}
	defer {
		r.close() or {}
		println('\n==================================================')
		println('Demo completed. Redis connection closed.')
		println('==================================================')
	}

	println('Connected successfully!\n')

	// Clean up any old test keys first
	r.del('demo:string') or {}
	r.del('demo:counter') or {}
	r.del('demo:list') or {}
	r.del('demo:hash') or {}
	r.del('demo:set') or {}

	// --- 1. String Operations ---
	println('--- 1. String Operations ---')
	println('Setting "demo:string" to "Hello V + Redis!"...')
	r.set('demo:string', 'Hello V + Redis!') or { panic(err) }

	val := r.get('demo:string') or { panic(err) }
	println('GET "demo:string" -> "${val}"')

	// Increment demo
	r.incr('demo:counter') or { panic(err) }
	r.incr('demo:counter') or { panic(err) }
	counter_val := r.get('demo:counter') or { panic(err) }
	println('Counter INCR twice -> "${counter_val}"')

	// TTL Demo
	println('Setting expiry of 5 seconds on "demo:string"...')
	r.expire('demo:string', 5) or { panic(err) }
	ttl_val := r.ttl('demo:string') or { panic(err) }
	println('TTL remaining: ${ttl_val} seconds\n')

	// --- 2. List Operations ---
	println('--- 2. List Operations ---')
	println('Pushing items to "demo:list" (item_a, item_b, item_c)...')
	r.rpush('demo:list', 'item_a') or { panic(err) }
	r.rpush('demo:list', 'item_b') or { panic(err) }
	r.rpush('demo:list', 'item_c') or { panic(err) }

	list_len := r.llen('demo:list') or { panic(err) }
	println('List length: ${list_len}')

	list_items := r.lrange('demo:list', 0, -1) or { panic(err) }
	println('List elements: ${list_items}')

	popped := r.lpop('demo:list') or { panic(err) }
	println('Popped from left (LPOP): "${popped}"')

	list_items_after := r.lrange('demo:list', 0, -1) or { panic(err) }
	println('List elements after LPOP: ${list_items_after}\n')

	// --- 3. Hash Operations ---
	println('--- 3. Hash Operations ---')
	println('Setting fields in "demo:hash"...')
	r.hset('demo:hash', 'name', 'V Programming Language') or { panic(err) }
	r.hset('demo:hash', 'year', '2019') or { panic(err) }
	r.hset('demo:hash', 'creator', 'Alex Medvednikov') or { panic(err) }

	name_field := r.hget('demo:hash', 'name') or { panic(err) }
	println('HGET "demo:hash" "name" -> "${name_field}"')

	hash_all := r.hgetall('demo:hash') or { panic(err) }
	println('HGETALL "demo:hash" fields & values:')
	for k, v in hash_all {
		println('  - ${k}: ${v}')
	}
	println('')

	// --- 4. Set Operations ---
	println('--- 4. Set Operations ---')
	println('Adding members to "demo:set"...')
	r.sadd('demo:set', 'apple') or { panic(err) }
	r.sadd('demo:set', 'banana') or { panic(err) }
	r.sadd('demo:set', 'apple') or { panic(err) } // Duplicate (should be ignored)

	is_banana := r.sismember('demo:set', 'banana') or { panic(err) }
	is_cherry := r.sismember('demo:set', 'cherry') or { panic(err) }
	println('SISMEMBER "demo:set" "banana": ${is_banana}')
	println('SISMEMBER "demo:set" "cherry": ${is_cherry}')

	set_members := r.smembers('demo:set') or { panic(err) }
	println('SMEMBERS "demo:set": ${set_members}\n')

	// --- 5. Namespaced Helper Demo ---
	println('--- 5. Namespaced Helper Demo ---')
	println('Creating a namespaced helper with namespace "app_v1"...')
	mut nr := new_namespaced_redis(r, 'app_v1')

	println('Setting namespaced key "user_token" (resolved key will be "app_v1:user_token")...')
	nr.set('user_token', 'token_abc123') or { panic(err) }

	token := nr.get('user_token') or { panic(err) }
	println('GET "user_token" via helper -> "${token}"')

	// Verify the actual key in Redis (without namespace helper) has the prefix
	actual_key := 'app_v1:user_token'
	actual_val := r.get(actual_key) or { panic(err) }
	println('GET raw "${actual_key}" directly from client -> "${actual_val}"')

	// Cleanup namespaced keys
	println('Cleaning up namespaced keys...')
	nr.del('user_token') or {}

	// Clean up test keys
	println('\nCleaning up created keys...')
	r.del('demo:string') or {}
	r.del('demo:counter') or {}
	r.del('demo:list') or {}
	r.del('demo:hash') or {}
	r.del('demo:set') or {}
	println('Cleanup done.')
}
