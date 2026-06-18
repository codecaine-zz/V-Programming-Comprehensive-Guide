module main

import net.html

fn main() {
	println('=== net.html Module Demo ===')

	// 1. Define a sample HTML document to parse
	html_content := '
	<!DOCTYPE html>
	<html>
	<head>
		<title>V Programming Language</title>
	</head>
	<body>
		<header>
			<h1 class="main-title">Welcome to the V Standard Library</h1>
		</header>
		<main>
			<div class="content" id="overview">
				<p class="description">
					V is a simple, fast, safe, and compiled language.
				</p>
				<p class="description">
					The net.html module parses HTML into a Queryable Document Object Model (DOM).
				</p>
				<a href="https://vlang.io" class="link-btn" id="home-link">Official Website</a>
				<a href="https://github.com/vlang/v" class="link-btn" id="repo-link">GitHub Repository</a>
			</div>
		</main>
	</body>
	</html>'

	// 2. Parse the HTML string into a DocumentObjectModel (DOM)
	println('Parsing HTML document...')
	dom := html.parse(html_content)

	// 3. Retrieve tags by name (e.g., header, title)
	title_tags := dom.get_tags(name: 'title')
	if title_tags.len > 0 {
		println('Page Title: "${title_tags[0].text()}"')
	}

	// 4. Retrieve tags by class name
	descriptions := dom.get_tags_by_class_name('description')
	println('\nParagraphs with class "description":')
	for i, p in descriptions {
		println('  ${i + 1}: ${p.text().trim_space()}')
	}

	// 5. Query tags by attribute value (e.g., href, id)
	links := dom.get_tags_by_class_name('link-btn')
	println('\nLinks found in document:')
	for link in links {
		href := link.attributes['href']
		id := link.attributes['id']
		text := link.text()
		println('  - Text: "${text}"')
		println('    ID:   "${id}"')
		println('    URL:  "${href}"')
	}

	// 6. Access DOM root and verify serialization representation
	root := dom.get_root()
	println('\nDOM Root Element Tag Name: <${root.name}>')
	println('HTML Demo finished.')
}
