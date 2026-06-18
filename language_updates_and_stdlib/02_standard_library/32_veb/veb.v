module main

import veb
import net.http
import time

pub struct Context {
	veb.Context
}

pub struct App {
	secret_key string
}

// Route handler
pub fn (app &App) index(mut ctx Context) veb.Result {
	return ctx.text('Hello from veb web framework!')
}

fn main() {
	println('=== veb Web Framework Demo ===')

	mut app := &App{
		secret_key: 'veb_secret_key'
	}

	port := 30088

	// Run the web server in a separate thread to avoid blocking the main execution
	spawn fn [mut app, port] () {
		println('Starting veb server on port ${port}...')
		veb.run[App, Context](mut app, port)
	}()

	// Wait for the server to spin up
	time.sleep(200 * time.millisecond)

	// Make an HTTP GET request to verify the server is running and responding
	url := 'http://localhost:${port}/'
	println('Sending request to: ${url}')
	
	resp := http.get(url) or {
		println('HTTP request failed: ${err}')
		return
	}

	println('Response Status Code: ${resp.status_code}')
	println('Response Body:        "${resp.body}"')
	println('veb server tested successfully.')
}
