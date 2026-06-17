module main

// ==========================================
// Define Custom Error Types
// ==========================================

// CustomError embeds the builtin Error struct to implement the IError interface.
struct CustomError {
	Error // Required: provides default implementations of msg() and code()
	message string
	code    int
}

// Overwrite the msg() method for CustomError
fn (err CustomError) msg() string {
	return err.message
}

// Overwrite the code() method for CustomError
fn (err CustomError) code() int {
	return err.code
}

// DatabaseError represents another custom error type.
struct DatabaseError {
	Error
	query string
}

fn (err DatabaseError) msg() string {
	return 'Database error executing query: "${err.query}"'
}

// ==========================================
// 1. Option Types (?T)
// Options represent either a value of type T or nothing (none).
// ==========================================

// find_item returns a string if found, or none if not.
fn find_item(id int) ?string {
	if id == 42 {
		return 'V programming book'
	}
	return none // return absence of value
}

// find_item_wrapper demonstrates Option propagation with the `?` suffix.
fn find_item_wrapper(id int) ?string {
	// If find_item returns none, the execution stops here and propagates none up.
	item := find_item(id)? 
	return 'Found: ' + item
}

// ==========================================
// 2. Result Types (!T)
// Results represent either a value of type T or an IError.
// ==========================================

// divide performs float division but returns an error for division by zero.
fn divide(a f64, b f64) !f64 {
	if b == 0.0 {
		return error('division by zero') // Return a standard error
	}
	return a / b
}

// fetch_data returns a string or a CustomError.
fn fetch_data(success bool) !string {
	if !success {
		return CustomError{
			message: 'Connection timed out'
			code: 504
		}
	}
	return 'Raw database records'
}

// query_db returns a string or a DatabaseError.
fn query_db(query string, success bool) !string {
	if !success {
		return DatabaseError{
			query: query
		}
	}
	return 'Query success'
}

// calculate_and_format demonstrates Result propagation using the `!` operator.
fn calculate_and_format(a f64, b f64) !string {
	// The `!` suffix propagates the error to the caller if divide fails.
	res := divide(a, b)! 
	return 'Result is ${res:.2f}'
}

// ==========================================
// 3. Unrecoverable Errors (Panics)
// ==========================================
fn force_panic() {
	println('Simulating a critical failure...')
	panic('Fatal error: Out of memory or system crash.')
}

fn main() {
	println('=== 1. Option Types (?T) ===')
	
	// Option Handling: Option unwrapping using `or` block
	item_1 := find_item(42) or { 'Default Item' }
	println('Item 1 (with 42): ${item_1}')
	
	item_2 := find_item(99) or { 'Default Item' }
	println('Item 2 (with 99): ${item_2}')

	// Option Handling: Option unwrapping with variable binding using `if-let`
	if item := find_item(42) {
		println('If-let match: Found "${item}"')
	} else {
		println('If-let match: Item not found')
	}

	if item := find_item(99) {
		println('If-let match: Found "${item}"')
	} else {
		println('If-let match: Item not found (none)')
	}

	// Option Propagation Check
	wrapped_item := find_item_wrapper(99) or { 'None propagated successfully' }
	println('Propagation check: ${wrapped_item}\n')


	println('=== 2. Result Types (!T) ===')

	// Result Handling: Standard error message extraction via the `err` variable inside `or` block
	calc_success := calculate_and_format(10.0, 2.0) or { 'Error: ${err}' }
	println('Calc success: ${calc_success}')

	calc_fail := calculate_and_format(10.0, 0.0) or { 'Error: ${err}' }
	println('Calc failure: ${calc_fail}')


	println('\n=== 3. Custom Error Matching & Type Casting ===')

	// We can inspect the error type dynamically using the `is` check inside the `or` block.
	// Since fetch_data(false) returns a Result type (!string), the `or` block must either:
	// 1. Terminate control flow (e.g. using return, panic, exit)
	// 2. Evaluate to a fallback string value.
	// We use `''` (empty string) here as the fallback value to satisfy this type requirement.
	fetch_data(false) or {
		if err is CustomError {
			// Inside this block, `err` is smart-cast to CustomError automatically, 
			// allowing direct access to custom fields like `code`.
			println('Caught CustomError! Message: "${err.msg()}", Code: ${err.code}')
		} else {
			println('Caught generic error: ${err.msg()}')
		}
		'' // Fallback empty string returned to satisfy the !string return type of the or block
	}

	// Similarly, query_db returns !string, so its or block must also evaluate to a string.
	query_db('SELECT * FROM users', false) or {
		if err is DatabaseError {
			// Smart-cast to DatabaseError, accessing the `query` field
			println('Caught DatabaseError!')
			println('Query attempted: "${err.query}"')
			println('Error message:   "${err.msg()}"')
		} else {
			println('Caught generic error: ${err.msg()}')
		}
		'' // Fallback empty string returned to satisfy the !string return type of the or block
	}


	println('\n=== 4. Panic (Unrecoverable Error) ===')
	// We wrap panic execution or run it last since it terminates the process.
	// You can uncomment the line below to test panic termination:
	// force_panic()
	println('To run a panic, uncomment force_panic() in main.')
}
