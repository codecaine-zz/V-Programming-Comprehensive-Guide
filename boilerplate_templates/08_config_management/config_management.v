module main

import json
import os

struct AppConfig {
mut:
	host    string
	port    int
	debug   bool
	retries int
}

fn default_config() AppConfig {
	return AppConfig{
		host:    '127.0.0.1'
		port:    8080
		debug:   false
		retries: 3
	}
}

fn load_config(path string) AppConfig {
	mut cfg := default_config()

	if path == '' {
		env_host := os.getenv('APP_HOST')
		if env_host != '' {
			cfg.host = env_host
		}
		env_port := os.getenv('APP_PORT')
		if env_port != '' {
			cfg.port = env_port.int()
		}
		env_debug := os.getenv('APP_DEBUG')
		if env_debug != '' {
			cfg.debug = env_debug == 'true'
		}
		env_retries := os.getenv('APP_RETRIES')
		if env_retries != '' {
			cfg.retries = env_retries.int()
		}
		return cfg
	}

	if !os.exists(path) {
		println('Config file not found. Falling back to defaults.')
		return cfg
	}

	raw := os.read_file(path) or {
		eprintln('Warning: could not read config file: ${err}')
		return cfg
	}

	decoded := json.decode(AppConfig, raw) or {
		eprintln('Warning: could not decode config file: ${err}')
		return cfg
	}

	return decoded
}

fn save_config(path string, cfg AppConfig) {
	data := json.encode(cfg)
	os.write_file(path, data) or { eprintln('Failed to save config file: ${err}') }
}

fn main() {
	println('=== V Configuration Management Boilerplate ===')

	config_path := 'app_config.json'
	mut cfg := load_config(config_path)

	println('Loaded configuration:')
	println('- host: ${cfg.host}')
	println('- port: ${cfg.port}')
	println('- debug: ${cfg.debug}')
	println('- retries: ${cfg.retries}')

	cfg.debug = true
	save_config(config_path, cfg)

	println('Saved configuration to ${config_path}')
}
