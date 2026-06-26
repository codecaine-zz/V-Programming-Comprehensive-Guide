module noinit_config

@[noinit]
pub struct Config {
pub:
	port int
	host string
}

// Public constructor function to allow initialization from outside
pub fn new_config(port int, host string) Config {
	return Config{
		port: port
		host: host
	}
}
