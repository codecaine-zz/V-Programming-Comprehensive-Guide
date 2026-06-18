# Comprehensive Vlang Tutorial

Welcome to the complete Zero-to-Hero tutorial for Vlang! This guide covers everything from basic variables to advanced concurrency and standard library usage.

## Prerequisites & Environment Setup

This tutorial and all code examples have been updated and tested for **V version 0.5.1**.

### V-Analyzer Setup for ARM Mac OS (Homebrew)

If you are using an ARM-based Mac (Apple Silicon) and installed V via Homebrew, you may encounter standard library resolution issues when using the `v-analyzer` extension in VSCode or the Antigravity IDE. To fix this, you need to point the analyzer to the correct V root directory.

Update your `v-analyzer` settings (typically in a `config.toml` or IDE settings) to set the `custom_vroot` to the Homebrew installation path (e.g., `/opt/homebrew/Cellar/vlang/0.5.1/libexec/v` or `/opt/homebrew/opt/vlang/libexec/v`). This ensures the analyzer correctly locates the `vlib` standard library.

## Table of Contents

- [Variables And Constants](#variables-and-constants)
  - [Code Comments](#code-comments)
  - [Constants](#constants)
  - [Variables](#variables)
- [Primitive Types](#primitive-types)
  - [Boolean Type](#boolean-type)
  - [Numeric Types](#numeric-types)
  - [Rune Type](#rune-type)
  - [String Type](#string-type)
- [Arrays And Maps](#arrays-and-maps)
  - [Arrays](#arrays)
  - [Maps](#maps)
- [Control Flow](#control-flow)
  - [If Statement](#if-statement)
  - [Iterative Statements](#iterative-statements)
  - [Match](#match)
- [Functions](#functions)
  - [Function Types](#function-types)
  - [Understanding Funtion Features](#understanding-funtion-features)
- [Structs](#structs)
  - [Approaches Defining Struct Fields](#approaches-defining-struct-fields)
  - [Introducing Structs](#introducing-structs)
  - [Methods For Struct](#methods-for-struct)
  - [Struct As Struct Field](#struct-as-struct-field)
  - [Struct As Trailing Literal Arguments To Function](#struct-as-trailing-literal-arguments-to-function)
  - [Updating Fields Of Struct](#updating-fields-of-struct)
- [Modules](#modules)
  - [Accessing Constants Of Module](#accessing-constants-of-module)
  - [Accessing Members Of Module](#accessing-members-of-module)
  - [Accessing Structs And Embedded Structs Of Module](#accessing-structs-and-embedded-structs-of-module)
  - [Creating Modue](#creating-modue)
  - [Creating Simple V Project](#creating-simple-v-project)
  - [Cyclic Imports](#cyclic-imports)
  - [Importing Module](#importing-module)
  - [Init Function For Module](#init-function-for-module)
  - [Installing External Packages and Webview](#installing-external-packages-and-webview)
  - [Member Scope In Module](#member-scope-in-module)
  - [Working With Multiple Files In Module](#working-with-multiple-files-in-module)
- [Concurrency](#concurrency)
  - [Concurrency Real Life Scenario](#concurrency-real-life-scenario)
  - [Implement Concurrent Programs](#implement-concurrent-programs)
  - [Sharing Data Main And Concurrent Tasks](#sharing-data-main-and-concurrent-tasks)
  - [Spawn Void Function](#spawn-void-function)
  - [Time Module Overview](#time-module-overview)
- [Channels](#channels)
  - [Channel Methods](#channel-methods)
  - [Channel Operations](#channel-operations)
  - [Channel Properties](#channel-properties)
  - [Channel Select](#channel-select)
  - [Define Channels](#define-channels)
  - [Working With Buffered Channels](#working-with-buffered-channels)
  - [Working With Unbuffered Channels](#working-with-unbuffered-channels)
- [Testing](#testing)
  - [Assert](#assert)
  - [Simple Test](#simple-test)
  - [Test Optional Return Functions](#test-optional-return-functions)
  - [Testing Program File](#testing-program-file)
  - [Testing Program With Modules](#testing-program-with-modules)
  - [Testsuite](#testsuite)
- [Json And Orm](#json-and-orm)
  - [Json](#json)
  - [Orm](#orm)
  - [Sqlite Raw Crud](#sqlite-raw-crud)
- [Notes Api](#notes-api)
  - [Notes Api](#notes-api)
- [Language Updates And Stdlib](#language-updates-and-stdlib)
  - [Language Basics Updates](#language-basics-updates)
    - [Sum Types](#sum-types)
    - [Generics](#generics)
    - [Interfaces](#interfaces)
    - [Options And Results](#options-and-results)
    - [Attributes](#attributes)
  - [Standard Library](#standard-library)
    - [Regex Matching](#regex-matching)
    - [Strings Builder](#strings-builder)
    - [Http Client](#http-client)
    - [Os Operations](#os-operations)
    - [Datatypes Collections](#datatypes-collections)
    - [Command Line Flags](#command-line-flags)
    - [Command Line Arguments](#command-line-arguments)
    - [Time And Stopwatch](#time-and-stopwatch)
    - [Math And Rand](#math-and-rand)
    - [Log And Crypto](#log-and-crypto)
    - [Sync Concurrency](#sync-concurrency)
    - [Encoding Formats](#encoding-formats)
    - [Arrays Utility](#arrays-utility)
    - [GG Graphics](#gg-graphics)
    - [Case Study: MindSpace Journal (Real-World Application)](#case-study-mindspace-journal-real-world-application)
    - [TOML Parser](#toml-parser)
    - [Strconv (String Conversion)](#strconv-string-conversion)
    - [Terminal Styling](#terminal-styling)
    - [Benchmark Testing](#benchmark-testing)
    - [Clipboard Access](#clipboard-access)
    - [Semantic Versioning](#semantic-versioning)
    - [Maps Utility](#maps-utility)
    - [Context Propagation](#context-propagation)
    - [Net URL Parsing](#net-url-parsing)
    - [Net WebSockets](#net-websockets)
    - [Net Unix Sockets](#net-unix-sockets)
    - [HTML Parsing](#html-parsing)
    - [JSON-RPC 2.0](#json-rpc-20)
    - [Tar Archiving](#tar-archiving)
    - [Gzip Compression](#gzip-compression)
    - [Deflate Compression](#deflate-compression)
    - [Zlib Compression](#zlib-compression)
    - [Zstd Compression](#zstd-compression)
    - [Szip Archive](#szip-archive)
    - [IO Stream Interfaces](#io-stream-interfaces)
    - [File System IO](#file-system-io)
    - [IO Utilities](#io-utilities)
    - [Hash Functions](#hash-functions)
    - [Bitfield Manipulation](#bitfield-manipulation)
    - [CLI Command Builder](#cli-command-builder)
    - [Veb Web Framework](#veb-web-framework)
    - [Readline Prompt](#readline-prompt)
    - [Runtime System Info](#runtime-system-info)
    - [WebAssembly (wasm) Binary Generation](#webassembly-wasm-binary-generation)
- [Error Handling](#error-handling)
  - [Error Handling](#error-handling-1)
- [V Tooling & CLI Utilities](#v-tooling--cli-utilities)
  - [Basic Build & Run](#basic-build--run)
  - [Code Formatting & Vetting](#code-formatting--vetting)
  - [Documentation Generator](#documentation-generator)
  - [Live Reloading (Watch)](#live-reloading-watch)
  - [Package & Installation Management](#package--installation-management)
  - [Profiling & Timing](#profiling--timing)

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

## Variables And Constants

### Code Comments

#### Programm Commented All Places

_File location: `variables_and_constants/03_code_comments/03_program_commented_all_places/programm_commented_all_places.v`_

This example demonstrates the concepts of **programm commented all places**.

```v
module main

// Space3D A struct indicating the 3 dimensional coordinate system
struct Space3D {
mut:
    x int
    // x is an integer field that represents coordinate
    y int
    // y is an integer field that represents coordinate
    z int
    // z is an integer field that represents coordinate
}

/*
get_point is a function that returns a struct of Type Space3D with points x,y,z passed as input arguments to it
x is an input argument accepts values of type of int
y is an input argument accepts values of type of int
z is an input argument accepts values of type of int
get_point function returns a Struct result of type Space3D with its coordinates set as value passed as input arguments x, y and z
*/
fn get_point(x int, y int, z int) Space3D {
    return Space3D{
        x: x
        y: y
        z: z
    }
}

const origin = get_point(0, 0, 0)

// Defining origin as a constant
fn main() {
    // origin := Space3D {x: 0, y: 0, z:0}
    println(origin)
}

```

#### Single Line Comments

_File location: `variables_and_constants/03_code_comments/01_single_line_comments/single_line_comments.v`_

This example demonstrates the concepts of **single line comments**.

```v
module main

// greet function prints greetings to the console
pub fn greet() {
    println('Hello, Welcome to the Jungle!')
}

fn main() {
    greet()
}

```

#### Multi Line Comments

_File location: `variables_and_constants/03_code_comments/02_multi_line_comments/multi_line_comments.v`_

This example demonstrates the concepts of **multi line comments**.

```v
module main

/*
multiply is a function that accepts two integer arguments
namely x and y.
It then performs multiplication of input arguments and returns the product which is again a type of integer as specified in the function signature.
x is an input argument accepts values of type of int
y is an input argument accepts values of type of int
multiply function returns the result of type int which is a multiplication of input arguments x and y
*/
fn multiply(x int, y int) int {
    return x * y
}

fn main() {
    println(multiply(4, 5))
}

```

### Constants

#### Define Constant Of Type Function

_File location: `variables_and_constants/02_constants/02_complex_constants/02_define_constant_of_type_function/define_constant_of_type_function.v`_

This example demonstrates the concepts of **define constant of type function**.

```v
module main

struct Space3D {
mut:
    x int
    y int
    z int
}

fn get_point(x int, y int, z int) Space3D {
    return Space3D{
        x: x
        y: y
        z: z
    }
}

const origin = get_point(0, 0, 0)

fn main() {
    println(origin)
}

```

#### Define Constant Of Type Struct

_File location: `variables_and_constants/02_constants/02_complex_constants/01_define_constant_of_type_struct/define_constant_of_type_struct.v`_

This example demonstrates the concepts of **define constant of type struct**.

```v
module main

struct Space3D {
mut:
    x int
    y int
    z int
}

const origin = Space3D{
    x: 0
    y: 0
    z: 0
}

fn main() {
    println(origin)
}

```

#### Define Single Constant

_File location: `variables_and_constants/02_constants/01_define_constant/01_define_single_constant.v`_

This example demonstrates the concepts of **define single constant**.

```v
const app_name = 'V on Wheels'

fn main() {
    println(app_name)
}
```

#### Define Multiple Constants

_File location: `variables_and_constants/02_constants/01_define_constant/02_define_multiple_constants.v`_

This example demonstrates the concepts of **define multiple constants**.

```v
const app_name2 = 'V on Wheels'
const max_connections = 1000
const decimal_places = 2
const pi = 3.14

fn main() {
    println(app_name)
    println(max_connections)
    println(decimal_places)
    println(pi)
}

```

#### Define Module Level Constants

_File location: `variables_and_constants/02_constants/03_best_practices/01_define_module_level_constants/define_module_level_constants.v`_

This example demonstrates the concepts of **define module level constants**.

```v
module main

const app_name = 'V on Wheels'

fn main() {
    println(app_name)
}

```

#### Cannot Define Constants Inside Functions

_File location: `variables_and_constants/02_constants/03_best_practices/02_cannot_define_constants_inside_functions/cannot_define_constants_inside_functions.v`_

This example demonstrates the concepts of **cannot define constants inside functions**.

```v
module main

const app_name = 'V on Wheels'

fn main() {
        const greet = 'hi' // this is not top level constant definition, throws error.
        println(app_name)
}

```

#### Main

_File location: `variables_and_constants/02_constants/03_best_practices/03_module_prefix_to_identify_constants/main.v`_

This example demonstrates the concepts of **main**.

```v
module main

import mod1

fn main() {
    mod1.do_work()
}

```

#### File1

_File location: `variables_and_constants/02_constants/03_best_practices/03_module_prefix_to_identify_constants/mod1/file1.v`_

This example demonstrates the concepts of **file1**.

```v
module mod1

const greet_count = 5

pub fn do_work() {
    println(greet_count)
}

```

### Variables

#### Variable Shadowing Not Allowed

_File location: `variables_and_constants/01_variables/03_limitations/03_variable_shadowing/variable_shadowing_not_allowed.v`_

This example demonstrates the concepts of **variable shadowing not allowed**.

```v
module main

fn scope_demo() {
    x := 10
    println(x)
    if true {
        x := 20 // throws error as shadowing is not allowed
        println(x)
    }
    println(x)
}

fn main() {
    scope_demo()
}

```

#### Global Variables Not Allowed

_File location: `variables_and_constants/01_variables/03_limitations/01_global_variables/01_global_variables_not_allowed.v`_

This example demonstrates the concepts of **global variables not allowed**.

```v
module main

fn method1() {
    msg := 'Hello from Method1'
    println(msg)
}

fn main() {
    method1()
    println(msg) // Will throw error as msg declared and accessible only in method1
}

```

#### Global Variables Not Allowed

_File location: `variables_and_constants/01_variables/03_limitations/01_global_variables/02_global_variables_not_allowed.v`_

This example demonstrates the concepts of **global variables not allowed**.

```v
module main

fn method1() {
    if true {
        mut b := 10
        b++
    }
    println(b)
}

fn main() {
    method1()
}

```

#### Variable Redeclaration

_File location: `variables_and_constants/01_variables/03_limitations/02_variable_redeclaration/01_variable_redeclaration.v`_

This example demonstrates the concepts of **variable redeclaration**.

```v
module main

fn main() {
        x := 3
        y := 2
        println(x + y)
        x := 5 // re-definition of variable x is not allowed
}

```

#### Variable Scope For Same Variable Names

_File location: `variables_and_constants/01_variables/03_limitations/02_variable_redeclaration/02_variable_scope_for_same_variable_names.v`_

This example demonstrates the concepts of **variable scope for same variable names**.

```v
module main

fn method1() {
    msg := 'Hello from Method1'
    println(msg)
}

fn method2() {
    msg := 'Hello from Method2'
    println(msg)
}

fn main() {
    method1()
    method2()
}

```

#### Declare Mutable Variable

_File location: `variables_and_constants/01_variables/02_variable_features/01_mutable_immutable_variables/01_mutable/01_declare_mutable_variable.v`_

This example demonstrates the concepts of **declare mutable variable**.

```v
fn main() {
    mut i := 10
    i = 100
    println(i)
}

```

#### Cannot Update Mutable With Another Type

_File location: `variables_and_constants/01_variables/02_variable_features/01_mutable_immutable_variables/01_mutable/02_cannot_update_mutable_with_another_type.v`_

This example demonstrates the concepts of **cannot update mutable with another type**.

```v
fn main() {
    mut i := 10
    i = 100
    i = 'Apple' // throws error
}

```

#### Declare Immutable Variable

_File location: `variables_and_constants/01_variables/02_variable_features/01_mutable_immutable_variables/02_immutable/01_declare_immutable_variable.v`_

This example demonstrates the concepts of **declare immutable variable**.

```v
fn main() {
    msg := 'Hello'
    println(msg)
}

```

#### Cannot Update Immutable Variables

_File location: `variables_and_constants/01_variables/02_variable_features/01_mutable_immutable_variables/02_immutable/02_cannot_update_immutable_variables.v`_

This example demonstrates the concepts of **cannot update immutable variables**.

```v
fn main() {
    msg := 'Hello'
    msg = 'Good Day!' // throws error
}

```

#### Unused Variables Will Be Warned

_File location: `variables_and_constants/01_variables/02_variable_features/03_declared_must_be_consumed/01_unused_variables_will_be_warned.v`_

This example demonstrates the concepts of **unused variables will be warned**.

```v
fn main() {
    i := 'hello' // i is not used anywhere, so warns when run in dev mode and throws error when run in prod mode
    x := 3
    y := 2
    println(x + y)
}

```

#### Declared And Assigned

_File location: `variables_and_constants/01_variables/02_variable_features/02_declared_must_be_assigned/01_declared_and_assigned.v`_

This example demonstrates the concepts of **declared and assigned**.

```v
fn main() {
    mut i := 0
    // declared and assigned
    println(i)
}

```

#### Declared And Not Assigned

_File location: `variables_and_constants/01_variables/02_variable_features/02_declared_must_be_assigned/02_declared_and_not_assigned.v`_

This example demonstrates the concepts of **declared and not assigned**.

```v
fn main() {
    mut a // throws error
}

```

#### Parallel Declaration Immutable Variables

_File location: `variables_and_constants/01_variables/01_variable_assignment/01_parallel_declaration/01_parallel_declaration_immutable_variables.v`_

This example demonstrates the concepts of **parallel declaration immutable variables**.

```v
// immutable variables parallel assignment

fn main() {
    a, b, c := 3, 4, 5
    println(a)
    println(b)
    println(c)
}

```

#### Parallel Declaration Mutable Variables

_File location: `variables_and_constants/01_variables/01_variable_assignment/01_parallel_declaration/02_parallel__declaration_mutable_variables.v`_

This example demonstrates the concepts of **parallel declaration mutable variables**.

```v
// mutable variables parallel assignment

fn main() {
    mut i, mut j := 'Hi', 'Hello'
    println(i)
    println(j)

    // updating mutable variables in parallel
    i, j = 'Hi there', 'Hello, Good Day!'
}

```

#### Parallel Declaration Mut And Immutable Vars

_File location: `variables_and_constants/01_variables/01_variable_assignment/01_parallel_declaration/03_parallel_declaration_mut_and_immutable_vars.v`_

This example demonstrates the concepts of **parallel declaration mut and immutable vars**.

```v
fn main() {
    mut msg, i := 'Hello', 32
    println(msg) // Hello
    msg = 'Hi'
    println(msg) // Hi
    println(i) // 32
    i = 2 // error: `i` is immutable, declare it with `mut` to make it mutable
}

```

#### Augmented Assignment String

_File location: `variables_and_constants/01_variables/01_variable_assignment/02_augmented_assignment/01_augmented_assignment_string.v`_

This example demonstrates the concepts of **augmented assignment string**.

```v
fn main() {
    mut greet := 'Hi'
    println(greet)

    greet = greet + ' there, How are you?'
    println(greet)

    greet += ' Hope you have a great day!'
    println(greet)
}

```

#### Augmented Assignment Integer

_File location: `variables_and_constants/01_variables/01_variable_assignment/02_augmented_assignment/02_augmented_assignment_integer.v`_

This example demonstrates the concepts of **augmented assignment integer**.

```v
fn main() {
    mut cnt := 10
    println(cnt)
    cnt = cnt + 5
    println(cnt)
    cnt += 5
    println(cnt)
}

```

## Primitive Types

### Boolean Type

#### Relational Operators

_File location: `primitive_types/01_boolean_type/02_relational_operators/01_relational_operators.v`_

This example demonstrates the concepts of **relational operators**.

```v
module main

struct Note {
    id        int
    detail    string
    completed bool
}

fn main() {
    mut n := Note{
        id:     1001
        detail: 'get groceries'
    }
    println(n.completed) // un-assigned bool field will be false by default

    // Comparing using Relational operator >
    if n.id > 1000 { // comparison of note id of integer type to another integer evaluates to a boolean
        println('The note id is greater than 1000')
    } else {
        println('The note id is less than 1000')
    }

    // Comparing using Relational operator ==
    if n.detail == 'get groceries' {
        println('The note details about groceries')
    }

    // Comparing using Relational operator !=
    if n.detail != 'get dairy products' {
        println('The note does not details about dairy products')
    }
}

```

#### Logical Operators

_File location: `primitive_types/01_boolean_type/01_logical_operators/01_logical_operators.v`_

This example demonstrates the concepts of **logical operators**.

```v
module main

fn main() {
    t := true
    f := false

    // Logical And using && operator
    and_tt := t && t
    and_tf := t && f
    and_ft := f && t
    and_ff := f && f

    println('Logical And using && operator')
    println('${t} && ${t} = ${and_tt}')
    println('${t} && ${f} = ${and_tf}')
    println('${f} && ${t} = ${and_ft}')
    println('${f} && ${f} = ${and_ff}')
    println('')

    // Logical OR using || operator
    or_tt := t || t
    or_tf := t || f
    or_ft := f || t
    or_ff := f || f

    println('Logical OR using || Operator')
    println('${t} || ${t} = ${or_tt}')
    println('${t} || ${f} = ${or_tf}')
    println('${f} || ${t} = ${or_ft}')
    println('${f} || ${f} = ${or_ff}')
    println('')

    // Logical not using ! Operator
    not_t := !t
    not_f := !f

    println('Logical not using ! Operator')
    println('!${t} = ${not_t}')
    println('!${f} = ${not_f}')
}

```

#### Boolean Methods

_File location: `primitive_types/01_boolean_type/03_boolean_methods/01_boolean_methods.v`_

This example demonstrates the concepts of **boolean methods**.

```v
module main

fn main() {
	t := true
	f := false

	// str() returns string representation ('true' or 'false')
	println(t.str()) // true
	println(f.str()) // false
}
```

```

### Numeric Types

#### Shift Operators

_File location: `primitive_types/02_numeric_types/03_operations_on_numeric_types/03_shift_operators/01_shift_operators/01_shift_operators.v`_

This example demonstrates the concepts of **shift operators**.

```v
module main

fn main() {
    // declare 8 bit integer with value 3
    a := i8(3)

    // 8 bits equals to 1 byte
    println('a is ${sizeof(a)} byte(s)') // a is 1 byte(s)

    // declare 8-bit unsigned integer to shift by 1 position
    pos := byte(1)

    // Shift left the value 3 by 1 position
    a_left_shift := a << pos
    println('${a} << ${pos} = ${a_left_shift}')
}

```

#### Shift Operator On Range Of Integers

_File location: `primitive_types/02_numeric_types/03_operations_on_numeric_types/03_shift_operators/02_shift_operator_on_range_of_integers/02_shift_operator_on_range_of_integers.v`_

This example demonstrates the concepts of **shift operator on range of integers**.

```v
module main

fn main() {
    val := i8(1)

    bits := sizeof(val) * 8

    println('Performing left shift using << Operator')

    for i in 0 .. bits {
        after_shift := val << i
        println('$val << $i = $after_shift \/\/ type after shift operation: ${typeof(after_shift).name}')
    }
}

```

#### Bitwise Operators

_File location: `primitive_types/02_numeric_types/03_operations_on_numeric_types/02_bitwise_operators/bitwise_operators.v`_

This example demonstrates the concepts of **bitwise operators**.

```v
module main

fn main() {
    a := 0b00000110 // 6
    b := 0b00000010 // 2

    // bitwise AND operation of two binary nums using & operator
    b_and := a & b

    // bitwise OR operation of two binary nums using | operator
    b_or := a | b

    // bitwise XOR operation of two binary nums using ^ operator
    b_xor := a ^ b

    // bitwise NOT operation of an binary nums using ~ operator
    not_a := ~a // Not operation yields value which is equal to -(a+1) in its integer form
    println('Bitwise AND: ${a:08b} & ${b:08b} = ${b_and:08b}')
    println('Bitwise OR: ${a:08b} | ${b:08b} = ${b_or:08b}')
    println('Bitwise XOR: ${a:08b} ^ ${b:08b} = ${b_xor:08b}')
    println('Bitwise NOT: ~${a:b} = ${not_a:b}')
}

```

#### Arithmetic Operators

_File location: `primitive_types/02_numeric_types/03_operations_on_numeric_types/01_arithmetic_operators/arithmetic_operators.v`_

This example demonstrates the concepts of **arithmetic operators**.

```v
module main

fn main() {
    a := 10
    b := 2

    // add using +
    sum := a + b

    // subtract using -
    diff := b - a

    // product using *
    prod := a * b

    // / results in quotient
    quotient := a / b

    // % modulo results in remainder
    remainder := a % b

    println('Sum of ${a} and ${b} is ${sum}')
    println('Subtracting ${a} from ${b} is ${diff}')
    println('Product of ${a} and ${b} is ${prod}')
    println('Quotient when ${a} divided by ${b} is ${quotient}')
    println('Remainder when ${a} divided by ${b} is ${remainder}')
}

```

#### Promoting Numeric Types

_File location: `primitive_types/02_numeric_types/02_promoting_numeric_types/01_promoting_numeric_types.v`_

This example demonstrates the concepts of **promoting numeric types**.

```v
module main

fn demo() {
    ia := i8(2)
    ib := i16(2)
    ic := int(2)

    println('----type definitions----')
    println('variable ia is of type: ${typeof(ia).name}')
    println('variable ib is of type: ${typeof(ib).name}')
    println('variable ic is of type: ${typeof(ic).name}')
    println('')
    iaa := ia + ia // i8 with i8 results i8
    ibb := ib + ib // i16 with i16 results i16
    icc := ic + ic // int with int results int
    println('----mixing types----')
    println('variable iaa is of type: ${typeof(iaa).name}, after adding type ${typeof(ia).name} with itself')
    println('variable ibb is of type: ${typeof(ibb).name}, after adding type ${typeof(ib).name} with itself')
    println('variable icc is of type: ${typeof(icc).name}, after adding type ${typeof(ic).name} with itself')
    println('')
    iab := ia + ib // i8 with i16 results in i16
    ibc := ib - ic // i16 with i32 results in i32
    println('----type promotion----')
    println('variable iab is promoted to type: ${typeof(iab).name}, after adding type ${typeof(ia).name} with ${typeof(ib).name}')
    println('variable ibc is promoted to type: ${typeof(ibc).name}, after subtracting type ${typeof(ib).name} with ${typeof(ic).name}')

    iba := ib / ia // the division of i16 and i8 types
    println('Variable iba is promoted to the higher data type ${typeof(iba).name} which is carried from ib of type ${typeof(ib).name} divided from variable ia of type ${typeof(ia).name}')

    fa := f32(2)

    fa_iba := fa + iba // fa is type of f32 and iba is of type i32
    println('Variable fa_iba is promoted to the higher data type ${typeof(fa_iba).name} which is carried from fa of type ${typeof(fa).name} when added with variable iba of type ${typeof(iba).name}')
}

fn main() {
    demo()
}

```

#### Declaring Integers

_File location: `primitive_types/02_numeric_types/01_declaring_integers/01_declaring_integers/01_declaring_integers.v`_

This example demonstrates the concepts of **declaring integers**.

```v
module main

fn main() {
	x := 1
	println(typeof(x).name)
	// int

	i := 1_000
	j := 1000

	println(i == j) // true
}
```
```

#### Hex Binary Octa Notation Of Declaring Integers

_File location: `primitive_types/02_numeric_types/01_declaring_integers/02_hex_binary_octa_notation/02_hex_binary_octa_notation_of_declaring_integers.v`_

This example demonstrates the concepts of **hex binary octa notation of declaring integers**.

```v
module main

fn demo() {
    h1 := 0x64 // hexadecimal starts with 0x
    b1 := 0b1100100 // binary starts with 0b
    o1 := 0o144 // Octal starts with 0o
    println('Value of var h1 with hexadecimal value : ${h1}')
    println('Data type of var h1 with hexadecimal value : ${typeof(h1).name}')
    println('Value of var b1 with binary value : ${b1}')
    println('Data type of var b1 with binary value : ${typeof(b1).name}')
    println('Value of var o1 with octal value : ${o1}')
    println('Data type of var o1 with octal value : ${typeof(o1).name}')
}

fn main() {
    demo()
}

```

#### Integer Methods

_File location: `primitive_types/02_numeric_types/04_numeric_methods/01_integer_methods/01_integer_methods.v`_

This example demonstrates the concepts of **integer methods**.

```v
module main

fn main() {
	x := 42

	// str() returns string representation of the integer
	println(x.str()) // "42"

	// hex() returns hexadecimal representation without prefix
	println(x.hex()) // "2a"

	// hex2() returns hexadecimal representation with "0x" prefix
	println(x.hex2()) // "0x2a"

	// hex_full() returns hexadecimal representation with full width padding for the type (8 digits for 32-bit int)
	println(x.hex_full()) // "0000002a"
}
```

#### Float Methods

_File location: `primitive_types/02_numeric_types/04_numeric_methods/02_float_methods/02_float_methods.v`_

This example demonstrates the concepts of **float methods**.

```v
module main

fn main() {
	f := 12345.6789

	// str() returns string representation of the float
	println(f.str()) // "12345.6789"

	// strg() returns string representation (often identical to str())
	println(f.strg()) // "12345.6789"

	// strlong() returns a full/long string representation of the float
	println(f.strlong()) // "12345.6789"

	// strsci(precision) returns scientific notation with specified precision/decimal places
	println(f.strsci(4)) // "1.2346e+04"

	// eq_epsilon(other) performs a comparison using machine epsilon (for near-equality)
	f2 := 12345.678900000001
	println(f.eq_epsilon(f2)) // true
}
```

#### u8 Methods

_File location: `primitive_types/02_numeric_types/04_numeric_methods/03_u8_methods/03_u8_methods.v`_

This example demonstrates the concepts of **u8 methods**.

```v
module main

fn main() {
	b := u8(65) // ASCII code for 'A'

	// str() returns string representation of the numeric value
	println(b.str()) // "65"

	// ascii_str() returns string of length 1 containing the character
	println(b.ascii_str()) // "A"

	// hex() returns hexadecimal representation
	println(b.hex()) // "41"

	// hex_full() returns hexadecimal representation (same as hex() for u8)
	println(b.hex_full()) // "41"

	// is_alnum() checks if the character is alphanumeric
	println(b.is_alnum()) // true

	// is_bin_digit() checks if the character is a binary digit ('0' or '1')
	println(b.is_bin_digit()) // false

	// is_capital() checks if the character is an uppercase letter
	println(b.is_capital()) // true

	// is_digit() checks if the character is a decimal digit ('0'-'9')
	println(b.is_digit()) // false

	// is_hex_digit() checks if the character is a hexadecimal digit ('0'-'9', 'a'-'f', 'A'-'F')
	println(b.is_hex_digit()) // true

	// is_letter() checks if the character is an alphabetic letter
	println(b.is_letter()) // true

	// is_oct_digit() checks if the character is an octal digit ('0'-'7')
	println(b.is_oct_digit()) // false

	// is_space() checks if the character is a whitespace character
	println(b.is_space()) // false

	// repeat(count) repeats the character count times and returns a string
	println(b.repeat(3)) // "AAA"

	// str_escaped() returns an escaped string representation of the character
	println(b.str_escaped()) // "A"
}
```

#### Size And Pointer Methods

_File location: `primitive_types/02_numeric_types/04_numeric_methods/04_size_pointer_methods/04_size_pointer_methods.v`_

This example demonstrates the concepts of **size and pointer methods**.

```v
module main

fn main() {
	// isize and usize methods
	sz := isize(100)
	usz := usize(200)

	// str() returns string representation
	println(sz.str())  // "100"
	println(usz.str()) // "200"

	// voidptr methods
	x := 42
	p := voidptr(&x)

	// str() returns the memory address as string
	println(p.str().starts_with('0x')) // true

	// hex_full() returns full-width hex representation of address
	println(p.hex_full().len > 0) // true

	// vbytes(len) returns a byte array representation of the memory pointed to (must be called in unsafe block)
	unsafe {
		bytes := p.vbytes(int(sizeof(int)))
		println(bytes) // [42, 0, 0, 0]
	}
}
```

### Rune Type

#### Declare Rune

_File location: `primitive_types/04_rune_type/01_declare_rune/01_declare_rune.v`_

This example demonstrates the concepts of **declare rune**.

```v
fn main() {
    l := `a`
    println(typeof(l).name)
    // rune
}

```

#### Rune Operations With Strings

_File location: `primitive_types/04_rune_type/02_rune_operations_with_strings/02_rune_operations_with_strings.v`_

This example demonstrates the concepts of **rune operations with strings**.

```v
fn main() {
    beverage := 'café'
    s := `é`
    // declare rune
    println(beverage.count(s.str()))
    // 1
}

```

#### Rune Methods

_File location: `primitive_types/04_rune_type/03_rune_methods/01_rune_methods.v`_

This example demonstrates the concepts of **rune methods**.

```v
module main

fn main() {
	r := `A`

	// bytes() returns the byte representation (UTF-8 bytes) of the rune
	println(r.bytes()) // [65]

	// hex() returns the hexadecimal representation of the rune code point
	println(r.hex()) // "41"

	// length_in_bytes() returns the size of the rune in bytes (1 to 4)
	println(r.length_in_bytes()) // 1

	// repeat(count) returns a string with the rune repeated count times
	println(r.repeat(3)) // "AAA"

	// str() returns the string representation of the rune
	println(r.str()) // "A"

	// to_lower() returns the lowercase rune
	println(r.to_lower().str()) // "a"

	// to_upper() returns the uppercase rune
	println(r.to_upper().str()) // "A"

	// to_title() returns the titlecase rune
	println(r.to_title().str()) // "A"

	// Testing with a multi-byte UTF-8 rune (dog emoji 🐕)
	r2 := `🐕`
	println(r2.bytes())           // [240, 159, 144, 149]
	println(r2.hex())             // "1f415" (Unicode code point in hex)
	println(r2.length_in_bytes()) // 4
	println(r2.repeat(2))         // "🐕🐕"
	println(r2.str())             // "🐕"
}
```

### String Type

#### Declare String

_File location: `primitive_types/03_string_type/01_declare_string/01_declare_string.v`_

This example demonstrates the concepts of **declare string**.

```v
fn main() {
    h := 'hello'
    println(h)
    // hello
    println(h.len)
    // 5
    println(typeof(h).name)
    // string
}

```

#### String Read Only Array Of Bytes

_File location: `primitive_types/03_string_type/01_working_with_strings/01_string_read_only_array_of_bytes/01_string_read_only_array_of_bytes.v`_

This example demonstrates the concepts of **string read only array of bytes**.

```v
fn main() {
    fruit := 'Orange'
    println(typeof(fruit[0]).name)
    // byte
    println(fruit[0])
    // 79
}

```

#### Strings Immutable By Default

_File location: `primitive_types/03_string_type/01_working_with_strings/02_strings_immutable_by_default/02_strings_immutable_by_default.v`_

This example demonstrates the concepts of **strings immutable by default**.

```v
fn main() {
    s := 'hello'
    // variable s is immutable
    s = 'Hello!'
    // this results in error
}

```

#### Declaring Mutable Strings

_File location: `primitive_types/03_string_type/01_working_with_strings/03_declaring_mutable_strings/03_declaring_mutable_strings.v`_

This example demonstrates the concepts of **declaring mutable strings**.

```v
fn main() {
    mut msg := 'Hello Friend!'
    msg = 'Hope you are doing good.'
    println(msg)
    // Hope you are doing good.
    msg = msg + ' There is a surprise for you.'
    println(msg)
    // Hope you are doing good. There is a surprise for you.
}

```

#### Cannot Mutate String Elements

_File location: `primitive_types/03_string_type/01_working_with_strings/04_cannot_mutate_string_elements/04_cannot_mutate_string_elements.v`_

This example demonstrates the concepts of **cannot mutate string elements**.

```v
fn main() {
    mut greet := 'good Day'

    greet[0] = 'G' // this results in error
}

```

#### Escape Special Characters

_File location: `primitive_types/03_string_type/02_operations_on_string_types/02_string_manipulation/01_escape_special_characters/01_escape_special_characters.v`_

This example demonstrates the concepts of **escape special characters**.

```v
module main

fn main() {
	sen := "It's my Daughter's birthday!"
	println(sen)
}
```

#### Declare Raw Strings

_File location: `primitive_types/03_string_type/02_operations_on_string_types/02_string_manipulation/02_declare_raw_strings/02_declare_raw_strings.v`_

This example demonstrates the concepts of **declare raw strings**.

```v
module main

fn main() {
	i := r'hi \how are you/?'
	println(i)
}
```

#### String Concatenation Using Plus Sign

_File location: `primitive_types/03_string_type/02_operations_on_string_types/02_string_manipulation/03_string_concatenation_using_plus_sign/03_string_concatenation_using_plus_sign.v`_

This example demonstrates the concepts of **string concatenation using plus sign**.

```v
module main

fn main() {
	a := 'con'
	b := 'cat'
	println(a + b)
	// concat
}
```

#### String Concatenation Using Interpolation

_File location: `primitive_types/03_string_type/02_operations_on_string_types/02_string_manipulation/04_string_concatenation_using_interpolation/04_string_concatenation_using_interpolation.v`_

This example demonstrates the concepts of **string concatenation using interpolation**.

```v
module main

fn main() {
	i := 1
	j := 'man army'
	println('${i} ${j}')
}
```

#### Extract Substring From String Literal

_File location: `primitive_types/03_string_type/02_operations_on_string_types/02_string_manipulation/05_extract_substring_from_string_literal/05_extract_substring_from_string_literal.v`_

This example demonstrates the concepts of **extract substring from string literal**.

```v
module main

fn main() {
	a := 'Camel'
	b := a.substr(0, 3)
	println(b)
	// Cam
}
```

#### Split String

_File location: `primitive_types/03_string_type/02_operations_on_string_types/02_string_manipulation/06_split_string/06_split_string.v`_

This example demonstrates the concepts of **split string**.

```v
module main

fn main() {
	sp := 'The tiny tiger tied the tie tighter to its tail'
	res := sp.split(' ')
	// split by space as delimiter
	println(typeof(res).name)
	// []string
	println(res)
	// ['The', 'tiny', 'tiger', 'tied', 'the', 'tie', 'tighter', 'to', 'its', 'tail']
}
```

#### String To Runes Array

_File location: `primitive_types/03_string_type/02_operations_on_string_types/02_string_manipulation/07_string_to_runes_array/07_string_to_runes_array.v`_

This example demonstrates the concepts of **string to runes array**.

```v
module main

fn main() {
	doge_moon := '🐕+🚀=🌑'
	doge_moon_runes := doge_moon.runes()
	println(doge_moon_runes)
	println(typeof(doge_moon_runes).name) // []rune
}
```

#### Count Sub String Occurences

_File location: `primitive_types/03_string_type/02_operations_on_string_types/02_string_manipulation/08_count_sub_string_occurences/08_count_sub_string_occurences.v`_

This example demonstrates the concepts of **count sub string occurences**.

```v
module main

fn main() {
	sp := 'The tiny tiger tied the tie tighter to its tail'
	println(sp.count('t'))
	// 10
	println(sp.count('T'))
	// 1
	println(sp.count('tie'))
	// 2
	println(sp.count('-'))
	// 0
}
```

#### Check String Contains Substring

_File location: `primitive_types/03_string_type/02_operations_on_string_types/02_string_manipulation/09_check_string_contains_substring/09_check_string_contains_substring.v`_

This example demonstrates the concepts of **check string contains substring**.

```v
module main

fn main() {
    hs := 'monday'

    if hs.contains('mon') {
        println('${hs} contains mon')
    } else {
        println('${hs} does not contains mon')
    }
}

```

#### String Contains Is Case Sensitive

_File location: `primitive_types/03_string_type/02_operations_on_string_types/02_string_manipulation/10_string_contains_is_case_sensitive/10_string_contains_is_case_sensitive.v`_

This example demonstrates the concepts of **string contains is case sensitive**.

```v
module main

fn main() {
    hs := 'Monday'

    if hs.contains('mon') {
        println('${hs} contains mon')
    } else {
        println('${hs} does not contains mon')
    }
}

```

#### Common String Methods

_File location: `primitive_types/03_string_type/02_operations_on_string_types/02_string_manipulation/11_common_string_methods/11_common_string_methods.v`_

This example demonstrates the concepts of **common string methods**.

```v
module main

fn main() {
	s := '  Hello, V!  '

	// to_lower() returns the lowercase version of the string
	println(s.to_lower()) // "  hello, v!  "

	// to_upper() returns the uppercase version of the string
	println(s.to_upper()) // "  HELLO, V!  "

	// trim_space() trims leading and trailing whitespaces
	println(s.trim_space()) // "Hello, V!"

	// trim(cutset) trims leading and trailing characters that match any character in the cutset
	println(s.trim(' ')) // "Hello, V!"

	// replace(old, new) replaces all occurrences of old with new
	println(s.replace('V', 'World')) // "  Hello, World!  "

	// replace_once(old, new) replaces the first occurrence of old with new
	println(s.replace_once('l', 'x')) // "  Hexlo, V!  "

	// index(sub) returns the start index of the first occurrence of sub as an optional ?int
	idx := s.index('Hello') or { -1 }
	println(idx) // 2

	// last_index(sub) returns the start index of the last occurrence of sub as an optional ?int
	last_idx := s.last_index('l') or { -1 }
	println(last_idx) // 5

	// starts_with(prefix) checks if the string starts with the prefix
	println(s.starts_with('  ')) // true

	// ends_with(suffix) checks if the string ends with the suffix
	println(s.ends_with('!')) // false (ends with spaces)

	// is_pure_ascii() checks if all characters in the string are pure ASCII
	println(s.is_pure_ascii()) // true

	// split_into_lines() splits a string into an array of lines
	multiline := "line 1\nline 2"
	println(multiline.split_into_lines()) // ["line 1", "line 2"]

	// split_by_space() splits a string by space as delimiter
	println(s.split_by_space()) // ["Hello,", "V!"]
}
```

#### String Interpolation

_File location: `primitive_types/03_string_type/02_operations_on_string_types/01_string_interpolation/01_string_interpolation.v`_

This example demonstrates the concepts of **string interpolation**.

```v
fn main() {
    a := 'coding'
    b := 'fun'
    println('${a} is ${b}')
    println('${a} is ${b}')
}

```

## Arrays And Maps

### Arrays

#### Working With Array Properties

_File location: `arrays_and_maps/01_arrays/02_array_properties/01_working_with_array_properties.v`_

This example demonstrates the concepts of **working with array properties**.

```v
fn main() {
    mut sports := ['cricket', 'hockey', 'football']
    println(sports.len)
    // Length of sports array
    println(sports.cap)
    // Capacity of sports array
    println('----Deleting football----')
    sports.delete(2)
    // deleting football
    println('Length of sports array: ${sports.len}')
    println('Capacity of sports array: ${sports.cap}')

    println('----Adding volleyball and baseball----')

    sports << ['volleyball', 'baseball']
    println(sports)
    println('Length of sports array: ${sports.len}')
    println('Capacity of sports array: ${sports.cap}')
}

```

#### In Operator With Array

_File location: `arrays_and_maps/01_arrays/04_array_operators/01_in_operator_with_array/01_in_operator_with_array.v`_

This example demonstrates the concepts of **in operator with array**.

```v
fn main() {
    odd := [1, 3, 5, 7]

    println(3 in odd)
    // prints: true
    println(8 !in odd)
    // prints: true
}

```

#### Append Array

_File location: `arrays_and_maps/01_arrays/04_array_operators/02_append_array/02_append_array.v`_

This example demonstrates the concepts of **append array**.

```v
fn main() {
    mut even := [2, 4, 6]
    even << 8
    println(even)
    // prints [2, 4, 6, 8]
    even << [10, 12, 14]
    println(even)
    // prints: [2, 4, 6, 8, 10, 12, 14]
}

```

#### Clone Array

_File location: `arrays_and_maps/01_arrays/07_array_operations/01_clone_array/01_clone_array/01_clone_array.v`_

This example demonstrates the concepts of **clone array**.

```v
fn main() {
    r := [1, 2, 3, 4]
    mut u := r.clone()
    // copies the array r to u
    println(u)
}

```

#### Copy Array

_File location: `arrays_and_maps/01_arrays/07_array_operations/01_clone_array/02_copy_array/02_copy_array.v`_

This example demonstrates the concepts of **copy array**.

```v
fn main() {
    r := [1, 2, 3, 4]
    s := unsafe { r }
    println(s)
    unsafe {
        r.free()
    }
}

```

#### Map Array Items

_File location: `arrays_and_maps/01_arrays/07_array_operations/04_map_array/01_map_array_items/01_map_array_items.v`_

This example demonstrates the concepts of **map array items**.

```v
fn main() {
    visitor := ['Tom', 'Ram', 'Rao']
    res := visitor.map('Mr. ' + it)
    println(res)
}

```

#### Map Using Anonymous Funcs On Array

_File location: `arrays_and_maps/01_arrays/07_array_operations/04_map_array/02_map_using_anonymous_funcs_on_array/02_map_using_anonymous_funcs_on_array.v`_

This example demonstrates the concepts of **map using anonymous funcs on array**.

```v
fn main() {
    colors := ['red', 'blue', 'green', 'white', 'black']

    colors_with_letter_e := colors.map(fn (c string) int {
        if c.contains('e') { return 1 } else { return 0 }
    })

    println(colors_with_letter_e)
}

```

#### Filter Array

_File location: `arrays_and_maps/01_arrays/07_array_operations/03_filter_array/01_filter_array/01_filter_array.v`_

This example demonstrates the concepts of **filter array**.

```v
fn main() {
    f := [1, 2, 3, 4, 5, 6, 7, 8, 9]
    multiples_of_3 := f.filter(it % 3 == 0)
    println(multiples_of_3)
    // [3, 6, 9]
}

```

#### Filter With Anonymous Funcs On Array

_File location: `arrays_and_maps/01_arrays/07_array_operations/03_filter_array/02_filter_with_anonymous_funcs_on_array/02_filter_with_anonymous_funcs_on_array.v`_

This example demonstrates the concepts of **filter with anonymous funcs on array**.

```v
fn main() {
    fruits := ['apple', 'mango', 'water melon', 'musk melon']

    fruits_starting_m := fruits.filter(fn (f string) bool {
        return f.starts_with('m')
    })

    println(fruits_starting_m)
}

```

#### Sort Integer Array

_File location: `arrays_and_maps/01_arrays/07_array_operations/02_sort_array/01_sort_integer_array/01_sort_integer_array.v`_

This example demonstrates the concepts of **sort integer array**.

```v
fn main() {
    mut i := [3, 2, 8, 1]
    i.sort()
    // ascending order
    println(i)
    i.sort(a > b)
    // descending order
    println(i)
}

```

#### Sort String Array

_File location: `arrays_and_maps/01_arrays/07_array_operations/02_sort_array/02_sort_string_array/02_sort_string_array.v`_

This example demonstrates the concepts of **sort string array**.

```v
fn main() {
    mut fruits := ['Apples', 'avocado', 'banana', 'Orange']

    fruits.sort()
    // ascending order
    println(fruits)
    fruits.sort(a > b)
    // reverse order
    println(fruits)
}

```

#### Sort Struct Array

_File location: `arrays_and_maps/01_arrays/07_array_operations/02_sort_array/sort_struct_array/03_sort_struct_array.v`_

This example demonstrates the concepts of **sort struct array**.

```v
module main

struct Student {
    id    int
    name  string
    class int
}

fn main() {
    // Declare an empty array
    mut students := []Student{}

    // Create students
    st1 := Student{
        id:    1
        name:  'Ram'
        class: 9
    }
    st2 := Student{
        id:    2
        name:  'Katy'
        class: 3
    }
    st3 := Student{
        id:    3
        name:  'Tom'
        class: 6
    }

    // Append all the students to the array
    students << [st1, st2, st3]
    println(students)

    // Reverse Sort students by id
    students.sort(a.id > b.id)

    println('Students sorted in reverse order of id:')
    println(students)

    // Sort students by class in ascending order
    students.sort(a.class < b.class)

    println('Students sorted in ascending order of class:')
    println(students)

    // Sort students by name in reverse order
    students.sort(a.name > b.name)

    println('Students sorted in reverse order of name:')
    println(students)
}

```

#### Declare And Initialize

_File location: `arrays_and_maps/01_arrays/01_array_declaration/01_declare_and_initialize/01_declare_and_initialize.v`_

This example demonstrates the concepts of **declare and initialize**.

```v
fn main() {
    mut sports := ['cricket', 'hockey', 'football']
    println(sports)
}

```

#### Declare Empty Array

_File location: `arrays_and_maps/01_arrays/01_array_declaration/02_declare_empty_array/02_declare_empty_array.v`_

This example demonstrates the concepts of **declare empty array**.

```v
fn main() {
    mut animals := []string{}
    println(animals)
    // prints empty array: []
    animals << 'Chimpanzee'
    animals << 'Dog'
    println(animals)
    // ['Chimpanzee', 'Dog']
}

```

#### Declare Array With Len

_File location: `arrays_and_maps/01_arrays/01_array_declaration/03_declare_array_with_len/03_declare_array_with_len.v`_

This example demonstrates the concepts of **declare array with len**.

```v
fn main() {
    mut i := []int{len: 3}
    println(i)
}

```

#### Declare Array With Init And Len

_File location: `arrays_and_maps/01_arrays/01_array_declaration/04_declare_array_with_init_and_len/04_declare_array_with_init_and_len.v`_

This example demonstrates the concepts of **declare array with init and len**.

```v
fn main() {
    mut j := []int{len: 3, init: 1}
    println(j)
}

```

#### Declare Array With Cap

_File location: `arrays_and_maps/01_arrays/01_array_declaration/05_declare_array_with_cap/05_declare_array_with_cap.v`_

This example demonstrates the concepts of **declare array with cap**.

```v
fn main() {
    mut k := []int{cap: 2}
    println(k)
}

```

#### Define Fixed Size Array

_File location: `arrays_and_maps/01_arrays/05_fixed_size_arrays/01_define_fixed_size_array/01_define_fixed_size_array.v`_

This example demonstrates the concepts of **define fixed size array**.

```v
fn main() {
    mut fix := [4]int{}
    println(fix)
    // [0, 0, 0, 0]
}

```

#### Update Fixed Size Array Elements

_File location: `arrays_and_maps/01_arrays/05_fixed_size_arrays/02_update_fixed_size_array_elements/02_update_fixed_size_array_elements.v`_

This example demonstrates the concepts of **update fixed size array elements**.

```v
fn main() {
    mut fix := [4]int{}
    fix[1] = 33
    println(fix)
    //[0, 33, 0, 0]
}

```

#### Determining Type Of Fixed Array

_File location: `arrays_and_maps/01_arrays/05_fixed_size_arrays/03_determining_type_of_fixed_array/03_determining_type_of_fixed_array.v`_

This example demonstrates the concepts of **determining type of fixed array**.

```v
fn main() {
    mut fix := [4]int{}
    println(typeof(fix).name) // [4]int
}

```

#### Slicing Fixed Size Array Results In Ordinary Array

_File location: `arrays_and_maps/01_arrays/05_fixed_size_arrays/04_slicing_fixed_size_array_results_in_ordinary_array/04_slicing_fixed_size_array_results_in_ordinary_array.v`_

This example demonstrates the concepts of **slicing fixed size array results in ordinary array**.

```v
fn main() {
    mut fix := [4]int{}
    fix[1] = 33
    s := fix[1..]
    println(s)
    // [33, 0, 0]
    println(typeof(s).name) // prints: []int
}

```

#### Declaring Multi Dimensional Arrays

_File location: `arrays_and_maps/01_arrays/06_multi_dimensional_arrays/01_declaring_multi_dimensional_arrays/01_declaring_multi_dimensional_arrays.v`_

This example demonstrates the concepts of **declaring multi dimensional arrays**.

```v
fn main() {
    mut coordinates_2d := [][]int{len: 4, init: []int{len: 2}}
    println(typeof(coordinates_2d).name)
    // [][]int
    println(coordinates_2d)
    // [[0, 0], [0, 0], [0, 0], [0, 0]]
}

```

#### Updating Multi Dimensional Arrays

_File location: `arrays_and_maps/01_arrays/06_multi_dimensional_arrays/02_updating_multi_dimensional_arrays/02_updating_multi_dimensional_arrays.v`_

This example demonstrates the concepts of **updating multi dimensional arrays**.

```v
fn main() {
    mut coordinates_2d := [][]int{len: 4, init: []int{len: 2}}
    println(coordinates_2d.len)

    point_1 := [0, 0]
    point_2 := [0, 1]
    point_3 := [1, 0]
    point_4 := [1, 1]

    coordinates_2d[0] = point_1
    coordinates_2d[1] = point_2
    coordinates_2d[2] = point_3
    coordinates_2d[3] = point_4
    println(coordinates_2d)
}

```

#### Updating Multi Dimensional Arrays

_File location: `arrays_and_maps/01_arrays/06_multi_dimensional_arrays/03_updating_multi_dimensional_arrays/03_updating_multi_dimensional_arrays.v`_

This example demonstrates the concepts of **updating multi dimensional arrays**.

```v
fn main() {
    mut coordinates_2d := [][]int{len: 4, init: []int{len: 2}}
    println(coordinates_2d.len)
    coordinates_2d = [
        [0, 0],
        [0, 1],
        [1, 0],
        [1, 1],
    ]
    println(coordinates_2d)
}

```

#### Access Array Elements Using Index

_File location: `arrays_and_maps/01_arrays/03_accessing_array_elements/01_access_array_elements_using_index/01_access_array_elements_using_index.v`_

This example demonstrates the concepts of **access array elements using index**.

```v
fn main() {
    mut sports := ['cricket', 'hockey', 'football']
    s := sports[1]
    println(s) // hockey
}

```

#### Access Array Elements Using Slices

_File location: `arrays_and_maps/01_arrays/03_accessing_array_elements/02_access_array_elements_using_slices/02_access_array_elements_using_slices.v`_

This example demonstrates the concepts of **access array elements using slices**.

```v
fn main() {
    mut sports := ['cricket', 'hockey', 'football']
    println(sports[1..3])
}

```

#### Array Methods

_File location: `arrays_and_maps/01_arrays/08_array_methods/01_array_methods/01_array_methods.v`_

This example demonstrates the concepts of **array methods**.

```v
module main

// A custom comparison function for sorting.
// It accepts references to elements (e.g. &int) and returns -1, 1, or 0.
fn compare_ints(a &int, b &int) int {
	val_a := *a
	val_b := *b
	if val_a < val_b { return -1 }
	if val_a > val_b { return 1 }
	return 0
}

fn main() {
	println('--- Array Built-in Methods ---')

	// 1. ensure_cap(required)
	// Ensures that the array has at least the specified capacity.
	mut a := [10, 20, 30]
	a.ensure_cap(10)
	println('ensure_cap: cap is ${a.cap >= 10}') // true

	// 2. repeat(count)
	// Repeats the array count times and returns a new array.
	rep := a.repeat(2)
	println('repeat: ${rep}') // [10, 20, 30, 10, 20, 30]

	// 3. repeat_to_depth(count, depth) (unsafe)
	// Recursively repeats a multi-dimensional array count times to the specified depth.
	grid := [[1, 2], [3, 4]]
	unsafe {
		rep_grid := grid.repeat_to_depth(2, 1)
		// Cast the raw array struct back to typed [][]int
		typed_grid := *(&[][]int(&rep_grid))
		println('repeat_to_depth: ${typed_grid}') // [[1, 2], [3, 4], [1, 2], [3, 4]]
		rep_grid.free()
	}

	// 4. insert(index, val)
	// Inserts a new element at the specified index.
	a.insert(1, 15)
	println('insert: ${a}') // [10, 15, 20, 30]

	// 5. prepend(val)
	// Prepends a new element at the beginning of the array.
	a.prepend(5)
	println('prepend: ${a}') // [5, 10, 15, 20, 30]

	// 6. delete(index)
	// Deletes the element at the specified index.
	a.delete(1) // Deletes index 1 (which is 10)
	println('delete: ${a}') // [5, 15, 20, 30]

	// 7. delete_many(index, size)
	// Deletes size elements starting from the specified index.
	a.delete_many(1, 2) // Deletes 2 elements starting at index 1
	println('delete_many: ${a}') // [5, 30]

	// 8. clear()
	// Sets the array length to 0, retaining capacity.
	mut a_clear := [1, 2, 3]
	a_clear.clear()
	println('clear: len is ${a_clear.len}') // 0

	// 9. reset() (unsafe)
	// Sets all elements of the array to 0 / empty values without altering len or cap.
	mut a_reset := [1, 2, 3]
	unsafe {
		a_reset.reset()
	}
	println('reset: ${a_reset}') // [0, 0, 0]
	unsafe {
		a_reset.free()
	}

	// 10. trim(index)
	// Truncates the array length to index.
	mut a_trim := [1, 2, 3, 4]
	a_trim.trim(2)
	println('trim: ${a_trim}') // [1, 2]

	// 11. drop(num)
	// Drops the first num elements in-place.
	mut a_drop := [1, 2, 3, 4]
	a_drop.drop(2)
	println('drop: ${a_drop}') // [3, 4]

	// 12. first()
	// Returns the first element of the array.
	println('first: ${a_drop.first()}') // 3

	// 13. last()
	// Returns the last element of the array.
	println('last: ${a_drop.last()}') // 4

	// 14. pop_left()
	// Removes and returns the first element of the array.
	mut a_pop := [1, 2, 3]
	first_val := a_pop.pop_left()
	println('pop_left: value = ${first_val}, array = ${a_pop}') // 1, [2, 3]

	// 15. pop()
	// Removes and returns the last element of the array.
	last_val := a_pop.pop()
	println('pop: value = ${last_val}, array = ${a_pop}') // 3, [2]

	// 16. delete_last()
	// Deletes the last element of the array.
	mut a_del_last := [1, 2, 3]
	a_del_last.delete_last()
	println('delete_last: ${a_del_last}') // [1, 2]

	// 17. clone()
	// Returns a deep copy of the array.
	a_clone := a_del_last.clone()
	println('clone: ${a_clone}') // [1, 2]

	// 18. clone_to_depth(depth) (unsafe)
	// Recursively clones a multi-dimensional array up to the specified depth.
	grid2 := [[1, 2], [3, 4]]
	unsafe {
		grid_clone := grid2.clone_to_depth(1)
		typed_clone := *(&[][]int(&grid_clone))
		println('clone_to_depth: ${typed_clone}') // [[1, 2], [3, 4]]
		grid_clone.free()
	}

	// 19. push_many(val, size) (unsafe)
	// Appends size elements starting from a raw pointer val to the array.
	mut a_push := [1, 2]
	vals := [3, 4]
	unsafe {
		a_push.push_many(vals.data, 2)
	}
	println('push_many: ${a_push}') // [1, 2, 3, 4]
	unsafe {
		a_push.free()
		vals.free()
	}

	// 20. reverse()
	// Returns a new reversed copy of the array.
	a_rev := [1, 2, 3]
	println('reverse: ${a_rev.reverse()}') // [3, 2, 1]

	// 21. reverse_in_place()
	// Reverses the array elements in-place.
	mut a_rev_ip := [1, 2, 3]
	a_rev_ip.reverse_in_place()
	println('reverse_in_place: ${a_rev_ip}') // [3, 2, 1]

	// 22. free() (unsafe)
	// Deallocates the array's buffer.
	mut a_free := [1, 2, 3]
	unsafe {
		a_free.free()
	}
	println('free: array freed')

	// 23. filter(it)
	// Filters elements that satisfy a predicate using compiler-defined `it` expression.
	a_filt := [1, 2, 3, 4]
	filtered := a_filt.filter(it % 2 == 0)
	println('filter: ${filtered}') // [2, 4]

	// 24. any(it)
	// Checks if any element satisfies the predicate.
	println('any: ${a_filt.any(it > 3)}') // true

	// 25. count(it)
	// Counts how many elements satisfy the predicate.
	println('count: ${a_filt.count(it % 2 == 0)}') // 2

	// 26. all(it)
	// Checks if all elements satisfy the predicate.
	println('all: ${a_filt.all(it > 0)}') // true

	// 27. map(it)
	// Maps elements to a new array using a transformation expression.
	mapped := a_filt.map(it * 10)
	println('map: ${mapped}') // [10, 20, 30, 40]

	// 28. sort() & sort(custom)
	// Sorts elements in-place. Uses optional boolean expression for custom order (uses magic vars a and b).
	mut a_sort := [3, 1, 4, 2]
	a_sort.sort()
	println('sort (default ascending): ${a_sort}') // [1, 2, 3, 4]
	a_sort.sort(a > b)
	println('sort (custom descending): ${a_sort}') // [4, 3, 2, 1]

	// 29. sorted() & sorted(custom)
	// Returns a sorted copy of the array. Uses optional boolean expression for custom order (uses magic vars a and b).
	a_sorted := [3, 1, 4, 2]
	println('sorted (default): ${a_sorted.sorted()}') // [1, 2, 3, 4]
	println('sorted (custom): ${a_sorted.sorted(a > b)}') // [4, 3, 2, 1]

	// 30. sort_with_compare(callback)
	// Sorts the array in-place using a custom comparison function.
	mut a_compare := [3, 1, 4, 2]
	a_compare.sort_with_compare(compare_ints)
	println('sort_with_compare: ${a_compare}') // [1, 2, 3, 4]

	// 31. sorted_with_compare(callback)
	// Returns a sorted copy of the array using a custom comparison function.
	a_sorted_comp := [3, 1, 4, 2]
	println('sorted_with_compare: ${a_sorted_comp.sorted_with_compare(compare_ints)}') // [1, 2, 3, 4]

	// 32. contains(value)
	// Checks if the array contains value.
	println('contains: ${a_filt.contains(3)}') // true

	// 33. index(value)
	// Returns the index of the first occurrence of value, or -1 if not found.
	println('index: ${a_filt.index(3)}') // 2

	// 34. last_index(value)
	// Returns the index of the last occurrence of value, or -1 if not found.
	a_dup := [1, 2, 3, 2]
	println('last_index: ${a_dup.last_index(2)}') // 3

	// 35. grow_cap(amount)
	// Increases the array capacity by the specified amount.
	mut a_grow := [1, 2]
	a_grow.grow_cap(10)
	println('grow_cap: cap is ${a_grow.cap >= 12}') // true

	// 36. grow_len(amount) (unsafe)
	// Increases the array length by the specified amount.
	unsafe {
		a_grow.grow_len(3)
	}
	println('grow_len: ${a_grow}') // [1, 2, 0, 0, 0]
	unsafe {
		a_grow.free()
	}

	// 37. pointers() (unsafe)
	// Returns an array of void pointers (pointers()) pointing to each element.
	a_ptrs := [10, 20]
	unsafe {
		ptrs := a_ptrs.pointers()
		println('pointers (first element): ${*(&int(ptrs[0]))}') // 10
		ptrs.free()
		a_ptrs.free()
	}
}
```

### Maps

#### Explicit Map Initialization

_File location: `arrays_and_maps/02_maps/01_explicit_map_initialization/01_explicit_map_initialization.v`_

This example demonstrates the concepts of **explicit map initialization**.

```v
fn main() {
    mut books := map[string]int{}
    books['V on Wheels'] = 320
    books['Go for Dummies'] = 279

    println(books)
}

```

#### Short Syntax Initialization Of Map

_File location: `arrays_and_maps/02_maps/02_short_syntax_initialization_of_map/02_short_syntax_initialization_of_map.v`_

This example demonstrates the concepts of **short syntax initialization of map**.

```v
fn main() {
    mut student_1 := {
        'english':     90
        'mathematics': 96
        'physics':     83
        'chemistry':   89
    }
    println(student_1)
}

```

#### Count Key Value Pairs In Map

_File location: `arrays_and_maps/02_maps/03_count_key_value_pairs_in_map/03_count_key_value_pairs_in_map.v`_

This example demonstrates the concepts of **count key value pairs in map**.

```v
fn main() {
    mut student_1 := {
        'english':     90
        'mathematics': 96
        'physics':     83
        'chemistry':   89
    }
    cnt := student_1.len
    println('There are ${cnt} key-value pairs in student_1 map')
}

```

#### Value Given Key Of Map

_File location: `arrays_and_maps/02_maps/04_value_given_key_of_map/04_value_given_key_of_map.v`_

This example demonstrates the concepts of **value given key of map**.

```v
fn main() {
    mut student_1 := {
        'english':     90
        'mathematics': 96
        'physics':     83
        'chemistry':   89
    }

    println(student_1['physics']) // 83
}

```

#### Value Given Non Existent Key Of Map

_File location: `arrays_and_maps/02_maps/05_value_given_non_existent_key_of_map/05_value_given_non_existent_key_of_map.v`_

This example demonstrates the concepts of **value given non existent key of map**.

```v
fn main() {
    mut student_1 := {
        'english':     90
        'mathematics': 96
        'physics':     83
        'chemistry':   89
    }

    println(student_1['geography']) // 0
}

```

#### Handling Missing Keys In Map

_File location: `arrays_and_maps/02_maps/06_handling_missing_keys_in_map/06_handling_missing_keys_in_map.v`_

This example demonstrates the concepts of **handling missing keys in map**.

```v
fn main() {
    mut student_1 := {
        'english':     90
        'mathematics': 96
        'physics':     83
        'chemistry':   89
    }

    sub := 'geography'
    res := student_1[sub] or { panic('marks for subject ${sub} not yet updated') } // throws error
}

```

#### Update Value Given A Key In Map

_File location: `arrays_and_maps/02_maps/07_update_value_given_a_key_in_map/07_update_value_given_a_key_in_map.v`_

This example demonstrates the concepts of **update value given a key in map**.

```v
fn main() {
    mut student_1 := {
        'english':     90
        'mathematics': 96
        'physics':     83
        'chemistry':   89
    }
    student_1['english'] = 93
    println(student_1)
}

```

#### Delete Key Value Pair From Map

_File location: `arrays_and_maps/02_maps/08_delete_key_value_pair_from_map/08_delete_key_value_pair_from_map.v`_

This example demonstrates the concepts of **delete key value pair from map**.

```v
fn main() {
    mut student_1 := {
        'english':     90
        'mathematics': 96
        'physics':     83
        'chemistry':   89
    }

    println('Key-Value pairs before deleting a key: ${student_1.len}')
    student_1.delete('physics')
    println('Key-Value pairs after deleting a key ${student_1.len}')
}

```

#### Map Methods

_File location: `arrays_and_maps/02_maps/09_map_methods/01_map_methods/01_map_methods.v`_

This example demonstrates the concepts of **map methods**.

```v
module main

fn main() {
	println('--- Map Built-in Methods ---')

	mut m := {
		'one': 1
		'two': 2
	}
	println('initial map: ${m}') // {"one": 1, "two": 2}

	// 1. keys()
	// Returns an array containing all keys in the map.
	println('keys: ${m.keys()}') // ["one", "two"]

	// 2. values()
	// Returns an array containing all values in the map.
	println('values: ${m.values()}') // [1, 2]

	// 3. clone()
	// Returns a deep copy of the map.
	mut m_clone := m.clone()
	println('clone: ${m_clone}') // {"one": 1, "two": 2}

	// 4. delete(key)
	// Removes a key-value pair from the map by key.
	m.delete('one')
	println('delete: ${m}') // {"two": 2}

	// 5. reserve(capacity)
	// Pre-allocates space for at least capacity elements in the map.
	m.reserve(10)
	println('reserve: reserved capacity successfully')

	// 6. clear()
	// Removes all key-value pairs from the map without deallocating data.
	m.clear()
	println('clear: len is ${m.len}') // 0

	// 7. move()
	// Moves the map contents to a new map variable and clears the original map to empty.
	mut m_move := {
		'three': 3
		'four': 4
	}
	moved := m_move.move()
	println('move (new map): ${moved}') // {"three": 3, "four": 4}
	println('move (original map): ${m_move}') // {}

	// 8. free() (unsafe)
	// Deallocates the map memory.
	mut m_free := {
		'temp': 100
	}
	unsafe {
		m_free.free()
	}
	println('free: map freed successfully')
}
```

## Control Flow

### If Statement

#### If With Goto

_File location: `control_flow/01_If_Statement/if_with_goto/if_with_goto.v`_

This example demonstrates the concepts of **if with goto**.

```v
module main

import os

fn main() {
    improper_input_age:
    println('Invalid input. Please provide value greater than 0.')

    next_person:
    inp := os.input('Enter your age:')

    if inp != 'stop' {
        age := inp.int()

        if age >= 13 {
            println('You are allowed to watch this movie')
        } else if age > 0 && age < 13 {
            println('Parental Guidance is required to watch this movie')
        } else if age <= 0 {
            unsafe {
                goto improper_input_age
            }
        }
        unsafe {
            goto next_person
        }
    }
}

```

#### Chaining Else If

_File location: `control_flow/01_If_Statement/chaining_else_if/chaining_else_if.v`_

This example demonstrates the concepts of **chaining else if**.

```v
module main

fn breakfast_menu(day string) {
    if day == 'Monday' {
        println('Bread, Jam, Half boiled Egg')
    } else if day == 'Tuesday' {
        println('Bread, Jam, Juice')
    } else if day == 'Wednesday' {
        println('Milk, Bread, Fruit Bowl')
    } else if day == 'Thursday' {
        println('Bread, Jam, Juice')
    } else if day == 'Friday' {
        println('Cereals, Bread, Jam, Half boiled Egg')
    } else if day == 'Saturday' {
        println('Milk, Bread, Fruit Bowl')
    } else if day == 'Sunday' {
        println('Cereals, Bread, Jam, Half boiled Egg')
    } else {
        println('invalid input')
    }
}

fn main() {
    breakfast_menu('Saturday')
}

```

### Iterative Statements

#### Continue For

_File location: `control_flow/03_Iterative_statements/continue_for/continue_for.v`_

This example demonstrates the concepts of **continue for**.

```v
module main

fn main() {
    for i in 0 .. 10 {
        if i % 2 == 0 { // skips printing number that is a multiple of 2
            continue
        }
        println(i)
    }
}

```

#### For On Maps Ignore Key

_File location: `control_flow/03_Iterative_statements/for_on_maps_ignore_key/for_on_maps_ignore_key.v`_

This example demonstrates the concepts of **for on maps ignore key**.

```v
module main

fn main() {
    basket := {
        'apples':  10
        'bananas': 12
    }

    mut total := 0
    for _, v in basket {
        total += v
    }
    println('Total number of fruits: $total')
}

```

#### For On Maps

_File location: `control_flow/03_Iterative_statements/for_on_maps/for_on_maps.v`_

This example demonstrates the concepts of **for on maps**.

```v
module main

fn main() {
    lottery := {
        'First':       1000
        'Second':      700
        'Consolation': 200
    }

    for k, v in lottery {
        println('$k prize lottery amount: $v')
    }
}

```

#### For On Array Without Index

_File location: `control_flow/03_Iterative_statements/for_on_array_without_index/for_on_array_without_index.v`_

This example demonstrates the concepts of **for on array without index**.

```v
module main

fn main() {
    col := [1, 2, 3, 4, 5, 6, 7]
    for val in col {
        if val % 2 == 0 {
            println('$val is Even')
        } else {
            println('$val is Odd')
        }
    }
}

```

#### For On Arrays

_File location: `control_flow/03_Iterative_statements/for_on_arrays/for_on_arrays.v`_

This example demonstrates the concepts of **for on arrays**.

```v
module main

fn main() {
    fruits := ['apple', 'banana', 'coconut']
    for idx, ele in fruits {
        println('idx: $idx \t fruit: $ele')
    }
}

```

#### Reverse For

_File location: `control_flow/03_Iterative_statements/reverse_for/reverse_for.v`_

This example demonstrates the concepts of **reverse for**.

```v
module main

fn main() {
    subjects := ['zoology', 'chemistry', 'physics', 'algebra']

    for i := subjects.len - 1; i >= 0; i-- {
        println(subjects[i])
    }
}

```

#### Bare For

_File location: `control_flow/03_Iterative_statements/bare_for/bare_for.v`_

This example demonstrates the concepts of **bare for**.

```v
module main

fn main() {
    mut count := 1
    for {
        println('Hi $count times')
        count += 1
    }
}

```

#### For C Style

_File location: `control_flow/03_Iterative_statements/for_c_style/for_c_style.v`_

This example demonstrates the concepts of **for c style**.

```v
module main

fn main() {
    sample := [3, 4, 23, 12, 4, 1, 45, 12, 42, 17, 92, 38]
    for i := 0; i < sample.len; i += 3 {
        println(sample[i])
    }
}

```

#### For With Continue Break And Labels

_File location: `control_flow/03_Iterative_statements/for_with_continue_break_and_labels/for_with_continue_break_and_labels.v`_

This example demonstrates the concepts of **for with continue break and labels**.

```v
module main

import os

fn main() {
    input := os.input('Enter the number of multiplication tables to print:')
    limit := input.int()
    if limit <= 0 {
        return
    }
    first_loop: for i := 1; i <= 10; i++ {
        println('Printing multiplication table for $i')
        for j := 1; j <= 10; j++ {
            mul := i * j
            println('$i * $j = $mul')
            if mul >= limit * 10 {
                break first_loop
            }
        }
        println('*********')
    }
}

```

#### For On Range

_File location: `control_flow/03_Iterative_statements/for_on_range/for_on_range.v`_

This example demonstrates the concepts of **for on range**.

```v
module main

fn main() {
    for val in 0 .. 4 {
        println(val)
    }
}

```

#### Break For

_File location: `control_flow/03_Iterative_statements/break_for/break_for.v`_

This example demonstrates the concepts of **break for**.

```v
module main

import os

fn main() {
    mut count := 0
    input := os.input('Enter number of times to Greet:')
    limit := input.int()
    for {
        if count >= limit {
            break
        }
        println('Hi')
        count += 1
    }
    println('Greeted Hi $count times')
}

```

### Match

#### Match As Switch Case

_File location: `control_flow/02_Match/match_as_switch_case/match_as_switch_case.v`_

This example demonstrates the concepts of **match as switch case**.

```v
module main

fn breakfast_menu(day string) {
    match day {
        'Monday' { println('Bread, Jam, Half boiled Egg') }
        'Tuesday' { println('Bread, Jam, Juice') }
        'Wednesday' { println('Milk, Bread, Fruit Bowl') }
        'Thursday' { println('Bread, Jam, Juice') }
        'Friday' { println('Cereals, Bread, Jam, Half boiled Egg') }
        'Saturday' { println('Milk, Bread, Fruit Bowl') }
        'Sunday' { println('Cereals, Bread, Jam, Half boiled Egg') }
        else { println('invalid input') }
    }
}

fn main() {
    breakfast_menu('Sunday')
}

```

#### Cascade Match Conditions

_File location: `control_flow/02_Match/cascade_match_conditions/cascade_match_conditions.v`_

This example demonstrates the concepts of **cascade match conditions**.

```v
module main

fn breakfast_menu(day string) string {
    return match day {
        'Monday' {
            'Bread, Jam, Half boiled Egg'
        }
        'Tuesday', 'Thursday' {
            'Bread, Jam, Juice'
        }
        'Wednesday' {
            'Milk, Bread, Fruit Bowl'
        }
        'Friday', 'Sunday' {
            'Cereals, Bread, Jam, Half boiled Egg'
        }
        'Saturday' {
            'Milk, Bread, Fruit Bowl'
        }
        else {
            'invalid input'
        }
    }
}

fn main() {
    friday_menu := breakfast_menu('Friday')
    println(friday_menu)

    sunday_menu := breakfast_menu('Sunday')
    println(sunday_menu)

    tuesday_menu := breakfast_menu('Tuesday')
    println(tuesday_menu)

    thursday_menu := breakfast_menu('Thursday')
    println(thursday_menu)
}

```

#### Match With Enum

_File location: `control_flow/02_Match/match_with_enum/match_with_enum.v`_

This example demonstrates the concepts of **match with enum**.

```v
module main

enum Day {
    sunday
    monday
    tuesday
    wednesday
    thursday
    friday
    saturday
}

fn breakfast_menu(day Day) string {
    return match day {
        .monday {
            'Bread, Jam, Half boiled Egg'
        }
        .tuesday, .thursday {
            'Bread, Jam, Juice'
        }
        .wednesday {
            'Milk, Bread, Fruit Bowl'
        }
        .friday, .sunday {
            'Cereals, Bread, Jam, Half boiled Egg'
        }
        .saturday {
            'Milk, Bread, Fruit Bowl'
        }
    }
}

fn main() {
    friday_menu := breakfast_menu(Day.friday)
    println(friday_menu)

    sunday_menu := breakfast_menu(Day.sunday)
    println(sunday_menu)

    tuesday_menu := breakfast_menu(Day.tuesday)
    println(tuesday_menu)

    thursday_menu := breakfast_menu(Day.thursday)
    println(thursday_menu)
}

```

#### Match With Enum And Else

_File location: `control_flow/02_Match/match_with_enum_and_else/match_with_enum_and_else.v`_

This example demonstrates the concepts of **match with enum and else**.

```v
module main

enum Day {
    sunday
    monday
    tuesday
    wednesday
    thursday
    friday
    saturday
}

fn weekend_breakfast_menu(day Day) string {
    return match day {
        .sunday {
            'Cereals, Bread, Jam, Half boiled Egg'
        }
        .saturday {
            'Milk, Bread, Fruit Bowl'
        }
        else {
            'Sorry, we are closed on weekdays!'
        }
    }
}

fn main() {
    sunday_menu := weekend_breakfast_menu(Day.sunday)
    println(sunday_menu)

    tuesday_menu := weekend_breakfast_menu(Day.tuesday)
    println(tuesday_menu)
}

```

#### Match Pattern Matching

_File location: `control_flow/02_Match/match_pattern_matching/match_pattern_matching.v`_

This example demonstrates the concepts of **match pattern matching**.

```v
module main

fn main() {
    age := 18
    res := match age {
        0...18 { 'Person with age $age classified as a Child' }
        19...120 { 'Person with age $age classified as an Adult' }
        else { '$age is must be in the range 0 to 120' }
    }
    println(res)
}

```

## Functions

### Function Types

#### Basic Functions

_File location: `functions/01_function_types/01_basic_functions/basic_functions.v`_

This example demonstrates the concepts of **basic functions**.

```v
fn greet(msg string) {
    println(msg)
}

fn main() {
    greet('Hello, Welcome to the world of V programming')
}

```

#### Anonymous Functions

_File location: `functions/01_function_types/02_anonymous_functions/anonymous_functions.v`_

This example demonstrates the concepts of **anonymous functions**.

```v
module main

fn main() {
    greet := fn (name string) {
        println('Hello, ${name}')
    }
    greet('Pavan')
    greet('Sahithi')
}

```

#### Hello

_File location: `functions/01_function_types/00_main_function/hello.v`_

This example demonstrates the concepts of **hello**.

```v
module main

fn main() {
    println('Welcome to the World of V!')
}

```

#### Functions As Input Arguments

_File location: `functions/01_function_types/03_higher_order_functions/01_functions_as_input_arguments/01_functions_as_input_arguments.v`_

This example demonstrates the concepts of **functions as input arguments**.

```v
module main

fn greet_morning() string {
    return 'Good Morning'
}

fn greet_noon() string {
    return 'Good Afternoon'
}

fn greet_evening() string {
    return 'Good Evening'
}

fn greet(f fn () string, name string) string {
    return '${f()}, ${name}!'
}

fn main() {
    mut res := greet(greet_morning, 'Pavan')
    println(res)

    res = greet(greet_evening, 'Sahithi')
    println(res)

    res = greet(fn () string {
        return 'New year greetings to you'
    }, 'Sahithi')
    println(res)
}

```

#### Functions That Return Other Functions

_File location: `functions/01_function_types/03_higher_order_functions/02_functions_that_return_other_functions/02_functions_that_return_other_functions.v`_

This example demonstrates the concepts of **functions that return other functions**.

```v
module main

enum Operation {
    add
    sub
    mul
}

fn adder(i int, j int) int {
    return i + j
}

fn subtractor(i int, j int) int {
    return i - j
}

fn multiplier(i int, j int) int {
    return i * j
}

fn fetch(op Operation) fn (int, int) int {
    return match op {
        .add {
            adder
        }
        .sub {
            subtractor
        }
        .mul {
            multiplier
        }
    }
}

fn main() {
    i, j := 2, 5
    mut f := fetch(.add) // return adder function
    mut res := f(i, j) // calls adder(2, 5)
    println('sum of ${i} and ${j}: ${res}')

    f = fetch(.sub) // returns subtractor function
    res = f(i, j) // calls subtractor(2, 5)
    println('difference of ${i} and ${j}: ${res}')

    f = fetch(.mul) // returns multipler function
    res = f(i, j) // calls multiplier(2, 5)
    println('product of ${i} and ${j}: ${res}')
}

```

### Understanding Funtion Features

#### Functions With Optional Return Types Example 1

_File location: `functions/02_understanding_funtion_features/09_functions_with_optional_return_types/01_functions_with_optional_return_types_example_1.v`_

This example demonstrates the concepts of **functions with optional return types example 1**.

```v
module main

fn is_teen(age int) ?string {
    if age < 0 {
        return none
    } else if age >= 13 && age <= 19 {
        return 'teenager'
    } else {
        return 'not teenager'
    }
}

fn main() {
    x := is_teen(-3) or { 'invalid age provided' }
    println(x)
}

```

#### Function With Optional Return Type Example 2

_File location: `functions/02_understanding_funtion_features/09_functions_with_optional_return_types/02_function_with_optional_return_type_example_2.v`_

This example demonstrates the concepts of **function with optional return type example 2**.

```v
module main

fn is_teen(age int) ?string {
    if age < 0 {
        return error('invalid age provided')
    } else if age >= 13 && age <= 19 {
        return 'teenager'
    } else {
        return 'not teenager'
    }
}

fn main() {
    x := is_teen(-3) or { err.msg }
    println(x)
}

```

#### Function With Defer Block

_File location: `functions/02_understanding_funtion_features/11_functions_with_defer_block/01_function_with_defer_block.v`_

This example demonstrates the concepts of **function with defer block**.

```v
module main

fn void_func_defer() {
    println('Hello')
    defer {
        println('Hi from defer block')
    }
    println('How are you?')

    // the defer block will be executed when the execution control reaches here
}

fn main() {
    void_func_defer()
}

```

#### Function Calls Other Function

_File location: `functions/02_understanding_funtion_features/05_function_calls_other_function/01_function_calls_other_function.v`_

This example demonstrates the concepts of **function calls other function**.

```v
fn greet(p string) string {
    return 'Hello, ${p}!'
}

fn welcome(p string) string {
    msg := 'Nice to meet you!'
    mut g := greet(p)
    g = g + ' ${msg}'
    return g
}

fn main() {
    res := welcome('Visitor')
    println(res)
}

```

#### Function Return Multiple Values

_File location: `functions/02_understanding_funtion_features/03_function_return_multiple_values/01_function_return_multiple_values.v`_

This example demonstrates the concepts of **function return multiple values**.

```v
fn greet_and_message_length(name string) (string, int) {
    mut greeting := 'Hello, ' + name + '!'
    return greeting, greeting.len
}

fn main() {
    i, j := greet_and_message_length('Navule')
    println(i)
    println(j)
}

```

#### Functions As Elements Of Array Or Map

_File location: `functions/02_understanding_funtion_features/12_functions_as_elements_of_array_or_map/01_functions_as_elements_of_array_or_map.v`_

This example demonstrates the concepts of **functions as elements of array or map**.

```v
module main

fn adder(i int, j int) int {
    return i + j
}

fn subtractor(i int, j int) int {
    return i - j
}

fn multiplier(i int, j int) int {
    return i * j
}

fn main() {
    i, j := 2, 5
    println('Functions as elements of an Array')
    funcs := [adder, subtractor, multiplier]

    for f in funcs {
        res := f(i, j)
        println(res)
    }
    println('Functions as elements of Map')
    d := {
        'sum':        adder
        'difference': subtractor
        'product':    multiplier
    }

    for key, val in d {
        res := val(i, j)
        println('${key} of ${i} and ${j}: ${res}')
    }
}

```

#### Public Function Demo1

_File location: `functions/02_understanding_funtion_features/10_functions_marked_public/public_function_demo1.v`_

This example demonstrates the concepts of **public function demo1**.

```v
// file: public_function_demo1.v
import mod1

fn main() {
    g := mod1.greet1()
    println(g)
}

```

#### Public Function Demo2

_File location: `functions/02_understanding_funtion_features/10_functions_marked_public/public_function_demo2.v`_

This example demonstrates the concepts of **public function demo2**.

```v
// file: public_function_demo2.v
import mod1

fn main() {
    g := mod1.greet2()
    println(g)
}

```

#### Public Function Demo3

_File location: `functions/02_understanding_funtion_features/10_functions_marked_public/public_function_demo3.v`_

This example demonstrates the concepts of **public function demo3**.

```v
// file: public_function_demo3.v
import mod1

fn main() {
    g := mod1.greet_and_wish()
    println(g)
}

```

#### Mod1

_File location: `functions/02_understanding_funtion_features/10_functions_marked_public/mod1/mod1.v`_

This example demonstrates the concepts of **mod1**.

```v
// file: mod1/mod1.v
module mod1

fn greet1() string {
    return 'Hello from greet1'
}

pub fn greet2() string {
    return 'Hello from greet2'
}

pub fn greet_and_wish() string {
    wish := 'Have a nice day!'
    return greet1() + ', ' + wish
}

```

#### Example 1

_File location: `functions/02_understanding_funtion_features/06_allowed_function_input_argument_types/01_example_1.v`_

This example demonstrates the concepts of **example 1**.

```v
fn increment_array_items(arr []int, inc int) []int {
    mut tmp := arr.clone()
    for mut i in tmp {
        i += inc
    }
    return tmp
}

fn main() {
    a := [5, 6]

    res := increment_array_items(a, 100)

    println('a: ${a}')
    println('res: ${res}')
}

```

#### Example 2

_File location: `functions/02_understanding_funtion_features/06_allowed_function_input_argument_types/02_example_2.v`_

This example demonstrates the concepts of **example 2**.

```v
fn increment_array_items(mut arr []int, inc int) {
    for mut i in arr {
        i += inc
    }
}

fn main() {
    mut a := [5, 6]
    increment_array_items(mut a, 100)
    // Must specify mut keyword when sending value to mut arg of a function
    println('a: ${a}')
}

```

#### Ignore Function Return Value

_File location: `functions/02_understanding_funtion_features/04_ignore_function_return_values/01_ignore_function_return_value.v`_

This example demonstrates the concepts of **ignore function return value**.

```v
fn greet_and_message_length(name string) (string, int) {
    mut greeting := 'Hello, ' + name + '!'
    return greeting, greeting.len
}

fn main() {
    i, _ := greet_and_message_length('Navule')
    println(i)
}

```

#### Function With Input Arguments

_File location: `functions/02_understanding_funtion_features/02_function_and_input_arguments/01_function_with_input_arguments.v`_

This example demonstrates the concepts of **function with input arguments**.

```v
fn add(a int, b int) int {
    return a + b
}

fn main() {
    res := add(2, 4)
    println(res)
    // prints: 6
}

```

#### Main

_File location: `functions/02_understanding_funtion_features/08_functions_and_module_variables/main.v`_

This example demonstrates the concepts of **main**.

```v
// file: main.v
module main

import mymod

fn main() {
    mymod.msg := 'global variable demo'
    println(mymod.msg)
}

```

#### Mymod

_File location: `functions/02_understanding_funtion_features/08_functions_and_module_variables/mymod/mymod.v`_

This example demonstrates the concepts of **mymod**.

```v
// file: mymod/mymod.v
module mymod

__global (
    msg string
)

```

#### Function Returns Value Example 1

_File location: `functions/02_understanding_funtion_features/01_functions_return_or_just_perform_operations/01_functions_return_value_or_just_perform_routine/01_function_returns_value_example_1.v`_

This example demonstrates the concepts of **function returns value example 1**.

```v
fn sum(a int, b int) int {
    return a + b
}

fn main() {
    println(sum(2, 3))
}

```

#### Function Returns Value Example 2

_File location: `functions/02_understanding_funtion_features/01_functions_return_or_just_perform_operations/01_functions_return_value_or_just_perform_routine/02_function_returns_value_example_2.v`_

This example demonstrates the concepts of **function returns value example 2**.

```v
fn say_hello() string {
    return 'Hello!'
}

fn main() {
    // call the method
    res := say_hello()
    println(res)
    // prints: Hello!
}

```

#### Funtions Without Return Type

_File location: `functions/02_understanding_funtion_features/01_functions_return_or_just_perform_operations/01_functions_return_value_or_just_perform_routine/03_funtions_without_return_type.v`_

This example demonstrates the concepts of **funtions without return type**.

```v
fn console_greeter() {
    println('Hello!')
}

fn main() {
    console_greeter()
    // prints: Hello!
}

```

## Structs

### Approaches Defining Struct Fields

#### Struct With Multiple Fields

_File location: `structs/03_approaches_defining_struct_fields/01_struct_with_multiple_fields/01_struct_with_multiple_fields.v`_

This example demonstrates the concepts of **struct with multiple fields**.

```v
struct Note {
    id int
mut:
    message string
    status  bool
}

fn main() {
}

```

#### Grouping Struct Fields Based On Access Modifiers

_File location: `structs/03_approaches_defining_struct_fields/02_grouping_struct_fields_based_on_access_modifiers/01_grouping_struct_fields_based_on_access_modifiers.v`_

This example demonstrates the concepts of **grouping struct fields based on access modifiers**.

```v
pub struct Note {
pub:
    id int
pub mut:
    message string
    status  bool
}

fn main() {
}

```

#### Struct Fields With Default Values

_File location: `structs/03_approaches_defining_struct_fields/04_fields_with_default_values/01_struct_fields_with_default_values.v`_

This example demonstrates the concepts of **struct fields with default values**.

```v
import time

pub struct Note {
pub:
    id      int
    created time.Time = time.now()
pub mut:
    message string @[required]
    status  bool
    due     time.Time = time.now().add_days(1)
}

fn main() {
    n := Note{
        id:      1
        message: 'order groceries'
    }
    println(n)
}

```

#### Required Fields Example 01

_File location: `structs/03_approaches_defining_struct_fields/03_required_fields_in_struct/01_required_fields_example_01/01_required_fields_example_01.v`_

This example demonstrates the concepts of **required fields example 01**.

```v
pub struct Note {
pub:
    id int
pub mut:
    message string @[required]
    status  bool
}

fn main() {
    _ := Note{
        id:     1
        status: false
    }
}
// throws error
```

#### Required Fields Example 02

_File location: `structs/03_approaches_defining_struct_fields/03_required_fields_in_struct/02_required_fields_example_02/02_required_fields_example_02.v`_

This example demonstrates the concepts of **required fields example 02**.

```v
module main

pub struct Note {
pub:
    id int
pub mut:
    message string @[required]
    status  bool
}

fn main() {
    n := Note{
        id:      1
        message: 'a simple struct demo'
        status:  false
    }
    println(n)
}

```

### Introducing Structs

#### Access Struct Fields

_File location: `structs/01_introducing_structs/02_access_struct_fields/01_access_struct_fields.v`_

This example demonstrates the concepts of **access struct fields**.

```v
struct Note {
    id      int
    message string
}

fn main() {
    n := Note{1, 'a simple struct demo'}
    println(n.message)
}

```

#### Heap Structs

_File location: `structs/01_introducing_structs/03_heap_structs/01_heap_structs.v`_

This example demonstrates the concepts of **heap structs**.

```v
struct Note {
    id      int
    message string
}

fn main() {
    n1 := &Note{1, 'this note will be allocated on heap'}
    println(typeof(n1).name) // &Note
}

```

#### Defining Struct

_File location: `structs/01_introducing_structs/01_defining_struct/01_defining_struct/01_defining_struct.v`_

This example demonstrates the concepts of **defining struct**.

```v
struct Note {
    id      int
    message string
}

fn main() {
}

```

#### Initialize Struct Example 1

_File location: `structs/01_introducing_structs/01_defining_struct/02_initialize_struct_example_1/02_initialize_struct_example_1.v`_

This example demonstrates the concepts of **initialize struct example 1**.

```v
struct Note {
    id      int
    message string
}

fn main() {
    n := Note{1, 'a simple struct demo'}

    println(n)
}

```

#### Initialize Struct Example 2

_File location: `structs/01_introducing_structs/01_defining_struct/03_initialize_struct_example_2/03_initialize_struct_example_2.v`_

This example demonstrates the concepts of **initialize struct example 2**.

```v
struct Note {
    id      int
    message string
}

fn main() {
    n := Note{
        message: 'a simple struct demo'
        id:      1
    }

    println(typeof(n).name)
    // Note
}

```

### Methods For Struct

#### Methods For Struct

_File location: `structs/04_methods_for_struct/01_methods_for_struct.v`_

This example demonstrates the concepts of **methods for struct**.

```v
module main

import time

pub struct Note {
pub:
    id      int
    created time.Time = time.now()
pub mut:
    message string @[required]
    status  bool
    due     time.Time = time.now().add_days(1)
}

// is_empty_message is a method that belongs to Note
pub fn (n Note) is_empty_message() bool {
    return n.message.len < 1
}

fn main() {
    mut n := Note{
        id:      1
        message: ''
    }

    if n.is_empty_message() {
        println('message is empty')
    } else {
        println('message not empty')
    }
}

```

### Struct As Struct Field

#### Adding Struct As Struct Field

_File location: `structs/05_struct_as_struct_field/01_adding_struct_as_struct_field/01_adding_struct_as_struct_field.v`_

This example demonstrates the concepts of **adding struct as struct field**.

```v
import time

// NoteTimeInfo is a struct to store time info of Note
pub struct NoteTimeInfo {
pub:
    created time.Time = time.now()
pub mut:
    due time.Time = time.now().add_days(1)
}

// Note is a struct with struct NoteTimeInfo as a field, along with other fields
pub struct Note {
    NoteTimeInfo // Struct as another struct field
pub:
    id int
pub mut:
    message string @[required]
    status  bool
}

fn main() {
    n := Note{
        id:      1
        message: 'adding struct as struct field demo'
    }
    println('Due date: ${n.due}')
    println(n)
}

```

#### Updating Fields Of Type Struct

_File location: `structs/05_struct_as_struct_field/02_updating_fields_of_type_struct/01_updating_fields_of_type_struct.v`_

This example demonstrates the concepts of **updating fields of type struct**.

```v
module main

import time

// NoteTimeInfo is a struct to store time info of Note
pub struct NoteTimeInfo {
pub:
    created time.Time = time.now()
pub mut:
    due time.Time = time.now().add_days(1)
}

// Note is a struct with struct NoteTimeInfo as a field, along with other fields
pub struct Note {
    NoteTimeInfo
pub:
    id int
pub mut:
    message string @[required]
    status  bool
}

fn main() {
    mut n := Note{
        id:      1
        message: 'adding struct as struct field demo'
    }

    println('Due date: ${n.due}')
    // approach 1: implicit access of struct fields of fields of type struct
    n.due = n.due.add_days(2)
    println('Due date after update: ${n.due}')

    // approach 2: explicitly specifying the field of type struct and its fields
    n.NoteTimeInfo.due = n.NoteTimeInfo.due.add_days(2)
    println('Due date updated second time: ${n.due}')
    println(n)
}

```

### Struct As Trailing Literal Arguments To Function

#### Struct As Trailing Literal Arguments To Function

_File location: `structs/06_struct_as_trailing_literal_arguments_to_function/01_struct_as_trailing_literal_arguments_to_function.v`_

This example demonstrates the concepts of **struct as trailing literal arguments to function**.

```v
module main

import time

// NoteTimeInfo is a struct to store time info of Note
pub struct NoteTimeInfo {
pub:
    created time.Time = time.now()
pub mut:
    due time.Time = time.now().add_days(1)
}

// Note is a struct with embedding struct NoteTimeInfo along with other fields
pub struct Note {
    NoteTimeInfo
pub:
    id int
pub mut:
    message string @[required]
    status  bool
}

fn new_grocery_note(n Note) &Note {
    return &Note{
        id:      n.id
        message: 'Buy Groceries: ' + n.message
    }
}

fn extend_due_by_a_day(n Note) &Note {
    return &Note{
        NoteTimeInfo: NoteTimeInfo{
            due: n.due.add_days(1)
        }
        id:           n.id
        message:      n.message
    }
}

fn main() {
    g := new_grocery_note(Note{ id: 1, message: 'Milk' })
    println('${g.message} is due by ${g.due}')
    n := extend_due_by_a_day(g)
    println('After extending due date by a day')
    println('${n.message} is due by ${n.due}')
}

```

### Updating Fields Of Struct

#### Updating Mutable Fields Of Struct

_File location: `structs/02_updating_fields_of_struct/02_updating_mutable_fields_of_struct/01_updating_mutable_fields_of_struct.v`_

This example demonstrates the concepts of **updating mutable fields of struct**.

```v
module main

struct Note {
    id int
mut:
    message string
}

fn main() {
    mut n := Note{1, 'a simple struct demo'}
    println('before update')
    println(n)

    n.message = 'a simple struct updated'
    println('after update')
    println(n)
}

```

#### Updating Struct With Unspecified Fields Are Zeroed

_File location: `structs/02_updating_fields_of_struct/04_updating_struct_with_unspecified_fields_are_zeroed/01_updating_struct_with_unspecified_fields_are_zeroed.v`_

This example demonstrates the concepts of **updating struct with unspecified fields are zeroed**.

```v
module main

struct Note {
    id int
mut:
    message string
}

fn main() {
    // declare
    mut n := Note{}

    // populate
    n = Note{
        id:      1
        message: 'updating struct fields demo'
    }
    println(n)

    // unspecified fields zeroed by default
    // id being type of int, will become 0 here
    println('unspecified id zeroed during short struct type initialization')
    n = Note{
        message: 'updating struct fields demo 2'
    }
    println(n)
}

```

#### Updating Immutable Fields Throws Error

_File location: `structs/02_updating_fields_of_struct/03_updating_immutable_fields_throws_error/01_updating_immutable_fields_throws_error.v`_

This example demonstrates the concepts of **updating immutable fields throws error**.

```v
module main

struct Note {
    id int
mut:
    message string
}

fn main() {
    mut j := Note{1, 'a simple struct demo'}
    j.id = 2 // throws error
}

```

#### Updating Immutable Struct Variable Throws Error

_File location: `structs/02_updating_fields_of_struct/01_updating_immutable_struct_variable_throws_error/01_updating_immutable_struct_variable_throws_error.v`_

This example demonstrates the concepts of **updating immutable struct variable throws error**.

```v
module main

struct Note {
    id int
mut:
    message string
}

fn main() {
    n := Note{1, 'a simple struct demo'}
    println(n)

    n.message = 'a simple struct updated' // throws error
}

```

## Modules

### Accessing Constants Of Module

#### Modulebasics

_File location: `modules/09_accessing_constants_of_module/modulebasics/modulebasics.v`_

This example demonstrates the concepts of **modulebasics**.

```v
module main

import mod1

fn main() {
    println(mod1.greet_msg)
}

```

#### File1

_File location: `modules/09_accessing_constants_of_module/modulebasics/mod1/file1.v`_

This example demonstrates the concepts of **file1**.

```v
module mod1

pub const greet_msg = 'Greeting from mod1!'

```

### Accessing Members Of Module

#### Modulebasics

_File location: `modules/04_accessing_members_of_module/modulebasics/modulebasics.v`_

This example demonstrates the concepts of **modulebasics**.

```v
module main

import mod1

fn main() {
    mod1.hello()
    println('Hello World!')
}

```

#### File1

_File location: `modules/04_accessing_members_of_module/modulebasics/mod1/file1.v`_

This example demonstrates the concepts of **file1**.

```v
module mod1

pub fn hello() {
    println('Hello from mod1!')
}

```

### Accessing Structs And Embedded Structs Of Module

#### Modulebasics

_File location: `modules/10_accessing_structs_and_embedded_structs_of_module/modulebasics/modulebasics.v`_

This example demonstrates the concepts of **modulebasics**.

```v
module main

import mod1

fn main() {
    n := mod1.Note{
        id:      1
        message: 'Accessing structs of module demo'
    }
    println('Accessing struct field value Note id: ${n.id}')
    println('Accessing embedded struct field value NoteTimeInfo: ${n.NoteTimeInfo}')
}

```

#### File1

_File location: `modules/10_accessing_structs_and_embedded_structs_of_module/modulebasics/mod1/file1.v`_

This example demonstrates the concepts of **file1**.

```v
module mod1

import time

// NoteTimeInfo is a struct to store time info of Note
pub struct NoteTimeInfo {
pub:
    created time.Time = time.now()
pub mut:
    due time.Time = time.now().add_days(1)
}

// Note is a struct with embedding struct NoteTimeInfo along with other fields
pub struct Note {
    NoteTimeInfo // Embedded Struct
pub:
    id int
pub mut:
    message string @[required]
    status  bool
}

```

### Creating Modue

#### Modulebasics

_File location: `modules/02_creating_modue/modulebasics/modulebasics.v`_

This example demonstrates the concepts of **modulebasics**.

```v
module main

fn main() {
    println('Hello World!')
}

```

#### File1

_File location: `modules/02_creating_modue/modulebasics/mod1/file1.v`_

This example demonstrates the concepts of **file1**.

```v
module mod1

pub fn hello() {
    println('Hello from mod1!')
}

```

### Creating Simple V Project

#### Modulebasics

_File location: `modules/01_creating_simple_v_project/modulebasics/modulebasics.v`_

This example demonstrates the concepts of **modulebasics**.

```v
module main

fn main() {
    println('Hello World!')
}

```

### Cyclic Imports

#### Modulebasics

_File location: `modules/07_cyclic_imports/modulebasics/modulebasics.v`_

This example demonstrates the concepts of **modulebasics**.

```v
module main

import m1
import m2

fn main() {
    m1.hello()
    m2.hello()
}

```

#### File1

_File location: `modules/07_cyclic_imports/modulebasics/m1/file1.v`_

This example demonstrates the concepts of **file1**.

```v
module m1

import m2

pub const greet_from_m1 = 'Greetings from m1'

pub fn hello() {
    println(m2.greet_from_m2)
}

```

#### File1

_File location: `modules/07_cyclic_imports/modulebasics/m2/file1.v`_

This example demonstrates the concepts of **file1**.

```v
module m2

import m1

pub const greet_from_m2 = 'Greetings from m2'

pub fn hello() {
    println(m1.greet_from_m1)
}

```

### Importing Module

#### Modulebasics

_File location: `modules/03_importing_module/modulebasics/modulebasics.v`_

This example demonstrates the concepts of **modulebasics**.

```v
module main

import mod1

fn main() {
    println('Hello World!')
}

```

#### File1

_File location: `modules/03_importing_module/modulebasics/mod1/file1.v`_

This example demonstrates the concepts of **file1**.

```v
module mod1

pub fn hello() {
    println('Hello from mod1!')
}

```

### Init Function For Module

#### Modulebasics

_File location: `modules/08_init_function_for_module/modulebasics/modulebasics.v`_

This example demonstrates the concepts of **modulebasics**.

```v
module main

import mod1

fn main() {
    mod1.hello()
}

```

#### File1

_File location: `modules/08_init_function_for_module/modulebasics/mod1/file1.v`_

This example demonstrates the concepts of **file1**.

```v
module mod1

pub fn hello() {
    println('Hello from mod1!')
}

fn init() {
    println('Initializing mod1')
}

```

### Member Scope In Module

#### Modulebasics

_File location: `modules/06_member_scope_in_module/before/modulebasics/modulebasics.v`_

This example demonstrates the concepts of **modulebasics**.

```v
module main

import mod1

fn main() {
    mod1.hello()
    mod1.hello2()
}

```

#### File1

_File location: `modules/06_member_scope_in_module/before/modulebasics/mod1/file1.v`_

This example demonstrates the concepts of **file1**.

```v
module mod1

pub fn hello() {
    println('Hello from mod1!')
}

```

#### File2

_File location: `modules/06_member_scope_in_module/before/modulebasics/mod1/file2.v`_

This example demonstrates the concepts of **file2**.

```v
module mod1

fn hello2() {
    println('Hello 2 from mod1!')
}

```

#### Modulebasics

_File location: `modules/06_member_scope_in_module/after/modulebasics/modulebasics.v`_

This example demonstrates the concepts of **modulebasics**.

```v
module main

import mod1

fn main() {
    mod1.hello()
}

```

#### File1

_File location: `modules/06_member_scope_in_module/after/modulebasics/mod1/file1.v`_

This example demonstrates the concepts of **file1**.

```v
module mod1

pub fn hello() {
    println('Hello from mod1!')
    // hello2 is not a public but accessible within mod1
    hello2()
}

```

#### File2

_File location: `modules/06_member_scope_in_module/after/modulebasics/mod1/file2.v`_

This example demonstrates the concepts of **file2**.

```v
module mod1

fn hello2() {
    println('Hello 2 from mod1!')
}

```

### Working With Multiple Files In Module

#### Modulebasics

_File location: `modules/05_working_with_multiple_files_in_module/before/modulebasics/modulebasics.v`_

This example demonstrates the concepts of **modulebasics**.

```v
module main

import mod1

fn main() {
    mod1.hello()
    println('Hello World!')
}

```

#### File1

_File location: `modules/05_working_with_multiple_files_in_module/before/modulebasics/mod1/file1.v`_

This example demonstrates the concepts of **file1**.

```v
module mod1

pub fn hello() {
    println('Hello from mod1!')
}

```

#### File2

_File location: `modules/05_working_with_multiple_files_in_module/before/modulebasics/mod1/file2.v`_

This example demonstrates the concepts of **file2**.

```v
fn hello2() {
    println('Hello 2 from mod1!')
}

fn main() {
}

```

#### Modulebasics

_File location: `modules/05_working_with_multiple_files_in_module/after/modulebasics/modulebasics.v`_

This example demonstrates the concepts of **modulebasics**.

```v
module main

import mod1

fn main() {
    mod1.hello()
    println('Hello World!')
}

```

#### File1

_File location: `modules/05_working_with_multiple_files_in_module/after/modulebasics/mod1/file1.v`_

This example demonstrates the concepts of **file1**.

```v
module mod1

pub fn hello() {
    println('Hello from mod1!')
}

```

#### File2

_File location: `modules/05_working_with_multiple_files_in_module/after/modulebasics/mod1/file2.v`_

This example demonstrates the concepts of **file2**.

```v
module mod1

fn hello2() {
    println('Hello 2 from mod1!')
}
```

### Installing External Packages and Webview

#### Installing External Packages (`vpm`)

V features a built-in package manager called `vpm` (V Package Manager). You can install community-maintained external modules directly from the command line using:

```bash
v install ttytm.webview
```

V will download and place the package under the global V modules directory `~/.vmodules/` (e.g. `~/.vmodules/ttytm/webview`).

#### System Dependencies

Since `webview` binds to a native C++ webview library, you need the proper platform-specific C++ toolchains and WebKit libraries installed on your machine:
* **macOS**: Install Xcode Command Line Tools (`xcode-select --install`).
* **Linux (Debian/Ubuntu)**: Install GTK and WebKit2 development libraries:
  ```bash
  sudo apt install build-essential libgtk-3-dev libwebkit2gtk-4.0-dev
  ```
* **Windows**: Set up a GCC compiler environment (e.g., MinGW-w64 via MSYS2) and compile using `v -cc gcc run .`.

#### Compiling the C++ Webview Library (Workaround for macOS Bug)

After installing the V module, you normally run the build script `build.vsh` located in the module directory to compile the underlying C++ dependency (`webview.o`).

However, on macOS, running the script directly or compiling it via V might result in a bus error (**Signal 10**) due to thread/spinner channel operations.

To bypass this issue, you can compile the dependency manually:

```bash
# For macOS / Linux: Compile the C++ object file directly using clang++ or g++
clang++ -c ~/.vmodules/ttytm/webview/src/webview.cc -DWEBVIEW_STATIC -o ~/.vmodules/ttytm/webview/src/webview.o -std=c++11
```

Once `webview.o` is compiled in the `.vmodules/ttytm/webview/src` directory, you can build any V application importing `ttytm.webview` without errors.

#### Binding V Functions to Webview (Bidirectional Communication)

Exchanging data bidirectionally between V and Javascript inside the Webview is simple:
1. **Define the V Function**: Create a V function with a parameter of type `&webview.Event`.
2. **Access Arguments**: Retrieve inputs passed from the JavaScript call by calling `e.get_arg[T](index)`.
3. **Register the Binding**: Call `w.bind('js_func_name', v_func_name)` on your webview instance.
4. **Call from JS**: In your frontend JavaScript, call the function asynchronously via `await window.js_func_name(args...)`.

#### Webview Demo

_File location: `modules/11_install_external_packages_and_webview/webview_demo/webview_demo.v`_

This example demonstrates the concepts of **installing external packages and webview bindings**.

```v
module main

import ttytm.webview

const html = '
<!DOCTYPE html>
<html>
<head>
    <style>
        body {
            font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, sans-serif;
            background: linear-gradient(135deg, #1e1e2f 0%, #111119 100%);
            color: #f8f8f2;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            height: 100vh;
            margin: 0;
            user-select: none;
        }
        .container {
            text-align: center;
            background: rgba(255, 255, 255, 0.05);
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0 8px 32px 0 rgba(0, 0, 0, 0.3);
            backdrop-filter: blur(4px);
            border: 1px solid rgba(255, 255, 255, 0.1);
        }
        h1 {
            margin-bottom: 20px;
            font-size: 2.2rem;
            color: #50fa7b;
        }
        input {
            padding: 10px 15px;
            font-size: 1rem;
            border-radius: 6px;
            border: 1px solid #6272a4;
            background-color: #282a36;
            color: #f8f8f2;
            margin-right: 10px;
            outline: none;
        }
        button {
            padding: 10px 20px;
            font-size: 1rem;
            font-weight: bold;
            color: #282a36;
            background-color: #50fa7b;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            transition: all 0.2s ease;
        }
        button:hover {
            background-color: #8be9fd;
            transform: translateY(-1px);
        }
        #result {
            margin-top: 25px;
            font-size: 1.1rem;
            min-height: 25px;
            color: #f1fa8c;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>V + Webview Binding</h1>
        <input type="text" id="userInput" placeholder="Enter message for V..." value="Hello from JS!">
        <button onclick="sendToV()">Send to V</button>
        <div id="result">Waiting for action...</div>
    </div>

    <script>
        async function sendToV() {
            const input = document.getElementById("userInput").value;
            const resultDiv = document.getElementById("result");
            resultDiv.innerText = "Calling V function...";
            try {
                // Call the bound V function "greet_from_v" asynchronously
                const res = await window.greet_from_v(input);
                resultDiv.innerText = res;
            } catch (err) {
                resultDiv.innerText = "Error: " + err;
            }
        }
    </script>
</body>
</html>
'

// V binding function. Must take &webview.Event and can return a type (like string).
fn greet_from_v(e &webview.Event) string {
    // 1. Retrieve the argument passed from JavaScript (at index 0)
    msg := e.get_arg[string](0) or { 'No arguments passed' }
    println('V side: Received from JS: ${msg}')

    // 2. We can run custom JavaScript on the webview page from V
    e.eval('console.log("V successfully invoked eval in JS context!");')

    // 3. Return string back to the JS Promise resolver
    return 'V responds: "Message received: ${msg}"'
}

fn main() {
    // Initialize Webview
    mut w := webview.create(debug: true)
    w.set_title('V Webview Binding Demo')
    w.set_size(600, 450, .@none)

    // Bind V function "greet_from_v" to JS window.greet_from_v
    w.bind('greet_from_v', greet_from_v)

    // Load the HTML content
    w.set_html(html)

    // Run the main loop
    w.run()
}
```

#### Redis GUI Explorer Demo

_File location: `modules/11_install_external_packages_and_webview/redis_webview_demo/redis_webview_demo.v`_

This example demonstrates a complete desktop GUI application that combines the `ttytm.webview` bindings with the external `xiusin.vredis` client to construct a beautiful, dark-themed Redis GUI Dashboard.

It features:
*   Bidirectional communication between JavaScript (running inside the Webview) and the V backend.
*   Full CRUD operations: listing, filtering, viewing details, creating, modifying, and deleting keys of multiple types (Strings, Lists, Hashes, and Sets).
*   Live connection status tracking and DB stats displaying.
*   Resource embedding using `$embed_file` to keep the compiled executable entirely self-contained.

##### HTML, CSS, and JS Layout (`index.html`)

_File location: `modules/11_install_external_packages_and_webview/redis_webview_demo/index.html`_

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>V + Redis GUI Dashboard</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;500;600;700&family=JetBrains+Mono:wght@400;500&display=swap" rel="stylesheet">
    <style>
        :root {
            --bg-main: #0c0d14;
            --bg-card: #131520;
            --bg-sidebar: #10111a;
            --border-color: rgba(255, 255, 255, 0.08);
            
            --text-main: #f8f9fa;
            --text-muted: #8a8f9f;
            
            --color-primary: #8b5cf6;
            --color-primary-hover: #a78bfa;
            --color-success: #10b981;
            --color-danger: #ef4444;
            --color-warning: #f59e0b;
            --color-info: #3b82f6;
            
            --tag-string: #3b82f6;
            --tag-list: #10b981;
            --tag-hash: #8b5cf6;
            --tag-set: #f59e0b;
            
            --font-sans: 'Outfit', -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
            --font-mono: 'JetBrains Mono', monospace;
        }

        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
            user-select: none;
        }

        body {
            font-family: var(--font-sans);
            background-color: var(--bg-main);
            color: var(--text-main);
            height: 100vh;
            display: flex;
            overflow: hidden;
        }

        /* Sidebar Styling */
        .sidebar {
            width: 340px;
            background-color: var(--bg-sidebar);
            border-right: 1px solid var(--border-color);
            display: flex;
            flex-direction: column;
            height: 100%;
            flex-shrink: 0;
        }

        .sidebar-header {
            padding: 24px;
            border-bottom: 1px solid var(--border-color);
            display: flex;
            flex-direction: column;
            gap: 12px;
        }

        .brand-section {
            display: flex;
            align-items: center;
            justify-content: space-between;
        }

        .brand-title {
            font-size: 1.25rem;
            font-weight: 700;
            background: linear-gradient(135deg, #a78bfa 0%, #8b5cf6 100%);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .status-badge {
            display: flex;
            align-items: center;
            gap: 6px;
            font-size: 0.75rem;
            font-weight: 600;
            padding: 4px 10px;
            border-radius: 9999px;
            background: rgba(255, 255, 255, 0.04);
            border: 1px solid var(--border-color);
        }

        .status-dot {
            width: 8px;
            height: 8px;
            border-radius: 50%;
            background-color: var(--color-danger);
            box-shadow: 0 0 8px var(--color-danger);
        }

        .status-dot.connected {
            background-color: var(--color-success);
            box-shadow: 0 0 8px var(--color-success);
        }

        .server-meta {
            font-size: 0.8rem;
            color: var(--text-muted);
            display: flex;
            flex-direction: column;
            gap: 4px;
            background: rgba(255, 255, 255, 0.02);
            padding: 10px 12px;
            border-radius: 8px;
            border: 1px solid rgba(255, 255, 255, 0.03);
        }

        .server-meta-item {
            display: flex;
            justify-content: space-between;
        }

        .sidebar-actions {
            padding: 16px 24px;
            display: flex;
            gap: 8px;
            border-bottom: 1px solid var(--border-color);
        }

        .btn {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            gap: 6px;
            padding: 10px 16px;
            font-size: 0.875rem;
            font-weight: 600;
            border-radius: 8px;
            border: 1px solid transparent;
            cursor: pointer;
            transition: all 0.2s cubic-bezier(0.4, 0, 0.2, 1);
            color: var(--text-main);
            outline: none;
        }

        .btn-primary {
            background: linear-gradient(135deg, var(--color-primary) 0%, #7c3aed 100%);
            box-shadow: 0 4px 12px rgba(139, 92, 246, 0.2);
        }

        .btn-primary:hover {
            opacity: 0.9;
            transform: translateY(-1px);
        }

        .btn-secondary {
            background-color: rgba(255, 255, 255, 0.05);
            border-color: var(--border-color);
        }

        .btn-secondary:hover {
            background-color: rgba(255, 255, 255, 0.08);
            border-color: rgba(255, 255, 255, 0.15);
        }

        .btn-danger-outline {
            background-color: transparent;
            border-color: rgba(239, 68, 68, 0.3);
            color: var(--color-danger);
        }

        .btn-danger-outline:hover {
            background-color: rgba(239, 68, 68, 0.1);
            border-color: var(--color-danger);
        }

        .btn-icon {
            padding: 10px;
        }

        .search-container {
            padding: 16px 24px;
            border-bottom: 1px solid var(--border-color);
            position: relative;
        }

        .search-input {
            width: 100%;
            background-color: rgba(255, 255, 255, 0.03);
            border: 1px solid var(--border-color);
            border-radius: 8px;
            padding: 10px 12px 10px 36px;
            color: var(--text-main);
            font-family: var(--font-sans);
            font-size: 0.9rem;
            outline: none;
            transition: all 0.2s;
        }

        .search-input:focus {
            border-color: var(--color-primary);
            background-color: rgba(255, 255, 255, 0.05);
            box-shadow: 0 0 0 2px rgba(139, 92, 246, 0.25);
        }

        .search-icon {
            position: absolute;
            left: 36px;
            top: 50%;
            transform: translateY(-50%);
            color: var(--text-muted);
            pointer-events: none;
        }

        .keys-list {
            flex-grow: 1;
            overflow-y: auto;
            padding: 16px 24px;
            display: flex;
            flex-direction: column;
            gap: 8px;
        }

        /* Custom scrollbar */
        ::-webkit-scrollbar {
            width: 6px;
            height: 6px;
        }

        ::-webkit-scrollbar-track {
            background: transparent;
        }

        ::-webkit-scrollbar-thumb {
            background: rgba(255, 255, 255, 0.1);
            border-radius: 3px;
        }

        ::-webkit-scrollbar-thumb:hover {
            background: rgba(255, 255, 255, 0.2);
        }

        .key-item {
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 12px;
            border-radius: 8px;
            background-color: rgba(255, 255, 255, 0.02);
            border: 1px solid transparent;
            cursor: pointer;
            transition: all 0.2s;
        }

        .key-item:hover {
            background-color: rgba(255, 255, 255, 0.05);
            border-color: rgba(255, 255, 255, 0.05);
        }

        .key-item.active {
            background-color: rgba(139, 92, 246, 0.08);
            border-color: rgba(139, 92, 246, 0.3);
        }

        .key-info-left {
            display: flex;
            flex-direction: column;
            gap: 4px;
            min-width: 0;
            flex-grow: 1;
            margin-right: 8px;
        }

        .key-name {
            font-size: 0.9rem;
            font-weight: 500;
            color: var(--text-main);
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
            font-family: var(--font-mono);
        }

        .key-meta-row {
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .type-tag {
            font-size: 0.7rem;
            font-weight: 700;
            text-transform: uppercase;
            padding: 1px 6px;
            border-radius: 4px;
            color: #fff;
            letter-spacing: 0.02em;
        }

        .type-tag.string { background-color: var(--tag-string); }
        .type-tag.list { background-color: var(--tag-list); }
        .type-tag.hash { background-color: var(--tag-hash); }
        .type-tag.set { background-color: var(--tag-set); }

        .key-ttl {
            font-size: 0.75rem;
            color: var(--text-muted);
        }

        .key-ttl.expiring {
            color: var(--color-warning);
        }

        /* Main Workspace Styling */
        .workspace {
            flex-grow: 1;
            display: flex;
            flex-direction: column;
            height: 100%;
            background-color: var(--bg-main);
            position: relative;
        }

        .empty-state {
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            height: 100%;
            color: var(--text-muted);
            gap: 16px;
            animation: fadeIn 0.4s ease-out;
        }

        .empty-icon {
            font-size: 3rem;
            color: rgba(255, 255, 255, 0.05);
        }

        .empty-text {
            font-size: 1.1rem;
            font-weight: 400;
        }

        .detail-view {
            padding: 32px;
            display: flex;
            flex-direction: column;
            gap: 24px;
            height: 100%;
            overflow-y: auto;
            animation: slideIn 0.3s cubic-bezier(0.16, 1, 0.3, 1);
        }

        .detail-header {
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
            border-bottom: 1px solid var(--border-color);
            padding-bottom: 24px;
        }

        .detail-header-left {
            display: flex;
            flex-direction: column;
            gap: 8px;
        }

        .detail-title-row {
            display: flex;
            align-items: center;
            gap: 12px;
        }

        .detail-key-name {
            font-size: 1.5rem;
            font-weight: 700;
            font-family: var(--font-mono);
            word-break: break-all;
        }

        .detail-meta-row {
            display: flex;
            align-items: center;
            gap: 16px;
            font-size: 0.875rem;
            color: var(--text-muted);
        }

        .ttl-input-group {
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .input-text {
            background-color: rgba(255, 255, 255, 0.02);
            border: 1px solid var(--border-color);
            border-radius: 6px;
            padding: 8px 12px;
            color: var(--text-main);
            font-family: var(--font-sans);
            font-size: 0.9rem;
            outline: none;
            transition: all 0.2s;
        }

        .input-text:focus {
            border-color: var(--color-primary);
        }

        .input-mono {
            font-family: var(--font-mono);
        }

        .textarea-value {
            width: 100%;
            height: 200px;
            background-color: rgba(0, 0, 0, 0.2);
            border: 1px solid var(--border-color);
            border-radius: 8px;
            padding: 16px;
            color: var(--text-main);
            font-family: var(--font-mono);
            font-size: 0.9rem;
            outline: none;
            resize: vertical;
            transition: border-color 0.2s;
            user-select: text;
        }

        .textarea-value:focus {
            border-color: var(--color-primary);
        }

        /* List/Set Values Editor */
        .list-editor {
            display: flex;
            flex-direction: column;
            gap: 10px;
        }

        .list-row {
            display: flex;
            align-items: center;
            gap: 8px;
            animation: fadeIn 0.2s ease-out;
        }

        .list-index {
            width: 32px;
            font-family: var(--font-mono);
            font-size: 0.85rem;
            color: var(--text-muted);
            text-align: right;
        }

        .list-item-input {
            flex-grow: 1;
            user-select: text;
        }

        /* Hash Values Editor */
        .hash-editor {
            display: flex;
            flex-direction: column;
            gap: 10px;
        }

        .hash-row {
            display: flex;
            align-items: center;
            gap: 8px;
            animation: fadeIn 0.2s ease-out;
        }

        .hash-key-input {
            width: 30%;
            user-select: text;
        }

        .hash-val-input {
            flex-grow: 1;
            user-select: text;
        }

        /* Modals */
        .modal-overlay {
            position: fixed;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background-color: rgba(0, 0, 0, 0.7);
            backdrop-filter: blur(4px);
            display: flex;
            align-items: center;
            justify-content: center;
            z-index: 100;
            opacity: 0;
            pointer-events: none;
            transition: opacity 0.25s ease;
        }

        .modal-overlay.active {
            opacity: 1;
            pointer-events: auto;
        }

        .modal {
            background-color: var(--bg-card);
            border: 1px solid var(--border-color);
            border-radius: 16px;
            width: 500px;
            max-width: 90%;
            box-shadow: 0 20px 25px -5px rgba(0, 0, 0, 0.5), 0 10px 10px -5px rgba(0, 0, 0, 0.4);
            transform: scale(0.95);
            transition: transform 0.25s cubic-bezier(0.16, 1, 0.3, 1);
            display: flex;
            flex-direction: column;
        }

        .modal-overlay.active .modal {
            transform: scale(1);
        }

        .modal-header {
            padding: 20px 24px;
            border-bottom: 1px solid var(--border-color);
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .modal-title {
            font-size: 1.15rem;
            font-weight: 600;
        }

        .modal-close {
            background: none;
            border: none;
            color: var(--text-muted);
            cursor: pointer;
            font-size: 1.25rem;
        }

        .modal-body {
            padding: 24px;
            display: flex;
            flex-direction: column;
            gap: 16px;
            max-height: 400px;
            overflow-y: auto;
        }

        .form-group {
            display: flex;
            flex-direction: column;
            gap: 8px;
        }

        .form-label {
            font-size: 0.85rem;
            font-weight: 600;
            color: var(--text-muted);
        }

        .select-input {
            background-color: rgba(255, 255, 255, 0.02);
            border: 1px solid var(--border-color);
            border-radius: 6px;
            padding: 10px 12px;
            color: var(--text-main);
            font-family: var(--font-sans);
            outline: none;
            cursor: pointer;
        }

        .select-input option {
            background-color: var(--bg-card);
            color: var(--text-main);
        }

        .modal-footer {
            padding: 20px 24px;
            border-top: 1px solid var(--border-color);
            display: flex;
            justify-content: flex-end;
            gap: 8px;
        }

        /* Animations */
        @keyframes fadeIn {
            from { opacity: 0; }
            to { opacity: 1; }
        }

        @keyframes slideIn {
            from { opacity: 0; transform: translateY(10px); }
            to { opacity: 1; transform: translateY(0); }
        }

        /* Spinner */
        .spinner {
            border: 3px solid rgba(255, 255, 255, 0.1);
            width: 18px;
            height: 18px;
            border-radius: 50%;
            border-left-color: var(--color-primary);
            animation: spin 0.8s linear infinite;
            display: inline-block;
        }

        @keyframes spin {
            0% { transform: rotate(0deg); }
            100% { transform: rotate(360deg); }
        }

        .loader-overlay {
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background-color: rgba(12, 13, 20, 0.7);
            display: flex;
            align-items: center;
            justify-content: center;
            z-index: 10;
            opacity: 0;
            pointer-events: none;
            transition: opacity 0.2s;
        }

        .loader-overlay.active {
            opacity: 1;
            pointer-events: auto;
        }
    </style>
</head>
<body>
    <!-- Sidebar -->
    <div class="sidebar">
        <div class="sidebar-header">
            <div class="brand-section">
                <div class="brand-title">
                    <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><path d="M12 2L2 7l10 5 10-5-10-5zM2 17l10 5 10-5M2 12l10 5 10-5"/></svg>
                    Redis Explorer
                </div>
                <div class="status-badge">
                    <div class="status-dot" id="statusDot"></div>
                    <span id="statusText">Connecting</span>
                </div>
            </div>
            <div class="server-meta">
                <div class="server-meta-item">
                    <span>Host:</span>
                    <span id="metaHost" style="font-family: var(--font-mono);">127.0.0.1:6379</span>
                </div>
                <div class="server-meta-item">
                    <span>Version:</span>
                    <span id="metaVersion">-</span>
                </div>
                <div class="server-meta-item">
                    <span>Keys Total:</span>
                    <span id="metaKeys">-</span>
                </div>
            </div>
        </div>

        <div class="sidebar-actions">
            <button class="btn btn-secondary btn-icon" id="btnRefresh" title="Refresh Key List">
                <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M21.5 2v6h-6M21.34 15.57a10 10 0 1 1-.57-8.38l5.67-5.67"/></svg>
            </button>
            <button class="btn btn-primary" style="flex-grow: 1;" id="btnNewKey">
                <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><line x1="12" y1="5" x2="12" y2="19"></line><line x1="5" y1="12" x2="19" y2="12"></line></svg>
                New Key
            </button>
            <button class="btn btn-danger-outline btn-icon" id="btnFlush" title="Flush DB">
                <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><polyline points="3 6 5 6 21 6"></polyline><path d="M19 6v14a2 2 0 0 1-2 2H7a2 2 0 0 1-2-2V6m3 0V4a2 2 0 0 1 2-2h4a2 2 0 0 1 2 2v2"></path></svg>
            </button>
        </div>

        <div class="search-container">
            <svg class="search-icon" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg>
            <input type="text" class="search-input" id="searchKeys" placeholder="Filter keys...">
        </div>

        <div class="keys-list" id="keysList">
            <!-- Dynamic Keys go here -->
        </div>
    </div>

    <!-- Workspace -->
    <div class="workspace">
        <div class="loader-overlay" id="loader">
            <div class="spinner"></div>
        </div>

        <!-- Empty State -->
        <div class="empty-state" id="emptyState">
            <svg class="empty-icon" width="48" height="48" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"><rect x="2" y="2" width="20" height="8" rx="2" ry="2"></rect><rect x="2" y="14" width="20" height="8" rx="2" ry="2"></rect><line x1="6" y1="6" x2="6.01" y2="6"></line><line x1="6" y1="18" x2="6.01" y2="18"></line></svg>
            <div class="empty-text">Select a key to view details or create a new key</div>
        </div>

        <!-- Detail View -->
        <div class="detail-view" id="detailView" style="display: none;">
            <div class="detail-header">
                <div class="detail-header-left">
                    <div class="detail-title-row">
                        <span class="detail-key-name" id="detailKeyName">user:info</span>
                        <span class="type-tag string" id="detailKeyType">string</span>
                    </div>
                    <div class="detail-meta-row">
                        <div class="ttl-input-group">
                            <span>TTL (seconds):</span>
                            <input type="number" class="input-text" id="detailKeyTTL" style="width: 80px;" value="-1">
                            <span class="key-ttl" id="detailKeyTTLDisplay"></span>
                        </div>
                    </div>
                </div>
                <div class="detail-actions">
                    <button class="btn btn-secondary" id="btnSaveKey">
                        <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M19 21H5a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h11l5 5v11a2 2 0 0 1-2 2z"></path><polyline points="17 21 17 13 7 13 7 21"></polyline><polyline points="7 3 7 8 15 8"></polyline></svg>
                        Save
                    </button>
                    <button class="btn btn-danger-outline" id="btnDeleteKey">
                        <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><polyline points="3 6 5 6 21 6"></polyline><path d="M19 6v14a2 2 0 0 1-2 2H7a2 2 0 0 1-2-2V6m3 0V4a2 2 0 0 1 2-2h4a2 2 0 0 1 2 2v2"></path><line x1="10" y1="11" x2="10" y2="17"></line><line x1="14" y1="11" x2="14" y2="17"></line></svg>
                        Delete
                    </button>
                </div>
            </div>

            <!-- Value Editor Card -->
            <div class="card">
                <div class="card-title" id="valueEditorTitle">Value Editor</div>
                
                <!-- String Content -->
                <div id="editorString" style="display: none;">
                    <textarea class="textarea-value" id="stringValueInput" placeholder="String value..."></textarea>
                </div>

                <!-- List / Set Content -->
                <div id="editorList" style="display: none;">
                    <div class="list-editor" id="listEditorContainer">
                        <!-- Dynamic rows of list elements -->
                    </div>
                    <button class="btn btn-secondary" style="margin-top: 12px; width: fit-content;" id="btnAddListRow">
                        <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><line x1="12" y1="5" x2="12" y2="19"></line><line x1="5" y1="12" x2="19" y2="12"></line></svg>
                        Add Item
                    </button>
                </div>

                <!-- Hash Content -->
                <div id="editorHash" style="display: none;">
                    <div class="hash-editor" id="hashEditorContainer">
                        <!-- Dynamic rows of hash field:values -->
                    </div>
                    <button class="btn btn-secondary" style="margin-top: 12px; width: fit-content;" id="btnAddHashRow">
                        <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><line x1="12" y1="5" x2="12" y2="19"></line><line x1="5" y1="12" x2="19" y2="12"></line></svg>
                        Add Field
                    </button>
                </div>
            </div>
        </div>
    </div>

    <!-- New Key Modal -->
    <div class="modal-overlay" id="newKeyModal">
        <div class="modal">
            <div class="modal-header">
                <div class="modal-title">Create New Redis Key</div>
                <button class="modal-close" id="btnModalClose">&times;</button>
            </div>
            <div class="modal-body">
                <div class="form-group">
                    <label class="form-label" for="newKeyName">Key Name</label>
                    <input type="text" class="input-text input-mono" id="newKeyName" placeholder="e.g. user:session:1">
                </div>
                <div class="form-group">
                    <label class="form-label" for="newKeyType">Key Type</label>
                    <select class="select-input" id="newKeyType">
                        <option value="string">String</option>
                        <option value="list">List</option>
                        <option value="set">Set</option>
                        <option value="hash">Hash</option>
                    </select>
                </div>
                <div class="form-group">
                    <label class="form-label" for="newKeyTTL">TTL (seconds, -1 for persistent)</label>
                    <input type="number" class="input-text" id="newKeyTTL" value="-1">
                </div>
                <div class="form-group" id="newKeyInitialValueContainer">
                    <label class="form-label" for="newKeyInitialValue" id="newKeyValLabel">Initial Value</label>
                    
                    <!-- Dynamic inputs based on type selected -->
                    <div id="newValString">
                        <textarea class="textarea-value" id="newKeyInitialValue" style="height: 120px;" placeholder="Enter string value..."></textarea>
                    </div>
                    
                    <div id="newValList" style="display: none;">
                        <div class="list-editor" id="newValListContainer">
                            <div class="list-row">
                                <span class="list-index">0</span>
                                <input type="text" class="input-text list-item-input" value="">
                            </div>
                        </div>
                        <button class="btn btn-secondary" style="margin-top: 8px; font-size: 0.8rem; padding: 6px 12px;" id="btnModalAddListRow">Add Item</button>
                    </div>

                    <div id="newValHash" style="display: none;">
                        <div class="hash-editor" id="newValHashContainer">
                            <div class="hash-row">
                                <input type="text" class="input-text hash-key-input" placeholder="Field" value="">
                                <input type="text" class="input-text hash-val-input" placeholder="Value" value="">
                            </div>
                        </div>
                        <button class="btn btn-secondary" style="margin-top: 8px; font-size: 0.8rem; padding: 6px 12px;" id="btnModalAddHashRow">Add Field</button>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <button class="btn btn-secondary" id="btnModalCancel">Cancel</button>
                <button class="btn btn-primary" id="btnModalCreate">Create Key</button>
            </div>
        </div>
    </div>

    <!-- Confirm Dialog Modal -->
    <div class="modal-overlay" id="confirmModal">
        <div class="modal" style="width: 420px;">
            <div class="modal-header">
                <div class="modal-title" id="confirmTitle" style="color: var(--color-danger);">Confirm Action</div>
                <button class="modal-close" id="btnConfirmClose">&times;</button>
            </div>
            <div class="modal-body" id="confirmMessage" style="font-size: 0.95rem; line-height: 1.5; color: var(--text-main); user-select: text;">
                Are you sure you want to proceed?
            </div>
            <div class="modal-footer">
                <button class="btn btn-secondary" id="btnConfirmCancel">Cancel</button>
                <button class="btn btn-primary" id="btnConfirmOK" style="background: linear-gradient(135deg, var(--color-danger) 0%, #dc2626 100%); box-shadow: 0 4px 12px rgba(239, 68, 68, 0.2);">Confirm</button>
            </div>
        </div>
    </div>

    <!-- Alert Dialog Modal -->
    <div class="modal-overlay" id="alertModal">
        <div class="modal" style="width: 420px;">
            <div class="modal-header">
                <div class="modal-title" id="alertTitle" style="color: var(--color-primary);">Notice</div>
                <button class="modal-close" id="btnAlertClose">&times;</button>
            </div>
            <div class="modal-body" id="alertMessage" style="font-size: 0.95rem; line-height: 1.5; color: var(--text-main); user-select: text;">
                Message body.
            </div>
            <div class="modal-footer">
                <button class="btn btn-primary" id="btnAlertOK">OK</button>
            </div>
        </div>
    </div>

    <!-- Script logic -->
    <script>
        // Global error tracking for webview
        window.addEventListener('error', function(event) {
            if (typeof showAlert === 'function') {
                showAlert("JavaScript Error", event.message + " (" + event.filename + ":" + event.lineno + ")");
            } else {
                alert("JavaScript Error: " + event.message);
            }
        });
        window.addEventListener('unhandledrejection', function(event) {
            if (typeof showAlert === 'function') {
                showAlert("Unhandled Rejection", event.reason ? event.reason.toString() : "Unknown promise rejection");
            } else {
                alert("Unhandled Rejection: " + event.reason);
            }
        });

        let currentKeys = [];
        let selectedKey = null;
        let isConnected = false;

        // UI Elements
        const statusDot = document.getElementById("statusDot");
        const statusText = document.getElementById("statusText");
        const metaVersion = document.getElementById("metaVersion");
        const metaKeys = document.getElementById("metaKeys");
        const keysList = document.getElementById("keysList");
        const searchInput = document.getElementById("searchKeys");
        const emptyState = document.getElementById("emptyState");
        const detailView = document.getElementById("detailView");
        const loader = document.getElementById("loader");

        // Detail elements
        const detailKeyName = document.getElementById("detailKeyName");
        const detailKeyType = document.getElementById("detailKeyType");
        const detailKeyTTL = document.getElementById("detailKeyTTL");
        const detailKeyTTLDisplay = document.getElementById("detailKeyTTLDisplay");
        const valueEditorTitle = document.getElementById("valueEditorTitle");
        const btnSaveKey = document.getElementById("btnSaveKey");
        const btnDeleteKey = document.getElementById("btnDeleteKey");

        // Detail Editors
        const editorString = document.getElementById("editorString");
        const stringValueInput = document.getElementById("stringValueInput");
        
        const editorList = document.getElementById("editorList");
        const listEditorContainer = document.getElementById("listEditorContainer");
        const btnAddListRow = document.getElementById("btnAddListRow");

        const editorHash = document.getElementById("editorHash");
        const hashEditorContainer = document.getElementById("hashEditorContainer");
        const btnAddHashRow = document.getElementById("btnAddHashRow");

        // Modal Elements
        const newKeyModal = document.getElementById("newKeyModal");
        const btnNewKey = document.getElementById("btnNewKey");
        const btnModalClose = document.getElementById("btnModalClose");
        const btnModalCancel = document.getElementById("btnModalCancel");
        const btnModalCreate = document.getElementById("btnModalCreate");
        const selectNewKeyType = document.getElementById("newKeyType");
        
        const newValString = document.getElementById("newValString");
        const newValList = document.getElementById("newValList");
        const newValListContainer = document.getElementById("newValListContainer");
        const newValHash = document.getElementById("newValHash");
        const newValHashContainer = document.getElementById("newValHashContainer");

        // Set Loading State
        function setLoading(loading) {
            if (loading) {
                loader.classList.add("active");
            } else {
                loader.classList.remove("active");
            }
        }

        // Custom Alert Modal
        function showAlert(title, message) {
            document.getElementById("alertTitle").innerText = title;
            document.getElementById("alertMessage").innerText = message;
            document.getElementById("alertModal").classList.add("active");
        }

        function closeAlert() {
            document.getElementById("alertModal").classList.remove("active");
        }

        document.getElementById("btnAlertClose").onclick = closeAlert;
        document.getElementById("btnAlertOK").onclick = closeAlert;

        // Custom Confirm Modal
        let confirmCallback = null;

        function showConfirm(title, message, onConfirm) {
            document.getElementById("confirmTitle").innerText = title;
            document.getElementById("confirmMessage").innerText = message;
            confirmCallback = onConfirm;
            document.getElementById("confirmModal").classList.add("active");
        }

        function closeConfirm() {
            document.getElementById("confirmModal").classList.remove("active");
            confirmCallback = null;
        }

        document.getElementById("btnConfirmClose").onclick = closeConfirm;
        document.getElementById("btnConfirmCancel").onclick = closeConfirm;
        document.getElementById("btnConfirmOK").onclick = () => {
            if (confirmCallback) confirmCallback();
            closeConfirm();
        };

        // Initialize Status Connection
        async function checkStatus() {
            try {
                const infoStr = await window.redis_connect_status();
                const info = JSON.parse(infoStr);
                
                if (info.status === "connected") {
                    isConnected = true;
                    statusDot.className = "status-dot connected";
                    statusText.innerText = "Online";
                    metaVersion.innerText = info.version;
                    metaKeys.innerText = info.keys_count;
                } else {
                    isConnected = false;
                    statusDot.className = "status-dot";
                    statusText.innerText = "Offline";
                    metaVersion.innerText = "-";
                    metaKeys.innerText = "-";
                }
            } catch (err) {
                console.error("Failed to check status", err);
                statusDot.className = "status-dot";
                statusText.innerText = "Error";
            }
        }

        // Load keys and render list
        async function fetchAndRenderKeys() {
            setLoading(true);
            await checkStatus();
            if (!isConnected) {
                keysList.innerHTML = `<div style="text-align: center; color: var(--color-danger); padding: 20px 0; font-size: 0.9rem;">Redis server offline.<br>Ensure Redis is running on port 6379.</div>`;
                setLoading(false);
                return;
            }

            try {
                const keysStr = await window.redis_get_keys();
                currentKeys = JSON.parse(keysStr);
                renderKeys(currentKeys);
            } catch (err) {
                console.error("Failed to fetch keys", err);
                keysList.innerHTML = `<div style="color: var(--color-danger); padding: 10px;">Error fetching keys: ${err}</div>`;
            }
            setLoading(false);
        }

        function renderKeys(keys) {
            keysList.innerHTML = "";
            if (keys.length === 0) {
                keysList.innerHTML = `<div style="color: var(--text-muted); font-size: 0.85rem; text-align: center; padding: 20px 0;">No keys found</div>`;
                return;
            }

            keys.forEach(k => {
                const item = document.createElement("div");
                item.className = `key-item ${selectedKey && selectedKey.name === k.name ? "active" : ""}`;
                item.onclick = () => selectKey(k.name);

                const left = document.createElement("div");
                left.className = "key-info-left";

                const name = document.createElement("div");
                name.className = "key-name";
                name.innerText = k.name;

                const meta = document.createElement("div");
                meta.className = "key-meta-row";

                const type = document.createElement("span");
                type.className = `type-tag ${k.type}`;
                type.innerText = k.type;

                meta.appendChild(type);

                if (k.ttl > 0) {
                    const ttl = document.createElement("span");
                    ttl.className = "key-ttl" + (k.ttl < 30 ? " expiring" : "");
                    ttl.innerText = `TTL: ${k.ttl}s`;
                    meta.appendChild(ttl);
                }

                left.appendChild(name);
                left.appendChild(meta);

                const deleteBtn = document.createElement("div");
                deleteBtn.style.color = "var(--text-muted)";
                deleteBtn.style.cursor = "pointer";
                deleteBtn.innerHTML = `<svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><polyline points="3 6 5 6 21 6"></polyline><path d="M19 6v14a2 2 0 0 1-2 2H7a2 2 0 0 1-2-2V6m3 0V4a2 2 0 0 1 2-2h4a2 2 0 0 1 2 2v2"></path></svg>`;
                deleteBtn.onclick = (e) => {
                    e.stopPropagation();
                    deleteKeyConfirm(k.name);
                };

                item.appendChild(left);
                item.appendChild(deleteBtn);
                keysList.appendChild(item);
            });
        }

        // Search filter
        searchInput.oninput = () => {
            const query = searchInput.value.toLowerCase();
            const filtered = currentKeys.filter(k => k.name.toLowerCase().includes(query));
            renderKeys(filtered);
        };

        // Select and display key details
        async function selectKey(name) {
            setLoading(true);
            try {
                const detailStr = await window.redis_get_key_detail(name);
                selectedKey = JSON.parse(detailStr);
                
                // Show detail pane
                emptyState.style.display = "none";
                detailView.style.display = "flex";

                // Setup header
                detailKeyName.innerText = selectedKey.name;
                detailKeyType.className = `type-tag ${selectedKey.type}`;
                detailKeyType.innerText = selectedKey.type;
                detailKeyTTL.value = selectedKey.ttl;
                
                if (selectedKey.ttl === -1) {
                    detailKeyTTLDisplay.innerText = "(Persistent)";
                } else {
                    detailKeyTTLDisplay.innerText = "(" + selectedKey.ttl + "s remaining)";
                }

                // Hide all editors first
                editorString.style.display = "none";
                editorList.style.display = "none";
                editorHash.style.display = "none";

                // Setup active keys selection highlighting
                document.querySelectorAll(".key-item").forEach(item => {
                    if (item.querySelector(".key-name").innerText === name) {
                        item.classList.add("active");
                    } else {
                        item.classList.remove("active");
                    }
                });

                // Configure editor based on type
                if (selectedKey.type === "string") {
                    editorString.style.display = "block";
                    stringValueInput.value = selectedKey.value;
                    valueEditorTitle.innerText = "Edit String Value";
                } else if (selectedKey.type === "list" || selectedKey.type === "set") {
                    editorList.style.display = "block";
                    valueEditorTitle.innerText = `Edit ${selectedKey.type === 'list' ? 'List' : 'Set'} Elements`;
                    renderListEditor(selectedKey.list_val);
                } else if (selectedKey.type === "hash") {
                    editorHash.style.display = "block";
                    valueEditorTitle.innerText = "Edit Hash Fields";
                    renderHashEditor(selectedKey.hash_val);
                }

            } catch (err) {
                console.error("Failed to load key detail", err);
                showAlert("Error Loading Key", "Failed to load key detail: " + err);
            }
            setLoading(false);
        }

        // Render List Elements
        function renderListEditor(elements) {
            listEditorContainer.innerHTML = "";
            if (!elements || elements.length === 0) {
                addListRow("");
                return;
            }
            elements.forEach((val, idx) => {
                addListRow(val, idx);
            });
        }

        function addListRow(val = "", idx = null) {
            const rowIdx = idx !== null ? idx : listEditorContainer.children.length;
            const row = document.createElement("div");
            row.className = "list-row";
            
            // Build elements explicitly to avoid quotes and backtick issues
            const idxSpan = document.createElement("span");
            idxSpan.className = "list-index";
            idxSpan.innerText = rowIdx;
            
            const itemInput = document.createElement("input");
            itemInput.type = "text";
            itemInput.className = "input-text list-item-input";
            itemInput.value = val;
            
            const delBtn = document.createElement("button");
            delBtn.className = "btn btn-secondary btn-icon";
            delBtn.style.padding = "8px";
            delBtn.innerHTML = '<svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><line x1="18" y1="6" x2="6" y2="18"></line><line x1="6" y1="6" x2="18" y2="18"></line></svg>';
            delBtn.onclick = () => {
                row.remove();
                reindexListRows();
            };
            
            row.appendChild(idxSpan);
            row.appendChild(itemInput);
            row.appendChild(delBtn);
            
            listEditorContainer.appendChild(row);
        }

        function reindexListRows() {
            document.querySelectorAll("#listEditorContainer .list-row").forEach((row, i) => {
                row.querySelector(".list-index").innerText = i;
            });
        }

        btnAddListRow.onclick = () => addListRow("");

        // Render Hash Editor
        function renderHashEditor(hashData) {
            hashEditorContainer.innerHTML = "";
            const keys = Object.keys(hashData);
            if (keys.length === 0) {
                addHashRow("", "");
                return;
            }
            keys.forEach(k => {
                addHashRow(k, hashData[k]);
            });
        }

        function addHashRow(field = "", value = "") {
            const row = document.createElement("div");
            row.className = "hash-row";
            
            const fieldInput = document.createElement("input");
            fieldInput.type = "text";
            fieldInput.className = "input-text hash-key-input";
            fieldInput.placeholder = "Field";
            fieldInput.value = field;
            
            const valInput = document.createElement("input");
            valInput.type = "text";
            valInput.className = "input-text hash-val-input";
            valInput.placeholder = "Value";
            valInput.value = value;
            
            const delBtn = document.createElement("button");
            delBtn.className = "btn btn-secondary btn-icon";
            delBtn.style.padding = "8px";
            delBtn.innerHTML = '<svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><line x1="18" y1="6" x2="6" y2="18"></line><line x1="6" y1="6" x2="18" y2="18"></line></svg>';
            delBtn.onclick = () => {
                row.remove();
            };
            
            row.appendChild(fieldInput);
            row.appendChild(valInput);
            row.appendChild(delBtn);
            
            hashEditorContainer.appendChild(row);
        }

        btnAddHashRow.onclick = () => addHashRow("", "");

        // Save active key edits
        async function saveKey() {
            if (!selectedKey) return;
            setLoading(true);
            const name = selectedKey.name;
            const type = selectedKey.type;
            const ttl = parseInt(detailKeyTTL.value) || -1;

            try {
                if (type === "string") {
                    const val = stringValueInput.value;
                    await window.redis_set_string(name, val, ttl);
                } else if (type === "list") {
                    const vals = Array.from(document.querySelectorAll("#listEditorContainer .list-item-input")).map(i => i.value);
                    await window.redis_set_list(name, JSON.stringify(vals), ttl);
                } else if (type === "set") {
                    const vals = Array.from(document.querySelectorAll("#listEditorContainer .list-item-input")).map(i => i.value);
                    await window.redis_set_set(name, JSON.stringify(vals), ttl);
                } else if (type === "hash") {
                    const fvs = {};
                    document.querySelectorAll("#hashEditorContainer .hash-row").forEach(row => {
                        const f = row.querySelector(".hash-key-input").value.trim();
                        const v = row.querySelector(".hash-val-input").value;
                        if (f) {
                            fvs[f] = v;
                        }
                    });
                    await window.redis_set_hash(name, JSON.stringify(fvs), ttl);
                }

                // Reload and re-select
                await fetchAndRenderKeys();
                await selectKey(name);
            } catch (err) {
                console.error("Failed to save key", err);
                showAlert("Error Saving Key", "Failed to save key: " + err);
            }
            setLoading(false);
        }

        // Delete active key
        async function deleteKeyConfirm(name) {
            showConfirm("Delete Key", "Are you sure you want to delete key \"" + name + "\"?", async () => {
                setLoading(true);
                try {
                    await window.redis_del_key(name);
                    selectedKey = null;
                    detailView.style.display = "none";
                    emptyState.style.display = "flex";
                    await fetchAndRenderKeys();
                } catch (err) {
                    showAlert("Error Deleting Key", "Failed to delete key: " + err);
                }
                setLoading(false);
            });
        }

        btnDeleteKey.onclick = () => {
            if (selectedKey) deleteKeyConfirm(selectedKey.name);
        };
        btnSaveKey.onclick = saveKey;

        // Modal functionality
        btnNewKey.onclick = () => {
            // reset fields
            document.getElementById("newKeyName").value = "";
            document.getElementById("newKeyTTL").value = "-1";
            document.getElementById("newKeyInitialValue").value = "";
            newValListContainer.innerHTML = "";
            addModalListRow("");
            newValHashContainer.innerHTML = "";
            addModalHashRow("", "");
            
            newKeyModal.classList.add("active");
        };

        function closeModal() {
            newKeyModal.classList.remove("active");
        }

        btnModalClose.onclick = closeModal;
        btnModalCancel.onclick = closeModal;

        // Modal type change view switcher
        selectNewKeyType.onchange = () => {
            const type = selectNewKeyType.value;
            newValString.style.display = "none";
            newValList.style.display = "none";
            newValHash.style.display = "none";

            if (type === "string") {
                newValString.style.display = "block";
            } else if (type === "list" || type === "set") {
                newValList.style.display = "block";
            } else if (type === "hash") {
                newValHash.style.display = "block";
            }
        };

        // Modal dynamic list / hash rows adders
        function addModalListRow(val = "") {
            const idx = newValListContainer.children.length;
            const row = document.createElement("div");
            row.className = "list-row";
            
            const idxSpan = document.createElement("span");
            idxSpan.className = "list-index";
            idxSpan.innerText = idx;
            
            const itemInput = document.createElement("input");
            itemInput.type = "text";
            itemInput.className = "input-text list-item-input";
            itemInput.value = val;
            
            const delBtn = document.createElement("button");
            delBtn.className = "btn btn-secondary btn-icon";
            delBtn.style.padding = "6px";
            delBtn.innerHTML = '<svg width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><line x1="18" y1="6" x2="6" y2="18"></line><line x1="6" y1="6" x2="18" y2="18"></line></svg>';
            delBtn.onclick = () => {
                row.remove();
                reindexModalListRows();
            };
            
            row.appendChild(idxSpan);
            row.appendChild(itemInput);
            row.appendChild(delBtn);
            
            newValListContainer.appendChild(row);
        }

        function reindexModalListRows() {
            document.querySelectorAll("#newValListContainer .list-row").forEach((row, i) => {
                row.querySelector(".list-index").innerText = i;
            });
        }

        document.getElementById("btnModalAddListRow").onclick = () => addModalListRow("");

        function addModalHashRow(field = "", val = "") {
            const row = document.createElement("div");
            row.className = "hash-row";
            
            const fieldInput = document.createElement("input");
            fieldInput.type = "text";
            fieldInput.className = "input-text hash-key-input";
            fieldInput.placeholder = "Field";
            fieldInput.value = field;
            
            const valInput = document.createElement("input");
            valInput.type = "text";
            valInput.className = "input-text hash-val-input";
            valInput.placeholder = "Value";
            valInput.value = val;
            
            const delBtn = document.createElement("button");
            delBtn.className = "btn btn-secondary btn-icon";
            delBtn.style.padding = "6px";
            delBtn.innerHTML = '<svg width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><line x1="18" y1="6" x2="6" y2="18"></line><line x1="6" y1="6" x2="18" y2="18"></line></svg>';
            delBtn.onclick = () => {
                row.remove();
            };
            
            row.appendChild(fieldInput);
            row.appendChild(valInput);
            row.appendChild(delBtn);
            
            newValHashContainer.appendChild(row);
        }

        document.getElementById("btnModalAddHashRow").onclick = () => addModalHashRow("", "");

        btnModalCreate.onclick = async () => {
            const name = document.getElementById("newKeyName").value.trim();
            if (!name) {
                showAlert("Validation Error", "Key name is required!");
                return;
            }

            const type = selectNewKeyType.value;
            const ttl = parseInt(document.getElementById("newKeyTTL").value) || -1;
            setLoading(true);

            try {
                if (type === "string") {
                    const val = document.getElementById("newKeyInitialValue").value;
                    await window.redis_set_string(name, val, ttl);
                } else if (type === "list") {
                    const vals = Array.from(document.querySelectorAll("#newValListContainer .list-item-input")).map(i => i.value);
                    await window.redis_set_list(name, JSON.stringify(vals), ttl);
                } else if (type === "set") {
                    const vals = Array.from(document.querySelectorAll("#newValListContainer .list-item-input")).map(i => i.value);
                    await window.redis_set_set(name, JSON.stringify(vals), ttl);
                } else if (type === "hash") {
                    const fvs = {};
                    document.querySelectorAll("#newValHashContainer .hash-row").forEach(row => {
                        const f = row.querySelector(".hash-key-input").value.trim();
                        const v = row.querySelector(".hash-val-input").value;
                        if (f) fvs[f] = v;
                    });
                    await window.redis_set_hash(name, JSON.stringify(fvs), ttl);
                }

                closeModal();
                await fetchAndRenderKeys();
                await selectKey(name);
            } catch (err) {
                showAlert("Error Creating Key", "Failed to create key: " + err);
            }
            setLoading(false);
        };

        // Refresh Button
        document.getElementById("btnRefresh").onclick = fetchAndRenderKeys;

        // Flush Database
        document.getElementById("btnFlush").onclick = async () => {
            const warning = "WARNING: Are you absolutely sure you want to delete ALL keys in the current database?";
            showConfirm("Flush Database", warning, async () => {
                setLoading(true);
                try {
                    await window.redis_flush_db();
                    selectedKey = null;
                    detailView.style.display = "none";
                    emptyState.style.display = "flex";
                    await fetchAndRenderKeys();
                } catch (err) {
                    showAlert("Error Flushing DB", "Failed to flush DB: " + err);
                }
                setLoading(false);
            });
        };

        // Initial Load
        window.addEventListener("DOMContentLoaded", () => {
            setTimeout(fetchAndRenderKeys, 100);
        });
    </script>
</body>
</html>
```

##### V Entrypoint (`redis_webview_demo.v`)

_File location: `modules/11_install_external_packages_and_webview/redis_webview_demo/redis_webview_demo.v`_

```v
module main

import json
import ttytm.webview
import xiusin.vredis

struct KeyInfo {
	name  string
	@type string
	ttl   int
}

struct KeyDetail {
mut:
	name     string
	@type    string
	ttl      int
	value    string
	list_val []string
	hash_val map[string]string
}

struct ConnectStatus {
	status     string
	host       string
	port       int
	version    string
	keys_count int
}

// Embed the HTML, CSS, and JS file directly into the binary
const html_file = $embed_file('index.html')
const html = html_file.to_string()

fn connect_redis() !&vredis.Redis {
	return vredis.new_client(host: '127.0.0.1', port: 6379)
}

fn redis_connect_status(e &webview.Event) !string {
	mut client := connect_redis() or {
		status_info := ConnectStatus{
			status: 'disconnected'
			host: '127.0.0.1'
			port: 6379
			version: ''
			keys_count: 0
		}
		return json.encode(status_info)
	}
	defer {
		client.close() or {}
	}
	
	mut version := 'Unknown'
	info := client.send('INFO', 'server') or {
		count := client.dbsize() or { 0 }
		status_info := ConnectStatus{
			status: 'connected'
			host: '127.0.0.1'
			port: 6379
			version: 'Unknown'
			keys_count: count
		}
		return json.encode(status_info)
	}
	if info.bytestr().len > 0 {
		lines := info.bytestr().split('\n')
		for line in lines {
			if line.starts_with('redis_version:') {
				version = line.split(':')[1].trim_space()
				break
			}
		}
	}
	
	count := client.dbsize() or { 0 }
	
	status_info := ConnectStatus{
		status: 'connected'
		host: '127.0.0.1'
		port: 6379
		version: version
		keys_count: count
	}
	return json.encode(status_info)
}

fn redis_get_keys(e &webview.Event) !string {
	mut client := connect_redis()!
	defer {
		client.close() or {}
	}
	
	keys := client.keys('*') or { []string{} }
	mut items := []KeyInfo{}
	for key in keys {
		t := client.@type(key) or { 'unknown' }
		ttl := client.ttl(key) or { -1 }
		items << KeyInfo{
			name: key
			@type: t
			ttl: ttl
		}
	}
	return json.encode(items)
}

fn redis_get_key_detail(e &webview.Event) !string {
	mut client := connect_redis()!
	defer {
		client.close() or {}
	}
	
	key := e.get_arg[string](0)!
	t := client.@type(key)!
	ttl := client.ttl(key)!
	
	mut detail := KeyDetail{
		name: key
		@type: t
		ttl: ttl
		value: ''
		list_val: []string{}
		hash_val: map[string]string{}
	}
	
	match t {
		'string' {
			detail.value = client.get(key) or { '' }
		}
		'list' {
			detail.list_val = client.lrange(key, 0, -1) or { []string{} }
		}
		'set' {
			detail.list_val = client.smembers(key) or { []string{} }
		}
		'hash' {
			detail.hash_val = client.hgetall(key) or { map[string]string{} }
		}
		else {}
	}
	return json.encode(detail)
}

fn redis_set_string(e &webview.Event) !string {
	mut client := connect_redis()!
	defer {
		client.close() or {}
	}
	
	key := e.get_arg[string](0)!
	val := e.get_arg[string](1)!
	ttl := e.get_arg[int](2)!
	
	client.set(key, val)!
	if ttl > 0 {
		client.expire(key, ttl)!
	} else if ttl == -1 {
		client.persist(key) or {}
	}
	return 'ok'
}

fn redis_set_list(e &webview.Event) !string {
	mut client := connect_redis()!
	defer {
		client.close() or {}
	}
	
	key := e.get_arg[string](0)!
	vals_json := e.get_arg[string](1)!
	ttl := e.get_arg[int](2)!
	
	vals := json.decode([]string, vals_json)!
	client.del(key) or {}
	for val in vals {
		client.rpush(key, val)!
	}
	if ttl > 0 {
		client.expire(key, ttl)!
	} else if ttl == -1 {
		client.persist(key) or {}
	}
	return 'ok'
}

fn redis_set_hash(e &webview.Event) !string {
	mut client := connect_redis()!
	defer {
		client.close() or {}
	}
	
	key := e.get_arg[string](0)!
	hash_json := e.get_arg[string](1)!
	ttl := e.get_arg[int](2)!
	
	fvs := json.decode(map[string]string, hash_json)!
	client.del(key) or {}
	for field, val in fvs {
		client.hset(key, field, val)!
	}
	if ttl > 0 {
		client.expire(key, ttl)!
	} else if ttl == -1 {
		client.persist(key) or {}
	}
	return 'ok'
}

fn redis_set_set(e &webview.Event) !string {
	mut client := connect_redis()!
	defer {
		client.close() or {}
	}
	
	key := e.get_arg[string](0)!
	vals_json := e.get_arg[string](1)!
	ttl := e.get_arg[int](2)!
	
	vals := json.decode([]string, vals_json)!
	client.del(key) or {}
	for val in vals {
		client.sadd(key, val)!
	}
	if ttl > 0 {
		client.expire(key, ttl)!
	} else if ttl == -1 {
		client.persist(key) or {}
	}
	return 'ok'
}

fn redis_del_key(e &webview.Event) !string {
	mut client := connect_redis()!
	defer {
		client.close() or {}
	}
	
	key := e.get_arg[string](0)!
	client.del(key)!
	return 'ok'
}

fn redis_flush_db(e &webview.Event) !string {
	mut client := connect_redis()!
	defer {
		client.close() or {}
	}
	
	client.flushdb()!
	return 'ok'
}

fn main() {
	mut w := webview.create(debug: true)
	defer {
		w.destroy()
	}
	w.set_title('V + Redis GUI Dashboard')
	w.set_size(1080, 720, .@none)

	// Bindings
	w.bind_opt[string]('redis_connect_status', redis_connect_status)
	w.bind_opt[string]('redis_get_keys', redis_get_keys)
	w.bind_opt[string]('redis_get_key_detail', redis_get_key_detail)
	w.bind_opt[string]('redis_set_string', redis_set_string)
	w.bind_opt[string]('redis_set_list', redis_set_list)
	w.bind_opt[string]('redis_set_hash', redis_set_hash)
	w.bind_opt[string]('redis_set_set', redis_set_set)
	w.bind_opt[string]('redis_del_key', redis_del_key)
	w.bind_opt[string]('redis_flush_db', redis_flush_db)

	w.set_html(html)
	w.run()
}
```

##### Redis Helper Utility (`redis_helper.v`)

_File location: `modules/11_install_external_packages_and_webview/redis_console_demo/redis_helper.v`_

This helper provides a namespaced wrapper struct `NamespacedRedis` that automatically prefixes all Redis keys with a given namespace (e.g. `namespace:key`). This is a great pattern for keeping keys organized and avoiding collisions between multiple apps/environments.

```v
module main

import xiusin.vredis

// NamespacedRedis wraps a standard vredis.Redis client and prefixes all keys with a namespace.
struct NamespacedRedis {
mut:
	client &vredis.Redis
pub:
	namespace string
}

fn new_namespaced_redis(client &vredis.Redis, namespace string) NamespacedRedis {
	return NamespacedRedis{
		client: client
		namespace: namespace
	}
}

fn (nr NamespacedRedis) key(name string) string {
	if nr.namespace == '' {
		return name
	}
	return '${nr.namespace}:${name}'
}

fn (mut nr NamespacedRedis) close() ! {
	nr.client.close()!
}

fn (mut nr NamespacedRedis) set(key string, val string) ! {
	nr.client.set(nr.key(key), val)!
}

fn (mut nr NamespacedRedis) get(key string) !string {
	return nr.client.get(nr.key(key))!
}

fn (mut nr NamespacedRedis) incr(key string) ! {
	nr.client.incr(nr.key(key))!
}

fn (mut nr NamespacedRedis) expire(key string, seconds int) ! {
	nr.client.expire(nr.key(key), seconds)!
}

fn (mut nr NamespacedRedis) ttl(key string) !int {
	return nr.client.ttl(nr.key(key))!
}

fn (mut nr NamespacedRedis) del(key string) ! {
	nr.client.del(nr.key(key))!
}

fn (mut nr NamespacedRedis) rpush(key string, val string) ! {
	nr.client.rpush(nr.key(key), val)!
}

fn (mut nr NamespacedRedis) lrange(key string, start int, stop int) ![]string {
	return nr.client.lrange(nr.key(key), start, stop)!
}

fn (mut nr NamespacedRedis) lpop(key string) !string {
	return nr.client.lpop(nr.key(key))!
}

fn (mut nr NamespacedRedis) llen(key string) !int {
	return nr.client.llen(nr.key(key))!
}

fn (mut nr NamespacedRedis) hset(key string, field string, val string) ! {
	nr.client.hset(nr.key(key), field, val)!
}

fn (mut nr NamespacedRedis) hget(key string, field string) !string {
	return nr.client.hget(nr.key(key), field)!
}

fn (mut nr NamespacedRedis) hgetall(key string) !map[string]string {
	return nr.client.hgetall(nr.key(key))!
}

fn (mut nr NamespacedRedis) sadd(key string, member string) ! {
	nr.client.sadd(nr.key(key), member)!
}

fn (mut nr NamespacedRedis) sismember(key string, member string) !bool {
	return nr.client.sismember(nr.key(key), member)!
}

fn (mut nr NamespacedRedis) smembers(key string) ![]string {
	return nr.client.smembers(nr.key(key))!
}
```

##### Redis Console Demo (`redis_console_demo.v`)

_File location: `modules/11_install_external_packages_and_webview/redis_console_demo/redis_console_demo.v`_

This example demonstrates how to use the external `xiusin.vredis` client package in a console application and demonstrates key namespacing with the custom `NamespacedRedis` helper. It covers:
*   Establishing a connection and handling errors gracefully.
*   Basic String operations (`set`, `get`, `incr`, `expire`, `ttl`, `del`).
*   List operations (`rpush`, `llen`, `lrange`, `lpop`).
*   Hash operations (`hset`, `hget`, `hgetall`).
*   Set operations (`sadd`, `sismember`, `smembers`).
*   Namespaced Redis helper operations using `NamespacedRedis`.
*   Cleaning up created keys on application exit.

```v
module main

import xiusin.vredis

fn main() {
	println('==================================================')
	println('       V + Redis Console API Learning Demo        ')
	println('==================================================')

	println('Connecting to local Redis at 127.0.0.1:6379...')
	mut r := vredis.new_client(host: '127.0.0.1', port: 6379) or {
		eprintln('\n[ERROR] Failed to connect to Redis server: ${err}')
		eprintln('Please make sure Redis is running locally on port 6379.')
		return
	}
	defer {
		r.close() or {}
		println('\n==================================================')
		println('Demo completed. Redis connection closed.')
		println('==================================================')
	}

	println('Connected successfully!\n')

	// Clean up any old test keys first
	r.del('demo:string') or {}
	r.del('demo:counter') or {}
	r.del('demo:list') or {}
	r.del('demo:hash') or {}
	r.del('demo:set') or {}

	// --- 1. String Operations ---
	println('--- 1. String Operations ---')
	println('Setting "demo:string" to "Hello V + Redis!"...')
	r.set('demo:string', 'Hello V + Redis!') or { panic(err) }

	val := r.get('demo:string') or { panic(err) }
	println('GET "demo:string" -> "${val}"')

	// Increment demo
	r.incr('demo:counter') or { panic(err) }
	r.incr('demo:counter') or { panic(err) }
	counter_val := r.get('demo:counter') or { panic(err) }
	println('Counter INCR twice -> "${counter_val}"')

	// TTL Demo
	println('Setting expiry of 5 seconds on "demo:string"...')
	r.expire('demo:string', 5) or { panic(err) }
	ttl_val := r.ttl('demo:string') or { panic(err) }
	println('TTL remaining: ${ttl_val} seconds\n')

	// --- 2. List Operations ---
	println('--- 2. List Operations ---')
	println('Pushing items to "demo:list" (item_a, item_b, item_c)...')
	r.rpush('demo:list', 'item_a') or { panic(err) }
	r.rpush('demo:list', 'item_b') or { panic(err) }
	r.rpush('demo:list', 'item_c') or { panic(err) }

	list_len := r.llen('demo:list') or { panic(err) }
	println('List length: ${list_len}')

	list_items := r.lrange('demo:list', 0, -1) or { panic(err) }
	println('List elements: ${list_items}')

	popped := r.lpop('demo:list') or { panic(err) }
	println('Popped from left (LPOP): "${popped}"')

	list_items_after := r.lrange('demo:list', 0, -1) or { panic(err) }
	println('List elements after LPOP: ${list_items_after}\n')

	// --- 3. Hash Operations ---
	println('--- 3. Hash Operations ---')
	println('Setting fields in "demo:hash"...')
	r.hset('demo:hash', 'name', 'V Programming Language') or { panic(err) }
	r.hset('demo:hash', 'year', '2019') or { panic(err) }
	r.hset('demo:hash', 'creator', 'Alex Medvednikov') or { panic(err) }

	name_field := r.hget('demo:hash', 'name') or { panic(err) }
	println('HGET "demo:hash" "name" -> "${name_field}"')

	hash_all := r.hgetall('demo:hash') or { panic(err) }
	println('HGETALL "demo:hash" fields & values:')
	for k, v in hash_all {
		println('  - ${k}: ${v}')
	}
	println('')

	// --- 4. Set Operations ---
	println('--- 4. Set Operations ---')
	println('Adding members to "demo:set"...')
	r.sadd('demo:set', 'apple') or { panic(err) }
	r.sadd('demo:set', 'banana') or { panic(err) }
	r.sadd('demo:set', 'apple') or { panic(err) } // Duplicate (should be ignored)

	is_banana := r.sismember('demo:set', 'banana') or { panic(err) }
	is_cherry := r.sismember('demo:set', 'cherry') or { panic(err) }
	println('SISMEMBER "demo:set" "banana": ${is_banana}')
	println('SISMEMBER "demo:set" "cherry": ${is_cherry}')

	set_members := r.smembers('demo:set') or { panic(err) }
	println('SMEMBERS "demo:set": ${set_members}\n')

	// --- 5. Namespaced Helper Demo ---
	println('--- 5. Namespaced Helper Demo ---')
	println('Creating a namespaced helper with namespace "app_v1"...')
	mut nr := new_namespaced_redis(r, 'app_v1')

	println('Setting namespaced key "user_token" (resolved key will be "app_v1:user_token")...')
	nr.set('user_token', 'token_abc123') or { panic(err) }

	token := nr.get('user_token') or { panic(err) }
	println('GET "user_token" via helper -> "${token}"')

	// Verify the actual key in Redis (without namespace helper) has the prefix
	actual_key := 'app_v1:user_token'
	actual_val := r.get(actual_key) or { panic(err) }
	println('GET raw "${actual_key}" directly from client -> "${actual_val}"')

	// Cleanup namespaced keys
	println('Cleaning up namespaced keys...')
	nr.del('user_token') or {}

	// Clean up test keys
	println('\nCleaning up created keys...')
	r.del('demo:string') or {}
	r.del('demo:counter') or {}
	r.del('demo:list') or {}
	r.del('demo:hash') or {}
	r.del('demo:set') or {}
	println('Cleanup done.')
}
```

##### Redis Namespaced Demo (`redis_namespaced_demo.v`)

_File location: `modules/11_install_external_packages_and_webview/redis_namespaced_demo/redis_namespaced_demo.v`_

This example provides an easy, dedicated demo showing how to use the `NamespacedRedis` helper wrapper to manage multiple independent namespaces (like `cache` and `session`) over a single underlying Redis connection without key collisions.

```v
module main

import xiusin.vredis

fn main() {
	println('==================================================')
	println('     V + Redis Namespaced Helper Easy Demo        ')
	println('==================================================')

	println('Connecting to local Redis at 127.0.0.1:6379...')
	mut client := vredis.new_client(host: '127.0.0.1', port: 6379) or {
		eprintln('\n[ERROR] Failed to connect to Redis server: ${err}')
		eprintln('Please make sure Redis is running locally on port 6379.')
		return
	}
	defer {
		client.close() or {}
		println('\n==================================================')
		println('Demo completed. Redis connection closed.')
		println('==================================================')
	}

	println('Connected successfully!\n')

	// Create a namespaced client wrapper for "cache"
	println('Initializing "cache" namespace wrapper...')
	mut cache := new_namespaced_redis(client, 'cache')

	// Create another namespaced client wrapper for "session"
	println('Initializing "session" namespace wrapper...\n')
	mut session := new_namespaced_redis(client, 'session')

	// 1. Store value in cache namespace (key will be "cache:user_123")
	println('1. Storing data in "cache" namespace (key: "user_123")...')
	cache.set('user_123', '{"name": "Alice", "role": "Admin"}') or { panic(err) }

	// 2. Store value in session namespace (key will be "session:user_123")
	println('2. Storing data in "session" namespace (key: "user_123")...')
	session.set('user_123', 'active_session_token_xyz987') or { panic(err) }

	println('\n--- Retrieval ---')

	// 3. Retrieve values using the namespace helpers
	cache_val := cache.get('user_123') or { panic(err) }
	session_val := session.get('user_123') or { panic(err) }

	println('Retrieved from cache:   "${cache_val}"')
	println('Retrieved from session: "${session_val}"')

	println('\n--- Verification (Direct Raw Lookups) ---')

	// 4. Retrieve values using the raw client directly to show the actual keys stored
	raw_cache := client.get('cache:user_123') or { panic(err) }
	raw_session := client.get('session:user_123') or { panic(err) }
	println('Raw key "cache:user_123" directly:   "${raw_cache}"')
	println('Raw key "session:user_123" directly: "${raw_session}"')

	// Cleanup
	println('\nCleaning up keys...')
	cache.del('user_123') or {}
	session.del('user_123') or {}
	println('Cleanup done.')
}
```

## Concurrency

### Concurrency Real Life Scenario

#### Running Multiple Tasks In Sequence

_File location: `concurrency/03_concurrency_real_life_scenario/01_running_multiple_tasks_in_sequence/01_running_multiple_tasks_in_sequence.v`_

This example demonstrates the concepts of **running multiple tasks in sequence**.

```v
module main

import time

fn hot_water() {
    println('Started Switch on Water heater: $time.now().hhmmss()')
    time.sleep(5 * time.second)
    println('Water heater indicates hot water ready!: $time.now().hhmmss()')
}

fn brush_teeth() {
    println('Started brushing:  $time.now().hhmmss()')
    time.sleep(3 * time.second)
    println('End Brushing:  $time.now().hhmmss()')
}

fn select_clothes() {
    println('Started choosing pair of clothes :  $time.now().hhmmss()')
    time.sleep(3 * time.second)
    println('End choosing pair of clothes:  $time.now().hhmmss()')
}

fn main() {
    sw := time.new_stopwatch()
    hot_water()
    brush_teeth()
    select_clothes()
    println('Your pre bath morning chores took: $sw.elapsed().seconds() seconds')
}

```

#### Spawning Multiple Tasks Concurrently

_File location: `concurrency/03_concurrency_real_life_scenario/02_spawning_multiple_tasks_concurrently/01_spawning_multiple_tasks_concurrently.v`_

This example demonstrates the concepts of **spawning multiple tasks concurrently**.

```v
module main

import time

fn hot_water() {
    println('Started Switch on Water heater: $time.now().hhmmss()')
    time.sleep(5 * time.second)
    println('Water heater indicates hot water ready! : $time.now().hhmmss()')
}

fn brush_teeth() {
    println('Started brushing:  $time.now().hhmmss()')
    time.sleep(3 * time.second)
    println('End Brushing:  $time.now().hhmmss()')
}

fn select_clothes() {
    println('Started choosing pair of clothes:  $time.now().hhmmss()')
    time.sleep(3 * time.second)
    println('End choosing pair of clothes:  $time.now().hhmmss()')
}

fn main() {
    mut t := []thread{}
    sw := time.new_stopwatch()
    t << go hot_water()
    t << go brush_teeth()
    t << go select_clothes()
    t.wait()
    println('Your pre bath morning chores took: $sw.elapsed().seconds() seconds')
}

```

### Implement Concurrent Programs

#### Spawn Anonymous Funcs With Input Args

_File location: `concurrency/04_implement concurrent programs/02_anonymous_functions/02_spawn_anonymous_funcs_with_input_args/01_spawn_anonymous_funcs_with_input_args.v`_

This example demonstrates the concepts of **spawn anonymous funcs with input args**.

```v
module main

fn main() {
    mut t := []thread string{}
    for i in 1 .. 3 {
        t << go fn (i int, msg string) string {
            return 'iteration: $i, message: $msg'
        }(i, 'hello') // <- arguments must match list in the anonymous function definition
    }
    res := t.wait()
    println('Type of t: ${typeof(t).name}')
    println('Type of res: ${typeof(res).name}')
    println(res)
}

```

#### Spawn Anonymous Funcs Without Input Args

_File location: `concurrency/04_implement concurrent programs/02_anonymous_functions/01_spawn_anonymous_funcs_without_input_args/01_spawn_anonymous_funcs_without_input_args.v`_

This example demonstrates the concepts of **spawn anonymous funcs without input args**.

```v
module main

fn main() {
    t := go fn () string {
        return 'hi'
    }()
    x := t.wait()
    println(typeof(x).name) // string
    println(x) // hi
}

```

#### Functions With Return Values

_File location: `concurrency/04_implement concurrent programs/01_functions_with_return_values/01_functions_with_return_values.v`_

This example demonstrates the concepts of **functions with return values**.

```v
module main

import time

fn hot_water() string {
    println('Started Switch on Water heater: $time.now().hhmmss()')
    time.sleep(5 * time.second)
    println('Water heater indicates hot water ready! : $time.now().hhmmss()')
    return 'Hot water ready!'
}

fn brush_teeth() string {
    println('Started brushing:  $time.now().hhmmss()')
    time.sleep(3 * time.second)
    println('End Brushing:  $time.now().hhmmss()')
    return 'Sparkling Teeth ready!'
}

fn select_clothes() string {
    println('Started choosing pair of clothes:  $time.now().hhmmss()')
    time.sleep(3 * time.second)
    println('End choosing pair of clothes:  $time.now().hhmmss()')
    return 'Pair of clothes ready!'
}

fn main() {
    mut t := []thread string{}
    sw := time.new_stopwatch()
    t << go hot_water()
    t << go brush_teeth()
    t << go select_clothes()
    res := t.wait()
    println('Your pre bath morning chores took: $sw.elapsed().seconds() seconds')
    println('*** Type Check ***')
    println('Type of thread array of strings t: ${typeof(t).name}')
    println('Type of res: ${typeof(res).name}')
    println('*** Values returned by concurrently executed tasks ***')
    println(res)
}

```

### Sharing Data Main And Concurrent Tasks

#### Sharing Data Main And Concurrent Tasks

_File location: `concurrency/05_sharing_data_main_and_concurrent_tasks/01_sharing_data_main_and_concurrent_tasks.v`_

This example demonstrates the concepts of **sharing data main and concurrent tasks**.

```v
module main

import rand

struct Fund {
    name   string
    target f32
mut:
    total      f32
    num_donors int
}

fn (shared f Fund) collect(amt f32) {
    lock f { // read - write lock
        if f.total < f.target {
            f.num_donors += 1
            f.total += amt
            println('$f.num_donors \t before: ${f.total - amt} \t funds received: $amt \t total: $f.total')
        }
    }
}

fn donation() f32 {
    return rand.f32_in_range(100.00, 250.00)
}

fn main() {
    shared fund := Fund{
        name: 'A noble cause'
        target: 1000.00
    }

    for {
        rlock fund {
            if fund.total >= fund.target {
                break
            }
        }
        h := go donation()
        go fund.collect(h.wait())
    }

    rlock fund { // acquire read lock
        println('$fund.num_donors donors donated for $fund.name')
        println('$fund.name raised total fund amount: \$ $fund.total')
    }
}

```

### Spawn Void Function

#### Waiting On Concurrent Thread

_File location: `concurrency/02_spawn_void_function/02_waiting_on_concurrent_thread/waiting_on_concurrent_thread.v`_

This example demonstrates the concepts of **waiting on concurrent thread**.

```v
module main

fn greet() {
    println('Hello from other side!')
}

fn main() {
    h := go greet()
    println(typeof(h).name)
    h.wait()
}

```

#### Spawn Void Function

_File location: `concurrency/02_spawn_void_function/01_check_thread_type/spawn_void_function.v`_

This example demonstrates the concepts of **spawn void function**.

```v
module main

fn greet() {
    println('Hello from other side!')
}

fn main() {
    h := go greet()
    println(typeof(h).name) // thread
}

```

### Time Module Overview

#### Stopwatch Demo

_File location: `concurrency/01_time_module_overview/stopwatch_demo.v`_

This example demonstrates the concepts of **stopwatch demo**.

```v
module main

import time

fn main() {
    sw := time.new_stopwatch()

    for i in 1 .. 5 {
        println('$i')
    }
    println('Total time took to finish: $sw.elapsed().seconds() seconds')
}

```

## Channels

### Channel Methods

#### Close

_File location: `channels/04_channel_methods/03_close/01_close/01_close.v`_

This example demonstrates the concepts of **close**.

```v
module main

fn main() {
    ch := chan int{cap: 2}

    // push using arrow operator: <-
    ch <- 123 // Push 1st element into the channel
    ch <- 222 // Push 2nd element into the channel
    println(<-ch) // pop using: <- First in is the first to out. So prints 123
    ch.close() // Close channel

    // try_push will result .closed
    new_val := 999
    status := ch.try_push(new_val)
    println('try_push on a closed channel resulted in status: ${status}')

    // We still have one more element to pop
    println(<-ch) // 222
}

```

#### Defer Close

_File location: `channels/04_channel_methods/03_close/02_defer_close/01_defer_close.v`_

This example demonstrates the concepts of **defer close**.

```v
module main

fn main() {
    ch := chan int{cap: 2}
    defer {
        ch.close()
    } // Deferred execution to Close channel

    // push using arrow operator: <-
    ch <- 123 // Push 1st element into the channel
    ch <- 222 // Push 2nd element into the channel
    println(<-ch) // pop using: <- First in is the first to out. So prints 123

    // try_push will result .closed
    new_val := 999
    status := ch.try_push(new_val)
    println('try_push on a closed channel resulted in status: ${status}')

    // We still have one more element to pop
    println(<-ch) // 222
}

```

#### Try Pop

_File location: `channels/04_channel_methods/02_try_pop/01_try_pop.v`_

This example demonstrates the concepts of **try pop**.

```v
fn main() {
    ch := chan int{cap: 1}
    mut x, mut y := 0, 0
    ch <- 101
    mut status := ch.try_pop(mut x)
    println('try pop resulted in status: ${status}, Value of x: ${x}')
    status = ch.try_pop(mut y)
    println('try pop resulted in status: ${status}, Value of y: ${y}')
}

```

#### Try Push Unbuffered

_File location: `channels/04_channel_methods/01_try_push/01_try_push_unbuffered.v`_

This example demonstrates the concepts of **try push unbuffered**.

```v
fn main() {
    v := 'hi'
    ch := chan string{} // unbuffered channel
    res := ch.try_push(v)
    println(res) // not_ready
}

```

#### Try Push Buffered

_File location: `channels/04_channel_methods/01_try_push/02_try_push_buffered.v`_

This example demonstrates the concepts of **try push buffered**.

```v
fn main() {
    x := 'hello'
    ch := chan string{cap: 2}
    for {
        status := ch.try_push(x)
        if status == .success {
            println('Channel length: ${ch.len}')
        } else {
            println('channel status: ${status}')
            break
        }
    }
}

```

### Channel Operations

#### Push Buffered

_File location: `channels/02_channel_operations/01_push_buffered.v`_

This example demonstrates the concepts of **push buffered**.

```v
fn main() {
    ch := chan int{cap: 1}
    ch <- 51
    println(ch)
}

```

#### Push Unbuffered

_File location: `channels/02_channel_operations/02_push_unbuffered.v`_

This example demonstrates the concepts of **push unbuffered**.

```v
fn main() {
    ch := chan int{}
    ch <- 51
    println(ch) // doesn't prints, due to blocking behavior of unbuffered channels
}

```

#### Pop

_File location: `channels/02_channel_operations/03_pop.v`_

This example demonstrates the concepts of **pop**.

```v
fn main() {
    ch := chan int{cap: 1}
    ch <- 51
    println('channel after push: ${ch.str()}')

    println('popping value out of the channel and storing it in immutable variable x')
    x := <-ch
    println('value of x: ${x}')
    println('channel after pop: ${ch.str()}')
}

```

### Channel Properties

#### Channel Properties

_File location: `channels/03_channel_properties/01_channel_properties.v`_

This example demonstrates the concepts of **channel properties**.

```v
fn main() {
    b := chan string{cap: 2}
    b <- 'hello'
    println('capacity: ${b.cap}')
    println('length: ${b.len}')
    println('closed: ${b.closed}')
}

```

### Channel Select

#### Channel Select Before

_File location: `channels/07_channel_select/01_before/01_channel_select_before.v`_

This example demonstrates the concepts of **channel select before**.

```v
module main

fn process1(ch chan int) {
    for i in 1 .. 6 {
        sq := i * i
        println('process1: value being pushed on ch1: ${sq}')
        ch <- sq
    }
}

fn process2(ch chan string) {
    msg := 'hello from process 2'
    println('process2: value being pushed on ch2: ${msg}')
    ch <- msg
}

fn main() {
    ch1 := chan int{cap: 5} // buffered channel
    ch2 := chan string{} // unbuffered channel
    defer {
        ch1.close()
        ch2.close()
    }
    go process1(ch1)
    go process2(ch2)
    select {
        a := <-ch1 {
            println('main: value popped from ch1: ${a}')
        }
        b := <-ch2 {
            println('main: value popped from ch2: ${b}')
        }
    }
}

```

#### Channel Select

_File location: `channels/07_channel_select/02_after/01_channel_select.v`_

This example demonstrates the concepts of **channel select**.

```v
module main

import time

fn process1(ch chan int) {
    for i in 1 .. 6 {
        sq := i * i
        time.sleep(3 * time.second)
        println('process1: value being pushed on ch1: ${sq}')
        ch <- sq
    }
}

fn process2(ch chan string) {
    msg := 'hello from process 2'
    println('process2: value being pushed on ch2: ${msg}')
    ch <- msg
}

fn main() {
    ch1 := chan int{cap: 5} // buffered channel
    ch2 := chan string{} // unbuffered channel
    defer {
        ch1.close()
        ch2.close()
    }
    go process1(ch1)
    go process2(ch2)
    mut sec := 0
    for {
        select {
            a := <-ch1 {
                sec = 0
                println('main: value popped from ch1: ${a}')
            }
            b := <-ch2 {
                sec = 0
                println('main: value popped from ch2: ${b}')
            }
            2 * time.second {
                // this case executes for every 2 seconds of inactivity by any other channels in this select statement
                sec = sec + 2
                println('main: more than ${sec}s passed without a channel being ready')
                if sec >= 6 {
                    println('exiting out of select after ${sec} seconds of inactivity amongst channels')
                    break
                }
            }
        }
    }
    println('done')
}

```

### Define Channels

#### Unbuffered Channel

_File location: `channels/01_define_channels/01_unbuffered_channel.v`_

This example demonstrates the concepts of **unbuffered channel**.

```v
fn main() {
    uc := chan int{}
    println(uc.cap) // 0
    println(typeof(uc).name) // chan int
}

```

#### Buffered Channel

_File location: `channels/01_define_channels/02_buffered_channel.v`_

This example demonstrates the concepts of **buffered channel**.

```v
fn main() {
    bc := chan string{cap: 2}
    println(bc.cap)
    println(typeof(bc).name)
}

```

### Working With Buffered Channels

#### Sync Before

_File location: `channels/06_working_with_buffered_channels/03_synchronizing_data/01_before/01_sync_before.v`_

This example demonstrates the concepts of **sync before**.

```v
module main

const count = 4

fn sender(ch chan int) {
    for i in 0 .. count {
        ch <- i
        println('sent value: ${i} in the channel')
    }
}

fn receiver(ch chan int) {
    println('Received value from the channel ${<-ch}')
}

fn main() {
    ch := chan int{cap: 2}
    defer {
        ch.close()
    }
    t := go receiver(ch)
    go sender(ch)

    t.wait()
    println('End main')
}

```

#### Sync After

_File location: `channels/06_working_with_buffered_channels/03_synchronizing_data/02_after/01_sync_after.v`_

This example demonstrates the concepts of **sync after**.

```v
module main

const count = 4

fn sender(ch chan int) {
    for i in 0 .. count {
        ch <- i
        println('sent value: ${i} in the channel')
    }
}

fn receiver(ch chan int) {
    for _ in 0 .. count {
        println('Received value from the channel ${<-ch}')
    }
}

fn main() {
    ch := chan int{cap: 2}
    defer {
        ch.close()
    }
    t := go receiver(ch)
    go sender(ch)

    t.wait()
    println('End main')
}

```

#### Coroutines Communication

_File location: `channels/06_working_with_buffered_channels/02_establish_communication_between_coroutines/01_coroutines_communication.v`_

This example demonstrates the concepts of **coroutines communication**.

```v
module main

fn sender(ch chan int) {
    val := 3
    println('Sending value: ${val} in the channel')
    ch <- val
    println('sent value: ${val} in the channel')
}

fn receiver(ch chan int) {
    println('Received value from the channel ${<-ch}')
}

fn main() {
    ch := chan int{cap: 1}
    defer {
        ch.close()
    }
    t := go receiver(ch)
    go sender(ch)

    t.wait()
    println('End main')
}

```

#### Buffered Channel

_File location: `channels/06_working_with_buffered_channels/01_understanding_buffered_channel/01_buffered_channel.v`_

This example demonstrates the concepts of **buffered channel**.

```v
module main

fn main() {
    ch := chan int{cap: 1}
    defer {
        ch.close()
    }
    ch <- 3
    x := <-ch
    println(x)
    println('End main')
}

```

### Working With Unbuffered Channels

#### Blocking Channels

_File location: `channels/05_working_with_unbuffered_channels/01_understanding_blocking_nature/01_blocking_channels.v`_

This example demonstrates the concepts of **blocking channels**.

```v
module main

fn main() {
    ch := chan int{}
    defer {
        ch.close()
    }
    ch <- 3
    x := <-ch
    println(x)
    println('End main')
}

```

#### Dealing Before

_File location: `channels/05_working_with_unbuffered_channels/02_dealing_with_blocking_channels/01_before/01_dealing_before.v`_

This example demonstrates the concepts of **dealing before**.

```v
module main

fn receiver(ch chan int) {
    println('Received value from the channel ${<-ch}')
}

fn main() {
    ch := chan int{}
    defer {
        ch.close()
    }
    go receiver(ch)
    ch <- 3
    println('End main')
}

```

#### Dealing After

_File location: `channels/05_working_with_unbuffered_channels/02_dealing_with_blocking_channels/02_after/01_dealing_after.v`_

This example demonstrates the concepts of **dealing after**.

```v
module main

fn receiver(ch chan int) {
    println('Received value from the channel ${<-ch}')
}

fn main() {
    ch := chan int{}
    defer {
        ch.close()
    }
    t := go receiver(ch)
    ch <- 3
    t.wait()
    println('End main')
}

```

#### Sync Before

_File location: `channels/05_working_with_unbuffered_channels/03_synchronizing_data/01_before/01_sync_before.v`_

This example demonstrates the concepts of **sync before**.

```v
module main

const count = 4

fn sender(ch chan int) {
    for i in 0 .. count {
        ch <- i // since the push operation is a void expression, this cannot be placed in a println
        println('Sent ${i} into the channel')
    }
}

fn receiver(ch chan int) {
    println('Received value from the channel ${<-ch}')
}

fn main() {
    ch := chan int{}
    defer {
        ch.close()
    }
    t := go receiver(ch)
    go sender(ch)
    t.wait()
    println('End main')
}

```

#### Sync After

_File location: `channels/05_working_with_unbuffered_channels/03_synchronizing_data/02_after/01_sync_after.v`_

This example demonstrates the concepts of **sync after**.

```v
module main

const count = 4

fn sender(ch chan int) {
    for i in 0 .. count {
        ch <- i // since the push operation is a void expression, this cannot be placed in a println
        println('Sent ${i} into the channel')
    }
}

fn receiver(ch chan int) {
    for _ in 0 .. count {
        println('Received value from the channel ${<-ch}')
    }
}

fn main() {
    ch := chan int{}
    defer {
        ch.close()
    }
    t := go receiver(ch)
    go sender(ch)
    t.wait()
    println('End main')
}

```

## Testing

### Assert

#### Assert Demo

_File location: `testing/01_assert/assert_demo.v`_

This example demonstrates the concepts of **assert demo**.

```v
module main

fn main() {
    println('1st assert')
    msg := 'hello there!'
    assert msg.contains('hello') // true
    println('2nd assert')
    assert 'apple' == 'orange' // stops execution
    println('done')
}

```

### Simple Test

#### Demo Test

_File location: `testing/02_simple_test/01_before/demo_test.v`_

This example demonstrates the concepts of **demo test**.

```v
fn test_first() {
    assert 2 != 2
}

```

#### Demo Test

_File location: `testing/02_simple_test/02_after/demo_test.v`_

This example demonstrates the concepts of **demo test**.

```v
fn test_first() {
    assert 2 == 2
}

```

### Test Optional Return Functions

#### Demo Test

_File location: `testing/05_test_optional_return_functions/demo_test.v`_

This example demonstrates the concepts of **demo test**.

```v
fn greet(name string) !string {
    if name != '' {
        return 'Hello $name!'
    }
    return error('name not provided')
}

fn test_greet_given_a_name() {
    exp := 'Hello Pavan!'
    assert (greet('Pavan') or { err.msg() }) == exp
}

fn test_greet_propagates_error() ! {
    greet('')!
}

fn test_greet_when_empty() {
    exp := 'name not provided'
    assert (greet('') or { err.msg() }) == exp
}

```

### Testing Program File

#### Greet

_File location: `testing/06_testing_program_file/greet.v`_

This example demonstrates the concepts of **greet**.

```v
module main

fn greet(name string) string {
    return 'Hello $name!'
}

fn main() {
    msg := greet('Bob')
    println(msg)
}

```

#### Greet Test

_File location: `testing/06_testing_program_file/greet_test.v`_

This example demonstrates the concepts of **greet test**.

```v
module main

fn test_greet() {
    // Arrange
    name := 'Bob'
    exp_msg := 'Hello Bob!'

    // Act
    act_msg := greet(name)

    // Assert
    assert act_msg == exp_msg
    assert act_msg.contains(name)
}

```

### Testing Program With Modules

#### Main Test

_File location: `testing/07_testing_program_with_modules/modulebasics/main_test.v`_

This example demonstrates the concepts of **main test**.

```v
module main

import mod1

fn test_hello() {
    // arrange
    exp := 'Hello from mod1!'

    // act
    act := mod1.hello()

    // assert
    assert act == exp
    assert mod1.hello().contains('Hello')
}

```

#### Modulebasics

_File location: `testing/07_testing_program_with_modules/modulebasics/modulebasics.v`_

This example demonstrates the concepts of **modulebasics**.

```v
module main

import mod1

fn main() {
    res := mod1.hello()
    println(res)
}

```

#### File1

_File location: `testing/07_testing_program_with_modules/modulebasics/mod1/file1.v`_

This example demonstrates the concepts of **file1**.

```v
module mod1

pub fn hello() string {
    return 'Hello from mod1!'
}

```

#### Mod1 Test

_File location: `testing/07_testing_program_with_modules/modulebasics/mod1/mod1_test.v`_

This example demonstrates the concepts of **mod1 test**.

```v
module mod1

fn test_hello() {
    // arrange
    exp := 'Hello from mod1!'

    // act
    act := hello()

    // assert
    assert act == exp
}

```

### Testsuite

#### Testsuite Demo Test

_File location: `testing/04_testsuite/testsuite_demo_test.v`_

This example demonstrates the concepts of **testsuite demo test**.

```v
import os

fn testsuite_begin() {
    os.setenv('foo', 'bar', true)
    println('About to start executing all tests')
}

fn test_env_foo_has_value_bar() {
    println('Executing test')

    // arrange
    inp := 'foo'
    expected := 'bar'

    // act
    actual := os.getenv(inp)

    // assert
    assert actual == expected
}

fn testsuite_end() {
    os.unsetenv('foo')
    println('Finished executing all tests')
}

```

## Json And Orm

### Json

#### Encode

_File location: `json_and_orm/01_json/02_encode/encode.v`_

This example demonstrates the concepts of **encode**.

```v
import json

struct Note {
    id      int
    message string
    status  bool
}

fn main() {
    m := Note{
        id: 2
        message: 'Get groceries'
        status: false
    }

    j := json.encode(m)
    println(j)
}

```

#### Decode

_File location: `json_and_orm/01_json/01_decode/decode.v`_

This example demonstrates the concepts of **decode**.

```v
import json

struct Note {
    id      int
    message string
    status  bool
}

fn main() {
    n := json.decode(Note, '{"id":1,"message":"Plan a holiday","status":false}') or {
        panic('invalid json data')
    }
    println(typeof(n).name) // Note
    println(n)
}

```

#### JSON To/From File

_File location: `json_and_orm/01_json/03_json_to_from_file/json_to_from_file.v`_

This example demonstrates how to encode an object to JSON, write it to a file, read it back, and decode it into a V struct.

```v
module main

import json
import os

struct Book {
	title  string
	author string
	year   int
}

fn main() {
	file_path := 'book.json'

	// Create an object instance
	book := Book{
		title: 'The V Programming Language'
		author: 'Alex Medvednikov'
		year: 2019
	}

	// 1. Encode object to JSON string
	println('Encoding object to JSON...')
	json_str := json.encode(book)
	println('JSON string: ${json_str}')

	// 2. Write JSON string to file
	println('Writing JSON to file "${file_path}"...')
	os.write_file(file_path, json_str) or {
		eprintln('Failed to write file: ${err}')
		return
	}

	// 3. Read JSON string from file
	println('Reading JSON from file "${file_path}"...')
	content := os.read_file(file_path) or {
		eprintln('Failed to read file: ${err}')
		return
	}

	// 4. Decode JSON string back to Book object
	println('Decoding JSON back to object...')
	decoded_book := json.decode(Book, content) or {
		eprintln('Failed to decode JSON: ${err}')
		return
	}

	println('Decoded book: Title: "${decoded_book.title}", Author: "${decoded_book.author}", Year: ${decoded_book.year}')

	// Clean up created file
	os.rm(file_path) or {}
}
```

#### JSON Array of Objects

_File location: `json_and_orm/01_json/04_json_array_of_objects/json_array_of_objects.v`_

This example demonstrates how to serialize and deserialize an array of objects (structs) to and from JSON, and how to write/read them using the filesystem.

```v
module main

import json
import os

struct Task {
	id    int
	title string
	done  bool
}

fn main() {
	file_path := 'tasks.json'

	// Create an array of objects
	tasks := [
		Task{
			id: 1
			title: 'Read V Guide'
			done: false
		},
		Task{
			id: 2
			title: 'Write JSON helper examples'
			done: true
		},
	]

	// 1. Encode array of objects to JSON string
	println('Encoding array of objects to JSON...')
	json_str := json.encode(tasks)
	println('JSON string:\n${json_str}')

	// 2. Write JSON string to file
	println('\nWriting JSON array to file "${file_path}"...')
	os.write_file(file_path, json_str) or {
		eprintln('Failed to write file: ${err}')
		return
	}

	// 3. Read JSON string from file
	println('Reading JSON from file "${file_path}"...')
	content := os.read_file(file_path) or {
		eprintln('Failed to read file: ${err}')
		return
	}

	// 4. Decode JSON string back to an array of Task objects
	println('Decoding JSON back to array of objects...')
	decoded_tasks := json.decode([]Task, content) or {
		eprintln('Failed to decode JSON: ${err}')
		return
	}

	println('Decoded array of tasks successfully!')
	for task in decoded_tasks {
		println('  - Task #${task.id}: "${task.title}" [Done: ${task.done}]')
	}

	// Clean up created file
	os.rm(file_path) or {}
}
```

#### JSON Map To/From File

_File location: `json_and_orm/01_json/05_json_map_to_from_file/json_map_to_from_file.v`_

This example demonstrates how to serialize a map structure (`map[string]int`) into a JSON string, write it to a file, read it back, and deserialize it back into a map in V.

```v
module main

import json
import os

fn main() {
	file_path := 'scores.json'

	// Create a map[string]int
	scores := {
		'Alice': 95
		'Bob': 88
		'Charlie': 92
	}

	// 1. Encode map to JSON string
	println('Encoding map to JSON...')
	json_str := json.encode(scores)
	println('JSON string: ${json_str}')

	// 2. Write JSON string to file
	println('Writing map JSON to file "${file_path}"...')
	os.write_file(file_path, json_str) or {
		eprintln('Failed to write file: ${err}')
		return
	}

	// 3. Read JSON string from file
	println('Reading from file "${file_path}"...')
	content := os.read_file(file_path) or {
		eprintln('Failed to read file: ${err}')
		return
	}

	// 4. Decode JSON string back to map[string]int
	println('Decoding JSON back to map...')
	decoded_scores := json.decode(map[string]int, content) or {
		eprintln('Failed to decode map JSON: ${err}')
		return
	}

	println('Decoded map successfully:')
	for k, v in decoded_scores {
		println('  - ${k}: ${v}')
	}

	// Clean up created file
	os.rm(file_path) or {}
}
```

#### JSON and Raw Array To/From File

_File location: `json_and_orm/01_json/06_json_array_to_from_file/json_array_to_from_file.v`_

This example demonstrates two different methods for reading and writing arrays to/from files in V:
1. **JSON Serialization**: Best for primitive numeric/boolean arrays (e.g. `[]int`).
2. **Raw Line-by-Line (Plain Text)**: Best for string lists (e.g. `[]string`), joining with newlines on write and using V's standard `os.read_lines()` on read.

```v
module main

import json
import os

fn main() {
	// We will show two ways of writing/reading arrays to/from files:
	// Method 1: Using JSON serialization (great for numeric or structured arrays)
	// Method 2: Using raw text line-by-line reading/writing (great for string lists)

	// --- Method 1: JSON Serialization ---
	println('=== Method 1: JSON Serialization ===')
	json_file_path := 'numbers.json'
	numbers := [10, 20, 30, 40, 50]

	println('Encoding array to JSON...')
	json_str := json.encode(numbers)
	println('JSON string: ${json_str}')

	println('Writing JSON to file "${json_file_path}"...')
	os.write_file(json_file_path, json_str) or {
		eprintln('Failed to write file: ${err}')
		return
	}

	json_content := os.read_file(json_file_path) or {
		eprintln('Failed to read file: ${err}')
		return
	}

	decoded_numbers := json.decode([]int, json_content) or {
		eprintln('Failed to decode array JSON: ${err}')
		return
	}
	println('Decoded array: ${decoded_numbers}')
	os.rm(json_file_path) or {}

	// --- Method 2: Raw Line-by-Line (Plain Text) ---
	println('\n=== Method 2: Raw Line-by-Line ===')
	text_file_path := 'fruits.txt'
	fruits := ['Apple', 'Banana', 'Cherry', 'Date']

	println('Writing array elements to text file "${text_file_path}"...')
	// Join the string array with newlines to write line-by-line
	fruits_content := fruits.join('\n')
	os.write_file(text_file_path, fruits_content) or {
		eprintln('Failed to write file: ${err}')
		return
	}

	println('Reading lines from file "${text_file_path}" using os.read_lines()...')
	// os.read_lines reads a file directly into a []string (line by line)
	read_fruits := os.read_lines(text_file_path) or {
		eprintln('Failed to read lines: ${err}')
		return
	}
	println('Read string array: ${read_fruits}')
	
	// Clean up created files
	os.rm(text_file_path) or {}
}
```

### Orm

#### Orm Demo

_File location: `json_and_orm/02_orm/orm_demo.v`_

This example demonstrates the concepts of **orm demo**.

```v
module main

import db.sqlite

@[table: 'Notes']
struct Note {
    id      int    @[primary; sql: serial]
    message string @[sql: 'detail'; unique]
    status  bool
}

fn main() {
    mut db := sqlite.connect('NotesDB.db') or { panic(err) }
    defer {
        db.close() or {}
    }
    db.exec('drop table if exists Notes') or { panic(err) }

    // Creating a table
    sql db {
        create table Note
    } or { panic(err) }

    // Inserting record(s)
    n1 := Note{
        message: 'Get some milk'
        status: false
    }

    n2 := Note{
        message: 'Get groceries'
        status: false
    }
    sql db {
        insert n1 into Note
        insert n2 into Note
    } or { panic(err) }

    println(db.last_id() as int)

    // Select records
    all_notes := sql db {
        select from Note
    } or { panic(err) }

    println(all_notes)
    println('Type of all_notes is : ${typeof(all_notes).name}')

    // Select using order by clause
    notes_sorted := sql db {
        select from Note order by id desc
    } or { panic(err) }
    println(notes_sorted)

    // Select using the limit clause
    notes_limited := sql db {
        select from Note order by id desc limit 1
    } or { panic(err) }

    println(notes_limited)
    println('Type returned by select when limit is 1:  ${typeof(notes_limited).name}')

    // Select using where clause
    notes_latest := sql db {
        select from Note where id > 1
    } or { panic(err) }

    println(notes_latest)

    // Update record(s)
    sql db {
        update Note set status = true where id == 2
    } or { panic(err) }

    notes_updated := sql db {
        select from Note where id == 2
    } or { panic(err) }
    println(notes_updated)

    // Delete record(s)
    sql db {
        delete from Note where id == 2
    } or { panic(err) }

    notes_leftover := sql db {
        select from Note
    } or { panic(err) }
    println(notes_leftover)

    sql db {
        drop table Note
    } or { panic(err) }
    println('Dropped the Note table from database!')
}
```

### Sqlite Raw Crud

#### Sqlite Raw Crud

_File location: `json_and_orm/03_sqlite_raw/sqlite_raw_crud.v`_

This example demonstrates how to connect to a SQLite database and execute raw SQL queries securely using parameterized queries (`db.exec_param_many`) to prevent SQL Injection attacks.

It illustrates:
1. Connecting with `sqlite.connect`.
2. Executing statements that do not return tabular results (like DDL/DML) via `db.exec`.
3. Executing parameterized DML queries (INSERT, SELECT, UPDATE, DELETE) using `db.exec_param_many` and `?` placeholders.
4. Fetching result sets from `SELECT` statements into `[]sqlite.Row`.
5. Iterating and accessing row values from `row.vals` by index.
6. Handling resource cleanup cleanly via `defer`.

> [!TIP]
> **SQL Injection Prevention:** Avoid raw string interpolation (e.g. `"$name"`) inside raw queries. Using `db.exec_param_many` forces parameter binding, rendering the query secure from malicious inputs.

```v
module main

import db.sqlite

fn main() {
    // 1. Database Connection
    // Connects to a SQLite database. ':memory:' creates a temporary in-memory database.
    println('Connecting to database...')
    mut db := sqlite.connect(':memory:') or {
        println('Connection failed: ${err}')
        return
    }
    defer {
        db.close() or { println('Failed to close database: ${err}') }
        println('Database connection closed.')
    }

    // 2. Schema Creation (DDL)
    println('Creating "users" table...')
    db.exec('CREATE TABLE users (id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT NOT NULL, email TEXT UNIQUE, age INTEGER);') or {
        println('Table creation failed: ${err}')
        return
    }

    // 3. Create (Insert Records using Parameterized Queries)
    println('\n--- CREATE: Inserting records securely ---')
    
    // SAFE APPROACH: Use `exec_param_many` with '?' placeholders to prevent SQL Injection.
    // Parameters are passed as an array of strings: []string
    db.exec_param_many("INSERT INTO users (name, email, age) VALUES (?, ?, ?);", ['Alice', 'alice@example.com', '30']) or {
        println('Insert failed: ${err}')
    }
    db.exec_param_many("INSERT INTO users (name, email, age) VALUES (?, ?, ?);", ['Bob', 'bob@example.com', '25']) or {
        println('Insert failed: ${err}')
    }
    db.exec_param_many("INSERT INTO users (name, email, age) VALUES (?, ?, ?);", ['Charlie', 'charlie@example.com', '40']) or {
        println('Insert failed: ${err}')
    }

    println('Last inserted row ID: ${db.last_id()}')

    // 4. Read (Select Records using Parameterized Queries)
    println('\n--- READ: Querying records securely ---')
    
    // Querying with parameters: only retrieve users older than 20
    rows := db.exec_param_many('SELECT id, name, email, age FROM users WHERE age > ?;', ['20']) or {
        println('Select failed: ${err}')
        []sqlite.Row{}
    }

    // Iterate and extract column values by index
    for row in rows {
        // Each sqlite.Row has two string arrays: `vals` (values) and `names` (column names)
        id := row.vals[0]
        name := row.vals[1]
        email := row.vals[2]
        age := row.vals[3]
        println('User [ID: ${id}] -> Name: ${name}, Email: ${email}, Age: ${age}')
    }

    // 5. Update (Modify Records using Parameterized Queries)
    println('\n--- UPDATE: Modifying Bob\'s email and age securely ---')
    db.exec_param_many("UPDATE users SET email = ?, age = ? WHERE name = ?;", ['bob_new@example.com', '26', 'Bob']) or {
        println('Update failed: ${err}')
    }

    // Verify update
    updated_rows := db.exec_param_many("SELECT email, age FROM users WHERE name = ?;", ['Bob']) or { []sqlite.Row{} }
    if updated_rows.len > 0 {
        println("Bob's new email: ${updated_rows[0].vals[0]}")
        println("Bob's new age:   ${updated_rows[0].vals[1]}")
    }

    // 6. Delete (Remove Records using Parameterized Queries)
    println('\n--- DELETE: Removing Charlie securely ---')
    db.exec_param_many("DELETE FROM users WHERE name = ?;", ['Charlie']) or {
        println('Delete failed: ${err}')
    }

    // Verify delete
    remaining_rows := db.exec('SELECT name FROM users;') or { []sqlite.Row{} }
    print('Remaining users: ')
    for row in remaining_rows {
        print('${row.vals[0]} ')
    }
    println('')

    // 7. Cleanup
    println('\nDropping "users" table...')
    db.exec('DROP TABLE users;') or {
        println('Drop table failed: ${err}')
    }
}
```

## Notes Api

### Notes Api

#### Main

_File location: `notes_api/notes_api/main.v`_

This example demonstrates the concepts of **main**.

```v
module main

import veb
import db.sqlite

struct App {
mut:
    db sqlite.DB
}

struct Context {
    veb.Context
}

fn main() {
    mut db := sqlite.connect('notes.db') or { panic(err) }
    defer {
        db.close() or {}
    }
    db.exec('drop table if exists Notes') or { panic(err) }
    sql db {
        create table Note
    } or { panic(err) }
    http_port := 8000
    mut app := &App{
        db: db
    }
    veb.run[App, Context](mut app, http_port)
}
```

#### Note

_File location: `notes_api/notes_api/note.v`_

This example demonstrates the concepts of **note**.

```v
module main

import json
import veb

@[table: 'Notes']
struct Note {
    id      int    @[primary; sql: serial]
    message string @[sql: 'detail'; unique]
    status  bool
}

fn (n Note) to_json() string {
    return json.encode(n)
}

@['/notes'; post]
fn (mut app App) create(mut ctx Context) veb.Result {
    // malformed json
    n := json.decode(Note, ctx.req.data) or {
        ctx.res.set_status(.bad_request)
        return ctx.json(error_response(400, invalid_json))
    }

    // before we save, we must ensure the note's message is unique
    notes_found := sql app.db {
        select from Note where message == n.message
    } or {
        ctx.res.set_status(.internal_server_error)
        return ctx.json(error_response(500, err.msg()))
    }
    if notes_found.len > 0 {
        ctx.res.set_status(.bad_request)
        return ctx.json(error_response(400, unique_message))
    }

    // save to db
    sql app.db {
        insert n into Note
    } or {
        ctx.res.set_status(.internal_server_error)
        return ctx.json(error_response(500, err.msg()))
    }

    // retrieve the last id from the db to build full Note object
    new_id := app.db.last_id() as int

    // build new note object including the new_id and send it as JSON response
    note_created := Note{new_id, n.message, n.status}
    ctx.res.set_status(.created)
    ctx.res.header.add(.content_location, '/notes/${new_id}')
    return ctx.json(note_created.to_json())
}

@['/notes/:id'; get]
fn (mut app App) read(mut ctx Context, id int) veb.Result {
    n := sql app.db {
        select from Note where id == id
    } or {
        ctx.res.set_status(.internal_server_error)
        return ctx.json(error_response(500, err.msg()))
    }

    // check if note exists
    if n.len == 0 {
        ctx.res.set_status(.not_found)
        return ctx.json(error_response(400, note_not_found))
    }

    // found note, return it
    ret := json.encode(n[0])
    ctx.res.set_status(.ok)
    return ctx.json(ret)
}

@['/notes'; get]
fn (mut app App) read_all(mut ctx Context) veb.Result {
    n := sql app.db {
        select from Note
    } or {
        ctx.res.set_status(.internal_server_error)
        return ctx.json(error_response(500, err.msg()))
    }

    ret := json.encode(n)
    ctx.res.set_status(.ok)
    return ctx.json(ret)
}

@['/notes/:id'; put]
fn (mut app App) update(mut ctx Context, id int) veb.Result {
    // malformed json
    n := json.decode(Note, ctx.req.data) or {
        ctx.res.set_status(.bad_request)
        return ctx.json(error_response(400, invalid_json))
    }

    // check if note to be updated exists
    note_to_update := sql app.db {
        select from Note where id == id
    } or {
        ctx.res.set_status(.internal_server_error)
        return ctx.json(error_response(500, err.msg()))
    }

    if note_to_update.len == 0 {
        ctx.res.set_status(.not_found)
        return ctx.json(error_response(404, note_not_found))
    }

    // before update, we must ensure the note's message is unique
    // id != id for idempotency
    // message == n.message for unique check
    res := sql app.db {
        select from Note where message == n.message && id != id
    } or {
        ctx.res.set_status(.internal_server_error)
        return ctx.json(error_response(500, err.msg()))
    }

    if res.len > 0 {
        ctx.res.set_status(.bad_request)
        return ctx.json(error_response(400, unique_message))
    }

    // update the note
    sql app.db {
        update Note set message = n.message, status = n.status where id == id
    } or {
        ctx.res.set_status(.internal_server_error)
        return ctx.json(error_response(500, err.msg()))
    }

    // build the updated note using the :id and request body
    // instead of making one more db call
    updated_note := Note{id, n.message, n.status}

    ret := json.encode(updated_note)
    ctx.res.set_status(.ok)
    return ctx.json(ret)
}

@['/notes/:id'; delete]
fn (mut app App) delete(mut ctx Context, id int) veb.Result {
    sql app.db {
        delete from Note where id == id
    } or {
        ctx.res.set_status(.internal_server_error)
        return ctx.json(error_response(500, err.msg()))
    }
    ctx.res.set_status(.no_content)
    return ctx.ok('')
}
```

#### Util

_File location: `notes_api/notes_api/util.v`_

This example demonstrates the concepts of **util**.

```v
module main

import json

struct NotesResponse {
    status  int
    message string
}

fn (c NotesResponse) to_json() string {
    return json.encode(c)
}

const invalid_json = 'Invalid JSON Payload'
const note_not_found = 'Note not found'
const unique_message = 'Please provide a unique message for Note'

fn error_response(status int, message string) string {
    er := NotesResponse{status, message}
    return er.to_json()
}
```

## Language Updates And Stdlib

### Language Basics Updates

#### Sum Types

_File location: `language_updates_and_stdlib/01_language_basics_updates/04_sum_types/sum_types.v`_

This example demonstrates the concepts of **sum types**.

```v
module main

// Define structs for different shapes
struct Circle {
    radius f64
}

struct Rectangle {
    width  f64
    height f64
}

struct Triangle {
    base   f64
    height f64
}

// Shape is a Sum Type. A Shape variable can store a Circle, Rectangle, or Triangle.
type Shape = Circle | Rectangle | Triangle

// get_area calculates the area depending on the concrete type stored in Shape.
fn get_area(s Shape) f64 {
    // Inside the match branches, the variable is smart-casted to its concrete type.
    match s {
        Circle {
            return 3.14159 * s.radius * s.radius
        }
        Rectangle {
            return s.width * s.height
        }
        Triangle {
            return 0.5 * s.base * s.height
        }
    }
}

fn main() {
    // 1. Creating values of the sum type
    shapes := [
        Shape(Circle{
            radius: 5.0
        }),
        Shape(Rectangle{
            width:  4.0
            height: 6.0
        }),
        Shape(Triangle{
            base:   3.0
            height: 4.0
        }),
    ]

    // 2. Iterating and pattern-matching
    for shape in shapes {
        match shape {
            Circle {
                println('Found Circle with radius ${shape.radius}. Area: ${get_area(shape):.2f}')
            }
            Rectangle {
                println('Found Rectangle of ${shape.width}x${shape.height}. Area: ${get_area(shape):.2f}')
            }
            Triangle {
                println('Found Triangle with base ${shape.base} and height ${shape.height}. Area: ${get_area(shape):.2f}')
            }
        }
    }
}

```

#### Generics

_File location: `language_updates_and_stdlib/01_language_basics_updates/02_generics/generics.v`_

This example demonstrates the concepts of **generics**.

```v
module main

// Stack[T] represents a generic stack structure.
struct Stack[T] {
mut:
    items []T
}

// push appends an item of type T to the stack.
fn (mut s Stack[T]) push(item T) {
    s.items << item
}

// pop removes and returns the top item of type T from the stack,
// or returns `none` (Option type) if the stack is empty.
fn (mut s Stack[T]) pop() ?T {
    if s.items.len == 0 {
        return none
    }
    return s.items.pop()
}

// print_val is a generic function that takes any type T and prints it.
fn print_val[T](val T) {
    println('Value: ${val}')
}

fn main() {
    // 1. Using a generic struct with integers
    mut int_stack := Stack[int]{}
    int_stack.push(10)
    int_stack.push(20)
    println('Popped: ${int_stack.pop() or { 0 }}')
    println('Popped: ${int_stack.pop() or { 0 }}')
    println('Popped from empty stack: ${int_stack.pop() or { -1 }}')

    // 2. Using the same generic struct with strings
    mut str_stack := Stack[string]{}
    str_stack.push('V')
    str_stack.push('lang')
    println('Popped: ${str_stack.pop() or { 'empty' }}')
    println('Popped: ${str_stack.pop() or { 'empty' }}')

    // 3. Calling a generic function with different types
    print_val[string]('V monomorphizes generics at compile-time!')
    print_val[f64](3.14159)
}

```

#### Interfaces

_File location: `language_updates_and_stdlib/01_language_basics_updates/03_interfaces/interfaces.v`_

This example demonstrates the concepts of **interfaces**.

```v
module main

// Speaker is an interface. Any struct that implements a `speak() string` method
// implicitly implements Speaker. There is no `implements` keyword.
interface Speaker {
    speak() string
}

struct Dog {
    name string
}

// speak implements Speaker for Dog
fn (d Dog) speak() string {
    return 'Woof! My name is ${d.name}.'
}

struct Cat {
    name string
}

// speak implements Speaker for Cat
fn (c Cat) speak() string {
    return 'Meow! My name is ${c.name}.'
}

// perform_speak accepts any type implementing the Speaker interface
fn perform_speak(s Speaker) {
    println(s.speak())
}

fn main() {
    d := Dog{
        name: 'Buddy'
    }
    c := Cat{
        name: 'Whiskers'
    }

    // 1. Passing structs directly to functions expecting an interface
    perform_speak(d)
    perform_speak(c)

    // 2. Creating an array of interfaces
    speakers := [Speaker(d), Speaker(c)]
    for speaker in speakers {
        println('From array: ${speaker.speak()}')
    }
}

```

#### Options And Results

_File location: `language_updates_and_stdlib/01_language_basics_updates/01_options_and_results/options_and_results.v`_

This example demonstrates the concepts of **options and results**.

```v
module main

// Result type (!T) is used when a function can return an error.
fn divide(a f64, b f64) !f64 {
    if b == 0 {
        return error('division by zero')
    }
    return a / b
}

// Option type (?T) is used when a function can return nothing (none).
fn find_user(id int) ?string {
    if id == 1 {
        return 'Alice'
    }
    return none
}

fn main() {
    // 1. Handling a Result type with an `or` block
    // Inside the `or` block, the special variable `err` is available.
    val1 := divide(10.0, 2.0) or {
        println('Error: ${err}')
        0.0
    }
    println('Result 1: ${val1}')

    // 2. Handling a failed Result
    val2 := divide(10.0, 0.0) or {
        println('Error: ${err}')
        0.0
    }
    println('Result 2: ${val2}')

    // 3. Handling an Option type with an `or` block
    // For Option types, the value is unwrapped or the fallback value is returned.
    user1 := find_user(1) or { 'Guest' }
    println('User 1: ${user1}')

    user2 := find_user(99) or { 'Guest' }
    println('User 2: ${user2}')

    // 4. Using if-let syntax to check Options
    if name := find_user(1) {
        println('Found user: ${name}')
    } else {
        println('User not found')
    }
}

```

#### Attributes

_File location: `language_updates_and_stdlib/01_language_basics_updates/05_attributes/attributes.v`_

This example demonstrates the concepts of **attributes**.

```v
module main

import json

// User struct defines field attributes for custom JSON serialization/deserialization.
struct User {
    name string @[json: 'username']
    age  int    @[json: 'user_age']
}

// @[deprecated] warns the developer at compile time that the function shouldn't be used.
@[deprecated: 'use modern_greet instead']
fn old_greet() {
    println('Hello from the old greeting!')
}

fn modern_greet() {
    println('Hello from the modern greeting!')
}

// @[inline] suggests the compiler to inline the function body.
@[inline]
fn add(a int, b int) int {
    return a + b
}

fn main() {
    // 1. JSON serialization/deserialization using @[json] mapping
    u := User{
        name: 'Bob'
        age:  30
    }
    encoded := json.encode(u)
    println('Encoded JSON: ${encoded}')

    decoded := json.decode(User, '{"username":"Alice","user_age":25}') or {
        println('JSON error: ${err}')
        User{}
    }
    println('Decoded User -> Name: ${decoded.name}, Age: ${decoded.age}')

    // 2. Calling inline function
    sum := add(10, 20)
    println('Sum: ${sum}')

    // 3. Calling modern function
    modern_greet()

    // Note: Calling old_greet() will compile successfully but output a warning:
    // warning: old_greet has been deprecated. use modern_greet instead
    // old_greet()
}

```

### Standard Library

#### Regex Matching

_File location: `language_updates_and_stdlib/02_standard_library/05_regex_matching/regex_matching.v`_

This example demonstrates the concepts of **regex matching**.

```v
module main

import regex

fn main() {
    // 1. Compile a regex pattern
    // r'...' specifies a raw string literal, avoiding excessive escaping
    mut re := regex.regex_opt(r'\d+') or {
        println('Failed to compile regex: ${err}')
        return
    }

    text := 'We have 15 apples, 32 bananas, and 120 oranges.'

    // 2. Find the first match in the text
    // `find()` searches anywhere in the string and returns (start_index, end_index)
    start, end := re.find(text)
    if start >= 0 {
        matched := text[start..end]
        println('First match found: "${matched}" at range (${start}, ${end})')
    } else {
        println('No match found.')
    }

    // 3. Find all matches in the text
    // `find_all_str()` returns an array of all matching substrings
    all_matches := re.find_all_str(text)
    println('All matches: ${all_matches}')

    // 4. Replace matches in the text
    // `replace()` replaces all occurrences matching the regex pattern
    replaced := re.replace(text, 'NUM')
    println('Replaced text: "${replaced}"')
}

```

#### Strings Builder

_File location: `language_updates_and_stdlib/02_standard_library/01_strings_builder/strings_builder.v`_

This example demonstrates the concepts of **strings builder**.

```v
module main

import strings

fn main() {
    // 1. Initialize a new Builder with pre-allocated buffer size (e.g. 100 bytes).
    // Pre-allocation is highly recommended for performance to reduce memory allocations.
    mut sb := strings.new_builder(100)

    // 2. Write strings and runes to the buffer
    sb.write_string('Welcome ')
    sb.write_string('to ')
    sb.write_string('the V standard library!')
    sb.write_rune(`\n`)

    sb.write_string('V is:\n')
    features := ['Fast', 'Simple', 'Statically Typed', 'Safe']
    for feature in features {
        sb.write_string('- ')
        sb.write_string(feature)
        sb.write_rune(`\n`)
    }

    // 3. Extract the final constructed string
    result := sb.str()
    println(result)

    // 4. Reset/Clear the builder to reuse it
    // In V, `clear()` clears the builder's buffer.
    sb.clear()
    sb.write_string('New content in builder.')
    println(sb.str())
}

```

#### Http Client

_File location: `language_updates_and_stdlib/02_standard_library/04_http_client/http_client.v`_

This example demonstrates the concepts of **http client**.

```v
module main

import net.http

fn main() {
    // 1. HTTP GET Request
    println('Sending GET request to vlang.io...')
    get_resp := http.get('https://vlang.io') or {
        println('GET request failed: ${err}')
        return
    }
    println('GET Status Code: ${get_resp.status_code}')

    // Reading a response header
    content_type := get_resp.header.get(.content_type) or { 'unknown' }
    println('GET Content-Type Header: ${content_type}')
    println('GET Body length: ${get_resp.body.len} bytes\n')

    // 2. HTTP POST Request
    println('Sending POST request to httpbin.org...')
    post_body := 'Hello V Standard Library!'
    post_resp := http.post('https://httpbin.org/post', post_body) or {
    println('POST Status Code: ${post_resp.status_code}')
    println('POST Response Body:')
    println(post_resp.body)
}

```

#### Os Operations

V's standard library `os` module provides comprehensive functionality for interacting with the operating system, with a strong focus on POSIX/Nix systems. To cover the entire suite of `os` APIs, the examples are divided into four distinct files under `language_updates_and_stdlib/02_standard_library/02_os_operations/`:

##### 1. Basic OS & File Operations
_File location: `language_updates_and_stdlib/02_standard_library/02_os_operations/basic/os_operations.v`_

This example demonstrates common file system tasks, path manipulation, working directory traversal, environmental querying, symbol links, permissions (`chmod`), and ownership (`chown`).

```v
module main

import os

fn main() {
	filename := 'temp_book_example.txt'
	content := 'V standard library makes OS operations very straightforward.'

	// ==========================================
	// 1. Basic File Operations (Writing, Reading, Existence)
	// ==========================================
	println('Writing text to ${filename}...')
	os.write_file(filename, content) or {
		println('Failed to write file: ${err}')
		return
	}

	// Checking file existence
	if os.exists(filename) {
		println('Confirmed: File exists.')
	}

	// Reading from a file
	read_content := os.read_file(filename) or {
		println('Failed to read file: ${err}')
		return
	}
	println('Read content from file: "${read_content}"')

	// Writing and reading lines
	lines := ['Line 1: V has simple OS functions.', 'Line 2: Supporting multiple lines.']
	lines_file := 'temp_lines_example.txt'
	os.write_lines(lines_file, lines) or {
		println('Failed to write lines: ${err}')
	}
	read_lines := os.read_lines(lines_file) or {
		println('Failed to read lines: ${err}')
		[]
	}
	println('Read lines: ${read_lines}')
	os.rm(lines_file) or {}

	// Listing directory contents
	println('Listing files in current directory:')
	files := os.ls('.') or {
		println('Failed to list directory: ${err}')
		[]
	}
	for file in files {
		// Filter and print temp file
		if file == filename {
			println('- Found file: ${file}')
		}
	}

	// Reading environment variables
	home_dir := os.getenv('HOME')
	println('User HOME directory: ${home_dir}')

	// Checking if a binary exists in the system PATH
	if os.exists_in_system_path('git') {
		println('Confirmed: Git executable exists in system PATH.')
	}

	// Executing OS commands
	// os.execute runs command in a subshell and returns a Result struct containing exit_code and output.
	println('Running command "uname"...')
	res := os.execute('uname')
	if res.exit_code == 0 {
		println('Operating System: ${res.output.trim_space()}')
	} else {
		println('Command execution failed with code ${res.exit_code}: ${res.output}')
	}

	// ==========================================
	// 2. Directory Tree Operations (Nix/CLI Focus)
	// ==========================================
	println('\n--- Directory Tree Operations ---')
	
	// Create nested directories (like `mkdir -p`)
	nested_dir := os.join_path('temp_parent', 'temp_child')
	println('Creating nested directory structure: ${nested_dir}...')
	os.mkdir_all(nested_dir) or {
		println('Failed to create directory structure: ${err}')
	}

	// ==========================================
	// 3. Path Manipulation & Extraction
	// ==========================================
	println('\n--- Path Manipulation & Extraction ---')
	sample_path := '/usr/local/bin/v.exe'
	println('Sample path: ${sample_path}')
	println('Directory:   ${os.dir(sample_path)}')      // /usr/local/bin
	println('Base name:   ${os.base(sample_path)}')     // v.exe
	println('Extension:   ${os.file_ext(sample_path)}') // .exe

	// ==========================================
	// 4. Working Directory Traversal
	// ==========================================
	println('\n--- Working Directory Traversal ---')
	original_wd := os.getwd()
	println('Original working directory: ${original_wd}')

	println('Changing directory to: temp_parent...')
	os.chdir('temp_parent') or {
		println('Failed to change directory: ${err}')
	}
	println('New working directory: ${os.getwd()}')

	// Change back to original directory
	os.chdir(original_wd) or {
		println('Failed to restore directory: ${err}')
	}

	// ==========================================
	// 5. Advanced File Operations (Copying, Moving)
	// ==========================================
	println('\n--- Advanced File Actions ---')
	copied_file := 'temp_book_copy.txt'
	moved_file := 'temp_book_moved.txt'

	println('Copying ${filename} to ${copied_file}...')
	os.cp(filename, copied_file) or {
		println('Failed to copy file: ${err}')
	}

	println('Moving ${copied_file} to ${moved_file}...')
	os.mv(copied_file, moved_file) or {
		println('Failed to move file: ${err}')
	}

	// ==========================================
	// 6. Symbolic Links & Nix-Specific Operations
	// ==========================================
	println('\n--- Nix-Specific Operations ---')
	symlink_name := 'temp_book_link.txt'

	// Create symlink
	println('Creating symbolic link from ${moved_file} to ${symlink_name}...')
	os.symlink(moved_file, symlink_name) or {
		println('Failed to create symlink: ${err}')
	}

	// Check if path is a link
	if os.is_link(symlink_name) {
		println('Confirmed: ${symlink_name} is a symbolic link.')
	}

	// Change file permissions (chmod)
	// 0o644 = Owner: read/write, Group: read, Others: read
	println('Setting file permissions to 0o644 (read/write for owner, read-only for others)...')
	os.chmod(moved_file, 0o644) or {
		println('Failed to change permissions: ${err}')
	}

	// Check permissions
	println('Is readable?   ${os.is_readable(moved_file)}')
	println('Is writable?   ${os.is_writable(moved_file)}')
	println('Is executable? ${os.is_executable(moved_file)}')

	// Change ownership (chown)
	// Safe demo using our current user's UID and GID to avoid permission errors
	uid := os.getuid()
	gid := os.getgid()
	println('Setting ownership of ${moved_file} to UID: ${uid}, GID: ${gid}...')
	os.chown(moved_file, uid, gid) or {
		println('Failed to change ownership: ${err}')
	}

	// ==========================================
	// 7. Cleanup
	// ==========================================
	println('\n--- Cleanup ---')
	
	// Remove original file
	os.rm(filename) or { println('Failed to remove ${filename}: ${err}') }
	
	// Remove moved file
	os.rm(moved_file) or { println('Failed to remove ${moved_file}: ${err}') }
	
	// Remove symlink
	os.rm(symlink_name) or { println('Failed to remove symlink ${symlink_name}: ${err}') }
	
	// Remove nested directory structure recursively
	os.rmdir_all('temp_parent') or { println('Failed to remove temp_parent directory: ${err}') }
	
	println('Cleanup completed successfully.')
}
```

##### 2. Asynchronous Processes, Signals & Pipes
_File location: `language_updates_and_stdlib/02_standard_library/02_os_operations/process/os_process_pipe.v`_

This example demonstrates managing subprocesses asynchronously using `os.Process`, exchanging data via stdin/stdout redirection, passing custom environments, sending POSIX signals (`SIGSTOP`, `SIGCONT`, `SIGTERM`), creating low-level descriptor pipes, and capturing stdout/stderr dynamically via `IOCapture`.

```v
module main

import os
import time

fn main() {
	println('=== V OS Processes, Pipes & Signals (POSIX/Nix) ===')

	// --- 1. Spawning and Controlling Processes ---
	println('\n--- 1. Asynchronous Child Process (Process) ---')
	
	// Spawning '/bin/cat' as a child process
	mut p := os.new_process('/bin/cat')
	p.set_args([])
	p.set_environment({
		'CUSTOM_ENV_VAR': 'V-OS-Demo'
	})
	
	// Enable standard I/O redirection to interact with the process
	p.set_redirect_stdio()
	p.use_stdio_ctl = true
	
	// Start the process asynchronously
	p.run()
	println('Child process spawned with PID: ${p.pid}')
	println('Is alive? -> ${p.is_alive()}')

	// Write to the process's standard input
	p.stdin_write('Line 1: Hello from the parent process!\n')
	p.stdin_write('Line 2: WebAssembly and V standard libraries rule.\n')
	
	// Allow child process buffer to receive and echo the lines
	time.sleep(100 * time.millisecond)
	
	// Read output currently available in the stdout pipe
	output := p.stdout_read()
	println('Read from child stdout:\n${output.trim_space()}')

	// --- 2. POSIX Signaling ---
	println('\n--- 2. POSIX Signals ---')
	
	// Suspend the child process (SIGSTOP)
	println('Suspending child process (SIGSTOP)...')
	p.signal_stop()
	time.sleep(50 * time.millisecond)
	
	// Resume the child process (SIGCONT)
	println('Resuming child process (SIGCONT)...')
	p.signal_continue()
	time.sleep(50 * time.millisecond)

	// Terminate the child process (SIGTERM)
	println('Terminating child process (SIGTERM)...')
	p.signal_term()
	p.wait()
	
	println('Child process exited with status: ${p.status} (Code: ${p.code})')
	p.close()


	// --- 3. Pipes ---
	println('\n--- 3. Low-Level Descriptor Pipes (Pipe) ---')
	
	// Create a new pipe
	mut my_pipe := os.pipe() or {
		println('Failed to create pipe: ${err}')
		return
	}
	
	// Write to the pipe
	pipe_msg := 'IPC via Pipe'.bytes()
	written := my_pipe.write(pipe_msg) or {
		println('Failed to write to pipe: ${err}')
		0
	}
	println('Wrote ${written} bytes to pipe.')

	// Read from the pipe
	mut pipe_buf := []u8{len: 32}
	bytes_read := my_pipe.read(mut pipe_buf) or {
		println('Failed to read from pipe: ${err}')
		0
	}
	println('Read message from pipe: "${pipe_buf[..bytes_read].bytestr()}"')
	my_pipe.close()


	// --- 4. Capture Stdout/Stderr ---
	println('\n--- 4. Capture Stdout and Stderr (IOCapture) ---')
	
	// Flush stdout to prevent capturing existing print statements
	os.flush()
	
	// Capture all stdout/stderr output within this block
	mut cap := os.stdio_capture() or {
		println('Failed to initialize capture: ${err}')
		return
	}
	
	// Anything printed here will be redirected to the capture buffer
	print('Captured standard output data.')
	eprint('Captured standard error data.')
	
	// Restore standard streams and retrieve captured data
	captured_out, captured_err := cap.finish()
	
	println('Captured stdout lines: ${captured_out}')
	println('Captured stderr lines: ${captured_err}')
}
```

##### 3. System Diagnostics & File Metadata (Stat)
_File location: `language_updates_and_stdlib/02_standard_library/02_os_operations/system_info/os_system_info.v`_

This example demonstrates calling system diagnostics (`os.uname`), retrieving current host/user identities, assessing disk capacity and usage metrics (`os.disk_usage`), and parsing detailed file metadata using POSIX stat/lstat mappings (`os.Stat` and `os.FileMode`).

```v
module main

import os

fn main() {
	println('=== V OS System & File Information (POSIX/Nix) ===')

	// --- 1. System Info (uname, hostname, loginname) ---
	println('\n--- 1. System Diagnostics ---')
	
	// os.uname() returns kernel details, release, OS name, and architecture
	u := os.uname()
	println('Operating System:     ${u.sysname}')
	println('Node Name (Network):  ${u.nodename}')
	println('Kernel Release:       ${u.release}')
	println('Kernel Version:       ${u.version}')
	println('Machine Architecture: ${u.machine}')

	// Retrieve hostname and login user name
	host := os.hostname() or { 'unknown_host' }
	user := os.loginname() or { 'unknown_user' }
	println('Hostname:             ${host}')
	println('Login Name:           ${user}')


	// --- 2. Identity and Process Metrics ---
	println('\n--- 2. User/Group IDs & Process Context ---')
	
	// Real and effective UID/GIDs
	println('User ID (UID):        ${os.getuid()}')
	println('Group ID (GID):       ${os.getgid()}')
	println('Effective UID (EUID): ${os.geteuid()}')
	println('Effective GID (EGID): ${os.getegid()}')
	
	// Current Process ID and Parent Process ID
	println('Process ID (PID):     ${os.getpid()}')
	println('Parent PID (PPID):    ${os.getppid()}')


	// --- 3. Disk Space Usage ---
	println('\n--- 3. Disk Space Stats ---')
	
	// Query disk space information for the current directory
	du := os.disk_usage('.') or {
		println('Failed to retrieve disk usage: ${err}')
		return
	}
	
	// Convert u64 bytes to Gigabytes for user readability
	total_gb := f64(du.total) / (1024.0 * 1024.0 * 1024.0)
	avail_gb := f64(du.available) / (1024.0 * 1024.0 * 1024.0)
	used_gb := f64(du.used) / (1024.0 * 1024.0 * 1024.0)
	
	println('Disk Total:     ${total_gb:.2f} GB')
	println('Disk Available: ${avail_gb:.2f} GB')
	println('Disk Used:      ${used_gb:.2f} GB')


	// --- 4. Detailed File Metadata (stat/lstat) ---
	println('\n--- 4. File Metadata via stat ---')
	
	// Let's create a temporary file to run stat on
	temp_file := 'temp_stat_test.txt'
	os.write_file(temp_file, 'V stat demo content.') or { return }
	
	// Fetch file stats
	st := os.stat(temp_file) or {
		println('Failed to stat file: ${err}')
		os.rm(temp_file) or {}
		return
	}
	
	println('File Size:          ${st.size} bytes')
	println('Inode Number:       ${st.inode}')
	println('Hard Links Count:   ${st.nlink}')
	println('Device ID:          ${st.dev}')
	println('Owner UID:          ${st.uid}')
	println('Owner GID:          ${st.gid}')
	
	// Access access, modify, and status change timestamps
	println('Last Access Time:   ${st.atime} (Unix Epoch)')
	println('Last Modify Time:   ${st.mtime} (Unix Epoch)')
	println('Last Change Time:   ${st.ctime} (Unix Epoch)')

	// File type and permissions from Stat
	file_type := st.get_filetype()
	file_mode := st.get_mode()
	println('File Type:          ${file_type}') // e.g., regular, directory, link, etc.
	println('File Mode Bitmask:  0o${file_mode.bitmask():o}') // octal representation
	
	// Permissions breakdown
	println('Permissions -> Owner: R=${file_mode.owner.read} W=${file_mode.owner.write} X=${file_mode.owner.execute}')
	println('               Group: R=${file_mode.group.read} W=${file_mode.group.write} X=${file_mode.group.execute}')
	println('               Other: R=${file_mode.others.read} W=${file_mode.others.write} X=${file_mode.others.execute}')

	// Cleanup
	os.rm(temp_file) or {}
}
```

##### 4. Advanced I/O, Serialization & Directory Walking
_File location: `language_updates_and_stdlib/02_standard_library/02_os_operations/advanced_io/os_advanced_io.v`_

This example demonstrates advanced Unix file behaviors such as raw struct binary serialization, cursor seeking (`seek`/`tell`), file size truncation, and recursive directory tree traversal.

```v
module main

import os

struct Config {
mut:
	id   int
	val  f64
	name [20]u8 // fixed-size array of bytes for safe serialization
}

fn main() {
	println('=== V Advanced File I/O & Directory Walking ===')

	file_path := 'temp_advanced_io.bin'

	// --- 1. Struct Reading & Writing (Binary Serialization) ---
	println('\n--- 1. Struct Binary Serialization ---')
	
	// Create a mutable file in write/read mode
	mut f := os.open_file(file_path, 'w+') or {
		println('Failed to open file: ${err}')
		return
	}

	mut cfg := Config{
		id: 101
		val: 99.99
		name: [u8(0), 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]!
	}
	
	// Populate name
	name_str := 'V-OS-Advanced-IO'
	for i in 0 .. name_str.len {
		if i < 20 {
			cfg.name[i] = name_str[i]
		}
	}

	// Write struct representation directly to the file
	f.write_struct(cfg) or {
		println('Failed to write struct: ${err}')
	}
	println('Struct successfully serialized to file.')


	// --- 2. Seeking & Cursor Position (seek/tell) ---
	println('\n--- 2. File Seeking & Cursor Position ---')
	
	// Retrieve current position in the file (should be size of struct)
	pos := f.tell() or { 0 }
	println('Current file cursor position: ${pos} bytes')

	// Seek back to the beginning of the file (.start)
	println('Seeking back to the start of the file...')
	f.seek(0, .start) or {
		println('Failed to seek: ${err}')
	}

	// Read struct back from file
	mut read_cfg := Config{
		name: [u8(0), 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]!
	}
	f.read_struct(mut read_cfg) or {
		println('Failed to read struct: ${err}')
	}

	// Extract string from fixed-size byte array
	mut bytes := []u8{}
	for b in read_cfg.name {
		if b == 0 { break }
		bytes << b
	}
	name_read := bytes.bytestr()

	println('Deserialized Struct:')
	println('  ID:   ${read_cfg.id}')
	println('  Val:  ${read_cfg.val}')
	println('  Name: ${name_read}')

	f.close()


	// --- 3. Truncating Files ---
	println('\n--- 3. File Truncation (truncate) ---')
	
	// Note: V's os.truncate opens the file with O_TRUNC, resetting it first before sizing.
	// Shrinking/sizing a file directly using os.truncate:
	println('Truncating file "${file_path}" to 10 bytes...')
	os.truncate(file_path, 10) or {
		println('Failed to truncate: ${err}')
	}
	println('File size after truncation: ${os.file_size(file_path)} bytes')
	
	// Clean up binary file
	os.rm(file_path) or {}


	// --- 4. Recursive Directory Tree Walking ---
	println('\n--- 4. Directory Tree Walking (walk) ---')
	
	// Create a dummy tree for traversal
	walk_root := 'temp_walk_root'
	sub_dir := os.join_path(walk_root, 'docs')
	os.mkdir_all(sub_dir) or {}
	os.write_file(os.join_path(walk_root, 'file1.txt'), 'content1') or {}
	os.write_file(os.join_path(sub_dir, 'file2.log'), 'content2') or {}
	os.write_file(os.join_path(sub_dir, 'file3.txt'), 'content3') or {}

	// Recursive walk using a callback
	println('Recursive walk using os.walk (all files):')
	os.walk(walk_root, fn (path string) {
		println('  Found file: ${path}')
	})

	// Walk with file extension filter
	println('Walk with file extension filter using os.walk_ext (.txt only):')
	txt_files := os.walk_ext(walk_root, '.txt', os.WalkParams{})
	for path in txt_files {
		println('  Found .txt file: ${path}')
	}

	// Cleanup directory tree
	os.rmdir_all(walk_root) or {}
	println('Directory tree cleanup complete.')
}
```

---

#### Datatypes Collections

_File location: `language_updates_and_stdlib/02_standard_library/07_datatypes_collections/datatypes_collections.v`_

This example demonstrates the concepts of **datatypes collections**.

```v
module main

import datatypes

fn main() {
    // 1. Stack (LIFO - Last In First Out)
    println('=== Stack Demo ===')
    mut stack := datatypes.Stack[string]{}
    stack.push('first')
    stack.push('second')
    stack.push('third')
    println('Stack size: ${stack.len()}')
    println('Stack contents: ${stack.array()}')

    // peek() and pop() return Result (!T), so we handle with "or" block
    top := stack.peek() or { 'empty' }
    println('Peek top element: ${top}')

    for !stack.is_empty() {
        val := stack.pop() or { 'error' }
        println('Popped: ${val}')
    }

    // 2. Queue (FIFO - First In First Out)
    println('\n=== Queue Demo ===')
    mut queue := datatypes.Queue[int]{}
    queue.push(100)
    queue.push(200)
    queue.push(300)
    println('Queue size: ${queue.len()}')
    println('Queue contents: ${queue.array()}')

    // peek() and pop() return Result (!T)
    front := queue.peek() or { -1 }
    println('Peek front element: ${front}')

    for !queue.is_empty() {
        val := queue.pop() or { -1 }
        println('Dequeued: ${val}')
    }

    // 3. Set (Unique Elements)
    println('\n=== Set Demo ===')
    mut set_a := datatypes.Set[string]{}
    set_a.add_all(['apple', 'banana', 'cherry', 'apple']) // 'apple' is duplicate and ignored
    println('Set A elements: ${set_a.array()}')
    println('Set A size: ${set_a.size()}')
    println('Contains "banana": ${set_a.exists('banana')}')

    mut set_b := datatypes.Set[string]{}
    set_b.add_all(['cherry', 'date', 'elderberry'])
    println('Set B elements: ${set_b.array()}')

    // Union of Set A and Set B (note: 'union' is a V keyword, so we write '@union')
    union_set := set_a.@union(set_b)
    println('Union (A + B): ${union_set.array()}')

    // Intersection of Set A and Set B
    intersection_set := set_a.intersection(set_b)
    println('Intersection (A and B): ${intersection_set.array()}')

    // Difference of Set A and Set B (A - B)
    diff_set := set_a - set_b
    println('Difference (A - B): ${diff_set.array()}')
}

```

#### Command Line Flags

_File location: `language_updates_and_stdlib/02_standard_library/06_command_line_flags/command_line_flags.v`_

This example demonstrates the concepts of **command line flags**.

```v
module main

import flag
import os

fn main() {
    // 1. Initialize the flag parser with command line arguments (os.args)
    mut fp := flag.new_flag_parser(os.args)
    fp.application('greet-tool')
    fp.version('1.0.0')
    fp.description("A simple CLI greeting utility demonstrating V's flag module.")

    // 2. Skip the executable name during parsing
    fp.skip_executable()

    // 3. Define flags with their types, short abbreviations, default values, and descriptions
    // The second argument is a u8 rune for the short flag (e.g. `n` for -n), or `0` for none.
    name := fp.string('name', `n`, 'Guest', 'The name of the person to greet')
    verbose := fp.bool('verbose', `v`, false, 'Enable verbose logging output')
    count := fp.int('count', `c`, 1, 'Number of times to print the greeting')

    // 4. Finalize parsing. This returns remaining non-flag arguments or an error.
    additional_args := fp.finalize() or {
        println('Error: ${err}')
        println(fp.usage())
        return
    }

    if verbose {
        println('Verbose Mode: ON')
        println('Parsing completed successfully.')
    }

    // 5. Use the parsed variables
    for i in 0 .. count {
        println('Hello, ${name}! (greeting ${i + 1}/${count})')
    }

    if additional_args.len > 0 {
        println('Additional non-flag arguments: ${additional_args}')
    }
}

```

#### Command Line Arguments

_File location: `language_updates_and_stdlib/02_standard_library/09_command_line_arguments/command_line_arguments.v`_

This example demonstrates how to directly access and parse command-line arguments using `os.args` to build simple command-line applications.

```v
module main

import os

fn main() {
	// os.args is a []string containing all command line arguments.
	// os.args[0] is always the name of the executable (or the script path if run via v run).
	// os.args[1..] contains the actual command-line arguments passed to the program.
	println('Executable / script path: ${os.args[0]}')
	println('Total arguments count:    ${os.args.len}')
	println('All arguments list:       ${os.args}')

	if os.args.len < 2 {
		println('\nUsage: v run command_line_arguments.v <command> [arguments...]')
		println('Try running: v run command_line_arguments.v greet Alice')
		println('Try running: v run command_line_arguments.v sum 3 5 8')
		return
	}

	command := os.args[1]
	args := os.args[2..]

	println('\nProcessing command: "${command}" with args: ${args}')

	match command {
		'greet' {
			if args.len < 1 {
				println('Error: greet command requires a name.')
				return
			}
			name := args[0]
			println('Hello, ${name}!')
		}
		'sum' {
			if args.len < 1 {
				println('Error: sum command requires at least one number.')
				return
			}
			mut total := 0
			for arg in args {
				num := arg.int()
				total += num
			}
			println('Sum of numbers: ${total}')
		}
		else {
			println('Unknown command: "${command}". Allowed commands: "greet", "sum".')
		}
	}
}
```

#### Time And Stopwatch

_File location: `language_updates_and_stdlib/02_standard_library/03_time_and_stopwatch/time_and_stopwatch.v`_

This example demonstrates the concepts of **time and stopwatch**.

```v
module main

import time

fn main() {
    // 1. Getting current local time
    now := time.now()
    println('Current local time: ${now}')
    println('Components -> Year: ${now.year}, Month: ${now.month}, Day: ${now.day}')

    // 2. Custom time formatting
    formatted := now.custom_format('YYYY-MM-DD HH:mm:ss')
    println('Custom formatted: ${formatted}')

    // 3. Time calculations (adding/subtracting durations)
    // V provides constants like time.hour, time.minute, time.second, etc.
    two_hours := 2 * time.hour
    future := now.add(two_hours)
    println('Time in 2 hours: ${future}')

    // 4. Measuring elapsed time using a Stopwatch
    println('Starting stopwatch...')
    mut sw := time.new_stopwatch()

    // Sleep for a short duration to simulate work
    time.sleep(150 * time.millisecond)

    elapsed := sw.elapsed()
    println('Elapsed time: ${elapsed.milliseconds()} ms')
}
```

#### Math And Rand

_File location: `language_updates_and_stdlib/02_standard_library/10_math_and_rand/math_and_rand.v`_

This example demonstrates the concepts of **math and rand**.

```v
module main

import math
import rand

fn main() {
	println('=== Math & Rand Module Examples ===')

	// --- math ---
	println('\n--- math ---')
	println('Pi constant: ${math.pi}')
	println('E constant:  ${math.e}')
	
	// Trigonometry
	angle := 45.0 * (math.pi / 180.0) // 45 degrees in radians
	println('sin(45 deg): ${math.sin(angle):.4f}')
	println('cos(45 deg): ${math.cos(angle):.4f}')
	println('tan(45 deg): ${math.tan(angle):.4f}')

	// Power, Square Root, Logarithms
	println('2^10:        ${math.pow(2.0, 10.0)}')
	println('sqrt(144):   ${math.sqrt(144.0)}')
	println('ln(e):       ${math.log(math.e)}')
	println('log10(100):  ${math.log10(100.0)}')

	// Absolute, Min/Max, Rounding
	println('abs(-5.5):   ${math.abs(-5.5)}')
	println('max(10, 20): ${math.max(10.0, 20.0)}')
	println('min(10, 20): ${math.min(10.0, 20.0)}')
	println('ceil(4.2):   ${math.ceil(4.2)}')
	println('floor(4.8):  ${math.floor(4.8)}')
	println('round(4.5):  ${math.round(4.5)}')

	// --- rand ---
	println('\n--- rand ---')
	// Random integers and floats
	random_int := rand.int_in_range(1, 100) or { 0 }
	println('Random integer in [1, 100): ${random_int}')

	random_f64 := rand.f64()
	println('Random f64 in [0.0, 1.0):   ${random_f64:.4f}')

	// Random boolean simulated using rand.intn
	random_bool := (rand.intn(2) or { 0 }) == 0
	println('Random boolean:             ${random_bool}')

	// Choosing a random element from an array
	items := ['Apple', 'Banana', 'Cherry', 'Date']
	chosen := rand.element(items) or { 'None' }
	println('Randomly chosen fruit:      ${chosen}')

	// Random UUID generation (commonly used)
	uuid_str := rand.uuid_v4()
	println('Random UUID v4:             ${uuid_str}')
}
```

#### Log And Crypto

_File location: `language_updates_and_stdlib/02_standard_library/11_log_and_crypto/log_and_crypto.v`_

This example demonstrates the concepts of **log and crypto**.

```v
module main

import log
import crypto.sha256
import crypto.md5

fn main() {
	println('=== Log & Crypto Module Examples ===')

	// --- log ---
	println('\n--- log ---')
	// V's log module provides customizable levels (debug, info, warn, error, fatal)
	mut logger := log.Log{}
	logger.set_level(.info) // Set threshold (ignores debug level)
	
	logger.info('Logger initialized.')
	logger.warn('This is a warning message.')
	logger.error('This is an error message.')

	// --- crypto ---
	println('\n--- crypto ---')
	input := 'V language standard library'
	
	// SHA256 Hash
	sha_hash := sha256.hexhash(input)
	println('SHA-256 of "${input}":')
	println('  ${sha_hash}')

	// MD5 Hash
	md5_hash := md5.hexhash(input)
	println('MD5 of "${input}":')
	println('  ${md5_hash}')
}
```

##### Comprehensive Cryptographic Examples

For a detailed demonstration of every cryptographic module, the standard library examples are structured into subdirectories under `language_updates_and_stdlib/02_standard_library/11_log_and_crypto/crypto/`.

###### 1. Cryptographic Hash Functions
_File location: `language_updates_and_stdlib/02_standard_library/11_log_and_crypto/crypto/hash/crypto_hash.v`_

Demonstrates MD5, SHA-1, SHA-256, SHA-512, SHA-3 (Keccak-256/Keccak-512), RIPEMD-160, BLAKE2b, BLAKE2s, and BLAKE3.

```v
module main

import crypto.md5
import crypto.sha1
import crypto.sha256
import crypto.sha512
import crypto.sha3
import crypto.ripemd160
import crypto.blake2b
import crypto.blake2s
import crypto.blake3

fn main() {
	println('=== V Cryptographic Hash Algorithms ===')
	
	input := 'V Language Crypto Guide'.bytes()
	input_str := 'V Language Crypto Guide'

	// 1. MD5 (128-bit)
	md5_hex := md5.hexhash(input_str)
	println('MD5:       ${md5_hex}')

	// 2. SHA-1 (160-bit)
	sha1_hex := sha1.hexhash(input_str)
	println('SHA-1:     ${sha1_hex}')

	// 3. SHA-256 (256-bit)
	sha256_hex := sha256.hexhash(input_str)
	println('SHA-256:   ${sha256_hex}')

	// 4. SHA-512 (512-bit)
	sha512_hex := sha512.hexhash(input_str)
	println('SHA-512:   ${sha512_hex}')

	// 5. SHA-3 (Keccak-based, 256 and 512 bit sums)
	sha3_256 := sha3.sum256(input)
	sha3_512 := sha3.sum512(input)
	println('SHA3-256:  ${sha3_256.hex()}')
	println('SHA3-512:  ${sha3_512.hex()}')

	// 6. RIPEMD-160 (160-bit)
	ripemd_hex := ripemd160.hexhash(input_str)
	println('RIPEMD160: ${ripemd_hex}')

	// 7. BLAKE2b (commonly 512-bit / 256-bit)
	blake2b_256 := blake2b.sum256(input)
	blake2b_512 := blake2b.sum512(input)
	println('BLAKE2b-256: ${blake2b_256.hex()}')
	println('BLAKE2b-512: ${blake2b_512.hex()}')

	// 8. BLAKE2s (commonly 256-bit)
	blake2s_256 := blake2s.sum256(input)
	println('BLAKE2s-256: ${blake2s_256.hex()}')

	// 9. BLAKE3 (256-bit, highly optimized)
	blake3_256 := blake3.sum256(input)
	println('BLAKE3-256:  ${blake3_256.hex()}')
}
```

###### 2. Symmetric Ciphers & Block Modes
_File location: `language_updates_and_stdlib/02_standard_library/11_log_and_crypto/crypto/symmetric/crypto_symmetric.v`_

Demonstrates AES (CBC block mode with PKCS7-like padding), DES, Blowfish (encryption-only), RC4 stream cipher, and general block modes.

```v
module main

import crypto.aes
import crypto.des
import crypto.blowfish
import crypto.rc4
import crypto.cipher

fn main() {
	println('=== V Symmetric Cryptography Demo ===')

	// --- 1. AES with CBC Block Mode ---
	println('\n--- AES (CBC Mode) ---')
	aes_key := [u8(1), 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16] // 16-byte key (AES-128)
	aes_iv := [u8(9), 8, 7, 6, 5, 4, 3, 2, 1, 0, 9, 8, 7, 6, 5, 4]       // 16-byte IV

	aes_block := aes.new_cipher(aes_key)
	mut aes_enc := cipher.new_cbc(aes_block, aes_iv)

	// In CBC mode, data must be padded to block size (16 bytes for AES)
	plaintext := 'Hello, V Cryptography! Padding here.'.bytes() // 36 bytes. We need to pad it to 48 bytes (multiple of 16)
	mut padded := plaintext.clone()
	pad_len := 16 - (padded.len % 16)
	for _ in 0 .. pad_len {
		padded << u8(pad_len)
	}

	mut ciphertext := []u8{len: padded.len}
	aes_enc.encrypt_blocks(mut ciphertext, padded)
	println('Ciphertext (Hex): ${ciphertext.hex()}')

	// Decrypt
	mut aes_dec := cipher.new_cbc(aes_block, aes_iv)
	mut decrypted := []u8{len: ciphertext.len}
	aes_dec.decrypt_blocks(mut decrypted, ciphertext)
	
	// Unpad
	unpadded_len := decrypted.len - int(decrypted.last())
	unpadded_text := decrypted[..unpadded_len].bytestr()
	println('Decrypted Text:   "${unpadded_text}"')


	// --- 2. DES Block Cipher ---
	println('\n--- DES ---')
	des_key := [u8(1), 2, 3, 4, 5, 6, 7, 8] // 8-byte key
	des_block := des.new_cipher(des_key)

	des_plain := 'DESplain'.bytes() // exactly 8 bytes (DES block size)
	mut des_cipher := []u8{len: 8}
	des_block.encrypt(mut des_cipher, des_plain)
	println('DES Ciphertext (Hex): ${des_cipher.hex()}')

	mut des_decrypted := []u8{len: 8}
	des_block.decrypt(mut des_decrypted, des_cipher)
	println('DES Decrypted:        "${des_decrypted.bytestr()}"')


	// --- 3. Blowfish Block Cipher ---
	println('\n--- Blowfish (Encryption Only) ---')
	bf_key := 'blowfish_key'.bytes()
	mut bf := blowfish.new_cipher(bf_key) or { panic(err) }

	bf_plain := 'bf_block'.bytes() // exactly 8 bytes (Blowfish block size)
	mut bf_cipher := []u8{len: 8}
	bf.encrypt(mut bf_cipher, bf_plain)
	println('Blowfish Ciphertext (Hex): ${bf_cipher.hex()}')
	println('(Note: V standard library crypto.blowfish only supports encryption)')


	// --- 4. RC4 Stream Cipher ---
	println('\n--- RC4 (Stream Cipher) ---')
	rc4_key := 'rc4_secret_key'.bytes()
	rc4_plain := 'RC4 is a stream cipher commonly used for legacy operations.'.bytes()

	mut rc4_enc := rc4.new_cipher(rc4_key) or { panic(err) }
	mut rc4_cipher := []u8{len: rc4_plain.len}
	rc4_enc.xor_key_stream(mut rc4_cipher, rc4_plain)
	println('RC4 Ciphertext (Hex): ${rc4_cipher.hex()}')

	mut rc4_dec := rc4.new_cipher(rc4_key) or { panic(err) }
	mut rc4_decrypted := []u8{len: rc4_cipher.len}
	rc4_dec.xor_key_stream(mut rc4_decrypted, rc4_cipher)
	println('RC4 Decrypted:        "${rc4_decrypted.bytestr()}"')
}
```

###### 3. Asymmetric Cryptography & PEM Formats
_File location: `language_updates_and_stdlib/02_standard_library/11_log_and_crypto/crypto/asymmetric/crypto_asymmetric.v`_

Demonstrates ECDSA key generation, signing, and verification; Ed25519 signing and verification; and PEM block encoding/decoding.

```v
module main

import crypto.ecdsa
import crypto.ed25519
import crypto.pem

fn main() {
	println('=== V Asymmetric Cryptography Demo ===')

	message := 'Message to sign and verify asymmetric signatures.'.bytes()

	// --- 1. ECDSA ---
	println('\n--- ECDSA ---')
	
	// Generate key pair
	pub_ec, priv_ec := ecdsa.generate_key() or {
		println('Failed to generate ECDSA key: ${err}')
		return
	}
	
	// Sign message
	sig_ec := priv_ec.sign(message, ecdsa.SignerOpts{}) or {
		println('ECDSA signing failed: ${err}')
		return
	}
	println('ECDSA Signature (Hex): ${sig_ec.hex()}')

	// Verify message
	verified_ec := pub_ec.verify(message, sig_ec, ecdsa.SignerOpts{}) or {
		println('ECDSA verification error: ${err}')
		return
	}
	println('ECDSA Signature Verified? -> ${verified_ec}')


	// --- 2. Ed25519 ---
	println('\n--- Ed25519 ---')
	
	// Generate key pair
	pub_ed, priv_ed := ed25519.generate_key() or {
		println('Failed to generate Ed25519 key: ${err}')
		return
	}

	// Sign message
	sig_ed := ed25519.sign(priv_ed, message) or {
		println('Ed25519 signing failed: ${err}')
		return
	}
	println('Ed25519 Signature (Hex): ${sig_ed.hex()}')

	// Verify message
	verified_ed := ed25519.verify(pub_ed, message, sig_ed) or {
		println('Ed25519 verification error: ${err}')
		return
	}
	println('Ed25519 Signature Verified? -> ${verified_ed}')


	// --- 3. PEM Encoding/Decoding ---
	println('\n--- PEM (Privacy Enhanced Mail) Encoding ---')
	
	pub_bytes := pub_ec.bytes() or {
		println('Failed to get public key bytes: ${err}')
		return
	}
	
	mut pem_block := pem.Block.new('EC PUBLIC KEY')
	pem_block.data = pub_bytes
	
	pem_string := pem_block.encode(pem.EncodeConfig{}) or {
		println('PEM encoding failed: ${err}')
		return
	}
	println('Encoded PEM Public Key:')
	println(pem_string)

	// Decode back
	decoded_block, _ := pem.decode(pem_string) or {
		println('PEM decoding failed')
		return
	}
	println('Decoded Block Type: "${decoded_block.block_type}"')
	println('Decoded data size matches? -> ${decoded_block.data.len == pub_bytes.len}')
}
```

###### 4. Key Derivation Functions (KDF)
_File location: `language_updates_and_stdlib/02_standard_library/11_log_and_crypto/crypto/kdf/crypto_kdf.v`_

Demonstrates secure password hashing and key derivation using Bcrypt, Scrypt, and PBKDF2.

```v
module main

import crypto.bcrypt
import crypto.scrypt
import crypto.pbkdf2
import crypto.sha256

fn main() {
	println('=== V Key Derivation Functions Demo ===')

	// --- 1. Bcrypt ---
	println('\n--- Bcrypt ---')
	password := 'super_secure_password'.bytes()
	hash := bcrypt.generate_from_password(password, bcrypt.default_cost) or {
		println('Bcrypt failed: ${err}')
		return
	}
	println('Bcrypt hash: ${hash}')

	bcrypt.compare_hash_and_password(password, hash.bytes()) or {
		println('Bcrypt verification failed: ${err}')
		return
	}
	println('Bcrypt verification successful!')


	// --- 2. Scrypt ---
	println('\n--- Scrypt ---')
	scrypt_pass := 'my_scrypt_pass'.bytes()
	scrypt_salt := 'scrypt_salt'.bytes()
	
	// N=16384, r=8, p=1, key_len=32 (N must be power of 2)
	scrypt_key := scrypt.scrypt(scrypt_pass, scrypt_salt, 16384, 8, 1, 32) or {
		println('Scrypt failed: ${err}')
		return
	}
	println('Scrypt Key (Hex): ${scrypt_key.hex()}')


	// --- 3. PBKDF2 ---
	println('\n--- PBKDF2 ---')
	pbkdf2_pass := 'my_pbkdf2_pass'.bytes()
	pbkdf2_salt := 'pbkdf2_salt'.bytes()
	
	// pbkdf2.key(password, salt, iterations, key_len, hash_fn)
	pbkdf2_key := pbkdf2.key(pbkdf2_pass, pbkdf2_salt, 4096, 32, sha256.new()) or {
		println('PBKDF2 failed: ${err}')
		return
	}
	println('PBKDF2 Key (Hex): ${pbkdf2_key.hex()}')
}
```

###### 5. Message Authentication Codes (MAC)
_File location: `language_updates_and_stdlib/02_standard_library/11_log_and_crypto/crypto/mac/crypto_mac.v`_

Demonstrates message integrity and authenticity verification using HMAC-SHA256.

```v
module main

import crypto.hmac
import crypto.sha256

fn main() {
	println('=== V Message Authentication Codes (MAC) Demo ===')

	// --- 1. HMAC-SHA256 Signature Generation ---
	println('\n--- HMAC-SHA256 Signature ---')
	key := 'secret_signing_key'.bytes()
	message := 'This is a message to be authenticated using HMAC.'.bytes()

	// hmac.new(key, data, hash_func, blocksize)
	mac := hmac.new(key, message, sha256.sum, sha256.block_size)
	println('HMAC (Hex): ${mac.hex()}')

	// --- 2. HMAC Verification ---
	println('\n--- HMAC Verification ---')
	
	// Re-compute to verify
	computed_mac := hmac.new(key, message, sha256.sum, sha256.block_size)
	
	// hmac.equal performs constant-time comparison to prevent timing attacks
	is_valid := hmac.equal(mac, computed_mac)
	println('Signature matches? -> ${is_valid}')

	// Verify with a tampered message
	tampered_message := 'This is a message to be authenticated using HMAC!'.bytes()
	tampered_mac := hmac.new(key, tampered_message, sha256.sum, sha256.block_size)
	is_tampered_valid := hmac.equal(mac, tampered_mac)
	println('Tampered signature matches? -> ${is_tampered_valid}')
}
```

###### 6. Secure Randomness & Entropy
_File location: `language_updates_and_stdlib/02_standard_library/11_log_and_crypto/crypto/entropy/crypto_entropy.v`_

Demonstrates generating secure cryptographically random bytes, `u64` values, and large integers (`big.Integer`).

```v
module main

import crypto.rand
import math.big

fn main() {
	println('=== V Secure Randomness (Entropy) Demo ===')

	// --- 1. Generating Secure Random Bytes ---
	println('\n--- Secure Random Bytes ---')
	// Generates securely generated random bytes from the OS entropy pool
	random_bytes := rand.bytes(16) or {
		println('Failed to generate secure bytes: ${err}')
		return
	}
	println('Generated 16 secure bytes (Hex): ${random_bytes.hex()}')

	// --- 2. Generating Secure Random u64 ---
	println('\n--- Secure Random u64 ---')
	// Generates a random u64 in the range [0, max)
	limit_u64 := u64(10_000)
	random_val := rand.int_u64(limit_u64) or {
		println('Failed to generate random u64: ${err}')
		return
	}
	println('Secure random u64 in [0, ${limit_u64}): ${random_val}')

	// --- 3. Generating Secure Random Big Integer ---
	println('\n--- Secure Random big.Integer ---')
	// Generates a random big.Integer in the range [0, limit)
	limit_str := '10000000000000000000000000000000000000000' // 10^40
	limit_big := big.integer_from_string(limit_str) or {
		println('Failed to parse big integer string: ${err}')
		return
	}
	
	random_big := rand.int_big(limit_big) or {
		println('Failed to generate random big integer: ${err}')
		return
	}
	println('Secure random big.Integer in [0, 10^40):')
	println(random_big.str())
}
```

#### Sync Concurrency

_File location: `language_updates_and_stdlib/02_standard_library/12_sync_concurrency/sync_concurrency.v`_

This example demonstrates the concepts of **sync concurrency**.

```v
module main

import sync
import time

fn worker(id int, mut wg sync.WaitGroup) {
	defer {
		wg.done()
	}
	println('Worker ${id} starting...')
	time.sleep(50 * time.millisecond)
	println('Worker ${id} done!')
}

fn main() {
	println('=== Sync & Concurrency Examples ===')

	// 1. WaitGroup (Wait for multiple goroutines/tasks)
	mut wg := sync.new_waitgroup()
	for i in 1 .. 4 {
		wg.add(1)
		go worker(i, mut wg)
	}
	wg.wait()
	println('All workers completed!')

	// 2. Mutex (Thread-safe shared state access)
	println('\n=== Mutex Demo ===')
	mut mu := sync.new_mutex()
	mu.@lock()
	println('Mutex locked')
	mu.unlock()
	println('Mutex unlocked')
}
```

#### Encoding Formats

_File location: `language_updates_and_stdlib/02_standard_library/13_encoding_formats/encoding_formats.v`_

This example demonstrates the concepts of **encoding formats**.

```v
module main

import encoding.base64
import encoding.hex
import encoding.csv

fn main() {
	println('=== Encoding Modules Examples ===')

	// --- 1. Base64 ---
	println('\n--- Base64 ---')
	raw_str := 'V Programming Language'
	encoded_b64 := base64.encode_str(raw_str)
	println('Encoded Base64: ${encoded_b64}')

	decoded_b64 := base64.decode_str(encoded_b64)
	println('Decoded Base64: ${decoded_b64}')

	// --- 2. Hex ---
	println('\n--- Hex ---')
	raw_bytes := [u8(72), 101, 108, 108, 111] // "Hello"
	encoded_hex := hex.encode(raw_bytes)
	println('Encoded Hex:    ${encoded_hex}')

	decoded_hex := hex.decode(encoded_hex) or { []u8{} }
	println('Decoded Hex:    ${decoded_hex.bytestr()}')

	// --- 3. CSV ---
	println('\n--- CSV ---')
	csv_data := 'Name,Age,City\nAlice,30,New York\nBob,25,San Francisco'
	
	mut reader := csv.new_reader(csv_data)
	println('Reading CSV rows:')
	for {
		row := reader.read() or { break }
		println('  Row: ${row}')
	}
}
```

#### Arrays Utility

_File location: `language_updates_and_stdlib/02_standard_library/14_arrays_utility/arrays_utility.v`_

This example demonstrates the concepts of **arrays utility**.

```v
module main

import arrays

fn main() {
	println('=== arrays Utility Module Examples ===')

	nums := [5, 3, 9, 1, 7, 3]

	// Find min and max
	min_val := arrays.min(nums) or { 0 }
	max_val := arrays.max(nums) or { 0 }
	println('Array: ${nums}')
	println('Min:   ${min_val}') // 1
	println('Max:   ${max_val}') // 9

	// Find index of min/max
	min_idx := arrays.idx_min(nums) or { -1 }
	max_idx := arrays.idx_max(nums) or { -1 }
	println('Index of Min: ${min_idx}') // 3
	println('Index of Max: ${max_idx}') // 2

	// Chunking
	chunked := arrays.chunk(nums, 2)
	println('Chunked into sizes of 2: ${chunked}') // [[5, 3], [9, 1], [7, 3]]

	// Uniq (remove consecutive duplicates)
	consecutive_dups := [1, 1, 2, 2, 3, 1, 1]
	unique := arrays.uniq(consecutive_dups)
	println('Consecutive duplicates array: ${consecutive_dups}')
	println('After uniq():                 ${unique}') // [1, 2, 3, 1]
}
```

#### GG Graphics

_File location: `language_updates_and_stdlib/02_standard_library/08_gg_graphics/gg_graphics.v`_

This example demonstrates the concepts of **gg graphics** using V's simple graphics module. It shows how to initialize a window, define an application state struct, draw various 2D shapes (rectangles, circles, triangles, polygons, lines), render formatted text, and intercept keyboard and mouse event inputs.

```v
module main

import gg
import math

// AppContext holds the state of our graphical application.
// Using a state struct is a recommended best practice for gg applications
// to avoid global variables (which V does not support by default).
struct AppContext {
mut:
	ctx          &gg.Context = unsafe { nil }
	width        int  = 800
	height       int  = 600
	// Interactive shape parameters
	shape_x      f32  = 400.0
	shape_y      f32  = 300.0
	shape_size   f32  = 50.0
	shape_color  gg.Color = gg.blue
	active_shape int  // 0 = Circle, 1 = Rectangle, 2 = Triangle
	// Tracking mouse positions and clicks
	mouse_x      f32
	mouse_y      f32
	click_x      f32  = -1.0
	click_y      f32  = -1.0
	click_color  gg.Color = gg.red
	// Last key pressed message
	last_key     string = 'None'
}

fn main() {
	// Initialize state
	mut app := &AppContext{
		width: 800
		height: 600
	}

	// Create a new gg context.
	// You specify callbacks for rendering frames, processing events,
	// and cleanups, along with initial window configurations.
	app.ctx = gg.new_context(
		width:        app.width
		height:       app.height
		window_title: "V's gg graphics module: Tutorial & Interactive Demo"
		bg_color:     gg.rgb(240, 244, 248) // A subtle modern light-blue background
		user_data:    app                 // Pass our state struct to be accessible inside callbacks
		frame_fn:     frame               // Callback called once per frame (to draw shapes/UI)
		event_fn:     on_event            // Callback called for user inputs (mouse & keyboard)
	)

	println('Starting interactive graphics window...')
	println('Controls:')
	println('  - Move the mouse to see cursor position tracking.')
	println('  - Left-Click anywhere to draw a red dot at the click location.')
	println('  - Use Arrow Keys (Up/Down/Left/Right) to move the active shape.')
	println('  - Press [C] or [c] to cycle the active shape\'s color.')
	println('  - Press [S] or [s] to toggle between Circle, Rectangle, and Triangle.')
	println('  - Press [Escape] to close the window.')
	println('\nReal-world Case Study:')
	println('  - Check out a complete journaling application built with gg:')
	println('    https://github.com/codecaine-zz/MindSpace-Journal')

	// Start the application main event loop.
	app.ctx.run()
}

// frame is the drawing function called per frame.
// All rendering code MUST reside between ctx.begin() and ctx.end().
fn frame(data voidptr) {
	mut app := unsafe { &AppContext(data) }
	mut ctx := app.ctx
	ctx.begin()

	// --- 1. Draw Static 2D Shapes ---
	
	// Draw a thick horizontal line dividing the header from the demo workspace
	ctx.draw_line(0, 80, app.width, 80, gg.gray)

	// Draw a filled rectangle (Left)
	ctx.draw_rect_filled(50, 120, 120, 80, gg.green)
	// Draw an empty/outline rectangle just next to it
	ctx.draw_rect_empty(200, 120, 120, 80, gg.dark_gray)

	// Draw a filled circle (Middle-Left)
	ctx.draw_circle_filled(430, 160, 45, gg.orange)
	// Draw an empty/outline circle
	ctx.draw_circle_empty(560, 160, 45, gg.purple)

	// Draw a filled triangle (Middle-Right)
	ctx.draw_triangle_filled(700, 115, 750, 205, 650, 205, gg.pink)

	// Draw a custom convex polygon (a star-like pentagon, bottom right)
	poly_points := [
		f32(650.0), 480.0, // Point 1
		750.0, 480.0,      // Point 2
		780.0, 560.0,      // Point 3
		700.0, 520.0,      // Point 4
		620.0, 560.0       // Point 5
	]
	ctx.draw_convex_poly(poly_points, gg.cyan)

	// --- 2. Render Text using custom configurations (TextCfg) ---

	// Main Title with default configuration
	ctx.draw_text_def(20, 15, "Welcome to V's Simple Graphics (gg) Tutorial!")

	// Instructions and state metadata at the top right
	ctx.draw_text(20, 45, 'Cursor: (${app.mouse_x:.1f}, ${app.mouse_y:.1f}) | Last Key: ${app.last_key}',
		color: gg.dark_blue
		size: 16
		bold: true
	)

	// Context description
	ctx.draw_text(50, 215, 'Filled & Empty Rectangles', size: 12, color: gg.dark_gray)
	ctx.draw_text(400, 215, 'Filled & Empty Circles', size: 12, color: gg.dark_gray)
	ctx.draw_text(650, 215, 'Filled Triangle', size: 12, color: gg.dark_gray)
	ctx.draw_text(630, 570, 'Convex Polygon (Pentagon)', size: 12, color: gg.dark_gray)

	// Help panel explaining key bindings
	ctx.draw_rect_filled(20, 440, 280, 140, gg.Color{r: 255, g: 255, b: 255, a: 180})
	ctx.draw_rect_empty(20, 440, 280, 140, gg.gray)
	ctx.draw_text(35, 450, 'Controls Panel', size: 15, bold: true, color: gg.black)
	ctx.draw_text(35, 475, '- Arrows: Move active shape', size: 13, color: gg.black)
	ctx.draw_text(35, 495, '- C: Cycle shape color', size: 13, color: gg.black)
	ctx.draw_text(35, 515, '- S: Switch shape type', size: 13, color: gg.black)
	ctx.draw_text(35, 535, '- Mouse Click: Draw a dot', size: 13, color: gg.black)
	ctx.draw_text(35, 555, '- Escape: Quit application', size: 13, color: gg.black)

	// Case Study reference
	ctx.draw_text(20, 585, 'Case Study: github.com/codecaine-zz/MindSpace-Journal', size: 10, italic: true, color: gg.dark_blue)

	// --- 3. Draw Dynamic / Interactive Elements ---

	// Draw a dot where the user clicked, if a click has occurred
	if app.click_x >= 0.0 {
		ctx.draw_circle_filled(app.click_x, app.click_y, 8, app.click_color)
		ctx.draw_circle_empty(app.click_x, app.click_y, 12, gg.black)
		ctx.draw_text(int(app.click_x) + 12, int(app.click_y) - 6, 'Last Click: (${app.click_x:.0f}, ${app.click_y:.0f})',
			size: 11
			color: gg.black
		)
	}

	// Draw the active shape controlled by the user
	match app.active_shape {
		0 {
			// Draw interactive Circle
			ctx.draw_circle_filled(app.shape_x, app.shape_y, app.shape_size, app.shape_color)
			ctx.draw_circle_empty(app.shape_x, app.shape_y, app.shape_size, gg.black)
		}
		1 {
			// Draw interactive Rectangle (centered on coordinates)
			half := app.shape_size
			ctx.draw_rect_filled(app.shape_x - half, app.shape_y - half, app.shape_size * 2, app.shape_size * 2, app.shape_color)
			ctx.draw_rect_empty(app.shape_x - half, app.shape_y - half, app.shape_size * 2, app.shape_size * 2, gg.black)
		}
		2 {
			// Draw interactive Equilateral Triangle (centered on coordinates)
			// Using trigonometry to draw an equilateral triangle of size `shape_size`
			h := app.shape_size * f32(math.sqrt(3.0)) / 2.0
			x1 := app.shape_x
			y1 := app.shape_y - (2.0 / 3.0) * h
			x2 := app.shape_x - app.shape_size
			y2 := app.shape_y + (1.0 / 3.0) * h
			x3 := app.shape_x + app.shape_size
			y3 := app.shape_y + (1.0 / 3.0) * h
			ctx.draw_triangle_filled(x1, y1, x2, y2, x3, y3, app.shape_color)
		}
		else {}
	}

	// Draw label above the active shape
	ctx.draw_text(int(app.shape_x) - 40, int(app.shape_y) - int(app.shape_size) - 20, 'Active Shape',
		size: 13
		bold: true
		color: gg.black
	)

	ctx.end()
}

// on_event intercepts and handles all system-level user inputs.
fn on_event(e &gg.Event, data voidptr) {
	mut app := unsafe { &AppContext(data) }
	mut ctx := app.ctx

	match e.typ {
		.mouse_move {
			app.mouse_x = e.mouse_x
			app.mouse_y = e.mouse_y
		}
		.mouse_down {
			app.click_x = e.mouse_x
			app.click_y = e.mouse_y
			// Randomize click dot color slightly for visual variety
			if app.click_color.r == 255 {
				app.click_color = gg.Color{r: 0, g: 180, b: 0, a: 255}
			} else {
				app.click_color = gg.red
			}
		}
		.key_down {
			app.last_key = e.key_code.str()

			match e.key_code {
				.escape {
					ctx.quit()
				}
				// Change Color when 'C' or 'c' is pressed
				.c {
					if app.shape_color.r == 0 && app.shape_color.b == 255 { // blue -> red
						app.shape_color = gg.red
					} else if app.shape_color.r == 255 && app.shape_color.g == 0 { // red -> green
						app.shape_color = gg.green
					} else { // green -> blue
						app.shape_color = gg.blue
					}
				}
				// Toggle shape type when 'S' or 's' is pressed
				.s {
					app.active_shape = (app.active_shape + 1) % 3
				}
				// Use Arrow Keys to move the active shape
				.left {
					app.shape_x -= 15.0
					if app.shape_x < 0 { app.shape_x = 0 }
				}
				.right {
					app.shape_x += 15.0
					if app.shape_x > app.width { app.shape_x = f32(app.width) }
				}
				.up {
					app.shape_y -= 15.0
					if app.shape_y < 80 { app.shape_y = 80 } // Keep below divider line
				}
				.down {
					app.shape_y += 15.0
					if app.shape_y > app.height { app.shape_y = f32(app.height) }
				}
				else {}
			}
		}
		else {}
}
}
```

#### Case Study: MindSpace Journal (Real-World Application)

A great real-world example of using V's `gg` module for a complete GUI application is [MindSpace Journal](https://github.com/codecaine-zz/MindSpace-Journal).

MindSpace Journal is a sleek, local-first personal journaling application built from scratch on V's hardware-accelerated canvas (`gg`/`sokol`). It showcases the following advanced architectural patterns:

1. **Custom Widget Rendering**: Building completely custom GUI components (such as text input fields with cursor blinking and text selection, mood selectors, and scrollbars) using primitive 2D drawing calls (`draw_rect_filled`, `draw_circle_filled`, etc.).
2. **Advanced Event Routing**: Intercepting and dispatching mouse clicks, mouse moves, scroll wheels, and keyboard inputs (including character code mapping, arrow key navigation, and backspace handling) across custom widgets.
3. **Dynamic State Management**: Using a single global application state struct passed via the `user_data` pointer to handle context across all rendering and event functions.
4. **Theme Persistence**: Dynamically recalculating palettes and rendering either Light Mode or Dark Mode layouts on the fly, with configurations and window bounds saved locally via the `json` module.
5. **Local Database Serialisation**: Storing entries locally as structured JSON data by encoding and decoding structs automatically.

Check out the full repository and source code on GitHub: [MindSpace Journal Repository](https://github.com/codecaine-zz/MindSpace-Journal).

#### TOML Parser

_File location: `language_updates_and_stdlib/02_standard_library/15_toml/toml.v`_

This example demonstrates how to parse and query TOML configuration files using V's built-in `toml` module.

```v
module main

import toml

const toml_content = '
# TOML configuration example
title = "V TOML Demo"

[owner]
name = "Antigravity AI"
organization = "Google DeepMind"

[database]
server = "127.0.0.1"
ports = [ 5432, 5433 ]
connection_max = 1000
enabled = true
'

fn main() {
	println('=== TOML Module Demo ===')
	doc := toml.parse_text(toml_content) or {
		println('Failed to parse TOML: ${err}')
		return
	}

	// 1. Reading basic values using value() and type converters
	title := doc.value('title').string()
	println('Project Title: ${title}')

	// 2. Accessing nested tables
	owner_name := doc.value('owner.name').string()
	org := doc.value('owner.organization').string()
	println('Owner: ${owner_name} (${org})')

	// 3. Accessing primitive values
	server := doc.value('database.server').string()
	conn_max := doc.value('database.connection_max').int()
	enabled := doc.value('database.enabled').bool()
	println('DB Server: ${server} | Connection Max: ${conn_max} | Enabled: ${enabled}')

	// 4. Retrieving array values
	ports_any := doc.value('database.ports')
	println('Ports Any: ${ports_any}')
	
	// Accessing array elements with query syntax
	port_0 := doc.value('database.ports[0]').int()
	port_1 := doc.value('database.ports[1]').int()
	println('Primary Port: ${port_0} | Secondary Port: ${port_1}')

	// 5. Using default values for non-existing keys
	db_timeout := doc.value('database.timeout').default_to(30).int()
	println('Database Timeout (Default): ${db_timeout} seconds')

	// 6. Optional retrieval using value_opt()
	if db_server := doc.value_opt('database.server') {
		println('Optional check: Database server key exists. Value = ${db_server.string()}')
	} else {
		println('Optional check: Database server key does not exist.')
	}
}
```

#### Strconv (String Conversion)

_File location: `language_updates_and_stdlib/02_standard_library/16_strconv/strconv.v`_

This example demonstrates how to convert strings to numbers, parse numbers in different bases and bit-sizes, and convert numbers back to base string representations using the `strconv` module.

```v
module main

import strconv

fn main() {
	println('=== strconv Module Demo ===')

	// 1. Convert string to integer types (with error propagation/handling)
	val_int := strconv.atoi('12345') or {
		println('Error parsing int: ${err}')
		0
	}
	println('Parsed int: ${val_int}')

	val_i64 := strconv.atoi64('9223372036854775807') or {
		println('Error parsing i64: ${err}')
		0
	}
	println('Parsed i64: ${val_i64}')

	// 2. Parse unsigned and specific bases/bit-sizes
	// parse_int(s string, base int, bit_size int) !i64
	val_hex := strconv.parse_int('0xff', 0, 64) or {
		println('Error parsing hex: ${err}')
		0
	}
	println('Parsed hex (0xff in base 0): ${val_hex}')

	val_bin := strconv.parse_uint('101010', 2, 32) or {
		println('Error parsing binary: ${err}')
		0
	}
	println('Parsed binary (101010 in base 2): ${val_bin}')

	// 3. Convert string to float (atof64)
	val_f64 := strconv.atof64('3.14159265') or {
		println('Error parsing f64: ${err}')
		0.0
	}
	println('Parsed float64: ${val_f64}')

	// 4. Convert number to base string representation
	// format_int(n i64, radix int) string
	binary_str := strconv.format_int(42, 2)
	hex_str := strconv.format_int(255, 16)
	println('42 in binary: ${binary_str}')
	println('255 in hex:   ${hex_str}')
}
```

#### Terminal Styling

_File location: `language_updates_and_stdlib/02_standard_library/17_term/term.v`_

This example demonstrates styling terminal output (bold, underline, strikethrough), coloring foreground and background text, and retrieving the terminal size using the `term` module.

```v
module main

import term

fn main() {
	println('=== term Module Demo ===')

	// 1. Get terminal size
	width, height := term.get_terminal_size()
	println('Terminal size: ${width} columns x ${height} rows')

	// 2. Colored text helpers
	println(term.green('This text is green!'))
	println(term.red('This text is red!'))
	println(term.yellow('This text is yellow!'))
	println(term.blue('This text is blue!'))

	// 3. Text styling modifiers
	println(term.bold('This text is bold!'))
	println(term.underline('This text is underlined!'))
	println(term.strikethrough('This text has a strikethrough!'))

	// 4. Background styling
	println(term.bg_blue(' This has a blue background! '))

	// 5. Message box helper formats
	println(term.ok_message('Operation succeeded!'))
	println(term.warn_message('This is a warning!'))
	println(term.fail_message('Operation failed!'))
}
```

#### Benchmark Testing

_File location: `language_updates_and_stdlib/02_standard_library/18_benchmark/benchmark.v`_

This example demonstrates timing code execution chunks and step-by-step progress benchmarking using the `benchmark` module.

```v
module main

import benchmark
import time

fn main() {
	println('=== benchmark Module Demo ===')

	// Example 1: Using benchmark.start() and measure()
	println('--- Simple Measurement ---')
	mut b := benchmark.start()
	
	// Simulate work chunk 1
	time.sleep(50 * time.millisecond)
	b.measure('Simulated task 1 (50ms sleep)')

	// Simulate work chunk 2
	time.sleep(100 * time.millisecond)
	b.measure('Simulated task 2 (100ms sleep)')

	// Example 2: Using structured new_benchmark()
	println('\n--- Structured Step-by-Step Benchmarking ---')
	mut bmark := benchmark.new_benchmark()
	
	// Step 1: Ok step
	bmark.step()
	time.sleep(30 * time.millisecond)
	bmark.ok()
	println(bmark.step_message('Step 1 (successful arithmetic)'))

	// Step 2: Failed step demo
	bmark.step()
	time.sleep(10 * time.millisecond)
	bmark.fail()
	println(bmark.step_message('Step 2 (simulated failure verification)'))

	// Finalize and print results summary
	bmark.stop()
	println(bmark.total_message('Final summary of execution stages'))
}
```

#### Clipboard Access

_File location: `language_updates_and_stdlib/02_standard_library/19_clipboard/clipboard.v`_

This example demonstrates writing to and reading from the system clipboard on macOS using the `clipboard` module, including a backup and restore mechanism.

```v
module main

import clipboard

fn main() {
	println('=== clipboard Module Demo ===')

	// 1. Initialize clipboard
	mut cb := clipboard.new()
	defer {
		cb.destroy()
	}

	if !cb.is_available() {
		println('Clipboard is not available on this platform/session.')
		return
	}

	// 2. Backup current clipboard content so we do not overwrite user data permanently
	original_text := cb.paste()
	println('Backed up original clipboard text (length: ${original_text.len})')

	// 3. Copy new text to clipboard
	test_message := 'Hello from Vlang standard library!'
	println('Copying text to clipboard: "${test_message}"')
	if cb.copy(test_message) {
		println('Text successfully copied!')
	} else {
		println('Failed to copy text.')
	}

	// 4. Paste back to verify
	pasted_text := cb.paste()
	println('Pasted text from clipboard:  "${pasted_text}"')

	// 5. Restore original clipboard content
	println('Restoring original clipboard content...')
	cb.copy(original_text)
	println('Clipboard restore completed successfully.')
}
```

#### Semantic Versioning

_File location: `language_updates_and_stdlib/02_standard_library/20_semver/semver.v`_

This example demonstrates parsing semantic versions and checking constraint satisfaction using the `semver` module.

```v
module main

import semver

fn main() {
	println('=== semver Module Demo ===')

	// 1. Parsing semver strings
	v1 := semver.from('1.5.0-beta.1+build.123') or {
		println('Failed to parse version: ${err}')
		return
	}
	v2 := semver.from('1.5.0') or {
		println('Failed to parse version: ${err}')
		return
	}
	v3 := semver.from('2.0.0-rc.1') or {
		println('Failed to parse version: ${err}')
		return
	}

	// 2. Accessing parts of the version struct
	println('Version 1 components:')
	println('  Raw string: ${v1.str()}')
	println('  Major:      ${v1.major}')
	println('  Minor:      ${v1.minor}')
	println('  Patch:      ${v1.patch}')
	println('  Prerelease: ${v1.prerelease}')
	println('  Build info: ${v1.metadata}')

	// 3. Comparisons using relational operators
	println('\nVersion Comparisons:')
	println('  ${v1} < ${v2} ? -> ${v1 < v2}')
	println('  ${v2} > ${v1} ? -> ${v2 > v1}')
	println('  ${v3} >= ${v2} ? -> ${v3 >= v2}')

	// 4. Checking against version ranges (constraints)
	println('\nVersion Constraint Satisfactions:')
	// Range checking
	println('  Is ${v2} in range ">=1.0.0 <2.0.0" ? -> ${v2.satisfies('>=1.0.0 <2.0.0')}')
	println('  Is ${v3} in range ">=1.0.0 <2.0.0" ? -> ${v3.satisfies('>=1.0.0 <2.0.0')}')
	
	// Complex constraint checking using logical OR (||)
	range_query := '^1.4.0 || >=2.0.0'
	println('  Does ${v2} satisfy "${range_query}"? -> ${v2.satisfies(range_query)}')
	println('  Does ${v3} satisfy "${range_query}"? -> ${v3.satisfies(range_query)}')
}
```

#### Maps Utility

_File location: `language_updates_and_stdlib/02_standard_library/21_maps/maps.v`_

This example demonstrates map utility functions such as filtering, converting map keys and values to arrays, inverting maps, and merging maps using the `maps` module.

```v
module main

import maps

fn main() {
	println('=== maps Module Demo ===')

	m1 := {
		'apple':  1
		'banana': 2
		'cherry': 3
	}

	// 1. Filter elements by condition
	filtered := maps.filter(m1, fn (k string, v int) bool {
		return v > 1
	})
	println('Filtered (values > 1): ${filtered}')

	// 2. Transform map entries to an array
	keys_upper := maps.to_array(m1, fn (k string, v int) string {
		return k.to_upper()
	})
	println('Transformed keys to upper array: ${keys_upper}')

	// 3. Invert map (swap keys and values)
	inverted := maps.invert(m1)
	println('Inverted map: ${inverted}')

	// 4. Construct a map from an array
	fruits := ['apple', 'banana', 'cherry']
	map_from_arr := maps.from_array(fruits)
	println('Map from array (index to element): ${map_from_arr}')

	// 5. Merge two maps
	m2 := {
		'banana': 20
		'date':   4
	}
	merged := maps.merge(m1, m2)
	println('Merged map (m2 overwrites duplicates): ${merged}')

	// 6. Merge in place (mutates the target map)
	mut mut_map := {
		'a': 1
	}
	maps.merge_in_place(mut mut_map, {'b': 2, 'c': 3})
	println('In-place merged map: ${mut_map}')
}
```

#### Context Propagation

_File location: `language_updates_and_stdlib/02_standard_library/22_context/context.v`_

This example demonstrates propagating request-scoped values, cancellation signals, and timeouts across thread boundaries using the `context` module.

```v
module main

import context
import time

fn main() {
	println('=== context Module Demo ===')

	// 1. Context with Value
	// Useful for passing metadata (e.g. Request ID) through call chains
	mut ctx_bg := context.background()
	mut ctx_val := context.with_value(ctx_bg, 'request_id', 'REQ-101')

	if req_id := ctx_val.value('request_id') {
		if req_id is string {
			println('Request ID in context: ${req_id}')
		}
	}

	// 2. Context with Cancellation
	mut ctx_cancel, cancel := context.with_cancel(mut ctx_val)
	
	// Check if canceled
	println('Before cancel - Done channel is open')
	cancel() // trigger cancellation
	
	// Select block to read from done channel
	done_ch := ctx_cancel.done()
	select {
		_ := <-done_ch {
			println('Context cancellation detected successfully!')
		}
		1 * time.second {
			println('Timeout waiting for cancellation.')
		}
	}

	// 3. Context with Timeout
	// Abandon execution after a duration
	mut ctx_timeout, cancel_timeout := context.with_timeout(mut ctx_bg, 50 * time.millisecond)
	defer {
		cancel_timeout()
	}

	println('Waiting for context timeout (50ms)...')
	start := time.now()
	timeout_ch := ctx_timeout.done()
	select {
		_ := <-timeout_ch {
			elapsed := time.since(start)
			println('Timeout triggered after ${elapsed.milliseconds()} ms!')
		}
		1 * time.second {
			println('Error: Timeout did not trigger in time.')
		}
	}
}
```

#### Net URL Parsing

_File location: `language_updates_and_stdlib/02_standard_library/23_net_urllib/net_urllib.v`_

This example demonstrates parsing URLs into components, escaping and unescaping query parameters, and encoding query parameters using the `net.urllib` module.

```v
module main

import net.urllib

fn main() {
	println('=== net.urllib Module Demo ===')

	// 1. Parsing a URL
	raw_url := 'https://user:pass@vlang.io:8080/docs/stdlib?lang=v&version=0.5.1#intro'
	println('Parsing URL: ${raw_url}')
	
	u := urllib.parse(raw_url) or {
		println('Failed to parse URL: ${err}')
		return
	}

	println('Parsed URL parts:')
	println('  Scheme:   ${u.scheme}')
	println('  Host:     ${u.host}')
	println('  Path:     ${u.path}')
	println('  Query:    ${u.raw_query}')
	println('  Fragment: ${u.fragment}')

	// 2. Query escaping and unescaping
	original_query := 'V compiler version 0.5.1 & details'
	escaped := urllib.query_escape(original_query)
	unescaped := urllib.query_unescape(escaped) or { 'failed' }

	println('\nQuery Escaping:')
	println('  Original:  ${original_query}')
	println('  Escaped:   ${escaped}')
	println('  Unescaped: ${unescaped}')

	// 3. Managing Query Parameters using urllib.Values
	println('\nManaging Query Values:')
	mut query_params := urllib.new_values()
	query_params.add('format', 'json')
	query_params.add('tags', 'programming')
	query_params.add('tags', 'tutorial')
	query_params.set('version', '0.5.1')

	// Encode to raw query string
	encoded_query := query_params.encode()
	println('  Encoded query string: ${encoded_query}')

	// Parse it back
	parsed_params := urllib.parse_query(encoded_query) or { urllib.new_values() }
	println('  Parsed format tag:    ${parsed_params.get('format') or { 'none' }}')
	println('  Parsed tags:          ${parsed_params.get_all('tags')}')
}
```

#### Net WebSockets

_File location: `language_updates_and_stdlib/02_standard_library/24_net_websocket/net_websocket.v`_

This example demonstrates spinning up a local WebSocket server, connecting a WebSocket client to it, exchanging messages, and closing the connection cleanly using the `net.websocket` module.

```v
module main

import net.websocket
import time

fn main() {
	println('=== net.websocket Module Demo ===')

	port := 30099
	uri := 'ws://localhost:${port}'

	// 1. Initialize and run a local WebSocket server in a separate thread
	mut ws_server := websocket.new_server(.ip, port, '/')
	
	ws_server.on_connect(fn (mut s websocket.ServerClient) !bool {
		println('Server: Client connecting from ${s.client_key}')
		return true
	})!

	ws_server.on_message(fn (mut ws websocket.Client, msg &websocket.Message) ! {
		if msg.opcode == .text_frame {
			payload := msg.payload.bytestr()
			println('Server received text: "${payload}"')
			
			// Echo message back to client
			ws.write_string('Echo: ' + payload)!
		}
	})

	// Run the server listening loop in a background thread
	spawn fn [mut ws_server] () {
		ws_server.listen() or {
			println('Server error: ${err}')
		}
	}()

	// Allow the server a moment to start
	time.sleep(100 * time.millisecond)

	// 2. Initialize the WebSocket client
	mut ws_client := websocket.new_client(uri) or {
		println('Client init failed: ${err}')
		return
	}

	ws_client.on_open(fn (mut c websocket.Client) ! {
		println('Client: Connection opened!')
	})

	ws_client.on_message(fn (mut c websocket.Client, msg &websocket.Message) ! {
		if msg.opcode == .text_frame {
			payload := msg.payload.bytestr()
			println('Client received text response: "${payload}"')
		}
	})

	ws_client.on_error(fn (mut c websocket.Client, error_msg string) ! {
		println('Client error: ${error_msg}')
	})

	// 3. Connect and run the client
	ws_client.connect() or {
		println('Client failed to connect: ${err}')
		return
	}

	// Start the client listen loop in a background thread
	spawn ws_client.listen()

	// 4. Send a test message
	time.sleep(50 * time.millisecond)
	msg_to_send := 'Hello WebSocket Server!'
	println('Client sending: "${msg_to_send}"')
	ws_client.write_string(msg_to_send) or {
		println('Client failed to send: ${err}')
	}

	// Wait for echo to arrive
	time.sleep(200 * time.millisecond)

	// Clean close
	println('Client closing connection...')
	ws_client.close(1000, 'Done') or {
		println('Client close error: ${err}')
	}
	time.sleep(50 * time.millisecond)
	println('WebSocket Demo finished.')
}
```

#### Net Unix Sockets

_File location: `language_updates_and_stdlib/02_standard_library/25_net/unix/net_unix.v`_

This example demonstrates Unix domain socket client-server communication using the `net.unix` module.

```v
module main

import net.unix
import os
import time

// run_server starts the Unix socket server, accepts one client connection,
// echoes back the received message, and exits.
fn run_server(socket_path string) ! {
	// Clean up any stale socket file from a previous run
	if os.exists(socket_path) {
		os.rm(socket_path)!
	}

	// Listen on the Unix socket path with default options
	mut listener := unix.listen_stream(socket_path, unix.ListenOptions{}) or {
		println('Server: Failed to listen on ${socket_path}: ${err}')
		return err
	}
	defer {
		listener.close() or {}
		listener.unlink() or {}
	}

	println('Server: Listening on socket path: ${socket_path}')

	// Accept an incoming connection
	mut conn := listener.accept() or {
		println('Server: Failed to accept connection: ${err}')
		return err
	}
	defer {
		conn.close() or {}
	}

	println('Server: Client connected!')

	// Read client's message
	mut buf := []u8{len: 1024}
	n := conn.read(mut buf) or {
		println('Server: Read failed: ${err}')
		return err
	}

	message := buf[..n].bytestr()
	println('Server: Received message: "${message}"')

	// Write response back to the client
	response := 'Echo: ${message}'
	conn.write(response.bytes()) or {
		println('Server: Write failed: ${err}')
		return err
	}
	println('Server: Sent echo response.')
}

// run_client connects to the Unix socket server, sends a message,
// reads the echo response, and closes the connection.
fn run_client(socket_path string) ! {
	println('Client: Connecting to ${socket_path}...')
	mut conn := unix.connect_stream(socket_path) or {
		println('Client: Failed to connect: ${err}')
		return err
	}
	defer {
		conn.close() or {}
	}

	println('Client: Connected!')

	// Send message to the server
	message := 'Hello V Unix Domain Sockets!'
	println('Client: Sending message: "${message}"')
	conn.write(message.bytes()) or {
		println('Client: Write failed: ${err}')
		return err
	}

	// Read server response
	mut buf := []u8{len: 1024}
	n := conn.read(mut buf) or {
		println('Client: Read failed: ${err}')
		return err
	}

	response := buf[..n].bytestr()
	println('Client: Received response: "${response}"')
}

fn main() {
	println('=== net.unix Module Demo ===')
	
	// Create a unique temporary socket path
	socket_path := os.join_path(os.temp_dir(), 'v_unix_socket_example')

	// Spawn the server in a background thread
	spawn fn (path string) {
		run_server(path) or {
			println('Server thread failed: ${err}')
		}
	}(socket_path)

	// Allow the server thread a short time to start and bind
	time.sleep(100 * time.millisecond)

	// Run the client in the main thread
	run_client(socket_path) or {
		println('Client failed: ${err}')
	}

	// Give the server a small window to finish deferred cleanups
	time.sleep(50 * time.millisecond)
	println('Unix Sockets Demo finished.')
}
```

#### HTML Parsing

_File location: `language_updates_and_stdlib/02_standard_library/25_net/html/net_html.v`_

This example demonstrates parsing HTML strings, querying tags by class name and attribute values, and extracting node text and properties using the `net.html` module.

```v
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
```

#### JSON-RPC 2.0

_File location: `language_updates_and_stdlib/02_standard_library/25_net/jsonrpc/net_jsonrpc.v`_

This example demonstrates implementing JSON-RPC 2.0 servers and clients using V's `net.jsonrpc` module, utilizing a Unix domain socket connection as the transport layer.

```v
module main

import net.unix
import net.jsonrpc
import os
import time

// Define structs for request parameters and response results
struct MathParams {
pub:
	a int
	b int
}

struct MathResult {
pub:
	sum        int
	difference int
}

// Router handler to compute mathematical operations
fn handle_math(req &jsonrpc.Request, mut wr jsonrpc.ResponseWriter) {
	// Decode request parameters into MathParams struct
	params := req.decode_params[MathParams]() or {
		wr.write_error(jsonrpc.invalid_params)
		return
	}

	result := MathResult{
		sum:        params.a + params.b
		difference: params.a - params.b
	}

	// Write the successful result back
	wr.write(result)
}

// Start JSON-RPC 2.0 Server over Unix Socket
fn run_rpc_server(socket_path string) ! {
	// Ensure cleanup of any old socket file
	if os.exists(socket_path) {
		os.rm(socket_path)!
	}

	mut listener := unix.listen_stream(socket_path, unix.ListenOptions{}) or {
		println('Server: Failed to listen: ${err}')
		return err
	}
	defer {
		listener.close() or {}
		listener.unlink() or {}
	}

	println('Server: Listening and waiting for connections...')

	// Accept client connection
	mut conn := listener.accept() or {
		println('Server: Accept failed: ${err}')
		return err
	}
	defer {
		conn.close() or {}
	}

	println('Server: Client connected, initiating JSON-RPC protocol.')

	// Setup JSON-RPC router and register math method
	mut router := jsonrpc.Router{}
	router.register('math.compute', handle_math)

	// Create JSON-RPC server wrapping the Unix socket connection stream
	mut server := jsonrpc.new_server(jsonrpc.ServerConfig{
		stream:  conn
		handler: router.handle_jsonrpc
	})

	// Process incoming request and respond
	server.respond() or {
		println('Server: Error processing request: ${err}')
		return err
	}
	println('Server: Successfully processed request and shut down.')
}

// Start JSON-RPC 2.0 Client over Unix Socket
fn run_rpc_client(socket_path string) ! {
	println('Client: Connecting to server at ${socket_path}...')
	mut conn := unix.connect_stream(socket_path) or {
		println('Client: Connection failed: ${err}')
		return err
	}
	defer {
		conn.close() or {}
	}

	// Create JSON-RPC client wrapping the Unix socket connection stream
	mut client := jsonrpc.new_client(jsonrpc.ClientConfig{
		stream: conn
	})

	params := MathParams{
		a: 45
		b: 17
	}

	println('Client: Sending request "math.compute" with params {a: ${params.a}, b: ${params.b}}')

	// Execute JSON-RPC request (method, parameters, request ID)
	resp := client.request('math.compute', params, 'req_math_1') or {
		println('Client: Request execution failed: ${err}')
		return err
	}

	// Decode response result
	result := resp.decode_result[MathResult]() or {
		println('Client: Failed to decode response result: ${err}')
		return err
	}

	println('Client received response:')
	println('  Request ID: ${resp.id}')
	println('  Result sum:        ${result.sum}')
	println('  Result difference: ${result.difference}')
}

fn main() {
	println('=== net.jsonrpc Module Demo ===')
	socket_path := os.join_path(os.temp_dir(), 'v_jsonrpc_example_socket')

	// Spawn JSON-RPC server in background thread
	spawn fn (path string) {
		run_rpc_server(path) or {
			println('Server thread failed: ${err}')
		}
	}(socket_path)

	// Wait briefly for the server socket to bind
	time.sleep(100 * time.millisecond)

	// Run JSON-RPC client in main thread
	run_rpc_client(socket_path) or {
		println('Client thread failed: ${err}')
	}

	// Wait briefly for server post-handling cleanups
	time.sleep(50 * time.millisecond)
	println('JSON-RPC Demo finished.')
}
```


#### Tar Archiving

_File location: `language_updates_and_stdlib/02_standard_library/26_archive_tar/archive_tar.v`_

This example demonstrates reading and inspecting the contents of `.tar.gz` files using the `archive.tar` module.

```v
module main

import archive.tar
import os

// CustomReader implements the tar.Reader interface
struct CustomReader {
pub mut:
	files_found int
}

fn (mut cr CustomReader) dir_block(mut read tar.Read, size u64) {
	println('Directory in tar: ${read.get_path()}')
}

fn (mut cr CustomReader) file_block(mut read tar.Read, size u64) {
	println('File in tar:      ${read.get_path()} (${size} bytes)')
	cr.files_found++
}

fn (mut cr CustomReader) data_block(mut read tar.Read, data []u8, pending int) {
	// Trim content bytes to display them cleanly
	content := data.bytestr().trim_space()
	println('  Content snippet: "${content}"')
}

fn (mut cr CustomReader) other_block(mut read tar.Read, details string) {
	// Ignore details for this demo
}

fn main() {
	println('=== archive.tar Module Demo ===')

	// 1. Create a dummy file to archive
	temp_file := 'temp_file_for_tar.txt'
	os.write_file(temp_file, 'Hello standard archive tar from Vlang!') or {
		println('Failed to write temp file: ${err}')
		return
	}
	defer {
		os.rm(temp_file) or {}
	}

	// 2. Create the tar.gz archive using system tar
	tar_archive := 'temp_archive.tar.gz'
	println('Creating tar archive using system tar...')
	tar_cmd := if os.user_os() == 'macos' { 'COPYFILE_DISABLE=1 tar -czf' } else { 'tar -czf' }
	os.execute('${tar_cmd} ${tar_archive} ${temp_file}')
	defer {
		os.rm(tar_archive) or {}
	}

	// 3. Read and parse the tar.gz archive using V's archive.tar module
	println('Reading archive using vlib/archive/tar:')
	mut reader := CustomReader{}
	
	// Read and parse
	tar.read_tar_gz_file(tar_archive, reader) or {
		println('Failed to read tar archive: ${err}')
		return
	}

	println('Total files found in archive: ${reader.files_found}')
}
```

#### Gzip Compression

_File location: `language_updates_and_stdlib/02_standard_library/27_compress/gzip/compress_gzip.v`_

This example demonstrates compressing and decompressing binary or text data using the `compress.gzip` module.

```v
module main

import compress.gzip

fn main() {
	println('=== compress.gzip Module Demo ===')

	// 1. Original text data
	original_text := 'V programming language standard library gzip compression and decompression demonstration. This string is long enough to show compression.'
	println('Original Text length: ${original_text.len} bytes')

	// 2. Compress the data
	compressed_bytes := gzip.compress(original_text.bytes()) or {
		println('Compression failed: ${err}')
		return
	}
	println('Compressed size:      ${compressed_bytes.len} bytes')

	// 3. Decompress the data
	decompressed_bytes := gzip.decompress(compressed_bytes) or {
		println('Decompression failed: ${err}')
		return
	}
	println('Decompressed size:    ${decompressed_bytes.len} bytes')

	// 4. Convert back to string and verify
	decompressed_text := decompressed_bytes.bytestr()
	println('Decompressed text equals original? -> ${decompressed_text == original_text}')
	println('Decompressed Text: "${decompressed_text}"')
}
```

#### Deflate Compression

_File location: `language_updates_and_stdlib/02_standard_library/27_compress/deflate/compress_deflate.v`_

This example demonstrates standard Deflate byte stream compression and decompression using the `compress.deflate` module.

```v
module main

import compress.deflate

fn main() {
	println('=== compress.deflate Module Demo ===')

	// 1. Data to compress
	original_text := 'V programming language standard library deflate compression demo. Deflate is a lossless data compression algorithm.'
	println('Original Text length: ${original_text.len} bytes')

	// 2. Compress the data using deflate.compress
	compressed_bytes := deflate.compress(original_text.bytes()) or {
		println('Compression failed: ${err}')
		return
	}
	println('Compressed size:      ${compressed_bytes.len} bytes')

	// 3. Decompress the data using deflate.decompress
	decompressed_bytes := deflate.decompress(compressed_bytes) or {
		println('Decompression failed: ${err}')
		return
	}
	println('Decompressed size:    ${decompressed_bytes.len} bytes')

	// 4. Verify the result
	decompressed_text := decompressed_bytes.bytestr()
	println('Decompressed text equals original? -> ${decompressed_text == original_text}')
	println('Decompressed Text: "${decompressed_text}"')
}
```

#### Zlib Compression

_File location: `language_updates_and_stdlib/02_standard_library/27_compress/zlib/compress_zlib.v`_

This example demonstrates standard Zlib byte stream compression and decompression using the `compress.zlib` module.

```v
module main

import compress.zlib

fn main() {
	println('=== compress.zlib Module Demo ===')

	// 1. Data to compress
	original_text := 'V programming language standard library zlib compression demo. Zlib uses the deflate algorithm with headers and checksum.'
	println('Original Text length: ${original_text.len} bytes')

	// 2. Compress the data using zlib.compress
	compressed_bytes := zlib.compress(original_text.bytes()) or {
		println('Compression failed: ${err}')
		return
	}
	println('Compressed size:      ${compressed_bytes.len} bytes')

	// 3. Decompress the data using zlib.decompress
	decompressed_bytes := zlib.decompress(compressed_bytes) or {
		println('Decompression failed: ${err}')
		return
	}
	println('Decompressed size:    ${decompressed_bytes.len} bytes')

	// 4. Verify the result
	decompressed_text := decompressed_bytes.bytestr()
	println('Decompressed text equals original? -> ${decompressed_text == original_text}')
	println('Decompressed Text: "${decompressed_text}"')
}
```

#### Zstd Compression

_File location: `language_updates_and_stdlib/02_standard_library/27_compress/zstd/compress_zstd.v`_

This example demonstrates Zstd compression and decompression using the fast Facebook Zstandard algorithm in the `compress.zstd` module.

```v
module main

import compress.zstd

fn main() {
	println('=== compress.zstd Module Demo ===')

	// 1. Check version details
	version := zstd.version_string()
	println('ZSTD Library Version: ${version}')

	// 2. Data to compress
	original_text := 'Zstd, short for Zstandard, is a fast lossless compression algorithm developed by Facebook. It offers high compression ratios.'
	println('\nOriginal Text length: ${original_text.len} bytes')

	// 3. Compress using zstd.compress (specifying standard parameters)
	compressed_bytes := zstd.compress(original_text.bytes(), compression_level: 3) or {
		println('Compression failed: ${err}')
		return
	}
	println('Compressed size:      ${compressed_bytes.len} bytes')

	// 4. Decompress using zstd.decompress
	decompressed_bytes := zstd.decompress(compressed_bytes) or {
		println('Decompression failed: ${err}')
		return
	}
	println('Decompressed size:    ${decompressed_bytes.len} bytes')

	// 5. Verify and display result
	decompressed_text := decompressed_bytes.bytestr()
	println('Decompressed text equals original? -> ${decompressed_text == original_text}')
	println('Decompressed Text: "${decompressed_text}"')
}
```

#### Szip Archive

_File location: `language_updates_and_stdlib/02_standard_library/27_compress/szip/compress_szip.v`_

This example demonstrates packaging multiple files into zip archives recursively, inspecting zip contents/meta-data (size, CRC32), and extracting zip files to folders using the `compress.szip` module.

```v
module main

import os
import compress.szip

fn main() {
	println('=== compress.szip Module Demo ===')

	zip_filename := 'demo_archive.zip'
	dest_dir := 'extracted_demo'

	// Ensure cleanup of any temp files/folders
	defer {
		os.rm(zip_filename) or {}
		os.rmdir_all(dest_dir) or {}
		println('\nCleaned up archive and extraction folder.')
	}

	println('\n--- 1. Creating a Zip Archive ---')
	// Open a new zip archive for writing (creating it)
	mut archive := szip.open(zip_filename, .default_compression, .write) or {
		println('Failed to create zip: ${err}')
		return
	}

	// Add first file entry
	archive.open_entry('first_file.txt') or {
		println('Failed to open entry: ${err}')
		return
	}
	archive.write_entry('Hello from the first file inside our zip archive!'.bytes()) or {
		println('Failed to write entry: ${err}')
		return
	}
	archive.close_entry()

	// Add second file entry
	archive.open_entry('docs/second_file.txt') or {
		println('Failed to open entry: ${err}')
		return
	}
	archive.write_entry('This is a second file nested inside a docs directory.'.bytes()) or {
		println('Failed to write entry: ${err}')
		return
	}
	archive.close_entry()

	// Close the zip file
	archive.close()
	println('Successfully created zip archive "${zip_filename}" with 2 entries.')

	println('\n--- 2. Inspecting the Zip Archive ---')
	// Open zip file in read-only mode to inspect its contents
	mut reader := szip.open(zip_filename, .default_compression, .read_only) or {
		println('Failed to open zip for reading: ${err}')
		return
	}
	
	total_entries := reader.total() or { 0 }
	println('Total entries found in zip: ${total_entries}')

	// Inspect first entry details
	reader.open_entry_by_index(0) or {
		println('Failed to open entry 0: ${err}')
		return
	}
	name := reader.name()
	size := reader.size()
	crc := reader.crc32()
	println('Entry 0 details -> Name: "${name}", Size: ${size} bytes, CRC32: ${crc}')
	reader.close_entry()
	reader.close()

	println('\n--- 3. Extracting Zip Archive contents to Directory ---')
	os.mkdir(dest_dir) or {
		println('Failed to create destination directory: ${err}')
		return
	}

	// Extract the full archive to the target folder
	success := szip.extract_zip_to_dir(zip_filename, dest_dir) or {
		println('Extraction failed: ${err}')
		return
	}

	if success {
		println('Successfully extracted all entries to folder "${dest_dir}".')
		// Read and display content from extracted files
		file1_content := os.read_file(os.join_path(dest_dir, 'first_file.txt')) or { '' }
		file2_content := os.read_file(os.join_path(dest_dir, 'docs', 'second_file.txt')) or { '' }
		println('Extracted first_file.txt: "${file1_content}"')
		println('Extracted docs/second_file.txt: "${file2_content}"')
	} else {
		println('Extraction reported failure.')
	}
}
```


#### IO Stream Interfaces

_File location: `language_updates_and_stdlib/02_standard_library/28_io/io.v`_

This example demonstrates implementing custom Reader and Writer structs and using the `io.cp` utility to copy data between streams using the `io` module.

```v
module main

import io

// SimpleReader implements the io.Reader interface
struct SimpleReader {
	data string
mut:
	pos int
}

fn (mut sr SimpleReader) read(mut buf []u8) !int {
	if sr.pos >= sr.data.len {
		// Return io.Eof when the end of the stream is reached
		return io.Eof{}
	}
	mut bytes_read := 0
	for sr.pos < sr.data.len && bytes_read < buf.len {
		buf[bytes_read] = sr.data[sr.pos]
		sr.pos++
		bytes_read++
	}
	return bytes_read
}

// SimpleWriter implements the io.Writer interface
struct SimpleWriter {
mut:
	buf []u8
}

fn (mut sw SimpleWriter) write(buf []u8) !int {
	sw.buf << buf
	return buf.len
}

fn main() {
	println('=== io Module Demo ===')

	// 1. Initialize Reader and Writer
	mut reader := SimpleReader{
		data: 'Vlang standard library: io package demo.'
	}
	mut writer := SimpleWriter{}

	// 2. Use io.cp to copy data from Reader to Writer
	println('Copying data from custom Reader to custom Writer via io.cp...')
	io.cp(mut reader, mut writer) or {
		println('Error copying data: ${err}')
		return
	}

	// 3. Print the written data
	written_str := writer.buf.bytestr()
	println('Writer received: "${written_str}"')
}
```

#### File System IO

_File location: `language_updates_and_stdlib/02_standard_library/28_io/fs/io_fs.v`_

This example demonstrates how `os.File` implements `io.Reader` and `io.Writer` interfaces, allowing standard file operations to utilize stream-oriented utilities like `io.cp` and `io.BufferedReader`.

```v
module main

import os
import io

fn main() {
	println('=== io & File System (os.File) Demo ===')

	src_path := 'temp_src_file.txt'
	dst_path := 'temp_dst_file.txt'

	// Ensure files are cleaned up on completion
	defer {
		os.rm(src_path) or {}
		os.rm(dst_path) or {}
		println('\nCleaned up temporary files.')
	}

	println('\n--- 1. Creating and Writing to File via io.Writer ---')
	// os.create returns an os.File struct, which implements the io.Writer interface.
	mut src_file := os.create(src_path) or {
		println('Failed to create file: ${err}')
		return
	}
	
	// Write data using the io.Writer write() method
	content_to_write := 'Hello! This is a file system demo.\nIt demonstrates how os.File integrates with the io module.\n'
	written_bytes := src_file.write(content_to_write.bytes()) or {
		println('Failed to write to file: ${err}')
		return
	}
	println('Wrote ${written_bytes} bytes to "${src_path}" using the io.Writer interface.')
	src_file.close()

	println('\n--- 2. Reading from File via io.BufferedReader ---')
	// os.open opens a file for reading, returning an os.File (which implements io.Reader).
	mut read_file := os.open(src_path) or {
		println('Failed to open file: ${err}')
		return
	}

	// Wrap os.File in io.BufferedReader for convenient line-by-line reading
	mut buf_reader := io.new_buffered_reader(reader: read_file)
	
	// Read lines until EOF
	for {
		line := buf_reader.read_line() or {
			break
		}
		println('Buffered Read Line: "${line}"')
	}
	read_file.close()

	println('\n--- 3. Copying File Contents using io.cp ---')
	// Re-open source file for reading (implements io.Reader)
	mut src_to_copy := os.open(src_path) or {
		println('Failed to open source file: ${err}')
		return
	}
	defer { src_to_copy.close() }

	// Create a new destination file for writing (implements io.Writer)
	mut dst_file := os.create(dst_path) or {
		println('Failed to create destination file: ${err}')
		return
	}
	defer { dst_file.close() }

	// Copy all contents from reader to writer using io.cp
	io.cp(mut src_to_copy, mut dst_file) or {
		println('Failed to copy file content: ${err}')
		return
	}
	// Explicitly close files so data is flushed and readable
	src_to_copy.close()
	dst_file.close()
	println('Copied content from "${src_path}" to "${dst_path}" via io.cp.')

	// Verify the destination file contents
	copied_content := os.read_file(dst_path) or {
		println('Failed to read destination file: ${err}')
		return
	}
	println('Copied File Contents:\n${copied_content.trim_space()}')
}
```

#### IO Utilities

_File location: `language_updates_and_stdlib/02_standard_library/28_io/util/io_util.v`_

This example demonstrates using the `io.util` module for creating, writing to, reading from, and cleaning up temporary files and directories.

```v
module main

import os
import io.util

fn main() {
	println('=== io.util Module Demo ===')

	println('\n--- 1. Creating a Temporary File ---')
	// Create a temporary file. The '*' character in the pattern is replaced by a random number.
	// tfo.path defaults to the system temp directory if not specified.
	mut temp_file, temp_file_path := util.temp_file(pattern: 'v_guide_demo_*.txt') or {
		println('Failed to create temp file: ${err}')
		return
	}
	// Close the returned file handle immediately so we can open it with a clean write mode
	temp_file.close()

	defer {
		os.rm(temp_file_path) or {}
		println('Cleaned up temporary file: ${temp_file_path}')
	}
	println('Created temporary file at: ${temp_file_path}')

	// Reopen the temp file for writing explicitly
	mut f := os.open_file(temp_file_path, 'w') or {
		println('Failed to open temp file for writing: ${err}')
		return
	}

	// Write content into the temporary file
	f.write('This is some temporary data written to a temp file.'.bytes()) or {
		println('Failed to write to temp file: ${err}')
		f.close()
		return
	}
	f.close() // Close file to flush buffer and allow reading

	// Read content to verify
	content := os.read_file(temp_file_path) or {
		println('Failed to read temp file: ${err}')
		return
	}
	println('Temp file content: "${content}"')

	println('\n--- 2. Creating a Temporary Directory ---')
	// Create a temporary directory using a pattern
	temp_dir_path := util.temp_dir(pattern: 'v_guide_dir_*') or {
		println('Failed to create temp directory: ${err}')
		return
	}
	
	// Register cleanup on function exit
	defer {
		os.rmdir_all(temp_dir_path) or {}
		println('Cleaned up temporary directory: ${temp_dir_path}')
	}
	println('Created temporary directory at: ${temp_dir_path}')

	// Create a sub-file inside the temporary directory
	sub_file_path := os.join_path(temp_dir_path, 'sub_file.txt')
	os.write_file(sub_file_path, 'Data saved inside temporary directory.') or {
		println('Failed to create sub-file: ${err}')
		return
	}
	println('Created sub-file: ${sub_file_path}')

	// List files in the temporary directory to verify
	dir_files := os.ls(temp_dir_path) or {
		println('Failed to list temp directory: ${err}')
		return
	}
	println('Temporary directory contents: ${dir_files}')
}
```

#### Hash Functions

_File location: `language_updates_and_stdlib/02_standard_library/29_hash/hash.v`_

This example demonstrates calculating FNV-1a (32-bit and 64-bit) hashes and CRC32 checksums using the `hash` module.

```v
module main

import hash.fnv1a
import hash.crc32

fn main() {
	println('=== hash Module Demo ===')

	input := 'V language standard library'
	println('Input string: "${input}"')

	// 1. FNV-1a 32-bit and 64-bit string hashing
	fnv_32 := fnv1a.sum32_string(input)
	fnv_64 := fnv1a.sum64_string(input)
	println('FNV-1a 32-bit hash: ${fnv_32}')
	println('FNV-1a 64-bit hash: ${fnv_64}')

	// 2. CRC32 IEEE checksum
	crc_val := crc32.sum(input.bytes())
	println('CRC32 checksum:     ${crc_val}')
}
```

#### Bitfield Manipulation

_File location: `language_updates_and_stdlib/02_standard_library/30_bitfield/bitfield.v`_

This example demonstrates creating bitfields, getting/setting individual bits, performing logical operations (AND, OR, XOR, NOT), and converting to string representation using the `bitfield` module.

```v
module main

import bitfield

fn main() {
	println('=== bitfield Module Demo ===')

	// 1. Create bitfield from string
	mut bf1 := bitfield.from_str('101100')
	println('BitField 1 (from str):  ${bf1.str()}')
	println('Size of BitField 1:      ${bf1.get_size()}')
	println('Number of 1s (pop_count): ${bf1.pop_count()}')

	// 2. Accessing and modifying individual bits
	println('\nModifying individual bits:')
	println('  Bit at index 1 before:  ${bf1.get_bit(1)}')
	bf1.set_bit(1)
	println('  Bit at index 1 after set: ${bf1.get_bit(1)}')
	bf1.clear_bit(0)
	println('  Bitfield after changes: ${bf1.str()}')

	// 3. Logical bitwise operations
	mut bf2 := bitfield.from_str('011010')
	println('\nLogical operations on ${bf1.str()} and ${bf2.str()}:')
	
	and_result := bitfield.bf_and(bf1, bf2)
	or_result  := bitfield.bf_or(bf1, bf2)
	xor_result := bitfield.bf_xor(bf1, bf2)
	not_result := bitfield.bf_not(bf1)

	println('  AND: ${and_result.str()}')
	println('  OR:  ${or_result.str()}')
	println('  XOR: ${xor_result.str()}')
	println('  NOT: ${not_result.str()}')
}
```

#### CLI Command Builder

_File location: `language_updates_and_stdlib/02_standard_library/31_cli/cli.v`_

This example demonstrates building structured CLI applications with commands, subcommands, and option flags in POSIX mode using the `cli` module.

```v
module main

import cli

fn main() {
	println('=== cli Module Demo ===')

	mut app := cli.Command{
		name:        'tool'
		description: 'A sample CLI tool showing V\'s cli package.'
		version:     '1.0.0'
		posix_mode:  true
		execute:     fn (cmd cli.Command) ! {
			println('Root command execution. Use --help to see subcommands.')
		}
		commands:    [
			cli.Command{
				name:        'greet'
				description: 'Greet a user with custom options'
				posix_mode:  true
				execute:     fn (cmd cli.Command) ! {
					name := cmd.flags.get_string('name') or { 'Guest' }
					verbose := cmd.flags.get_bool('verbose') or { false }
					
					if verbose {
						println('Log: Initiating greeting process...')
					}
					println('Hello, ${name}!')
				}
				flags: [
					cli.Flag{
						flag:        .string
						name:        'name'
						abbrev:      'n'
						description: 'Name of person to greet'
					},
					cli.Flag{
						flag:        .bool
						name:        'verbose'
						abbrev:      'v'
						description: 'Enable verbose logging'
					},
				]
			},
		]
	}

	app.setup()
	
	// Test by parsing args mock
	println('\nParsing args: tool greet --name Antigravity -v')
	app.parse(['tool', 'greet', '--name', 'Antigravity', '-v'])
}
```

#### Veb Web Framework

_File location: `language_updates_and_stdlib/02_standard_library/32_veb/veb.v`_

This example demonstrates building a web application with routes, starting it in a background thread, and testing requests using the modern `veb` web framework.

```v
module main

import veb
import net.http
import time

pub struct Context {
	veb.Context
}

pub struct App {
	secret_key string
}

// Route handler
pub fn (app &App) index(mut ctx Context) veb.Result {
	return ctx.text('Hello from veb web framework!')
}

fn main() {
	println('=== veb Web Framework Demo ===')

	mut app := &App{
		secret_key: 'veb_secret_key'
	}

	port := 30088

	// Run the web server in a separate thread to avoid blocking the main execution
	spawn fn [mut app, port] () {
		println('Starting veb server on port ${port}...')
		veb.run[App, Context](mut app, port)
	}()

	// Wait for the server to spin up
	time.sleep(200 * time.millisecond)

	// Make an HTTP GET request to verify the server is running and responding
	url := 'http://localhost:${port}/'
	println('Sending request to: ${url}')
	
	resp := http.get(url) or {
		println('HTTP request failed: ${err}')
		return
	}

	println('Response Status Code: ${resp.status_code}')
	println('Response Body:        "${resp.body}"')
	println('veb server tested successfully.')
}
```

#### Readline Prompt

_File location: `language_updates_and_stdlib/02_standard_library/33_readline/readline.v`_

This example demonstrates prompting users for text input from terminal lines in a structured manner using the `readline` module.

```v
module main

import readline

fn main() {
	println('=== readline Module Demo ===')

	mut r := readline.Readline{}
	println('Simulating readline input (feed via stdin if non-interactive):')
	
	// Read a line from standard input
	line := r.read_line('Enter text: ') or {
		println('Error or EOF: ${err}')
		return
	}
	println('You entered: "${line}"')
}
```

#### Runtime System Info

_File location: `language_updates_and_stdlib/02_standard_library/34_runtime/runtime.v`_

This example demonstrates inspecting hardware specifications, processor cores, system endianness, and memory usage statistics using the `runtime` module.

```v
module main

import runtime

fn main() {
	println('=== runtime Module Demo ===')

	// 1. CPU and job info
	cpus := runtime.nr_cpus()
	jobs := runtime.nr_jobs()
	println('CPU Cores:              ${cpus}')
	println('Concurrent Jobs (VJOBS): ${jobs}')

	// 2. System architecture details
	println('Is 64-bit architecture?  ${runtime.is_64bit()}')
	println('Is 32-bit architecture?  ${runtime.is_32bit()}')
	println('Is Little Endian?        ${runtime.is_little_endian()}')
	println('Is Big Endian?           ${runtime.is_big_endian()}')

	// 3. Memory statistics
	total_mem := runtime.total_memory() or { 0 }
	free_mem := runtime.free_memory() or { 0 }
	used_mem := runtime.used_memory() or { 0 }

	// Format to megabytes
	total_mb := total_mem / (1024 * 1024)
	free_mb := free_mem / (1024 * 1024)
	used_mb := used_mem / (1024 * 1024)

	println('\nPhysical Memory info:')
	println('  Total Memory: ${total_mb} MB')
	println('  Free Memory:  ${free_mb} MB')
	println('  Used (by App): ${used_mb} MB')
}
```

#### WebAssembly (wasm) Binary Generation

_File location: `language_updates_and_stdlib/02_standard_library/35_wasm/wasm.v`_

V provides a built-in `wasm` module in its standard library that allows developers to programmatically build WebAssembly binary (`.wasm`) files directly using instruction-level builder patterns. This is extremely useful for compilers, runtime engines, or dynamic code generation targeting the browser and other WebAssembly runtimes.

This example demonstrates how to:
1. Initialize a WebAssembly module (`wasm.Module`).
2. Generate exported arithmetic functions (`add`, `sub`, `mul`).
3. Construct and read mutable global variables (`new_global`, `global_get`, `global_set`).
4. Build recursive control structures (a factorial `fac` function utilizing `c_if`, `c_else`, `c_end`, and recursive `call`).
5. Compile the module down to a `.wasm` binary slice (`[]u8`) and save it to disk.

```v
module main

import wasm
import os

fn main() {
	println('=== V WebAssembly (wasm) Module Demo ===')

	// Initialize the WebAssembly module
	mut m := wasm.Module{}
	m.enable_debug('vlang_wasm_demo')

	// --- 1. Basic Arithmetic Functions ---
	println('\n1. Generating Arithmetic Functions (add, sub, mul)...')
	
	// Exported 'add' function: taking two i32 parameters, returning one i32 result
	mut add_fn := m.new_function('add', [.i32_t, .i32_t], [.i32_t])
	{
		add_fn.local_get(0)
		add_fn.local_get(1)
		add_fn.add(.i32_t)
	}
	m.commit(add_fn, true) // commit with export = true

	// Exported 'sub' function
	mut sub_fn := m.new_function('sub', [.i32_t, .i32_t], [.i32_t])
	{
		sub_fn.local_get(0)
		sub_fn.local_get(1)
		sub_fn.sub(.i32_t)
	}
	m.commit(sub_fn, true)

	// Exported 'mul' function
	mut mul_fn := m.new_function('mul', [.i32_t, .i32_t], [.i32_t])
	{
		mul_fn.local_get(0)
		mul_fn.local_get(1)
		mul_fn.mul(.i32_t)
	}
	m.commit(mul_fn, true)


	// --- 2. Global Variables ---
	println('\n2. Creating Global Variables...')
	// Global variable named '__vsp' (Stack Pointer), internal/non-exported, type i32, mutable, init value 10
	vsp := m.new_global('__vsp', false, .i32_t, true, wasm.constexpr_value(10))
	
	// Create a function that retrieves the global value, adds 20, stores it back, and returns the new value
	mut vsp_fn := m.new_function('update_vsp', [], [.i32_t])
	{
		vsp_fn.global_get(vsp)
		vsp_fn.i32_const(20)
		vsp_fn.add(.i32_t)
		vsp_fn.global_set(vsp)
		vsp_fn.global_get(vsp)
	}
	m.commit(vsp_fn, true)


	// --- 3. Recursive Functions (Factorial) ---
	println('\n3. Generating Recursive Function (fac)...')
	// fac(n) returns n! using i64 types
	mut fac_fn := m.new_function('fac', [.i64_t], [.i64_t])
	{
		fac_fn.local_get(0)
		fac_fn.eqz(.i64_t)
		
		// If block: if n == 0, return 1
		ifs := fac_fn.c_if([], [.i64_t])
		{
			fac_fn.i64_const(1)
		}
		fac_fn.c_else(ifs)
		{
			// Else: return n * fac(n - 1)
			fac_fn.local_get(0) // push n
			
			fac_fn.local_get(0)
			fac_fn.i64_const(1)
			fac_fn.sub(.i64_t)   // n - 1
			fac_fn.call('fac')   // recursive call to fac(n - 1)
			
			fac_fn.mul(.i64_t)   // n * fac(n - 1)
		}
		fac_fn.c_end(ifs)
	}
	m.commit(fac_fn, true)


	// --- 4. Compilation & Output ---
	println('\n4. Compiling Module to WebAssembly Binary...')
	binary_code := m.compile()
	println('Compilation Successful! Binary size: ${binary_code.len} bytes')

	// Save compiled binary as output.wasm in the current directory
	dir := os.dir(@FILE)
	output_path := os.join_path(dir, 'output.wasm')
	os.write_file(output_path, binary_code.bytestr()) or {
		println('Failed to write output.wasm: ${err}')
		return
	}
	println('Saved Wasm binary to: ${output_path}')
}
```

---

## Error Handling

### Error Handling

_File location: `error_handling/error_handling.v`_

This section covers V's error handling model in depth, demonstrating how the language handles potential absence of values and errors without standard exceptions.

#### Key Mechanisms

1. **Option Types (`?T`)**:
   - Represent a value that might be absent (either `T` or `none`).
   - Defined with a `?` prefix (e.g., `?string`).
   - Propagated using the `?` suffix.
   - Handled/Unwrapped using `or { ... }` blocks (e.g., to return a fallback or perform early exit) or `if-let` binding: `if value := opt_func() { ... } else { ... }`.

2. **Result Types (`!T`)**:
   - Represent a value or an error (either `T` or an `IError`).
   - Defined with a `!` prefix (e.g., `!f64`).
   - Propagated using the `!` suffix.
   - Handled using `or { ... }` blocks, where a special, automatically-bound `err` variable of type `IError` is accessible inside the block.

3. **Custom Errors (`IError`)**:
   - V allows creating custom errors by defining a struct and embedding the builtin `Error` struct.
   - You can implement/override `msg() string` and `code() int` from the `IError` interface.
   - In handling blocks (`or`), you can dynamically check and cast the error using type guards: `if err is CustomError { ... }`. The compiler smart-casts the variable, letting you directly access custom fields (like `err.code` or `err.query`).

4. **Unrecoverable Errors (Panics)**:
   - For critical, non-recoverable runtime failures, V provides the `panic(message string)` function which prints a stack trace and immediately terminates the program.

```v
module main

// ==========================================
// Define Custom Error Types
// ==========================================

// CustomError embeds the builtin Error struct to implement the IError interface.
struct CustomError {
    Error // Required: provides default implementations of msg() and code()
    message string
    code    int
}

// Overwrite the msg() method for CustomError
fn (err CustomError) msg() string {
    return err.message
}

// Overwrite the code() method for CustomError
fn (err CustomError) code() int {
    return err.code
}

// DatabaseError represents another custom error type.
struct DatabaseError {
    Error
    query string
}

fn (err DatabaseError) msg() string {
    return 'Database error executing query: "${err.query}"'
}

// ==========================================
// 1. Option Types (?T)
// Options represent either a value of type T or nothing (none).
// ==========================================

// find_item returns a string if found, or none if not.
fn find_item(id int) ?string {
    if id == 42 {
        return 'V programming book'
    }
    return none // return absence of value
}

// find_item_wrapper demonstrates Option propagation with the `?` suffix.
fn find_item_wrapper(id int) ?string {
    // If find_item returns none, the execution stops here and propagates none up.
    item := find_item(id)? 
    return 'Found: ' + item
}

// ==========================================
// 2. Result Types (!T)
// Results represent either a value of type T or an IError.
// ==========================================

// divide performs float division but returns an error for division by zero.
fn divide(a f64, b f64) !f64 {
    if b == 0.0 {
        return error('division by zero') // Return a standard error
    }
    return a / b
}

// fetch_data returns a string or a CustomError.
fn fetch_data(success bool) !string {
    if !success {
        return CustomError{
            message: 'Connection timed out'
            code: 504
        }
    }
    return 'Raw database records'
}

// query_db returns a string or a DatabaseError.
fn query_db(query string, success bool) !string {
    if !success {
        return DatabaseError{
            query: query
        }
    }
    return 'Query success'
}

// calculate_and_format demonstrates Result propagation using the `!` operator.
fn calculate_and_format(a f64, b f64) !string {
    // The `!` suffix propagates the error to the caller if divide fails.
    res := divide(a, b)! 
    return 'Result is ${res:.2f}'
}

// ==========================================
// 3. Unrecoverable Errors (Panics)
// ==========================================
fn force_panic() {
    println('Simulating a critical failure...')
    panic('Fatal error: Out of memory or system crash.')
}

fn main() {
    println('=== 1. Option Types (?T) ===')
    
    // Option Handling: Option unwrapping using `or` block
    item_1 := find_item(42) or { 'Default Item' }
    println('Item 1 (with 42): ${item_1}')
    
    item_2 := find_item(99) or { 'Default Item' }
    println('Item 2 (with 99): ${item_2}')

    // Option Handling: Option unwrapping with variable binding using `if-let`
    if item := find_item(42) {
        println('If-let match: Found "${item}"')
    } else {
        println('If-let match: Item not found')
    }

    if item := find_item(99) {
        println('If-let match: Found "${item}"')
    } else {
        println('If-let match: Item not found (none)')
    }

    // Option Propagation Check
    wrapped_item := find_item_wrapper(99) or { 'None propagated successfully' }
    println('Propagation check: ${wrapped_item}\n')


    println('=== 2. Result Types (!T) ===')

    // Result Handling: Standard error message extraction via the `err` variable inside `or` block
    calc_success := calculate_and_format(10.0, 2.0) or { 'Error: ${err}' }
    println('Calc success: ${calc_success}')

    calc_fail := calculate_and_format(10.0, 0.0) or { 'Error: ${err}' }
    println('Calc failure: ${calc_fail}')


    println('\n=== 3. Custom Error Matching & Type Casting ===')

    // We can inspect the error type dynamically using the `is` check inside the `or` block.
    // Since fetch_data(false) returns a Result type (!string), the `or` block must either:
    // 1. Terminate control flow (e.g. using return, panic, exit)
    // 2. Evaluate to a fallback string value.
    // We use `''` (empty string) here as the fallback value to satisfy this type requirement.
    fetch_data(false) or {
        if err is CustomError {
            // Inside this block, `err` is smart-cast to CustomError automatically, 
            // allowing direct access to custom fields like `code`.
            println('Caught CustomError! Message: "${err.msg()}", Code: ${err.code}')
        } else {
            println('Caught generic error: ${err.msg()}')
        }
        '' // Fallback empty string returned to satisfy the !string return type of the or block
    }

    // Similarly, query_db returns !string, so its or block must also evaluate to a string.
    query_db('SELECT * FROM users', false) or {
        if err is DatabaseError {
            // Smart-cast to DatabaseError, accessing the `query` field
            println('Caught DatabaseError!')
            println('Query attempted: "${err.query}"')
            println('Error message:   "${err.msg()}"')
        } else {
            println('Caught generic error: ${err.msg()}')
        }
        '' // Fallback empty string returned to satisfy the !string return type of the or block
    }


    println('\n=== 4. Panic (Unrecoverable Error) ===')
    // We wrap panic execution or run it last since it terminates the process.
    // You can uncomment the line below to test panic termination:
    // force_panic()
    println('To run a panic, uncomment force_panic() in main.')
}
```

---

## Official Documentation

For comprehensive and up-to-date information about V, please refer to the official documentation:

- **[V Official Documentation](https://github.com/vlang/v/blob/master/doc/docs.md)** - Complete reference guide for the V programming language
