module main

import toml

const toml_content = '
# TOML configuration example
title = "V TOML Demo"

[owner]
name = "Antigravity AI"
organization = "Google DeepMind"

[database]
server = "127.0.0.1"
ports = [ 5432, 5433 ]
connection_max = 1000
enabled = true
'

fn main() {
	println('=== TOML Module Demo ===')
	doc := toml.parse_text(toml_content) or {
		println('Failed to parse TOML: ${err}')
		return
	}

	// 1. Reading basic values using value() and type converters
	title := doc.value('title').string()
	println('Project Title: ${title}')

	// 2. Accessing nested tables
	owner_name := doc.value('owner.name').string()
	org := doc.value('owner.organization').string()
	println('Owner: ${owner_name} (${org})')

	// 3. Accessing primitive values
	server := doc.value('database.server').string()
	conn_max := doc.value('database.connection_max').int()
	enabled := doc.value('database.enabled').bool()
	println('DB Server: ${server} | Connection Max: ${conn_max} | Enabled: ${enabled}')

	// 4. Retrieving array values
	ports_any := doc.value('database.ports')
	println('Ports Any: ${ports_any}')
	
	// Accessing array elements with query syntax
	port_0 := doc.value('database.ports[0]').int()
	port_1 := doc.value('database.ports[1]').int()
	println('Primary Port: ${port_0} | Secondary Port: ${port_1}')

	// 5. Using default values for non-existing keys
	db_timeout := doc.value('database.timeout').default_to(30).int()
	println('Database Timeout (Default): ${db_timeout} seconds')

	// 6. Optional retrieval using value_opt()
	if db_server := doc.value_opt('database.server') {
		println('Optional check: Database server key exists. Value = ${db_server.string()}')
	} else {
		println('Optional check: Database server key does not exist.')
	}
}
