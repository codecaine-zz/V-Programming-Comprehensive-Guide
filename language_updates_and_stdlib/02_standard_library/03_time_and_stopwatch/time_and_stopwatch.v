module main

import time

fn main() {
	println('Time API examples')
	println('=================')

	// time.now() returns the current system time.
	// We can access properties like year, month, day, hour, etc.
	now := time.now()
	println('Current time: ${now}')
	println('Fields -> year=${now.year}, month=${now.month}, day=${now.day}, hour=${now.hour}, minute=${now.minute}, second=${now.second}, nanosecond=${now.nanosecond}, is_local=${now.is_local}')

	// ==========================================
	// Arithmetic and comparisons
	// ==========================================
	
	// now.add() adds a duration to the timestamp.
	// now.add_days() adds a specified number of days.
	// now.add_seconds() adds a specified number of seconds.
	// We can compare Time objects using <, >, ==, and subtract them to get a Duration.
	future := now.add(2 * time.hour)
	tomorrow := now.add_days(1)
	in_30_seconds := now.add_seconds(30)
	println('add: ${future}')
	println('add_days: ${tomorrow}')
	println('add_seconds: ${in_30_seconds}')
	println('comparison: now < future -> ${now < future}')
	println('comparison: now == now -> ${now == now}')
	println('difference: future - now -> ${future - now}')

	// ==========================================
	// Formatting helpers
	// ==========================================
	
	// now.clean() formats time as YYYY-MM-DD HH:MM:SS.
	// now.clean12() formats time using a 12-hour clock with AM/PM.
	// now.custom_format() formats time using a custom layout pattern.
	// now.format() and format_rfc3339() print standard ISO/RFC timestamps.
	// format_ss methods print time down to micro, milli, or nanoseconds.
	// strftime() uses C-like format specifiers.
	println('clean: ${now.clean()}')
	println('clean12: ${now.clean12()}')
	println('custom_format: ${now.custom_format('YYYY-MM-DD HH:mm:ss')}')
	println('format: ${now.format()}')
	println('format_rfc3339: ${now.format_rfc3339()}')
	println('format_rfc3339_micro: ${now.format_rfc3339_micro()}')
	println('format_rfc3339_nano: ${now.format_rfc3339_nano()}')
	println('format_ss: ${now.format_ss()}')
	println('format_ss_micro: ${now.format_ss_micro()}')
	println('format_ss_milli: ${now.format_ss_milli()}')
	println('format_ss_nano: ${now.format_ss_nano()}')
	println('strftime: ${now.strftime('%Y-%m-%d %H:%M:%S')}')
	println('get_fmt_str: ${now.get_fmt_str(time.FormatDelimiter.hyphen, time.FormatTime.hhmm24, time.FormatDate.yyyymmdd)}')
	println('get_fmt_date_str: ${now.get_fmt_date_str(time.FormatDelimiter.hyphen, time.FormatDate.yyyymmdd)}')
	println('get_fmt_time_str: ${now.get_fmt_time_str(time.FormatTime.hhmm24)}')

	// ==========================================
	// Date and time helpers
	// ==========================================
	
	// Extra details like day_of_week(), days_from_unix_epoch(), week_of_year(), smonth(), etc.
	println('day_of_week: ${now.day_of_week()}')
	println('days_from_unix_epoch: ${now.days_from_unix_epoch()}')
	println('ddmmy: ${now.ddmmy()}')
	println('hhmm: ${now.hhmm()}')
	println('hhmm12: ${now.hhmm12()}')
	println('hhmmss: ${now.hhmmss()}')
	println('long_weekday_str: ${now.long_weekday_str()}')
	println('md: ${now.md()}')
	println('smonth: ${now.smonth()}')
	println('weekday_str: ${now.weekday_str()}')
	println('week_of_year: ${now.week_of_year()}')
	println('year_day: ${now.year_day()}')
	println('ymmdd: ${now.ymmdd()}')

	// ==========================================
	// UTC and local conversions
	// ==========================================
	
	// Convert between UTC and the system local timezone.
	// unix(), unix_milli(), etc. return timestamps since the Unix Epoch.
	println('is_utc: ${now.is_utc()}')
	println('as_local: ${now.as_local()}')
	println('as_utc: ${now.as_utc()}')
	println('local: ${now.local()}')
	println('local_to_utc: ${now.local_to_utc()}')
	println('utc_to_local: ${now.utc_to_local()}')
	println('local_unix: ${now.local_unix()}')
	println('unix: ${now.unix()}')
	println('unix_micro: ${now.unix_micro()}')
	println('unix_milli: ${now.unix_milli()}')
	println('unix_nano: ${now.unix_nano()}')
	println('utc_string: ${now.utc_string()}')

	// ==========================================
	// Relative and serialization helpers
	// ==========================================
	
	// relative() and relative_short() return values like "2 hours ago".
	// to_json() returns the JSON representation of the time.
	// push_to_http_header() format HTTP-standard cookie/caching header dates.
	println('relative: ${now.relative()}')
	println('relative_short: ${now.relative_short()}')
	println('debug: ${now.debug()}')
	println('str: ${now.str()}')
	println('to_json: ${now.to_json()}')

	mut header_buffer := []u8{}
	now.push_to_http_header(mut header_buffer)
	println('http_header_string: ${now.http_header_string()}')
	println('push_to_http_header: ${header_buffer.bytestr()}')

	// ==========================================
	// JSON parsing helpers
	// ==========================================
	
	// Parse Unix timestamps or ISO/RFC 3339 strings directly back into a Time struct.
	mut parsed_from_number := time.now()
	parsed_from_number.from_json_number('1712345678') or {
		println('from_json_number error: ${err}')
	}
	println('from_json_number: ${parsed_from_number}')

	mut parsed_from_string := time.now()
	parsed_from_string.from_json_string('2024-04-06T12:34:56Z') or {
		println('from_json_string error: ${err}')
	}
	println('from_json_string: ${parsed_from_string}')

	// ==========================================
	// Stopwatch example
	// ==========================================
	
	// new_stopwatch starts a new stopwatch to measure high-precision elapsed code execution time.
	println('Starting stopwatch...')
	mut sw := time.new_stopwatch()
	time.sleep(150 * time.millisecond)
	println('Elapsed: ${sw.elapsed().milliseconds()} ms')
}