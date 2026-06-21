# Comprehensive Vlang Tutorial

Welcome to the complete Zero-to-Hero tutorial for Vlang! This guide covers everything from basic variables to advanced concurrency and standard library usage.

> [!TIP]
> **Interactive Viewer**: Read this guide and other tutorials as a responsive HTML site on the [Markdown Tutorials Live App](https://codefreelance.net/apps/markdown_tutorials/) (source code available in the [GitHub Repository](https://github.com/codecaine-zz/markdown_tutorials)).

## Why V?

V is a statically typed, compiled programming language designed for building maintainable, highly performant software. It shares similarities with Go and is influenced by Rust, Swift, and Julia.

### Core Philosophy

*   **Zero Dependencies**: The entire language, compiler, and standard library have no external dependencies. Everything you need is compiled into a single, clean codebase.
*   **Extreme Compilation Speeds**: V compiles to native C code (and from there to machine code) or directly to machine code/WebAssembly in under a second. Rebuilding the entire V compiler itself takes less than 1.5 seconds.
*   **Safety**: Immortality by default (no globals, immutable variables, immutable struct fields by default), bounds checking, no null pointers, and strict control over variable scopes.
*   **No Heavy Runtime**: V compiles directly to native binaries without a Virtual Machine (VM), interpreter, or heavy runtime library. Resulting executables are extremely lightweight (usually < 1MB).

### Use-Case Guidance: Choosing V

| Scenario / Goal | Choose V when... | Choose Go when... | Choose Rust when... | Choose C when... |
| :--- | :--- | :--- | :--- | :--- |
| **Lightweight CLI Tools** | **Highly Recommended**. Tiny binaries, instant startup, zero dependencies, easy arguments/flags parsing. | Binaries are larger (~5-15MB) and startup is slightly slower due to GC. | Great, but development speed is slower and setup is more complex. | Good, but lack of modern string handling and collections makes it tedious. |
| **Fast-Booting Microservices** | **Excellent**. Low memory overhead, instant boot (ideal for Serverless/Docker environments). | Excellent standard library, but higher memory footprint and GC pauses. | Excellent performance, but longer compilation cycles and steeper learning curve. | Too low-level, unsafe web-facing library ecosystem. |
| **Embedded & Systems** | **Excellent**. Easily compiles to C, runs on bare-metal or resource-constrained boards. | Not suitable due to garbage collector and runtime footprint. | **Excellent**. Safe concurrency and hardware control, though more complex. | The classic choice, but lacks V's safety guards against memory corruption. |
| **Desktop GUI Apps** | **Excellent**. Built-in `gg` graphics library and simple Webview bindings. | Not ideal; lacks first-class native desktop GUI support. | Possible, but complex ecosystem. | Possible, but extremely verbose and unsafe. |

## Prerequisites & Environment Setup

This tutorial and all code examples have been updated and tested for **V version 0.5.1**.

### V-Analyzer Setup for ARM Mac OS (Homebrew)

If you are using an ARM-based Mac (Apple Silicon) and installed V via Homebrew, you may encounter standard library resolution issues when using the `v-analyzer` extension in VSCode or the Antigravity IDE. To fix this, you need to point the analyzer to the correct V root directory.

Update your `v-analyzer` settings (typically in a `config.toml` or IDE settings) to set the `custom_vroot` to the Homebrew installation path (e.g., `/opt/homebrew/Cellar/vlang/0.5.1/libexec/v` or `/opt/homebrew/opt/vlang/libexec/v`). This ensures the analyzer correctly locates the `vlib` standard library.


---

> [!IMPORTANT]
> **Vlang Textbook Learning Guide & Code Examples**
> All code examples and detailed, step-by-step programming lessons have been moved to the dedicated textbook guide: **[TUTORIAL.md](file:///Users/codecaine/V-Programming-Comprehensive-Guide/TUTORIAL.md)**.
> 
> Please use `TUTORIAL.md` as your primary resource for learning V, as it features a structured, school-book syllabus designed specifically for new and experienced developers alike.

---
## Production-Ready Architectures (Case Studies)

While this guide covers all elements of V syntax, it also includes full-scale, production-ready codebases and architectures that showcase how to build real-world software in V. You can jump directly to these case studies:

*   **[Redis GUI Explorer Demo](#redis-gui-explorer-demo)**: A complete cross-platform desktop GUI dashboard utilizing V's C++ Webview bindings (`ttytm.webview`) and the external `xiusin.vredis` client.
*   **[Case Study: MindSpace Journal](#case-study-mindspace-journal-real-world-application)**: A hardware-accelerated personal journaling application built on top of V's `gg` module. Demonstrates event routing, theme persistence, and local JSON database serialization.
*   **[Notes REST API](#notes-api)**: A lightweight web backend utilizing V's SQLite ORM and HTTP router (`veb`) to build a persistent task/note manager.

---

## V Tooling & CLI Utilities

V provides a powerful command-line interface with a rich set of built-in utilities for building, running, formatting, documenting, and managing V code. Below is a comprehensive guide to V's CLI commands.

### Basic Build & Run

*   **Compile and Run**: `v run main.v`
    Compiles the target program to a temporary binary, executes it immediately, and cleans up the binary afterwards. Recommended for development.
*   **Compile to Binary**: `v main.v`
    Compiles the V code and outputs a native executable (`main` or `main.exe`) in the directory.
*   **Cached Compilation (Scripting)**: `v crun script.v`
    Compiles and runs the program. However, unlike `v run`, it caches the compiled executable. If you run the program again without modifying its source code, V runs the cached executable immediately, skipping compilation. Great for shell scripting.
*   **Optimized Production Build**: `v -prod main.v`
    Generates a highly optimized build. Enables C optimization flags (like `-O3`), turns off debugging helpers, and optimizes the compiled binary size and runtime speed.
*   **Debug Compilation**: `v -g run main.v`
    Compiles the code with debug symbols and sets up compiler helpers. If your program crashes, V will print a helpful backtrace showing the exact file name and line number of the crash.

### Code Formatting & Vetting

*   **Format Code**: `v fmt -w file.v`
    Formats the V source file to conform to V's official style guide. The `-w` flag writes the formatted code directly back to the file (in-place). To preview changes without writing, run `v fmt file.v`.
*   **Code Vetting**: `v vet file.v`
    A static analysis tool that reports suspicious code constructs, style violations, or potential errors that compile but are not recommended.

### Documentation Generator

*   **Module Docs in Terminal**: `v doc module_name`
    Generates and prints markdown documentation for any standard library module directly to the terminal.
    *Example:* `v doc strings`
*   **HTML Documentation**: `v doc -f html module_name`
    Generates structured HTML documentation files inside a `_docs` folder.
*   **Full Standard Library Docs**:
    Generates HTML documentation for all V standard library modules and opens it in your browser. Since the built-in `v vlib-docs` command only outputs plain text to the terminal in V 0.5.1, run the following commands instead:
    ```bash
    v doc -m -f html -o _docs vlib
    open _docs/index.html
    ```

### Live Reloading (Watch)

*   **Watch and Compile**: `v watch main.v`
    Instructs the compiler to watch files for changes and re-run compilation as soon as you save any V file. Useful to check for compiler errors in real time.
*   **Watch and Run**: `v watch run main.v`
    Watches files for changes, re-compiles, and immediately executes the program on save.

### Package & Installation Management

*   **Self-Updater**: `v up`
    Updates your V installation to the latest master branch directly from Git.
*   **Self-Compiler**: `v self`
    Rebuilds the V compiler itself. Usually executed after running `v up` or manually making modifications to the compiler source. Use `v -prod self` to compile an optimized version.
*   **Installing VPM Modules**: `v install package_name`
    Downloads and installs external modules from the V Package Manager (VPM).
    *Example:* `v install markdown`
*   **Manage Modules**:
    *   `v list` — Lists all installed external modules.
    *   `v outdated` — Checks for and lists modules with updates available.
    *   `v remove package_name` — Uninstalls the specified VPM module.

### Profiling & Timing

V includes several built-in tools for measuring execution time and profiling function performance.

*   **Timing Execution**: `v time run script.v`
    Starts the program, measures how long it takes to run, and reports its total execution time and exit code.
    *Example:*
    ```bash
    v time run script.v
    ```

*   **Profiling Code**: `v -profile <file.txt> run script.v`
    Compiles the program with all functions profiled, writing execution metrics to the specified text file.
    *   To output profiling data directly to the stdout/terminal, use a hyphen `-`:
        ```bash
        v -profile - run script.v
        ```
    *   The output format contains four space-separated columns:
        1. Number of times the function was called.
        2. Total time spent in the function (in nanoseconds).
        3. Average time per call (in nanoseconds).
        4. Name of the function.
    *   To skip profiling of V startup code (constants evaluation and module `init()` functions), add `-d no_profile_startup`:
        ```bash
        v -profile - -d no_profile_startup run script.v
        ```
    *   To profile only specific functions, use `-profile-fns`:
        ```bash
        v -profile-fns function_name_1,function_name_2 -profile - run script.v
        ```
    *   *Note:* The profiler is not thread-safe, so results for multithreaded programs should be interpreted with caution.

*   **Programmatic Profiling**:
    You can selectively enable or disable profiling in your V source code by importing the `v.profile` module:
    ```v
    import v.profile

    fn main() {
        // Turn profiling off initially
        profile.on(false)
        
        // Critical section to profile
        profile.on(true)
        do_heavy_work()
        profile.on(false)
    }
    ```

*   **Compiler Timing**: `v -show-timings script.v`
    Prints a breakdown of how much time each phase of the compiler took (e.g., PARSE, CHECK, C GEN, backend compiler).

---



## Official Documentation

For comprehensive and up-to-date information about V, please refer to the official documentation:

- **[V Official Documentation](https://github.com/vlang/v/blob/master/doc/docs.md)** - Complete reference guide for the V programming language
- **[Markdown Tutorials Live App](https://codefreelance.net/apps/markdown_tutorials/)** - Interactive HTML viewer featuring this Vlang guide alongside other programming tutorials ([GitHub Repository](https://github.com/codecaine-zz/markdown_tutorials))
