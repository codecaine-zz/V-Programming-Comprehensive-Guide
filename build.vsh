#!/usr/bin/env v

import os
import strings
import regex
import json2

// Structs for search index and structure JSON
struct Lesson {
	id string
mut:
	title string
}

struct Section {
	id    string
	title string
mut:
	lessons []Lesson
}

struct Chapter {
	id     string
	number string
	title  string
mut:
	sections []Section
}

struct SearchIndexEntry {
	id      string
	title   string
	typ     string @[json: 'type']
mut:
	content string
	chapter string
	section string
}

// Global/Helper functions

fn escape_html(text string) string {
	return text
		.replace('&', '&amp;')
		.replace('<', '&lt;')
		.replace('>', '&gt;')
		.replace('"', '&quot;')
		.replace("'", '&#039;')
}

fn get_github_url(raw_path string) string {
	has_extension := raw_path.contains('.')
	prefix := if has_extension { 'blob' } else { 'tree' }

	if raw_path.starts_with('boilerplate_templates/13_simplegui') {
		mut sub_path := raw_path['boilerplate_templates/13_simplegui'.len..]
		if sub_path.starts_with('/') {
			sub_path = sub_path[1..]
		}
		if sub_path == '' {
			return 'https://github.com/codecaine-zz/vlang_simplegui'
		}
		return 'https://github.com/codecaine-zz/vlang_simplegui/${prefix}/master/${sub_path}'
	}

	return 'https://github.com/codecaine-zz/V-Programming-Comprehensive-Guide/${prefix}/master/${raw_path}'
}

fn slugify(text string) string {
	lower := text.to_lower()
	mut filtered := strings.new_builder(lower.len)
	for i in 0 .. lower.len {
		c := lower[i]
		if (c >= `a` && c <= `z`) || (c >= `0` && c <= `9`) || c == `_` || c == ` ` || c == `-` {
			filtered.write_u8(c)
		}
	}

	replaced := filtered.str().replace(' ', '-')

	mut start := 0
	for start < replaced.len && replaced[start] == `-` {
		start++
	}
	mut end := replaced.len
	for end > start && replaced[end - 1] == `-` {
		end--
	}

	return replaced[start..end]
}

fn normalize_code_language(language string) string {
	normalized := language.to_lower().trim_space()
	if normalized == '' {
		return 'text'
	}
	if normalized == 'vlang' {
		return 'v'
	}
	return normalized
}

fn generate_code_block_html(code_language string, code_str string) string {
	code_html := escape_html(code_str)
	mut playground_btn := ''
	lang_lower := code_language.to_lower().trim_space()
	if lang_lower == 'v' || lang_lower == 'vlang' {
		playground_btn = '<button type="button" class="btn-playground" onclick="runInPlayground(this)" title="Run in V Playground"><svg class="icon" width="14" height="14"><use href="#i-play"></use></svg> Run</button><button type="button" class="btn-playground-copy" onclick="copyAndOpenPlayground(this)" title="Copy Code &amp; Open V Playground"><svg class="icon" width="14" height="14"><use href="#i-external"></use></svg> Copy &amp; Open</button>'
	}

	normalized_language := normalize_code_language(code_language)
	display_lang := if code_language.trim_space() == '' { 'text' } else { code_language.trim_space() }
	return '<div class="code-wrapper"><div class="code-header"><span class="code-lang">${escape_html(display_lang)}</span><div class="code-actions">${playground_btn}<button type="button" class="btn-zoom" onclick="toggleCodeZoom(this)" title="Zoom Code" aria-label="Zoom code block"><svg class="icon" width="14" height="14"><use href="#i-zoom"></use></svg> Zoom</button><button type="button" class="btn-copy" onclick="copyCode(this)" title="Copy Code" aria-label="Copy code block"><svg class="icon copy-icon" width="14" height="14"><use href="#i-copy"></use></svg> Copy</button></div></div><pre><code class="language-${normalized_language}">${code_html}</code></pre></div>\n'
}

struct LinkInfo {
	link_text   string
	href        string
	target_attr string
}

fn parse_inline(text string) string {
	mut result := escape_html(text)

	// 1. Extract inline code blocks `code`
	mut code_blocks := []string{}
	mut re_code := regex.regex_opt(r'`([^`]+)`') or { panic(err) }
	for {
		start, end := re_code.find(result)
		if start < 0 {
			break
		}
		code := re_code.get_group_by_id(result, 0)
		placeholder := 'CODEPLACEHOLDER${code_blocks.len}XYZ'
		code_blocks << code
		result = result[..start] + placeholder + result[end..]
	}

	// 2. Extract Markdown links [text](url)
	mut links := []LinkInfo{}
	mut re_link := regex.regex_opt(r'\[([^\]]+)\]\(([^)]+)\)') or { panic(err) }
	for {
		start, end := re_link.find(result)
		if start < 0 {
			break
		}
		link_text := re_link.get_group_by_id(result, 0)
		url := re_link.get_group_by_id(result, 1)

		is_external := url.starts_with('http://') || url.starts_with('https://')
		is_anchor := url.starts_with('#')
		mut href := url
		mut target_attr := ''
		if !is_external && !is_anchor {
			href = get_github_url(url)
			target_attr = ' target="_blank" rel="noopener noreferrer"'
		} else if is_external {
			target_attr = ' target="_blank" rel="noopener noreferrer"'
		}

		placeholder := 'LINKPLACEHOLDER${links.len}XYZ'
		links << LinkInfo{
			link_text:   link_text
			href:        href
			target_attr: target_attr
		}
		result = result[..start] + placeholder + result[end..]
	}

	// 3. Apply standard formatting
	// Bold: **text**
	mut re_bold1 := regex.regex_opt(r'\*\*([^\*]+)\*\*') or { panic(err) }
	for {
		start, end := re_bold1.find(result)
		if start < 0 {
			break
		}
		val := re_bold1.get_group_by_id(result, 0)
		result = result[..start] + '<strong>' + val + '</strong>' + result[end..]
	}

	// Bold: __text__
	mut re_bold2 := regex.regex_opt(r'__([^_]+)__') or { panic(err) }
	for {
		start, end := re_bold2.find(result)
		if start < 0 {
			break
		}
		val := re_bold2.get_group_by_id(result, 0)
		result = result[..start] + '<strong>' + val + '</strong>' + result[end..]
	}

	// Italics: *text*
	mut re_ital1 := regex.regex_opt(r'\*([^\*]+)\*') or { panic(err) }
	for {
		start, end := re_ital1.find(result)
		if start < 0 {
			break
		}
		val := re_ital1.get_group_by_id(result, 0)
		result = result[..start] + '<em>' + val + '</em>' + result[end..]
	}

	// Italics: _text_
	mut re_ital2 := regex.regex_opt(r'_([^_]+)_') or { panic(err) }
	for {
		start, end := re_ital2.find(result)
		if start < 0 {
			break
		}
		val := re_ital2.get_group_by_id(result, 0)
		result = result[..start] + '<em>' + val + '</em>' + result[end..]
	}

	// 4. Restore links
	mut re_restore_link := regex.regex_opt(r'LINKPLACEHOLDER(\d+)XYZ') or { panic(err) }
	for {
		start, end := re_restore_link.find(result)
		if start < 0 {
			break
		}
		index_str := re_restore_link.get_group_by_id(result, 0)
		idx := index_str.int()
		if idx < links.len {
			link_info := links[idx]
			formatted := '<a href="${link_info.href}"${link_info.target_attr}>${parse_inline_simple(link_info.link_text)}</a>'
			result = result[..start] + formatted + result[end..]
		} else {
			break
		}
	}

	// 5. Restore inline code blocks
	mut re_restore_code := regex.regex_opt(r'CODEPLACEHOLDER(\d+)XYZ') or { panic(err) }
	for {
		start, end := re_restore_code.find(result)
		if start < 0 {
			break
		}
		index_str := re_restore_code.get_group_by_id(result, 0)
		idx := index_str.int()
		if idx < code_blocks.len {
			code_val := code_blocks[idx]
			formatted := '<code>${code_val}</code>'
			result = result[..start] + formatted + result[end..]
		} else {
			break
		}
	}

	return result
}

fn parse_inline_simple(text string) string {
	mut result := text
	mut re_bold := regex.regex_opt(r'\*\*([^\*]+)\*\*') or { panic(err) }
	for {
		start, end := re_bold.find(result)
		if start < 0 {
			break
		}
		val := re_bold.get_group_by_id(result, 0)
		result = result[..start] + '<strong>' + val + '</strong>' + result[end..]
	}
	return result
}

fn is_table_row(trimmed string) bool {
	return trimmed.starts_with('|') && trimmed.ends_with('|') && trimmed.len > 2
}

fn is_table_divider(trimmed string) bool {
	if !is_table_row(trimmed) {
		return false
	}
	inner := trimmed[1..trimmed.len - 1].trim_space()
	if inner == '' {
		return false
	}
	for i in 0 .. inner.len {
		c := inner[i]
		if c != `-` && c != `:` && c != `|` && c != ` ` {
			return false
		}
	}
	return inner.contains('-')
}

fn split_table_cells(row string) []string {
	inner := row[1..row.len - 1]
	parts := inner.split('|')
	mut cells := []string{cap: parts.len}
	for part in parts {
		cells << part.trim_space()
	}
	return cells
}

fn render_table_html(rows []string) string {
	if rows.len == 0 {
		return ''
	}
	mut sb := strings.new_builder(rows.len * 80)
	sb.write_string('<div class="table-wrap"><table class="doc-table">')

	mut body_start := 0
	if rows.len >= 2 && is_table_divider(rows[1].trim_space()) {
		header_cells := split_table_cells(rows[0].trim_space())
		sb.write_string('<thead><tr>')
		for cell in header_cells {
			sb.write_string('<th>${parse_inline(cell)}</th>')
		}
		sb.write_string('</tr></thead>')
		body_start = 2
	}

	sb.write_string('<tbody>')
	for i in body_start .. rows.len {
		r := rows[i].trim_space()
		if is_table_divider(r) {
			continue
		}
		cells := split_table_cells(r)
		sb.write_string('<tr>')
		for cell in cells {
			sb.write_string('<td>${parse_inline(cell)}</td>')
		}
		sb.write_string('</tr>')
	}
	sb.write_string('</tbody></table></div>\n')
	return sb.str()
}

struct Parser {
mut:
	html            strings.Builder
	curr_chap_idx   int = -1
	curr_sec_idx    int = -1
	curr_less_idx   int = -1
	curr_search_idx int = -1

	search_index []SearchIndexEntry
	structure    []Chapter
	used_slugs   map[string]int

	in_code_block bool
	code_language string
	code_content  []string

	in_blockquote      bool
	alert_type         string
	blockquote_content []string

	in_list   bool
	list_type string

	in_table   bool
	table_rows []string

	in_quick_access   bool
	in_under_the_hood bool
}

fn (mut p Parser) unique_slug(base_slug string) string {
	slug := if base_slug == '' { 'section' } else { base_slug }
	count := p.used_slugs[slug]
	p.used_slugs[slug] = count + 1
	if count == 0 {
		return slug
	}
	return '${slug}-${count + 1}'
}

fn (mut p Parser) append_search_text(text string) {
	if p.curr_search_idx < 0 || p.curr_search_idx >= p.search_index.len {
		return
	}
	if p.search_index[p.curr_search_idx].content.len > 650 {
		return
	}
	clean := text.replace('`', '').replace('*', '').replace('#', '').trim_space()
	if clean != '' {
		p.search_index[p.curr_search_idx].content += ' ' + clean
	}
}

fn (mut p Parser) flush_list() {
	if p.in_list {
		p.html.write_string('</${p.list_type}>\n')
		p.in_list = false
	}
}

fn (mut p Parser) flush_table() {
	if p.in_table {
		p.html.write_string(render_table_html(p.table_rows))
		p.in_table = false
		p.table_rows.clear()
	}
}

fn (mut p Parser) close_collapsible_sections() {
	if p.in_quick_access {
		p.flush_list()
		p.flush_table()
		p.flush_blockquote()
		p.html.write_string('</div></details>\n')
		p.in_quick_access = false
	}
	if p.in_under_the_hood {
		p.flush_list()
		p.flush_table()
		p.flush_blockquote()
		p.html.write_string('</div></details>\n')
		p.in_under_the_hood = false
	}
}

fn (mut p Parser) flush_blockquote() {
	if p.in_blockquote {
		mut parsed_content := strings.new_builder(256)
		mut block_code_content := []string{}
		mut in_block_code := false
		mut block_code_language := ''
		mut block_table_rows := []string{}
		mut in_block_list := false
		mut block_list_type := ''

		mut re_ul := regex.regex_opt(r'^\s*-\s+(.*)') or { panic(err) }
		mut re_ol := regex.regex_opt(r'^\s*\d+\.\s+(.*)') or { panic(err) }

		for b_line in p.blockquote_content {
			trimmed_b_line := b_line.trim_space()

			if trimmed_b_line.starts_with('```') {
				if in_block_list {
					parsed_content.write_string('</${block_list_type}>\n')
					in_block_list = false
				}
				if block_table_rows.len > 0 {
					parsed_content.write_string(render_table_html(block_table_rows))
					block_table_rows.clear()
				}
				if in_block_code {
					code_str := block_code_content.join('\n')
					parsed_content.write_string(generate_code_block_html(block_code_language,
						code_str))
					in_block_code = false
					block_code_content.clear()
				} else {
					in_block_code = true
					block_code_language = trimmed_b_line[3..].trim_space()
				}
				continue
			}

			if in_block_code {
				block_code_content << b_line
				continue
			}

			if is_table_row(trimmed_b_line) {
				if in_block_list {
					parsed_content.write_string('</${block_list_type}>\n')
					in_block_list = false
				}
				block_table_rows << trimmed_b_line
				p.append_search_text(trimmed_b_line)
				continue
			} else if block_table_rows.len > 0 {
				parsed_content.write_string(render_table_html(block_table_rows))
				block_table_rows.clear()
			}

			s_ul, _ := re_ul.find(trimmed_b_line)
			s_ol, _ := re_ol.find(trimmed_b_line)
			if s_ul == 0 {
				item_text := re_ul.get_group_by_id(trimmed_b_line, 0)
				if !in_block_list || block_list_type != 'ul' {
					if in_block_list {
						parsed_content.write_string('</${block_list_type}>\n')
					}
					parsed_content.write_string('<ul>\n')
					in_block_list = true
					block_list_type = 'ul'
				}
				parsed_content.write_string('<li>${parse_inline(item_text)}</li>\n')
				p.append_search_text(item_text)
				continue
			} else if s_ol == 0 {
				item_text := re_ol.get_group_by_id(trimmed_b_line, 0)
				if !in_block_list || block_list_type != 'ol' {
					if in_block_list {
						parsed_content.write_string('</${block_list_type}>\n')
					}
					parsed_content.write_string('<ol>\n')
					in_block_list = true
					block_list_type = 'ol'
				}
				parsed_content.write_string('<li>${parse_inline(item_text)}</li>\n')
				p.append_search_text(item_text)
				continue
			} else if in_block_list {
				parsed_content.write_string('</${block_list_type}>\n')
				in_block_list = false
			}

			if trimmed_b_line != '' {
				parsed_content.write_string('<p>${parse_inline(b_line)}</p>\n')
				p.append_search_text(b_line)
			}
		}

		if in_block_list {
			parsed_content.write_string('</${block_list_type}>\n')
		}
		if block_table_rows.len > 0 {
			parsed_content.write_string(render_table_html(block_table_rows))
			block_table_rows.clear()
		}
		if in_block_code && block_code_content.len > 0 {
			code_str := block_code_content.join('\n')
			parsed_content.write_string(generate_code_block_html(block_code_language,
				code_str))
		}

		body_html := parsed_content.str()
		if p.alert_type == 'solution' || p.alert_type == 'output' {
			label := if p.alert_type == 'solution' {
				'SOLUTION (Click to Reveal / Hide)'
			} else {
				'EXPECTED OUTPUT (Click to Reveal / Hide)'
			}
			p.html.write_string('<details class="alert alert-${p.alert_type} solution-details"><summary class="alert-title"><svg class="alert-icon" viewBox="0 0 16 16" width="16" height="16"><use href="#i-alert-${p.alert_type}"></use></svg><span>${label}</span></summary><div class="alert-content">${body_html}</div></details>\n')
		} else if p.alert_type != '' {
			p.html.write_string('<div class="alert alert-${p.alert_type}"><div class="alert-title"><svg class="alert-icon" viewBox="0 0 16 16" width="16" height="16"><use href="#i-alert-${p.alert_type}"></use></svg><span>${p.alert_type.to_upper()}</span></div><div class="alert-content">${body_html}</div></div>\n')
		} else {
			p.html.write_string('<blockquote>${body_html}</blockquote>\n')
		}

		p.in_blockquote = false
		p.alert_type = ''
		p.blockquote_content.clear()
	}
}

fn parse_markdown_to_html_and_index(md string) (string, []Chapter, []SearchIndexEntry) {
	lines := md.split_into_lines()
	mut p := Parser{
		html:       strings.new_builder(md.len)
		used_slugs: map[string]int{}
	}

	mut re_ul := regex.regex_opt(r'^\s*-\s+(.*)') or { panic(err) }
	mut re_ol := regex.regex_opt(r'^\s*\d+\.\s+(.*)') or { panic(err) }
	mut re_h := regex.regex_opt(r'^(#{1,6})\s+(.*)') or { panic(err) }

	for line in lines {
		trimmed := line.trim_space()

		// Code blocks
		if trimmed.starts_with('```') {
			p.flush_list()
			p.flush_table()
			p.flush_blockquote()
			if p.in_code_block {
				code_str := p.code_content.join('\n')
				p.html.write_string(generate_code_block_html(p.code_language, code_str))
				if p.code_content.len > 0 {
					preview_lines := if p.code_content.len > 6 {
						p.code_content[..6].join(' ')
					} else {
						p.code_content.join(' ')
					}
					p.append_search_text(preview_lines)
				}
				p.in_code_block = false
				p.code_content.clear()
			} else {
				p.in_code_block = true
				p.code_language = trimmed[3..].trim_space()
			}
			continue
		}

		if p.in_code_block {
			p.code_content << line
			continue
		}

		// Blockquotes & GitHub Alerts
		if trimmed.starts_with('>') {
			p.flush_list()
			p.flush_table()
			p.in_blockquote = true
			mut clean_line := trimmed[1..].trim_space()

			if clean_line.starts_with('[!NOTE]') {
				p.alert_type = 'note'
				clean_line = clean_line[7..].trim_space()
			} else if clean_line.starts_with('[!TIP]') {
				p.alert_type = 'tip'
				clean_line = clean_line[6..].trim_space()
			} else if clean_line.starts_with('[!IMPORTANT]') {
				p.alert_type = 'important'
				clean_line = clean_line[12..].trim_space()
			} else if clean_line.starts_with('[!WARNING]') {
				p.alert_type = 'warning'
				clean_line = clean_line[10..].trim_space()
			} else if clean_line.starts_with('[!CAUTION]') {
				p.alert_type = 'caution'
				clean_line = clean_line[10..].trim_space()
			} else if clean_line.starts_with('[!EXERCISE]') {
				p.alert_type = 'exercise'
				clean_line = clean_line[11..].trim_space()
			} else if clean_line.starts_with('[!SOLUTION]') {
				p.alert_type = 'solution'
				clean_line = clean_line[11..].trim_space()
			} else if clean_line.starts_with('[!OUTPUT]') {
				p.alert_type = 'output'
				clean_line = clean_line[9..].trim_space()
			}

			if clean_line != '' {
				p.blockquote_content << clean_line
			}
			continue
		} else if p.in_blockquote {
			p.flush_blockquote()
		}

		// Markdown Tables
		if is_table_row(trimmed) {
			p.flush_list()
			p.in_table = true
			p.table_rows << trimmed
			p.append_search_text(trimmed)
			continue
		} else if p.in_table {
			p.flush_table()
		}

		// Lists
		s_ul, _ := re_ul.find(line)
		s_ol, _ := re_ol.find(line)

		if s_ul == 0 {
			content := re_ul.get_group_by_id(line, 0)
			if !p.in_list || p.list_type != 'ul' {
				p.flush_list()
				p.html.write_string('<ul>\n')
				p.in_list = true
				p.list_type = 'ul'
			}
			p.html.write_string('<li>${parse_inline(content)}</li>\n')
			p.append_search_text(content)
			continue
		} else if s_ol == 0 {
			content := re_ol.get_group_by_id(line, 0)
			if !p.in_list || p.list_type != 'ol' {
				p.flush_list()
				p.html.write_string('<ol>\n')
				p.in_list = true
				p.list_type = 'ol'
			}
			p.html.write_string('<li>${parse_inline(content)}</li>\n')
			p.append_search_text(content)
			continue
		} else {
			p.flush_list()
		}

		if trimmed == '' {
			continue
		}

		if trimmed == '---' {
			if p.in_quick_access {
				p.flush_list()
				p.flush_table()
				p.flush_blockquote()
				p.html.write_string('</div></details>\n')
				p.in_quick_access = false
			}
			p.html.write_string('<hr />\n')
			continue
		}

		// Headings
		s_h, _ := re_h.find(line)
		if s_h == 0 {
			h := re_h.get_group_by_id(line, 0)
			title := re_h.get_group_by_id(line, 1).trim_space()
			base_slug := slugify(title)
			level := h.len

			if level <= 2 {
				p.close_collapsible_sections()
			}

			if level == 1 {
				slug := p.unique_slug(base_slug)
				if title.starts_with('Chapter ') && title.contains(':') {
					mut chap_num := ''
					mut chap_name := title
					colon_idx := title.index(':') or { -1 }
					if colon_idx > 'Chapter '.len {
						chap_num = title['Chapter '.len..colon_idx].trim_space()
						chap_name = title[colon_idx + 1..].trim_space()
					}

					p.structure << Chapter{
						id:       slug
						number:   chap_num
						title:    chap_name
						sections: []
					}
					p.curr_chap_idx = p.structure.len - 1
					p.curr_sec_idx = -1
					p.curr_less_idx = -1

					p.html.write_string('</section>\n<section id="chap-wrapper-${slug}" class="chapter-section" data-chapter-id="${slug}">\n')
					p.html.write_string('<h1 class="chapter-title" id="${slug}" data-chapter-id="${slug}"><span class="chap-badge">Chapter ${chap_num}</span> ${escape_html(chap_name)}</h1>\n')

					p.search_index << SearchIndexEntry{
						id:      slug
						title:   'Chapter ${chap_num}: ${chap_name}'
						typ:     'chapter'
						content: title
						chapter: chap_name
					}
					p.curr_search_idx = p.search_index.len - 1
				} else {
					// Chapter 0: Start Here & Overview
					p.structure << Chapter{
						id:       slug
						number:   '0'
						title:    'Start Here & Quick Reference'
						sections: []
					}
					p.curr_chap_idx = p.structure.len - 1
					p.curr_sec_idx = -1
					p.curr_less_idx = -1

					p.html.write_string('<section id="chap-wrapper-${slug}" class="chapter-section intro-section" data-chapter-id="${slug}">\n')
					p.html.write_string('<h1 class="doc-main-title" id="${slug}" data-chapter-id="${slug}">${escape_html(title)}</h1>\n')
					p.search_index << SearchIndexEntry{
						id:      slug
						title:   title
						typ:     'chapter'
						content: title
						chapter: 'Start Here & Quick Reference'
					}
					p.curr_search_idx = p.search_index.len - 1
				}
			} else if level == 2 {
				if title == 'Code Examples Index' || title == 'Table of Contents' {
					slug := p.unique_slug(base_slug)
					p.html.write_string('<h2 class="section-title" id="${slug}">${escape_html(title)}</h2>\n')
					continue
				}

				if title == 'Quick Access' {
					slug := p.unique_slug(base_slug)
					p.html.write_string('<details class="quick-access-details" id="${slug}"><summary class="quick-access-summary"><svg class="icon" width="16" height="16"><use href="#i-compass"></use></svg><span>Quick Access — Jump to any lesson in this chapter</span></summary><div class="quick-access-body">\n')
					p.in_quick_access = true
					continue
				}

				slug := p.unique_slug(base_slug)
				mut current_chapter_title := ''
				if p.curr_chap_idx >= 0 {
					current_chapter_title = p.structure[p.curr_chap_idx].title

					p.structure[p.curr_chap_idx].sections << Section{
						id:      slug
						title:   title
						lessons: []
					}
					p.curr_sec_idx = p.structure[p.curr_chap_idx].sections.len - 1
					p.curr_less_idx = -1
				}

				chap_id := if p.curr_chap_idx >= 0 { p.structure[p.curr_chap_idx].id } else { '' }
				if title.starts_with('Under the Hood') {
					p.html.write_string('<details class="under-the-hood-details"><summary class="under-the-hood-summary"><h2 class="section-title" id="${slug}" data-chapter-id="${chap_id}">${escape_html(title)}</h2><span class="uth-badge">🔧 Optional Deep Dive — Click to Expand / Collapse</span></summary><div class="under-the-hood-body">\n')
					p.in_under_the_hood = true
				} else {
					p.html.write_string('<h2 class="section-title" id="${slug}" data-chapter-id="${chap_id}">${escape_html(title)}</h2>\n')
				}

				sec_type := if title.contains('Glossary') || title.contains('Dictionary') {
					'dictionary'
				} else {
					'section'
				}
				p.search_index << SearchIndexEntry{
					id:      slug
					title:   title
					typ:     sec_type
					content: title
					chapter: current_chapter_title
					section: title
				}
				p.curr_search_idx = p.search_index.len - 1
			} else if level == 3 {
				mut clean_title := title
				if title.starts_with('Lesson:') {
					clean_title = title[7..].trim_space()
				}
				slug := p.unique_slug(slugify(clean_title))

				mut current_chapter_title := ''
				mut current_chapter_num := ''
				mut current_section_title := ''
				if p.curr_chap_idx >= 0 {
					current_chapter_title = p.structure[p.curr_chap_idx].title
					current_chapter_num = p.structure[p.curr_chap_idx].number
					if p.curr_sec_idx >= 0 {
						current_section_title = p.structure[p.curr_chap_idx].sections[p.curr_sec_idx].title
					}
				}

				is_conceptual_sub := current_chapter_num == '0'
					|| current_section_title.starts_with('Under the Hood')
					|| current_section_title.starts_with('Deep Dive')
					|| current_section_title.starts_with('Featured Real-World')

				chap_id := if p.curr_chap_idx >= 0 { p.structure[p.curr_chap_idx].id } else { '' }

				if is_conceptual_sub {
					p.html.write_string('<h3 class="sub-heading" id="${slug}" data-chapter-id="${chap_id}">${escape_html(clean_title)}</h3>\n')
					sub_type := if current_section_title.contains('Glossary')
						|| current_section_title.contains('Dictionary') {
						'dictionary'
					} else {
						'section'
					}
					p.search_index << SearchIndexEntry{
						id:      slug
						title:   clean_title
						typ:     sub_type
						content: clean_title
						chapter: current_chapter_title
						section: current_section_title
					}
					p.curr_search_idx = p.search_index.len - 1
				} else {
					lesson := Lesson{
						id:    slug
						title: clean_title
					}
					if p.curr_chap_idx >= 0 && p.curr_sec_idx >= 0 {
						p.structure[p.curr_chap_idx].sections[p.curr_sec_idx].lessons << lesson
						p.curr_less_idx = p.structure[p.curr_chap_idx].sections[p.curr_sec_idx].lessons.len - 1
					}

					escaped_js_title := escape_html(clean_title).replace("'", "\\'")
					p.html.write_string('<h3 class="lesson-title" id="${slug}" data-chapter-id="${chap_id}"><span>${escape_html(clean_title)}</span><button type="button" class="btn-bookmark" data-id="${slug}" onclick="toggleBookmark(\'${slug}\', \'${escaped_js_title}\')" title="Bookmark lesson" aria-label="Bookmark lesson"><svg class="bookmark-icon" viewBox="0 0 24 24" width="16" height="16"><use href="#i-bookmark"></use></svg></button></h3>\n')

					entry_type := if current_chapter_num == '15'
						|| clean_title.starts_with('Exercise ') {
						'exercise'
					} else {
						'lesson'
					}
					p.search_index << SearchIndexEntry{
						id:      slug
						title:   clean_title
						typ:     entry_type
						content: clean_title
						chapter: current_chapter_title
						section: current_section_title
					}
					p.curr_search_idx = p.search_index.len - 1
				}
			} else {
				slug := p.unique_slug(base_slug)
				p.html.write_string('<h${level} id="${slug}">${escape_html(title)}</h${level}>\n')
			}
			continue
		}

		// File locations
		if (trimmed.starts_with('_File location:')
			|| trimmed.starts_with('_File Location:')) && trimmed.ends_with('_') {
			idx_start_bracket := line.index('[') or { -1 }
			idx_end_bracket := line.index(']') or { -1 }
			idx_start_paren := line.index('(') or { -1 }
			idx_end_paren := line.index(')') or { -1 }

			if idx_start_bracket > 0 && idx_end_bracket > idx_start_bracket
				&& idx_start_paren > idx_end_bracket && idx_end_paren > idx_start_paren {
				rel_path := line[idx_start_bracket + 1..idx_end_bracket]
				mut resolved_url := line[idx_start_paren + 1..idx_end_paren]
				if !resolved_url.starts_with('http') && !resolved_url.starts_with('file://')
					&& !resolved_url.starts_with('#') {
					resolved_url = get_github_url(resolved_url)
				}
				p.html.write_string('<div class="file-location"><svg class="icon" width="14" height="14"><use href="#i-file"></use></svg><span>File: </span><a href="${resolved_url}" target="_blank" rel="noopener noreferrer">${escape_html(rel_path)}</a></div>\n')
				p.append_search_text(rel_path)
				continue
			}
		}

		// Regular Paragraphs
		parsed_line := parse_inline(line)
		p.html.write_string('<p>${parsed_line}</p>\n')
		p.append_search_text(line)
	}

	p.close_collapsible_sections()
	p.flush_list()
	p.flush_table()
	p.flush_blockquote()
	p.html.write_string('</section>\n')

	return p.html.str(), p.structure, p.search_index
}

fn main() {
	src_path := os.join_path(@DIR, 'The V Programming Language: A Comprehensive Textbook Guide.md')
	dest_dir := os.join_path(@DIR, 'docs')
	dest_path := os.join_path(dest_dir, 'index.html')
	template_path := os.join_path(@DIR, 'template.html')

	if !os.exists(dest_dir) {
		os.mkdir_all(dest_dir) or {
			eprintln('Failed to create destination directory: ${err}')
			exit(1)
		}
	}

	markdown := os.read_file(src_path) or {
		eprintln('Failed to read source markdown: ${err}')
		exit(1)
	}

	template := os.read_file(template_path) or {
		eprintln('Failed to read template.html: ${err}')
		exit(1)
	}

	println('Parsing markdown...')
	content_html, structure, search_index := parse_markdown_to_html_and_index(markdown)

	println('Generating search index...')
	structure_json := json2.encode(structure)
	search_index_json := json2.encode(search_index)

	println('Building final HTML...')
	mut output := template
	output = output.replace('<!-- CONTENT_HTML_PLACEHOLDER -->', content_html)
	output = output.replace('/* STRUCTURE_JSON_PLACEHOLDER */', structure_json)
	output = output.replace('/* SEARCH_INDEX_JSON_PLACEHOLDER */', search_index_json)

	os.write_file(dest_path, output) or {
		eprintln('Failed to write output HTML: ${err}')
		exit(1)
	}

	println('Build completed successfully! Docs output to docs/index.html')
}
