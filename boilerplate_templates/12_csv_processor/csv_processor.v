module main

import os
import encoding.csv

struct Person {
	name string
	age  int
	city string
}

fn read_people(path string) ![]Person {
	content := os.read_file(path) or { return error('Could not read ${path}: ${err}') }
	mut reader := csv.new_reader(content)

	mut people := []Person{}
	for {
		row := reader.read() or { break }
		if row.len == 0 {
			continue
		}
		if row[0] == 'name' {
			continue
		}
		people << Person{
			name: row[0]
			age: row[1].int()
			city: row[2]
		}
	}
	return people
}

fn write_people(path string, people []Person) ! {
	mut output := []string{}
	output << 'name,age,city'
	for person in people {
		output << '${person.name},${person.age},${person.city}'
	}
	os.write_file(path, output.join('\n')) or { return error('Could not write ${path}: ${err}') }
}

fn main() {
	println('=== V CSV Processor Boilerplate ===')

	input_path := 'people.csv'
	output_path := 'people_out.csv'

	// Ensure temporary CSV files are cleaned up on exit
	defer {
		if os.exists(input_path) {
			os.rm(input_path) or {}
		}
		if os.exists(output_path) {
			os.rm(output_path) or {}
		}
		println('Cleaned up temporary CSV files.')
	}

	os.write_file(input_path, 'name,age,city\nAlice,30,New York\nBob,25,San Francisco') or {
		eprintln('Could not create sample CSV: ${err}')
		return
	}

	people := read_people(input_path) or {
		eprintln('${err}')
		return
	}

	for person in people {
		println('Loaded: ${person.name} (${person.age}) from ${person.city}')
	}

	write_people(output_path, people) or {
		eprintln('${err}')
		return
	}
	println('Wrote processed CSV to ${output_path}')
}
