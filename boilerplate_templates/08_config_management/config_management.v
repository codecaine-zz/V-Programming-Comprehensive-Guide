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

	// 1. If path is provided and exists, load config from the JSON file first
	if path != '' && os.exists(path) {
		raw := os.read_file(path) or {
			eprintln('Warning: could not read config file: ${err}')
			''
		}
		if raw != '' {
			cfg = json.decode(AppConfig, raw) or {
				eprintln('Warning: could not decode config file: ${err}')
				cfg
			}
		}
	} else if path != '' {
		println('Config file not found. Using defaults with environment overrides.')
	}

	// 2. Overlay / override with environment variables (crucial for production container envs)
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

fn save_config(path string, cfg AppConfig) {
	data := json.encode(cfg)
	os.write_file(path, data) or { eprint('Failed to save config file: ${err}') }
}

fn main() {
	println('=== V Configuration Management Boilerplate ===')

	config_path := 'app_config.json'
	
	// Ensure we cleanup the generated file on exit
	defer {
		if os.exists(config_path) {
			os.rm(config_path) or {}
			println('Cleaned up temporary config file: ${config_path}')
		}
	}

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
