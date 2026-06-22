# Comprehensive Vlang Tutorial

Welcome to the complete Zero-to-Hero tutorial for Vlang! This guide covers everything from basic variables to advanced concurrency and standard library usage.

## Repository Layout

The repository is organized by topic so you can move through the material in a natural learning order:

- `variables_and_constants/` — variables, mutability, constants, and comments
- `primitive_types/` — booleans, numbers, strings, and runes
- `control_flow/` — conditionals, pattern matching, and loops
- `functions/` — function basics and advanced usage
- `structs/` — custom types, fields, and methods
- `error_handling/` — option and result patterns
- `modules/` — organizing code into reusable modules
- `testing/` — assertions and test suites
- `concurrency/` and `channels/` — concurrent programming and communication
- `json_and_orm/`, `sqlite/`, and `notes_api/` — data persistence and APIs

This structure makes it easier to jump straight to the concept you want to study.

> [!TIP]
> **Interactive Viewer**: Read this guide and other tutorials as a responsive HTML site on the [Markdown Tutorials Live App](https://codefreelance.net/apps/markdown_tutorials/) (source code available in the [GitHub Repository](https://github.com/codecaine-zz/markdown_tutorials)).

> [!NOTE]
> **Enhanced HTML Textbook Version**: We now include a premium, interactive HTML documentation site compiled locally from this guide. You can read it live at **[codefreelance.net/apps/vlang.html](https://codefreelance.net/apps/vlang.html)** or open it locally at **[docs/index.html](file:///Users/codecaine/V-Programming-Comprehensive-Guide/docs/index.html)**. It features a collapsible navigation tree, dynamic search filters, dark/light/cyberpunk theme togglers, and interactive links to run code examples in the [V Playground](https://play.vlang.io/) with automatic code loading.

## Why V?

V is a statically typed, compiled programming language designed for building maintainable, highly performant software. It shares similarities with Go and is influenced by Rust, Swift, and Julia.

### Core Philosophy

- **Zero Dependencies**: The entire language, compiler, and standard library have no external dependencies. Everything you need is compiled into a single, clean codebase.
- **Extreme Compilation Speeds**: V compiles to native C code (and from there to machine code) or directly to machine code/WebAssembly in under a second. Rebuilding the entire V compiler itself takes less than 1.5 seconds.
- **Safety**: Immortality by default (no globals, immutable variables, immutable struct fields by default), bounds checking, no null pointers, and strict control over variable scopes.
- **No Heavy Runtime**: V compiles directly to native binaries without a Virtual Machine (VM), interpreter, or heavy runtime library. Resulting executables are extremely lightweight (usually < 1MB).

### Use-Case Guidance: Choosing V

| Scenario / Goal                | Choose V when...                                                                                         | Choose Go when...                                                       | Choose Rust when...                                                              | Choose C when...                                                           |
| :----------------------------- | :------------------------------------------------------------------------------------------------------- | :---------------------------------------------------------------------- | :------------------------------------------------------------------------------- | :------------------------------------------------------------------------- |
| **Lightweight CLI Tools**      | **Highly Recommended**. Tiny binaries, instant startup, zero dependencies, easy arguments/flags parsing. | Binaries are larger (~5-15MB) and startup is slightly slower due to GC. | Great, but development speed is slower and setup is more complex.                | Good, but lack of modern string handling and collections makes it tedious. |
| **Fast-Booting Microservices** | **Excellent**. Low memory overhead, instant boot (ideal for Serverless/Docker environments).             | Excellent standard library, but higher memory footprint and GC pauses.  | Excellent performance, but longer compilation cycles and steeper learning curve. | Too low-level, unsafe web-facing library ecosystem.                        |
| **Embedded & Systems**         | **Excellent**. Easily compiles to C, runs on bare-metal or resource-constrained boards.                  | Not suitable due to garbage collector and runtime footprint.            | **Excellent**. Safe concurrency and hardware control, though more complex.       | The classic choice, but lacks V's safety guards against memory corruption. |
| **Desktop GUI Apps**           | **Excellent**. Built-in `gg` graphics library and simple Webview bindings.                               | Not ideal; lacks first-class native desktop GUI support.                | Possible, but complex ecosystem.                                                 | Possible, but extremely verbose and unsafe.                                |

## Prerequisites & Environment Setup

This tutorial and all code examples have been updated and tested for **V version 0.5.1**.

### V-Analyzer Setup for ARM Mac OS (Homebrew)

If you are using an ARM-based Mac (Apple Silicon) and installed V via Homebrew, you may encounter standard library resolution issues when using the `v-analyzer` extension in VSCode or the Antigravity IDE. To fix this, you need to point the analyzer to the correct V root directory.

Update your `v-analyzer` settings (typically in a `config.toml` or IDE settings) to set the `custom_vroot` to the Homebrew installation path (e.g., `/opt/homebrew/Cellar/vlang/0.5.1/libexec/v` or `/opt/homebrew/opt/vlang/libexec/v`). This ensures the analyzer correctly locates the `vlib` standard library.

---

> [!IMPORTANT]
> **Vlang Textbook Learning Guide & Code Examples**
> All code examples and detailed, step-by-step programming lessons have been moved to the dedicated textbook guide: **[The V Programming Language: A Comprehensive Textbook Guide.md](https://github.com/codecaine-zz/V-Programming-Comprehensive-Guide/blob/master/The%20V%20Programming%20Language:%20A%20Comprehensive%20Textbook%20Guide.md)** (or **[vlang-complete-guide.md](https://github.com/codecaine-zz/V-Programming-Comprehensive-Guide/blob/master/vlang-complete-guide.md)**).
>
> Please use [The V Programming Language: A Comprehensive Textbook Guide.md](https://github.com/codecaine-zz/V-Programming-Comprehensive-Guide/blob/master/The%20V%20Programming%20Language:%20A%20Comprehensive%20Textbook%20Guide.md) (or **[vlang-complete-guide.md](https://github.com/codecaine-zz/V-Programming-Comprehensive-Guide/blob/master/vlang-complete-guide.md)**) as your primary resource for learning V, as it features a structured, school-book syllabus designed specifically for new and experienced developers alike.

---

## Official Documentation & Interactive Guide

For comprehensive and up-to-date information about V, please refer to:

- **[Interactive HTML Guide (Live Web Version)](https://codefreelance.net/apps/vlang.html)** - Read the compiled guide online on the web.
- **[Interactive HTML Guide (Local Version)](file:///Users/codecaine/V-Programming-Comprehensive-Guide/docs/index.html)** - The premium, interactive HTML version of this textbook with built-in search, theme togglers, and V Playground integration.
- **[V Official Documentation](https://github.com/vlang/v/blob/master/doc/docs.md)** - Complete reference guide for the V programming language.
- **[Vlang Complete Guide](https://github.com/codecaine-zz/V-Programming-Comprehensive-Guide/blob/master/vlang-complete-guide.md)** - Comprehensive textbook and learning guide for V.
- **[Markdown Tutorials Live App](https://codefreelance.net/apps/markdown_tutorials/)** - Interactive HTML viewer featuring this Vlang guide alongside other programming tutorials ([GitHub Repository](https://github.com/codecaine-zz/markdown_tutorials)).

### V Playground Integration

The interactive HTML guide integrates directly with the [V Playground](https://play.vlang.io/):

- **Run in Playground**: Pre-loads the specific V code block directly into the playground editor using the `base64` query parameter.
- **Copy & Open**: Copies the V code block to your clipboard and opens the playground pre-loaded with the exact code snippet.

### Rebuilding the Interactive HTML Guide

If you update `The V Programming Language: A Comprehensive Textbook Guide.md`, you can recompile the interactive HTML version at any time by running:

```bash
node build.js
```
