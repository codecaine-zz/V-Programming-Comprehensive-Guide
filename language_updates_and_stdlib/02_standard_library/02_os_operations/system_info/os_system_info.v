module main

import os

fn main() {
	println('=== V OS System & File Information (POSIX/Nix) ===')

	// --- 1. System Info (uname, hostname, loginname) ---
	println('\n--- 1. System Diagnostics ---')

	// os.uname() returns kernel details, release, OS name, and architecture
	u := os.uname()
	println('Operating System:     ${u.sysname}')
	println('Node Name (Network):  ${u.nodename}')
	println('Kernel Release:       ${u.release}')
	println('Kernel Version:       ${u.version}')
	println('Machine Architecture: ${u.machine}')

	// Retrieve hostname and login user name
	host := os.hostname() or { 'unknown_host' }
	user := os.loginname() or { 'unknown_user' }
	println('Hostname:             ${host}')
	println('Login Name:           ${user}')

	// --- 2. Identity and Process Metrics ---
	println('\n--- 2. User/Group IDs & Process Context ---')

	// Real and effective UID/GIDs
	println('User ID (UID):        ${os.getuid()}')
	println('Group ID (GID):       ${os.getgid()}')
	println('Effective UID (EUID): ${os.geteuid()}')
	println('Effective GID (EGID): ${os.getegid()}')

	// Current Process ID and Parent Process ID
	println('Process ID (PID):     ${os.getpid()}')
	println('Parent PID (PPID):    ${os.getppid()}')

	// --- 3. Disk Space Usage ---
	println('\n--- 3. Disk Space Stats ---')

	// Query disk space information for the current directory
	du := os.disk_usage('.') or {
		println('Failed to retrieve disk usage: ${err}')
		return
	}

	// Convert u64 bytes to Gigabytes for user readability
	total_gb := f64(du.total) / (1024.0 * 1024.0 * 1024.0)
	avail_gb := f64(du.available) / (1024.0 * 1024.0 * 1024.0)
	used_gb := f64(du.used) / (1024.0 * 1024.0 * 1024.0)

	println('Disk Total:     ${total_gb:.2f} GB')
	println('Disk Available: ${avail_gb:.2f} GB')
	println('Disk Used:      ${used_gb:.2f} GB')

	// --- 4. Detailed File Metadata (stat/lstat) ---
	println('\n--- 4. File Metadata via stat ---')

	// Let's create a temporary file to run stat on
	temp_file := 'temp_stat_test.txt'
	os.write_file(temp_file, 'V stat demo content.') or { return }

	// Fetch file stats
	st := os.stat(temp_file) or {
		println('Failed to stat file: ${err}')
		os.rm(temp_file) or {}
		return
	}

	println('File Size:          ${st.size} bytes')
	println('Inode Number:       ${st.inode}')
	println('Hard Links Count:   ${st.nlink}')
	println('Device ID:          ${st.dev}')
	println('Owner UID:          ${st.uid}')
	println('Owner GID:          ${st.gid}')

	// Access access, modify, and status change timestamps
	println('Last Access Time:   ${st.atime} (Unix Epoch)')
	println('Last Modify Time:   ${st.mtime} (Unix Epoch)')
	println('Last Change Time:   ${st.ctime} (Unix Epoch)')

	// File type and permissions from Stat
	file_type := st.get_filetype()
	file_mode := st.get_mode()
	println('File Type:          ${file_type}') // e.g., regular, directory, link, etc.
	println('File Mode Bitmask:  0o${file_mode.bitmask():o}') // octal representation

	// Permissions breakdown
	println('Permissions -> Owner: R=${file_mode.owner.read} W=${file_mode.owner.write} X=${file_mode.owner.execute}')
	println('               Group: R=${file_mode.group.read} W=${file_mode.group.write} X=${file_mode.group.execute}')
	println('               Other: R=${file_mode.others.read} W=${file_mode.others.write} X=${file_mode.others.execute}')

	// Cleanup
	os.rm(temp_file) or {}
}
