module main

@[assert_continues]
fn check_value(ii int) {
	assert ii == 2
}

fn main() {
	println('=== Assert Continues ===')
	for i in 0 .. 4 {
		check_value(i)
	}
	println('Finished running!')
}
