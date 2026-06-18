module main

import wasm
import os

fn main() {
	println('=== V WebAssembly (wasm) Module Demo ===')

	// Initialize the WebAssembly module
	mut m := wasm.Module{}
	m.enable_debug('vlang_wasm_demo')

	// --- 1. Basic Arithmetic Functions ---
	println('\n1. Generating Arithmetic Functions (add, sub, mul)...')
	
	// Exported 'add' function: taking two i32 parameters, returning one i32 result
	mut add_fn := m.new_function('add', [.i32_t, .i32_t], [.i32_t])
	{
		add_fn.local_get(0)
		add_fn.local_get(1)
		add_fn.add(.i32_t)
	}
	m.commit(add_fn, true) // commit with export = true

	// Exported 'sub' function
	mut sub_fn := m.new_function('sub', [.i32_t, .i32_t], [.i32_t])
	{
		sub_fn.local_get(0)
		sub_fn.local_get(1)
		sub_fn.sub(.i32_t)
	}
	m.commit(sub_fn, true)

	// Exported 'mul' function
	mut mul_fn := m.new_function('mul', [.i32_t, .i32_t], [.i32_t])
	{
		mul_fn.local_get(0)
		mul_fn.local_get(1)
		mul_fn.mul(.i32_t)
	}
	m.commit(mul_fn, true)


	// --- 2. Global Variables ---
	println('\n2. Creating Global Variables...')
	// Global variable named '__vsp' (Stack Pointer), internal/non-exported, type i32, mutable, init value 10
	vsp := m.new_global('__vsp', false, .i32_t, true, wasm.constexpr_value(10))
	
	// Create a function that retrieves the global value, adds 20, stores it back, and returns the new value
	mut vsp_fn := m.new_function('update_vsp', [], [.i32_t])
	{
		vsp_fn.global_get(vsp)
		vsp_fn.i32_const(20)
		vsp_fn.add(.i32_t)
		vsp_fn.global_set(vsp)
		vsp_fn.global_get(vsp)
	}
	m.commit(vsp_fn, true)


	// --- 3. Recursive Functions (Factorial) ---
	println('\n3. Generating Recursive Function (fac)...')
	// fac(n) returns n! using i64 types
	mut fac_fn := m.new_function('fac', [.i64_t], [.i64_t])
	{
		fac_fn.local_get(0)
		fac_fn.eqz(.i64_t)
		
		// If block: if n == 0, return 1
		ifs := fac_fn.c_if([], [.i64_t])
		{
			fac_fn.i64_const(1)
		}
		fac_fn.c_else(ifs)
		{
			// Else: return n * fac(n - 1)
			fac_fn.local_get(0) // push n
			
			fac_fn.local_get(0)
			fac_fn.i64_const(1)
			fac_fn.sub(.i64_t)   // n - 1
			fac_fn.call('fac')   // recursive call to fac(n - 1)
			
			fac_fn.mul(.i64_t)   // n * fac(n - 1)
		}
		fac_fn.c_end(ifs)
	}
	m.commit(fac_fn, true)


	// --- 4. Compilation & Output ---
	println('\n4. Compiling Module to WebAssembly Binary...')
	binary_code := m.compile()
	println('Compilation Successful! Binary size: ${binary_code.len} bytes')

	// Save compiled binary as output.wasm in the current directory
	dir := os.dir(@FILE)
	output_path := os.join_path(dir, 'output.wasm')
	os.write_file(output_path, binary_code.bytestr()) or {
		println('Failed to write output.wasm: ${err}')
		return
	}
	println('Saved Wasm binary to: ${output_path}')
}
