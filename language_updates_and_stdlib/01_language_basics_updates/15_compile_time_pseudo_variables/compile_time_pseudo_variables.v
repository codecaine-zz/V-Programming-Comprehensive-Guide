module main

struct User {
	name string
}

fn (u User) register() {
	println('Executing method: ' + @METHOD) // User.register
	println('Defined in struct: ' + @STRUCT) // User
}

fn log_event() {
	println('Logging from function: ' + @FN) // log_event
}

fn main() {
	println('=== V Compile-Time Pseudo Variables ===')
	
	// Module & File Info
	println('Current Module: ' + @MOD)
	println('Source File Path: ' + @FILE)
	println('Source Directory: ' + @DIR)
	println('Line Number: ' + @LINE.str())
	println('Relative File/Line: ' + @FILE_LINE)
	println('Log Location: ' + @LOCATION)
	println('Column Number: ' + @COLUMN.str())
	
	// Compiler Info
	println('V Compiler Executable: ' + @VEXE)
	println('V compiler Root Directory: ' + @VEXEROOT)
	println('V Compiler Commit Hash: ' + @VHASH)
	println('V Compiler Current Hash: ' + @VCURRENTHASH)
	
	// project Info (from v.mod)
	println('v.mod File Contents: ' + @VMOD_FILE)
	println('v.mod Git Commit Hash: ' + @VMODHASH)
	println('v.mod Root Directory: ' + @VMODROOT)
	
	// Build Info (UTC timezone)
	println('Build Date: ' + @BUILD_DATE)
	println('Build Time: ' + @BUILD_TIME)
	println('Build Timestamp: ' + @BUILD_TIMESTAMP)
	
	// Platform / Backend Info
	println('Target OS: ' + @OS)
	println('C Compiler: ' + @CCOMPILER)
	println('V Backend: ' + @BACKEND)
	println('CPU Platform: ' + @PLATFORM)
	
	u := User{name: 'Alice'}
	u.register()
	log_event()
}
