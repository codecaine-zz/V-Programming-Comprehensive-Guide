module main

import x.json2 as json
import ttytm.webview
import xiusin.vredis

struct KeyInfo {
	name  string
	@type string
	ttl   int
}

struct KeyDetail {
mut:
	name     string
	@type    string
	ttl      int
	value    string
	list_val []string
	hash_val map[string]string
}

struct ConnectStatus {
	status     string
	host       string
	port       int
	version    string
	keys_count int
}

// Embed the HTML, CSS, and JS file directly into the binary
const html_file = $embed_file('index.html')
const html = html_file.to_string()

fn connect_redis() !&vredis.Redis {
	return vredis.new_client(host: '127.0.0.1', port: 6379)
}

fn redis_connect_status(e &webview.Event) !string {
	mut client := connect_redis() or {
		status_info := ConnectStatus{
			status:     'disconnected'
			host:       '127.0.0.1'
			port:       6379
			version:    ''
			keys_count: 0
		}
		return json.encode(status_info)
	}
	defer {
		client.close() or {}
	}

	mut version := 'Unknown'
	info := client.send('INFO', 'server') or {
		count := client.dbsize() or { 0 }
		status_info := ConnectStatus{
			status:     'connected'
			host:       '127.0.0.1'
			port:       6379
			version:    'Redis (Unknown)'
			keys_count: count
		}
		return json.encode(status_info)
	}

	for line in info.split_into_lines() {
		if line.starts_with('redis_version:') {
			version = line.all_after('redis_version:').trim_space()
			break
		}
	}

	count := client.dbsize() or { 0 }
	status_info := ConnectStatus{
		status:     'connected'
		host:       '127.0.0.1'
		port:       6379
		version:    'Redis ${version}'
		keys_count: count
	}
	return json.encode(status_info)
}

fn redis_list_keys(e &webview.Event) !string {
	pattern := e.get_arg[string](0) or { '*' }
	filter_pattern := if pattern == '' { '*' } else { pattern }

	mut client := connect_redis()!
	defer {
		client.close() or {}
	}

	keys := client.keys(filter_pattern) or { []string{} }
	mut items := []KeyInfo{}

	for key in keys {
		typ := client.key_type(key) or { 'unknown' }
		ttl := client.ttl(key) or { -1 }
		items << KeyInfo{
			name:  key
			@type: typ
			ttl:   ttl
		}
	}

	return json.encode(items)
}

fn redis_get_key_detail(e &webview.Event) !string {
	key := e.get_arg[string](0)!

	mut client := connect_redis()!
	defer {
		client.close() or {}
	}

	typ := client.key_type(key) or { 'none' }
	ttl := client.ttl(key) or { -1 }

	mut detail := KeyDetail{
		name:     key
		@type:    typ
		ttl:      ttl
		value:    ''
		list_val: []string{}
		hash_val: map[string]string{}
	}

	match typ {
		'string' {
			detail.value = client.get(key) or { '' }
		}
		'list' {
			detail.list_val = client.lrange(key, 0, -1) or { []string{} }
		}
		'set' {
			detail.list_val = client.smembers(key) or { []string{} }
		}
		'hash' {
			detail.hash_val = client.hgetall(key) or { map[string]string{} }
		}
		'zset' {
			detail.list_val = client.zrange(key, 0, -1) or { []string{} }
		}
		else {}
	}

	return json.encode(detail)
}

fn redis_set_string(e &webview.Event) !string {
	mut client := connect_redis()!
	defer {
		client.close() or {}
	}

	key := e.get_arg[string](0)!
	val := e.get_arg[string](1)!
	ttl := e.get_arg[int](2)!

	client.set(key, val)!
	if ttl > 0 {
		client.expire(key, ttl)!
	} else if ttl == -1 {
		client.persist(key) or {}
	}
	return 'ok'
}

fn redis_set_list(e &webview.Event) !string {
	mut client := connect_redis()!
	defer {
		client.close() or {}
	}

	key := e.get_arg[string](0)!
	vals_json := e.get_arg[string](1)!
	ttl := e.get_arg[int](2)!

	vals := json.decode[[]string](vals_json)!
	client.del(key) or {}
	for val in vals {
		client.rpush(key, val)!
	}
	if ttl > 0 {
		client.expire(key, ttl)!
	} else if ttl == -1 {
		client.persist(key) or {}
	}
	return 'ok'
}

fn redis_set_hash(e &webview.Event) !string {
	mut client := connect_redis()!
	defer {
		client.close() or {}
	}

	key := e.get_arg[string](0)!
	hash_json := e.get_arg[string](1)!
	ttl := e.get_arg[int](2)!

	fvs := json.decode[map[string]string](hash_json)!
	client.del(key) or {}
	for field, val in fvs {
		client.hset(key, field, val)!
	}
	if ttl > 0 {
		client.expire(key, ttl)!
	} else if ttl == -1 {
		client.persist(key) or {}
	}
	return 'ok'
}

fn redis_set_set(e &webview.Event) !string {
	mut client := connect_redis()!
	defer {
		client.close() or {}
	}

	key := e.get_arg[string](0)!
	vals_json := e.get_arg[string](1)!
	ttl := e.get_arg[int](2)!

	vals := json.decode[[]string](vals_json)!
	client.del(key) or {}
	for val in vals {
		client.sadd(key, val)!
	}
	if ttl > 0 {
		client.expire(key, ttl)!
	} else if ttl == -1 {
		client.persist(key) or {}
	}
	return 'ok'
}

fn redis_del_key(e &webview.Event) !string {
	mut client := connect_redis()!
	defer {
		client.close() or {}
	}

	key := e.get_arg[string](0)!
	client.del(key)!
	return 'ok'
}

fn redis_flush_db(e &webview.Event) !string {
	mut client := connect_redis()!
	defer {
		client.close() or {}
	}

	client.flushdb()!
	return 'ok'
}

fn main() {
	mut w := webview.create(debug: true)
	defer {
		w.destroy()
	}
	w.set_title('V + Redis GUI Dashboard')
	w.set_size(1080, 720, .@none)

	// Bindings
	w.bind_opt[string]('redis_connect_status', redis_connect_status)
	w.bind_opt[string]('redis_get_keys', redis_get_keys)
	w.bind_opt[string]('redis_get_key_detail', redis_get_key_detail)
	w.bind_opt[string]('redis_set_string', redis_set_string)
	w.bind_opt[string]('redis_set_list', redis_set_list)
	w.bind_opt[string]('redis_set_hash', redis_set_hash)
	w.bind_opt[string]('redis_set_set', redis_set_set)
	w.bind_opt[string]('redis_del_key', redis_del_key)
	w.bind_opt[string]('redis_flush_db', redis_flush_db)

	w.set_html(html)
	w.run()
}
