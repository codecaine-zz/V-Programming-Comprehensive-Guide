import noinit_config

fn main() {
	// This works because it uses the constructor function
	cfg := noinit_config.new_config(8080, 'localhost')
	println('Config port: ${cfg.port}, host: ${cfg.host}')

	// This would fail compilation because noinit_config.Config is marked [noinit]:
	// cfg2 := noinit_config.Config{ port: 8080, host: 'localhost' }
}
