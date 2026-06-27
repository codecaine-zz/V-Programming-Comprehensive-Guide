module main

import net.http
import json

struct UserPayload {
	name string @[json: 'name']
	job  string @[json: 'job']
}

struct UserResponse {
	name string @[json: 'name']
	job  string @[json: 'job']
	id   string @[json: 'id']
	created_at string @[json: 'created_at']
}

fn fetch_json(url string) !string {
	resp := http.get(url) or { return error('GET request failed: ${err}') }
	if resp.status_code >= 400 {
		return error('Request failed with status ${resp.status_code}')
	}
	return resp.body
}

fn post_json(url string, payload UserPayload) !UserResponse {
	body := json.encode(payload)
	resp := http.post(url, body) or { return error('POST request failed: ${err}') }
	if resp.status_code >= 400 {
		return error('Request failed with status ${resp.status_code}')
	}
	return json.decode(UserResponse, resp.body) or { return error('Invalid JSON response') }
}

fn main() {
	println('=== V HTTP Client Boilerplate ===')

	body := fetch_json('https://httpbin.org/get') or {
		eprintln('${err}')
		return
	}
	println('GET response body:')
	println(body)

	response := post_json('https://httpbin.org/post', UserPayload{
		name: 'Ada'
		job: 'Developer'
	}) or {
		eprintln('${err}')
		return
	}

	println('\nPOST response:')
	println('name: ${response.name}')
	println('job: ${response.job}')
	println('id: ${response.id}')
}
