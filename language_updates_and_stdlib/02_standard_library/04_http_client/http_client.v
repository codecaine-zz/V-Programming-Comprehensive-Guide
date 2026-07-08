module main

// `net.http` is V's built-in HTTP client — no external dependencies needed.
//
// Beginner tips:
// - Network calls can always fail (no connection, DNS error, timeouts),
//   so http.get()/http.post() return a Result and require `or { ... }`.
// - A response has three interesting parts: status_code (200 = OK,
//   404 = not found, ...), header (metadata), and body (the content).
import net.http

fn main() {
	// 1. HTTP GET Request — fetch a page or an API resource.
	println('Sending GET request to vlang.io...')
	get_resp := http.get('https://vlang.io') or {
		// The `or` block runs on failure; `err` describes what went wrong.
		println('GET request failed: ${err}')
		return
	}
	// 2xx status codes mean success; 4xx/5xx indicate errors.
	println('GET Status Code: ${get_resp.status_code}')

	// Reading a response header. Headers can be absent, so this also
	// returns a Result with a fallback value.
	content_type := get_resp.header.get(.content_type) or { 'unknown' }
	println('GET Content-Type Header: ${content_type}')
	println('GET Body length: ${get_resp.body.len} bytes\n')

	// 2. HTTP POST Request — send data to a server.
	// httpbin.org is a free testing service that echoes back what you send.
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
