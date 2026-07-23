#!/usr/bin/env v
import os
import strings
import regex
import json
import net.urllib
import encoding.base64

// Structs for search index and structure JSON
struct Lesson {
	id    string
mut:
	title   string
	content string
}

struct Section {
	id      string
	title   string
mut:
	lessons []Lesson
}

struct Chapter {
	id       string
	number   string
	title    string
mut:
	sections []Section
}

struct SearchIndexEntry {
	id      string
	title   string
	typ     string @[json: 'type']
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
	if code_language.to_lower() == 'v' || code_language.to_lower() == 'vlang' {
		base64_code := base64.encode_str(code_str)
		playground_url := 'https://play.vlang.io/?base64=' + urllib.query_escape(base64_code)
		playground_btn = '<a href="${playground_url}" target="_blank" class="btn-playground" title="Run in V Playground">
                <svg viewBox="0 0 24 24" width="16" height="16" stroke="currentColor" stroke-width="2" fill="none" stroke-linecap="round" stroke-linejoin="round"><polygon points="5 3 19 12 5 21 5 3"></polygon></svg>
                Run
            </a>
            <button class="btn-playground-copy" onclick="copyAndOpenPlayground(this)" title="Copy Code & Open V Playground">
                <svg viewBox="0 0 24 24" width="16" height="16" stroke="currentColor" stroke-width="2" fill="none" stroke-linecap="round" stroke-linejoin="round"><rect x="9" y="9" width="13" height="13" rx="2" ry="2"></rect><path d="M5 15H4a2 2 0 0 1-2-2V4a2 2 0 0 1 2-2h9a2 2 0 0 1 2 2v1"></path></svg>
                Copy &amp; Open
            </button>'
	}
	
	normalized_language := normalize_code_language(code_language)
	return '<div class="code-wrapper">
            <div class="code-header">
                <span class="code-lang">${code_language}</span>
                <div class="code-actions">
                    ${playground_btn}
                    <button type="button" class="btn-zoom" onclick="toggleCodeZoom(this)" title="Zoom Code" aria-label="Zoom code block">
                        <svg viewBox="0 0 24 24" width="16" height="16" stroke="currentColor" stroke-width="2" fill="none" stroke-linecap="round" stroke-linejoin="round"><path d="M21 21l-4.35-4.35"></path><circle cx="11" cy="11" r="6"></circle><path d="M11 8v6"></path><path d="M8 11h6"></path></svg>
                        Zoom
                    </button>
                    <button type="button" class="btn-copy" onclick="copyCode(this)" title="Copy Code" aria-label="Copy code block">
                        <svg class="copy-icon" viewBox="0 0 24 24" width="16" height="16" stroke="currentColor" stroke-width="2" fill="none" stroke-linecap="round" stroke-linejoin="round"><rect x="9" y="9" width="13" height="13" rx="2" ry="2"></rect><path d="M5 15H4a2 2 0 0 1-2-2V4a2 2 0 0 1 2-2h9a2 2 0 0 1 2 2v1"></path></svg>
                        Copy
                    </button>
                </div>
            </div>
            <pre><code class="language-${normalized_language}">${code_html}</code></pre>
        </div>\n'
}

fn normalize_title_for_comparison(text string) string {
	mut res := text
	if res.to_lower().starts_with('lesson:') {
		res = res['lesson:'.len..].trim_space()
	}
	if res.contains('(') {
		idx := res.index('(') or { res.len }
		res = res[..idx].trim_space()
	}
	
	mut clean := strings.new_builder(res.len)
	lower := res.to_lower()
	for i in 0 .. lower.len {
		c := lower[i]
		if (c >= `a` && c <= `z`) || (c >= `0` && c <= `9`) || c == `_` || c == ` ` || c == `-` {
			clean.write_u8(c)
		}
	}
	
	mut final_builder := strings.new_builder(clean.len)
	clean_str := clean.str()
	mut last_was_space := false
	for i in 0 .. clean_str.len {
		c := clean_str[i]
		if c == ` ` {
			if !last_was_space {
				final_builder.write_u8(` `)
				last_was_space = true
			}
		} else {
			final_builder.write_u8(c)
			last_was_space = false
		}
	}
	
	return final_builder.str().trim_space()
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
			link_text: link_text
			href: href
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
			formatted := '<a href="${link_info.href}"${link_info.target_attr}>${link_info.link_text}</a>'
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

fn get_alert_icon(typ string) string {
	return match typ {
		'note' { '<path d="M0 8a8 8 0 1 1 16 0A8 8 0 0 1 0 8Zm8-6.5a.75.75 0 0 0-.75.75v5.25a.75.75 0 0 0 1.5 0V2.25A.75.75 0 0 0 8 1.5ZM8.75 11a.75.75 0 1 0-1.5 0 .75.75 0 0 0 1.5 0Z"></path>' }
		'tip' { '<path d="M8 1.5c-2.363 0-4 1.83-4 3.75 0 .885.342 1.684.97 2.31l.01.01c.28.28.483.636.597 1.02a.25.25 0 0 1-.24.32H3.75a.75.75 0 0 0 0 1.5h1.223a.25.25 0 0 1 .24.32c-.114.384-.316.74-.596 1.02l-.01.01c-.628.626-.97 1.425-.97 2.31 0 1.92 1.637 3.75 4 3.75s4-1.83 4-3.75c0-.885-.342-1.684-.97-2.31l-.01-.01a2.915 2.915 0 0 0-.596-1.02.25.25 0 0 1 .24-.32h1.223a.75.75 0 0 0 0-1.5H10.74a.25.25 0 0 1-.24-.32c.114-.384.316-.74.596-1.02l.01-.01c.628-.626.97-1.425.97-2.31 0-1.92-1.637-3.75-4-3.75ZM6.5 5.5a.5.5 0 0 1 .5-.5h2a.5.5 0 0 1 0 1H7a.5.5 0 0 1-.5-.5ZM7 8a.5.5 0 0 1 .5-.5h1a.5.5 0 0 1 0 1h-1A.5.5 0 0 1 7 8Z"></path>' }
		'important' { '<path d="M0 8a8 8 0 1 1 16 0A8 8 0 0 1 0 8Zm1.5 0a6.5 6.5 0 1 0 13 0 6.5 6.5 0 0 0-13 0Zm7.25-3.25v3.5a.75.75 0 0 1-1.5 0v-3.5a.75.75 0 0 1 1.5 0ZM8 10a1 1 0 1 1 0 2 1 1 0 0 1 0-2Z"></path>' }
		'warning' { '<path d="M6.457 1.047c.659-1.14 2.427-1.14 3.086 0l6.03 10.437C16.233 12.624 15.349 14 14.03 14H1.97c-1.319 0-2.204-1.376-1.543-2.516L6.457 1.047ZM8 4c-.552 0-1 .448-1 1v3c0 .552.448 1 1 1s1-.448 1-1V5c0-.552-.448-1-1-1Zm0 6.5a1 1 0 1 0 0 2 1 1 0 0 0 0-2Z"></path>' }
		'caution' { '<path d="M8 15A7 7 0 1 1 8 1a7 7 0 0 1 0 14Zm0 1.5a8.5 8.5 0 1 0 0-17 8.5 8.5 0 0 0 0 17Zm0-9a.75.75 0 0 1 .75.75v4.5a.75.75 0 0 1-1.5 0v-4.5A.75.75 0 0 1 8 7.5ZM8 4.75a.75.75 0 1 1 0 1.5.75.75 0 0 1 0-1.5Z"></path>' }
		'exercise' { '<path d="M8 1.5A6.5 6.5 0 1 0 14.5 8 6.507 6.507 0 0 0 8 1.5Zm.75 3.25a.75.75 0 0 1-1.5 0V8a.75.75 0 0 1 1.5 0Zm0 4.5a.75.75 0 1 1-1.5 0 .75.75 0 0 1 1.5 0Z"></path>' }
		'solution' { '<path d="M13.78 4.22a.75.75 0 0 1 0 1.06L6.56 12.5a.75.75 0 0 1-1.06 0l-3.5-3.5a.75.75 0 1 1 1.06-1.06l2.97 2.97 6.97-8.97a.75.75 0 0 1 1.06 0Z"></path>' }
		'output' { '<path d="M5.75 3a.75.75 0 0 0 0 1.5h4.5A.75.75 0 0 0 10.25 3h-4.5Zm-2.5 4.5A.75.75 0 0 0 3 8.25v3.5a.75.75 0 0 0 1.5 0v-3.5Zm7.5 0A.75.75 0 0 0 10.5 8.25v3.5a.75.75 0 0 0 1.5 0v-3.5ZM8 10.25a.75.75 0 0 1 .75.75v1.5a.75.75 0 0 1-1.5 0v-1.5A.75.75 0 0 1 8 10.25Z"></path>' }
		else { '' }
	}
}

struct Parser {
mut:
	html               strings.Builder
	curr_chap_idx      int = -1
	curr_sec_idx       int = -1
	curr_less_idx      int = -1
	
	search_index       []SearchIndexEntry
	structure          []Chapter
	
	in_code_block      bool
	code_language      string
	code_content       []string
	
	in_blockquote      bool
	alert_type         string
	blockquote_content []string
	
	in_list            bool
	list_type          string
}

fn (mut p Parser) flush_list() {
	if p.in_list {
		p.html.write_string('</${p.list_type}>\n')
		p.in_list = false
	}
}

fn (mut p Parser) flush_blockquote() {
	if p.in_blockquote {
		mut parsed_content := ''
		mut block_code_content := []string{}
		mut in_block_code := false
		mut block_code_language := ''
		
		for b_line in p.blockquote_content {
			trimmed_b_line := b_line.trim_space()
			
			if trimmed_b_line.starts_with('```') {
				if in_block_code {
					code_str := block_code_content.join('\n')
					parsed_content += generate_code_block_html(block_code_language, code_str)
					in_block_code = false
					block_code_content.clear()
				} else {
					in_block_code = true
					block_code_language = trimmed_b_line[3..].trim_space()
				}
			} else if in_block_code {
				block_code_content << b_line
			} else {
				if trimmed_b_line != '' {
					parsed_content += '<p>${parse_inline(b_line)}</p>\n'
				}
			}
		}
		
		if in_block_code && block_code_content.len > 0 {
			code_str := block_code_content.join('\n')
			parsed_content += generate_code_block_html(block_code_language, code_str)
		}
		
		if p.alert_type != '' {
			p.html.write_string('<div class="alert alert-${p.alert_type}">
                    <div class="alert-title">
                        <svg class="alert-icon" viewBox="0 0 16 16" width="16" height="16">
                            ${get_alert_icon(p.alert_type)}
                        </svg>
                        <span>${p.alert_type.to_upper()}</span>
                    </div>
                    <div class="alert-content">${parsed_content}</div>
                </div>\n')
		} else {
			p.html.write_string('<blockquote>${parsed_content}</blockquote>\n')
		}
		
		p.in_blockquote = false
		p.alert_type = ''
		p.blockquote_content.clear()
	}
}

fn parse_markdown_to_html_and_index(md string) (string, []Chapter, []SearchIndexEntry) {
	lines := md.split_into_lines()
	mut p := Parser{
		html: strings.new_builder(md.len)
	}
	
	mut re_ul := regex.regex_opt(r'^\s*-\s+(.*)') or { panic(err) }
	mut re_ol := regex.regex_opt(r'^\s*\d+\.\s+(.*)') or { panic(err) }
	mut re_h := regex.regex_opt(r'^(#{1,6})\s+(.*)') or { panic(err) }
	
	for line in lines {
		trimmed := line.trim_space()
		
		// Code blocks
		if trimmed.starts_with('```') {
			p.flush_list()
			p.flush_blockquote()
			if p.in_code_block {
				code_str := p.code_content.join('\n')
				p.html.write_string(generate_code_block_html(p.code_language, code_str))
				
				if p.curr_chap_idx >= 0 && p.curr_sec_idx >= 0 && p.curr_less_idx >= 0 {
					p.structure[p.curr_chap_idx].sections[p.curr_sec_idx].lessons[p.curr_less_idx].content += ' [CODE:${p.code_language}]'
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
			continue
		} else {
			p.flush_list()
		}
		
		if trimmed == '' {
			continue
		}
		
		if trimmed == '---' {
			p.html.write_string('<hr />\n')
			continue
		}
		
		// Headings
		s_h, _ := re_h.find(line)
		if s_h == 0 {
			h := re_h.get_group_by_id(line, 0)
			title := re_h.get_group_by_id(line, 1).trim_space()
			slug := slugify(title)
			level := h.len
			
			if level == 1 {
				if title.starts_with('Chapter ') && title.contains(':') {
					mut chap_num := ''
					mut chap_name := title
					colon_idx := title.index(':') or { -1 }
					if colon_idx > 'Chapter '.len {
						chap_num = title['Chapter '.len .. colon_idx].trim_space()
						chap_name = title[colon_idx + 1 ..].trim_space()
					}
					
					p.structure << Chapter{
						id: slug
						number: chap_num
						title: chap_name
						sections: []
					}
					p.curr_chap_idx = p.structure.len - 1
					p.curr_sec_idx = -1
					p.curr_less_idx = -1
					
					p.html.write_string('</section>\n<section id="chap-wrapper-${slug}" class="chapter-section" data-chapter-id="${slug}">\n')
					p.html.write_string('<h1 class="chapter-title" id="${slug}" data-chapter-id="${slug}"><span class="chap-badge">Chapter ${chap_num}</span> ${escape_html(chap_name)}</h1>\n')
					
					p.search_index << SearchIndexEntry{
						id: slug
						title: 'Chapter ${chap_num}: ${chap_name}'
						typ: 'chapter'
						content: title
					}
				} else {
					p.html.write_string('<h1 class="doc-main-title" id="${slug}">${escape_html(title)}</h1>\n')
					p.search_index << SearchIndexEntry{
						id: slug
						title: title
						typ: 'title'
						content: title
					}
				}
			} else if level == 2 {
				if title == 'Code Examples Index' || title == 'Table of Contents' {
					continue
				}
				
				mut current_chapter_title := ''
				if p.curr_chap_idx >= 0 {
					current_chapter_title = p.structure[p.curr_chap_idx].title
					
					p.structure[p.curr_chap_idx].sections << Section{
						id: slug
						title: title
						lessons: []
					}
					p.curr_sec_idx = p.structure[p.curr_chap_idx].sections.len - 1
					p.curr_less_idx = -1
				}
				
				p.html.write_string('<h2 class="section-title" id="${slug}" data-chapter-id="${if p.curr_chap_idx >= 0 { p.structure[p.curr_chap_idx].id } else { "" }}">${escape_html(title)}</h2>\n')
				
				p.search_index << SearchIndexEntry{
					id: slug
					title: title
					typ: 'section'
					content: title
					chapter: current_chapter_title
				}
			} else if level == 3 {
				mut is_lesson := false
				mut clean_title := title
				if title.starts_with('Lesson:') {
					is_lesson = true
					clean_title = title[7..].trim_space()
				}
				
				mut duplicate_idx := -1
				if p.curr_chap_idx >= 0 && p.curr_sec_idx >= 0 {
					lessons := p.structure[p.curr_chap_idx].sections[p.curr_sec_idx].lessons
					if lessons.len > 0 {
						last_lesson := lessons[lessons.len - 1]
						if normalize_title_for_comparison(last_lesson.title) == normalize_title_for_comparison(title) {
							duplicate_idx = lessons.len - 1
						}
					}
				}
				
				mut current_chapter_title := ''
				mut current_section_title := ''
				if p.curr_chap_idx >= 0 {
					current_chapter_title = p.structure[p.curr_chap_idx].title
					if p.curr_sec_idx >= 0 {
						current_section_title = p.structure[p.curr_chap_idx].sections[p.curr_sec_idx].title
					}
				}
				
				if duplicate_idx >= 0 {
					if is_lesson {
						p.structure[p.curr_chap_idx].sections[p.curr_sec_idx].lessons[duplicate_idx].title = clean_title
					}
					p.curr_less_idx = duplicate_idx
					
					lesson_class := if is_lesson { ' lesson-header' } else { '' }
					p.html.write_string('<h3 class="lesson-subtitle${lesson_class}" id="${slug}" data-chapter-id="${if p.curr_chap_idx >= 0 { p.structure[p.curr_chap_idx].id } else { "" }}">
                        <span>${escape_html(clean_title)}</span>
                        <button class="btn-bookmark" data-id="${slug}" onclick="toggleBookmark(\'${slug}\', \'${escape_html(clean_title).replace("\'", "\\\'")}\')" title="Bookmark lesson">
                            <svg class="bookmark-icon" viewBox="0 0 24 24" width="16" height="16" stroke="currentColor" stroke-width="2" fill="none"><path d="M19 21l-7-5-7 5V5a2 2 0 0 1 2-2h10a2 2 0 0 1 2 2z"></path></svg>
                        </button>
                    </h3>\n')
				} else {
					lesson := Lesson{
						id: slug
						title: clean_title
						content: ''
					}
					if p.curr_chap_idx >= 0 && p.curr_sec_idx >= 0 {
						p.structure[p.curr_chap_idx].sections[p.curr_sec_idx].lessons << lesson
						p.curr_less_idx = p.structure[p.curr_chap_idx].sections[p.curr_sec_idx].lessons.len - 1
					}
					
					lesson_class := if is_lesson { ' lesson-header' } else { '' }
					p.html.write_string('<h3 class="lesson-title${lesson_class}" id="${slug}" data-chapter-id="${if p.curr_chap_idx >= 0 { p.structure[p.curr_chap_idx].id } else { "" }}">
                        <span>${escape_html(clean_title)}</span>
                        <button class="btn-bookmark" data-id="${slug}" onclick="toggleBookmark(\'${slug}\', \'${escape_html(clean_title).replace("\'", "\\\'")}\')" title="Bookmark lesson">
                            <svg class="bookmark-icon" viewBox="0 0 24 24" width="16" height="16" stroke="currentColor" stroke-width="2" fill="none"><path d="M19 21l-7-5-7 5V5a2 2 0 0 1 2-2h10a2 2 0 0 1 2 2z"></path></svg>
                        </button>
                    </h3>\n')
					
					p.search_index << SearchIndexEntry{
						id: slug
						title: clean_title
						typ: 'lesson'
						content: clean_title
						chapter: current_chapter_title
						section: current_section_title
					}
				}
			} else {
				p.html.write_string('<h${level} id="${slug}">${escape_html(title)}</h${level}>\n')
			}
			continue
		}
		
		// File locations
		if (trimmed.starts_with('_File location:') || trimmed.starts_with('_File Location:')) && trimmed.ends_with('_') {
			idx_start_bracket := line.index('[') or { -1 }
			idx_end_bracket := line.index(']') or { -1 }
			idx_start_paren := line.index('(') or { -1 }
			idx_end_paren := line.index(')') or { -1 }
			
			if idx_start_bracket > 0 && idx_end_bracket > idx_start_bracket && idx_start_paren > idx_end_bracket && idx_end_paren > idx_start_paren {
				rel_path := line[idx_start_bracket + 1 .. idx_end_bracket]
				mut abs_path := line[idx_start_paren + 1 .. idx_end_paren]
				if !abs_path.starts_with('http') && !abs_path.starts_with('file://') && !abs_path.starts_with('#') {
					abs_path = get_github_url(abs_path)
				}
				p.html.write_string('<div class="file-location">
                <svg viewBox="0 0 24 24" width="14" height="14" stroke="currentColor" stroke-width="2" fill="none"><path d="M13 2H6a2 2 0 0 0-2 2v16a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V9z"></path><polyline points="13 2 13 9 20 9"></polyline></svg>
                <span>File: </span><a href="${abs_path}" target="_blank" rel="noopener noreferrer">${escape_html(rel_path)}</a>
            </div>\n')
				if p.curr_chap_idx >= 0 && p.curr_sec_idx >= 0 && p.curr_less_idx >= 0 {
					p.structure[p.curr_chap_idx].sections[p.curr_sec_idx].lessons[p.curr_less_idx].content += ' File location: ' + rel_path
				}
				continue
			}
		}
		
		// Regular Paragraphs
		parsed_line := parse_inline(line)
		p.html.write_string('<p>${parsed_line}</p>\n')
		if p.curr_chap_idx >= 0 && p.curr_sec_idx >= 0 && p.curr_less_idx >= 0 {
			p.structure[p.curr_chap_idx].sections[p.curr_sec_idx].lessons[p.curr_less_idx].content += ' ' + line
		}
	}
	
	p.flush_list()
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
	structure_json := json.encode(structure)
	search_index_json := json.encode(search_index)
	
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
