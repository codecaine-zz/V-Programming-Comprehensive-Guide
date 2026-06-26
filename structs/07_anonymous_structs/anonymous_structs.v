module main

struct Book {
	author struct {
		name string
		age  int
	}
	title string
}

fn main() {
	book := Book{
		title: 'The V Programming Language'
		author: struct {
			name: 'Samantha Black'
			age:  24
		}
	}
	println('Book: ${book.title} by ${book.author.name} (${book.author.age})')
}
