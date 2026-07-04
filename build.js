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
            let parsedContent = '';
            let blockCodeContent = [];
            let inBlockCode = false;
            let blockCodeLanguage = '';

            for (let j = 0; j < blockquoteContent.length; j++) {
                const bLine = blockquoteContent[j];
                const trimmedBLine = bLine.trim();
                
                if (trimmedBLine.startsWith('```')) {
                    if (inBlockCode) {
                        // End code block inside blockquote
                        const codeStr = blockCodeContent.join('\n');
                        parsedContent += generateCodeBlockHtml(blockCodeLanguage, codeStr);
                        inBlockCode = false;
                        blockCodeContent = [];
                    } else {
                        // Start code block inside blockquote
                        inBlockCode = true;
                        blockCodeLanguage = trimmedBLine.substring(3).trim();
                    }
                } else if (inBlockCode) {
                    blockCodeContent.push(bLine);
                } else {
                    // Regular line, wrap in <p> if not empty
                    if (trimmedBLine !== '') {
                        parsedContent += `<p>${parseInline(bLine)}</p>\n`;
                    }
                }
            }

            if (inBlockCode && blockCodeContent.length > 0) {
                const codeStr = blockCodeContent.join('\n');
                parsedContent += generateCodeBlockHtml(blockCodeLanguage, codeStr);
            }

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
            case 'exercise':
                return '<path d="M8 1.5A6.5 6.5 0 1 0 14.5 8 6.507 6.507 0 0 0 8 1.5Zm.75 3.25a.75.75 0 0 1-1.5 0V8a.75.75 0 0 1 1.5 0Zm0 4.5a.75.75 0 1 1-1.5 0 .75.75 0 0 1 1.5 0Z"></path>';
            case 'solution':
                return '<path d="M13.78 4.22a.75.75 0 0 1 0 1.06L6.56 12.5a.75.75 0 0 1-1.06 0l-3.5-3.5a.75.75 0 1 1 1.06-1.06l2.97 2.97 6.97-8.97a.75.75 0 0 1 1.06 0Z"></path>';
            case 'output':
                return '<path d="M5.75 3a.75.75 0 0 0 0 1.5h4.5A.75.75 0 0 0 10.25 3h-4.5Zm-2.5 4.5A.75.75 0 0 0 3 8.25v3.5a.75.75 0 0 0 1.5 0v-3.5Zm7.5 0A.75.75 0 0 0 10.5 8.25v3.5a.75.75 0 0 0 1.5 0v-3.5ZM8 10.25a.75.75 0 0 1 .75.75v1.5a.75.75 0 0 1-1.5 0v-1.5A.75.75 0 0 1 8 10.25Z"></path>';
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

    function normalizeCodeLanguage(language) {
        const normalized = (language || 'text').toLowerCase();
        return normalized === 'vlang' ? 'v' : normalized;
    }

    function generateCodeBlockHtml(codeLanguage, codeStr) {
        let codeHtml = escapeHtml(codeStr);
        let playgroundBtn = '';
        if (codeLanguage.toLowerCase() === 'v' || codeLanguage.toLowerCase() === 'vlang') {
            const base64Code = Buffer.from(codeStr).toString('base64');
            const playgroundUrl = `https://play.vlang.io/?base64=${encodeURIComponent(base64Code)}`;
            playgroundBtn = `<a href="${playgroundUrl}" target="_blank" class="btn-playground" title="Run in V Playground">
                <svg viewBox="0 0 24 24" width="16" height="16" stroke="currentColor" stroke-width="2" fill="none" stroke-linecap="round" stroke-linejoin="round"><polygon points="5 3 19 12 5 21 5 3"></polygon></svg>
                Run
            </a>
            <button class="btn-playground-copy" onclick="copyAndOpenPlayground(this)" title="Copy Code & Open V Playground">
                <svg viewBox="0 0 24 24" width="16" height="16" stroke="currentColor" stroke-width="2" fill="none" stroke-linecap="round" stroke-linejoin="round"><rect x="9" y="9" width="13" height="13" rx="2" ry="2"></rect><path d="M5 15H4a2 2 0 0 1-2-2V4a2 2 0 0 1 2-2h9a2 2 0 0 1 2 2v1"></path></svg>
                Copy &amp; Open
            </button>`;
        }

        const normalizedLanguage = normalizeCodeLanguage(codeLanguage);
        return `<div class="code-wrapper">
            <div class="code-header">
                <span class="code-lang">${codeLanguage || 'text'}</span>
                <div class="code-actions">
                    ${playgroundBtn}
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
            <pre><code class="language-${normalizedLanguage}">${codeHtml}</code></pre>
        </div>\n`;
    }

    function normalizeTitleForComparison(text) {
        return text
            .replace(/^Lesson:\s*/i, '')
            .replace(/\s*\([^)]+\)\s*$/, '')
            .toLowerCase()
            .replace(/[^\w\s-]/g, '')
            .replace(/\s+/g, ' ')
            .trim();
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
                html += generateCodeBlockHtml(codeLanguage, codeStr);

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
            } else if (cleanLine.startsWith('[!EXERCISE]')) {
                alertType = 'exercise';
                cleanLine = cleanLine.substring(11).trim();
            } else if (cleanLine.startsWith('[!SOLUTION]')) {
                alertType = 'solution';
                cleanLine = cleanLine.substring(11).trim();
            } else if (cleanLine.startsWith('[!OUTPUT]')) {
                alertType = 'output';
                cleanLine = cleanLine.substring(9).trim();
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
                    
                    html += `</section>\n<section id="chap-wrapper-${slug}" class="chapter-section" data-chapter-id="${slug}">\n`;
                    html += `<h1 class="chapter-title" id="${slug}" data-chapter-id="${slug}"><span class="chap-badge">Chapter ${chapNum}</span> ${escapeHtml(chapName)}</h1>\n`;
                    
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

                html += `<h2 class="section-title" id="${slug}" data-chapter-id="${currentChapter ? currentChapter.id : ''}">${escapeHtml(title)}</h2>\n`;
                
                searchIndex.push({
                    id: `${slug}`,
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

                // Check if this is a duplicate of the last lesson in the current section
                let duplicateLesson = null;
                if (currentSection && currentSection.lessons.length > 0) {
                    const lastLesson = currentSection.lessons[currentSection.lessons.length - 1];
                    if (normalizeTitleForComparison(lastLesson.title) === normalizeTitleForComparison(title)) {
                        duplicateLesson = lastLesson;
                    }
                }

                if (duplicateLesson) {
                    // Update duplicate lesson's title if this is a cleaner lesson header (with "Lesson:")
                    if (isLesson) {
                        duplicateLesson.title = cleanTitle;
                    }
                    // Keep currentLesson pointing to the existing duplicate so content appends to it
                    currentLesson = duplicateLesson;

                    // Render with .lesson-subtitle instead of .lesson-title to keep scroll active highlighting and navigation builder correct
                    const lessonClass = isLesson ? ' lesson-header' : '';
                    html += `<h3 class="lesson-subtitle${lessonClass}" id="${slug}" data-chapter-id="${currentChapter ? currentChapter.id : ''}">
                        <span>${escapeHtml(cleanTitle)}</span>
                        <button class="btn-bookmark" data-id="${slug}" onclick="toggleBookmark('${slug}', '${escapeHtml(cleanTitle).replace(/'/g, "\\'")}')" title="Bookmark lesson">
                            <svg class="bookmark-icon" viewBox="0 0 24 24" width="16" height="16" stroke="currentColor" stroke-width="2" fill="none"><path d="M19 21l-7-5-7 5V5a2 2 0 0 1 2-2h10a2 2 0 0 1 2 2z"></path></svg>
                        </button>
                    </h3>\n`;
                } else {
                    currentLesson = {
                        id: slug,
                        title: cleanTitle,
                        content: ''
                    };

                    if (currentSection) {
                        currentSection.lessons.push(currentLesson);
                    }

                    const lessonClass = isLesson ? ' lesson-header' : '';
                    html += `<h3 class="lesson-title${lessonClass}" id="${slug}" data-chapter-id="${currentChapter ? currentChapter.id : ''}">
                        <span>${escapeHtml(cleanTitle)}</span>
                        <button class="btn-bookmark" data-id="${slug}" onclick="toggleBookmark('${slug}', '${escapeHtml(cleanTitle).replace(/'/g, "\\'")}')" title="Bookmark lesson">
                            <svg class="bookmark-icon" viewBox="0 0 24 24" width="16" height="16" stroke="currentColor" stroke-width="2" fill="none"><path d="M19 21l-7-5-7 5V5a2 2 0 0 1 2-2h10a2 2 0 0 1 2 2z"></path></svg>
                        </button>
                    </h3>\n`;
                    
                    searchIndex.push({
                        id: `${slug}`,
                        title: cleanTitle,
                        type: 'lesson',
                        content: cleanTitle,
                        chapter: currentChapter ? currentChapter.title : '',
                        section: currentSection ? currentSection.title : ''
                    });
                }
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
    <!-- Favicon -->
    <link rel="icon" type="image/svg+xml" href="favicon.svg">
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
            --content-pad: 60px;

            
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

        /* Forest Theme overrides */
        html[data-theme="forest"] {
            --bg-primary: #0a0e0a;
            --bg-secondary: #101611;
            --bg-tertiary: #172219;
            
            --text-primary: #ecfdf5;
            --text-secondary: #a7f3d0;
            --text-muted: #6ee7b7;
            
            --accent-primary: #10b981;
            --accent-glow: #34d399;
            --accent-gradient: linear-gradient(135deg, #10b981 0%, #059669 100%);
            
            --border-color: #1a261c;
            --border-hover: #34d399;
            
            --code-bg: #050805;
            --glass-bg: rgba(16, 22, 17, 0.85);
            --shadow-premium: 0 10px 25px -5px rgba(0, 0, 0, 0.4), 0 8px 10px -6px rgba(0, 0, 0, 0.4);
        }

        /* Amber Theme overrides */
        html[data-theme="amber"] {
            --bg-primary: #f8efe1;
            --bg-secondary: #f1dfbf;
            --bg-tertiary: #e8ceb0;
            
            --text-primary: #4a2f1b;
            --text-secondary: #775537;
            --text-muted: #926a3e;
            
            --accent-primary: #b96b10;
            --accent-glow: #d58a20;
            --accent-gradient: linear-gradient(135deg, #f2b24c 0%, #b96b10 100%);
            
            --border-color: #e4caa3;
            --border-hover: #b96b10;
            
            --code-bg: #24170d;
            --glass-bg: rgba(241, 223, 191, 0.86);
            --shadow-premium: 0 14px 32px -10px rgba(185, 107, 16, 0.2), 0 8px 16px -10px rgba(74, 47, 27, 0.16);
        }

        /* Ocean Theme overrides */
        html[data-theme="ocean"] {
            --bg-primary: #050b14;
            --bg-secondary: #0c1524;
            --bg-tertiary: #132135;
            
            --text-primary: #e0f2fe;
            --text-secondary: #7dd3fc;
            --text-muted: #38bdf8;
            
            --accent-primary: #0ea5e9;
            --accent-glow: #06b6d4;
            --accent-gradient: linear-gradient(135deg, #0ea5e9 0%, #06b6d4 100%);
            
            --border-color: #172c44;
            --border-hover: #0ea5e9;
            
            --code-bg: #02070e;
            --glass-bg: rgba(12, 21, 36, 0.85);
            --shadow-premium: 0 10px 25px -5px rgba(0, 0, 0, 0.4), 0 8px 10px -6px rgba(0, 0, 0, 0.4);
        }

        /* Rose Theme overrides */
        html[data-theme="rose"] {
            --bg-primary: #180c14;
            --bg-secondary: #24131f;
            --bg-tertiary: #311a2b;
            
            --text-primary: #fff1f7;
            --text-secondary: #f9a8d4;
            --text-muted: #f472b6;
            
            --accent-primary: #f472b6;
            --accent-glow: #ec4899;
            --accent-gradient: linear-gradient(135deg, #f472b6 0%, #ec4899 100%);
            
            --border-color: #4a2438;
            --border-hover: #f472b6;
            
            --code-bg: #11080f;
            --glass-bg: rgba(36, 19, 31, 0.86);
            --shadow-premium: 0 10px 25px -5px rgba(0, 0, 0, 0.35), 0 8px 10px -6px rgba(0, 0, 0, 0.25);
        }

        /* Lavender Theme overrides */
        html[data-theme="lavender"] {
            --bg-primary: #140f22;
            --bg-secondary: #1d1630;
            --bg-tertiary: #292042;
            
            --text-primary: #f5f3ff;
            --text-secondary: #c4b5fd;
            --text-muted: #8b5cf6;
            
            --accent-primary: #8b5cf6;
            --accent-glow: #a78bfa;
            --accent-gradient: linear-gradient(135deg, #8b5cf6 0%, #a78bfa 100%);
            
            --border-color: #3d2f58;
            --border-hover: #8b5cf6;
            
            --code-bg: #0d0a16;
            --glass-bg: rgba(29, 22, 48, 0.86);
            --shadow-premium: 0 10px 25px -5px rgba(0, 0, 0, 0.35), 0 8px 10px -6px rgba(0, 0, 0, 0.25);
        }

        /* Sunset Theme overrides */
        html[data-theme="sunset"] {
            --bg-primary: #1a0f0a;
            --bg-secondary: #2a1710;
            --bg-tertiary: #3b2218;
            
            --text-primary: #fff7ed;
            --text-secondary: #fdba74;
            --text-muted: #fb923c;
            
            --accent-primary: #fb923c;
            --accent-glow: #f97316;
            --accent-gradient: linear-gradient(135deg, #fb923c 0%, #f97316 100%);
            
            --border-color: #57311f;
            --border-hover: #fb923c;
            
            --code-bg: #120906;
            --glass-bg: rgba(42, 23, 16, 0.86);
            --shadow-premium: 0 10px 25px -5px rgba(0, 0, 0, 0.35), 0 8px 10px -6px rgba(0, 0, 0, 0.25);
        }

        /* Mint Theme overrides */
        html[data-theme="mint"] {
            --bg-primary: #07150f;
            --bg-secondary: #0f241f;
            --bg-tertiary: #183731;
            
            --text-primary: #f0fdf4;
            --text-secondary: #86efac;
            --text-muted: #34d399;
            
            --accent-primary: #34d399;
            --accent-glow: #10b981;
            --accent-gradient: linear-gradient(135deg, #34d399 0%, #10b981 100%);
            
            --border-color: #225041;
            --border-hover: #34d399;
            
            --code-bg: #030b09;
            --glass-bg: rgba(15, 36, 31, 0.86);
            --shadow-premium: 0 10px 25px -5px rgba(0, 0, 0, 0.35), 0 8px 10px -6px rgba(0, 0, 0, 0.25);
        }

        /* Aurora Theme overrides */
        html[data-theme="aurora"] {
            --bg-primary: #060816;
            --bg-secondary: #10192d;
            --bg-tertiary: #1a2850;
            
            --text-primary: #f4fbff;
            --text-secondary: #95c9ff;
            --text-muted: #6ca8f5;
            
            --accent-primary: #22d3ee;
            --accent-glow: #38bdf8;
            --accent-gradient: linear-gradient(135deg, #22d3ee 0%, #818cf8 100%);
            
            --border-color: #22355c;
            --border-hover: #38bdf8;
            
            --code-bg: #030611;
            --glass-bg: rgba(16, 25, 45, 0.88);
            --shadow-premium: 0 14px 32px -8px rgba(34, 211, 238, 0.18), 0 8px 16px -10px rgba(15, 23, 42, 0.35);
        }

        /* Plum Theme overrides */
        html[data-theme="plum"] {
            --bg-primary: #130b17;
            --bg-secondary: #22152b;
            --bg-tertiary: #301b3d;
            
            --text-primary: #fbefff;
            --text-secondary: #d8b4fe;
            --text-muted: #a78bfa;
            
            --accent-primary: #c084fc;
            --accent-glow: #f0abfc;
            --accent-gradient: linear-gradient(135deg, #c084fc 0%, #f472b6 100%);
            
            --border-color: #47304f;
            --border-hover: #c084fc;
            
            --code-bg: #0b0711;
            --glass-bg: rgba(34, 21, 43, 0.88);
            --shadow-premium: 0 14px 32px -8px rgba(192, 132, 252, 0.2), 0 8px 16px -10px rgba(19, 11, 23, 0.35);
        }

        /* Ember Theme overrides */
        html[data-theme="ember"] {
            --bg-primary: #130c09;
            --bg-secondary: #23130d;
            --bg-tertiary: #341d13;
            
            --text-primary: #fff6eb;
            --text-secondary: #ffd0a7;
            --text-muted: #ffb073;
            
            --accent-primary: #ff7a1a;
            --accent-glow: #ff9f43;
            --accent-gradient: linear-gradient(135deg, #ffb56b 0%, #d9480f 100%);
            
            --border-color: #553123;
            --border-hover: #ff7a1a;
            
            --code-bg: #0b0603;
            --glass-bg: rgba(35, 19, 13, 0.9);
            --shadow-premium: 0 16px 36px -10px rgba(255, 122, 26, 0.24), 0 8px 18px -10px rgba(12, 7, 4, 0.35);
        }

        /* Glacier Theme overrides */
        html[data-theme="glacier"] {
            --bg-primary: #07131c;
            --bg-secondary: #10253a;
            --bg-tertiary: #193b53;
            
            --text-primary: #f4fbff;
            --text-secondary: #cceeff;
            --text-muted: #83d6f7;
            
            --accent-primary: #4cc9ff;
            --accent-glow: #6fe4ff;
            --accent-gradient: linear-gradient(135deg, #7edcff 0%, #2563eb 100%);
            
            --border-color: #244e68;
            --border-hover: #5ac8ff;
            
            --code-bg: #030b12;
            --glass-bg: rgba(16, 37, 58, 0.88);
            --shadow-premium: 0 16px 36px -10px rgba(76, 201, 255, 0.2), 0 8px 18px -10px rgba(5, 17, 27, 0.35);
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

        .sidebar-actions {
            display: flex;
            align-items: center;
            gap: 8px;
            flex-wrap: wrap;
        }

        .sidebar-action-btn {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            min-width: 34px;
            height: 34px;
            padding: 0 10px;
            border-radius: 999px;
            border: 1px solid var(--border-color);
            background: var(--bg-primary);
            color: var(--text-secondary);
            cursor: pointer;
            transition: background-color var(--transition-speed), color var(--transition-speed), border-color var(--transition-speed), transform var(--transition-speed);
        }

        .sidebar-action-btn:hover {
            background: var(--bg-tertiary);
            color: var(--text-primary);
            border-color: var(--accent-primary);
            transform: translateY(-1px);
        }

        .sidebar-action-btn:active {
            transform: translateY(0);
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
            margin-bottom: 4px;
        }

        .search-input {
            width: 100%;
            min-height: 44px;
            padding: 10px 40px 10px 36px;
            border-radius: 8px;
            border: 1px solid var(--border-color);
            background-color: var(--bg-primary);
            color: var(--text-primary);
            font-family: var(--font-ui);
            font-size: 14px;
            outline: none;
            box-sizing: border-box;
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

        .search-clear-btn {
            position: absolute;
            right: 8px;
            top: 50%;
            transform: translateY(-50%);
            width: 28px;
            height: 28px;
            border: none;
            border-radius: 999px;
            background: transparent;
            color: var(--text-muted);
            cursor: pointer;
            display: none;
            align-items: center;
            justify-content: center;
            transition: background-color var(--transition-speed), color var(--transition-speed);
        }

        .search-clear-btn:hover {
            background-color: var(--bg-tertiary);
            color: var(--text-primary);
        }

        .search-clear-btn.visible {
            display: inline-flex;
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

        .menu-section-wrapper {
            display: flex;
            flex-direction: column;
        }

        .section-lessons {
            display: flex;
            flex-direction: column;
            gap: 2px;
            padding-left: 20px;
            margin-top: 2px;
            margin-bottom: 4px;
            transition: max-height 0.3s ease, opacity 0.3s ease;
            overflow: hidden;
        }

        .section-lessons.collapsed {
            max-height: 0;
            opacity: 0;
            pointer-events: none;
            margin-top: 0;
            margin-bottom: 0;
        }

        .menu-lesson-link {
            font-size: 13px;
            color: var(--text-secondary);
            text-decoration: none;
            padding: 5px 10px;
            border-radius: 4px;
            display: flex;
            align-items: center;
            gap: 6px;
            transition: color var(--transition-speed), background-color var(--transition-speed);
        }

        .menu-lesson-link .bullet {
            color: var(--text-muted);
            font-size: 8px;
            opacity: 0.7;
        }

        .menu-lesson-link:hover {
            color: var(--text-primary);
            background-color: var(--bg-tertiary);
        }

        .menu-lesson-link.active {
            color: #ffffff;
            background-color: var(--bg-tertiary);
            font-weight: 500;
            border-left: 2px solid var(--accent-glow);
            border-radius: 0 4px 4px 0;
            padding-left: 8px;
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
            flex-wrap: wrap;
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

        .theme-btn.custom-theme-btn {
            width: auto;
            padding: 0 8px;
            font-size: 12px;
            font-weight: 600;
            letter-spacing: 0.02em;
        }

        .theme-btn:hover {
            color: var(--text-primary);
        }

        .theme-btn.active {
            background-color: var(--bg-tertiary);
            color: var(--accent-glow);
        }

        .custom-theme-panel {
            display: none;
            margin-top: 8px;
            padding: 10px;
            border-radius: 8px;
            border: 1px solid var(--border-color);
            background-color: var(--bg-primary);
            width: 100%;
            gap: 8px;
        }

        .custom-theme-panel.open {
            display: grid;
        }

        .custom-theme-row {
            display: flex;
            align-items: center;
            justify-content: space-between;
            gap: 8px;
            font-size: 12px;
            color: var(--text-secondary);
        }

        .custom-theme-row input[type="color"] {
            width: 36px;
            height: 28px;
            padding: 0;
            border: none;
            background: none;
            cursor: pointer;
        }

        .custom-theme-actions {
            display: flex;
            gap: 6px;
            margin-top: 4px;
        }

        .custom-theme-actions button {
            flex: 1;
            border: 1px solid var(--border-color);
            background-color: var(--bg-secondary);
            color: var(--text-primary);
            border-radius: 6px;
            padding: 6px 8px;
            font-size: 12px;
            cursor: pointer;
            transition: background-color var(--transition-speed), border-color var(--transition-speed);
        }

        .custom-theme-actions button:hover {
            background-color: var(--bg-tertiary);
            border-color: var(--accent-primary);
        }

        /* Main Scrollable Content Panel */
        main.main-content {
            margin-left: var(--sidebar-width);
            flex: 1;
            min-width: 0;
            min-height: 100vh;
            display: flex;
            flex-direction: column;
            position: relative;
            background-color: var(--bg-primary);
            overflow-x: hidden;
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
            display: flex;
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

        .header-actions {
            display: flex;
            align-items: center;
            gap: 8px;
            flex-wrap: wrap;
            justify-content: flex-end;
        }

        .shortcuts-toggle {
            border: 1px solid var(--border-color);
            background: var(--bg-secondary);
            color: var(--text-secondary);
            padding: 7px 10px;
            border-radius: 999px;
            cursor: pointer;
            font-size: 12px;
            font-weight: 600;
            position: relative;
        }

        .shortcuts-toggle:hover {
            color: var(--accent-primary);
            border-color: var(--accent-primary);
            background: var(--bg-tertiary);
        }

        .shortcuts-panel {
            position: absolute;
            top: calc(100% + 8px);
            right: 0;
            background: var(--bg-secondary);
            border: 1px solid var(--border-color);
            border-radius: 12px;
            padding: 10px 12px;
            min-width: 220px;
            box-shadow: var(--shadow-premium);
            display: none;
            z-index: 120;
        }

        .shortcuts-panel.visible {
            display: block;
        }

        .command-palette-overlay {
            position: fixed;
            inset: 0;
            background: rgba(2, 6, 23, 0.72);
            backdrop-filter: blur(8px);
            display: none;
            align-items: flex-start;
            justify-content: center;
            padding: 80px 16px 16px;
            z-index: 200;
        }

        .command-palette-overlay.visible {
            display: flex;
        }

        .command-palette-panel {
            width: min(640px, 100%);
            background: linear-gradient(135deg, color-mix(in srgb, var(--bg-secondary) 92%, var(--bg-primary)), color-mix(in srgb, var(--bg-tertiary) 88%, var(--bg-secondary)));
            border: 1px solid color-mix(in srgb, var(--border-color) 80%, var(--accent-primary));
            border-radius: 18px;
            box-shadow: 0 24px 60px rgba(15, 23, 42, 0.28), inset 0 1px 0 color-mix(in srgb, var(--text-primary) 8%, transparent);
            overflow: hidden;
        }

        .command-palette-input {
            width: 100%;
            border: none;
            outline: none;
            background: transparent;
            color: var(--text-primary);
            padding: 16px 18px;
            font-size: 15px;
            font-family: var(--font-ui);
            border-bottom: 1px solid color-mix(in srgb, var(--border-color) 70%, transparent);
        }

        .command-palette-input::placeholder {
            color: var(--text-muted);
        }

        .command-palette-results {
            display: flex;
            flex-direction: column;
            gap: 2px;
            padding: 0 8px 8px;
            max-height: 340px;
            overflow-y: auto;
        }

        .command-palette-item {
            border: 1px solid color-mix(in srgb, var(--border-color) 55%, transparent);
            border-radius: 12px;
            padding: 10px 12px;
            cursor: pointer;
            color: var(--text-primary);
            background: color-mix(in srgb, var(--bg-tertiary) 70%, transparent);
            transition: background-color var(--transition-speed), border-color var(--transition-speed), transform var(--transition-speed);
        }

        .command-palette-item:hover,
        .command-palette-item.active {
            background: linear-gradient(90deg, color-mix(in srgb, var(--accent-primary) 16%, var(--bg-tertiary)), color-mix(in srgb, var(--accent-primary) 6%, var(--bg-tertiary)));
            border-color: color-mix(in srgb, var(--accent-primary) 45%, var(--border-color));
            transform: translateY(-1px);
        }

        .command-palette-title {
            font-size: 13px;
            font-weight: 600;
            color: var(--text-primary);
            margin-bottom: 3px;
        }

        .command-palette-meta {
            font-size: 12px;
            color: var(--text-secondary);
        }

        .command-palette-item.muted {
            cursor: default;
            color: var(--text-muted);
            font-size: 13px;
            background: transparent;
            border-color: transparent;
        }

        .shortcut-item {
            display: flex;
            justify-content: space-between;
            gap: 10px;
            font-size: 12px;
            color: var(--text-secondary);
            padding: 4px 0;
        }

        .shortcut-item strong {
            color: var(--text-primary);
        }

        .sidebar-backdrop {
            position: fixed;
            inset: 0;
            background: rgba(2, 6, 23, 0.55);
            backdrop-filter: blur(2px);
            z-index: 90;
            opacity: 0;
            pointer-events: none;
            transition: opacity var(--transition-speed);
        }

        .sidebar-backdrop.visible {
            opacity: 1;
            pointer-events: auto;
        }

        .sidebar-close-btn {
            display: none;
            align-items: center;
            justify-content: center;
            width: 36px;
            height: 36px;
            border-radius: 999px;
            border: 1px solid var(--border-color);
            background: var(--bg-primary);
            color: var(--text-primary);
            cursor: pointer;
            margin-left: auto;
        }

        .sidebar-resizer {
            position: absolute;
            top: 0;
            right: -4px;
            width: 8px;
            height: 100%;
            cursor: col-resize;
            z-index: 110;
        }

        .breadcrumb-bar {
            position: sticky;
            top: calc(var(--header-height) + 1px);
            z-index: 80;
            display: flex;
            align-items: center;
            gap: 8px;
            padding: 12px 16px;
            margin: 0 0 16px;
            background: var(--glass-bg);
            backdrop-filter: var(--glass-backdrop);
            border: 1px solid var(--border-color);
            border-radius: 12px;
            font-size: 13px;
            color: var(--text-secondary);
            overflow-x: auto;
        }

        .breadcrumb-pill {
            display: inline-flex;
            align-items: center;
            gap: 6px;
            padding: 4px 8px;
            border-radius: 999px;
            background: var(--bg-tertiary);
            color: var(--text-secondary);
            white-space: nowrap;
        }

        .breadcrumb-pill.current {
            color: var(--accent-primary);
            background: rgba(99, 102, 241, 0.16);
        }

        .continue-reading-card {
            display: none;
            align-items: center;
            justify-content: space-between;
            gap: 16px;
            margin: 0 0 16px;
            padding: 14px 16px;
            border: 1px solid var(--border-color);
            border-left: 4px solid var(--accent-primary);
            border-radius: 14px;
            background: linear-gradient(135deg, var(--bg-secondary), var(--bg-tertiary));
            box-shadow: var(--shadow-premium);
        }

        .continue-reading-card.visible {
            display: flex;
        }

        .continue-reading-title {
            font-size: 13px;
            font-weight: 700;
            color: var(--text-primary);
            margin-bottom: 4px;
        }

        .continue-reading-copy {
            font-size: 13px;
            color: var(--text-secondary);
            line-height: 1.5;
        }

        .continue-reading-actions {
            display: flex;
            align-items: center;
            gap: 8px;
            flex-wrap: wrap;
        }

        .continue-reading-btn,
        .continue-reading-dismiss {
            border: 1px solid var(--border-color);
            background: var(--bg-primary);
            color: var(--text-primary);
            border-radius: 999px;
            padding: 7px 10px;
            font-size: 12px;
            font-weight: 600;
            cursor: pointer;
            transition: border-color var(--transition-speed), color var(--transition-speed), background-color var(--transition-speed);
        }

        .continue-reading-btn {
            background: var(--accent-gradient);
            color: white;
            border-color: transparent;
        }

        .continue-reading-btn:hover,
        .continue-reading-dismiss:hover {
            border-color: var(--accent-primary);
            color: var(--accent-primary);
        }

        .focus-mode-btn {
            border: 1px solid var(--border-color);
            background: var(--bg-secondary);
            color: var(--text-primary);
            padding: 7px 10px;
            border-radius: 999px;
            cursor: pointer;
            font-size: 12px;
            font-weight: 600;
        }

        .focus-mode-btn:hover {
            border-color: var(--accent-primary);
            color: var(--accent-primary);
        }

        .progress-chip {
            display: inline-flex;
            align-items: center;
            gap: 6px;
            padding: 4px 8px;
            border-radius: 999px;
            background: var(--bg-tertiary);
            color: var(--text-secondary);
            font-size: 12px;
            font-weight: 600;
            white-space: nowrap;
        }

        .chapter-progress-wrap {
            margin: 8px 0 10px;
            display: flex;
            flex-direction: column;
            gap: 6px;
        }

        .chapter-progress-bar {
            height: 6px;
            border-radius: 999px;
            background: var(--bg-tertiary);
            overflow: hidden;
        }

        .chapter-progress-fill {
            height: 100%;
            border-radius: inherit;
            background: var(--accent-gradient);
            width: 0%;
            transition: width var(--transition-speed);
        }

        .chapter-progress-label {
            font-size: 11px;
            color: var(--text-muted);
        }

        .lesson-complete-btn {
            display: inline-flex;
            align-items: center;
            gap: 6px;
            padding: 6px 10px;
            border-radius: 999px;
            border: 1px solid var(--border-color);
            background: var(--bg-secondary);
            color: var(--text-secondary);
            cursor: pointer;
            font-size: 12px;
            font-weight: 600;
            margin-left: 8px;
        }

        .lesson-complete-btn.active {
            background: rgba(52, 211, 153, 0.16);
            color: #34d399;
            border-color: rgba(52, 211, 153, 0.32);
        }

        .lesson-complete-btn:hover {
            border-color: var(--accent-primary);
            color: var(--accent-primary);
        }

        .quick-jump {
            position: fixed;
            left: 24px;
            top: calc(var(--header-height) + 16px);
            z-index: 95;
        }

        .quick-jump-btn {
            border: 1px solid var(--border-color);
            background: var(--bg-secondary);
            color: var(--text-primary);
            padding: 10px 12px;
            border-radius: 999px;
            box-shadow: var(--shadow-premium);
            cursor: pointer;
            font-size: 12px;
            font-weight: 700;
        }

        .quick-jump-panel {
            position: absolute;
            top: calc(100% + 8px);
            left: 0;
            background: var(--bg-secondary);
            border: 1px solid var(--border-color);
            border-radius: 12px;
            padding: 10px 12px;
            min-width: 220px;
            max-height: 60vh;
            overflow-y: auto;
            box-shadow: var(--shadow-premium);
            display: none;
        }

        .quick-jump.open .quick-jump-panel {
            display: block;
        }

        .quick-jump-link {
            display: block;
            font-size: 13px;
            color: var(--text-secondary);
            padding: 6px 0;
            border-bottom: 1px solid var(--border-color);
            text-decoration: none;
        }

        .quick-jump-link:last-child {
            border-bottom: none;
        }

        .quick-jump-link:hover {
            color: var(--accent-primary);
        }

        .quick-jump-actions {
            display: grid;
            gap: 8px;
            margin-top: 8px;
            padding-top: 8px;
            border-top: 1px solid var(--border-color);
        }

        .quick-jump-action {
            display: flex;
            align-items: center;
            justify-content: space-between;
            gap: 8px;
            width: 100%;
            border: 1px solid var(--border-color);
            background: var(--bg-tertiary);
            color: var(--text-primary);
            border-radius: 8px;
            padding: 8px 10px;
            cursor: pointer;
            font-size: 12px;
            font-weight: 600;
            text-align: left;
        }

        .quick-jump-action:hover {
            border-color: var(--accent-primary);
            color: var(--accent-primary);
        }

        body.focus-mode .sidebar,
        body.focus-mode .toc-widget,
        body.focus-mode .font-size-widget,
        body.focus-mode .btn-top {
            display: none !important;
        }

        body.focus-mode main.main-content {
            margin-left: 0 !important;
        }

        body.focus-mode .content-body {
            max-width: 1100px;
        }

        .toc-widget {
            position: fixed;
            right: 24px;
            top: calc(var(--header-height) + 16px);
            z-index: 95;
        }

        .toc-toggle {
            border: 1px solid var(--border-color);
            background: var(--bg-secondary);
            color: var(--text-primary);
            padding: 10px 12px;
            border-radius: 999px;
            box-shadow: var(--shadow-premium);
            cursor: pointer;
            font-size: 12px;
            font-weight: 700;
        }

        .toc-panel {
            position: absolute;
            top: calc(100% + 8px);
            right: 0;
            background: var(--bg-secondary);
            border: 1px solid var(--border-color);
            border-radius: 12px;
            padding: 10px 12px;
            min-width: 240px;
            max-height: 60vh;
            overflow-y: auto;
            box-shadow: var(--shadow-premium);
            display: none;
        }

        .toc-widget.open .toc-panel {
            display: block;
        }

        .toc-link {
            display: block;
            font-size: 13px;
            color: var(--text-secondary);
            padding: 6px 0;
            border-bottom: 1px solid var(--border-color);
            text-decoration: none;
            border-bottom-style: solid;
        }

        .toc-link:last-child {
            border-bottom: none;
        }

        .toc-link:hover,
        .toc-link.active {
            color: var(--accent-primary);
        }

        .btn-font-size {
            border: 1px solid var(--border-color);
            background: var(--bg-tertiary);
            color: var(--text-primary);
            cursor: pointer;
            height: 34px;
            padding: 0 10px;
            border-radius: 6px;
            font-family: var(--font-ui);
            font-size: 13px;
            font-weight: 600;
            display: none; /* moved to floating widget */
        }

        .reading-progress-label {
            font-size: 11px;
            font-weight: 600;
            color: var(--accent-glow);
            font-family: var(--font-ui);
            min-width: 38px;
            text-align: right;
        }

        .reading-time {
            display: inline-flex;
            align-items: center;
            gap: 6px;
            font-size: 12px;
            color: var(--text-muted);
            font-weight: 500;
            margin-left: 12px;
            padding: 4px 10px;
            background: var(--bg-tertiary);
            border-radius: 20px;
            border: 1px solid var(--border-color);
        }

        .reading-time svg {
            flex-shrink: 0;
            opacity: 0.7;
        }

        /* Content Container */
        .content-body {
            width: 100%;
            max-width: 1400px;
            margin: 0 auto;
            padding: 40px var(--content-pad) 80px var(--content-pad);
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
            padding-right: 52px;
            scroll-margin-top: 90px;
            position: relative;
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
            scroll-margin-top: 90px;
        }

        .section-title, .lesson-title, .lesson-subtitle {
            position: relative;
            padding-right: 52px;
        }

        .lesson-title, .lesson-subtitle {
            font-family: var(--font-heading);
            font-size: 18px;
            font-weight: 600;
            margin-top: 24px;
            margin-bottom: 12px;
            color: var(--text-primary);
            scroll-margin-top: 90px;
        }

        .heading-action-btn {
            position: absolute;
            top: 50%;
            right: 0;
            transform: translateY(-50%);
            display: inline-flex;
            align-items: center;
            justify-content: center;
            width: 32px;
            height: 32px;
            border: 1px solid var(--border-color);
            background: var(--bg-secondary);
            color: var(--text-muted);
            border-radius: 999px;
            cursor: pointer;
            transition: background-color var(--transition-speed), color var(--transition-speed), border-color var(--transition-speed), transform var(--transition-speed);
            opacity: 0.88;
        }

        .heading-action-btn:hover {
            background-color: var(--bg-tertiary);
            color: var(--accent-primary);
            border-color: var(--accent-primary);
            transform: translateY(-50%) scale(1.04);
        }

        .toast-notification {
            position: fixed;
            bottom: 24px;
            right: 24px;
            background: var(--bg-secondary);
            color: var(--text-primary);
            border: 1px solid var(--border-color);
            box-shadow: var(--shadow-premium);
            border-radius: 999px;
            padding: 10px 14px;
            font-size: 13px;
            font-weight: 600;
            z-index: 1400;
            opacity: 0;
            transform: translateY(8px);
            pointer-events: none;
            transition: opacity var(--transition-speed), transform var(--transition-speed);
        }

        .toast-notification.visible {
            opacity: 1;
            transform: translateY(0);
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

        .alert-exercise {
            border-left-color: #8b5cf6;
            background: linear-gradient(to right, rgba(139, 92, 246, 0.04), rgba(139, 92, 246, 0.01)), var(--bg-secondary);
        }
        .alert-exercise .alert-title {
            color: #8b5cf6;
        }

        .alert-solution {
            border-left-color: #10b981;
            background: linear-gradient(to right, rgba(16, 185, 129, 0.04), rgba(16, 185, 129, 0.01)), var(--bg-secondary);
        }
        .alert-solution .alert-title {
            color: #10b981;
        }

        .alert-output {
            border-left-color: #38bdf8;
            background: linear-gradient(to right, rgba(56, 189, 248, 0.04), rgba(56, 189, 248, 0.01)), var(--bg-secondary);
        }
        .alert-output .alert-title {
            color: #38bdf8;
        }

        .alert-content .code-wrapper {
            margin-top: 12px;
            margin-bottom: 4px;
            border-color: var(--border-color);
            background-color: var(--code-bg);
        }

        .lesson-nav {
            display: flex;
            justify-content: space-between;
            gap: 12px;
            align-items: center;
            padding: 12px 14px;
            margin: 20px 0 24px;
            border: 1px solid var(--border-color);
            border-radius: 10px;
            background: rgba(255, 255, 255, 0.03);
        }

        .lesson-nav a {
            color: var(--accent-glow);
            text-decoration: none;
            font-weight: 600;
        }

        .lesson-nav a:hover {
            text-decoration: underline;
        }

        .lesson-nav .nav-label {
            font-size: 12px;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            color: var(--text-muted);
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
            flex-wrap: wrap;
            justify-content: flex-end;
        }

        .btn-copy, .btn-playground, .btn-playground-copy, .btn-zoom, .btn-close-zoom {
            background: linear-gradient(135deg, var(--bg-tertiary), var(--bg-secondary));
            border: 1px solid var(--border-color);
            color: var(--text-primary);
            padding: 7px 12px;
            min-height: 32px;
            border-radius: 8px;
            font-size: 12px;
            font-family: var(--font-ui);
            cursor: pointer;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            gap: 6px;
            font-weight: 700;
            letter-spacing: 0.01em;
            white-space: nowrap;
            box-shadow: 0 1px 2px rgba(0, 0, 0, 0.14);
            transition: background-color var(--transition-speed), color var(--transition-speed), transform var(--transition-speed), border-color var(--transition-speed), box-shadow var(--transition-speed);
            text-decoration: none;
        }

        .btn-copy:hover, .btn-playground:hover, .btn-playground-copy:hover, .btn-zoom:hover, .btn-close-zoom:hover {
            background: var(--bg-secondary);
            color: var(--accent-glow);
            border-color: var(--accent-glow);
            box-shadow: 0 3px 8px rgba(0, 0, 0, 0.16);
        }

        .btn-playground {
            background: var(--accent-gradient);
            color: #ffffff !important;
            border: 1px solid transparent;
            font-weight: 700;
            box-shadow: 0 2px 8px rgba(99, 102, 241, 0.28);
        }

        .btn-playground-copy {
            border-color: var(--accent-glow);
            color: var(--accent-glow);
        }

        .btn-playground-copy:hover {
            background: rgba(99, 102, 241, 0.12);
            border-color: var(--accent-glow);
        }

        .btn-playground:hover {
            box-shadow: 0 4px 12px rgba(99, 102, 241, 0.4);
            transform: translateY(-1px);
        }

        pre {
            padding: 16px 20px;
            overflow-x: auto;
            margin: 0;
            background: none !important;
        }

        pre code {
            font-size: 12px;
            line-height: 1.5;
        }

        .code-zoom-modal {
            position: fixed;
            inset: 0;
            background: rgba(2, 6, 23, 0.8);
            display: none;
            align-items: center;
            justify-content: center;
            padding: 24px;
            z-index: 2000;
        }

        .code-zoom-modal.active {
            display: flex;
        }

        .code-zoom-panel {
            width: min(1100px, 100%);
            max-height: 90vh;
            overflow: auto;
        }

        .code-zoom-panel .code-wrapper {
            margin: 0;
            box-shadow: 0 20px 60px rgba(0, 0, 0, 0.35);
        }

        .code-zoom-panel pre {
            max-height: 75vh;
            overflow: auto;
        }

        code {
            font-family: var(--font-code);
            font-size: 13px;
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

        /* Floating Font Size Widget */
        .font-size-widget {
            position: fixed;
            bottom: 84px;
            right: 30px;
            z-index: 95;
            display: flex;
            align-items: center;
            gap: 0;
            background: var(--bg-secondary);
            border: 1px solid var(--border-color);
            border-radius: 22px;
            box-shadow: var(--shadow-premium);
            overflow: visible;
            transition: box-shadow var(--transition-speed);
            position: relative;
        }

        .font-size-widget:hover {
            box-shadow: 0 8px 24px rgba(0,0,0,0.35);
        }

        .font-size-widget.open .toc-panel {
            display: block;
        }

        .fs-btn {
            background: none;
            border: none;
            cursor: pointer;
            color: var(--text-primary);
            width: 36px;
            height: 36px;
            display: flex;
            align-items: center;
            justify-content: center;
            transition: background-color var(--transition-speed), color var(--transition-speed);
            flex-shrink: 0;
        }

        .fs-btn:hover:not(:disabled) {
            background-color: var(--accent-primary);
            color: #fff;
        }

        .fs-btn:disabled {
            opacity: 0.3;
            cursor: not-allowed;
        }

        .fs-btn-contents {
            width: auto;
            min-width: 72px;
            padding: 0 10px;
            font-size: 11px;
            font-weight: 700;
            letter-spacing: 0.04em;
            text-transform: uppercase;
            border-right: 1px solid var(--border-color);
        }

        .toc-panel {
            position: absolute;
            right: 0;
            top: calc(100% + 8px);
            background: var(--bg-secondary);
            border: 1px solid var(--border-color);
            border-radius: 12px;
            padding: 10px 12px;
            min-width: 240px;
            max-height: 60vh;
            overflow-y: auto;
            box-shadow: var(--shadow-premium);
            display: none;
            z-index: 100;
        }

        .toc-link {
            display: block;
            font-size: 13px;
            color: var(--text-secondary);
            padding: 6px 0;
            border-bottom: 1px solid var(--border-color);
            text-decoration: none;
            border-bottom-style: solid;
        }

        .toc-link:last-child {
            border-bottom: none;
        }

        .toc-link:hover,
        .toc-link.active {
            color: var(--accent-primary);
        }

        .fs-label {
            font-family: var(--font-ui);
            font-size: 12px;
            font-weight: 700;
            color: var(--accent-glow);
            min-width: 32px;
            text-align: center;
            line-height: 1;
            border-left: 1px solid var(--border-color);
            border-right: 1px solid var(--border-color);
            padding: 0 4px;
            height: 36px;
            display: flex;
            align-items: center;
            justify-content: center;
            transition: color 0.15s;
        }

        .fs-label.bump {
            animation: fsBump 0.2s ease;
        }

        @keyframes fsBump {
            0%   { transform: scale(1); }
            40%  { transform: scale(1.35); color: var(--accent-primary); }
            100% { transform: scale(1); }
        }

        /* Bookmark button styles */
        .lesson-title, .lesson-subtitle {
            position: relative;
            display: flex;
            align-items: center;
            justify-content: space-between;
            gap: 16px;
        }

        .btn-bookmark {
            border: 1px solid transparent;
            background: rgba(99, 102, 241, 0.1);
            color: var(--text-muted);
            cursor: pointer;
            padding: 8px;
            border-radius: 999px;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            min-width: 40px;
            min-height: 40px;
            flex-shrink: 0;
            transition: color var(--transition-speed), background-color var(--transition-speed), border-color var(--transition-speed), transform var(--transition-speed), opacity var(--transition-speed);
            opacity: 1;
        }

        .lesson-title:hover .btn-bookmark,
        .lesson-subtitle:hover .btn-bookmark,
        .btn-bookmark.active,
        .btn-bookmark:focus-visible {
            opacity: 1;
            background-color: rgba(99, 102, 241, 0.16);
            border-color: rgba(99, 102, 241, 0.24);
            color: var(--accent-primary);
        }

        .btn-bookmark:hover {
            transform: translateY(-1px);
            background-color: rgba(99, 102, 241, 0.2);
            color: var(--accent-glow);
        }

        .btn-bookmark.active {
            color: var(--accent-primary);
        }

        .btn-bookmark.active .bookmark-icon {
            fill: var(--accent-primary);
        }

        /* Desktop collapsed sidebar */
        body.sidebar-collapsed aside.sidebar {
            transform: translateX(-100%);
        }
        body.sidebar-collapsed main.main-content {
            margin-left: 0;
        }

        /* Mobile adjustments */
        @media (max-width: 1024px) {
            .sidebar-close-btn {
                display: inline-flex;
            }

            .toc-widget {
                top: auto;
                bottom: 24px;
                right: 16px;
            }

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

            .btn-bookmark {
                min-width: 44px;
                min-height: 44px;
            }

            .search-input {
                min-height: 48px;
                font-size: 16px;
            }

            /* On mobile: update --content-pad */
            :root {
                --content-pad: 24px;
            }

            .content-body {
                padding: 30px var(--content-pad);
            }

            .code-wrapper {
                border-radius: 0;
            }

            header.nav-header {
                padding: 0 24px;
            }
        }

        /* Print / PDF export styles */
        @media print {
            aside.sidebar,
            .progress-container,
            .btn-top,
            .font-size-widget,
            .btn-toggle-sidebar,
            .nav-header,
            .btn-bookmark,
            .btn-copy,
            .btn-zoom,
            .btn-playground,
            .btn-playground-copy,
            .lesson-nav,
            .header-actions,
            #searchResultsOverlay {
                display: none !important;
            }

            main.main-content {
                margin-left: 0 !important;
            }

            body, html {
                background: #fff !important;
                color: #000 !important;
            }

            .content-body {
                max-width: 100% !important;
                padding: 20px !important;
            }

            .code-wrapper {
                border: 1px solid #ccc !important;
                break-inside: avoid;
                /* Reset breakout for print */
                margin-left: 0 !important;
                margin-right: 0 !important;
                width: auto !important;
                max-width: 100% !important;
                border-radius: 6px !important;
            }

            pre, code {
                color: #000 !important;
                background: #f5f5f5 !important;
                white-space: pre-wrap !important;
            }

            h1, h2, h3 {
                color: #000 !important;
                break-after: avoid;
            }

            p {
                orphans: 3;
                widows: 3;
            }
        }
    </style>
</head>
<body>
    <div class="progress-container">
        <div class="progress-bar" id="readingProgress"></div>
    </div>

    <div class="sidebar-backdrop" id="sidebarBackdrop"></div>
    
    <div class="app-container">
        <!-- Sidebar Navigation -->
        <aside class="sidebar" id="sidebar">
            <div class="sidebar-header" style="position: relative;">
                <button class="sidebar-close-btn" id="sidebarCloseBtn" aria-label="Close sidebar">
                    <svg viewBox="0 0 24 24" width="16" height="16" stroke="currentColor" stroke-width="2.5" fill="none"><line x1="18" y1="6" x2="6" y2="18"></line><line x1="6" y1="6" x2="18" y2="18"></line></svg>
                </button>
                <div class="sidebar-resizer" id="sidebarResizer" title="Resize sidebar"></div>
                <div class="sidebar-actions" role="toolbar" aria-label="Sidebar navigation actions">
                    <button class="sidebar-action-btn" id="collapseAllSectionsBtn" type="button" title="Collapse all sections" aria-label="Collapse all sections">
                        <svg viewBox="0 0 24 24" width="14" height="14" stroke="currentColor" stroke-width="2" fill="none" stroke-linecap="round" stroke-linejoin="round"><path d="M12 5v14"></path><path d="M5 12l7-7 7 7"></path></svg>
                    </button>
                    <button class="sidebar-action-btn" id="expandAllSectionsBtn" type="button" title="Expand all sections" aria-label="Expand all sections">
                        <svg viewBox="0 0 24 24" width="14" height="14" stroke="currentColor" stroke-width="2" fill="none" stroke-linecap="round" stroke-linejoin="round"><path d="M12 19V5"></path><path d="M5 12l7 7 7-7"></path></svg>
                    </button>
                    <button class="sidebar-action-btn" id="focusCurrentPathBtn" type="button" title="Focus current path" aria-label="Focus current path">
                        <svg viewBox="0 0 24 24" width="14" height="14" stroke="currentColor" stroke-width="2" fill="none" stroke-linecap="round" stroke-linejoin="round"><circle cx="12" cy="12" r="8"></circle><path d="M12 8v4l2 2"></path></svg>
                    </button>
                </div>
                <div class="logo-area">
                    <div class="logo-v">V</div>
                    <span class="logo-title">V Language Guide</span>
                </div>
                <div class="search-container">
                    <svg class="search-icon" viewBox="0 0 24 24" width="16" height="16" stroke="currentColor" stroke-width="2" fill="none"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg>
                    <input type="text" class="search-input" id="searchInput" placeholder="Search lessons, syntax... (Ctrl+K or /)">
                    <button type="button" class="search-clear-btn" id="searchClearBtn" aria-label="Clear search" title="Clear search">
                        <svg viewBox="0 0 24 24" width="14" height="14" stroke="currentColor" stroke-width="2.5" fill="none"><line x1="18" y1="6" x2="6" y2="18"></line><line x1="6" y1="6" x2="18" y2="18"></line></svg>
                    </button>
                </div>
            </div>
            
            <nav class="sidebar-menu" id="sidebarMenu">
                <div class="menu-chapter" id="bookmarksSection" style="display: none;">
                    <div class="chapter-heading">
                        <span>🔖 Bookmarked Lessons</span>
                    </div>
                    <div class="chapter-items" id="bookmarksItems"></div>
                </div>
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
                    <button class="theme-btn" onclick="setTheme('forest')" title="Forest Sage" id="theme-forest">
                        <svg viewBox="0 0 24 24" width="16" height="16" stroke="currentColor" stroke-width="2" fill="none" stroke-linecap="round" stroke-linejoin="round"><path d="M12 2L2 22h20L12 2z"></path><path d="M12 2v20"></path></svg>
                    </button>
                    <button class="theme-btn" onclick="setTheme('amber')" title="Solarized Amber" id="theme-amber">
                        <svg viewBox="0 0 24 24" width="16" height="16" stroke="currentColor" stroke-width="2" fill="none" stroke-linecap="round" stroke-linejoin="round"><circle cx="12" cy="12" r="5"></circle><line x1="12" y1="1" x2="12" y2="3"></line><line x1="12" y1="21" x2="12" y2="23"></line><line x1="4.22" y1="4.22" x2="5.64" y2="5.64"></line><line x1="18.36" y1="18.36" x2="19.78" y2="19.78"></line><line x1="1" y1="12" x2="3" y2="12"></line><line x1="21" y1="12" x2="23" y2="12"></line><line x1="4.22" y1="19.78" x2="5.64" y2="18.36"></line><line x1="18.36" y1="5.64" x2="19.78" y2="4.22"></line></svg>
                    </button>
                    <button class="theme-btn" onclick="setTheme('ocean')" title="Ocean Breeze" id="theme-ocean">
                        <svg viewBox="0 0 24 24" width="16" height="16" stroke="currentColor" stroke-width="2" fill="none" stroke-linecap="round" stroke-linejoin="round"><path d="M22 12h-4l-3 9L9 3l-3 9H2"></path></svg>
                    </button>
                    <button class="theme-btn" onclick="setTheme('rose')" title="Rose Glow" id="theme-rose">
                        <svg viewBox="0 0 24 24" width="16" height="16" stroke="currentColor" stroke-width="2" fill="none" stroke-linecap="round" stroke-linejoin="round"><path d="M12 3c3 2 5 5 5 8a5 5 0 1 1-10 0c0-3 2-6 5-8z"></path></svg>
                    </button>
                    <button class="theme-btn" onclick="setTheme('lavender')" title="Lavender Mood" id="theme-lavender">
                        <svg viewBox="0 0 24 24" width="16" height="16" stroke="currentColor" stroke-width="2" fill="none" stroke-linecap="round" stroke-linejoin="round"><path d="M12 3v18"></path><path d="M6 7c3 0 5 2 6 5 1-3 3-5 6-5"></path></svg>
                    </button>
                    <button class="theme-btn" onclick="setTheme('sunset')" title="Sunset Glow" id="theme-sunset">
                        <svg viewBox="0 0 24 24" width="16" height="16" stroke="currentColor" stroke-width="2" fill="none" stroke-linecap="round" stroke-linejoin="round"><path d="M6 18a6 6 0 0 1 12 0"></path><path d="M8 14c1-3 3-4 4-7 1 3 3 4 4 7"></path></svg>
                    </button>
                    <button class="theme-btn" onclick="setTheme('mint')" title="Mint Energy" id="theme-mint">
                        <svg viewBox="0 0 24 24" width="16" height="16" stroke="currentColor" stroke-width="2" fill="none" stroke-linecap="round" stroke-linejoin="round"><path d="M7 3h10"></path><path d="M6 8h12"></path><path d="M8 13h8"></path><path d="M9 18h6"></path></svg>
                    </button>
                    <button class="theme-btn" onclick="setTheme('aurora')" title="Aurora Glow" id="theme-aurora">
                        <svg viewBox="0 0 24 24" width="16" height="16" stroke="currentColor" stroke-width="2" fill="none" stroke-linecap="round" stroke-linejoin="round"><path d="M5 16c2-6 5-8 7-10 2 2 5 4 7 10"></path><path d="M4 20h16"></path></svg>
                    </button>
                    <button class="theme-btn" onclick="setTheme('plum')" title="Plum Velvet" id="theme-plum">
                        <svg viewBox="0 0 24 24" width="16" height="16" stroke="currentColor" stroke-width="2" fill="none" stroke-linecap="round" stroke-linejoin="round"><path d="M12 4c-3 3-5 6-5 10a5 5 0 0 0 10 0c0-4-2-7-5-10z"></path></svg>
                    </button>
                    <button class="theme-btn" onclick="setTheme('ember')" title="Ember Glow" id="theme-ember">
                        <svg viewBox="0 0 24 24" width="16" height="16" stroke="currentColor" stroke-width="2" fill="none" stroke-linecap="round" stroke-linejoin="round"><path d="M12 3c2 4 4 6 4 9a4 4 0 1 1-8 0c0-3 2-5 4-9z"></path></svg>
                    </button>
                    <button class="theme-btn" onclick="setTheme('glacier')" title="Glacier Ice" id="theme-glacier">
                        <svg viewBox="0 0 24 24" width="16" height="16" stroke="currentColor" stroke-width="2" fill="none" stroke-linecap="round" stroke-linejoin="round"><path d="M12 3l6 8H6l6-8z"></path><path d="M6 11h12"></path><path d="M8 15h8"></path><path d="M9 19h6"></path></svg>
                    </button>
                    <button class="theme-btn custom-theme-btn" onclick="setTheme('custom')" title="Custom color theme" id="theme-custom">Custom</button>
                </div>
                <div class="custom-theme-panel" id="customThemePanel">
                    <div class="custom-theme-row">
                        <span>Background</span>
                        <input type="color" id="customBgPrimary" value="#0b0f19">
                    </div>
                    <div class="custom-theme-row">
                        <span>Surface</span>
                        <input type="color" id="customBgSecondary" value="#131a2c">
                    </div>
                    <div class="custom-theme-row">
                        <span>Text</span>
                        <input type="color" id="customTextPrimary" value="#f1f5f9">
                    </div>
                    <div class="custom-theme-row">
                        <span>Accent</span>
                        <input type="color" id="customAccentPrimary" value="#4f46e5">
                    </div>
                    <div class="custom-theme-actions">
                        <button type="button" id="applyCustomThemeBtn">Apply</button>
                        <button type="button" id="resetCustomThemeBtn">Reset</button>
                    </div>
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
                <div class="header-actions" id="headerActions">
                    <button class="focus-mode-btn" id="commandPaletteBtn" type="button" title="Quick navigate (Ctrl+P)">⌘ Navigate</button>
                    <button class="focus-mode-btn" id="focusModeBtn" type="button" title="Toggle focus mode">Focus mode</button>
                    <div style="position:relative;">
                        <button class="shortcuts-toggle" id="shortcutsToggle" type="button" title="Keyboard shortcuts">⌨ Shortcuts</button>
                        <div class="shortcuts-panel" id="shortcutsPanel">
                            <div class="shortcut-item"><strong>Search</strong><span>/ or Ctrl+K</span></div>
                            <div class="shortcut-item"><strong>Quick navigate</strong><span>Ctrl+P</span></div>
                            <div class="shortcut-item"><strong>Focus mode</strong><span>F / Esc</span></div>
                            <div class="shortcut-item"><strong>Share section</strong><span>Click the link icon</span></div>
                        </div>
                    </div>
                    <span class="reading-progress-label" id="readingPct">0%</span>
                </div>
            </header>
            
            <div class="command-palette-overlay" id="commandPaletteOverlay">
                <div class="command-palette-panel" role="dialog" aria-modal="true" aria-label="Quick navigation">
                    <input class="command-palette-input" id="commandPaletteInput" type="text" placeholder="Type to jump to a chapter, section, or lesson..." autocomplete="off" />
                    <div class="command-palette-results" id="commandPaletteResults"></div>
                </div>
            </div>

            <!-- Global Search Overlay -->
            <div class="search-results-overlay" id="searchResultsOverlay">
                <div class="search-results-title" id="resultsSummary">Search Results</div>
                <div id="resultsList"></div>
            </div>
            
            <div class="content-body" id="contentBody">
                <div class="continue-reading-card" id="continueReadingCard" style="display:none;">
                    <div>
                        <div class="continue-reading-title">Continue reading</div>
                        <div class="continue-reading-copy" id="continueReadingCopy">Pick up where you left off.</div>
                    </div>
                    <div class="continue-reading-actions">
                        <button class="continue-reading-btn" id="continueReadingBtn" type="button">Resume</button>
                        <button class="continue-reading-dismiss" id="dismissContinueReadingBtn" type="button">Dismiss</button>
                    </div>
                </div>
                <div class="breadcrumb-bar" id="breadcrumbBar"></div>
                ${contentHtml}
            </div>
        </main>
    </div>
    
    <button class="btn-top" id="btnTop" onclick="scrollToTop()" title="Back to Top">
        <svg viewBox="0 0 24 24" width="20" height="20" stroke="currentColor" stroke-width="2.5" fill="none"><line x1="12" y1="19" x2="12" y2="5"></line><polyline points="5 12 12 5 19 12"></polyline></svg>
    </button>

    <div class="quick-jump" id="quickJumpWidget">
        <button class="quick-jump-btn" id="quickJumpToggle" type="button">Jump to</button>
        <div class="quick-jump-panel" id="quickJumpPanel">
            <div class="quick-jump-actions">
                <button class="quick-jump-action" id="quickJumpBackToTop" type="button">Back to top</button>
                <button class="quick-jump-action" id="quickJumpToggleFocus" type="button">Toggle focus</button>
            </div>
        </div>
    </div>

    <div class="toast-notification" id="toastNotification"></div>

    <!-- Floating Reading Controls -->
    <div class="font-size-widget" id="fontSizeWidget">
        <button class="fs-btn fs-btn-contents" id="tocToggle" type="button" title="Open contents">Contents</button>
        <button class="fs-btn" id="btnFontDec" title="Decrease font size (Ctrl+[)" aria-label="Decrease font size">
            <svg viewBox="0 0 24 24" width="14" height="14" stroke="currentColor" stroke-width="2.5" fill="none"><line x1="5" y1="12" x2="19" y2="12"></line></svg>
        </button>
        <span class="fs-label" id="fontSizeLabel">16</span>
        <button class="fs-btn" id="btnFontInc" title="Increase font size (Ctrl+])" aria-label="Increase font size">
            <svg viewBox="0 0 24 24" width="14" height="14" stroke="currentColor" stroke-width="2.5" fill="none"><line x1="12" y1="5" x2="12" y2="19"></line><line x1="5" y1="12" x2="19" y2="12"></line></svg>
        </button>
        <div class="toc-panel" id="tocPanel"></div>
    </div>
    
    <!-- Prism Syntax Highlighting -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/prism/1.29.0/components/prism-core.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/prism/1.29.0/components/prism-v.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/prism/1.29.0/plugins/autoloader/prism-autoloader.min.js"></script>
    
    <script>
        // Inject structure and search index JSON
        const bookStructure = ${structureJson};
        const searchIndex = ${searchIndexJson};
        
        // Theme Management
        const customThemeStorageKey = 'custom-theme-config';
        const customThemeDefaults = {
            bgPrimary: '#0b0f19',
            bgSecondary: '#131a2c',
            textPrimary: '#f1f5f9',
            accentPrimary: '#4f46e5'
        };
        const themePresets = {
            amber: {
                bgPrimary: '#f8efe1',
                bgSecondary: '#f1dfbf',
                textPrimary: '#4a2f1b',
                accentPrimary: '#b96b10'
            },
            rose: {
                bgPrimary: '#180c14',
                bgSecondary: '#24131f',
                textPrimary: '#fff1f7',
                accentPrimary: '#f472b6'
            },
            lavender: {
                bgPrimary: '#140f22',
                bgSecondary: '#1d1630',
                textPrimary: '#f5f3ff',
                accentPrimary: '#8b5cf6'
            },
            sunset: {
                bgPrimary: '#1a0f0a',
                bgSecondary: '#2a1710',
                textPrimary: '#fff7ed',
                accentPrimary: '#fb923c'
            },
            mint: {
                bgPrimary: '#07150f',
                bgSecondary: '#0f241f',
                textPrimary: '#f0fdf4',
                accentPrimary: '#34d399'
            },
            aurora: {
                bgPrimary: '#060816',
                bgSecondary: '#10192d',
                textPrimary: '#f4fbff',
                accentPrimary: '#22d3ee'
            },
            plum: {
                bgPrimary: '#130b17',
                bgSecondary: '#22152b',
                textPrimary: '#fbefff',
                accentPrimary: '#c084fc'
            },
            ember: {
                bgPrimary: '#17110c',
                bgSecondary: '#241711',
                textPrimary: '#fff5e9',
                accentPrimary: '#f97316'
            },
            glacier: {
                bgPrimary: '#07141d',
                bgSecondary: '#102335',
                textPrimary: '#f2fcff',
                accentPrimary: '#38bdf8'
            }
        };

        function hexToRgb(hex) {
            const normalized = hex.replace('#', '');
            const full = normalized.length === 3 ? normalized.split('').map(ch => ch + ch).join('') : normalized;
            const value = parseInt(full, 16);
            return {
                r: (value >> 16) & 255,
                g: (value >> 8) & 255,
                b: value & 255
            };
        }

        function rgbToHex(r, g, b) {
            return '#' + [r, g, b].map(channel => Math.max(0, Math.min(255, Math.round(channel))).toString(16).padStart(2, '0')).join('');
        }

        function blendColors(colorA, colorB, amount) {
            const rgbA = hexToRgb(colorA);
            const rgbB = hexToRgb(colorB);
            const mix = (a, b) => a + (b - a) * amount;
            return rgbToHex(mix(rgbA.r, rgbB.r), mix(rgbA.g, rgbB.g), mix(rgbA.b, rgbB.b));
        }

        function hexToRgba(hex, alpha) {
            const { r, g, b } = hexToRgb(hex);
            return \`rgba(\${r}, \${g}, \${b}, \${alpha})\`;
        }

        function getStoredCustomTheme() {
            try {
                const stored = JSON.parse(localStorage.getItem(customThemeStorageKey) || 'null');
                return stored && typeof stored === 'object' ? { ...customThemeDefaults, ...stored } : { ...customThemeDefaults };
            } catch (e) {
                return { ...customThemeDefaults };
            }
        }

        function getThemeConfigForCustomStart() {
            const currentTheme = document.documentElement.getAttribute('data-theme') || localStorage.getItem('theme') || 'dark';
            const currentInputs = collectCustomThemeFromInputs();
            const hasCurrentInputValues = currentInputs.bgPrimary && currentInputs.bgSecondary && currentInputs.textPrimary && currentInputs.accentPrimary;

            if (currentTheme === 'custom' && hasCurrentInputValues) {
                return currentInputs;
            }

            if (themePresets[currentTheme]) {
                return { ...customThemeDefaults, ...themePresets[currentTheme] };
            }

            const computed = window.getComputedStyle(document.documentElement);
            const fromCurrentTheme = {
                bgPrimary: computed.getPropertyValue('--bg-primary').trim(),
                bgSecondary: computed.getPropertyValue('--bg-secondary').trim(),
                textPrimary: computed.getPropertyValue('--text-primary').trim(),
                accentPrimary: computed.getPropertyValue('--accent-primary').trim()
            };

            if (fromCurrentTheme.bgPrimary && fromCurrentTheme.bgSecondary && fromCurrentTheme.textPrimary && fromCurrentTheme.accentPrimary) {
                return { ...customThemeDefaults, ...fromCurrentTheme };
            }

            return getStoredCustomTheme();
        }

        function populateCustomThemeInputs(themeConfig = getStoredCustomTheme()) {
            const inputs = {
                bgPrimary: document.getElementById('customBgPrimary'),
                bgSecondary: document.getElementById('customBgSecondary'),
                textPrimary: document.getElementById('customTextPrimary'),
                accentPrimary: document.getElementById('customAccentPrimary')
            };
            Object.entries(inputs).forEach(([key, input]) => {
                if (input) input.value = themeConfig[key] || customThemeDefaults[key];
            });
        }

        function collectCustomThemeFromInputs() {
            return {
                bgPrimary: document.getElementById('customBgPrimary')?.value || customThemeDefaults.bgPrimary,
                bgSecondary: document.getElementById('customBgSecondary')?.value || customThemeDefaults.bgSecondary,
                textPrimary: document.getElementById('customTextPrimary')?.value || customThemeDefaults.textPrimary,
                accentPrimary: document.getElementById('customAccentPrimary')?.value || customThemeDefaults.accentPrimary
            };
        }

        function applyCustomTheme(themeConfig = getStoredCustomTheme()) {
            const config = { ...customThemeDefaults, ...themeConfig };
            const bgPrimary = config.bgPrimary;
            const bgSecondary = config.bgSecondary;
            const textPrimary = config.textPrimary;
            const accentPrimary = config.accentPrimary;
            const textSecondary = blendColors(textPrimary, bgPrimary, 0.45);
            const textMuted = blendColors(textPrimary, bgPrimary, 0.65);
            const bgTertiary = blendColors(bgSecondary, bgPrimary, 0.2);
            const borderColor = blendColors(bgPrimary, textPrimary, 0.15);
            const borderHover = blendColors(bgPrimary, accentPrimary, 0.35);
            const codeBg = blendColors(bgPrimary, '#000000', 0.3);
            const glassBg = hexToRgba(bgSecondary, 0.86);
            const shadowPremium = \`0 10px 25px -5px \${hexToRgba(bgPrimary, 0.28)}, 0 8px 10px -6px \${hexToRgba(bgPrimary, 0.2)}\`;

            document.documentElement.style.setProperty('--bg-primary', bgPrimary);
            document.documentElement.style.setProperty('--bg-secondary', bgSecondary);
            document.documentElement.style.setProperty('--bg-tertiary', bgTertiary);
            document.documentElement.style.setProperty('--text-primary', textPrimary);
            document.documentElement.style.setProperty('--text-secondary', textSecondary);
            document.documentElement.style.setProperty('--text-muted', textMuted);
            document.documentElement.style.setProperty('--accent-primary', accentPrimary);
            document.documentElement.style.setProperty('--accent-glow', accentPrimary);
            document.documentElement.style.setProperty('--accent-gradient', \`linear-gradient(135deg, \${accentPrimary} 0%, \${blendColors(accentPrimary, '#ffffff', 0.2)} 100%)\`);
            document.documentElement.style.setProperty('--border-color', borderColor);
            document.documentElement.style.setProperty('--border-hover', borderHover);
            document.documentElement.style.setProperty('--code-bg', codeBg);
            document.documentElement.style.setProperty('--glass-bg', glassBg);
            document.documentElement.style.setProperty('--shadow-premium', shadowPremium);
            populateCustomThemeInputs(config);
        }

        function clearCustomThemeOverrides() {
            const properties = ['--bg-primary', '--bg-secondary', '--bg-tertiary', '--text-primary', '--text-secondary', '--text-muted', '--accent-primary', '--accent-glow', '--accent-gradient', '--border-color', '--border-hover', '--code-bg', '--glass-bg', '--shadow-premium'];
            properties.forEach(property => document.documentElement.style.removeProperty(property));
        }

        function setTheme(theme) {
            const customThemePanel = document.getElementById('customThemePanel');
            const isCustomToggle = theme === 'custom' && document.documentElement.getAttribute('data-theme') === 'custom' && customThemePanel && customThemePanel.classList.contains('open');
            const presetTheme = themePresets[theme];

            document.documentElement.setAttribute('data-theme', theme);
            localStorage.setItem('theme', theme);

            if (theme === 'custom') {
                const initialCustomTheme = getThemeConfigForCustomStart();
                applyCustomTheme(initialCustomTheme);
                if (customThemePanel) {
                    customThemePanel.classList.toggle('open', !isCustomToggle);
                }
            } else if (presetTheme) {
                populateCustomThemeInputs(presetTheme);
                clearCustomThemeOverrides();
                if (customThemePanel) customThemePanel.classList.remove('open');
            } else {
                clearCustomThemeOverrides();
                if (customThemePanel) customThemePanel.classList.remove('open');
            }
            
            document.querySelectorAll('.theme-btn').forEach(btn => {
                btn.classList.remove('active');
            });
            const activeButton = document.getElementById('theme-' + theme);
            if (activeButton) activeButton.classList.add('active');
        }

        const customThemePanel = document.getElementById('customThemePanel');
        document.addEventListener('click', (event) => {
            const customButton = document.getElementById('theme-custom');
            if (customThemePanel && !customThemePanel.contains(event.target) && !customButton?.contains(event.target)) {
                customThemePanel.classList.remove('open');
            }
        });

        ['customBgPrimary', 'customBgSecondary', 'customTextPrimary', 'customAccentPrimary'].forEach(id => {
            const input = document.getElementById(id);
            if (input) {
                input.addEventListener('input', () => {
                    const previewTheme = collectCustomThemeFromInputs();
                    if (document.documentElement.getAttribute('data-theme') === 'custom') {
                        applyCustomTheme(previewTheme);
                    }
                });
            }
        });

        const applyCustomThemeBtn = document.getElementById('applyCustomThemeBtn');
        if (applyCustomThemeBtn) {
            applyCustomThemeBtn.addEventListener('click', () => {
                const config = collectCustomThemeFromInputs();
                localStorage.setItem(customThemeStorageKey, JSON.stringify(config));
                applyCustomTheme(config);
                setTheme('custom');
                showToast('Custom theme saved');
            });
        }

        const resetCustomThemeBtn = document.getElementById('resetCustomThemeBtn');
        if (resetCustomThemeBtn) {
            resetCustomThemeBtn.addEventListener('click', () => {
                localStorage.setItem(customThemeStorageKey, JSON.stringify(customThemeDefaults));
                populateCustomThemeInputs(customThemeDefaults);
                applyCustomTheme(customThemeDefaults);
                setTheme('custom');
                showToast('Custom theme reset');
            });
        }
        
        // Init Theme
        const savedTheme = localStorage.getItem('theme') || 'dark';
        setTheme(savedTheme);

        let isClickScrolling = false;
        let clickScrollTimeout = null;

        function getChapterContext(element) {
            if (!element) return '';
            const directChapterId = element.getAttribute('data-chapter-id');
            if (directChapterId) return directChapterId;
            const chapterEl = element.closest('[data-chapter-id]');
            return chapterEl ? chapterEl.getAttribute('data-chapter-id') : '';
        }

        function resolveHashTarget(id, contextElement = null) {
            if (!id) return null;
            const matches = Array.from(document.querySelectorAll('[id="' + id + '"]'));
            if (matches.length <= 1) return matches[0] || null;

            const contextChapter = getChapterContext(contextElement);
            if (contextChapter) {
                const chapterMatches = matches.filter(match => match.getAttribute('data-chapter-id') === contextChapter);
                if (chapterMatches.length) {
                    return chapterMatches[0];
                }
            }

            return matches[0];
        }

        function scrollToHashTarget(hash, behavior = 'smooth', contextElement = null) {
            if (!hash) return;
            const id = hash.replace(/^#/, '');
            if (!id) return;

            const target = resolveHashTarget(id, contextElement);
            if (!target) return;

            const offset = 100;
            const top = target.getBoundingClientRect().top + window.scrollY - offset;
            window.scrollTo({ top, behavior });
        }

        document.addEventListener('click', (event) => {
            const link = event.target.closest('a[href^="#"]');
            if (!link) return;

            const href = link.getAttribute('href');
            if (!href || href === '#' || href.startsWith('#!')) return;
            if (event.metaKey || event.ctrlKey || event.altKey || event.shiftKey) return;

            const target = resolveHashTarget(href.slice(1), link);
            if (!target) return;

            event.preventDefault();
            history.pushState(null, '', href);
            scrollToHashTarget(href, 'smooth', link);
        });

        window.addEventListener('hashchange', () => {
            scrollToHashTarget(window.location.hash, 'auto', document.body);
        });

        window.addEventListener('load', () => {
            if (window.location.hash) {
                setTimeout(() => scrollToHashTarget(window.location.hash, 'auto', document.body), 0);
            }
        });
        
        // Populate Sidebar menu
        const menuEl = document.getElementById('sidebarMenu');
        const collapseAllSectionsBtn = document.getElementById('collapseAllSectionsBtn');
        const expandAllSectionsBtn = document.getElementById('expandAllSectionsBtn');
        const focusCurrentPathBtn = document.getElementById('focusCurrentPathBtn');

        function collapseSidebarSections() {
            document.querySelectorAll('.chapter-heading').forEach(heading => heading.classList.add('collapsed'));
            document.querySelectorAll('.chapter-items').forEach(items => items.classList.add('collapsed'));
            document.querySelectorAll('.section-lessons').forEach(lessons => lessons.classList.add('collapsed'));
        }

        function expandSidebarSections() {
            document.querySelectorAll('.chapter-heading').forEach(heading => heading.classList.remove('collapsed'));
            document.querySelectorAll('.chapter-items').forEach(items => items.classList.remove('collapsed'));
            document.querySelectorAll('.section-lessons').forEach(lessons => lessons.classList.remove('collapsed'));
        }

        function focusCurrentSidebarPath() {
            const activeLesson = document.querySelector('.menu-lesson-link.active');
            const activeSection = document.querySelector('.menu-link.active');
            const activeLink = activeLesson || activeSection;

            collapseSidebarSections();

            if (!activeLink) {
                expandSidebarSections();
                return;
            }

            const wrapper = activeLink.closest('.menu-section-wrapper');
            const lessonsDiv = wrapper?.querySelector('.section-lessons');
            const chapterItems = wrapper?.closest('.menu-chapter')?.querySelector('.chapter-items');
            const chapterHeading = chapterItems?.previousElementSibling;

            if (chapterItems) {
                chapterItems.classList.remove('collapsed');
            }
            if (chapterHeading) {
                chapterHeading.classList.remove('collapsed');
            }
            if (lessonsDiv) {
                lessonsDiv.classList.remove('collapsed');
            }
            if (wrapper) {
                const sectionLink = wrapper.querySelector('.menu-link');
                if (sectionLink) {
                    sectionLink.classList.add('active');
                }
            }
            if (activeLink) {
                activeLink.scrollIntoView({ block: 'nearest', behavior: 'smooth' });
            }
        }

        if (collapseAllSectionsBtn) {
            collapseAllSectionsBtn.addEventListener('click', () => {
                collapseSidebarSections();
                showToast('Sidebar collapsed');
            });
        }

        if (expandAllSectionsBtn) {
            expandAllSectionsBtn.addEventListener('click', () => {
                expandSidebarSections();
                showToast('Sidebar expanded');
            });
        }

        if (focusCurrentPathBtn) {
            focusCurrentPathBtn.addEventListener('click', () => {
                focusCurrentSidebarPath();
                showToast('Focused current path');
            });
        }

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
                if (!isCollapsed) {
                    setTimeout(() => {
                        heading.scrollIntoView({ block: 'start', behavior: 'smooth' });
                    }, 50);
                }
            });
            
            chap.sections.forEach(sec => {
                const secWrapper = document.createElement('div');
                secWrapper.className = 'menu-section-wrapper';
                
                const link = document.createElement('a');
                link.href = '#' + sec.id;
                link.className = 'menu-link';
                link.dataset.target = sec.id;
                link.dataset.title = sec.title.toLowerCase();
                link.setAttribute('data-chapter-id', chap.id);
                link.innerHTML = \`<svg viewBox="0 0 24 24" width="14" height="14" stroke="currentColor" stroke-width="2" fill="none"><path d="M12 2L2 7l10 5 10-5-10-5zM2 17l10 5 10-5M2 12l10 5 10-5"></path></svg>\${sec.title}\`;
                
                link.addEventListener('click', (e) => {
                    if (window.innerWidth <= 1024) {
                        document.getElementById('sidebar').classList.remove('open');
                    }

                    isClickScrolling = true;
                    clearTimeout(clickScrollTimeout);
                    clickScrollTimeout = setTimeout(() => {
                        isClickScrolling = false;
                        updateActiveState();
                    }, 800);

                    // Expand parent chapter if collapsed
                    if (itemsDiv.classList.contains('collapsed')) {
                        itemsDiv.classList.remove('collapsed');
                        heading.classList.remove('collapsed');
                    }

                    // Expand this section's lessons, collapse others in this chapter
                    const lessonsDiv = secWrapper.querySelector('.section-lessons');
                    if (lessonsDiv && lessonsDiv.classList.contains('collapsed')) {
                        lessonsDiv.classList.remove('collapsed');
                    }
                    chapDiv.querySelectorAll('.section-lessons').forEach(div => {
                        if (div !== lessonsDiv) {
                            div.classList.add('collapsed');
                        }
                    });

                    // Set active state immediately
                    document.querySelectorAll('.menu-link').forEach(l => l.classList.remove('active'));
                    document.querySelectorAll('.menu-lesson-link').forEach(l => l.classList.remove('active'));
                    link.classList.add('active');

                    // Scroll this item to the top of the sidebar menu
                    setTimeout(() => {
                        link.scrollIntoView({ block: 'start', behavior: 'smooth' });
                    }, 50);
                });
                
                secWrapper.appendChild(link);
                
                if (sec.lessons && sec.lessons.length > 0) {
                    const lessonsDiv = document.createElement('div');
                    lessonsDiv.className = 'section-lessons collapsed';
                    
                    const renderedTitles = new Set();
                    sec.lessons.forEach(les => {
                        if (renderedTitles.has(les.title)) {
                            return;
                        }
                        renderedTitles.add(les.title);
                        
                        const targetId = les.id;
                        
                        const lesLink = document.createElement('a');
                        lesLink.href = '#' + targetId;
                        lesLink.className = 'menu-lesson-link';
                        lesLink.dataset.target = targetId;
                        lesLink.dataset.title = les.title.toLowerCase();
                        lesLink.setAttribute('data-chapter-id', chap.id);
                        lesLink.innerHTML = \`<span class="bullet">■</span> \${les.title}\`;
                        
                        lesLink.addEventListener('click', (e) => {
                            if (window.innerWidth <= 1024) {
                                document.getElementById('sidebar').classList.remove('open');
                            }

                            isClickScrolling = true;
                            clearTimeout(clickScrollTimeout);
                            clickScrollTimeout = setTimeout(() => {
                                isClickScrolling = false;
                                updateActiveState();
                            }, 800);

                            // Expand parent chapter if collapsed
                            if (itemsDiv.classList.contains('collapsed')) {
                                itemsDiv.classList.remove('collapsed');
                                heading.classList.remove('collapsed');
                            }

                            // Expand parent section lessons if collapsed
                            if (lessonsDiv && lessonsDiv.classList.contains('collapsed')) {
                                lessonsDiv.classList.remove('collapsed');
                            }

                            // Set active state immediately
                            document.querySelectorAll('.menu-link').forEach(l => l.classList.remove('active'));
                            document.querySelectorAll('.menu-lesson-link').forEach(l => l.classList.remove('active'));
                            lesLink.classList.add('active');

                            // Scroll this item into view (nearest/center)
                            setTimeout(() => {
                                lesLink.scrollIntoView({ block: 'nearest', behavior: 'smooth' });
                            }, 50);
                        });
                        lessonsDiv.appendChild(lesLink);
                    });
                    
                    secWrapper.appendChild(lessonsDiv);
                }
                
                itemsDiv.appendChild(secWrapper);
            });
            
            chapDiv.appendChild(heading);
            chapDiv.appendChild(itemsDiv);
            menuEl.appendChild(chapDiv);
        });
        
        // Mobile & Desktop Sidebar toggler
        const sidebar = document.getElementById('sidebar');
        const toggleBtn = document.getElementById('toggleSidebarBtn');
        const sidebarBackdrop = document.getElementById('sidebarBackdrop');
        const sidebarCloseBtn = document.getElementById('sidebarCloseBtn');
        const shortcutsToggle = document.getElementById('shortcutsToggle');
        const shortcutsPanel = document.getElementById('shortcutsPanel');
        const focusModeBtn = document.getElementById('focusModeBtn');
        const tocWidget = document.getElementById('fontSizeWidget');
        const sidebarResizer = document.getElementById('sidebarResizer');
        const breadcrumbBar = document.getElementById('breadcrumbBar');
        const tocToggle = document.getElementById('tocToggle');
        const tocPanel = document.getElementById('tocPanel');

        let sidebarWidth = parseInt(localStorage.getItem('vguide-sidebar-width') || '320', 10);

        function applySidebarWidth(width) {
            sidebarWidth = Math.max(260, Math.min(420, width));
            document.documentElement.style.setProperty('--sidebar-width', sidebarWidth + 'px');
            try { localStorage.setItem('vguide-sidebar-width', sidebarWidth); } catch (e) {}
        }

        function setSidebarOpen(isOpen) {
            sidebar.classList.toggle('open', isOpen);
            if (window.innerWidth <= 1024) {
                document.body.classList.toggle('sidebar-open-mobile', isOpen);
                sidebarBackdrop.classList.toggle('visible', isOpen);
            } else {
                document.body.classList.remove('sidebar-open-mobile');
                sidebarBackdrop.classList.remove('visible');
            }
        }

        toggleBtn.addEventListener('click', () => {
            if (window.innerWidth <= 1024) {
                setSidebarOpen(!sidebar.classList.contains('open'));
            } else {
                document.body.classList.toggle('sidebar-collapsed');
            }
        });

        if (sidebarCloseBtn) {
            sidebarCloseBtn.addEventListener('click', () => setSidebarOpen(false));
        }

        if (sidebarBackdrop) {
            sidebarBackdrop.addEventListener('click', () => setSidebarOpen(false));
        }

        if (sidebarResizer) {
            sidebarResizer.addEventListener('mousedown', (event) => {
                event.preventDefault();
                const startX = event.clientX;
                const startWidth = sidebarWidth;
                const onMove = (moveEvent) => {
                    const delta = moveEvent.clientX - startX;
                    applySidebarWidth(startWidth + delta);
                };
                const onUp = () => {
                    window.removeEventListener('mousemove', onMove);
                    window.removeEventListener('mouseup', onUp);
                };
                window.addEventListener('mousemove', onMove);
                window.addEventListener('mouseup', onUp);
            });
        }

        if (tocToggle) {
            tocToggle.addEventListener('click', (event) => {
                event.stopPropagation();
                tocWidget.classList.toggle('open');
            });
        }

        if (quickJumpToggle) {
            quickJumpToggle.addEventListener('click', (event) => {
                event.stopPropagation();
                quickJumpWidget.classList.toggle('open');
            });
        }

        const quickJumpBackToTop = document.getElementById('quickJumpBackToTop');
        const quickJumpToggleFocus = document.getElementById('quickJumpToggleFocus');

        if (quickJumpBackToTop) {
            quickJumpBackToTop.addEventListener('click', () => {
                window.scrollTo({ top: 0, behavior: 'smooth' });
                quickJumpWidget.classList.remove('open');
            });
        }

        if (quickJumpToggleFocus) {
            quickJumpToggleFocus.addEventListener('click', () => {
                toggleFocusMode();
                quickJumpWidget.classList.remove('open');
            });
        }

        document.addEventListener('click', (event) => {
            if (shortcutsToggle && shortcutsPanel && !shortcutsToggle.contains(event.target) && !shortcutsPanel.contains(event.target)) {
                shortcutsPanel.classList.remove('visible');
            }
            if (tocWidget && !tocWidget.contains(event.target)) {
                tocWidget.classList.remove('open');
            }
            if (quickJumpWidget && !quickJumpWidget.contains(event.target)) {
                quickJumpWidget.classList.remove('open');
            }
        });

        if (shortcutsToggle) {
            shortcutsToggle.addEventListener('click', (event) => {
                event.stopPropagation();
                shortcutsPanel.classList.toggle('visible');
            });
        }

        function toggleFocusMode(forceState) {
            const isEnabled = typeof forceState === 'boolean' ? forceState : !document.body.classList.contains('focus-mode');
            document.body.classList.toggle('focus-mode', isEnabled);
            if (focusModeBtn) {
                focusModeBtn.textContent = isEnabled ? 'Exit focus' : 'Focus mode';
                focusModeBtn.setAttribute('aria-pressed', isEnabled ? 'true' : 'false');
            }
            if (quickJumpToggleFocus) {
                quickJumpToggleFocus.textContent = isEnabled ? 'Exit focus' : 'Toggle focus';
            }
            return isEnabled;
        }

        if (focusModeBtn) {
            focusModeBtn.addEventListener('click', () => toggleFocusMode());
        }
        
        // Scroll / Reading progress & Sidebar active link highlight
        const progress = document.getElementById('readingProgress');
        const btnTop = document.getElementById('btnTop');
        const currentSectionTitleEl = document.getElementById('currentSectionTitle');
        const LAST_READ_KEY = 'vguide-last-read';
        const COMPLETED_LESSONS_KEY = 'vguide-completed-lessons';
        const CONTINUE_READING_DISMISS_KEY = 'vguide-continue-reading-dismissed';
        const progressState = {
            completedLessons: []
        };
        let lessonEntries = [];
        let saveReadingStateTimer = null;

        function getActiveHeadingId() {
            const headings = Array.from(document.querySelectorAll('h1.chapter-title, h2.section-title, h3.lesson-title'));
            let activeId = '';
            headings.forEach(head => {
                const rect = head.getBoundingClientRect();
                if (rect.top < 140) {
                    activeId = head.id;
                }
            });
            return activeId;
        }

        function loadCompletedLessons() {
            try {
                progressState.completedLessons = JSON.parse(localStorage.getItem(COMPLETED_LESSONS_KEY) || '[]');
            } catch (e) {
                progressState.completedLessons = [];
            }
        }

        function saveCompletedLessons() {
            try { localStorage.setItem(COMPLETED_LESSONS_KEY, JSON.stringify(progressState.completedLessons)); } catch (e) {}
        }

        function markLessonComplete(lessonId) {
            if (!lessonId) return;
            const index = progressState.completedLessons.indexOf(lessonId);
            if (index === -1) {
                progressState.completedLessons.push(lessonId);
            } else {
                progressState.completedLessons.splice(index, 1);
            }
            saveCompletedLessons();
            renderChapterProgress();
            updateLessonCompletionButtons();
        }

        function updateLessonCompletionButtons() {
            document.querySelectorAll('.lesson-complete-btn').forEach(btn => {
                const lessonId = btn.getAttribute('data-lesson-id');
                btn.classList.toggle('active', progressState.completedLessons.includes(lessonId));
                btn.innerHTML = progressState.completedLessons.includes(lessonId) ? '✓ Completed' : '○ Mark done';
            });
        }

        function saveReadingState() {
            const payload = {
                hash: getActiveHeadingId() ? '#' + getActiveHeadingId() : window.location.hash || '',
                scrollY: window.scrollY
            };
            try { localStorage.setItem(LAST_READ_KEY, JSON.stringify(payload)); } catch (e) {}
        }

        function getSavedReadingState() {
            try {
                return JSON.parse(localStorage.getItem(LAST_READ_KEY) || 'null');
            } catch (e) {
                return null;
            }
        }

        function getHeadingTextForId(targetId) {
            const target = targetId ? document.getElementById(targetId) : null;
            if (!target) return '';
            return target.textContent.replace(/Chapter \d+:/i, '').replace(/^Lesson:\s*/i, '').trim();
        }

        function showContinueReadingCard(saved = getSavedReadingState()) {
            const card = document.getElementById('continueReadingCard');
            const copy = document.getElementById('continueReadingCopy');
            if (!card || !copy) return;

            if (!saved || typeof saved.scrollY !== 'number' || window.location.hash || localStorage.getItem(CONTINUE_READING_DISMISS_KEY) === '1') {
                card.classList.remove('visible');
                return;
            }

            const targetId = saved.hash ? saved.hash.replace(/^#/, '') : '';
            const title = getHeadingTextForId(targetId) || 'your last lesson';
            copy.textContent = \`Resume from “\${title}” and pick up right where you left off.\`;
            card.classList.add('visible');
        }

        function hideContinueReadingCard() {
            const card = document.getElementById('continueReadingCard');
            if (card) card.classList.remove('visible');
        }

        function scheduleSaveReadingState() {
            clearTimeout(saveReadingStateTimer);
            saveReadingStateTimer = setTimeout(saveReadingState, 180);
        }

        function restoreReadingState(force = false) {
            if (!force && window.location.hash) return false;
            const saved = getSavedReadingState();
            if (!saved || typeof saved.scrollY !== 'number') return false;
            const targetId = saved.hash ? saved.hash.replace(/^#/, '') : '';
            const target = targetId ? document.getElementById(targetId) : null;
            if (target) {
                setTimeout(() => scrollToHashTarget(saved.hash, 'auto', document.body), 220);
            } else {
                window.scrollTo({ top: Math.max(0, saved.scrollY), behavior: 'auto' });
            }
            return true;
        }

        function renderBreadcrumbs() {
            if (!breadcrumbBar) return;
            const headings = Array.from(document.querySelectorAll('h1.chapter-title, h2.section-title, h3.lesson-title'));
            const activeHeading = headings.find(heading => {
                const rect = heading.getBoundingClientRect();
                return rect.top < 140;
            }) || headings[0];

            if (!activeHeading) {
                breadcrumbBar.innerHTML = '';
                return;
            }

            const chapter = activeHeading.closest('.chapter-section')?.querySelector('h1.chapter-title') || null;
            const section = activeHeading.tagName === 'H2' || activeHeading.tagName === 'H3' ? activeHeading : null;
            const crumbs = [];
            if (chapter) crumbs.push({ label: chapter.textContent.replace(/Chapter \d+:/i, '').trim(), current: chapter.id === activeHeading.id });
            if (section) crumbs.push({ label: section.textContent.trim(), current: section.id === activeHeading.id });
            if (activeHeading.tagName === 'H3') crumbs.push({ label: activeHeading.textContent.trim(), current: true });

            breadcrumbBar.innerHTML = '';
            crumbs.forEach((crumb, index) => {
                const pill = document.createElement('span');
                pill.className = 'breadcrumb-pill' + (crumb.current ? ' current' : '');
                pill.textContent = crumb.label;
                breadcrumbBar.appendChild(pill);
                if (index < crumbs.length - 1) {
                    const sep = document.createElement('span');
                    sep.textContent = '›';
                    breadcrumbBar.appendChild(sep);
                }
            });
        }

        function renderChapterProgress() {
            const chapterSections = Array.from(document.querySelectorAll('.chapter-section'));
            chapterSections.forEach(section => {
                const heading = section.querySelector('h1.chapter-title');
                if (!heading) return;
                const existing = section.querySelector('.chapter-progress-wrap');
                if (existing) existing.remove();

                const wrap = document.createElement('div');
                wrap.className = 'chapter-progress-wrap';

                const progressBar = document.createElement('div');
                progressBar.className = 'chapter-progress-bar';
                const fill = document.createElement('div');
                fill.className = 'chapter-progress-fill';
                progressBar.appendChild(fill);

                const label = document.createElement('div');
                label.className = 'chapter-progress-label';

                const lessons = Array.from(section.querySelectorAll('h3.lesson-title'));
                const completedCount = lessons.filter(lesson => progressState.completedLessons.includes(lesson.id)).length;
                const percent = lessons.length ? Math.round((completedCount / lessons.length) * 100) : 0;
                fill.style.width = percent + '%';
                label.textContent = completedCount + ' of ' + lessons.length + ' lessons completed';

                wrap.appendChild(progressBar);
                wrap.appendChild(label);
                heading.insertAdjacentElement('afterend', wrap);
            });
        }

        function renderTableOfContents() {
            if (!tocPanel) return;
            const headings = Array.from(document.querySelectorAll('h1.chapter-title, h2.section-title, h3.lesson-title'));
            tocPanel.innerHTML = '';
            headings.forEach(heading => {
                if (!heading.id) return;
                const link = document.createElement('a');
                link.className = 'toc-link';
                link.href = '#' + heading.id;
                link.textContent = heading.textContent.replace(/Chapter \d+:/i, '').replace(/^Lesson:\s*/i, '').trim();
                link.addEventListener('click', (event) => {
                    event.preventDefault();
                    history.pushState(null, '', '#' + heading.id);
                    scrollToHashTarget('#' + heading.id, 'smooth', heading);
                    tocWidget.classList.remove('open');
                });
                tocPanel.appendChild(link);
            });
        }

        function renderQuickJump() {
            if (!quickJumpPanel) return;
            const chapters = Array.from(document.querySelectorAll('.chapter-section'));
            const actions = quickJumpPanel.querySelector('.quick-jump-actions');
            quickJumpPanel.innerHTML = '';
            if (actions) {
                quickJumpPanel.appendChild(actions);
            }
            chapters.forEach(chapter => {
                const heading = chapter.querySelector('h1.chapter-title');
                if (!heading || !heading.id) return;
                const link = document.createElement('a');
                link.className = 'quick-jump-link';
                link.href = '#' + heading.id;
                link.textContent = heading.textContent.replace(/Chapter \d+:/i, '').trim();
                link.addEventListener('click', (event) => {
                    event.preventDefault();
                    history.pushState(null, '', '#' + heading.id);
                    scrollToHashTarget('#' + heading.id, 'smooth', heading);
                    quickJumpWidget.classList.remove('open');
                });
                quickJumpPanel.appendChild(link);
            });
        }
        
        function updateActiveState() {
            // Highlight active navigation section or lesson
            const headings = document.querySelectorAll('h1.chapter-title, h2.section-title, h3.lesson-title');
            let activeId = '';
            let currentTitle = 'Welcome';
            
            headings.forEach(head => {
                const rect = head.getBoundingClientRect();
                if (rect.top < 120) {
                    activeId = head.id;
                    currentTitle = head.innerText.replace(/Chapter \\d+:/i, '').replace(/^Lesson:\\s*/i, '').trim();
                }
            });
            
            if (activeId) {
                // Highlight section links
                const targetId = activeId;

                document.querySelectorAll('.menu-link').forEach(link => {
                    const isDirectActive = (link.dataset.target === targetId || link.getAttribute('href') === '#' + targetId);
                    
                    // Check if targetId is a lesson inside this section's wrapper
                    const wrapper = link.closest('.menu-section-wrapper');
                    const hasActiveLessonInside = wrapper && wrapper.querySelector('.menu-lesson-link[data-target="' + targetId + '"]');
                    
                    if (isDirectActive) {
                        link.classList.add('active');
                    } else {
                        link.classList.remove('active');
                    }

                    // Handle lessons expansion for this section
                    if (wrapper) {
                        const lessonsDiv = wrapper.querySelector('.section-lessons');
                        if (lessonsDiv) {
                            if (isDirectActive || hasActiveLessonInside) {
                                lessonsDiv.classList.remove('collapsed');
                            } else {
                                lessonsDiv.classList.add('collapsed');
                            }
                        }
                    }
                });

                // Highlight lesson links
                document.querySelectorAll('.menu-lesson-link').forEach(link => {
                    const isDirectActive = (link.dataset.target === targetId || link.getAttribute('href') === '#' + targetId);
                    
                    if (isDirectActive) {
                        link.classList.add('active');
                        
                        // Automatically expand parent chapter items
                        const parentItems = link.closest('.chapter-items');
                        if (parentItems && parentItems.classList.contains('collapsed')) {
                            parentItems.classList.remove('collapsed');
                            const heading = parentItems.previousElementSibling;
                            if (heading) heading.classList.remove('collapsed');
                        }
                    } else {
                        link.classList.remove('active');
                    }
                });

                // Also make sure chapter items are expanded for active section
                document.querySelectorAll('.menu-link.active').forEach(link => {
                    const parentItems = link.closest('.chapter-items');
                    if (parentItems && parentItems.classList.contains('collapsed')) {
                        parentItems.classList.remove('collapsed');
                        const heading = parentItems.previousElementSibling;
                        if (heading) heading.classList.remove('collapsed');
                    }
                });

                if (currentSectionTitleEl) {
                    currentSectionTitleEl.innerText = currentTitle;
                }
            } else {
                // keep the current view without inline lesson navigation
            }

            document.querySelectorAll('.toc-link').forEach(link => {
                link.classList.toggle('active', link.getAttribute('href') === '#' + activeId);
            });

            renderBreadcrumbs();
            scheduleSaveReadingState();
        }
        
        window.addEventListener('scroll', () => {
            const totalHeight = document.documentElement.scrollHeight - window.innerHeight;
            if (totalHeight > 0) {
                const scrolled = (window.scrollY / totalHeight) * 100;
                progress.style.width = scrolled + '%';
                const pctEl = document.getElementById('readingPct');
                if (pctEl) pctEl.textContent = Math.round(scrolled) + '%';
            }

            if (window.scrollY > 300) {
                btnTop.classList.add('visible');
            } else {
                btnTop.classList.remove('visible');
            }

            if (!isClickScrolling) {
                updateActiveState();
            }
        });
        
        function scrollToTop() {
            window.scrollTo({ top: 0, behavior: 'smooth' });
        }

        function slugifyHeading(text) {
            return (text || '').toLowerCase().trim().replace(/[^a-z0-9]+/g, '-').replace(/(^-|-$)/g, '');
        }

        function showToast(message) {
            const toast = document.getElementById('toastNotification');
            if (!toast) return;
            toast.textContent = message;
            toast.classList.add('visible');
            clearTimeout(showToast.timeoutId);
            showToast.timeoutId = setTimeout(() => {
                toast.classList.remove('visible');
            }, 1800);
        }

        function copyLinkToClipboard(url) {
            if (navigator.clipboard && navigator.clipboard.writeText) {
                return navigator.clipboard.writeText(url).then(() => true).catch(() => false);
            }

            const textarea = document.createElement('textarea');
            textarea.value = url;
            textarea.setAttribute('readonly', '');
            textarea.style.position = 'fixed';
            textarea.style.left = '-9999px';
            document.body.appendChild(textarea);
            textarea.select();
            const copied = document.execCommand('copy');
            document.body.removeChild(textarea);
            return Promise.resolve(copied);
        }

        function attachHeadingActions() {
            document.querySelectorAll('h1.chapter-title, h2.section-title, h3.lesson-title, h4.lesson-subtitle').forEach(heading => {
                if (!heading.id) {
                    heading.id = slugifyHeading(heading.textContent);
                }

                if (!heading.querySelector('.heading-action-btn')) {
                    const actionBtn = document.createElement('button');
                    actionBtn.type = 'button';
                    actionBtn.className = 'heading-action-btn';
                    actionBtn.title = 'Copy link to this section';
                    actionBtn.setAttribute('aria-label', 'Copy link to this section');
                    actionBtn.innerHTML = '<svg viewBox="0 0 24 24" width="14" height="14" stroke="currentColor" stroke-width="2" fill="none" stroke-linecap="round" stroke-linejoin="round"><path d="M10 13a5 5 0 0 0 7.54.54l3-3a5 5 0 0 0-7.07-7.07l-1.72 1.71"></path><path d="M14 11a5 5 0 0 0-7.54-.54l-3 3a5 5 0 0 0 7.07 7.07l1.71-1.71"></path></svg>';
                    actionBtn.addEventListener('click', async (event) => {
                        event.preventDefault();
                        event.stopPropagation();
                        const url = window.location.href.split('#')[0] + '#' + heading.id;
                        const copied = await copyLinkToClipboard(url);
                        showToast(copied ? 'Link copied to clipboard' : 'Unable to copy link');
                    });
                    heading.appendChild(actionBtn);
                }

                if (heading.tagName === 'H3' && heading.classList.contains('lesson-title') && !heading.querySelector('.lesson-complete-btn')) {
                    const completeBtn = document.createElement('button');
                    completeBtn.type = 'button';
                    completeBtn.className = 'lesson-complete-btn';
                    completeBtn.setAttribute('data-lesson-id', heading.id);
                    completeBtn.title = 'Mark lesson complete';
                    completeBtn.setAttribute('aria-label', 'Mark lesson complete');
                    completeBtn.addEventListener('click', (event) => {
                        event.preventDefault();
                        event.stopPropagation();
                        markLessonComplete(heading.id);
                        showToast(progressState.completedLessons.includes(heading.id) ? 'Lesson marked complete' : 'Lesson marked incomplete');
                    });
                    heading.appendChild(completeBtn);
                }
            });
            updateLessonCompletionButtons();
        }
        
        const continueReadingBtn = document.getElementById('continueReadingBtn');
        const dismissContinueReadingBtn = document.getElementById('dismissContinueReadingBtn');

        if (continueReadingBtn) {
            continueReadingBtn.addEventListener('click', () => {
                restoreReadingState(true);
                hideContinueReadingCard();
            });
        }

        if (dismissContinueReadingBtn) {
            dismissContinueReadingBtn.addEventListener('click', () => {
                try { localStorage.setItem(CONTINUE_READING_DISMISS_KEY, '1'); } catch (e) {}
                hideContinueReadingCard();
            });
        }

        const commandPaletteBtn = document.getElementById('commandPaletteBtn');
        const commandPaletteOverlay = document.getElementById('commandPaletteOverlay');
        const commandPaletteInput = document.getElementById('commandPaletteInput');
        const commandPaletteResults = document.getElementById('commandPaletteResults');
        let commandPaletteIndex = 0;

        function normalizePaletteText(text) {
            return (text || '').toLowerCase().replace(/[^a-z0-9\s]/g, ' ').replace(/\s+/g, ' ').trim();
        }

        function getNavigationEntries() {
            return Array.from(document.querySelectorAll('h1.chapter-title, h2.section-title, h3.lesson-title'))
                .map(heading => {
                    const chapterTitle = heading.closest('.chapter-section')?.querySelector('h1.chapter-title')?.textContent || '';
                    const sectionTitle = heading.tagName === 'H3' ? heading.closest('.chapter-section')?.querySelector('h2.section-title')?.textContent || '' : '';
                    const displayTitle = heading.textContent.replace(/Chapter \d+:/i, '').replace(/^Lesson:\s*/i, '').trim();
                    const type = heading.tagName === 'H1' ? 'Chapter' : heading.tagName === 'H2' ? 'Section' : 'Lesson';
                    const path = heading.tagName === 'H3' ? chapterTitle.replace(/Chapter \d+:/i, '').trim() + ' › ' + sectionTitle.replace(/Chapter \d+:/i, '').trim() : chapterTitle.replace(/Chapter \d+:/i, '').trim();
                    return {
                        id: heading.id,
                        title: displayTitle,
                        type,
                        path: path || 'Guide'
                    };
                })
                .filter(entry => entry.id && entry.title);
        }

        function renderCommandPaletteResults(query = '') {
            if (!commandPaletteResults) return;
            const normalizedQuery = normalizePaletteText(query);
            const entries = getNavigationEntries().filter(entry => {
                const haystack = normalizePaletteText(entry.title + ' ' + entry.path + ' ' + entry.type);
                return !normalizedQuery || haystack.includes(normalizedQuery);
            }).slice(0, 8);

            commandPaletteIndex = 0;
            commandPaletteResults.innerHTML = '';

            if (!entries.length) {
                const emptyItem = document.createElement('div');
                emptyItem.className = 'command-palette-item muted';
                emptyItem.textContent = 'No matching lessons or chapters';
                commandPaletteResults.appendChild(emptyItem);
                return;
            }

            entries.forEach((entry, index) => {
                const item = document.createElement('button');
                item.type = 'button';
                item.className = 'command-palette-item' + (index === 0 ? ' active' : '');
                item.innerHTML = '<div class="command-palette-title">' + entry.title + '</div><div class="command-palette-meta">' + entry.type + ' · ' + entry.path + '</div>';
                item.addEventListener('click', () => {
                    const target = document.getElementById(entry.id);
                    if (target) {
                        history.pushState(null, '', '#' + entry.id);
                        scrollToHashTarget('#' + entry.id, 'smooth', target);
                    }
                    closeCommandPalette();
                });
                commandPaletteResults.appendChild(item);
            });
        }

        function openCommandPalette() {
            if (!commandPaletteOverlay || !commandPaletteInput) return;
            commandPaletteOverlay.classList.add('visible');
            commandPaletteInput.value = '';
            renderCommandPaletteResults();
            setTimeout(() => commandPaletteInput.focus(), 0);
        }

        function closeCommandPalette() {
            if (!commandPaletteOverlay) return;
            commandPaletteOverlay.classList.remove('visible');
            if (commandPaletteInput) commandPaletteInput.blur();
        }

        if (commandPaletteBtn) {
            commandPaletteBtn.addEventListener('click', (event) => {
                event.stopPropagation();
                openCommandPalette();
            });
        }

        if (commandPaletteOverlay) {
            commandPaletteOverlay.addEventListener('click', (event) => {
                if (event.target === commandPaletteOverlay) {
                    closeCommandPalette();
                }
            });
        }

        if (commandPaletteInput) {
            commandPaletteInput.addEventListener('input', (event) => {
                renderCommandPaletteResults(event.target.value);
            });

            commandPaletteInput.addEventListener('keydown', (event) => {
                const items = commandPaletteResults?.querySelectorAll('.command-palette-item:not(.muted)') || [];
                if (!items.length) return;

                if (event.key === 'ArrowDown') {
                    event.preventDefault();
                    commandPaletteIndex = (commandPaletteIndex + 1) % items.length;
                    items.forEach((item, index) => item.classList.toggle('active', index === commandPaletteIndex));
                } else if (event.key === 'ArrowUp') {
                    event.preventDefault();
                    commandPaletteIndex = (commandPaletteIndex - 1 + items.length) % items.length;
                    items.forEach((item, index) => item.classList.toggle('active', index === commandPaletteIndex));
                } else if (event.key === 'Enter') {
                    event.preventDefault();
                    const activeItem = items[commandPaletteIndex];
                    if (activeItem) activeItem.click();
                } else if (event.key === 'Escape') {
                    event.preventDefault();
                    closeCommandPalette();
                }
            });
        }

        // Search functionality
        const searchInput = document.getElementById('searchInput');
        const searchClearBtn = document.getElementById('searchClearBtn');
        const overlay = document.getElementById('searchResultsOverlay');
        const resultsList = document.getElementById('resultsList');
        const resultsSummary = document.getElementById('resultsSummary');

        function normalizeSearchText(text) {
            return (text || '').toLowerCase().replace(/[^a-z0-9\s]/g, ' ').replace(/\s+/g, ' ').trim();
        }

        function textMatchesQuery(text, query) {
            const normalizedText = normalizeSearchText(text);
            if (!query || !normalizedText) return false;
            const terms = query.split(/\s+/).filter(Boolean);
            return terms.every(term => normalizedText.includes(term));
        }

        function resetSidebarSearchState() {
            document.querySelectorAll('.menu-chapter').forEach(chapDiv => {
                chapDiv.style.display = '';
                const heading = chapDiv.querySelector('.chapter-heading');
                const itemsDiv = chapDiv.querySelector('.chapter-items');
                if (heading) heading.classList.remove('collapsed');
                if (itemsDiv) itemsDiv.classList.remove('collapsed');

                chapDiv.querySelectorAll('.menu-section-wrapper').forEach(w => w.style.display = '');
                chapDiv.querySelectorAll('.menu-link').forEach(link => {
                    link.style.display = '';
                });
                chapDiv.querySelectorAll('.menu-lesson-link').forEach(link => {
                    link.style.display = '';
                });
                chapDiv.querySelectorAll('.section-lessons').forEach(div => {
                    div.classList.add('collapsed');
                });
            });
        }
        
        function updateSearchClearButton() {
            if (!searchClearBtn) return;
            searchClearBtn.classList.toggle('visible', searchInput.value.trim().length > 0);
        }

        function clearSearch() {
            searchInput.value = '';
            updateSearchClearButton();
            resetSidebarSearchState();
            overlay.style.display = 'none';
            resultsSummary.innerText = 'Search Results';
            resultsList.innerHTML = '';
            searchInput.focus();
        }

        if (searchClearBtn) {
            searchClearBtn.addEventListener('click', (event) => {
                event.preventDefault();
                event.stopPropagation();
                clearSearch();
            });
        }

        searchInput.addEventListener('input', (e) => {
            const query = normalizeSearchText(e.target.value);
            updateSearchClearButton();

            if (query.length === 0) {
                resetSidebarSearchState();
                overlay.style.display = 'none';
                return;
            }
            
            document.querySelectorAll('.menu-chapter').forEach(chapDiv => {
                const chapTitle = chapDiv.dataset.title || '';
                const heading = chapDiv.querySelector('.chapter-heading');
                const itemsDiv = chapDiv.querySelector('.chapter-items');
                let hasVisibleSectionOrLesson = false;
                
                chapDiv.querySelectorAll('.menu-section-wrapper').forEach(wrapper => {
                    const sectionLink = wrapper.querySelector('.menu-link');
                    const sectionTitle = sectionLink ? (sectionLink.dataset.title || '') : '';
                    let hasVisibleLesson = false;
                    
                    wrapper.querySelectorAll('.menu-lesson-link').forEach(lessonLink => {
                        const lessonTitle = lessonLink.dataset.title || '';
                        const combinedLessonText = chapTitle + ' ' + sectionTitle + ' ' + lessonTitle;
                        if (textMatchesQuery(combinedLessonText, query)) {
                            lessonLink.style.display = '';
                            hasVisibleLesson = true;
                        } else {
                            lessonLink.style.display = 'none';
                        }
                    });
                    
                    const lessonsDiv = wrapper.querySelector('.section-lessons');
                    if (lessonsDiv) {
                        if (hasVisibleLesson) {
                            lessonsDiv.classList.remove('collapsed');
                        } else {
                            lessonsDiv.classList.add('collapsed');
                        }
                    }

                    const combinedSectionText = chapTitle + ' ' + sectionTitle;
                    if (textMatchesQuery(combinedSectionText, query) || hasVisibleLesson) {
                        wrapper.style.display = '';
                        if (sectionLink) sectionLink.style.display = '';
                        hasVisibleSectionOrLesson = true;
                    } else {
                        wrapper.style.display = 'none';
                    }
                });
                
                if (hasVisibleSectionOrLesson || textMatchesQuery(chapTitle, query)) {
                    chapDiv.style.display = '';
                    if (itemsDiv) itemsDiv.classList.remove('collapsed');
                    if (heading) heading.classList.remove('collapsed');
                } else {
                    chapDiv.style.display = 'none';
                }
            });
            
            overlay.style.display = 'block';
            const hits = [];
            
            searchIndex.forEach(item => {
                const combinedText = [item.title, item.content, item.chapter || '', item.section || ''].join(' ');
                if (!textMatchesQuery(combinedText, query)) {
                    return;
                }

                const titleText = normalizeSearchText(item.title);
                const contentText = normalizeSearchText(item.content);
                const titleIndex = titleText.indexOf(query);
                const contentIndex = contentText.indexOf(query);
                
                let snippet = '';
                if (contentIndex !== -1) {
                    const start = Math.max(0, contentIndex - 40);
                    const end = Math.min(item.content.length, contentIndex + 100);
                    snippet = item.content.substring(start, end);
                    
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
                    score: titleIndex !== -1 ? 10 : 1
                });
            });
            
            hits.sort((a, b) => b.score - a.score);
            
            resultsSummary.innerText = 'Search Results (' + hits.length + ' found)';
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
                
                itemDiv.innerHTML = '<div class="result-meta">' +
                    '<span class="result-type">' + hit.type + '</span>' +
                    '<span class="result-path">' + pathStr + '</span>' +
                    '</div>' +
                    '<div class="result-title">' + hit.title + '</div>' +
                    '<div class="result-snippet">' + hit.snippet + '</div>';
                
                itemDiv.addEventListener('click', () => {
                    overlay.style.display = 'none';
                    clearSearch();
                    window.location.hash = hit.id;
                });
                
                resultsList.appendChild(itemDiv);
            });
        });
        
        function escapeRegExp(string) {
            return string.replace(/[.*+?^\${}()|[\\]\\\\]/g, '\\\\$&');
        }

        function closeCodeZoom() {
            const modal = document.getElementById('code-zoom-modal');
            if (modal) {
                modal.remove();
            }
        }

        function toggleCodeZoom(btn) {
            const sourceWrapper = btn.closest('.code-wrapper');
            const existingModal = document.getElementById('code-zoom-modal');
            if (existingModal) {
                existingModal.remove();
                return;
            }

            const modal = document.createElement('div');
            modal.id = 'code-zoom-modal';
            modal.className = 'code-zoom-modal active';
            modal.addEventListener('click', (event) => {
                if (event.target === modal) {
                    closeCodeZoom();
                }
            });

            const panel = document.createElement('div');
            panel.className = 'code-zoom-panel';

            const wrapper = document.createElement('div');
            wrapper.className = 'code-wrapper code-wrapper-zoomed';

            const header = document.createElement('div');
            header.className = 'code-header';

            const lang = document.createElement('span');
            lang.className = 'code-lang';
            lang.textContent = sourceWrapper.querySelector('.code-lang').textContent;
            header.appendChild(lang);

            const actions = document.createElement('div');
            actions.className = 'code-actions';

            const closeBtn = document.createElement('button');
            closeBtn.className = 'btn-close-zoom';
            closeBtn.title = 'Close Zoom';
            closeBtn.innerHTML = '<svg viewBox="0 0 24 24" width="16" height="16" stroke="currentColor" stroke-width="2" fill="none" stroke-linecap="round" stroke-linejoin="round"><line x1="18" y1="6" x2="6" y2="18"></line><line x1="6" y1="6" x2="18" y2="18"></line></svg> Close';
            closeBtn.addEventListener('click', closeCodeZoom);
            actions.appendChild(closeBtn);

            const copyBtn = document.createElement('button');
            copyBtn.className = 'btn-copy';
            copyBtn.title = 'Copy Code';
            copyBtn.innerHTML = '<svg class="copy-icon" viewBox="0 0 24 24" width="16" height="16" stroke="currentColor" stroke-width="2" fill="none" stroke-linecap="round" stroke-linejoin="round"><rect x="9" y="9" width="13" height="13" rx="2" ry="2"></rect><path d="M5 15H4a2 2 0 0 1-2-2V4a2 2 0 0 1 2-2h9a2 2 0 0 1 2 2v1"></path></svg> Copy';
            copyBtn.onclick = () => copyCode(copyBtn);
            actions.appendChild(copyBtn);

            header.appendChild(actions);
            wrapper.appendChild(header);

            const pre = document.createElement('pre');
            const code = document.createElement('code');
            code.className = sourceWrapper.querySelector('code').className;
            code.textContent = sourceWrapper.querySelector('code').innerText;
            pre.appendChild(code);
            wrapper.appendChild(pre);
            panel.appendChild(wrapper);
            modal.appendChild(panel);
            document.body.appendChild(modal);
            if (window.Prism) {
                Prism.highlightElement(code);
            }
        }
        
        // Copy Code utility
        function copyCode(btn) {
            const codeBlock = btn.closest('.code-wrapper').querySelector('code');
            
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

        function copyAndOpenPlayground(btn) {
            const codeBlock = btn.closest('.code-wrapper').querySelector('code');
            const codeText = codeBlock.innerText;
            navigator.clipboard.writeText(codeText).then(() => {
                const originalText = btn.innerHTML;
                btn.innerHTML = \`<svg viewBox="0 0 24 24" width="16" height="16" stroke="currentColor" stroke-width="2" fill="none"><polyline points="20 6 9 17 4 12"></polyline></svg> Copied!\`;
                btn.style.color = '#34d399';
                setTimeout(() => {
                    btn.innerHTML = originalText;
                    btn.style.color = '';
                    const base64 = btoa(unescape(encodeURIComponent(codeText)));
                    window.open(\`https://play.vlang.io/?base64=\${encodeURIComponent(base64)}\`, '_blank');
                }, 800);
            }).catch(err => {
                console.error('Failed to copy text: ', err);
                const base64 = btoa(unescape(encodeURIComponent(codeText)));
                window.open(\`https://play.vlang.io/?base64=\${encodeURIComponent(base64)}\`, '_blank');
            });
        }

        function renderLessonNavigation() {
            lessonEntries = [];
            (bookStructure || []).forEach(chapter => {
                (chapter.sections || []).forEach(section => {
                    (section.lessons || []).forEach(lesson => {
                        lessonEntries.push({
                            id: lesson.id,
                            title: lesson.title,
                            chapter: chapter.title,
                            section: section.title
                        });
                    });
                });
            });

            const headings = Array.from(document.querySelectorAll('.lesson-title'));
            headings.forEach((heading, index) => {
                const lessonIndex = lessonEntries.findIndex(entry => entry.id === heading.id);
                if (lessonIndex === -1) return;

                const prevEntry = lessonIndex > 0 ? lessonEntries[lessonIndex - 1] : null;
                const nextEntry = lessonIndex < lessonEntries.length - 1 ? lessonEntries[lessonIndex + 1] : null;

                const nav = document.createElement('div');
                nav.className = 'lesson-nav';
                const prevHtml = prevEntry
                    ? \`<a href="#\${prevEntry.id}"><span class="nav-label">Previous</span><br />\${prevEntry.title}</a>\`
                    : '<span class="nav-label">Start of guide</span>';
                const nextHtml = nextEntry
                    ? \`<a href="#\${nextEntry.id}"><span class="nav-label">Next</span><br />\${nextEntry.title}</a>\`
                    : '<span class="nav-label">End of guide</span>';
                nav.innerHTML = \`
                    <div>
                        \${prevHtml}
                    </div>
                    <div style="text-align:right;">
                        \${nextHtml}
                    </div>
                \`;

                let insertAfter = heading;
                let sibling = heading.nextElementSibling;
                while (sibling) {
                    if (sibling.classList && (sibling.classList.contains('lesson-title') || sibling.classList.contains('section-title') || sibling.classList.contains('chapter-title'))) {
                        break;
                    }
                    insertAfter = sibling;
                    sibling = sibling.nextElementSibling;
                }
                insertAfter.insertAdjacentElement('afterend', nav);
            });
        }

        // Bookmarks Management
        let bookmarks = [];
        try {
            bookmarks = JSON.parse(localStorage.getItem('bookmarks')) || [];
        } catch (e) {
            bookmarks = [];
        }

        function updateBookmarksUI() {
            const bookmarksSec = document.getElementById('bookmarksSection');
            const bookmarksItems = document.getElementById('bookmarksItems');
            const bookmarksHeading = bookmarksSec ? bookmarksSec.querySelector('.chapter-heading') : null;
            
            // Highlight active state on all page buttons
            document.querySelectorAll('.btn-bookmark').forEach(btn => {
                const id = btn.getAttribute('data-id');
                if (bookmarks.some(b => b.id === id)) {
                    btn.classList.add('active');
                } else {
                    btn.classList.remove('active');
                }
            });

            if (bookmarks.length === 0) {
                bookmarksSec.style.display = 'none';
                bookmarksItems.innerHTML = '';
                return;
            }

            bookmarksSec.style.display = 'block';
            bookmarksItems.innerHTML = '';

            if (bookmarksHeading && !bookmarksHeading.dataset.bookmarksBound) {
                bookmarksHeading.addEventListener('click', () => {
                    const isCollapsed = bookmarksItems.classList.toggle('collapsed');
                    bookmarksHeading.classList.toggle('collapsed', isCollapsed);
                });
                bookmarksHeading.dataset.bookmarksBound = 'true';
            }

            if (bookmarksHeading) {
                bookmarksHeading.classList.remove('collapsed');
                bookmarksItems.classList.remove('collapsed');
            }

            bookmarks.forEach(b => {
                const secWrapper = document.createElement('div');
                secWrapper.className = 'menu-section-wrapper';
                
                const link = document.createElement('a');
                link.href = '#' + b.id;
                link.className = 'menu-lesson-link active';
                link.dataset.target = b.id;
                link.innerHTML = \`<span class="bullet">🔖</span> \${b.title}\`;
                
                link.addEventListener('click', (e) => {
                    if (window.innerWidth <= 1024) {
                        document.getElementById('sidebar').classList.remove('open');
                    }
                });
                
                secWrapper.appendChild(link);
                bookmarksItems.appendChild(secWrapper);
            });
        }

        function toggleBookmark(id, title) {
            const index = bookmarks.findIndex(b => b.id === id);
            if (index === -1) {
                bookmarks.push({ id, title });
            } else {
                bookmarks.splice(index, 1);
            }
            try {
                localStorage.setItem('bookmarks', JSON.stringify(bookmarks));
            } catch(e) {}
            updateBookmarksUI();
        }

        // Search Keyboard Shortcut (Ctrl+K or /)
        document.addEventListener('keydown', (e) => {
            const activeElement = document.activeElement;
            const isTypingTarget = activeElement && (activeElement.tagName === 'INPUT' || activeElement.tagName === 'TEXTAREA' || activeElement.tagName === 'SELECT' || activeElement.isContentEditable);
            const isK = (e.key === 'k' || e.key === 'K') && (e.metaKey || e.ctrlKey);
            const isSlash = e.key === '/' && !isTypingTarget;
            const isCommandPaletteShortcut = (e.key === 'p' || e.key === 'P') && (e.metaKey || e.ctrlKey) && !e.altKey && !isTypingTarget;
            const isFocusShortcut = (e.key === 'f' || e.key === 'F') && !e.metaKey && !e.ctrlKey && !e.altKey && !isTypingTarget;
            const isEscapeShortcut = e.key === 'Escape' && document.body.classList.contains('focus-mode') && !isTypingTarget;

            if (isK || isSlash) {
                e.preventDefault();
                const search = document.getElementById('searchInput');
                search.focus();
                search.select();
            }

            if (isCommandPaletteShortcut) {
                e.preventDefault();
                openCommandPalette();
            }

            if (isFocusShortcut) {
                e.preventDefault();
                toggleFocusMode();
            }

            if (isEscapeShortcut) {
                e.preventDefault();
                toggleFocusMode(false);
            }
        });

        // Font size control
        const FONT_MIN = 12;
        const FONT_MAX = 22;
        let contentFontSize = parseInt(localStorage.getItem('contentFontSize') || '16', 10);

        function applyFontSize(size) {
            contentFontSize = Math.max(FONT_MIN, Math.min(FONT_MAX, size));
            document.getElementById('contentBody').style.fontSize = contentFontSize + 'px';
            try { localStorage.setItem('contentFontSize', contentFontSize); } catch(e) {}

            // Update the label with a bounce animation
            const label = document.getElementById('fontSizeLabel');
            if (label) {
                label.textContent = contentFontSize + 'px';
                label.classList.remove('bump');
                void label.offsetWidth; // force reflow to restart animation
                label.classList.add('bump');
            }

            // Dim / disable buttons at limits
            const dec = document.getElementById('btnFontDec');
            const inc = document.getElementById('btnFontInc');
            if (dec) dec.disabled = contentFontSize <= FONT_MIN;
            if (inc) inc.disabled = contentFontSize >= FONT_MAX;
        }

        applyFontSize(contentFontSize);
        document.getElementById('btnFontInc').addEventListener('click', () => applyFontSize(contentFontSize + 1));
        document.getElementById('btnFontDec').addEventListener('click', () => applyFontSize(contentFontSize - 1));

        // Ctrl+[ and Ctrl+] for font size
        document.addEventListener('keydown', (e) => {
            if ((e.metaKey || e.ctrlKey) && e.key === ']') { e.preventDefault(); applyFontSize(contentFontSize + 1); }
            if ((e.metaKey || e.ctrlKey) && e.key === '[') { e.preventDefault(); applyFontSize(contentFontSize - 1); }
        });



        // Inject reading time after each chapter h1
        function injectReadingTimes() {
            document.querySelectorAll('h1.chapter-title').forEach(h1 => {
                // Count all text within the next sibling section
                const section = h1.closest('section') || h1.parentElement;
                const text = section ? section.innerText : '';
                const words = text.trim().split(/\s+/).length;
                const minutes = Math.ceil(words / 200);
                if (h1.querySelector('.reading-time')) return;
                const badge = document.createElement('span');
                badge.className = 'reading-time';
                badge.innerHTML = '<svg viewBox="0 0 24 24" width="12" height="12" stroke="currentColor" stroke-width="2" fill="none"><circle cx="12" cy="12" r="10"></circle><polyline points="12 6 12 12 16 14"></polyline></svg> ' + minutes + ' min read';

                h1.appendChild(badge);
            });
        }

        // Trigger initial highlight and expand on load
        setTimeout(() => {
            if (window.Prism) {
                Prism.highlightAll();
            }
            applySidebarWidth(sidebarWidth);
            loadCompletedLessons();
            attachHeadingActions();
            renderLessonNavigation();
            renderTableOfContents();
            renderQuickJump();
            renderChapterProgress();
            renderBreadcrumbs();
            updateBookmarksUI();
            injectReadingTimes();
            updateSearchClearButton();
            restoreReadingState();
            showContinueReadingCard();
            window.dispatchEvent(new Event('scroll'));
        }, 100);
    </script>
</body>
</html>`;

fs.writeFileSync(destPath, template, 'utf8');
console.log('Build completed successfully! Docs output to docs/index.html');
