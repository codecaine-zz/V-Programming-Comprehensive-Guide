module main

import net.http
import json

struct PostPayload {
	title   string @[json: 'title']
	body    string @[json: 'body']
	user_id int    @[json: 'userId']
}

struct PostResponse {
	id      int    @[json: 'id']
	title   string @[json: 'title']
	body    string @[json: 'body']
	user_id int    @[json: 'userId']
}

fn fetch_json(url string) !string {
	resp := http.get(url) or { return error('GET request failed: ${err}') }
	if resp.status_code >= 400 {
		return error('Request failed with status ${resp.status_code}')
	}
	return resp.body
}

fn post_json(url string, payload PostPayload) !PostResponse {
	body := json.encode(payload)
	
	// Set Content-Type explicitly for compliance with strict JSON APIs
	mut req := http.Request{
		method: .post
		url: url
		data: body
	}
	req.header.set(.content_type, 'application/json')

	resp := req.do() or { return error('POST request failed: ${err}') }
	if resp.status_code >= 400 {
		return error('Request failed with status ${resp.status_code}')
	}
	return json.decode(PostResponse, resp.body) or { return error('Invalid JSON response') }
}

fn main() {
	println('=== V HTTP Client Boilerplate ===')

	body := fetch_json('https://httpbin.org/get') or {
		eprintln('${err}')
		return
	}
	println('GET response body:')
	println(body)

	response := post_json('https://jsonplaceholder.typicode.com/posts', PostPayload{
		title: 'Ada'
		body: 'Developer'
		user_id: 1
	}) or {
		eprintln('${err}')
		return
	}

	println('\nPOST response:')
	println('id:      ${response.id}')
	println('title:   ${response.title}')
	println('body:    ${response.body}')
	println('user_id: ${response.user_id}')
}
