const fs = require('fs');
const path = require('path');

const srcPath = path.join(__dirname, 'The V Programming Language: A Comprehensive Textbook Guide.md');
const destDir = path.join(__dirname, 'docs');
const destPath = path.join(destDir, 'index.html');

// Create dest directory if it doesn't exist
if (!fs.existsSync(destDir)) {
    fs.mkdirSync(destDir, { recursive: true });
}

const markdown = fs.readFileSync(srcPath, 'utf8');

function escapeHtml(text) {
    return text
        .replace(/&/g, '&amp;')
        .replace(/</g, '&lt;')
        .replace(/>/g, '&gt;')
        .replace(/"/g, '&quot;')
        .replace(/'/g, '&#039;');
}

// Custom Markdown parser optimized for this specific guide
function parseMarkdownToHtmlAndIndex(md) {
    const lines = md.split(/\r?\n/);
    let html = '';
    let currentChapter = null;
    let currentSection = null;
    let currentLesson = null;
    
    // For search indexing
    const searchIndex = [];
    
    let inCodeBlock = false;
    let codeLanguage = '';
    let codeContent = [];
    
    let inBlockquote = false;
    let alertType = null; // 'note', 'tip', 'important', 'warning', 'caution'
    let blockquoteContent = [];
    
    let inList = false;
    let listType = ''; // 'ul', 'ol'

    function flushList() {
        if (inList) {
            html += `</${listType}>\n`;
            inList = false;
        }
    }

    function flushBlockquote() {
        if (inBlockquote) {
            const contentText = blockquoteContent.join('\n');
            const parsedContent = parseInline(contentText);
            if (alertType) {
                html += `<div class="alert alert-${alertType}">
                    <div class="alert-title">
                        <svg class="alert-icon" viewBox="0 0 16 16" width="16" height="16">
                            ${getAlertIcon(alertType)}
                        </svg>
                        <span>${alertType.toUpperCase()}</span>
                    </div>
                    <div class="alert-content">${parsedContent}</div>
                </div>\n`;
            } else {
                html += `<blockquote>${parsedContent}</blockquote>\n`;
            }
            inBlockquote = false;
            alertType = null;
            blockquoteContent = [];
        }
    }

    function getAlertIcon(type) {
        switch (type) {
            case 'note':
                return '<path d="M0 8a8 8 0 1 1 16 0A8 8 0 0 1 0 8Zm8-6.5a.75.75 0 0 0-.75.75v5.25a.75.75 0 0 0 1.5 0V2.25A.75.75 0 0 0 8 1.5ZM8.75 11a.75.75 0 1 0-1.5 0 .75.75 0 0 0 1.5 0Z"></path>';
            case 'tip':
                return '<path d="M8 1.5c-2.363 0-4 1.83-4 3.75 0 .885.342 1.684.97 2.31l.01.01c.28.28.483.636.597 1.02a.25.25 0 0 1-.24.32H3.75a.75.75 0 0 0 0 1.5h1.223a.25.25 0 0 1 .24.32c-.114.384-.316.74-.596 1.02l-.01.01c-.628.626-.97 1.425-.97 2.31 0 1.92 1.637 3.75 4 3.75s4-1.83 4-3.75c0-.885-.342-1.684-.97-2.31l-.01-.01a2.915 2.915 0 0 0-.596-1.02.25.25 0 0 1 .24-.32h1.223a.75.75 0 0 0 0-1.5H10.74a.25.25 0 0 1-.24-.32c.114-.384.316-.74.596-1.02l.01-.01c.628-.626.97-1.425.97-2.31 0-1.92-1.637-3.75-4-3.75ZM6.5 5.5a.5.5 0 0 1 .5-.5h2a.5.5 0 0 1 0 1H7a.5.5 0 0 1-.5-.5ZM7 8a.5.5 0 0 1 .5-.5h1a.5.5 0 0 1 0 1h-1A.5.5 0 0 1 7 8Z"></path>';
            case 'important':
                return '<path d="M0 8a8 8 0 1 1 16 0A8 8 0 0 1 0 8Zm1.5 0a6.5 6.5 0 1 0 13 0 6.5 6.5 0 0 0-13 0Zm7.25-3.25v3.5a.75.75 0 0 1-1.5 0v-3.5a.75.75 0 0 1 1.5 0ZM8 10a1 1 0 1 1 0 2 1 1 0 0 1 0-2Z"></path>';
            case 'warning':
                return '<path d="M6.457 1.047c.659-1.14 2.427-1.14 3.086 0l6.03 10.437C16.233 12.624 15.349 14 14.03 14H1.97c-1.319 0-2.204-1.376-1.543-2.516L6.457 1.047ZM8 4c-.552 0-1 .448-1 1v3c0 .552.448 1 1 1s1-.448 1-1V5c0-.552-.448-1-1-1Zm0 6.5a1 1 0 1 0 0 2 1 1 0 0 0 0-2Z"></path>';
            case 'caution':
                return '<path d="M8 15A7 7 0 1 1 8 1a7 7 0 0 1 0 14Zm0 1.5a8.5 8.5 0 1 0 0-17 8.5 8.5 0 0 0 0 17Zm0-9a.75.75 0 0 1 .75.75v4.5a.75.75 0 0 1-1.5 0v-4.5A.75.75 0 0 1 8 7.5ZM8 4.75a.75.75 0 1 1 0 1.5.75.75 0 0 1 0-1.5Z"></path>';
            default:
                return '';
        }
    }

    function parseInline(text) {
        // Code symbol links format: [ClassName](file:///...) -> ClassName with link
        // Avoid backticks around link text
        let result = escapeHtml(text);
        
        // Match Markdown links [text](url)
        result = result.replace(/\[([^\]]+)\]\(([^)]+)\)/g, (match, linkText, url) => {
            const isExternal = url.startsWith('http://') || url.startsWith('https://');
            const targetAttr = isExternal ? ' target="_blank" rel="noopener noreferrer"' : '';
            return `<a href="${url}"${targetAttr}>${linkText}</a>`;
        });

        // Bold **text**
        result = result.replace(/\*\*([^*]+)\*\*/g, '<strong>$1</strong>');
        // Bold __text__
        result = result.replace(/__([^_]+)__/g, '<strong>$1</strong>');
        // Italics *text*
        result = result.replace(/\*([^*]+)\*/g, '<em>$1</em>');
        // Italics _text_
        result = result.replace(/_([^_]+)_/g, '<em>$1</em>');
        // Inline code `code`
        result = result.replace(/`([^`]+)`/g, '<code>$1</code>');
        
        return result;
    }

    function slugify(text) {
        return text.toLowerCase()
            .replace(/[^\w\s-]/g, '')
            .replace(/\s/g, '-')
            .replace(/^-+|-+$/g, '');
    }

    const structure = [];

    for (let i = 0; i < lines.length; i++) {
        let line = lines[i];

        // Code block check
        if (line.trim().startsWith('```')) {
            flushList();
            flushBlockquote();
            if (inCodeBlock) {
                // End code block
                const codeStr = codeContent.join('\n');
                let codeHtml = escapeHtml(codeStr);
                
                // Base64 encoding for V Playground
                let playgroundBtn = '';
                if (codeLanguage.toLowerCase() === 'v' || codeLanguage.toLowerCase() === 'vlang') {
                    const base64Code = Buffer.from(codeStr).toString('base64');
                    const playgroundUrl = `https://play.vlang.io/?code=${encodeURIComponent(base64Code)}`;
                    playgroundBtn = `<a href="${playgroundUrl}" target="_blank" class="btn-playground" title="Run in V Playground">
                        <svg viewBox="0 0 24 24" width="16" height="16" stroke="currentColor" stroke-width="2" fill="none" stroke-linecap="round" stroke-linejoin="round"><polygon points="5 3 19 12 5 21 5 3"></polygon></svg>
                        Run
                    </a>`;
                }

                html += `<div class="code-wrapper">
                    <div class="code-header">
                        <span class="code-lang">${codeLanguage || 'text'}</span>
                        <div class="code-actions">
                            ${playgroundBtn}
                            <button class="btn-copy" onclick="copyCode(this)" title="Copy Code">
                                <svg class="copy-icon" viewBox="0 0 24 24" width="16" height="16" stroke="currentColor" stroke-width="2" fill="none" stroke-linecap="round" stroke-linejoin="round"><rect x="9" y="9" width="13" height="13" rx="2" ry="2"></rect><path d="M5 15H4a2 2 0 0 1-2-2V4a2 2 0 0 1 2-2h9a2 2 0 0 1 2 2v1"></path></svg>
                                Copy
                            </button>
                        </div>
                    </div>
                    <pre><code class="language-${codeLanguage || 'text'}">${codeHtml}</code></pre>
                </div>\n`;

                // Add to current lesson content
                if (currentLesson) {
                    currentLesson.content += `[CODE:${codeLanguage}]`;
                }

                inCodeBlock = false;
                codeContent = [];
            } else {
                // Start code block
                inCodeBlock = true;
                codeLanguage = line.trim().substring(3).trim();
            }
            continue;
        }

        if (inCodeBlock) {
            codeContent.push(line);
            continue;
        }

        // Blockquote check
        if (line.trim().startsWith('>')) {
            flushList();
            inBlockquote = true;
            let cleanLine = line.trim().substring(1).trim();
            
            // Check for GitHub alerts
            if (cleanLine.startsWith('[!NOTE]')) {
                alertType = 'note';
                cleanLine = cleanLine.substring(7).trim();
            } else if (cleanLine.startsWith('[!TIP]')) {
                alertType = 'tip';
                cleanLine = cleanLine.substring(6).trim();
            } else if (cleanLine.startsWith('[!IMPORTANT]')) {
                alertType = 'important';
                cleanLine = cleanLine.substring(12).trim();
            } else if (cleanLine.startsWith('[!WARNING]')) {
                alertType = 'warning';
                cleanLine = cleanLine.substring(10).trim();
            } else if (cleanLine.startsWith('[!CAUTION]')) {
                alertType = 'caution';
                cleanLine = cleanLine.substring(10).trim();
            }
            
            if (cleanLine) {
                blockquoteContent.push(cleanLine);
            }
            continue;
        } else if (inBlockquote) {
            // Blockquotes can span multiple lines if there are consecutive lines with >
            // Or if we encounter an empty line, we close it
            flushBlockquote();
        }

        // Lists check
        const ulMatch = line.match(/^(\s*)-\s+(.*)/);
        const olMatch = line.match(/^(\s*)\d+\.\s+(.*)/);
        
        if (ulMatch) {
            const content = ulMatch[2];
            if (!inList || listType !== 'ul') {
                flushList();
                html += `<ul>\n`;
                inList = true;
                listType = 'ul';
            }
            html += `<li>${parseInline(content)}</li>\n`;
            continue;
        } else if (olMatch) {
            const content = olMatch[2];
            if (!inList || listType !== 'ol') {
                flushList();
                html += `<ol>\n`;
                inList = true;
                listType = 'ol';
            }
            html += `<li>${parseInline(content)}</li>\n`;
            continue;
        } else {
            // Not a list item, so close the open list
            flushList();
        }

        // Empty lines
        if (line.trim() === '') {
            continue;
        }

        // Horizontal Rule
        if (line.trim() === '---') {
            html += `<hr />\n`;
            continue;
        }

        // Headings check
        const headingMatch = line.match(/^(#{1,6})\s+(.*)/);
        if (headingMatch) {
            const level = headingMatch[1].length;
            const title = headingMatch[2].trim();
            const slug = slugify(title);

            if (level === 1) {
                // If it is Chapter X: Title
                if (title.startsWith('Chapter ')) {
                    const chapMatch = title.match(/^Chapter (\d+):\s*(.*)/);
                    const chapNum = chapMatch ? chapMatch[1] : '';
                    const chapName = chapMatch ? chapMatch[2] : title;
                    
                    currentChapter = {
                        id: slug,
                        number: chapNum,
                        title: chapName,
                        sections: []
                    };
                    structure.push(currentChapter);
                    currentSection = null;
                    currentLesson = null;
                    
                    html += `</section>\n<section id="chap-wrapper-${slug}" class="chapter-section">\n`;
                    html += `<h1 class="chapter-title" id="${slug}"><span class="chap-badge">Chapter ${chapNum}</span> ${escapeHtml(chapName)}</h1>\n`;
                    
                    searchIndex.push({
                        id: currentChapter.id,
                        title: `Chapter ${chapNum}: ${chapName}`,
                        type: 'chapter',
                        content: title
                    });
                } else {
                    // Document title
                    html += `<h1 class="doc-main-title" id="${slug}">${escapeHtml(title)}</h1>\n`;
                    searchIndex.push({
                        id: slug,
                        title: title,
                        type: 'title',
                        content: title
                    });
                }
            } else if (level === 2) {
                // Section
                // Skip rendering redundancy index
                if (title === 'Code Examples Index' || title === 'Table of Contents') {
                    // We can skip these since our custom sidebar handles navigation
                    continue;
                }
                
                currentSection = {
                    id: slug,
                    title: title,
                    lessons: []
                };
                if (currentChapter) {
                    currentChapter.sections.push(currentSection);
                }
                currentLesson = null;

                html += `<h2 class="section-title" id="${slug}">${escapeHtml(title)}</h2>\n`;
                
                searchIndex.push({
                    id: `sec-${slug}`,
                    title: title,
                    type: 'section',
                    content: title,
                    chapter: currentChapter ? currentChapter.title : ''
                });
            } else if (level === 3) {
                // Lesson or Subtitle
                let isLesson = false;
                let cleanTitle = title;
                if (title.startsWith('Lesson:')) {
                    isLesson = true;
                    cleanTitle = title.substring(7).trim();
                }

                currentLesson = {
                    id: slug,
                    title: cleanTitle,
                    content: ''
                };

                if (currentSection) {
                    currentSection.lessons.push(currentLesson);
                }

                const lessonClass = isLesson ? ' lesson-header' : '';
                html += `<h3 class="lesson-title${lessonClass}" id="${slug}">${escapeHtml(cleanTitle)}</h3>\n`;
                
                searchIndex.push({
                    id: `lesson-${slug}`,
                    title: cleanTitle,
                    type: 'lesson',
                    content: cleanTitle,
                    chapter: currentChapter ? currentChapter.title : '',
                    section: currentSection ? currentSection.title : ''
                });
            } else {
                html += `<h${level} id="${slug}">${escapeHtml(title)}</h${level}>\n`;
            }
            continue;
        }

        // Check for file location lines
        // e.g. _File location: [relative/path](file:///absolute/path)_
        const fileLocMatch = line.match(/^_(File location|File Location):\s*\[(.*?)\]\((.*?)\)_/);
        if (fileLocMatch) {
            const relPath = fileLocMatch[2];
            const absPath = fileLocMatch[3];
            html += `<div class="file-location">
                <svg viewBox="0 0 24 24" width="14" height="14" stroke="currentColor" stroke-width="2" fill="none"><path d="M13 2H6a2 2 0 0 0-2 2v16a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V9z"></path><polyline points="13 2 13 9 20 9"></polyline></svg>
                <span>File: </span><a href="${absPath}">${escapeHtml(relPath)}</a>
            </div>\n`;
            if (currentLesson) {
                currentLesson.content += ` File location: ${relPath}`;
            }
            continue;
        }

        // Default Paragraph
        const parsedLine = parseInline(line);
        html += `<p>${parsedLine}</p>\n`;
        if (currentLesson) {
            currentLesson.content += ' ' + line;
        }
    }

    // Close any unclosed sections/divs
    flushList();
    flushBlockquote();
    html += `</section>\n`;

    return {
        html,
        structure,
        searchIndex
    };
}

// Generate the beautiful Single Page App
const { html: contentHtml, structure, searchIndex } = parseMarkdownToHtmlAndIndex(markdown);

// Prepare structural JSON for client search
const structureJson = JSON.stringify(structure);
const searchIndexJson = JSON.stringify(searchIndex);

const template = `<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>The V Programming Language: A Comprehensive Textbook Guide</title>
    <meta name="description" content="A comprehensive, premium, interactive learning guide for the V Programming Language. Explore chapters, code lessons, and run examples directly in the V Playground.">
    <!-- Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&family=JetBrains+Mono:wght@400;500;700&family=Outfit:wght@400;600;800&display=swap" rel="stylesheet">
    
    <!-- Prism.js for V language syntax highlighting -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/prism/1.29.0/themes/prism-tomorrow.min.css" rel="stylesheet" />
    
    <style>
        :root {
            /* Base Colors - HSL tailored premium dark theme */
            --bg-primary: #0b0f19;
            --bg-secondary: #131a2c;
            --bg-tertiary: #1b253f;
            
            --text-primary: #f1f5f9;
            --text-secondary: #94a3b8;
            --text-muted: #64748b;
            
            --accent-primary: #4f46e5;      /* Indigo */
            --accent-glow: #6366f1;         /* Indigo Glow */
            --accent-gradient: linear-gradient(135deg, #6366f1 0%, #a855f7 100%);
            
            --border-color: #1e293b;
            --border-hover: #334155;
            
            --code-bg: #090d16;
            --sidebar-width: 320px;
            --header-height: 70px;
            
            /* Alert colors */
            --color-note: #38bdf8;
            --color-tip: #34d399;
            --color-important: #a78bfa;
            --color-warning: #fbbf24;
            --color-caution: #f87171;
            
            --font-ui: 'Inter', system-ui, -apple-system, sans-serif;
            --font-heading: 'Outfit', sans-serif;
            --font-code: 'JetBrains+Mono', 'JetBrains Mono', monospace;
            
            --transition-speed: 0.25s;
            --shadow-premium: 0 10px 25px -5px rgba(0, 0, 0, 0.3), 0 8px 10px -6px rgba(0, 0, 0, 0.3);
            --glass-bg: rgba(19, 26, 44, 0.8);
            --glass-backdrop: blur(12px);
        }
        
        /* Light Theme overrides */
        html[data-theme="light"] {
            --bg-primary: #f8fafc;
            --bg-secondary: #ffffff;
            --bg-tertiary: #f1f5f9;
            
            --text-primary: #0f172a;
            --text-secondary: #475569;
            --text-muted: #94a3b8;
            
            --accent-primary: #4f46e5;
            --accent-glow: #4f46e5;
            --accent-gradient: linear-gradient(135deg, #4f46e5 0%, #7c3aed 100%);
            
            --border-color: #e2e8f0;
            --border-hover: #cbd5e1;
            
            --code-bg: #0f172a;
            --glass-bg: rgba(255, 255, 255, 0.85);
            --shadow-premium: 0 10px 25px -5px rgba(0, 0, 0, 0.05), 0 8px 10px -6px rgba(0, 0, 0, 0.05);
        }

        /* Cyberpunk Theme overrides */
        html[data-theme="cyberpunk"] {
            --bg-primary: #050508;
            --bg-secondary: #0d0e15;
            --bg-tertiary: #161925;
            
            --text-primary: #00ffcc;
            --text-secondary: #ff007f;
            --text-muted: #8b8ea9;
            
            --accent-primary: #ff007f;
            --accent-glow: #00ffcc;
            --accent-gradient: linear-gradient(135deg, #ff007f 0%, #00ffcc 100%);
            
            --border-color: #2b1c3c;
            --border-hover: #ff007f;
            
            --code-bg: #030305;
            --glass-bg: rgba(13, 14, 21, 0.9);
            --shadow-premium: 0 0 15px rgba(255, 0, 127, 0.2), 0 0 30px rgba(0, 255, 204, 0.1);
        }

        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
            scroll-behavior: smooth;
        }

        body {
            font-family: var(--font-ui);
            background-color: var(--bg-primary);
            color: var(--text-primary);
            display: flex;
            min-height: 100vh;
            overflow-x: hidden;
            transition: background-color var(--transition-speed), color var(--transition-speed);
        }

        /* Top Reading Progress Bar */
        .progress-container {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 4px;
            z-index: 1000;
            background: rgba(0, 0, 0, 0.1);
        }

        .progress-bar {
            height: 100%;
            background: var(--accent-gradient);
            width: 0%;
            transition: width 0.1s ease;
        }

        /* App Layout */
        .app-container {
            display: flex;
            width: 100%;
            position: relative;
        }

        /* Left Navigation Sidebar */
        aside.sidebar {
            width: var(--sidebar-width);
            height: 100vh;
            position: fixed;
            top: 0;
            left: 0;
            background-color: var(--bg-secondary);
            border-right: 1px solid var(--border-color);
            display: flex;
            flex-direction: column;
            z-index: 100;
            transition: transform var(--transition-speed) ease, background-color var(--transition-speed), border-color var(--transition-speed);
        }

        .sidebar-header {
            padding: 24px 20px;
            border-bottom: 1px solid var(--border-color);
            display: flex;
            flex-direction: column;
            gap: 12px;
        }

        .logo-area {
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .logo-v {
            background: var(--accent-gradient);
            color: #ffffff;
            width: 32px;
            height: 32px;
            border-radius: 8px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: 800;
            font-family: var(--font-heading);
            font-size: 20px;
            box-shadow: 0 4px 10px rgba(99, 102, 241, 0.4);
        }

        .logo-title {
            font-family: var(--font-heading);
            font-weight: 700;
            font-size: 18px;
            letter-spacing: -0.5px;
            background: var(--accent-gradient);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
        }

        .search-container {
            position: relative;
        }

        .search-input {
            width: 100%;
            padding: 10px 14px 10px 36px;
            border-radius: 8px;
            border: 1px solid var(--border-color);
            background-color: var(--bg-primary);
            color: var(--text-primary);
            font-family: var(--font-ui);
            font-size: 14px;
            outline: none;
            transition: border-color var(--transition-speed), box-shadow var(--transition-speed);
        }

        .search-input:focus {
            border-color: var(--accent-primary);
            box-shadow: 0 0 0 2px rgba(99, 102, 241, 0.2);
        }

        .search-icon {
            position: absolute;
            left: 12px;
            top: 50%;
            transform: translateY(-50%);
            color: var(--text-muted);
            pointer-events: none;
        }

        .sidebar-menu {
            flex: 1;
            overflow-y: auto;
            padding: 16px;
            display: flex;
            flex-direction: column;
            gap: 16px;
        }

        /* Custom Scrollbar for Sidebar & Code */
        ::-webkit-scrollbar {
            width: 6px;
            height: 6px;
        }
        ::-webkit-scrollbar-track {
            background: transparent;
        }
        ::-webkit-scrollbar-thumb {
            background: var(--border-color);
            border-radius: 3px;
        }
        ::-webkit-scrollbar-thumb:hover {
            background: var(--border-hover);
        }

        .menu-chapter {
            display: flex;
            flex-direction: column;
            gap: 4px;
        }

        .chapter-heading {
            font-size: 13px;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 0.8px;
            color: var(--text-muted);
            padding: 6px 8px;
            cursor: pointer;
            display: flex;
            justify-content: space-between;
            align-items: center;
            border-radius: 4px;
            transition: color var(--transition-speed), background-color var(--transition-speed);
        }

        .chapter-heading:hover {
            color: var(--text-primary);
            background-color: var(--bg-tertiary);
        }

        .chapter-heading svg {
            transition: transform var(--transition-speed);
        }

        .chapter-heading.collapsed svg {
            transform: rotate(-90deg);
        }

        .chapter-items {
            display: flex;
            flex-direction: column;
            gap: 2px;
            padding-left: 8px;
            transition: max-height 0.3s ease, opacity 0.3s ease;
            overflow: hidden;
        }

        .chapter-items.collapsed {
            max-height: 0;
            opacity: 0;
            pointer-events: none;
        }

        .menu-link {
            font-size: 14px;
            color: var(--text-secondary);
            text-decoration: none;
            padding: 6px 12px;
            border-radius: 6px;
            display: flex;
            align-items: center;
            gap: 8px;
            transition: color var(--transition-speed), background-color var(--transition-speed);
        }

        .menu-link:hover {
            color: var(--text-primary);
            background-color: var(--bg-tertiary);
        }

        .menu-link.active {
            color: #ffffff;
            background: var(--accent-gradient);
            font-weight: 500;
            box-shadow: 0 4px 12px rgba(99, 102, 241, 0.15);
        }

        /* Sidebar Footer / Config */
        .sidebar-footer {
            padding: 16px 20px;
            border-top: 1px solid var(--border-color);
            display: flex;
            justify-content: space-between;
            align-items: center;
            background-color: var(--bg-secondary);
        }

        .theme-selector {
            display: flex;
            gap: 6px;
            background-color: var(--bg-primary);
            padding: 4px;
            border-radius: 8px;
            border: 1px solid var(--border-color);
        }

        .theme-btn {
            border: none;
            background: none;
            color: var(--text-muted);
            cursor: pointer;
            width: 28px;
            height: 28px;
            border-radius: 6px;
            display: flex;
            align-items: center;
            justify-content: center;
            transition: color var(--transition-speed), background-color var(--transition-speed);
        }

        .theme-btn:hover {
            color: var(--text-primary);
        }

        .theme-btn.active {
            background-color: var(--bg-tertiary);
            color: var(--accent-glow);
        }

        /* Main Scrollable Content Panel */
        main.main-content {
            margin-left: var(--sidebar-width);
            flex: 1;
            min-height: 100vh;
            display: flex;
            flex-direction: column;
            position: relative;
            background-color: var(--bg-primary);
            transition: margin var(--transition-speed) ease;
        }

        /* Top Sticky Floating Navbar */
        header.nav-header {
            position: sticky;
            top: 0;
            height: var(--header-height);
            background-color: var(--glass-bg);
            backdrop-filter: var(--glass-backdrop);
            -webkit-backdrop-filter: var(--glass-backdrop);
            border-bottom: 1px solid var(--border-color);
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 0 40px;
            z-index: 90;
            transition: background-color var(--transition-speed), border-color var(--transition-speed);
        }

        .btn-toggle-sidebar {
            display: none;
            background: none;
            border: 1px solid var(--border-color);
            color: var(--text-primary);
            width: 38px;
            height: 38px;
            border-radius: 8px;
            cursor: pointer;
            align-items: center;
            justify-content: center;
            transition: background-color var(--transition-speed);
        }

        .btn-toggle-sidebar:hover {
            background-color: var(--bg-tertiary);
        }

        .header-title-info {
            font-family: var(--font-heading);
            font-size: 16px;
            font-weight: 600;
            color: var(--text-secondary);
        }

        /* Content Container */
        .content-body {
            max-width: 900px;
            width: 100%;
            margin: 0 auto;
            padding: 40px 60px 80px 60px;
            flex: 1;
        }

        /* Markdown styling tags */
        .doc-main-title {
            font-family: var(--font-heading);
            font-size: 42px;
            font-weight: 800;
            line-height: 1.2;
            margin-bottom: 24px;
            background: var(--accent-gradient);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            letter-spacing: -1px;
        }

        .chapter-section {
            margin-top: 40px;
            margin-bottom: 80px;
            border-bottom: 1px solid var(--border-color);
            padding-bottom: 60px;
            content-visibility: auto;
            contain-intrinsic-size: 1000px;
        }

        .chapter-section:last-of-type {
            border-bottom: none;
            padding-bottom: 0;
        }

        .chapter-title {
            font-family: var(--font-heading);
            font-size: 32px;
            font-weight: 700;
            margin-top: 40px;
            margin-bottom: 24px;
            display: flex;
            flex-direction: column;
            gap: 8px;
            border-bottom: 1px solid var(--border-color);
            padding-bottom: 16px;
        }

        .chap-badge {
            font-family: var(--font-ui);
            font-size: 12px;
            text-transform: uppercase;
            font-weight: 700;
            letter-spacing: 1px;
            background: var(--accent-gradient);
            color: #ffffff;
            padding: 4px 10px;
            border-radius: 4px;
            width: fit-content;
        }

        .section-title {
            font-family: var(--font-heading);
            font-size: 24px;
            font-weight: 600;
            margin-top: 36px;
            margin-bottom: 16px;
            color: var(--text-primary);
        }

        .lesson-title {
            font-family: var(--font-heading);
            font-size: 18px;
            font-weight: 600;
            margin-top: 24px;
            margin-bottom: 12px;
            color: var(--text-primary);
        }

        .lesson-header {
            border-left: 3px solid var(--accent-primary);
            padding-left: 12px;
        }

        p {
            font-size: 16px;
            line-height: 1.7;
            color: var(--text-secondary);
            margin-bottom: 18px;
        }

        a {
            color: var(--accent-glow);
            text-decoration: none;
            border-bottom: 1px dashed rgba(99, 102, 241, 0.4);
            transition: color 0.15s, border-bottom-color 0.15s;
        }

        a:hover {
            color: var(--accent-primary);
            border-bottom-color: var(--accent-primary);
        }

        /* File Location Info */
        .file-location {
            display: inline-flex;
            align-items: center;
            gap: 6px;
            background-color: var(--bg-tertiary);
            padding: 6px 12px;
            border-radius: 6px;
            border: 1px solid var(--border-color);
            font-size: 13px;
            font-family: var(--font-code);
            margin-bottom: 16px;
            color: var(--text-secondary);
        }

        .file-location a {
            border: none;
            font-weight: 500;
        }

        /* Lists styling */
        ul, ol {
            margin-left: 24px;
            margin-bottom: 18px;
        }

        li {
            font-size: 16px;
            line-height: 1.7;
            color: var(--text-secondary);
            margin-bottom: 6px;
        }

        hr {
            border: none;
            border-top: 1px solid var(--border-color);
            margin: 40px 0;
        }

        blockquote {
            border-left: 4px solid var(--border-hover);
            padding: 8px 16px;
            margin-bottom: 18px;
            background-color: var(--bg-secondary);
            border-radius: 0 8px 8px 0;
            font-style: italic;
        }

        /* Enhanced GitHub style alerts */
        .alert {
            border-left: 4px solid var(--accent-primary);
            background-color: var(--bg-secondary);
            padding: 16px 20px;
            border-radius: 0 10px 10px 0;
            margin-bottom: 20px;
            border: 1px solid var(--border-color);
            border-left-width: 4px;
            transition: background-color var(--transition-speed), border-color var(--transition-speed);
        }

        .alert-title {
            display: flex;
            align-items: center;
            gap: 8px;
            font-weight: 700;
            font-size: 13px;
            margin-bottom: 8px;
            letter-spacing: 0.5px;
        }

        .alert-icon {
            fill: currentColor;
        }

        .alert-content p {
            margin-bottom: 0;
            font-size: 14.5px;
        }

        .alert-note {
            border-left-color: var(--color-note);
        }
        .alert-note .alert-title {
            color: var(--color-note);
        }
        
        .alert-tip {
            border-left-color: var(--color-tip);
        }
        .alert-tip .alert-title {
            color: var(--color-tip);
        }

        .alert-important {
            border-left-color: var(--color-important);
        }
        .alert-important .alert-title {
            color: var(--color-important);
        }

        .alert-warning {
            border-left-color: var(--color-warning);
        }
        .alert-warning .alert-title {
            color: var(--color-warning);
        }

        .alert-caution {
            border-left-color: var(--color-caution);
        }
        .alert-caution .alert-title {
            color: var(--color-caution);
        }

        /* Premium Code block layouts */
        .code-wrapper {
            background-color: var(--code-bg);
            border-radius: 10px;
            border: 1px solid var(--border-color);
            margin-bottom: 24px;
            overflow: hidden;
            box-shadow: var(--shadow-premium);
        }

        .code-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 8px 16px;
            background-color: rgba(255, 255, 255, 0.02);
            border-bottom: 1px solid var(--border-color);
        }

        .code-lang {
            font-family: var(--font-code);
            font-size: 12px;
            font-weight: 600;
            color: var(--text-muted);
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .code-actions {
            display: flex;
            gap: 8px;
        }

        .btn-copy, .btn-playground {
            background-color: rgba(255, 255, 255, 0.05);
            border: 1px solid var(--border-color);
            color: var(--text-secondary);
            padding: 4px 10px;
            border-radius: 6px;
            font-size: 12px;
            font-family: var(--font-ui);
            cursor: pointer;
            display: flex;
            align-items: center;
            gap: 6px;
            transition: background-color var(--transition-speed), color var(--transition-speed);
        }

        .btn-copy:hover, .btn-playground:hover {
            background-color: rgba(255, 255, 255, 0.1);
            color: var(--text-primary);
        }

        .btn-playground {
            background: var(--accent-gradient);
            color: #ffffff !important;
            border: none;
            font-weight: 600;
            box-shadow: 0 2px 8px rgba(99, 102, 241, 0.3);
        }

        .btn-playground:hover {
            box-shadow: 0 4px 12px rgba(99, 102, 241, 0.5);
            transform: translateY(-1px);
        }

        pre {
            padding: 16px 20px;
            overflow-x: auto;
            margin: 0;
            background: none !important;
        }

        code {
            font-family: var(--font-code);
            font-size: 14px;
            line-height: 1.5;
        }

        /* Inline code tag styling */
        p code, li code, td code {
            background-color: var(--bg-tertiary);
            padding: 2px 6px;
            border-radius: 4px;
            border: 1px solid var(--border-color);
            color: var(--text-primary);
        }

        /* Search Results Overlay */
        .search-results-overlay {
            position: absolute;
            top: var(--header-height);
            left: 0;
            width: 100%;
            height: calc(100vh - var(--header-height));
            background-color: var(--bg-primary);
            z-index: 85;
            display: none;
            overflow-y: auto;
            padding: 40px 60px;
        }

        .search-results-title {
            font-family: var(--font-heading);
            font-size: 28px;
            font-weight: 700;
            margin-bottom: 24px;
            color: var(--text-primary);
        }

        .search-result-item {
            background-color: var(--bg-secondary);
            border: 1px solid var(--border-color);
            border-radius: 10px;
            padding: 20px;
            margin-bottom: 16px;
            cursor: pointer;
            transition: border-color var(--transition-speed), transform var(--transition-speed), box-shadow var(--transition-speed);
        }

        .search-result-item:hover {
            border-color: var(--accent-primary);
            transform: translateY(-2px);
            box-shadow: var(--shadow-premium);
        }

        .result-meta {
            display: flex;
            gap: 12px;
            align-items: center;
            margin-bottom: 8px;
        }

        .result-type {
            font-size: 11px;
            font-weight: 700;
            text-transform: uppercase;
            background-color: var(--bg-tertiary);
            color: var(--accent-glow);
            padding: 2px 8px;
            border-radius: 4px;
        }

        .result-path {
            font-size: 12px;
            color: var(--text-muted);
        }

        .result-title {
            font-family: var(--font-heading);
            font-size: 18px;
            font-weight: 600;
            margin-bottom: 8px;
            color: var(--text-primary);
        }

        .result-snippet {
            font-size: 14px;
            color: var(--text-secondary);
            line-height: 1.5;
        }

        .result-snippet mark {
            background-color: rgba(99, 102, 241, 0.3);
            color: var(--text-primary);
            border-radius: 2px;
            padding: 0 2px;
        }

        .no-results {
            text-align: center;
            padding: 60px 0;
            color: var(--text-muted);
            font-size: 16px;
        }

        /* Back to top button */
        .btn-top {
            position: fixed;
            bottom: 30px;
            right: 30px;
            width: 44px;
            height: 44px;
            border-radius: 50%;
            background: var(--accent-gradient);
            color: #ffffff;
            border: none;
            cursor: pointer;
            box-shadow: var(--shadow-premium);
            display: flex;
            align-items: center;
            justify-content: center;
            z-index: 95;
            opacity: 0;
            visibility: hidden;
            transition: opacity var(--transition-speed), visibility var(--transition-speed), transform var(--transition-speed);
        }

        .btn-top:hover {
            transform: translateY(-3px);
        }

        .btn-top.visible {
            opacity: 1;
            visibility: visible;
        }

        /* Mobile adjustments */
        @media (max-width: 1024px) {
            aside.sidebar {
                transform: translateX(-100%);
            }

            aside.sidebar.open {
                transform: translateX(0);
            }

            main.main-content {
                margin-left: 0;
            }

            .btn-toggle-sidebar {
                display: flex;
            }

            .content-body {
                padding: 30px 24px;
            }

            header.nav-header {
                padding: 0 24px;
            }
        }
    </style>
</head>
<body>
    <div class="progress-container">
        <div class="progress-bar" id="readingProgress"></div>
    </div>
    
    <div class="app-container">
        <!-- Sidebar Navigation -->
        <aside class="sidebar" id="sidebar">
            <div class="sidebar-header">
                <div class="logo-area">
                    <div class="logo-v">V</div>
                    <span class="logo-title">V Language Guide</span>
                </div>
                <div class="search-container">
                    <svg class="search-icon" viewBox="0 0 24 24" width="16" height="16" stroke="currentColor" stroke-width="2" fill="none"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg>
                    <input type="text" class="search-input" id="searchInput" placeholder="Search lessons, syntax...">
                </div>
            </div>
            
            <nav class="sidebar-menu" id="sidebarMenu">
                <!-- Will be populated dynamically via JavaScript -->
            </nav>
            
            <div class="sidebar-footer">
                <div class="theme-selector">
                    <button class="theme-btn active" onclick="setTheme('dark')" title="Dark Theme" id="theme-dark">
                        <svg viewBox="0 0 24 24" width="16" height="16" stroke="currentColor" stroke-width="2" fill="none"><path d="M21 12.79A9 9 0 1 1 11.21 3 7 7 0 0 0 21 12.79z"></path></svg>
                    </button>
                    <button class="theme-btn" onclick="setTheme('light')" title="Light Theme" id="theme-light">
                        <svg viewBox="0 0 24 24" width="16" height="16" stroke="currentColor" stroke-width="2" fill="none"><circle cx="12" cy="12" r="5"></circle><line x1="12" y1="1" x2="12" y2="3"></line><line x1="12" y1="21" x2="12" y2="23"></line><line x1="4.22" y1="4.22" x2="5.64" y2="5.64"></line><line x1="18.36" y1="18.36" x2="19.78" y2="19.78"></line><line x1="1" y1="12" x2="3" y2="12"></line><line x1="21" y1="12" x2="23" y2="12"></line><line x1="4.22" y1="19.78" x2="5.64" y2="18.36"></line><line x1="18.36" y1="5.64" x2="19.78" y2="4.22"></line></svg>
                    </button>
                    <button class="theme-btn" onclick="setTheme('cyberpunk')" title="Neon Cyberpunk" id="theme-cyberpunk">
                        <svg viewBox="0 0 24 24" width="16" height="16" stroke="currentColor" stroke-width="2" fill="none"><polygon points="13 2 3 14 12 14 11 22 21 10 12 10 13 2"></polygon></svg>
                    </button>
                </div>
            </div>
        </aside>
        
        <!-- Main Content -->
        <main class="main-content">
            <header class="nav-header">
                <button class="btn-toggle-sidebar" id="toggleSidebarBtn">
                    <svg viewBox="0 0 24 24" width="24" height="24" stroke="currentColor" stroke-width="2" fill="none"><line x1="3" y1="12" x2="21" y2="12"></line><line x1="3" y1="6" x2="21" y2="6"></line><line x1="3" y1="18" x2="21" y2="18"></line></svg>
                </button>
                <div class="header-title-info" id="currentSectionTitle">Welcome</div>
                <div class="header-actions"></div>
            </header>
            
            <!-- Global Search Overlay -->
            <div class="search-results-overlay" id="searchResultsOverlay">
                <div class="search-results-title" id="resultsSummary">Search Results</div>
                <div id="resultsList"></div>
            </div>
            
            <div class="content-body" id="contentBody">
                ${contentHtml}
            </div>
        </main>
    </div>
    
    <button class="btn-top" id="btnTop" onclick="scrollToTop()" title="Back to Top">
        <svg viewBox="0 0 24 24" width="20" height="20" stroke="currentColor" stroke-width="2.5" fill="none"><line x1="12" y1="19" x2="12" y2="5"></line><polyline points="5 12 12 5 19 12"></polyline></svg>
    </button>
    
    <!-- Prism Syntax Highlighting -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/prism/1.29.0/components/prism-core.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/prism/1.29.0/plugins/autoloader/prism-autoloader.min.js"></script>
    
    <script>
        // Inject structure and search index JSON
        const bookStructure = ${structureJson};
        const searchIndex = ${searchIndexJson};
        
        // Theme Management
        function setTheme(theme) {
            document.documentElement.setAttribute('data-theme', theme);
            localStorage.setItem('theme', theme);
            
            document.querySelectorAll('.theme-btn').forEach(btn => {
                btn.classList.remove('active');
            });
            document.getElementById('theme-' + theme).classList.add('active');
        }
        
        // Init Theme
        const savedTheme = localStorage.getItem('theme') || 'dark';
        setTheme(savedTheme);
        
        // Populate Sidebar menu
        const menuEl = document.getElementById('sidebarMenu');
        bookStructure.forEach(chap => {
            const chapDiv = document.createElement('div');
            chapDiv.className = 'menu-chapter';
            chapDiv.dataset.title = chap.title.toLowerCase();
            
            const heading = document.createElement('div');
            heading.className = 'chapter-heading';
            heading.innerHTML = \`<span>Chapter \${chap.number || ''}: \${chap.title}</span>
                <svg viewBox="0 0 24 24" width="12" height="12" stroke="currentColor" stroke-width="3" fill="none"><polyline points="6 9 12 15 18 9"></polyline></svg>\`;
            
            const itemsDiv = document.createElement('div');
            itemsDiv.className = 'chapter-items';
            
            // Toggle collapse
            heading.addEventListener('click', () => {
                const isCollapsed = itemsDiv.classList.toggle('collapsed');
                heading.classList.toggle('collapsed', isCollapsed);
            });
            
            chap.sections.forEach(sec => {
                const link = document.createElement('a');
                link.href = '#' + sec.id;
                link.className = 'menu-link';
                link.dataset.target = sec.id;
                link.dataset.title = sec.title.toLowerCase();
                link.innerHTML = \`<svg viewBox="0 0 24 24" width="14" height="14" stroke="currentColor" stroke-width="2" fill="none"><path d="M12 2L2 7l10 5 10-5-10-5zM2 17l10 5 10-5M2 12l10 5 10-5"></path></svg>\${sec.title}\`;
                
                link.addEventListener('click', (e) => {
                    if (window.innerWidth <= 1024) {
                        document.getElementById('sidebar').classList.remove('open');
                    }
                });
                
                itemsDiv.appendChild(link);
            });
            
            chapDiv.appendChild(heading);
            chapDiv.appendChild(itemsDiv);
            menuEl.appendChild(chapDiv);
        });
        
        // Mobile Sidebar toggler
        const sidebar = document.getElementById('sidebar');
        const toggleBtn = document.getElementById('toggleSidebarBtn');
        toggleBtn.addEventListener('click', () => {
            sidebar.classList.toggle('open');
        });
        
        // Scroll / Reading progress & Sidebar active link highlight
        const progress = document.getElementById('readingProgress');
        const btnTop = document.getElementById('btnTop');
        const currentSectionTitleEl = document.getElementById('currentSectionTitle');
        
        window.addEventListener('scroll', () => {
            const totalHeight = document.documentElement.scrollHeight - window.innerHeight;
            if (totalHeight > 0) {
                const scrolled = (window.scrollY / totalHeight) * 100;
                progress.style.width = scrolled + '%';
            }
            
            if (window.scrollY > 300) {
                btnTop.classList.add('visible');
            } else {
                btnTop.classList.remove('visible');
            }
            
            // Highlight active navigation section
            const sections = document.querySelectorAll('h2.section-title, h1.chapter-title');
            let activeId = '';
            let currentTitle = 'Welcome';
            
            sections.forEach(sec => {
                const rect = sec.getBoundingClientRect();
                if (rect.top < 120) {
                    activeId = sec.id;
                    currentTitle = sec.innerText.replace(/Chapter \\d+:/i, '').trim();
                }
            });
            
            if (activeId) {
                document.querySelectorAll('.menu-link').forEach(link => {
                    if (link.dataset.target === activeId || link.getAttribute('href') === '#' + activeId) {
                        link.classList.add('active');
                    } else {
                        link.classList.remove('active');
                    }
                });
                currentSectionTitleEl.innerText = currentTitle;
            }
        });
        
        function scrollToTop() {
            window.scrollTo({ top: 0, behavior: 'smooth' });
        }
        
        // Search functionality
        const searchInput = document.getElementById('searchInput');
        const overlay = document.getElementById('searchResultsOverlay');
        const resultsList = document.getElementById('resultsList');
        const resultsSummary = document.getElementById('resultsSummary');
        
        searchInput.addEventListener('input', (e) => {
            const query = e.target.value.toLowerCase().trim();
            
            // 1. Filter Left Sidebar Table of Contents
            if (query.length === 0) {
                document.querySelectorAll('.menu-chapter').forEach(chapDiv => {
                    chapDiv.style.display = '';
                    const heading = chapDiv.querySelector('.chapter-heading');
                    const itemsDiv = chapDiv.querySelector('.chapter-items');
                    itemsDiv.classList.remove('collapsed');
                    heading.classList.remove('collapsed');
                    
                    chapDiv.querySelectorAll('.menu-link').forEach(link => {
                        link.style.display = '';
                    });
                });
                overlay.style.display = 'none';
                return;
            }
            
            document.querySelectorAll('.menu-chapter').forEach(chapDiv => {
                const chapTitle = chapDiv.dataset.title || '';
                const heading = chapDiv.querySelector('.chapter-heading');
                const itemsDiv = chapDiv.querySelector('.chapter-items');
                let hasVisibleLink = false;
                
                chapDiv.querySelectorAll('.menu-link').forEach(link => {
                    const linkTitle = link.dataset.title || '';
                    if (linkTitle.includes(query) || chapTitle.includes(query)) {
                        link.style.display = '';
                        hasVisibleLink = true;
                    } else {
                        link.style.display = 'none';
                    }
                });
                
                if (hasVisibleLink || chapTitle.includes(query)) {
                    chapDiv.style.display = '';
                    itemsDiv.classList.remove('collapsed');
                    heading.classList.remove('collapsed');
                } else {
                    chapDiv.style.display = 'none';
                }
            });
            
            // 2. Perform global search and display overlay (min 2 chars)
            if (query.length < 2) {
                overlay.style.display = 'none';
                return;
            }
            
            overlay.style.display = 'block';
            const hits = [];
            
            searchIndex.forEach(item => {
                const titleIndex = item.title.toLowerCase().indexOf(query);
                const contentIndex = item.content.toLowerCase().indexOf(query);
                
                if (titleIndex !== -1 || contentIndex !== -1) {
                    // Extract a snippet around the match
                    let snippet = '';
                    if (contentIndex !== -1) {
                        const start = Math.max(0, contentIndex - 40);
                        const end = Math.min(item.content.length, contentIndex + 100);
                        snippet = item.content.substring(start, end);
                        
                        // Highlight
                        const regex = new RegExp('(' + escapeRegExp(query) + ')', 'gi');
                        snippet = snippet.replace(regex, '<mark>$1</mark>');
                        
                        if (start > 0) snippet = '...' + snippet;
                        if (end < item.content.length) snippet = snippet + '...';
                    } else {
                        snippet = item.content.substring(0, 100) + '...';
                    }
                    
                    hits.push({
                        ...item,
                        snippet,
                        score: titleIndex !== -1 ? 10 : 1 // Prioritize title matches
                    });
                }
            });
            
            hits.sort((a, b) => b.score - a.score);
            
            resultsSummary.innerText = \`Search Results (\${hits.length} found)\`;
            resultsList.innerHTML = '';
            
            if (hits.length === 0) {
                resultsList.innerHTML = '<div class="no-results">No matches found. Try searching another term like "variables", "struct", or "channel".</div>';
                return;
            }
            
            hits.forEach(hit => {
                const itemDiv = document.createElement('div');
                itemDiv.className = 'search-result-item';
                
                let pathStr = hit.chapter || '';
                if (hit.section) pathStr += ' > ' + hit.section;
                
                itemDiv.innerHTML = \`
                    <div class="result-meta">
                        <span class="result-type">\${hit.type}</span>
                        <span class="result-path">\${pathStr}</span>
                    </div>
                    <div class="result-title">\${hit.title}</div>
                    <div class="result-snippet">\${hit.snippet}</div>
                \`;
                
                itemDiv.addEventListener('click', () => {
                    overlay.style.display = 'none';
                    searchInput.value = '';
                    
                    // Reset sidebar filter so rest of items are visible
                    document.querySelectorAll('.menu-chapter').forEach(chapDiv => {
                        chapDiv.style.display = '';
                        chapDiv.querySelectorAll('.menu-link').forEach(link => {
                            link.style.display = '';
                        });
                    });
                    
                    window.location.hash = hit.id;
                });
                
                resultsList.appendChild(itemDiv);
            });
        });
        
        function escapeRegExp(string) {
            return string.replace(/[.*+?^\${}()|[\\]\\\\]/g, '\\\\$&');
        }
        
        // Copy Code utility
        function copyCode(btn) {
            const codeBlock = btn.closest('.code-wrapper').querySelector('code');
            const range = document.createRange();
            
            navigator.clipboard.writeText(codeBlock.innerText).then(() => {
                const originalText = btn.innerHTML;
                btn.innerHTML = \`<svg viewBox="0 0 24 24" width="16" height="16" stroke="currentColor" stroke-width="2" fill="none"><polyline points="20 6 9 17 4 12"></polyline></svg> Copied!\`;
                btn.style.color = '#34d399';
                setTimeout(() => {
                    btn.innerHTML = originalText;
                    btn.style.color = '';
                }, 2000);
            }).catch(err => {
                console.error('Failed to copy text: ', err);
            });
        }
    </script>
</body>
</html>`;

fs.writeFileSync(destPath, template, 'utf8');
console.log('Build completed successfully! Docs output to docs/index.html');
