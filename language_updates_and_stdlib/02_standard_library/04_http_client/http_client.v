module main

import net.http

fn main() {
	// 1. HTTP GET Request
	println('Sending GET request to vlang.io...')
	get_resp := http.get('https://vlang.io') or {
		println('GET request failed: ${err}')
		return
	}
	println('GET Status Code: ${get_resp.status_code}')

	// Reading a response header
	content_type := get_resp.header.get(.content_type) or { 'unknown' }
	println('GET Content-Type Header: ${content_type}')
	println('GET Body length: ${get_resp.body.len} bytes\n')

	// 2. HTTP POST Request
	println('Sending POST request to httpbin.org...')
	post_body := 'Hello V Standard Library!'
	post_resp := http.post('https://httpbin.org/post', post_body) or {
		println('POST request failed: ${err}')
		return
	}
	println('POST Status Code: ${post_resp.status_code}')
	println('POST Response Body:')
	println(post_resp.body)
}
