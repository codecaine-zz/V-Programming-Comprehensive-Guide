module main

import crypto.sha256
import mymod.sha256 as mysha256

fn main() {
	println('=== Module Import Aliasing ===')
	// Use the standard crypto.sha256:
	v_hash := sha256.sum('hi'.bytes()).hex()
	// Use our aliased mymod.sha256:
	my_hash := mysha256.sum('hi'.bytes())
	
	println('Standard hash: ${v_hash}')
	println('Aliased mymod hash: ${my_hash}')
	
	assert my_hash == 'mock_sha256_sum_for_aliasing_demo'
}
