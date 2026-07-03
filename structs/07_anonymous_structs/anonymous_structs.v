module main

import json

struct Book {
	title string
mut:
	author struct {
		name string
	mut:
		age int
	}
}

fn main() {
	mut book := Book{
		title:  'The V Programming Language'
		author: struct {
			name: 'Samantha Black'
			age:  24
		}
	}
	book.author.age = 25
	println('${book.title} by ${book.author.name} (${book.author.age})')
	println(json.encode(book))
}
