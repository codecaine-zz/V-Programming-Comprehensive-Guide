# The V Programming Language: A Comprehensive Textbook Guide

Welcome to the ultimate learning guide for the V programming language! This textbook is structured specifically to take you from a complete beginner (zero programming experience) to an advanced V developer capable of building high-performance, concurrent, and safe systems applications. Rather than treating V as a list of syntax rules, this guide emphasizes a practical path: learn the core ideas, run the examples, and build small projects as you go.

> [!NOTE]
> **How to read this book:** Each section starts with a clear explanation of a fundamental programming concept, followed by concrete V code examples. Every example contains the exact code from the repository, formatted in clean code blocks so you can easily copy and run them yourself.

> [!TIP]
> **Interactive Learning:** You can test any code example from this guide live in your browser using the [V Playground](https://play.vlang.io/).

## Repository Structure

This book is paired with a topic-based repository layout so it is easier to explore examples by concept. The structure is intentionally arranged in a learning sequence rather than as a flat list of files:

- `variables_and_constants/`, `primitive_types/`, and `control_flow/` for the foundation of the language
- `functions/` and `structs/` for building reusable programs and modeling data
- `error_handling/`, `modules/`, and `testing/` for reliability and organization
- `concurrency/`, `channels/`, `json_and_orm/`, `sqlite/`, and `notes_api/` for real-world applications
- `language_updates_and_stdlib/` for newer language features and grouped standard library examples that are easier to browse by topic

Following this structure makes it simpler to move from small examples to larger projects, and it also gives contributors a clear place to add new lessons.

### A better way to think about the repo

- Start with the introductory folders when you are learning V for the first time.
- Use the middle sections when you are ready to write more structured programs.
- Explore the application-oriented folders once you want to build something practical.

### Contributing new content

When adding a new lesson, keep it in the most relevant topic folder and use a numbered naming pattern such as `01_topic_name/` so the learning flow stays predictable.

## Quick Start: Learn V by Building Things

If you are new to programming, the fastest way to learn V is to start small and build something real. Follow this sequence:

1. Install V and confirm it works with `v --version`.
2. Create a file named `hello.v` with a tiny program:

```v
fn main() {
	println('Hello, V!')
}
```

3. Run it with `v run hello.v`.
4. Build an executable with `v -o hello hello.v`.

V has a few ideas that are worth remembering early:

- Variables are immutable by default, so use `mut` when you need to change a value.
- Modules help organize larger programs.
- `option` and `result` make error handling explicit.
- `spawn` and channels make concurrency approachable.

## Core Language Essentials to Learn Early

A beginner-friendly roadmap becomes much clearer when you call out the core concepts that show up again and again in V programs:

- `mut` and immutable-by-default variables
- functions, parameters, and return values
- structs and methods for modeling data
- `enum` and `match` for branching on discrete choices
- modules and imports for organizing code
- `?` and `!` for option and result types
- `defer` for cleanup work before a function exits
- `unsafe` only when you truly need low-level access
- type aliases and sum types once you are comfortable with structs and enums

These ideas form the backbone of most V programs, so it is worth learning them in a small, practical order rather than trying to memorize every feature at once.

## Must-Learn-Before-Building Checklist

Before you start a larger project, make sure you can comfortably do the following:

- write a small program with a `main` function
- declare variables and explain when to use `mut`
- define and call functions with clear parameters and return types
- model simple data with structs
- choose between `if`, `match`, and `for` for control flow
- split code into modules and import them correctly
- handle optional or failing values with `?` and `!`
- use `defer` for cleanup work when needed
- avoid `unsafe` unless you truly need it

If you can do these reliably, you are ready to move from tiny examples to real programs.

## Why This Matters

The goal is not just to memorize syntax. Each concept in this guide solves a real programming problem:

- Variables and mutability help your program store and update information safely.
- Functions let you break a program into small, reusable pieces.
- Structs help you model real-world data such as users, files, or payments.
- Error handling makes programs more predictable and easier to debug.
- Concurrency helps programs do more work efficiently when tasks can run independently.

When you learn a new feature, ask yourself: “What problem does this solve?” and “How would I use it in a small program?”

## Suggested Learning Path

A beginner-friendly path through this guide is:

- Start with Chapters 1-4 to learn the basic syntax and control flow.
- Move into functions, structs, and modules to structure your programs.
- Practice with tests and error handling before tackling larger projects.
- Finish with concurrency, JSON, and databases by building a small app.

## Next-Level Language Features to Explore

Once the basics feel natural, the next step is to expand your comfort with a few higher-level features:

- type aliases for clearer naming
- sum types for values that can be one of several shapes
- generics for reusable data structures and helpers
- interfaces for shared behavior across different types
- higher-order functions and function values
- `unsafe` and pointers only when you need low-level performance or interop

These features are not required for every beginner project, but they become very useful once you start writing more structured or reusable code.

## Mini Projects to Try

These projects will make the guide feel much more practical:

- A command-line to-do list
- A number guessing game
- A simple file organizer or text search tool
- A notes app that stores data in JSON or SQLite

## Practice Exercises

Try these small exercises as you move through the guide:

1. Write a program that prints your name and age.
2. Create a function that adds two numbers and returns the result.
3. Build a tiny program that stores a user in a struct and prints the fields.
4. Write a loop that prints the first 10 even numbers.
5. Use an `option` or `result` in a small helper function and handle the failure case.

If you get stuck, write the smallest possible version first and test it before adding more features.

## Your First Project: A Tiny CLI Greeting App

A great first project is a small command-line app that asks for a name and prints a greeting. This lets you practice variables, functions, input, and output without getting overwhelmed.

### Step 1: Start with a simple main function

```v
fn main() {
	println('Hello, V!')
}
```

### Step 2: Add a name variable

```v
fn main() {
	name := 'Ada'
	println('Hello, ' + name + '!')
}
```

### Step 3: Make it interactive

```v
import os

fn main() {
	name := os.input('What is your name? ')
	println('Hello, ' + name + '!')
}
```

### Step 4: Improve it with a function

```v
import os

fn greet(name string) string {
	return 'Hello, ' + name + '!'
}

fn main() {
	name := os.input('What is your name? ')
	println(greet(name))
}
```

### Why this project is useful

This project teaches the core flow of programming in V:

- write a small program
- test it
- add a feature
- refactor it into functions
- make the output clearer

Once this feels easy, you can extend it with a command-line option, a loop, or a saved history file.

## What Most Programmers Want Next

A strong guide should help readers move from learning syntax to building and debugging real software. The following topics are especially useful for most programmers:

### Quick Reference

- Run a file: `v run hello.v`
- Build an executable: `v -o hello hello.v`
- Use `mut` when a value needs to change
- Use functions to keep logic organized
- Use modules to split larger projects into manageable files
- Use tests to verify behavior as you grow your program

### Common Beginner Mistakes

- Forgetting to make a variable `mut` before changing it
- Mixing up declaration and assignment
- Writing code without small, testable functions
- Trying to learn too many concepts at once instead of building one small feature

### Debugging and Reading Errors

When something fails, focus on the first compiler error, reduce the problem to a smaller example, and test one change at a time. This is often faster than changing many lines at once.

### Real-World Workflow

As your projects grow, you will want to know how to:

- split code into modules
- write tests
- structure folders clearly
- read documentation and standard library examples
- move from small scripts to larger applications

## V Cheat Sheet

This cheat sheet gathers the most common V patterns in one place. Use it as a quick reference while you move from examples to small programs.

### Run and build

```bash
v run hello.v
v -o hello hello.v
```

### Practical examples programmers reach for

#### Read input and greet the user

```v
import os

fn main() {
	name := os.input('What is your name? ')
	println('Hello, ${name}!')
}
```

#### Work with strings

```v
fn main() {
	msg := 'v is simple'
	println(msg.to_upper())
	println(msg.len)
}
```

#### Read a file

```v
import os

fn main() {
	content := os.read_file('notes.txt') or { '' }
	println(content)
}
```

#### Variables and mutability

```v
fn main() {
	mut count := 0
	count++
	println(count)
}
```

- `:=` declares and initializes a variable.
- `mut` makes a variable changeable.
- Variables are immutable by default.

### Conditionals and loops

```v
fn main() {
	age := 20

	if age >= 18 {
		println('adult')
	} else {
		println('minor')
	}

	for i in 0..5 {
		println(i)
	}
}
```

### Functions

```v
fn add(a int, b int) int {
	return a + b
}
```

- Keep functions small and focused.
- Use explicit parameter and return types.

### Arrays and maps

```v
fn main() {
	nums := [1, 2, 3]
	println(nums[0])

	grades := {'alice': 90, 'bob': 85}
	println(grades['alice'])
}
```

### Structs

```v
struct User {
	name string
	age  int
}

fn main() {
	user := User{
		name: 'Ada'
		age: 36
	}
	println(user.name)
}
```

### Error handling

```v
fn maybe_value() ?int {
	return 42
}

fn main() {
	value := maybe_value() or { 0 }
	println(value)
}
```

- `?` marks a function that may fail or produce no value.
- `or {}` provides a clear fallback.

### Modules

```v
module main

import math
```

- Use modules to split larger projects into smaller files.
- Imports make standard library features available.

### Concurrency basics

```v
fn worker() {
	println('working')
}

fn main() {
	spawn worker()
}
```

### More practical examples

#### CLI arguments

```v
import os

fn main() {
	if os.args.len < 2 {
		println('Usage: v run cli_args.v <name>')
		return
	}
	println('Hello, ${os.args[1]}!')
}
```

#### JSON encode and decode with structs

```v
import json

struct User {
	name string
	age  int
}

fn main() {
	user := User{
		name: 'Ada'
		age: 36
	}
	encoded := json.encode(user)
	println(encoded)

	decoded := json.decode(User, encoded) or { User{} }
	println(decoded.name)
}
```

#### Word count with a map

```v
fn main() {
	text := 'v is simple and simple is fast'
	mut counts := map[string]int{}
	for word in text.to_lower().split(' ') {
		counts[word] = counts[word] + 1
	}
	println(counts)
}
```

#### A small channel worker

```v
fn worker(ch chan string) {
	ch <- 'done'
}

fn main() {
	ch := chan string{}
	go worker(ch)
	println(<-ch)
}
```

#### A simple test

```v
fn add(a int, b int) int {
	return a + b
}

fn test_add() {
	assert add(2, 3) == 5
}
```

#### A generic helper

```v
fn max[T](a T, b T) T {
	if a > b {
		return a
	}
	return b
}

fn main() {
	println(max(8, 3))
	println(max('z', 'a'))
}
```

#### Enum and match

```v
enum Mode {
	start
	run
	stop
}

fn describe(mode Mode) string {
	return match mode {
		.start { 'starting' }
		.run { 'running' }
		.stop { 'stopped' }
	}
}

fn main() {
	println(describe(.run))
}
```

#### Safe file reading

```v
import os

fn main() {
	content := os.read_file('notes.txt') or {
		println('Could not read notes.txt')
		return
	}
	println(content)
}
```

### Quick glossary

- `mut`: make a variable changeable
- `fn`: define a function
- `struct`: define a custom data type
- `module`: group related code together
- `?`: represent optional or failing values
- `spawn`: run work concurrently

## From Practice to Real Projects

Once the basics feel comfortable, the next step is to build small applications that combine multiple ideas. A very effective progression is:

1. Build a tiny CLI tool that reads input and prints output.
2. Add functions, structs, and tests.
3. Introduce modules so the code is easier to maintain.
4. Add file I/O or JSON handling for persistence.
5. Explore concurrency for tasks that can run in parallel.

This progression helps learners move from “I can read examples” to “I can build useful software.”

## Where to Go Next

After finishing this guide, the best next steps are:

- read the official V documentation and examples
- try the V Playground for rapid experimentation
- build one project end to end instead of reading only
- contribute to or study real V repositories for idiomatic patterns

## Beginner Project Roadmap

A practical roadmap for new V developers could look like this:

### Milestone 1: CLI App

Build a small command-line app that accepts user input and prints useful output. This helps you practice functions, variables, and control flow.

### Milestone 2: Data App

Add file I/O or JSON handling so your app can save and load data. This introduces practical patterns for real-world applications.

### Milestone 3: Structured App

Split the app into modules and add structs for data models. This is where programs become easier to maintain.

### Milestone 4: Tested App

Write tests and improve reliability. This is an important step for building confidence as a programmer.

### Milestone 5: Concurrent App

Explore concurrency with `spawn` and channels for tasks that can run in parallel. This is where V becomes especially compelling for performance-oriented software.

## Setup Checklist

Before you start coding in V, make sure you have:

- V installed and available on your terminal
- a text editor or IDE with basic syntax highlighting
- a way to run and test small programs quickly
- a folder for practice files and mini projects

## Quick Glossary

- `mut`: makes a variable changeable
- `fn`: defines a function
- `struct`: defines a custom data type
- `module`: groups related code together
- `option`/`result`: explicit ways to handle missing or failing values
- `spawn`: runs code concurrently
- `channel`: passes data between concurrent tasks

## How to Use This Guide Effectively

To get the most from this book:

1. Read the explanation first, but do not stop there.
2. Run each example locally.
3. Change one small thing and observe what happens.
4. Write your own tiny version before moving on.
5. Apply each idea in a small project as soon as possible.

## Table of Contents

- [Chapter 1: Getting Started with V](#chapter-1-getting-started-with-v)
  - [Code Comments](#code-comments)
- [Chapter 2: Variables and Constants](#chapter-2-variables-and-constants)
  - [Constants](#constants)
  - [Variables](#variables)
- [Chapter 3: Primitive Data Types](#chapter-3-primitive-data-types)
  - [Primitive Types Demo](#primitive-types-demo)
  - [Boolean Type](#boolean-type)
  - [Numeric Types](#numeric-types)
  - [Rune Type](#rune-type)
  - [String Type](#string-type)
- [Chapter 4: Control Flow](#chapter-4-control-flow)
  - [Control Flow Extras](#control-flow-extras)
- [Chapter 5: Collections: Arrays and Maps](#chapter-5-collections-arrays-and-maps)
  - [Arrays](#arrays)
  - [Maps](#maps)
- [Chapter 6: Functions](#chapter-6-functions)
  - [Advanced Function Features](#advanced-function-features)
  - [Function Extras](#function-extras)
- [Chapter 7: Structs (Custom Types)](#chapter-7-structs-custom-types)
  - [Struct Basics & Fields](#struct-basics--fields)
- [Chapter 8: Error Handling](#chapter-8-error-handling)
  - [Option & Result Types](#option--result-types)
- [Chapter 9: Organizing Code with Modules](#chapter-9-organizing-code-with-modules)
  - [Modules & Project Structure](#modules--project-structure)
  - [Installing External Packages](#installing-external-packages)
- [Chapter 10: Writing Tests in V](#chapter-10-writing-tests-in-v)
  - [Assertions & Unit Testing](#assertions--unit-testing)
- [Chapter 11: Concurrency and Channels](#chapter-11-concurrency-and-channels)
  - [Channels & Communication](#channels--communication)
  - [V-Routines & Concurrency](#v-routines--concurrency)
- [Chapter 12: Working with Databases and JSON](#chapter-12-working-with-databases-and-json)
  - [Case Study: Notes API](#case-study-notes-api)
  - [JSON & ORM](#json--orm)
  - [SQLite Integration](#sqlite-integration)
  - [SQLite CRUD Helper](#sqlite-crud-helper)
  - [Sqlite Raw Crud](#sqlite-raw-crud)
- [Chapter 13: Standard Library & Advanced Features](#chapter-13-standard-library--advanced-features)
  - [Inline Assembly & C Interop](#inline-assembly--c-interop)
  - [Networking (TCP, UDP, SSL, WebSockets)](#networking-tcp-udp-ssl-websockets)
  - [Other Stdlib Updates](#other-stdlib-updates)
  - [Strings.Lorem Helper](#stringslorem-helper)
  - [WebAssembly Compilation](#webassembly-compilation)
- [Chapter 14: Useful Boilerplates and Application Templates](#chapter-14-useful-boilerplates-and-application-templates)
  - [CLI Command-Line Application Boilerplate](#cli-command-line-application-boilerplate)
  - [REST API Server Boilerplate](#rest-api-server-boilerplate)
  - [Worker Pool Concurrency Boilerplate](#worker-pool-concurrency-boilerplate)
  - [OS and File Utilities Boilerplate](#os-and-file-utilities-boilerplate)
  - [String Utilities Boilerplate](#string-utilities-boilerplate)
  - [Math and Statistics Boilerplate](#math-and-statistics-boilerplate)
  - [Array Utilities Boilerplate](#array-utilities-boilerplate)

---

# Chapter 1: Getting Started with V

## Quick Access

Below is an index of all code examples in this chapter. You can use these links to jump directly to any specific code example:

**Code Comments**

- [Single Line Comments](#single-line-comments)
- [Multi Line Comments](#multi-line-comments)
- [Programm Commented All Places](#programm-commented-all-places)

---

This chapter introduces the core design philosophies of V. You will learn how to set up your development environment, compile and run programs, and document your code using comments.

## Code Comments

### Single Line Comments

_File location: [variables_and_constants/03_code_comments/01_single_line_comments/single_line_comments.v](file:///Users/codecaine/V-Programming-Comprehensive-Guide/variables_and_constants/03_code_comments/01_single_line_comments/single_line_comments.v)_

### Lesson: Single Line Comments

Comments are non-executable lines of text in a program that explain what the code does. They are ignored by the compiler but are essential for human developers. This lesson on **Single Line Comments** demonstrates how to write and format comments in V.

**Additional Context from Repository docs:**
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

---

### Multi Line Comments

_File location: [variables_and_constants/03_code_comments/02_multi_line_comments/multi_line_comments.v](file:///Users/codecaine/V-Programming-Comprehensive-Guide/variables_and_constants/03_code_comments/02_multi_line_comments/multi_line_comments.v)_

### Lesson: Multi Line Comments

In V, multi-line (or block) comments are enclosed between `/*` and `*/`.

> [!NOTE]
> **Nested Block Comments:** Unlike languages like C, C++, Java, or JavaScript, V supports **nested block comments**. This is a powerful feature that allows you to easily comment out large blocks of code even if they already contain block comments, without triggering syntax errors.

**Additional Context from Repository docs:**
This example demonstrates the concepts of **multi line comments**.

```v
module main

/*
multiply is a function that accepts two integer arguments (x and y).
It performs multiplication and returns the integer product.

/*
Note: In V, block comments can be nested.
This is a nested block comment. In standard C, nesting block comments
would cause a compile error, but V's compiler parses them correctly.
*/
This is the end of the outer block comment.
*/
fn multiply(x int, y int) int {
	return x * y
}

fn main() {
	println(multiply(4, 5))
}
```

---

### Programm Commented All Places

_File location: [variables_and_constants/03_code_comments/03_program_commented_all_places/programm_commented_all_places.v](file:///Users/codecaine/V-Programming-Comprehensive-Guide/variables_and_constants/03_code_comments/03_program_commented_all_places/programm_commented_all_places.v)_

### Lesson: Programm Commented All Places

Comments are non-executable lines of text in a program that explain what the code does. They are ignored by the compiler but are essential for human developers. This lesson on **Programm Commented All Places** demonstrates how to write and format comments in V.

**Additional Context from Repository docs:**
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

---

# Chapter 2: Variables and Constants

## Quick Access

Below is an index of all code examples in this chapter. You can use these links to jump directly to any specific code example:

**Constants**

- [Define Single Constant](#define-single-constant)
- [Define Multiple Constants](#define-multiple-constants)
- [Define Constant Of Type Struct](#define-constant-of-type-struct)
- [Define Constant Of Type Function](#define-constant-of-type-function)
- [Define Module Level Constants](#define-module-level-constants)
- [Cannot Define Constants Inside Functions](#cannot-define-constants-inside-functions)
- [Constants Module - Main (main.v)](#constants-module---main-mainv)
- [Constant Module Prefix - Helper (file1.v)](#constant-module-prefix---helper-file1v)

**Variables**

- [Parallel Declaration Immutable Variables](#parallel-declaration-immutable-variables)
- [Parallel Declaration Mutable Variables](#parallel-declaration-mutable-variables)
- [Parallel Declaration Mut And Immutable Vars](#parallel-declaration-mut-and-immutable-vars)
- [Augmented Assignment String](#augmented-assignment-string)
- [Augmented Assignment Integer](#augmented-assignment-integer)
- [Declare Mutable Variable](#declare-mutable-variable)
- [Cannot Update Mutable With Another Type](#cannot-update-mutable-with-another-type)
- [Declare Immutable Variable](#declare-immutable-variable)
- [Cannot Update Immutable Variables](#cannot-update-immutable-variables)
- [Declared And Assigned](#declared-and-assigned)
- [Declared And Not Assigned](#declared-and-not-assigned)
- [Unused Variables Will Be Warned](#unused-variables-will-be-warned)
- [Global Variables Not Allowed - Scope Demo](#global-variables-not-allowed---scope-demo)
- [Global Variables Not Allowed - File Scope Demo](#global-variables-not-allowed---file-scope-demo)
- [Variable Redeclaration](#variable-redeclaration)
- [Variable Scope For Same Variable Names](#variable-scope-for-same-variable-names)
- [Variable Shadowing Not Allowed](#variable-shadowing-not-allowed)

---

Variables are the basic storage units of any program. In this chapter, we explore how V handles variables with a safety-first mindset: variables are immutable by default, variable shadowing is forbidden, and constants are declared in module scopes. You will learn to manage program data safely and cleanly.

## Constants

### Define Single Constant

_File location: [variables_and_constants/02_constants/01_define_constant/01_define_single_constant.v](file:///Users/codecaine/V-Programming-Comprehensive-Guide/variables_and_constants/02_constants/01_define_constant/01_define_single_constant.v)_

### Lesson: Define Single Constant

Constants in V are defined using the `const` block. Constants are values that are known at compile time and never change throughout the execution of the program. By convention, constant names are written in lowercase, unlike many other languages.

This example shows how to define and use a single constant.

**Additional Context from Repository docs:**
This example demonstrates the concepts of **define single constant**.

```v
const app_name = 'V on Wheels'

fn main() {
	println(app_name)
}
```

---

### Define Multiple Constants

_File location: [variables_and_constants/02_constants/01_define_constant/02_define_multiple_constants.v](file:///Users/codecaine/V-Programming-Comprehensive-Guide/variables_and_constants/02_constants/01_define_constant/02_define_multiple_constants.v)_

### Lesson: Define Multiple Constants

You can define multiple constants within a single `const` block. This keeps related constants grouped together and makes the code cleaner.

This example shows how to declare multiple constants (integers, strings, floats) together.

**Additional Context from Repository docs:**
This example demonstrates the concepts of **define multiple constants**.

```v
const app_name = 'V on Wheels'
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

---

### Define Constant Of Type Struct

_File location: [variables_and_constants/02_constants/02_complex_constants/01_define_constant_of_type_struct/define_constant_of_type_struct.v](file:///Users/codecaine/V-Programming-Comprehensive-Guide/variables_and_constants/02_constants/02_complex_constants/01_define_constant_of_type_struct/define_constant_of_type_struct.v)_

### Lesson: Define Constant Of Type Struct

Variables and constants store state in V programs. This lesson on **Define Constant Of Type Struct** covers declaration rules, default values, scopes, or constant naming conventions.

**Additional Context from Repository docs:**
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

---

### Define Constant Of Type Function

_File location: [variables_and_constants/02_constants/02_complex_constants/02_define_constant_of_type_function/define_constant_of_type_function.v](file:///Users/codecaine/V-Programming-Comprehensive-Guide/variables_and_constants/02_constants/02_complex_constants/02_define_constant_of_type_function/define_constant_of_type_function.v)_

### Lesson: Define Constant Of Type Function

Variables and constants store state in V programs. This lesson on **Define Constant Of Type Function** covers declaration rules, default values, scopes, or constant naming conventions.

**Additional Context from Repository docs:**
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

---

### Define Module Level Constants

_File location: [variables_and_constants/02_constants/03_best_practices/01_define_module_level_constants/define_module_level_constants.v](file:///Users/codecaine/V-Programming-Comprehensive-Guide/variables_and_constants/02_constants/03_best_practices/01_define_module_level_constants/define_module_level_constants.v)_

### Lesson: Define Module Level Constants

Variables and constants store state in V programs. This lesson on **Define Module Level Constants** covers declaration rules, default values, scopes, or constant naming conventions.

**Additional Context from Repository docs:**
This example demonstrates the concepts of **define module level constants**.

```v
module main

const app_name = 'V on Wheels'

fn main() {
	println(app_name)
}
```

---

### Cannot Define Constants Inside Functions

_File location: [variables_and_constants/02_constants/03_best_practices/02_cannot_define_constants_inside_functions/cannot_define_constants_inside_functions.v](file:///Users/codecaine/V-Programming-Comprehensive-Guide/variables_and_constants/02_constants/03_best_practices/02_cannot_define_constants_inside_functions/cannot_define_constants_inside_functions.v)_

### Lesson: Cannot Define Constants Inside Functions

Variables and constants store state in V programs. This lesson on **Cannot Define Constants Inside Functions** covers declaration rules, default values, scopes, or constant naming conventions.

**Additional Context from Repository docs:**
This example demonstrates the concepts of **cannot define constants inside functions**.

```v
module main

const app_name = 'V on Wheels'

fn main() {
        const greet = 'hi' // this is not top level constant definition, throws error.
        println(app_name)
}
```

---

### Constants Module - Main (main.v)

_File location: [variables_and_constants/02_constants/03_best_practices/03_module_prefix_to_identify_constants/main.v](file:///Users/codecaine/V-Programming-Comprehensive-Guide/variables_and_constants/02_constants/03_best_practices/03_module_prefix_to_identify_constants/main.v)_

### Lesson: Constants Module - Main

Variables and constants store state in V programs. This lesson on **Main** covers declaration rules, default values, scopes, or constant naming conventions.

**Additional Context from Repository docs:**
This example demonstrates the concepts of **main**.

```v
module main

import mod1

fn main() {
	mod1.do_work()
}
```

---

### Constant Module Prefix - Helper (file1.v)

_File location: [variables_and_constants/02_constants/03_best_practices/03_module_prefix_to_identify_constants/mod1/file1.v](file:///Users/codecaine/V-Programming-Comprehensive-Guide/variables_and_constants/02_constants/03_best_practices/03_module_prefix_to_identify_constants/mod1/file1.v)_

### Lesson: Constant Module Prefix - Helper

Variables and constants store state in V programs. This lesson on **File1** covers declaration rules, default values, scopes, or constant naming conventions.

**Additional Context from Repository docs:**
This example demonstrates the concepts of **file1**.

```v
module mod1

const greet_count = 5

pub fn do_work() {
	println(greet_count)
}
```

---

## Variables

### Parallel Declaration Immutable Variables

_File location: [variables_and_constants/01_variables/01_variable_assignment/01_parallel_declaration/01_parallel_declaration_immutable_variables.v](file:///Users/codecaine/V-Programming-Comprehensive-Guide/variables_and_constants/01_variables/01_variable_assignment/01_parallel_declaration/01_parallel_declaration_immutable_variables.v)_

### Lesson: Parallel Declaration Immutable Variables

In V, you can declare and initialize multiple variables in a single line. This is known as **parallel declaration**. By default, variables in V are **immutable** (read-only). Once assigned a value, they cannot be changed.

This program demonstrates declaring two variables `a` and `b` at the same time and assigning them initial values. Any attempt to modify `a` or `b` later in the code will cause a compile-time error.

**Additional Context from Repository docs:**
This example demonstrates the concepts of **parallel declaration immutable variables**.

```v
fn main() {
	first_name, last_name, age := 'Ada', 'Lovelace', 36
	println('${first_name} ${last_name} is ${age} years old')
	println('Next milestone: ${first_name} will speak at the conference')
}
```

---

### Parallel Declaration Mutable Variables

_File location: [variables_and_constants/01_variables/01_variable_assignment/01_parallel_declaration/02_parallel\_\_declaration_mutable_variables.v](file:///Users/codecaine/V-Programming-Comprehensive-Guide/variables_and_constants/01_variables/01_variable_assignment/01_parallel_declaration/02_parallel__declaration_mutable_variables.v)_

### Lesson: Parallel Declaration Mutable Variables

If you want to modify parallelly declared variables later, you must explicitly mark them as mutable using the `mut` keyword. In V, mutability is always explicit to make code safer and easier to reason about.

Here, we declare two mutable variables `a` and `b` at the same time using `mut`. We then reassign their values using the standard assignment operator (`=`).

**Additional Context from Repository docs:**
This example demonstrates the concepts of **parallel declaration mutable variables**.

```v
// mutable variables parallel assignment

fn main() {
	mut greeting, mut recipient := 'Hi', 'world'
	println('${greeting}, ${recipient}!')

	// updating mutable variables in parallel
	greeting, recipient = 'Hello', 'Ada'
	println('${greeting}, ${recipient}!')
}
```

---

### Parallel Declaration Mut And Immutable Vars

_File location: [variables_and_constants/01_variables/01_variable_assignment/01_parallel_declaration/03_parallel_declaration_mut_and_immutable_vars.v](file:///Users/codecaine/V-Programming-Comprehensive-Guide/variables_and_constants/01_variables/01_variable_assignment/01_parallel_declaration/03_parallel_declaration_mut_and_immutable_vars.v)_

### Lesson: Parallel Declaration Mut And Immutable Vars

Variables and constants store state in V programs. This lesson on **Parallel Declaration Mut And Immutable Vars** covers declaration rules, default values, scopes, or constant naming conventions.

**Additional Context from Repository docs:**
This example demonstrates the concepts of **parallel declaration mut and immutable vars**.

```v
fn main() {
	mut message, count := 'Hello', 32
	println(message)
	message = 'Hi'
	println(message)
	println(count)
	// count = 2 // Uncommenting this would fail because count is immutable.
}
```

---

### Augmented Assignment String

_File location: [variables_and_constants/01_variables/01_variable_assignment/02_augmented_assignment/01_augmented_assignment_string.v](file:///Users/codecaine/V-Programming-Comprehensive-Guide/variables_and_constants/01_variables/01_variable_assignment/02_augmented_assignment/01_augmented_assignment_string.v)_

### Lesson: Augmented Assignment String

Variables and constants store state in V programs. This lesson on **Augmented Assignment String** covers declaration rules, default values, scopes, or constant naming conventions.

**Additional Context from Repository docs:**
This example demonstrates the concepts of **augmented assignment string**.

```v
fn main() {
	mut greeting := 'Hi'
	println(greeting)

	greeting = greeting + ' there'
	println(greeting)

	greeting += ', how are you today?'
	println(greeting)
}
```

---

### Augmented Assignment Integer

_File location: [variables_and_constants/01_variables/01_variable_assignment/02_augmented_assignment/02_augmented_assignment_integer.v](file:///Users/codecaine/V-Programming-Comprehensive-Guide/variables_and_constants/01_variables/01_variable_assignment/02_augmented_assignment/02_augmented_assignment_integer.v)_

### Lesson: Augmented Assignment Integer

Variables and constants store state in V programs. This lesson on **Augmented Assignment Integer** covers declaration rules, default values, scopes, or constant naming conventions.

**Additional Context from Repository docs:**
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

---

### Declare Mutable Variable

_File location: [variables_and_constants/01_variables/02_variable_features/01_mutable_immutable_variables/01_mutable/01_declare_mutable_variable.v](file:///Users/codecaine/V-Programming-Comprehensive-Guide/variables_and_constants/01_variables/02_variable_features/01_mutable_immutable_variables/01_mutable/01_declare_mutable_variable.v)_

### Lesson: Declare Mutable Variable

By default, all variables in V are **immutable** (their values cannot change). To declare a variable whose value can be modified later, you must prepend the `mut` keyword before the variable name.

This example shows how to declare a mutable variable, change its value, and print the results.

**Additional Context from Repository docs:**
This example demonstrates the concepts of **declare mutable variable**.

```v
fn main() {
	mut count := 0
	count += 1
	count += 2
	println('Current count: ${count}')
}
```

---

### Cannot Update Mutable With Another Type

_File location: [variables_and_constants/01_variables/02_variable_features/01_mutable_immutable_variables/01_mutable/02_cannot_update_mutable_with_another_type.v](file:///Users/codecaine/V-Programming-Comprehensive-Guide/variables_and_constants/01_variables/02_variable_features/01_mutable_immutable_variables/01_mutable/02_cannot_update_mutable_with_another_type.v)_

### Lesson: Cannot Update Mutable With Another Type

Variables and constants store state in V programs. This lesson on **Cannot Update Mutable With Another Type** covers declaration rules, default values, scopes, or constant naming conventions.

**Additional Context from Repository docs:**
This example demonstrates the concepts of **cannot update mutable with another type**.

```v
fn main() {
	mut i := 10
	i = 100
	i = 'Apple' // throws error
}
```

---

### Declare Immutable Variable

_File location: [variables_and_constants/01_variables/02_variable_features/01_mutable_immutable_variables/02_immutable/01_declare_immutable_variable.v](file:///Users/codecaine/V-Programming-Comprehensive-Guide/variables_and_constants/01_variables/02_variable_features/01_mutable_immutable_variables/02_immutable/01_declare_immutable_variable.v)_

### Lesson: Declare Immutable Variable

Variables and constants store state in V programs. This lesson on **Declare Immutable Variable** covers declaration rules, default values, scopes, or constant naming conventions.

**Additional Context from Repository docs:**
This example demonstrates the concepts of **declare immutable variable**.

```v
fn main() {
	greeting := 'Hello'
	message := greeting + ', V!'
	println(message)
}
```

---

### Cannot Update Immutable Variables

_File location: [variables_and_constants/01_variables/02_variable_features/01_mutable_immutable_variables/02_immutable/02_cannot_update_immutable_variables.v](file:///Users/codecaine/V-Programming-Comprehensive-Guide/variables_and_constants/01_variables/02_variable_features/01_mutable_immutable_variables/02_immutable/02_cannot_update_immutable_variables.v)_

### Lesson: Cannot Update Immutable Variables

One of V's core safety features is **immutability by default**. If you declare a variable without the `mut` keyword and then try to reassign it a new value, the compiler will refuse to compile the program.

This example demonstrates what happens when you try to update an immutable variable (expect a compiler error).

**Additional Context from Repository docs:**
This example demonstrates the concepts of **cannot update immutable variables**.

```v
fn main() {
	msg := 'Hello'
	msg = 'Good Day!' // throws error
}
```

---

### Declared And Assigned

_File location: [variables_and_constants/01_variables/02_variable_features/02_declared_must_be_assigned/01_declared_and_assigned.v](file:///Users/codecaine/V-Programming-Comprehensive-Guide/variables_and_constants/01_variables/02_variable_features/02_declared_must_be_assigned/01_declared_and_assigned.v)_

### Lesson: Declared And Assigned

Variables and constants store state in V programs. This lesson on **Declared And Assigned** covers declaration rules, default values, scopes, or constant naming conventions.

**Additional Context from Repository docs:**
This example demonstrates the concepts of **declared and assigned**.

```v
fn main() {
	mut i := 0
	// declared and assigned
	println(i)
}
```

---

### Declared And Not Assigned

_File location: [variables_and_constants/01_variables/02_variable_features/02_declared_must_be_assigned/02_declared_and_not_assigned.v](file:///Users/codecaine/V-Programming-Comprehensive-Guide/variables_and_constants/01_variables/02_variable_features/02_declared_must_be_assigned/02_declared_and_not_assigned.v)_

### Lesson: Declared And Not Assigned

V does not allow variables to be declared without an initial value. Unlike other languages that initialize variables to a default 'zero' value or `null`, V forces you to explicitly provide a value. This prevents uninitialized variable bugs.

This example illustrates that declaring a variable without an assignment is a compilation error.

**Additional Context from Repository docs:**
This example demonstrates the concepts of **declared and not assigned**.

```v
fn main() {
	mut a // throws error
}
```

---

### Unused Variables Will Be Warned

_File location: [variables_and_constants/01_variables/02_variable_features/03_declared_must_be_consumed/01_unused_variables_will_be_warned.v](file:///Users/codecaine/V-Programming-Comprehensive-Guide/variables_and_constants/01_variables/02_variable_features/03_declared_must_be_consumed/01_unused_variables_will_be_warned.v)_

### Lesson: Unused Variables Will Be Warned

To keep codebases clean and efficient, the V compiler detects if you declare a variable but never use (consume) it. By default, V treats unused variables as a compilation warning/error, encouraging you to clean up dead code.

This example shows a declared variable that is never used.

**Additional Context from Repository docs:**
This example demonstrates the concepts of **unused variables will be warned**.

```v
fn main() {
	i := 'hello' // i is not used anywhere, so warns when run in dev mode and throws error when run in prod mode
	x := 3
	y := 2
	println(x + y)
}
```

---

### Global Variables Not Allowed - Scope Demo

_File location: [variables_and_constants/01_variables/03_limitations/01_global_variables/01_global_variables_not_allowed.v](file:///Users/codecaine/V-Programming-Comprehensive-Guide/variables_and_constants/01_variables/03_limitations/01_global_variables/01_global_variables_not_allowed.v)_

### Lesson: Global Variables Not Allowed - Scope Demo

V does not allow global variables by default. Global state is a major source of bugs, race conditions in multi-threaded applications, and poor code structure. By forbidding globals, V enforces clean, modular code passing state via arguments.

These examples demonstrate that declaring variables outside of the main function or modules is strictly prohibited.

**Additional Context from Repository docs:**
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

---

### Global Variables Not Allowed - File Scope Demo

_File location: [variables_and_constants/01_variables/03_limitations/01_global_variables/02_global_variables_not_allowed.v](file:///Users/codecaine/V-Programming-Comprehensive-Guide/variables_and_constants/01_variables/03_limitations/01_global_variables/02_global_variables_not_allowed.v)_

### Lesson: Global Variables Not Allowed - File Scope Demo

V does not allow global variables by default. Global state is a major source of bugs, race conditions in multi-threaded applications, and poor code structure. By forbidding globals, V enforces clean, modular code passing state via arguments.

These examples demonstrate that declaring variables outside of the main function or modules is strictly prohibited.

**Additional Context from Repository docs:**
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

---

### Variable Redeclaration

_File location: [variables_and_constants/01_variables/03_limitations/02_variable_redeclaration/01_variable_redeclaration.v](file:///Users/codecaine/V-Programming-Comprehensive-Guide/variables_and_constants/01_variables/03_limitations/02_variable_redeclaration/01_variable_redeclaration.v)_

### Lesson: Variable Redeclaration

Variables and constants store state in V programs. This lesson on **Variable Redeclaration** covers declaration rules, default values, scopes, or constant naming conventions.

**Additional Context from Repository docs:**
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

---

### Variable Scope For Same Variable Names

_File location: [variables_and_constants/01_variables/03_limitations/02_variable_redeclaration/02_variable_scope_for_same_variable_names.v](file:///Users/codecaine/V-Programming-Comprehensive-Guide/variables_and_constants/01_variables/03_limitations/02_variable_redeclaration/02_variable_scope_for_same_variable_names.v)_

### Lesson: Variable Scope For Same Variable Names

Variables and constants store state in V programs. This lesson on **Variable Scope For Same Variable Names** covers declaration rules, default values, scopes, or constant naming conventions.

**Additional Context from Repository docs:**
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

---

### Variable Shadowing Not Allowed

_File location: [variables_and_constants/01_variables/03_limitations/03_variable_shadowing/variable_shadowing_not_allowed.v](file:///Users/codecaine/V-Programming-Comprehensive-Guide/variables_and_constants/01_variables/03_limitations/03_variable_shadowing/variable_shadowing_not_allowed.v)_

### Lesson: Variable Shadowing Not Allowed

**Variable shadowing** happens when a variable declared within an inner scope (like a loop or a function block) has the same name as a variable in an outer scope. V strictly forbids variable shadowing to prevent confusion and accidental bugs where a developer modifies the wrong variable.

This example shows how V rejects shadowed variable declarations.

**Additional Context from Repository docs:**
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

---

# Chapter 3: Primitive Data Types

## Quick Access

Below is an index of all code examples in this chapter. You can use these links to jump directly to any specific code example:

**Primitive Types Demo**

- [Primitive Types Demo Code](#primitive-types-demo-code)

**Boolean Type**

- [Logical Operators](#logical-operators)
- [Relational Operators](#relational-operators)
- [Boolean Methods](#boolean-methods)

**Numeric Types**

- [Declaring Integers](#declaring-integers)
- [Hex Binary Octa Notation Of Declaring Integers](#hex-binary-octa-notation-of-declaring-integers)
- [Promoting Numeric Types](#promoting-numeric-types)
- [Arithmetic Operators](#arithmetic-operators)
- [Bitwise Operators](#bitwise-operators)
- [Shift Operators](#shift-operators)
- [Shift Operator On Range Of Integers](#shift-operator-on-range-of-integers)
- [Integer Methods](#integer-methods)
- [Float Methods](#float-methods)
- [U8 Methods](#u8-methods)
- [Size Pointer Methods](#size-pointer-methods)

**Rune Type**

- [Declare Rune](#declare-rune)
- [Rune Operations With Strings](#rune-operations-with-strings)
- [Rune Methods](#rune-methods)

**String Type**

- [Declare String](#declare-string)
- [String Read Only Array Of Bytes](#string-read-only-array-of-bytes)
- [Strings Immutable By Default](#strings-immutable-by-default)
- [Declaring Mutable Strings](#declaring-mutable-strings)
- [Cannot Mutate String Elements](#cannot-mutate-string-elements)
- [String Interpolation](#string-interpolation)
- [Escape Special Characters](#escape-special-characters)
- [Declare Raw Strings](#declare-raw-strings)
- [String Concatenation Using Plus Sign](#string-concatenation-using-plus-sign)
- [String Concatenation Using Interpolation](#string-concatenation-using-interpolation)
- [Extract Substring From String Literal](#extract-substring-from-string-literal)
- [Split String](#split-string)
- [String To Runes Array](#string-to-runes-array)
- [Count Sub String Occurences](#count-sub-string-occurences)
- [Check String Contains Substring](#check-string-contains-substring)
- [String Contains Is Case Sensitive](#string-contains-is-case-sensitive)
- [Common String Methods](#common-string-methods)

## Primitive Types Demo

### Primitive Types Demo Code

_File location: [primitive_types/05_primitive_types_demo/primitive_types_demo.v](file:///Users/codecaine/V-Programming-Comprehensive-Guide/primitive_types/05_primitive_types_demo/primitive_types_demo.v)_

### Lesson: Primitive Types Demo Code

This comprehensive example demonstrates every primitive data type in V:

- **Boolean**: `bool` (representing `true` or `false`).
- **String**: `string` (representing an immutable array of bytes).
- **Rune**: `rune` (representing a single Unicode code point, alias for `u32`).
- **Signed Integers**: `i8` (8-bit), `i16` (16-bit), `int` (32-bit), `i64` (64-bit).
- **Unsigned Integers**: `u8` (8-bit, alias `byte`), `u16` (16-bit), `u32` (32-bit), `u64` (64-bit).
- **Platform-dependent sizes**: `isize` (signed size of a pointer), `usize` (unsigned size of a pointer).
- **Floating Point Numbers**: `f32` (32-bit single-precision), `f64` (64-bit double-precision).

For each type, the example initializes a value and prints its value, type (using `typeof(var).name`), and size in bytes (using `sizeof(var)`).

**Additional Context from Repository docs:**
This example demonstrates the concepts of **primitive types demo**.

```v
module main

fn main() {
	println('==================================================')
	println('        Vlang Primitive Data Types Demo           ')
	println('==================================================')

	// 1. Boolean Type
	b := true
	println('Boolean: val: ${b} | type: ${typeof(b).name} | size: ${sizeof(b)} byte')

	// 2. String Type
	s := 'Hello, V!'
	println('String:  val: "${s}" | type: ${typeof(s).name} | size: ${sizeof(s)} bytes')

	// 3. Rune Type (unicode character, represented as `r` prefix or backticks)
	r := `V`
	println('Rune:    val: ${r} (char: ${r.str()}) | type: ${typeof(r).name} | size: ${sizeof(r)} bytes')

	// 4. Signed Integers
	i_8 := i8(-128)
	i_16 := i16(-32768)
	i_32 := int(-2147483648)
	i_64 := i64(-9223372036854775808)
	println('i8:      val: ${i_8} | type: ${typeof(i_8).name} | size: ${sizeof(i_8)} byte')
	println('i16:     val: ${i_16} | type: ${typeof(i_16).name} | size: ${sizeof(i_16)} bytes')
	println('int:     val: ${i_32} | type: ${typeof(i_32).name} | size: ${sizeof(i_32)} bytes')
	println('i64:     val: ${i_64} | type: ${typeof(i_64).name} | size: ${sizeof(i_64)} bytes')

	// 5. Unsigned Integers
	u_8 := u8(255)
	u_16 := u16(65535)
	u_32 := u32(4294967295)
	u_64 := u64(18446744073709551615)
	println('u8:      val: ${u_8} | type: ${typeof(u_8).name} | size: ${sizeof(u_8)} byte')
	println('u16:     val: ${u_16} | type: ${typeof(u_16).name} | size: ${sizeof(u_16)} bytes')
	println('u32:     val: ${u_32} | type: ${typeof(u_32).name} | size: ${sizeof(u_32)} bytes')
	println('u64:     val: ${u_64} | type: ${typeof(u_64).name} | size: ${sizeof(u_64)} bytes')

	// 6. Platform-dependent Sizes
	isize_val := isize(-12345)
	usize_val := usize(12345)
	println('isize:   val: ${isize_val} | type: ${typeof(isize_val).name} | size: ${sizeof(isize_val)} bytes')
	println('usize:   val: ${usize_val} | type: ${typeof(usize_val).name} | size: ${sizeof(usize_val)} bytes')

	// 7. Floating Point Numbers
	f_32 := f32(3.14159)
	f_64 := f64(2.718281828459)
	println('f32:     val: ${f_32} | type: ${typeof(f_32).name} | size: ${sizeof(f_32)} bytes')
	println('f64:     val: ${f_64} | type: ${typeof(f_64).name} | size: ${sizeof(f_64)} bytes')

	println('==================================================')
}
```

---

V is a statically-typed language, meaning every variable has a fixed data type at compile time. In this chapter, you will learn about V's primitive types: booleans for logic, numeric types for numbers, runes for single characters, and strings for text. You will also learn about V's rich set of built-in methods on these types.

## Boolean Type

### Logical Operators

_File location: [primitive_types/01_boolean_type/01_logical_operators/01_logical_operators.v](file:///Users/codecaine/V-Programming-Comprehensive-Guide/primitive_types/01_boolean_type/01_logical_operators/01_logical_operators.v)_

### Lesson: Logical Operators

In V, primitive data types are the core building blocks of the language. This section details how to declare and use **Logical Operators** in a simple, straightforward manner. Beginners should pay close attention to how variables of this type are initialized and how built-in methods are called on them.

**Additional Context from Repository docs:**
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

---

### Relational Operators

_File location: [primitive_types/01_boolean_type/02_relational_operators/01_relational_operators.v](file:///Users/codecaine/V-Programming-Comprehensive-Guide/primitive_types/01_boolean_type/02_relational_operators/01_relational_operators.v)_

### Lesson: Relational Operators

In V, primitive data types are the core building blocks of the language. This section details how to declare and use **Relational Operators** in a simple, straightforward manner. Beginners should pay close attention to how variables of this type are initialized and how built-in methods are called on them.

**Additional Context from Repository docs:**
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

---

### Boolean Methods

_File location: [primitive_types/01_boolean_type/03_boolean_methods/01_boolean_methods.v](file:///Users/codecaine/V-Programming-Comprehensive-Guide/primitive_types/01_boolean_type/03_boolean_methods/01_boolean_methods.v)_

### Lesson: Boolean Methods

Booleans in V are simple `true` or `false` values. V provides built-in methods on boolean types, such as `str()`, which converts the boolean value to its string representation (`'true'` or `'false'`).

This is useful for logging, printing, or interpolating booleans into strings.

**Additional Context from Repository docs:**
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

---

## Numeric Types

### Declaring Integers

_File location: [primitive_types/02_numeric_types/01_declaring_integers/01_declaring_integers/01_declaring_integers.v](file:///Users/codecaine/V-Programming-Comprehensive-Guide/primitive_types/02_numeric_types/01_declaring_integers/01_declaring_integers/01_declaring_integers.v)_

### Lesson: Declaring Integers

V has several built-in integer types, both signed and unsigned, of various sizes (e.g., `i8`, `i16`, `i32`, `i64` for signed integers, and `u8`, `u16`, `u32`, `u64` for unsigned integers). If you declare an integer using `:=`, V defaults to the standard 32-bit integer (`int`).

This example demonstrates how to declare different integer types.

**Additional Context from Repository docs:**
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

---

### Hex Binary Octa Notation Of Declaring Integers

_File location: [primitive_types/02_numeric_types/01_declaring_integers/02_hex_binary_octa_notation/02_hex_binary_octa_notation_of_declaring_integers.v](file:///Users/codecaine/V-Programming-Comprehensive-Guide/primitive_types/02_numeric_types/01_declaring_integers/02_hex_binary_octa_notation/02_hex_binary_octa_notation_of_declaring_integers.v)_

### Lesson: Hex Binary Octa Notation Of Declaring Integers

V has several built-in integer types, both signed and unsigned, of various sizes (e.g., `i8`, `i16`, `i32`, `i64` for signed integers, and `u8`, `u16`, `u32`, `u64` for unsigned integers). If you declare an integer using `:=`, V defaults to the standard 32-bit integer (`int`).

This example demonstrates how to declare different integer types.

**Additional Context from Repository docs:**
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

---

### Promoting Numeric Types

_File location: [primitive_types/02_numeric_types/02_promoting_numeric_types/01_promoting_numeric_types.v](file:///Users/codecaine/V-Programming-Comprehensive-Guide/primitive_types/02_numeric_types/02_promoting_numeric_types/01_promoting_numeric_types.v)_

### Lesson: Promoting Numeric Types

V is very strict about types. It does not perform implicit type conversion (coercion) between different numeric types to prevent accidental precision loss or overflow bugs. If you want to perform arithmetic operations on different types, you must explicitly cast them.

This example shows how to cast (promote) smaller integer types to larger ones or to floats.

**Additional Context from Repository docs:**
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

---

### Arithmetic Operators

_File location: [primitive_types/02_numeric_types/03_operations_on_numeric_types/01_arithmetic_operators/arithmetic_operators.v](file:///Users/codecaine/V-Programming-Comprehensive-Guide/primitive_types/02_numeric_types/03_operations_on_numeric_types/01_arithmetic_operators/arithmetic_operators.v)_

### Lesson: Arithmetic Operators

In V, primitive data types are the core building blocks of the language. This section details how to declare and use **Arithmetic Operators** in a simple, straightforward manner. Beginners should pay close attention to how variables of this type are initialized and how built-in methods are called on them.

**Additional Context from Repository docs:**
This example demonstrates the concepts of **arithmetic operators**.

```v
module main

fn main() {
	price := 120
	tax_rate := 8
	tax := price * tax_rate / 100
	total := price + tax

	println('Subtotal: ${price}')
	println('Tax: ${tax}')
	println('Total: ${total}')
}
```

---

### Bitwise Operators

_File location: [primitive_types/02_numeric_types/03_operations_on_numeric_types/02_bitwise_operators/bitwise_operators.v](file:///Users/codecaine/V-Programming-Comprehensive-Guide/primitive_types/02_numeric_types/03_operations_on_numeric_types/02_bitwise_operators/bitwise_operators.v)_

### Lesson: Bitwise Operators

In V, primitive data types are the core building blocks of the language. This section details how to declare and use **Bitwise Operators** in a simple, straightforward manner. Beginners should pay close attention to how variables of this type are initialized and how built-in methods are called on them.

**Additional Context from Repository docs:**
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

---

### Shift Operators

_File location: [primitive_types/02_numeric_types/03_operations_on_numeric_types/03_shift_operators/01_shift_operators/01_shift_operators.v](file:///Users/codecaine/V-Programming-Comprehensive-Guide/primitive_types/02_numeric_types/03_operations_on_numeric_types/03_shift_operators/01_shift_operators/01_shift_operators.v)_

### Lesson: Shift Operators

In V, primitive data types are the core building blocks of the language. This section details how to declare and use **Shift Operators** in a simple, straightforward manner. Beginners should pay close attention to how variables of this type are initialized and how built-in methods are called on them.

**Additional Context from Repository docs:**
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

---

### Shift Operator On Range Of Integers

_File location: [primitive_types/02_numeric_types/03_operations_on_numeric_types/03_shift_operators/02_shift_operator_on_range_of_integers/02_shift_operator_on_range_of_integers.v](file:///Users/codecaine/V-Programming-Comprehensive-Guide/primitive_types/02_numeric_types/03_operations_on_numeric_types/03_shift_operators/02_shift_operator_on_range_of_integers/02_shift_operator_on_range_of_integers.v)_

### Lesson: Shift Operator On Range Of Integers

In V, primitive data types are the core building blocks of the language. This section details how to declare and use **Shift Operator On Range Of Integers** in a simple, straightforward manner. Beginners should pay close attention to how variables of this type are initialized and how built-in methods are called on them.

**Additional Context from Repository docs:**
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

---

### Integer Methods

_File location: [primitive_types/02_numeric_types/04_numeric_methods/01_integer_methods/01_integer_methods.v](file:///Users/codecaine/V-Programming-Comprehensive-Guide/primitive_types/02_numeric_types/04_numeric_methods/01_integer_methods/01_integer_methods.v)_

### Lesson: Integer Methods

In V, primitive data types are the core building blocks of the language. This section details how to declare and use **Integer Methods** in a simple, straightforward manner. Beginners should pay close attention to how variables of this type are initialized and how built-in methods are called on them.

**Additional Context from Repository docs:**
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

---

### Float Methods

_File location: [primitive_types/02_numeric_types/04_numeric_methods/02_float_methods/02_float_methods.v](file:///Users/codecaine/V-Programming-Comprehensive-Guide/primitive_types/02_numeric_types/04_numeric_methods/02_float_methods/02_float_methods.v)_

### Lesson: Float Methods

In V, primitive data types are the core building blocks of the language. This section details how to declare and use **Float Methods** in a simple, straightforward manner. Beginners should pay close attention to how variables of this type are initialized and how built-in methods are called on them.

**Additional Context from Repository docs:**
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

---

### U8 Methods

_File location: [primitive_types/02_numeric_types/04_numeric_methods/03_u8_methods/03_u8_methods.v](file:///Users/codecaine/V-Programming-Comprehensive-Guide/primitive_types/02_numeric_types/04_numeric_methods/03_u8_methods/03_u8_methods.v)_

### Lesson: U8 Methods

In V, primitive data types are the core building blocks of the language. This section details how to declare and use **U8 Methods** in a simple, straightforward manner. Beginners should pay close attention to how variables of this type are initialized and how built-in methods are called on them.

**Additional Context from Repository docs:**
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

---

### Size Pointer Methods

_File location: [primitive_types/02_numeric_types/04_numeric_methods/04_size_pointer_methods/04_size_pointer_methods.v](file:///Users/codecaine/V-Programming-Comprehensive-Guide/primitive_types/02_numeric_types/04_numeric_methods/04_size_pointer_methods/04_size_pointer_methods.v)_

### Lesson: Size Pointer Methods

In V, primitive data types are the core building blocks of the language. This section details how to declare and use **Size Pointer Methods** in a simple, straightforward manner. Beginners should pay close attention to how variables of this type are initialized and how built-in methods are called on them.

**Additional Context from Repository docs:**
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

---

## Rune Type

### Declare Rune

_File location: [primitive_types/04_rune_type/01_declare_rune/01_declare_rune.v](file:///Users/codecaine/V-Programming-Comprehensive-Guide/primitive_types/04_rune_type/01_declare_rune/01_declare_rune.v)_

### Lesson: Declare Rune

A **rune** in V represents a single Unicode code point. Runes are declared using backticks (e.g., \`a\`, \`🔥\`) and are represented internally as 32-bit unsigned integers (`u32`). This allows V to support multi-byte Unicode characters (like emojis or Chinese characters) as single character tokens.

This example shows how to declare and print runes.

**Additional Context from Repository docs:**
This example demonstrates the concepts of **declare rune**.

```v
fn main() {
	initial := `A`
	symbol := `🔥`

	println(typeof(initial).name)
	println(typeof(symbol).name)
	println('Initial: ${initial.str()}')
	println('Symbol: ${symbol.str()}')
}
```

---

### Rune Operations With Strings

_File location: [primitive_types/04_rune_type/02_rune_operations_with_strings/02_rune_operations_with_strings.v](file:///Users/codecaine/V-Programming-Comprehensive-Guide/primitive_types/04_rune_type/02_rune_operations_with_strings/02_rune_operations_with_strings.v)_

### Lesson: Rune Operations With Strings

In V, primitive data types are the core building blocks of the language. This section details how to declare and use **Rune Operations With Strings** in a simple, straightforward manner. Beginners should pay close attention to how variables of this type are initialized and how built-in methods are called on them.

**Additional Context from Repository docs:**
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

---

### Rune Methods

_File location: [primitive_types/04_rune_type/03_rune_methods/01_rune_methods.v](file:///Users/codecaine/V-Programming-Comprehensive-Guide/primitive_types/04_rune_type/03_rune_methods/01_rune_methods.v)_

### Lesson: Rune Methods

In V, primitive data types are the core building blocks of the language. This section details how to declare and use **Rune Methods** in a simple, straightforward manner. Beginners should pay close attention to how variables of this type are initialized and how built-in methods are called on them.

**Additional Context from Repository docs:**
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

---

## String Type

### Declare String

_File location: [primitive_types/03_string_type/01_declare_string/01_declare_string.v](file:///Users/codecaine/V-Programming-Comprehensive-Guide/primitive_types/03_string_type/01_declare_string/01_declare_string.v)_

### Lesson: Declare String

In V, primitive data types are the core building blocks of the language. This section details how to declare and use **Declare String** in a simple, straightforward manner. Beginners should pay close attention to how variables of this type are initialized and how built-in methods are called on them.

**Additional Context from Repository docs:**
This example demonstrates the concepts of **declare string**.

```v
fn main() {
	greeting := 'hello'
	name := 'Ada'
	message := greeting + ', ' + name + '!'

	println(message)
	println('Length: ${message.len}')
	println('Type: ${typeof(message).name}')
}
```

---

### String Read Only Array Of Bytes

_File location: [primitive_types/03_string_type/01_working_with_strings/01_string_read_only_array_of_bytes/01_string_read_only_array_of_bytes.v](file:///Users/codecaine/V-Programming-Comprehensive-Guide/primitive_types/03_string_type/01_working_with_strings/01_string_read_only_array_of_bytes/01_string_read_only_array_of_bytes.v)_

### Lesson: String Read Only Array Of Bytes

In V, a string is internally represented as a read-only array of bytes (`u8`). This means you can access individual bytes of a string using array indexing (`str[index]`), but you cannot change them.

This example shows how to read bytes from a string and print their values.

**Additional Context from Repository docs:**
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

---

### Strings Immutable By Default

_File location: [primitive_types/03_string_type/01_working_with_strings/02_strings_immutable_by_default/02_strings_immutable_by_default.v](file:///Users/codecaine/V-Programming-Comprehensive-Guide/primitive_types/03_string_type/01_working_with_strings/02_strings_immutable_by_default/02_strings_immutable_by_default.v)_

### Lesson: Strings Immutable By Default

Strings in V are completely immutable. Once a string is created, its characters cannot be modified in place. Any operation that manipulates a string (such as replacing characters or converting to uppercase) returns a brand new string instead of modifying the original.

This example demonstrates that strings are read-only and cannot be changed.

**Additional Context from Repository docs:**
This example demonstrates the concepts of **strings immutable by default**.

```v
fn main() {
	s := 'hello'
	// variable s is immutable
	s = 'Hello!'
	// this results in error
}
```

---

### Declaring Mutable Strings

_File location: [primitive_types/03_string_type/01_working_with_strings/03_declaring_mutable_strings/03_declaring_mutable_strings.v](file:///Users/codecaine/V-Programming-Comprehensive-Guide/primitive_types/03_string_type/01_working_with_strings/03_declaring_mutable_strings/03_declaring_mutable_strings.v)_

### Lesson: Declaring Mutable Strings

While strings are immutable, you can declare a mutable string variable using `mut`. This allows the variable to be reassigned to a new string value, or appended to using the `+=` operator.

This example shows how to declare a mutable string and append text to it.

**Additional Context from Repository docs:**
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

---

### Cannot Mutate String Elements

_File location: [primitive_types/03_string_type/01_working_with_strings/04_cannot_mutate_string_elements/04_cannot_mutate_string_elements.v](file:///Users/codecaine/V-Programming-Comprehensive-Guide/primitive_types/03_string_type/01_working_with_strings/04_cannot_mutate_string_elements/04_cannot_mutate_string_elements.v)_

### Lesson: Cannot Mutate String Elements

Even if a string variable is declared with `mut`, you cannot mutate its individual characters or bytes directly via index assignment (e.g., `s[0] = \`a\``). The compiler will throw an error to protect string integrity.

This program shows that element mutation is strictly forbidden.

**Additional Context from Repository docs:**
This example demonstrates the concepts of **cannot mutate string elements**.

```v
fn main() {
	mut greet := 'good Day'

	greet[0] = 'G' // this results in error
}
```

---

### String Interpolation

_File location: [primitive_types/03_string_type/02_operations_on_string_types/01_string_interpolation/01_string_interpolation.v](file:///Users/codecaine/V-Programming-Comprehensive-Guide/primitive_types/03_string_type/02_operations_on_string_types/01_string_interpolation/01_string_interpolation.v)_

### Lesson: String Interpolation

**String interpolation** is a clean way to insert variables or expressions inside a string literal. In V, you do this by wrapping the variable or expression in `${variable}` inside a single-quoted string.

This example demonstrates how to format strings with variable values.

**Additional Context from Repository docs:**
This example demonstrates the concepts of **string interpolation**.

```v
fn main() {
	a := 'coding'
	b := 'fun'
	println('${a} is ${b}')
	println('${a} is ${b}')
}
```

---

### Escape Special Characters

_File location: [primitive_types/03_string_type/02_operations_on_string_types/02_string_manipulation/01_escape_special_characters/01_escape_special_characters.v](file:///Users/codecaine/V-Programming-Comprehensive-Guide/primitive_types/03_string_type/02_operations_on_string_types/02_string_manipulation/01_escape_special_characters/01_escape_special_characters.v)_

### Lesson: Escape Special Characters

V strings support standard escape characters (like `\n` for newlines, `\t` for tabs, and `\\` for backslashes) to represent special characters inside a string literal.

This example shows how these escape sequences are rendered in the console.

**Additional Context from Repository docs:**
This example demonstrates the concepts of **escape special characters**.

```v
module main

fn main() {
	// 1. Newline escape character (\n)
	println('Hello\nWorld!')

	// 2. Tab escape character (\t)
	println('Name:\tAlice\tAge:\t25')

	// 3. Backslash escape character (\\)
	println('File path: C:\\Program Files\\V')

	// 4. Escaping single quotes (\') in a single-quoted string
	println('It\'s my Daughter\'s birthday!')

	// 5. Escaping double quotes (\") in a double-quoted string
	println("She said, \"V is fast!\"")
}
```

---

### Declare Raw Strings

_File location: [primitive_types/03_string_type/02_operations_on_string_types/02_string_manipulation/02_declare_raw_strings/02_declare_raw_strings.v](file:///Users/codecaine/V-Programming-Comprehensive-Guide/primitive_types/03_string_type/02_operations_on_string_types/02_string_manipulation/02_declare_raw_strings/02_declare_raw_strings.v)_

### Lesson: Declare Raw Strings

If you want to write a string literal where escape sequences (like `\n`) are treated as literal text instead of special commands, you can declare a **raw string** by prefixing the string literal with `r` (e.g., `r\'hello\nworld\'`).

This is extremely useful when writing regular expressions or file paths.

**Additional Context from Repository docs:**
This example demonstrates the concepts of **declare raw strings**.

```v
module main

fn main() {
	i := r'hi \how are you/?'
	println(i)
}
```

---

### String Concatenation Using Plus Sign

_File location: [primitive_types/03_string_type/02_operations_on_string_types/02_string_manipulation/03_string_concatenation_using_plus_sign/03_string_concatenation_using_plus_sign.v](file:///Users/codecaine/V-Programming-Comprehensive-Guide/primitive_types/03_string_type/02_operations_on_string_types/02_string_manipulation/03_string_concatenation_using_plus_sign/03_string_concatenation_using_plus_sign.v)_

### Lesson: String Concatenation Using Plus Sign

In V, primitive data types are the core building blocks of the language. This section details how to declare and use **String Concatenation Using Plus Sign** in a simple, straightforward manner. Beginners should pay close attention to how variables of this type are initialized and how built-in methods are called on them.

**Additional Context from Repository docs:**
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

---

### String Concatenation Using Interpolation

_File location: [primitive_types/03_string_type/02_operations_on_string_types/02_string_manipulation/04_string_concatenation_using_interpolation/04_string_concatenation_using_interpolation.v](file:///Users/codecaine/V-Programming-Comprehensive-Guide/primitive_types/03_string_type/02_operations_on_string_types/02_string_manipulation/04_string_concatenation_using_interpolation/04_string_concatenation_using_interpolation.v)_

### Lesson: String Concatenation Using Interpolation

In V, primitive data types are the core building blocks of the language. This section details how to declare and use **String Concatenation Using Interpolation** in a simple, straightforward manner. Beginners should pay close attention to how variables of this type are initialized and how built-in methods are called on them.

**Additional Context from Repository docs:**
This example demonstrates the concepts of **string concatenation using interpolation**.

```v
module main

fn main() {
	i := 1
	j := 'man army'
	println('${i} ${j}')
}
```

---

### Extract Substring From String Literal

_File location: [primitive_types/03_string_type/02_operations_on_string_types/02_string_manipulation/05_extract_substring_from_string_literal/05_extract_substring_from_string_literal.v](file:///Users/codecaine/V-Programming-Comprehensive-Guide/primitive_types/03_string_type/02_operations_on_string_types/02_string_manipulation/05_extract_substring_from_string_literal/05_extract_substring_from_string_literal.v)_

### Lesson: Extract Substring From String Literal

V provides two main techniques to extract substrings from a string literal or variable:

1. **The `.substr(start, end)` Method**: Takes the starting index (inclusive) and ending index (exclusive) as parameters.
2. **Range Slicing Syntax `[start..end]`**: A clean and idiomatic syntax (similar to Go and Rust) where you specify range offsets. If the starting index is omitted (e.g. `[..end]`), it defaults to `0`. If the ending index is omitted (e.g. `[start..]`), it defaults to the length of the string.

Both techniques are demonstrated in the example below.

**Additional Context from Repository docs:**
This example demonstrates the concepts of **extract substring from string literal**.

```v
module main

fn main() {
	a := 'Camel'

	// Method 1: Using the substr(start, end) method
	// Extracts characters from index 0 up to (but not including) index 3
	b := a.substr(0, 3)
	println(b) // Output: Cam

	// Method 2: Using idiomatic range slicing syntax [start..end] (similar to Go/Rust)
	// Slices from index 1 up to (but not including) index 4
	c := a[1..4]
	println(c) // Output: ame

	// Method 3: Slicing from start to index [..end]
	// If the start index is omitted, it defaults to 0
	d := a[..3]
	println(d) // Output: Cam

	// Method 4: Slicing from index to end [start..]
	// If the end index is omitted, it defaults to the string length
	e := a[2..]
	println(e) // Output: mel
}
```

---

### Split String

_File location: [primitive_types/03_string_type/02_operations_on_string_types/02_string_manipulation/06_split_string/06_split_string.v](file:///Users/codecaine/V-Programming-Comprehensive-Guide/primitive_types/03_string_type/02_operations_on_string_types/02_string_manipulation/06_split_string/06_split_string.v)_

### Lesson: Split String

In V, primitive data types are the core building blocks of the language. This section details how to declare and use **Split String** in a simple, straightforward manner. Beginners should pay close attention to how variables of this type are initialized and how built-in methods are called on them.

**Additional Context from Repository docs:**
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

---

### String To Runes Array

_File location: [primitive_types/03_string_type/02_operations_on_string_types/02_string_manipulation/07_string_to_runes_array/07_string_to_runes_array.v](file:///Users/codecaine/V-Programming-Comprehensive-Guide/primitive_types/03_string_type/02_operations_on_string_types/02_string_manipulation/07_string_to_runes_array/07_string_to_runes_array.v)_

### Lesson: String To Runes Array

In V, primitive data types are the core building blocks of the language. This section details how to declare and use **String To Runes Array** in a simple, straightforward manner. Beginners should pay close attention to how variables of this type are initialized and how built-in methods are called on them.

**Additional Context from Repository docs:**
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

---

### Count Sub String Occurences

_File location: [primitive_types/03_string_type/02_operations_on_string_types/02_string_manipulation/08_count_sub_string_occurences/08_count_sub_string_occurences.v](file:///Users/codecaine/V-Programming-Comprehensive-Guide/primitive_types/03_string_type/02_operations_on_string_types/02_string_manipulation/08_count_sub_string_occurences/08_count_sub_string_occurences.v)_

### Lesson: Count Sub String Occurences

In V, primitive data types are the core building blocks of the language. This section details how to declare and use **Count Sub String Occurences** in a simple, straightforward manner. Beginners should pay close attention to how variables of this type are initialized and how built-in methods are called on them.

**Additional Context from Repository docs:**
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

---

### Check String Contains Substring

_File location: [primitive_types/03_string_type/02_operations_on_string_types/02_string_manipulation/09_check_string_contains_substring/09_check_string_contains_substring.v](file:///Users/codecaine/V-Programming-Comprehensive-Guide/primitive_types/03_string_type/02_operations_on_string_types/02_string_manipulation/09_check_string_contains_substring/09_check_string_contains_substring.v)_

### Lesson: Check String Contains Substring

In V, primitive data types are the core building blocks of the language. This section details how to declare and use **Check String Contains Substring** in a simple, straightforward manner. Beginners should pay close attention to how variables of this type are initialized and how built-in methods are called on them.

**Additional Context from Repository docs:**
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

---

### String Contains Is Case Sensitive

_File location: [primitive_types/03_string_type/02_operations_on_string_types/02_string_manipulation/10_string_contains_is_case_sensitive/10_string_contains_is_case_sensitive.v](file:///Users/codecaine/V-Programming-Comprehensive-Guide/primitive_types/03_string_type/02_operations_on_string_types/02_string_manipulation/10_string_contains_is_case_sensitive/10_string_contains_is_case_sensitive.v)_

### Lesson: String Contains Is Case Sensitive

In V, primitive data types are the core building blocks of the language. This section details how to declare and use **String Contains Is Case Sensitive** in a simple, straightforward manner. Beginners should pay close attention to how variables of this type are initialized and how built-in methods are called on them.

**Additional Context from Repository docs:**
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

---

### Common String Methods

_File location: [primitive_types/03_string_type/02_operations_on_string_types/02_string_manipulation/11_common_string_methods/11_common_string_methods.v](file:///Users/codecaine/V-Programming-Comprehensive-Guide/primitive_types/03_string_type/02_operations_on_string_types/02_string_manipulation/11_common_string_methods/11_common_string_methods.v)_

### Lesson: Common String Methods

In V, primitive data types are the core building blocks of the language. This section details how to declare and use **Common String Methods** in a simple, straightforward manner. Beginners should pay close attention to how variables of this type are initialized and how built-in methods are called on them.

**Additional Context from Repository docs:**
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

---

# Chapter 4: Control Flow

## Quick Access

Below is an index of all code examples in this chapter. You can use these links to jump directly to any specific code example:

**Control Flow Extras**

- [Chaining Else If](#chaining-else-if)
- [If With Goto](#if-with-goto)
- [Cascade Match Conditions](#cascade-match-conditions)
- [Match As Switch Case](#match-as-switch-case)
- [Match Pattern Matching](#match-pattern-matching)
- [Match With Enum](#match-with-enum)
- [Match With Enum And Else](#match-with-enum-and-else)
- [Bare For](#bare-for)
- [Break For](#break-for)
- [Continue For](#continue-for)
- [For C Style](#for-c-style)
- [For On Array Without Index](#for-on-array-without-index)
- [For On Arrays](#for-on-arrays)
- [For On Maps](#for-on-maps)
- [For On Maps Ignore Key](#for-on-maps-ignore-key)
- [For On Range](#for-on-range)
- [For With Continue Break And Labels](#for-with-continue-break-and-labels)
- [Reverse For](#reverse-for)

---

Control flow determines the execution path of your code. In this chapter, we cover conditionals (`if-else`), pattern matching (`match`), and the versatile `for` loop. V simplifies control flow by using fewer keywords, making code highly readable.

## Control Flow Extras

### Chaining Else If

_File location: [control_flow/01_If_Statement/chaining_else_if/chaining_else_if.v](file:///Users/codecaine/V-Programming-Comprehensive-Guide/control_flow/01_If_Statement/chaining_else_if/chaining_else_if.v)_

### Lesson: Chaining Else If

Control flow structures allow your program to decide which path of execution to take. This example demonstrates the usage of **Chaining Else If** in V, showing how to control execution paths cleanly and safely.

**Additional Context from Repository docs:**
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

---

### If With Goto

_File location: [control_flow/01_If_Statement/if_with_goto/if_with_goto.v](file:///Users/codecaine/V-Programming-Comprehensive-Guide/control_flow/01_If_Statement/if_with_goto/if_with_goto.v)_

### Lesson: If With Goto

Control flow structures allow your program to decide which path of execution to take. This example demonstrates the usage of **If With Goto** in V, showing how to control execution paths cleanly and safely.

**Additional Context from Repository docs:**
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

---

### Cascade Match Conditions

_File location: [control_flow/02_Match/cascade_match_conditions/cascade_match_conditions.v](file:///Users/codecaine/V-Programming-Comprehensive-Guide/control_flow/02_Match/cascade_match_conditions/cascade_match_conditions.v)_

### Lesson: Cascade Match Conditions

Control flow structures allow your program to decide which path of execution to take. This example demonstrates the usage of **Cascade Match Conditions** in V, showing how to control execution paths cleanly and safely.

**Additional Context from Repository docs:**
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

---

### Match As Switch Case

_File location: [control_flow/02_Match/match_as_switch_case/match_as_switch_case.v](file:///Users/codecaine/V-Programming-Comprehensive-Guide/control_flow/02_Match/match_as_switch_case/match_as_switch_case.v)_

### Lesson: Match As Switch Case

Control flow structures allow your program to decide which path of execution to take. This example demonstrates the usage of **Match As Switch Case** in V, showing how to control execution paths cleanly and safely.

**Additional Context from Repository docs:**
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

---

### Match Pattern Matching

_File location: [control_flow/02_Match/match_pattern_matching/match_pattern_matching.v](file:///Users/codecaine/V-Programming-Comprehensive-Guide/control_flow/02_Match/match_pattern_matching/match_pattern_matching.v)_

### Lesson: Match Pattern Matching

Control flow structures allow your program to decide which path of execution to take. This example demonstrates the usage of **Match Pattern Matching** in V, showing how to control execution paths cleanly and safely.

**Additional Context from Repository docs:**
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

---

### Match With Enum

_File location: [control_flow/02_Match/match_with_enum/match_with_enum.v](file:///Users/codecaine/V-Programming-Comprehensive-Guide/control_flow/02_Match/match_with_enum/match_with_enum.v)_

### Lesson: Match With Enum

Control flow structures allow your program to decide which path of execution to take. This example demonstrates the usage of **Match With Enum** in V, showing how to control execution paths cleanly and safely.

**Additional Context from Repository docs:**
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

---

### Match With Enum And Else

_File location: [control_flow/02_Match/match_with_enum_and_else/match_with_enum_and_else.v](file:///Users/codecaine/V-Programming-Comprehensive-Guide/control_flow/02_Match/match_with_enum_and_else/match_with_enum_and_else.v)_

### Lesson: Match With Enum And Else

Control flow structures allow your program to decide which path of execution to take. This example demonstrates the usage of **Match With Enum And Else** in V, showing how to control execution paths cleanly and safely.

**Additional Context from Repository docs:**
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

---

### Bare For

_File location: [control_flow/03_Iterative_statements/bare_for/bare_for.v](file:///Users/codecaine/V-Programming-Comprehensive-Guide/control_flow/03_Iterative_statements/bare_for/bare_for.v)_

### Lesson: Bare For

Control flow structures allow your program to decide which path of execution to take. This example demonstrates the usage of **Bare For** in V, showing how to control execution paths cleanly and safely.

**Additional Context from Repository docs:**
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

---

### Break For

_File location: [control_flow/03_Iterative_statements/break_for/break_for.v](file:///Users/codecaine/V-Programming-Comprehensive-Guide/control_flow/03_Iterative_statements/break_for/break_for.v)_

### Lesson: Break For

Control flow structures allow your program to decide which path of execution to take. This example demonstrates the usage of **Break For** in V, showing how to control execution paths cleanly and safely.

**Additional Context from Repository docs:**
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

---

### Continue For

_File location: [control_flow/03_Iterative_statements/continue_for/continue_for.v](file:///Users/codecaine/V-Programming-Comprehensive-Guide/control_flow/03_Iterative_statements/continue_for/continue_for.v)_

### Lesson: Continue For

Control flow structures allow your program to decide which path of execution to take. This example demonstrates the usage of **Continue For** in V, showing how to control execution paths cleanly and safely.

**Additional Context from Repository docs:**
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

---

### For C Style

_File location: [control_flow/03_Iterative_statements/for_c_style/for_c_style.v](file:///Users/codecaine/V-Programming-Comprehensive-Guide/control_flow/03_Iterative_statements/for_c_style/for_c_style.v)_

### Lesson: For C Style

Control flow structures allow your program to decide which path of execution to take. This example demonstrates the usage of **For C Style** in V, showing how to control execution paths cleanly and safely.

**Additional Context from Repository docs:**
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

---

### For On Array Without Index

_File location: [control_flow/03_Iterative_statements/for_on_array_without_index/for_on_array_without_index.v](file:///Users/codecaine/V-Programming-Comprehensive-Guide/control_flow/03_Iterative_statements/for_on_array_without_index/for_on_array_without_index.v)_

### Lesson: For On Array Without Index

Control flow structures allow your program to decide which path of execution to take. This example demonstrates the usage of **For On Array Without Index** in V, showing how to control execution paths cleanly and safely.

**Additional Context from Repository docs:**
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

---

### For On Arrays

_File location: [control_flow/03_Iterative_statements/for_on_arrays/for_on_arrays.v](file:///Users/codecaine/V-Programming-Comprehensive-Guide/control_flow/03_Iterative_statements/for_on_arrays/for_on_arrays.v)_

### Lesson: For On Arrays

Control flow structures allow your program to decide which path of execution to take. This example demonstrates the usage of **For On Arrays** in V, showing how to control execution paths cleanly and safely.

**Additional Context from Repository docs:**
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

---

### For On Maps

_File location: [control_flow/03_Iterative_statements/for_on_maps/for_on_maps.v](file:///Users/codecaine/V-Programming-Comprehensive-Guide/control_flow/03_Iterative_statements/for_on_maps/for_on_maps.v)_

### Lesson: For On Maps

Control flow structures allow your program to decide which path of execution to take. This example demonstrates the usage of **For On Maps** in V, showing how to control execution paths cleanly and safely.

**Additional Context from Repository docs:**
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

---

### For On Maps Ignore Key

_File location: [control_flow/03_Iterative_statements/for_on_maps_ignore_key/for_on_maps_ignore_key.v](file:///Users/codecaine/V-Programming-Comprehensive-Guide/control_flow/03_Iterative_statements/for_on_maps_ignore_key/for_on_maps_ignore_key.v)_

### Lesson: For On Maps Ignore Key

Control flow structures allow your program to decide which path of execution to take. This example demonstrates the usage of **For On Maps Ignore Key** in V, showing how to control execution paths cleanly and safely.

**Additional Context from Repository docs:**
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

---

### For On Range

_File location: [control_flow/03_Iterative_statements/for_on_range/for_on_range.v](file:///Users/codecaine/V-Programming-Comprehensive-Guide/control_flow/03_Iterative_statements/for_on_range/for_on_range.v)_

### Lesson: For On Range

Control flow structures allow your program to decide which path of execution to take. This example demonstrates the usage of **For On Range** in V, showing how to control execution paths cleanly and safely.

**Additional Context from Repository docs:**
This example demonstrates the concepts of **for on range**.

```v
module main

fn main() {
	for val in 0 .. 4 {
		println(val)
	}
}
```

---

### For With Continue Break And Labels

_File location: [control_flow/03_Iterative_statements/for_with_continue_break_and_labels/for_with_continue_break_and_labels.v](file:///Users/codecaine/V-Programming-Comprehensive-Guide/control_flow/03_Iterative_statements/for_with_continue_break_and_labels/for_with_continue_break_and_labels.v)_

### Lesson: For With Continue Break And Labels

Control flow structures allow your program to decide which path of execution to take. This example demonstrates the usage of **For With Continue Break And Labels** in V, showing how to control execution paths cleanly and safely.

**Additional Context from Repository docs:**
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

---

### Reverse For

_File location: [control_flow/03_Iterative_statements/reverse_for/reverse_for.v](file:///Users/codecaine/V-Programming-Comprehensive-Guide/control_flow/03_Iterative_statements/reverse_for/reverse_for.v)_

### Lesson: Reverse For

Control flow structures allow your program to decide which path of execution to take. This example demonstrates the usage of **Reverse For** in V, showing how to control execution paths cleanly and safely.

**Additional Context from Repository docs:**
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

---

# Chapter 5: Collections: Arrays and Maps

## Quick Access

Below is an index of all code examples in this chapter. You can use these links to jump directly to any specific code example:

**Arrays**

- [Declare And Initialize](#declare-and-initialize)
- [Declare Empty Array](#declare-empty-array)
- [Declare Array With Len](#declare-array-with-len)
- [Declare Array With Init And Len](#declare-array-with-init-and-len)
- [Declare Array With Cap](#declare-array-with-cap)
- [Working With Array Properties](#working-with-array-properties)
- [Access Array Elements Using Index](#access-array-elements-using-index)
- [Access Array Elements Using Slices](#access-array-elements-using-slices)
- [In Operator With Array](#in-operator-with-array)
- [Append Array](#append-array)
- [Define Fixed Size Array](#define-fixed-size-array)
- [Update Fixed Size Array Elements](#update-fixed-size-array-elements)
- [Determining Type Of Fixed Array](#determining-type-of-fixed-array)
- [Slicing Fixed Size Array Results In Ordinary Array](#slicing-fixed-size-array-results-in-ordinary-array)
- [Declaring Multi Dimensional Arrays](#declaring-multi-dimensional-arrays)
- [Updating Multi Dimensional Array Indices](#updating-multi-dimensional-array-indices)
- [Reassigning Multi Dimensional Arrays](#reassigning-multi-dimensional-arrays)
- [Clone Array](#clone-array)
- [Copy Array](#copy-array)
- [Sort Integer Array](#sort-integer-array)
- [Sort String Array](#sort-string-array)
- [Sort Struct Array](#sort-struct-array)
- [Filter Array](#filter-array)
- [Filter With Anonymous Funcs On Array](#filter-with-anonymous-funcs-on-array)
- [Map Array Items](#map-array-items)
- [Map Using Anonymous Funcs On Array](#map-using-anonymous-funcs-on-array)
- [Array Methods](#array-methods)

**Maps**

- [Explicit Map Initialization](#explicit-map-initialization)
- [Short Syntax Initialization Of Map](#short-syntax-initialization-of-map)
- [Count Key Value Pairs In Map](#count-key-value-pairs-in-map)
- [Value Given Key Of Map](#value-given-key-of-map)
- [Value Given Non Existent Key Of Map](#value-given-non-existent-key-of-map)
- [Handling Missing Keys In Map](#handling-missing-keys-in-map)
- [Update Value Given A Key In Map](#update-value-given-a-key-in-map)
- [Delete Key Value Pair From Map](#delete-key-value-pair-from-map)
- [Map Methods](#map-methods)

---

Collections allow you to group multiple data items together. V provides two primary built-in collection types: **arrays** (ordered lists of elements) and **maps** (key-value dictionaries). This chapter covers creating, accessing, and manipulating these collections using modern functional patterns like `map` and `filter`.

## Arrays

### Declare And Initialize

_File location: [arrays_and_maps/01_arrays/01_array_declaration/01_declare_and_initialize/01_declare_and_initialize.v](file:///Users/codecaine/V-Programming-Comprehensive-Guide/arrays_and_maps/01_arrays/01_array_declaration/01_declare_and_initialize/01_declare_and_initialize.v)_

### Lesson: Declare And Initialize

An **array** is a collection of elements of the same type. In V, arrays are declared using square brackets. They are index-based, dynamically sized, and provide built-in methods like `map()`, `filter()`, and `sort()` for functional-style manipulation.

These examples show how to initialize, append, clone, copy, and manipulate arrays.

**Additional Context from Repository docs:**
This example demonstrates the concepts of **declare and initialize**.

```v
fn main() {
	mut sports := ['cricket', 'hockey', 'football']
	println(sports)
}
```

---

### Declare Empty Array

_File location: [arrays_and_maps/01_arrays/01_array_declaration/02_declare_empty_array/02_declare_empty_array.v](file:///Users/codecaine/V-Programming-Comprehensive-Guide/arrays_and_maps/01_arrays/01_array_declaration/02_declare_empty_array/02_declare_empty_array.v)_

### Lesson: Declare Empty Array

An **array** is a collection of elements of the same type. In V, arrays are declared using square brackets. They are index-based, dynamically sized, and provide built-in methods like `map()`, `filter()`, and `sort()` for functional-style manipulation.

These examples show how to initialize, append, clone, copy, and manipulate arrays.

**Additional Context from Repository docs:**
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

---

### Declare Array With Len

_File location: [arrays_and_maps/01_arrays/01_array_declaration/03_declare_array_with_len/03_declare_array_with_len.v](file:///Users/codecaine/V-Programming-Comprehensive-Guide/arrays_and_maps/01_arrays/01_array_declaration/03_declare_array_with_len/03_declare_array_with_len.v)_

### Lesson: Declare Array With Len

An **array** is a collection of elements of the same type. In V, arrays are declared using square brackets. They are index-based, dynamically sized, and provide built-in methods like `map()`, `filter()`, and `sort()` for functional-style manipulation.

These examples show how to initialize, append, clone, copy, and manipulate arrays.

**Additional Context from Repository docs:**
This example demonstrates the concepts of **declare array with len**.

```v
fn main() {
	mut i := []int{len: 3}
	println(i)
}
```

---

### Declare Array With Init And Len

_File location: [arrays_and_maps/01_arrays/01_array_declaration/04_declare_array_with_init_and_len/04_declare_array_with_init_and_len.v](file:///Users/codecaine/V-Programming-Comprehensive-Guide/arrays_and_maps/01_arrays/01_array_declaration/04_declare_array_with_init_and_len/04_declare_array_with_init_and_len.v)_

### Lesson: Declare Array With Init And Len

An **array** is a collection of elements of the same type. In V, arrays are declared using square brackets. They are index-based, dynamically sized, and provide built-in methods like `map()`, `filter()`, and `sort()` for functional-style manipulation.

These examples show how to initialize, append, clone, copy, and manipulate arrays.

**Additional Context from Repository docs:**
This example demonstrates the concepts of **declare array with init and len**.

```v
fn main() {
	mut j := []int{len: 3, init: 1}
	println(j)
}
```

---

### Declare Array With Cap

_File location: [arrays_and_maps/01_arrays/01_array_declaration/05_declare_array_with_cap/05_declare_array_with_cap.v](file:///Users/codecaine/V-Programming-Comprehensive-Guide/arrays_and_maps/01_arrays/01_array_declaration/05_declare_array_with_cap/05_declare_array_with_cap.v)_

### Lesson: Declare Array With Cap

An **array** is a collection of elements of the same type. In V, arrays are declared using square brackets. They are index-based, dynamically sized, and provide built-in methods like `map()`, `filter()`, and `sort()` for functional-style manipulation.

These examples show how to initialize, append, clone, copy, and manipulate arrays.

**Additional Context from Repository docs:**
This example demonstrates the concepts of **declare array with cap**.

```v
fn main() {
	mut k := []int{cap: 2}
	println(k)
}
```

---

### Working With Array Properties

_File location: [arrays_and_maps/01_arrays/02_array_properties/01_working_with_array_properties.v](file:///Users/codecaine/V-Programming-Comprehensive-Guide/arrays_and_maps/01_arrays/02_array_properties/01_working_with_array_properties.v)_

### Lesson: Working With Array Properties

An **array** is a collection of elements of the same type. In V, arrays are declared using square brackets. They are index-based, dynamically sized, and provide built-in methods like `map()`, `filter()`, and `sort()` for functional-style manipulation.

These examples show how to initialize, append, clone, copy, and manipulate arrays.

**Additional Context from Repository docs:**
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

---

### Access Array Elements Using Index

_File location: [arrays_and_maps/01_arrays/03_accessing_array_elements/01_access_array_elements_using_index/01_access_array_elements_using_index.v](file:///Users/codecaine/V-Programming-Comprehensive-Guide/arrays_and_maps/01_arrays/03_accessing_array_elements/01_access_array_elements_using_index/01_access_array_elements_using_index.v)_

### Lesson: Access Array Elements Using Index

An **array** is a collection of elements of the same type. In V, arrays are declared using square brackets. They are index-based, dynamically sized, and provide built-in methods like `map()`, `filter()`, and `sort()` for functional-style manipulation.

These examples show how to initialize, append, clone, copy, and manipulate arrays.

**Additional Context from Repository docs:**
This example demonstrates the concepts of **access array elements using index**.

```v
fn main() {
	mut sports := ['cricket', 'hockey', 'football']
	s := sports[1]
	println(s) // hockey
}
```

---

### Access Array Elements Using Slices

_File location: [arrays_and_maps/01_arrays/03_accessing_array_elements/02_access_array_elements_using_slices/02_access_array_elements_using_slices.v](file:///Users/codecaine/V-Programming-Comprehensive-Guide/arrays_and_maps/01_arrays/03_accessing_array_elements/02_access_array_elements_using_slices/02_access_array_elements_using_slices.v)_

### Lesson: Access Array Elements Using Slices

An **array** is a collection of elements of the same type. In V, you can retrieve a subset of elements by slicing the array. Slicing uses the `[start..end]` syntax, which creates a new array containing elements from the `start` index up to (but not including) the `end` index.

#### Positive Slicing

Positive indices represent offsets from the beginning of the array (starting at `0`). For example, `sports[1..3]` returns a slice from index `1` to `2`.

#### Negative Slicing

V does not support negative indices natively in slices (e.g., `sports[-2..]` will cause a compiler error). To achieve the effect of negative slicing (indexing from the end of the array), you calculate the start and/or end index using the array's `.len` property:

- **Excluding the last element**: `sports[..sports.len - 1]` (equivalent to Python's `sports[..-1]`)
- **Range from the end**: `sports[sports.len - 3 .. sports.len - 1]` (equivalent to Python's `sports[-3..-1]`)
- **Last N elements**: `sports[sports.len - 2 ..]` (equivalent to Python's `sports[-2..]`)

#### Slices are References

> [!IMPORTANT]
> In V, **slices are reference views** of the original array, not copies.
>
> - Modifying any element inside a slice **will modify the original array**.
> - Assigning a slice to a variable is considered unsafe/restricted unless you wrap it in an `unsafe` block (`mut sl := unsafe { arr[1..4] }`) or clone it explicitly.
> - To get a separate array slice by value (so modifications do not affect the original array), append `.clone()` to the end of the slice expression (`mut sl_copy := arr[1..4].clone()`).

**Additional Context from Repository docs:**
This example demonstrates the concepts of **access array elements using slices**, including positive slicing, `.len`-based negative slicing, reference mutation via `unsafe` blocks, and copying by value with `.clone()`.

```v
fn main() {
	mut sports := ['cricket', 'hockey', 'football', 'basketball', 'tennis']

	// Positive slicing: from index 1 to 3 (excluding index 3)
	println(sports[1..3]) // ['hockey', 'football']

	// V does not support negative indices natively in slices (e.g., sports[-2..] will not compile).
	// To achieve "negative slicing" (indexing from the end of the array), use the `.len` property:

	// Slice up to the last element (excluding it): Python's sports[..-1]
	println(sports[..sports.len - 1]) // ['cricket', 'hockey', 'football', 'basketball']

	// Slice from 3rd to last up to 1st to last (excluding it): Python's sports[-3..-1]
	println(sports[sports.len - 3..sports.len - 1]) // ['football', 'basketball']

	// Slice the last two elements: Python's sports[-2..]
	println(sports[sports.len - 2..]) // ['basketball', 'tennis']

	// --- REFERENCE VS VALUE BEHAVIOR ---
	// In V, slices are reference views of the original array.
	// If you modify an element of a slice, it affects the original array.
	// Note: To prevent unsafe behavior, assigning a slice to a variable requires an `unsafe` block
	// if you want it by-reference, or an explicit `.clone()` to get a copy by-value.

	// 1. Modifying by reference (using unsafe)
	mut original := [10, 20, 30, 40, 50]
	mut ref_slice := unsafe { original[1..4] }
	ref_slice[0] = 99
	println(original) // [10, 99, 30, 40, 50] (Original is modified!)

	// 2. Modifying by value (using .clone())
	mut original_two := [10, 20, 30, 40, 50]
	mut val_slice := original_two[1..4].clone()
	val_slice[0] = 99
	println(original_two) // [10, 20, 30, 40, 50] (Original remains unchanged!)
}
```

---

### In Operator With Array

_File location: [arrays_and_maps/01_arrays/04_array_operators/01_in_operator_with_array/01_in_operator_with_array.v](file:///Users/codecaine/V-Programming-Comprehensive-Guide/arrays_and_maps/01_arrays/04_array_operators/01_in_operator_with_array/01_in_operator_with_array.v)_

### Lesson: In Operator With Array

An **array** is a collection of elements of the same type. In V, arrays are declared using square brackets. They are index-based, dynamically sized, and provide built-in methods like `map()`, `filter()`, and `sort()` for functional-style manipulation.

These examples show how to initialize, append, clone, copy, and manipulate arrays.

**Additional Context from Repository docs:**
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

---

### Append Array

_File location: [arrays_and_maps/01_arrays/04_array_operators/02_append_array/02_append_array.v](file:///Users/codecaine/V-Programming-Comprehensive-Guide/arrays_and_maps/01_arrays/04_array_operators/02_append_array/02_append_array.v)_

### Lesson: Append Array

An **array** is a collection of elements of the same type. In V, arrays are declared using square brackets. They are index-based, dynamically sized, and provide built-in methods like `map()`, `filter()`, and `sort()` for functional-style manipulation.

These examples show how to initialize, append, clone, copy, and manipulate arrays.

**Additional Context from Repository docs:**
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

---

### Define Fixed Size Array

_File location: [arrays_and_maps/01_arrays/05_fixed_size_arrays/01_define_fixed_size_array/01_define_fixed_size_array.v](file:///Users/codecaine/V-Programming-Comprehensive-Guide/arrays_and_maps/01_arrays/05_fixed_size_arrays/01_define_fixed_size_array/01_define_fixed_size_array.v)_

### Lesson: Define Fixed Size Array

An **array** is a collection of elements of the same type. In V, arrays are declared using square brackets. They are index-based, dynamically sized, and provide built-in methods like `map()`, `filter()`, and `sort()` for functional-style manipulation.

These examples show how to initialize, append, clone, copy, and manipulate arrays.

**Additional Context from Repository docs:**
This example demonstrates the concepts of **define fixed size array**.

```v
fn main() {
	mut fix := [4]int{}
	println(fix)
	// [0, 0, 0, 0]
}
```

---

### Update Fixed Size Array Elements

_File location: [arrays_and_maps/01_arrays/05_fixed_size_arrays/02_update_fixed_size_array_elements/02_update_fixed_size_array_elements.v](file:///Users/codecaine/V-Programming-Comprehensive-Guide/arrays_and_maps/01_arrays/05_fixed_size_arrays/02_update_fixed_size_array_elements/02_update_fixed_size_array_elements.v)_

### Lesson: Update Fixed Size Array Elements

An **array** is a collection of elements of the same type. In V, arrays are declared using square brackets. They are index-based, dynamically sized, and provide built-in methods like `map()`, `filter()`, and `sort()` for functional-style manipulation.

These examples show how to initialize, append, clone, copy, and manipulate arrays.

**Additional Context from Repository docs:**
This example demonstrates the concepts of **update fixed size array elements**.

```v
fn main() {
	mut fix := [4]int{}
	fix[1] = 33
	println(fix)
	//[0, 33, 0, 0]
}
```

---

### Determining Type Of Fixed Array

_File location: [arrays_and_maps/01_arrays/05_fixed_size_arrays/03_determining_type_of_fixed_array/03_determining_type_of_fixed_array.v](file:///Users/codecaine/V-Programming-Comprehensive-Guide/arrays_and_maps/01_arrays/05_fixed_size_arrays/03_determining_type_of_fixed_array/03_determining_type_of_fixed_array.v)_

### Lesson: Determining Type Of Fixed Array

An **array** is a collection of elements of the same type. In V, arrays are declared using square brackets. They are index-based, dynamically sized, and provide built-in methods like `map()`, `filter()`, and `sort()` for functional-style manipulation.

These examples show how to initialize, append, clone, copy, and manipulate arrays.

**Additional Context from Repository docs:**
This example demonstrates the concepts of **determining type of fixed array**.

```v
fn main() {
	mut fix := [4]int{}
	println(typeof(fix).name) // [4]int
}
```

---

### Slicing Fixed Size Array Results In Ordinary Array

_File location: [arrays_and_maps/01_arrays/05_fixed_size_arrays/04_slicing_fixed_size_array_results_in_ordinary_array/04_slicing_fixed_size_array_results_in_ordinary_array.v](file:///Users/codecaine/V-Programming-Comprehensive-Guide/arrays_and_maps/01_arrays/05_fixed_size_arrays/04_slicing_fixed_size_array_results_in_ordinary_array/04_slicing_fixed_size_array_results_in_ordinary_array.v)_

### Lesson: Slicing Fixed Size Array Results In Ordinary Array

An **array** is a collection of elements of the same type. In V, arrays are declared using square brackets. They are index-based, dynamically sized, and provide built-in methods like `map()`, `filter()`, and `sort()` for functional-style manipulation.

These examples show how to initialize, append, clone, copy, and manipulate arrays.

**Additional Context from Repository docs:**
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

---

### Declaring Multi Dimensional Arrays

_File location: [arrays_and_maps/01_arrays/06_multi_dimensional_arrays/01_declaring_multi_dimensional_arrays/01_declaring_multi_dimensional_arrays.v](file:///Users/codecaine/V-Programming-Comprehensive-Guide/arrays_and_maps/01_arrays/06_multi_dimensional_arrays/01_declaring_multi_dimensional_arrays/01_declaring_multi_dimensional_arrays.v)_

### Lesson: Declaring Multi Dimensional Arrays

An **array** is a collection of elements of the same type. In V, arrays are declared using square brackets. They are index-based, dynamically sized, and provide built-in methods like `map()`, `filter()`, and `sort()` for functional-style manipulation.

These examples show how to initialize, append, clone, copy, and manipulate arrays.

**Additional Context from Repository docs:**
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

---

### Updating Multi Dimensional Array Indices

_File location: [arrays_and_maps/01_arrays/06_multi_dimensional_arrays/02_updating_multi_dimensional_arrays/02_updating_multi_dimensional_arrays.v](file:///Users/codecaine/V-Programming-Comprehensive-Guide/arrays_and_maps/01_arrays/06_multi_dimensional_arrays/02_updating_multi_dimensional_arrays/02_updating_multi_dimensional_arrays.v)_

### Lesson: Updating Multi Dimensional Array Indices

An **array** is a collection of elements of the same type. In V, arrays are declared using square brackets. They are index-based, dynamically sized, and provide built-in methods like `map()`, `filter()`, and `sort()` for functional-style manipulation.

These examples show how to initialize, append, clone, copy, and manipulate arrays.

**Additional Context from Repository docs:**
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

---

### Reassigning Multi Dimensional Arrays

_File location: [arrays_and_maps/01_arrays/06_multi_dimensional_arrays/03_updating_multi_dimensional_arrays/03_updating_multi_dimensional_arrays.v](file:///Users/codecaine/V-Programming-Comprehensive-Guide/arrays_and_maps/01_arrays/06_multi_dimensional_arrays/03_updating_multi_dimensional_arrays/03_updating_multi_dimensional_arrays.v)_

### Lesson: Reassigning Multi Dimensional Arrays

An **array** is a collection of elements of the same type. In V, arrays are declared using square brackets. They are index-based, dynamically sized, and provide built-in methods like `map()`, `filter()`, and `sort()` for functional-style manipulation.

These examples show how to initialize, append, clone, copy, and manipulate arrays.

**Additional Context from Repository docs:**
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

---

### Clone Array

_File location: [arrays_and_maps/01_arrays/07_array_operations/01_clone_array/01_clone_array/01_clone_array.v](file:///Users/codecaine/V-Programming-Comprehensive-Guide/arrays_and_maps/01_arrays/07_array_operations/01_clone_array/01_clone_array/01_clone_array.v)_

### Lesson: Clone Array

An **array** is a collection of elements of the same type. In V, arrays are declared using square brackets. They are index-based, dynamically sized, and provide built-in methods like `map()`, `filter()`, and `sort()` for functional-style manipulation.

These examples show how to initialize, append, clone, copy, and manipulate arrays.

**Additional Context from Repository docs:**
This example demonstrates the concepts of **clone array**.

```v
fn main() {
	r := [1, 2, 3, 4]
	mut u := r.clone()
	// copies the array r to u
	println(u)
}
```

---

### Copy Array

_File location: [arrays_and_maps/01_arrays/07_array_operations/01_clone_array/02_copy_array/02_copy_array.v](file:///Users/codecaine/V-Programming-Comprehensive-Guide/arrays_and_maps/01_arrays/07_array_operations/01_clone_array/02_copy_array/02_copy_array.v)_

### Lesson: Copy Array

An **array** is a collection of elements of the same type. In V, arrays are declared using square brackets. They are index-based, dynamically sized, and provide built-in methods like `map()`, `filter()`, and `sort()` for functional-style manipulation.

These examples show how to initialize, append, clone, copy, and manipulate arrays.

**Additional Context from Repository docs:**
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

---

### Sort Integer Array

_File location: [arrays_and_maps/01_arrays/07_array_operations/02_sort_array/01_sort_integer_array/01_sort_integer_array.v](file:///Users/codecaine/V-Programming-Comprehensive-Guide/arrays_and_maps/01_arrays/07_array_operations/02_sort_array/01_sort_integer_array/01_sort_integer_array.v)_

### Lesson: Sort Integer Array

An **array** is a collection of elements of the same type. In V, arrays are declared using square brackets. They are index-based, dynamically sized, and provide built-in methods like `map()`, `filter()`, and `sort()` for functional-style manipulation.

These examples show how to initialize, append, clone, copy, and manipulate arrays.

**Additional Context from Repository docs:**
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

---

### Sort String Array

_File location: [arrays_and_maps/01_arrays/07_array_operations/02_sort_array/02_sort_string_array/02_sort_string_array.v](file:///Users/codecaine/V-Programming-Comprehensive-Guide/arrays_and_maps/01_arrays/07_array_operations/02_sort_array/02_sort_string_array/02_sort_string_array.v)_

### Lesson: Sort String Array

An **array** is a collection of elements of the same type. In V, arrays are declared using square brackets. They are index-based, dynamically sized, and provide built-in methods like `map()`, `filter()`, and `sort()` for functional-style manipulation.

These examples show how to initialize, append, clone, copy, and manipulate arrays.

**Additional Context from Repository docs:**
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

---

### Sort Struct Array

_File location: [arrays_and_maps/01_arrays/07_array_operations/02_sort_array/sort_struct_array/03_sort_struct_array.v](file:///Users/codecaine/V-Programming-Comprehensive-Guide/arrays_and_maps/01_arrays/07_array_operations/02_sort_array/sort_struct_array/03_sort_struct_array.v)_

### Lesson: Sort Struct Array

An **array** is a collection of elements of the same type. In V, arrays are declared using square brackets. They are index-based, dynamically sized, and provide built-in methods like `map()`, `filter()`, and `sort()` for functional-style manipulation.

These examples show how to initialize, append, clone, copy, and manipulate arrays.

**Additional Context from Repository docs:**
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

---

### Filter Array

_File location: [arrays_and_maps/01_arrays/07_array_operations/03_filter_array/01_filter_array/01_filter_array.v](file:///Users/codecaine/V-Programming-Comprehensive-Guide/arrays_and_maps/01_arrays/07_array_operations/03_filter_array/01_filter_array/01_filter_array.v)_

### Lesson: Filter Array

An **array** is a collection of elements of the same type. In V, arrays are declared using square brackets. They are index-based, dynamically sized, and provide built-in methods like `map()`, `filter()`, and `sort()` for functional-style manipulation.

These examples show how to initialize, append, clone, copy, and manipulate arrays.

**Additional Context from Repository docs:**
This example demonstrates the concepts of **filter array**.

```v
fn main() {
	f := [1, 2, 3, 4, 5, 6, 7, 8, 9]
	multiples_of_3 := f.filter(it % 3 == 0)
	println(multiples_of_3)
	// [3, 6, 9]
}
```

---

### Filter With Anonymous Funcs On Array

_File location: [arrays_and_maps/01_arrays/07_array_operations/03_filter_array/02_filter_with_anonymous_funcs_on_array/02_filter_with_anonymous_funcs_on_array.v](file:///Users/codecaine/V-Programming-Comprehensive-Guide/arrays_and_maps/01_arrays/07_array_operations/03_filter_array/02_filter_with_anonymous_funcs_on_array/02_filter_with_anonymous_funcs_on_array.v)_

### Lesson: Filter With Anonymous Funcs On Array

An **array** is a collection of elements of the same type. In V, arrays are declared using square brackets. They are index-based, dynamically sized, and provide built-in methods like `map()`, `filter()`, and `sort()` for functional-style manipulation.

These examples show how to initialize, append, clone, copy, and manipulate arrays.

**Additional Context from Repository docs:**
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

---

### Map Array Items

_File location: [arrays_and_maps/01_arrays/07_array_operations/04_map_array/01_map_array_items/01_map_array_items.v](file:///Users/codecaine/V-Programming-Comprehensive-Guide/arrays_and_maps/01_arrays/07_array_operations/04_map_array/01_map_array_items/01_map_array_items.v)_

### Lesson: Map Array Items

An **array** is a collection of elements of the same type. In V, arrays are declared using square brackets. They are index-based, dynamically sized, and provide built-in methods like `map()`, `filter()`, and `sort()` for functional-style manipulation.

These examples show how to initialize, append, clone, copy, and manipulate arrays.

**Additional Context from Repository docs:**
This example demonstrates the concepts of **map array items**.

```v
fn main() {
	visitor := ['Tom', 'Ram', 'Rao']
	res := visitor.map('Mr. ' + it)
	println(res)
}
```

---

### Map Using Anonymous Funcs On Array

_File location: [arrays_and_maps/01_arrays/07_array_operations/04_map_array/02_map_using_anonymous_funcs_on_array/02_map_using_anonymous_funcs_on_array.v](file:///Users/codecaine/V-Programming-Comprehensive-Guide/arrays_and_maps/01_arrays/07_array_operations/04_map_array/02_map_using_anonymous_funcs_on_array/02_map_using_anonymous_funcs_on_array.v)_

### Lesson: Map Using Anonymous Funcs On Array

An **array** is a collection of elements of the same type. In V, arrays are declared using square brackets. They are index-based, dynamically sized, and provide built-in methods like `map()`, `filter()`, and `sort()` for functional-style manipulation.

These examples show how to initialize, append, clone, copy, and manipulate arrays.

**Additional Context from Repository docs:**
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

---

### Array Methods

_File location: [arrays_and_maps/01_arrays/08_array_methods/01_array_methods/01_array_methods.v](file:///Users/codecaine/V-Programming-Comprehensive-Guide/arrays_and_maps/01_arrays/08_array_methods/01_array_methods/01_array_methods.v)_

### Lesson: Array Methods

An **array** is a collection of elements of the same type. In V, arrays are declared using square brackets. They are index-based, dynamically sized, and provide built-in methods like `map()`, `filter()`, and `sort()` for functional-style manipulation.

These examples show how to initialize, append, clone, copy, and manipulate arrays.

**Additional Context from Repository docs:**
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

---

## Maps

### Explicit Map Initialization

_File location: [arrays_and_maps/02_maps/01_explicit_map_initialization/01_explicit_map_initialization.v](file:///Users/codecaine/V-Programming-Comprehensive-Guide/arrays_and_maps/02_maps/01_explicit_map_initialization/01_explicit_map_initialization.v)_

### Lesson: Explicit Map Initialization

A **map** is an unordered collection of key-value pairs, also known as a dictionary or associative array. In V, map keys must be strings or integer types, and values can be of any type. Maps are declared using curly braces with colon separators.

These examples cover how to initialize maps, look up keys, add or delete entries, and check if a key exists.

**Additional Context from Repository docs:**
This example demonstrates the concepts of **explicit map initialization**.

```v
fn main() {
	mut books := map[string]int{}
	books['V on Wheels'] = 320
	books['Go for Dummies'] = 279

	println(books)
}
```

---

### Short Syntax Initialization Of Map

_File location: [arrays_and_maps/02_maps/02_short_syntax_initialization_of_map/02_short_syntax_initialization_of_map.v](file:///Users/codecaine/V-Programming-Comprehensive-Guide/arrays_and_maps/02_maps/02_short_syntax_initialization_of_map/02_short_syntax_initialization_of_map.v)_

### Lesson: Short Syntax Initialization Of Map

A **map** is an unordered collection of key-value pairs, also known as a dictionary or associative array. In V, map keys must be strings or integer types, and values can be of any type. Maps are declared using curly braces with colon separators.

These examples cover how to initialize maps, look up keys, add or delete entries, and check if a key exists.

**Additional Context from Repository docs:**
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

---

### Count Key Value Pairs In Map

_File location: [arrays_and_maps/02_maps/03_count_key_value_pairs_in_map/03_count_key_value_pairs_in_map.v](file:///Users/codecaine/V-Programming-Comprehensive-Guide/arrays_and_maps/02_maps/03_count_key_value_pairs_in_map/03_count_key_value_pairs_in_map.v)_

### Lesson: Count Key Value Pairs In Map

A **map** is an unordered collection of key-value pairs, also known as a dictionary or associative array. In V, map keys must be strings or integer types, and values can be of any type. Maps are declared using curly braces with colon separators.

These examples cover how to initialize maps, look up keys, add or delete entries, and check if a key exists.

**Additional Context from Repository docs:**
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

---

### Value Given Key Of Map

_File location: [arrays_and_maps/02_maps/04_value_given_key_of_map/04_value_given_key_of_map.v](file:///Users/codecaine/V-Programming-Comprehensive-Guide/arrays_and_maps/02_maps/04_value_given_key_of_map/04_value_given_key_of_map.v)_

### Lesson: Value Given Key Of Map

A **map** is an unordered collection of key-value pairs, also known as a dictionary or associative array. In V, map keys must be strings or integer types, and values can be of any type. Maps are declared using curly braces with colon separators.

These examples cover how to initialize maps, look up keys, add or delete entries, and check if a key exists.

**Additional Context from Repository docs:**
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

---

### Value Given Non Existent Key Of Map

_File location: [arrays_and_maps/02_maps/05_value_given_non_existent_key_of_map/05_value_given_non_existent_key_of_map.v](file:///Users/codecaine/V-Programming-Comprehensive-Guide/arrays_and_maps/02_maps/05_value_given_non_existent_key_of_map/05_value_given_non_existent_key_of_map.v)_

### Lesson: Value Given Non Existent Key Of Map

A **map** is an unordered collection of key-value pairs, also known as a dictionary or associative array. In V, map keys must be strings or integer types, and values can be of any type. Maps are declared using curly braces with colon separators.

These examples cover how to initialize maps, look up keys, add or delete entries, and check if a key exists.

**Additional Context from Repository docs:**
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

---

### Handling Missing Keys In Map

_File location: [arrays_and_maps/02_maps/06_handling_missing_keys_in_map/06_handling_missing_keys_in_map.v](file:///Users/codecaine/V-Programming-Comprehensive-Guide/arrays_and_maps/02_maps/06_handling_missing_keys_in_map/06_handling_missing_keys_in_map.v)_

### Lesson: Handling Missing Keys In Map

A **map** is an unordered collection of key-value pairs, also known as a dictionary or associative array. In V, map keys must be strings or integer types, and values can be of any type. Maps are declared using curly braces with colon separators.

These examples cover how to initialize maps, look up keys, add or delete entries, and check if a key exists.

**Additional Context from Repository docs:**
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

---

### Update Value Given A Key In Map

_File location: [arrays_and_maps/02_maps/07_update_value_given_a_key_in_map/07_update_value_given_a_key_in_map.v](file:///Users/codecaine/V-Programming-Comprehensive-Guide/arrays_and_maps/02_maps/07_update_value_given_a_key_in_map/07_update_value_given_a_key_in_map.v)_

### Lesson: Update Value Given A Key In Map

A **map** is an unordered collection of key-value pairs, also known as a dictionary or associative array. In V, map keys must be strings or integer types, and values can be of any type. Maps are declared using curly braces with colon separators.

These examples cover how to initialize maps, look up keys, add or delete entries, and check if a key exists.

**Additional Context from Repository docs:**
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

---

### Delete Key Value Pair From Map

_File location: [arrays_and_maps/02_maps/08_delete_key_value_pair_from_map/08_delete_key_value_pair_from_map.v](file:///Users/codecaine/V-Programming-Comprehensive-Guide/arrays_and_maps/02_maps/08_delete_key_value_pair_from_map/08_delete_key_value_pair_from_map.v)_

### Lesson: Delete Key Value Pair From Map

A **map** is an unordered collection of key-value pairs, also known as a dictionary or associative array. In V, map keys must be strings or integer types, and values can be of any type. Maps are declared using curly braces with colon separators.

These examples cover how to initialize maps, look up keys, add or delete entries, and check if a key exists.

**Additional Context from Repository docs:**
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

---

### Map Methods

_File location: [arrays_and_maps/02_maps/09_map_methods/01_map_methods/01_map_methods.v](file:///Users/codecaine/V-Programming-Comprehensive-Guide/arrays_and_maps/02_maps/09_map_methods/01_map_methods/01_map_methods.v)_

### Lesson: Map Methods

A **map** is an unordered collection of key-value pairs, also known as a dictionary or associative array. In V, map keys must be strings or integer types, and values can be of any type. Maps are declared using curly braces with colon separators.

These examples cover how to initialize maps, look up keys, add or delete entries, and check if a key exists.

**Additional Context from Repository docs:**
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

### Import Maps Helpers

_File location: [arrays_and_maps/02_maps/09_map_methods/02_import_maps_helpers/02_import_maps_helpers.v](file:///Users/codecaine/V-Programming-Comprehensive-Guide/arrays_and_maps/02_maps/09_map_methods/02_import_maps_helpers/02_import_maps_helpers.v)_

### Lesson: Import Maps Helpers

The `maps` module provides higher-level helpers for filtering, transforming, inverting, merging, and converting between maps and arrays. These helpers are useful when you want to work with map data in a functional style without manually writing the loops yourself.

**Additional Context from Repository docs:**
This example demonstrates the concepts of **import maps helpers**.

```v
module main

import maps

fn main() {
	println('--- Import Maps Module Helpers ---')

	m1 := {
		'apple':  1
		'banana': 2
		'cherry': 3
	}

	filtered := maps.filter(m1, fn (k string, v int) bool {
		return v > 1
	})
	println('filter(): ${filtered}')

	keys_upper := maps.to_array(m1, fn (k string, v int) string {
		return k.to_upper()
	})
	println('to_array(): ${keys_upper}')

	inverted := maps.invert(m1)
	println('invert(): ${inverted}')

	fruits := ['apple', 'banana', 'cherry']
	map_from_arr := maps.from_array(fruits)
	println('from_array(): ${map_from_arr}')

	m2 := {
		'banana': 20
		'date':   4
	}
	merged := maps.merge(m1, m2)
	println('merge(): ${merged}')

	mut mut_map := {
		'a': 1
	}
	maps.merge_in_place(mut mut_map, {
		'b': 2
		'c': 3
	})
	println('merge_in_place(): ${mut_map}')

	flat_items := maps.flat_map[string, int, string](m1, fn (k string, v int) []string {
		return [k, v.str()]
	})
	println('flat_map(): ${flat_items}')

	transformed := maps.to_map[string, int, string, int](m1, fn (k string, v int) (string, int) {
		return k.to_upper(), v * 10
	})
	println('to_map(): ${transformed}')
}
```

---

# Chapter 6: Functions

## Quick Access

Below is an index of all code examples in this chapter. You can use these links to jump directly to any specific code example:

**Advanced Function Features**

- [Function Returns Value Example 1](#function-returns-value-example-1)
- [Function Returns Value Example 2](#function-returns-value-example-2)
- [Funtions Without Return Type](#funtions-without-return-type)
- [Function With Input Arguments](#function-with-input-arguments)
- [Function Return Multiple Values](#function-return-multiple-values)
- [Ignore Function Return Value](#ignore-function-return-value)
- [Function Calls Other Function](#function-calls-other-function)
- [Example 1](#example-1)
- [Example 2](#example-2)
- [Error Script Functions](#error-script-functions)
- [Script Functions](#script-functions)
- [Functions Module Variables - Main (main.v)](#functions-module-variables---main-mainv)
- [Mymod](#mymod)
- [Functions With Optional Return Types Example 1](#functions-with-optional-return-types-example-1)
- [Function With Optional Return Type Example 2](#function-with-optional-return-type-example-2)
- [Mod1](#mod1)
- [Public Function Demo1](#public-function-demo1)
- [Public Function Demo2](#public-function-demo2)
- [Public Function Demo3](#public-function-demo3)
- [Function With Defer Block](#function-with-defer-block)
- [Functions As Elements Of Array Or Map](#functions-as-elements-of-array-or-map)

**Function Extras**

- [Hello](#hello)
- [Basic Functions](#basic-functions)
- [Anonymous Functions](#anonymous-functions)
- [Functions As Input Arguments](#functions-as-input-arguments)
- [Functions That Return Other Functions](#functions-that-return-other-functions)
- [Lambda Expressions](#lambda-expressions)
- [Closures](#closures)

---

Functions let you turn repeated or complex logic into small, named building blocks. A useful mental model is: define the task, give it inputs if needed, do the work, and return a useful result. This chapter starts with simple functions and then introduces multiple returns, optional results, higher-order functions, and cleanup with `defer`.

## Advanced Function Features

### Function Returns Value Example 1

_File location: [functions/02_understanding_funtion_features/01_functions_return_or_just_perform_operations/01_functions_return_value_or_just_perform_routine/01_function_returns_value_example_1.v](file:///Users/codecaine/V-Programming-Comprehensive-Guide/functions/02_understanding_funtion_features/01_functions_return_or_just_perform_operations/01_functions_return_value_or_just_perform_routine/01_function_returns_value_example_1.v)_

### Lesson: Function Returns Value Example 1

A simple function is a small helper that turns inputs into a useful result. The basic pattern is: define the function, pass in values, do some work, and return the answer. In this example, `add` takes two integers and returns their sum.

**Additional Context from Repository docs:**
This example demonstrates the concepts of **function returns value example 1**.

```v
fn add(a int, b int) int {
	return a + b
}

fn main() {
	total := add(7, 5)
	println('7 + 5 = ${total}')
}
```

---

### Function Returns Value Example 2

_File location: [functions/02_understanding_funtion_features/01_functions_return_or_just_perform_operations/01_functions_return_value_or_just_perform_routine/02_function_returns_value_example_2.v](file:///Users/codecaine/V-Programming-Comprehensive-Guide/functions/02_understanding_funtion_features/01_functions_return_or_just_perform_operations/01_functions_return_value_or_just_perform_routine/02_function_returns_value_example_2.v)_

### Lesson: Function Returns Value Example 2

A function does not need to print anything itself. It can build a value and hand it back to the caller. Here, `say_hello` returns a greeting string, and `main` decides how to display it.

**Additional Context from Repository docs:**
This example demonstrates the concepts of **function returns value example 2**.

```v
fn say_hello(name string) string {
	return 'Hello, ${name}!'
}

fn main() {
	message := say_hello('Ada')
	println(message)
}
```

---

### Functions Without Return Type

_File location: [functions/02_understanding_funtion_features/01_functions_return_or_just_perform_operations/01_functions_return_value_or_just_perform_routine/03_funtions_without_return_type.v](file:///Users/codecaine/V-Programming-Comprehensive-Guide/functions/02_understanding_funtion_features/01_functions_return_or_just_perform_operations/01_functions_return_value_or_just_perform_routine/03_funtions_without_return_type.v)_

### Lesson: Functions Without Return Type

Some functions are used for actions rather than calculations. They may print output, write files, or update state. In that case, you can leave out the return type and focus on the side effect.

**Additional Context from Repository docs:**
This example demonstrates the concepts of **funtions without return type**.

```v
fn print_welcome_message() {
	println('Welcome to V!')
}

fn main() {
	print_welcome_message()
}
```

---

### Function With Input Arguments

_File location: [functions/02_understanding_funtion_features/02_function_and_input_arguments/01_function_with_input_arguments.v](file:///Users/codecaine/V-Programming-Comprehensive-Guide/functions/02_understanding_funtion_features/02_function_and_input_arguments/01_function_with_input_arguments.v)_

### Lesson: Function With Input Arguments

Functions become much more useful when they accept inputs. This example uses two numbers as arguments and returns their sum, showing the classic input → process → output flow.

**Additional Context from Repository docs:**
This example demonstrates the concepts of **function with input arguments**.

```v
fn add(a int, b int) int {
	return a + b
}

fn main() {
	result := add(15, 27)
	println('15 + 27 = ${result}')
}
```

---

### Function Return Multiple Values

_File location: [functions/02_understanding_funtion_features/03_function_return_multiple_values/01_function_return_multiple_values.v](file:///Users/codecaine/V-Programming-Comprehensive-Guide/functions/02_understanding_funtion_features/03_function_return_multiple_values/01_function_return_multiple_values.v)_

### Lesson: Function Return Multiple Values

A function can return more than one value when those values belong together. A common pattern is returning both the main result and a related detail, such as a length or status. Here, `greet_and_message_length` returns both the greeting and its length.

**Additional Context from Repository docs:**
This example demonstrates the concepts of **function return multiple values**.

```v
fn greet_and_message_length(name string) (string, int) {
	greeting := 'Hello, ${name}!'
	return greeting, greeting.len
}

fn main() {
	greeting, length := greet_and_message_length('Navule')
	println(greeting)
	println('Length: ${length}')
}
```

---

### Ignore Function Return Value

_File location: [functions/02_understanding_funtion_features/04_ignore_function_return_values/01_ignore_function_return_value.v](file:///Users/codecaine/V-Programming-Comprehensive-Guide/functions/02_understanding_funtion_features/04_ignore_function_return_values/01_ignore_function_return_value.v)_

### Lesson: Ignore Function Return Value

Sometimes you only care about one returned value. V lets you ignore the rest with `_`, which keeps the code readable when you are only interested in part of the result.

**Additional Context from Repository docs:**
This example demonstrates the concepts of **ignore function return value**.

```v
fn greet_and_message_length(name string) (string, int) {
	greeting := 'Hello, ${name}!'
	return greeting, greeting.len
}

fn main() {
	greeting, _ := greet_and_message_length('Navule')
	println(greeting)
}
```

---

### Function Calls Other Function

_File location: [functions/02_understanding_funtion_features/05_function_calls_other_function/01_function_calls_other_function.v](file:///Users/codecaine/V-Programming-Comprehensive-Guide/functions/02_understanding_funtion_features/05_function_calls_other_function/01_function_calls_other_function.v)_

### Lesson: Function Calls Other Function

Functions can call other functions to split a bigger problem into smaller steps. This makes the code easier to understand and easier to reuse later.

**Additional Context from Repository docs:**
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

---

### Example 1

_File location: [functions/02_understanding_funtion_features/06_allowed_function_input_argument_types/01_example_1.v](file:///Users/codecaine/V-Programming-Comprehensive-Guide/functions/02_understanding_funtion_features/06_allowed_function_input_argument_types/01_example_1.v)_

### Lesson: Example 1

V functions support several advanced features:

- **Multiple Return Values**: A function can return more than one value (often a result and an error).
- **Blank Identifier (`_`)**: Used to discard unwanted return values.
- **Defer**: Schedules a block of code to run right before the function exits, which is excellent for resource cleanup.
- **Anonymous Functions & Closures**: Functions defined inline that can capture variables from their outer scope.

These examples illustrate these powerful concepts.

**Additional Context from Repository docs:**
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

---

### Example 2

_File location: [functions/02_understanding_funtion_features/06_allowed_function_input_argument_types/02_example_2.v](file:///Users/codecaine/V-Programming-Comprehensive-Guide/functions/02_understanding_funtion_features/06_allowed_function_input_argument_types/02_example_2.v)_

### Lesson: Example 2

V functions support several advanced features:

- **Multiple Return Values**: A function can return more than one value (often a result and an error).
- **Blank Identifier (`_`)**: Used to discard unwanted return values.
- **Defer**: Schedules a block of code to run right before the function exits, which is excellent for resource cleanup.
- **Anonymous Functions & Closures**: Functions defined inline that can capture variables from their outer scope.

These examples illustrate these powerful concepts.

**Additional Context from Repository docs:**
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

---

### Error Script Functions

_File location: [functions/02_understanding_funtion_features/07_functions_in_v_scripts/01_error_script_functions.vsh](file:///Users/codecaine/V-Programming-Comprehensive-Guide/functions/02_understanding_funtion_features/07_functions_in_v_scripts/01_error_script_functions.vsh)_

### Lesson: Error Script Functions

V functions support several advanced features:

- **Multiple Return Values**: A function can return more than one value (often a result and an error).
- **Blank Identifier (`_`)**: Used to discard unwanted return values.
- **Defer**: Schedules a block of code to run right before the function exits, which is excellent for resource cleanup.
- **Anonymous Functions & Closures**: Functions defined inline that can capture variables from their outer scope.

These examples illustrate these powerful concepts.

```v
#!/usr/local/bin/v run

cnt := 2

for i in 0 .. cnt {
	log('iteration ${i}')
}

fn log(msg string) {
	println(msg)
}
```

---

### Script Functions

_File location: [functions/02_understanding_funtion_features/07_functions_in_v_scripts/02_script_functions.vsh](file:///Users/codecaine/V-Programming-Comprehensive-Guide/functions/02_understanding_funtion_features/07_functions_in_v_scripts/02_script_functions.vsh)_

### Lesson: Script Functions

V functions support several advanced features:

- **Multiple Return Values**: A function can return more than one value (often a result and an error).
- **Blank Identifier (`_`)**: Used to discard unwanted return values.
- **Defer**: Schedules a block of code to run right before the function exits, which is excellent for resource cleanup.
- **Anonymous Functions & Closures**: Functions defined inline that can capture variables from their outer scope.

These examples illustrate these powerful concepts.

```v
#!/usr/local/bin/v run

fn log(msg string) {
	println(msg)
}

cnt := 2

for i in 0 .. cnt {
	log('iteration ${i}')
}
```

---

### Functions Module Variables - Main (main.v)

_File location: [functions/02_understanding_funtion_features/08_functions_and_module_variables/main.v](file:///Users/codecaine/V-Programming-Comprehensive-Guide/functions/02_understanding_funtion_features/08_functions_and_module_variables/main.v)_

### Lesson: Functions Module Variables - Main

V functions support several advanced features:

- **Multiple Return Values**: A function can return more than one value (often a result and an error).
- **Blank Identifier (`_`)**: Used to discard unwanted return values.
- **Defer**: Schedules a block of code to run right before the function exits, which is excellent for resource cleanup.
- **Anonymous Functions & Closures**: Functions defined inline that can capture variables from their outer scope.

These examples illustrate these powerful concepts.

**Additional Context from Repository docs:**
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

---

### Mymod

_File location: [functions/02_understanding_funtion_features/08_functions_and_module_variables/mymod/mymod.v](file:///Users/codecaine/V-Programming-Comprehensive-Guide/functions/02_understanding_funtion_features/08_functions_and_module_variables/mymod/mymod.v)_

### Lesson: Mymod

V functions support several advanced features:

- **Multiple Return Values**: A function can return more than one value (often a result and an error).
- **Blank Identifier (`_`)**: Used to discard unwanted return values.
- **Defer**: Schedules a block of code to run right before the function exits, which is excellent for resource cleanup.
- **Anonymous Functions & Closures**: Functions defined inline that can capture variables from their outer scope.

These examples illustrate these powerful concepts.

**Additional Context from Repository docs:**
This example demonstrates the concepts of **mymod**.

```v
// file: mymod/mymod.v
module mymod

__global (
	msg string
)
```

---

### Functions With Optional Return Types Example 1

_File location: [functions/02_understanding_funtion_features/09_functions_with_optional_return_types/01_functions_with_optional_return_types_example_1.v](file:///Users/codecaine/V-Programming-Comprehensive-Guide/functions/02_understanding_funtion_features/09_functions_with_optional_return_types/01_functions_with_optional_return_types_example_1.v)_

### Lesson: Functions With Optional Return Types Example 1

V functions support several advanced features:

- **Multiple Return Values**: A function can return more than one value (often a result and an error).
- **Blank Identifier (`_`)**: Used to discard unwanted return values.
- **Defer**: Schedules a block of code to run right before the function exits, which is excellent for resource cleanup.
- **Anonymous Functions & Closures**: Functions defined inline that can capture variables from their outer scope.

These examples illustrate these powerful concepts.

**Additional Context from Repository docs:**
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

---

### Function With Optional Return Type Example 2

_File location: [functions/02_understanding_funtion_features/09_functions_with_optional_return_types/02_function_with_optional_return_type_example_2.v](file:///Users/codecaine/V-Programming-Comprehensive-Guide/functions/02_understanding_funtion_features/09_functions_with_optional_return_types/02_function_with_optional_return_type_example_2.v)_

### Lesson: Function With Optional Return Type Example 2

V functions support several advanced features:

- **Multiple Return Values**: A function can return more than one value (often a result and an error).
- **Blank Identifier (`_`)**: Used to discard unwanted return values.
- **Defer**: Schedules a block of code to run right before the function exits, which is excellent for resource cleanup.
- **Anonymous Functions & Closures**: Functions defined inline that can capture variables from their outer scope.

These examples illustrate these powerful concepts.

**Additional Context from Repository docs:**
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

---

### Mod1

_File location: [functions/02_understanding_funtion_features/10_functions_marked_public/mod1/mod1.v](file:///Users/codecaine/V-Programming-Comprehensive-Guide/functions/02_understanding_funtion_features/10_functions_marked_public/mod1/mod1.v)_

### Lesson: Mod1

V functions support several advanced features:

- **Multiple Return Values**: A function can return more than one value (often a result and an error).
- **Blank Identifier (`_`)**: Used to discard unwanted return values.
- **Defer**: Schedules a block of code to run right before the function exits, which is excellent for resource cleanup.
- **Anonymous Functions & Closures**: Functions defined inline that can capture variables from their outer scope.

These examples illustrate these powerful concepts.

**Additional Context from Repository docs:**
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

---

### Public Function Demo1

_File location: [functions/02_understanding_funtion_features/10_functions_marked_public/public_function_demo1.v](file:///Users/codecaine/V-Programming-Comprehensive-Guide/functions/02_understanding_funtion_features/10_functions_marked_public/public_function_demo1.v)_

### Lesson: Public Function Demo1

V functions support several advanced features:

- **Multiple Return Values**: A function can return more than one value (often a result and an error).
- **Blank Identifier (`_`)**: Used to discard unwanted return values.
- **Defer**: Schedules a block of code to run right before the function exits, which is excellent for resource cleanup.
- **Anonymous Functions & Closures**: Functions defined inline that can capture variables from their outer scope.

These examples illustrate these powerful concepts.

**Additional Context from Repository docs:**
This example demonstrates the concepts of **public function demo1**.

```v
// file: public_function_demo1.v
import mod1

fn main() {
	g := mod1.greet1()
	println(g)
}
```

---

### Public Function Demo2

_File location: [functions/02_understanding_funtion_features/10_functions_marked_public/public_function_demo2.v](file:///Users/codecaine/V-Programming-Comprehensive-Guide/functions/02_understanding_funtion_features/10_functions_marked_public/public_function_demo2.v)_

### Lesson: Public Function Demo2

V functions support several advanced features:

- **Multiple Return Values**: A function can return more than one value (often a result and an error).
- **Blank Identifier (`_`)**: Used to discard unwanted return values.
- **Defer**: Schedules a block of code to run right before the function exits, which is excellent for resource cleanup.
- **Anonymous Functions & Closures**: Functions defined inline that can capture variables from their outer scope.

These examples illustrate these powerful concepts.

**Additional Context from Repository docs:**
This example demonstrates the concepts of **public function demo2**.

```v
// file: public_function_demo2.v
import mod1

fn main() {
	g := mod1.greet2()
	println(g)
}
```

---

### Public Function Demo3

_File location: [functions/02_understanding_funtion_features/10_functions_marked_public/public_function_demo3.v](file:///Users/codecaine/V-Programming-Comprehensive-Guide/functions/02_understanding_funtion_features/10_functions_marked_public/public_function_demo3.v)_

### Lesson: Public Function Demo3

V functions support several advanced features:

- **Multiple Return Values**: A function can return more than one value (often a result and an error).
- **Blank Identifier (`_`)**: Used to discard unwanted return values.
- **Defer**: Schedules a block of code to run right before the function exits, which is excellent for resource cleanup.
- **Anonymous Functions & Closures**: Functions defined inline that can capture variables from their outer scope.

These examples illustrate these powerful concepts.

**Additional Context from Repository docs:**
This example demonstrates the concepts of **public function demo3**.

```v
// file: public_function_demo3.v
import mod1

fn main() {
	g := mod1.greet_and_wish()
	println(g)
}
```

---

### Function With Defer Block

_File location: [functions/02_understanding_funtion_features/11_functions_with_defer_block/01_function_with_defer_block.v](file:///Users/codecaine/V-Programming-Comprehensive-Guide/functions/02_understanding_funtion_features/11_functions_with_defer_block/01_function_with_defer_block.v)_

### Lesson: Function With Defer Block

`defer` is useful when a function needs to clean up something before it exits, such as closing a file or releasing a resource. The deferred block runs automatically at the end of the function.

**Additional Context from Repository docs:**
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

---

### Functions As Elements Of Array Or Map

_File location: [functions/02_understanding_funtion_features/12_functions_as_elements_of_array_or_map/01_functions_as_elements_of_array_or_map.v](file:///Users/codecaine/V-Programming-Comprehensive-Guide/functions/02_understanding_funtion_features/12_functions_as_elements_of_array_or_map/01_functions_as_elements_of_array_or_map.v)_

### Lesson: Functions As Elements Of Array Or Map

Functions can be stored in arrays and maps just like other values. This allows you to choose an operation dynamically at runtime, which is helpful in flexible programs.

**Additional Context from Repository docs:**
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

---

## Function Extras

### Hello

_File location: [functions/01_function_types/00_main_function/hello.v](file:///Users/codecaine/V-Programming-Comprehensive-Guide/functions/01_function_types/00_main_function/hello.v)_

### Lesson: Hello

Every V program starts with `main()`. It is the entry point where execution begins, so it is the first function most beginners learn.

**Additional Context from Repository docs:**
This example demonstrates the concepts of **hello**.

```v
module main

fn main() {
	println('Welcome to the World of V!')
}
```

---

### Basic Functions

_File location: [functions/01_function_types/01_basic_functions/basic_functions.v](file:///Users/codecaine/V-Programming-Comprehensive-Guide/functions/01_function_types/01_basic_functions/basic_functions.v)_

### Lesson: Basic Functions

A basic function packages a task so you can call it later instead of repeating the same code. This example shows a function that prints a message when invoked.

**Additional Context from Repository docs:**
This example demonstrates the concepts of **basic functions**.

```v
fn greet(name string) {
	println('Hello, ${name}!')
}

fn main() {
	greet('Ada')
	greet('Grace')
}
```

---

### Anonymous Functions

_File location: [functions/01_function_types/02_anonymous_functions/anonymous_functions.v](file:///Users/codecaine/V-Programming-Comprehensive-Guide/functions/01_function_types/02_anonymous_functions/anonymous_functions.v)_

### Lesson: Anonymous Functions

Anonymous functions are defined inline and are useful for short, one-off behavior. They are handy when you want a quick callback without creating a named function.

**Additional Context from Repository docs:**
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

---

### Functions As Input Arguments

_File location: [functions/01_function_types/03_higher_order_functions/01_functions_as_input_arguments/01_functions_as_input_arguments.v](file:///Users/codecaine/V-Programming-Comprehensive-Guide/functions/01_function_types/03_higher_order_functions/01_functions_as_input_arguments/01_functions_as_input_arguments.v)_

### Lesson: Functions As Input Arguments

Functions are reusable blocks of logic. This lesson on **Functions As Input Arguments** explains functional syntax, arguments, returns, or functional capabilities in V.

**Additional Context from Repository docs:**
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

---

### Functions That Return Other Functions

_File location: [functions/01_function_types/03_higher_order_functions/02_functions_that_return_other_functions/02_functions_that_return_other_functions.v](file:///Users/codecaine/V-Programming-Comprehensive-Guide/functions/01_function_types/03_higher_order_functions/02_functions_that_return_other_functions/02_functions_that_return_other_functions.v)_

### Lesson: Functions That Return Other Functions

Functions are reusable blocks of logic. This lesson on **Functions That Return Other Functions** explains functional syntax, arguments, returns, or functional capabilities in V.

**Additional Context from Repository docs:**
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

---

### Lambda Expressions

_File location: [functions/01_function_types/04_lambda_expressions/lambda_expressions.v](file:///Users/codecaine/V-Programming-Comprehensive-Guide/functions/01_function_types/04_lambda_expressions/lambda_expressions.v)_

### Lesson: Lambda Expressions

V supports **Lambda Expressions**, which are lightweight, inline anonymous functions defined using the `|variables| expression` syntax.

Key architectural characteristics:

1. **Scope Restriction**: Lambda expressions are not general-purpose functions; this syntax is **only** valid when passed directly as arguments to higher-order functions like `.sort()`, `.map()`, and `.filter()`.
2. **Implicit Returns**: The result of the single expression on the right-hand side is automatically returned. No `return` keyword is needed.

#### Step-by-Step Code Walkthrough:

- **Sorting (`nums.sort(|a, b| b < a)`)**:
  The `.sort()` method accepts a comparator callback. The lambda expression defines parameters `a` and `b`, returning the comparison `b < a` to sort the array in descending order.
- **Mapping (`nums.map(|x| x * 10)`)**:
  The `.map()` method transforms each array element. The lambda `|x| x * 10` accepts the element `x`, multiplies it by `10`, and produces the new mapped array.
- **Filtering (`doubled.filter(|x| x > 20)`)**:
  The `.filter()` method checks a predicate. The lambda `|x| x > 20` checks each element and retains only those returning `true`.

**Additional Context from Repository docs:**
This example demonstrates the concepts of **lambda expressions**.

```v
module main

fn main() {
	mut nums := [1, 3, 2, 5, 4]

	// Sort descending using a lambda expression
	nums.sort(|a, b| b < a)
	println('Sorted: ${nums}') // [5, 4, 3, 2, 1]

	// Map using lambda to multiply by 10
	doubled := nums.map(|x| x * 10)
	println('Doubled: ${doubled}') // [50, 40, 30, 20, 10]

	// Filter using lambda to keep only elements > 20
	filtered := doubled.filter(|x| x > 20)
	println('Filtered (>20): ${filtered}') // [50, 40, 30]
}
```

---

### Closures

_File location: [functions/01_function_types/05_closures/closures.v](file:///Users/codecaine/V-Programming-Comprehensive-Guide/functions/01_function_types/05_closures/closures.v)_

### Lesson: Closures

V supports **Closures**, which are anonymous functions that "remember" and access variables from the parent scope in which they were created.

Unlike languages where variable capture is automatic and hidden, V implements **explicit capture lists** for safety and predictability:

1. **Explicit Capture Syntax**: Captured variables must be declared inside square brackets `fn [captured_var] (args)`.
2. **Pass-by-Value Capture (`[captured_var]`)**: The variable's value is copied when the closure is created. It is read-only inside the closure body.
3. **Pass-by-Reference Capture (`[mut captured_var]`)**: Prepending the capture with `mut` passes the variable by reference. Any changes made to the variable inside the closure modify the original variable in the parent scope, and vice-versa.

#### Step-by-Step Code Walkthrough:

- **`new_counter` Function**: Returns a closure `fn () int`.
- **State Preservation (`[mut count]`)**: The closure captures the local variable `count` from `new_counter` as `mut`. This allows `count` to survive after `new_counter` returns and update its state across multiple invocation calls (e.g. `counter()`).
- **Value Capture (`[factor]`)**: The closure `multiplier` captures the `factor` variable as read-only. Calling `multiplier(5)` evaluates to `5 * 10` (50).

**Additional Context from Repository docs:**
This example demonstrates the concepts of **closures**.

```v
module main

fn new_counter() fn () int {
	mut count := 0
	// The closure inherits `count` by reference (read-write) using explicit list `[mut count]`
	return fn [mut count] () int {
		count++
		return count
	}
}

fn main() {
	counter := new_counter()
	println(counter()) // 1
	println(counter()) // 2
	println(counter()) // 3

	// An immutable capture closure
	factor := 10
	multiplier := fn [factor] (x int) int {
		return x * factor
	}
	println(multiplier(5)) // 50
}
```

---

# Chapter 7: Structs (Custom Types)

## Quick Access

Below is an index of all code examples in this chapter. You can use these links to jump directly to any specific code example:

**Struct Basics & Fields**

- [Defining Struct](#defining-struct)
- [Initialize Struct Example 1](#initialize-struct-example-1)
- [Initialize Struct Example 2](#initialize-struct-example-2)
- [Access Struct Fields](#access-struct-fields)
- [Heap Structs](#heap-structs)
- [Updating Immutable Struct Variable Throws Error](#updating-immutable-struct-variable-throws-error)
- [Updating Mutable Fields Of Struct](#updating-mutable-fields-of-struct)
- [Updating Immutable Fields Throws Error](#updating-immutable-fields-throws-error)
- [Updating Struct With Unspecified Fields Are Zeroed](#updating-struct-with-unspecified-fields-are-zeroed)
- [Struct With Multiple Fields](#struct-with-multiple-fields)
- [Grouping Struct Fields Based On Access Modifiers](#grouping-struct-fields-based-on-access-modifiers)
- [Required Fields Example 01](#required-fields-example-01)
- [Required Fields Example 02](#required-fields-example-02)
- [Struct Fields With Default Values](#struct-fields-with-default-values)
- [Methods For Struct](#methods-for-struct)
- [Mutable Methods](#mutable-methods)
- [Adding Struct As Struct Field](#adding-struct-as-struct-field)
- [Updating Fields Of Type Struct](#updating-fields-of-type-struct)
- [Struct As Trailing Literal Arguments To Function](#struct-as-trailing-literal-arguments-to-function)
- [Anonymous Structs](#anonymous-structs)
- [Static Type Methods](#static-type-methods)
- [noinit Structs](#noinit-structs)
- [Unions](#unions)

---

Structs are user-defined data structures that allow you to group related fields together. This chapter explains how to define structs, set default values, make fields required, attach methods to structs, and embed structs inside other structures.

## Struct Basics & Fields

### Defining Struct

_File location: [structs/01_introducing_structs/01_defining_struct/01_defining_struct/01_defining_struct.v](file:///Users/codecaine/V-Programming-Comprehensive-Guide/structs/01_introducing_structs/01_defining_struct/01_defining_struct/01_defining_struct.v)_

### Lesson: Defining Struct

A **struct** is a user-defined custom type that groups related variables (called fields) together. Structs are fundamental to V's object-oriented programming model. By default, struct fields are private and immutable. V provides access modifiers like `mut:`, `pub:`, and `pub mut:` to control field access and mutability.

These examples demonstrate defining structs, updating fields, required fields, default values, and struct methods.

**Additional Context from Repository docs:**
This example demonstrates the concepts of **defining struct**.

```v
struct Note {
	id      int
	message string
}

fn main() {
	note := Note{
		id:      1
		message: 'A simple struct demo'
	}

	println(note)
}
```

---

### Initialize Struct Example 1

_File location: [structs/01_introducing_structs/01_defining_struct/02_initialize_struct_example_1/02_initialize_struct_example_1.v](file:///Users/codecaine/V-Programming-Comprehensive-Guide/structs/01_introducing_structs/01_defining_struct/02_initialize_struct_example_1/02_initialize_struct_example_1.v)_

### Lesson: Initialize Struct Example 1

A **struct** is a user-defined custom type that groups related variables (called fields) together. Structs are fundamental to V's object-oriented programming model. By default, struct fields are private and immutable. V provides access modifiers like `mut:`, `pub:`, and `pub mut:` to control field access and mutability.

These examples demonstrate defining structs, updating fields, required fields, default values, and struct methods.

**Additional Context from Repository docs:**
This example demonstrates the concepts of **initialize struct example 1**.

```v
struct Note {
	id      int
	message string
}

fn main() {
	note := Note{1, 'A simple struct demo'}

	println('ID: ${note.id}')
	println('Message: ${note.message}')
}
```

---

### Initialize Struct Example 2

_File location: [structs/01_introducing_structs/01_defining_struct/03_initialize_struct_example_2/03_initialize_struct_example_2.v](file:///Users/codecaine/V-Programming-Comprehensive-Guide/structs/01_introducing_structs/01_defining_struct/03_initialize_struct_example_2/03_initialize_struct_example_2.v)_

### Lesson: Initialize Struct Example 2

A **struct** is a user-defined custom type that groups related variables (called fields) together. Structs are fundamental to V's object-oriented programming model. By default, struct fields are private and immutable. V provides access modifiers like `mut:`, `pub:`, and `pub mut:` to control field access and mutability.

These examples demonstrate defining structs, updating fields, required fields, default values, and struct methods.

**Additional Context from Repository docs:**
This example demonstrates the concepts of **initialize struct example 2**.

```v
struct Note {
	id      int
	message string
}

fn main() {
	note := Note{
		message: 'A named-field struct demo'
		id:      2
	}

	println(typeof(note).name)
	println(note)
}
```

---

### Access Struct Fields

_File location: [structs/01_introducing_structs/02_access_struct_fields/01_access_struct_fields.v](file:///Users/codecaine/V-Programming-Comprehensive-Guide/structs/01_introducing_structs/02_access_struct_fields/01_access_struct_fields.v)_

### Lesson: Access Struct Fields

A **struct** is a user-defined custom type that groups related variables (called fields) together. Structs are fundamental to V's object-oriented programming model. By default, struct fields are private and immutable. V provides access modifiers like `mut:`, `pub:`, and `pub mut:` to control field access and mutability.

These examples demonstrate defining structs, updating fields, required fields, default values, and struct methods.

**Additional Context from Repository docs:**
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

---

### Heap Structs

_File location: [structs/01_introducing_structs/03_heap_structs/01_heap_structs.v](file:///Users/codecaine/V-Programming-Comprehensive-Guide/structs/01_introducing_structs/03_heap_structs/01_heap_structs.v)_

### Lesson: Heap Structs

A **struct** is a user-defined custom type that groups related variables (called fields) together. Structs are fundamental to V's object-oriented programming model. By default, struct fields are private and immutable. V provides access modifiers like `mut:`, `pub:`, and `pub mut:` to control field access and mutability.

These examples demonstrate defining structs, updating fields, required fields, default values, and struct methods.

**Additional Context from Repository docs:**
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

---

### Updating Immutable Struct Variable Throws Error

_File location: [structs/02_updating_fields_of_struct/01_updating_immutable_struct_variable_throws_error/01_updating_immutable_struct_variable_throws_error.v](file:///Users/codecaine/V-Programming-Comprehensive-Guide/structs/02_updating_fields_of_struct/01_updating_immutable_struct_variable_throws_error/01_updating_immutable_struct_variable_throws_error.v)_

### Lesson: Updating Immutable Struct Variable Throws Error

A **struct** is a user-defined custom type that groups related variables (called fields) together. Structs are fundamental to V's object-oriented programming model. By default, struct fields are private and immutable. V provides access modifiers like `mut:`, `pub:`, and `pub mut:` to control field access and mutability.

These examples demonstrate defining structs, updating fields, required fields, default values, and struct methods.

**Additional Context from Repository docs:**
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

---

### Updating Mutable Fields Of Struct

_File location: [structs/02_updating_fields_of_struct/02_updating_mutable_fields_of_struct/01_updating_mutable_fields_of_struct.v](file:///Users/codecaine/V-Programming-Comprehensive-Guide/structs/02_updating_fields_of_struct/02_updating_mutable_fields_of_struct/01_updating_mutable_fields_of_struct.v)_

### Lesson: Updating Mutable Fields Of Struct

A **struct** is a user-defined custom type that groups related variables (called fields) together. Structs are fundamental to V's object-oriented programming model. By default, struct fields are private and immutable. V provides access modifiers like `mut:`, `pub:`, and `pub mut:` to control field access and mutability.

These examples demonstrate defining structs, updating fields, required fields, default values, and struct methods.

**Additional Context from Repository docs:**
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

---

### Updating Immutable Fields Throws Error

_File location: [structs/02_updating_fields_of_struct/03_updating_immutable_fields_throws_error/01_updating_immutable_fields_throws_error.v](file:///Users/codecaine/V-Programming-Comprehensive-Guide/structs/02_updating_fields_of_struct/03_updating_immutable_fields_throws_error/01_updating_immutable_fields_throws_error.v)_

### Lesson: Updating Immutable Fields Throws Error

A **struct** is a user-defined custom type that groups related variables (called fields) together. Structs are fundamental to V's object-oriented programming model. By default, struct fields are private and immutable. V provides access modifiers like `mut:`, `pub:`, and `pub mut:` to control field access and mutability.

These examples demonstrate defining structs, updating fields, required fields, default values, and struct methods.

**Additional Context from Repository docs:**
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

---

### Updating Struct With Unspecified Fields Are Zeroed

_File location: [structs/02_updating_fields_of_struct/04_updating_struct_with_unspecified_fields_are_zeroed/01_updating_struct_with_unspecified_fields_are_zeroed.v](file:///Users/codecaine/V-Programming-Comprehensive-Guide/structs/02_updating_fields_of_struct/04_updating_struct_with_unspecified_fields_are_zeroed/01_updating_struct_with_unspecified_fields_are_zeroed.v)_

### Lesson: Updating Struct With Unspecified Fields Are Zeroed

A **struct** is a user-defined custom type that groups related variables (called fields) together. Structs are fundamental to V's object-oriented programming model. By default, struct fields are private and immutable. V provides access modifiers like `mut:`, `pub:`, and `pub mut:` to control field access and mutability.

These examples demonstrate defining structs, updating fields, required fields, default values, and struct methods.

**Additional Context from Repository docs:**
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

---

### Struct With Multiple Fields

_File location: [structs/03_approaches_defining_struct_fields/01_struct_with_multiple_fields/01_struct_with_multiple_fields.v](file:///Users/codecaine/V-Programming-Comprehensive-Guide/structs/03_approaches_defining_struct_fields/01_struct_with_multiple_fields/01_struct_with_multiple_fields.v)_

### Lesson: Struct With Multiple Fields

A **struct** is a user-defined custom type that groups related variables (called fields) together. Structs are fundamental to V's object-oriented programming model. By default, struct fields are private and immutable. V provides access modifiers like `mut:`, `pub:`, and `pub mut:` to control field access and mutability.

These examples demonstrate defining structs, updating fields, required fields, default values, and struct methods.

**Additional Context from Repository docs:**
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

---

### Grouping Struct Fields Based On Access Modifiers

_File location: [structs/03_approaches_defining_struct_fields/02_grouping_struct_fields_based_on_access_modifiers/01_grouping_struct_fields_based_on_access_modifiers.v](file:///Users/codecaine/V-Programming-Comprehensive-Guide/structs/03_approaches_defining_struct_fields/02_grouping_struct_fields_based_on_access_modifiers/01_grouping_struct_fields_based_on_access_modifiers.v)_

### Lesson: Grouping Struct Fields Based On Access Modifiers

A **struct** is a user-defined custom type that groups related variables (called fields) together. Structs are fundamental to V's object-oriented programming model. By default, struct fields are private and immutable. V provides access modifiers like `mut:`, `pub:`, and `pub mut:` to control field access and mutability.

These examples demonstrate defining structs, updating fields, required fields, default values, and struct methods.

**Additional Context from Repository docs:**
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

---

### Required Fields Example 01

_File location: [structs/03_approaches_defining_struct_fields/03_required_fields_in_struct/01_required_fields_example_01/01_required_fields_example_01.v](file:///Users/codecaine/V-Programming-Comprehensive-Guide/structs/03_approaches_defining_struct_fields/03_required_fields_in_struct/01_required_fields_example_01/01_required_fields_example_01.v)_

### Lesson: Required Fields Example 01

A **struct** is a user-defined custom type that groups related variables (called fields) together. Structs are fundamental to V's object-oriented programming model. By default, struct fields are private and immutable. V provides access modifiers like `mut:`, `pub:`, and `pub mut:` to control field access and mutability.

These examples demonstrate defining structs, updating fields, required fields, default values, and struct methods.

**Additional Context from Repository docs:**
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

---

### Required Fields Example 02

_File location: [structs/03_approaches_defining_struct_fields/03_required_fields_in_struct/02_required_fields_example_02/02_required_fields_example_02.v](file:///Users/codecaine/V-Programming-Comprehensive-Guide/structs/03_approaches_defining_struct_fields/03_required_fields_in_struct/02_required_fields_example_02/02_required_fields_example_02.v)_

### Lesson: Required Fields Example 02

A **struct** is a user-defined custom type that groups related variables (called fields) together. Structs are fundamental to V's object-oriented programming model. By default, struct fields are private and immutable. V provides access modifiers like `mut:`, `pub:`, and `pub mut:` to control field access and mutability.

These examples demonstrate defining structs, updating fields, required fields, default values, and struct methods.

**Additional Context from Repository docs:**
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

---

### Struct Fields With Default Values

_File location: [structs/03_approaches_defining_struct_fields/04_fields_with_default_values/01_struct_fields_with_default_values.v](file:///Users/codecaine/V-Programming-Comprehensive-Guide/structs/03_approaches_defining_struct_fields/04_fields_with_default_values/01_struct_fields_with_default_values.v)_

### Lesson: Struct Fields With Default Values

A **struct** is a user-defined custom type that groups related variables (called fields) together. Structs are fundamental to V's object-oriented programming model. By default, struct fields are private and immutable. V provides access modifiers like `mut:`, `pub:`, and `pub mut:` to control field access and mutability.

These examples demonstrate defining structs, updating fields, required fields, default values, and struct methods.

**Additional Context from Repository docs:**
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

---

### Methods For Struct

_File location: [structs/04_methods_for_struct/01_methods_for_struct/01_methods_for_struct.v](file:///Users/codecaine/V-Programming-Comprehensive-Guide/structs/04_methods_for_struct/01_methods_for_struct/01_methods_for_struct.v)_

### Lesson: Methods For Struct

A **struct** is a user-defined custom type that groups related variables (called fields) together. Structs are fundamental to V's object-oriented programming model. By default, struct fields are private and immutable. V provides access modifiers like `mut:`, `pub:`, and `pub mut:` to control field access and mutability.

This lesson demonstrates defining structs, updating fields, required fields, default values, and value receiver methods.

**Additional Context from Repository docs:**
This example demonstrates the concepts of **methods for struct**.

```v
module main

import time

// 1. Define a Struct.
// Structs are defined with the `struct` keyword. By default, structs are private
// (only accessible within the current module) and all fields are immutable.
// The `pub` keyword makes the struct visible to other modules.
pub struct Note {
// 2. Struct Access Modifiers:
// - `pub:` makes the fields readable from outside the module, but still immutable.
pub:
	id      int
	// Fields can have default values assigned at declaration.
	created time.Time = time.now()

// - `pub mut:` makes the fields readable and writable from outside the module.
pub mut:
	// Attributes can be attached to struct fields.
	// `@[required]` specifies that this field must be explicitly provided when instantiating.
	message string @[required]
	status  bool
	due     time.Time = time.now().add_days(1)
}

// 3. Define a Method (Value Receiver).
// In V, a method is a function with a receiver argument.
// The receiver is specified in parentheses before the function name: `(n Note)`.
// This is a "value receiver" method, meaning it receives a copy of the struct instance.
// It cannot modify fields on the original struct instance.
pub fn (n Note) is_empty_message() bool {
	return n.message.len < 1
}

fn main() {
	// 4. Instantiate a Struct.
	// We use the struct name and curly braces, listing field initializations.
	// Because `message` is marked `@[required]`, we must specify it.
	// The variable `n` is marked `mut` because we might want to update its `pub mut` fields.
	mut n := Note{
		id:      1
		message: ''
	}

	// 5. Invoke Struct Methods.
	// Methods are called on struct instances using the dot operator.
	if n.is_empty_message() {
		println('message is empty')
	} else {
		println('message not empty')
	}
}
```

---

### Mutable Methods

_File location: [structs/04_methods_for_struct/02_mutable_methods/02_mutable_methods.v](file:///Users/codecaine/V-Programming-Comprehensive-Guide/structs/04_methods_for_struct/02_mutable_methods/02_mutable_methods.v)_

### Lesson: Mutable Methods

By default, struct methods in V receive a read-only copy of the struct instance (value receiver). If a method needs to modify any fields of the struct, it must declare a mutable receiver using the `mut` keyword, e.g., `fn (mut n Note) mark_as_completed()`.

Additionally, the struct instance variable must be declared with `mut` at the call site to allow mutable method invocations.

**Additional Context from Repository docs:**
This example demonstrates the concepts of **mutable methods for struct**.

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

// 1. Define a Mutable Struct Method.
// To modify fields of a struct inside a method, the receiver must be marked mutable: `(mut n Note)`.
// Under the hood, this passes a pointer/mutable reference, allowing the method to update
// the original struct instance fields directly.
pub fn (mut n Note) mark_as_completed() {
	n.status = true
	println('Note [ID: ${n.id}] marked as completed.')
}

// 2. Define another Mutable Method to update the message.
pub fn (mut n Note) update_message(new_msg string) {
	if new_msg.len > 0 {
		n.message = new_msg
		println('Note [ID: ${n.id}] message updated to: "${new_msg}"')
	}
}

fn main() {
	// 3. Instantiate a mutable struct instance.
	// To call mutable methods on a struct, the variable MUST be declared as mutable (`mut`).
	// If `n` was immutable, calling `n.mark_as_completed()` would result in a compilation error.
	mut n := Note{
		id:      42
		message: 'Learn V programming'
		status:  false
	}

	println('Initial state - Message: "${n.message}", Completed: ${n.status}')

	// 4. Call the mutable methods.
	n.update_message('Master V programming and C interop!')
	n.mark_as_completed()

	// 5. Verify the updates.
	println('Final state - Message: "${n.message}", Completed: ${n.status}')
	assert n.status == true
}
```

---

### Adding Struct As Struct Field

_File location: [structs/05_struct_as_struct_field/01_adding_struct_as_struct_field/01_adding_struct_as_struct_field.v](file:///Users/codecaine/V-Programming-Comprehensive-Guide/structs/05_struct_as_struct_field/01_adding_struct_as_struct_field/01_adding_struct_as_struct_field.v)_

### Lesson: Adding Struct As Struct Field

A **struct** is a user-defined custom type that groups related variables (called fields) together. Structs are fundamental to V's object-oriented programming model. By default, struct fields are private and immutable. V provides access modifiers like `mut:`, `pub:`, and `pub mut:` to control field access and mutability.

These examples demonstrate defining structs, updating fields, required fields, default values, and struct methods.

**Additional Context from Repository docs:**
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

---

### Updating Fields Of Type Struct

_File location: [structs/05_struct_as_struct_field/02_updating_fields_of_type_struct/01_updating_fields_of_type_struct.v](file:///Users/codecaine/V-Programming-Comprehensive-Guide/structs/05_struct_as_struct_field/02_updating_fields_of_type_struct/01_updating_fields_of_type_struct.v)_

### Lesson: Updating Fields Of Type Struct

A **struct** is a user-defined custom type that groups related variables (called fields) together. Structs are fundamental to V's object-oriented programming model. By default, struct fields are private and immutable. V provides access modifiers like `mut:`, `pub:`, and `pub mut:` to control field access and mutability.

These examples demonstrate defining structs, updating fields, required fields, default values, and struct methods.

**Additional Context from Repository docs:**
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

---

### Struct As Trailing Literal Arguments To Function

_File location: [structs/06_struct_as_trailing_literal_arguments_to_function/01_struct_as_trailing_literal_arguments_to_function.v](file:///Users/codecaine/V-Programming-Comprehensive-Guide/structs/06_struct_as_trailing_literal_arguments_to_function/01_struct_as_trailing_literal_arguments_to_function.v)_

### Lesson: Struct As Trailing Literal Arguments To Function

A **struct** is a user-defined custom type that groups related variables (called fields) together. Structs are fundamental to V's object-oriented programming model. By default, struct fields are private and immutable. V provides access modifiers like `mut:`, `pub:`, and `pub mut:` to control field access and mutability.

These examples demonstrate defining structs, updating fields, required fields, default values, and struct methods.

**Additional Context from Repository docs:**
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

---

### Anonymous Structs

_File location: [structs/07_anonymous_structs/anonymous_structs.v](file:///Users/codecaine/V-Programming-Comprehensive-Guide/structs/07_anonymous_structs/anonymous_structs.v)_

### Lesson: Anonymous Structs

V supports **Anonymous Structs** which are inline struct declarations without separate struct names. They are useful for one-off structures like local nested objects.

#### Step-by-Step Code Walkthrough:

- **Inline Sub-Struct Declaration**:
  In the `Book` struct definition, the `author` field is declared as an anonymous struct type with fields `name string` and `age int`. No named struct like `Author` is required.
- **Inline Struct Initialization**:
  Inside `main()`, we instantiate `Book`. The nested `author` field is initialized directly using `struct { name: 'Samantha Black', age: 24 }`, matching the field structure.
- **Field Access**:
  Nested fields are accessed sequentially using dot notation: `book.author.name` and `book.author.age`.

**Additional Context from Repository docs:**
This example demonstrates the concepts of **anonymous structs**.

```v
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
```

---

### Static Type Methods

_File location: [structs/08_static_type_methods/static_type_methods.v](file:///Users/codecaine/V-Programming-Comprehensive-Guide/structs/08_static_type_methods/static_type_methods.v)_

### Lesson: Static Type Methods

V supports **Static Type Methods** (e.g. `User.new()`). These are defined on a struct via `fn [StructName].[methodName]` and allow organizing all constructor/factory functions related to a struct. V does not have traditional class constructors; static type methods are standard functions namespace-associated with the struct.

#### Step-by-Step Code Walkthrough:

- **Static Method Definition**:
  `fn User.new(name string, age int) User` declares a static method named `new` associated with the `User` struct namespace. It returns a new `User` instance.
- **Factory Organization**:
  The static method `User.default_user()` calls `User.new('Guest', 18)` to construct a user with default values, acting as a clean factory builder.
- **Invocation Syntax**:
  Inside `main()`, static methods are invoked using the struct name prefix: `User.new(...)` and `User.default_user()`. This prevents global namespace pollution and groups constructor-like logic cleanly.

**Additional Context from Repository docs:**
This example demonstrates the concepts of **static type methods**.

```v
module main

struct User {
	name string
	age  int
}

// Defining a static type method on User
fn User.new(name string, age int) User {
	return User{
		name: name
		age:  age
	}
}

// Another static method
fn User.default_user() User {
	return User.new('Guest', 18)
}

fn main() {
	// Call static type methods using StructName.method_name()
	user1 := User.new('Bob', 25)
	user2 := User.default_user()

	println('User 1: ${user1.name}, Age: ${user1.age}')
	println('User 2: ${user2.name}, Age: ${user2.age}')
}
```

---

### noinit Structs

_File location: [structs/09_noinit_structs/noinit_structs.v](file:///Users/codecaine/V-Programming-Comprehensive-Guide/structs/09_noinit_structs/noinit_structs.v)_

### Lesson: noinit Structs

V supports `[noinit]` structs which are structs that cannot be initialized directly outside of their declaring module. This forces client code to use factory constructor functions to instantiate the struct, enabling strict initialization checks and API boundaries.

#### Step-by-Step Code Walkthrough:

- **Declaring [noinit]**:
  In the `noinit_config` module (`noinit_config.v`), the `Config` struct is marked with the `@[noinit]` attribute. This blocks external modules from directly initializing it using literals like `noinit_config.Config{ ... }`.
- **Exposing a Constructor**:
  We provide a public factory function `pub fn new_config(port int, host string) Config` inside the `noinit_config` module, which is authorized to initialize and return the struct.
- **Compiler Enforcement**:
  In the main module (`noinit_structs.v`), creating `noinit_config.new_config(...)` compiles and runs successfully. Attempting to directly write `noinit_config.Config{port: 8080}` would cause a compilation error.

**Additional Context from Repository docs:**
This example demonstrates the concepts of **noinit structs**.

```v
// file: noinit_config/noinit_config.v
module noinit_config

@[noinit]
pub struct Config {
pub:
	port int
	host string
}

// Public constructor function to allow initialization from outside
pub fn new_config(port int, host string) Config {
	return Config{
		port: port
		host: host
	}
}
```

```v
// file: noinit_structs.v
import noinit_config

fn main() {
	// This works because it uses the constructor function
	cfg := noinit_config.new_config(8080, 'localhost')
	println('Config port: ${cfg.port}, host: ${cfg.host}')

	// This would fail compilation because noinit_config.Config is marked [noinit]:
	// cfg2 := noinit_config.Config{ port: 8080, host: 'localhost' }
}
```

---

### Unions

_File location: [structs/10_unions/unions.v](file:///Users/codecaine/V-Programming-Comprehensive-Guide/structs/10_unions/unions.v)_

### Lesson: Unions

A **Union** is a special type of struct that allows storing different data types in the same memory location. The largest member defines the size of the union. All members share the same memory location, meaning modifying one member automatically modifies the shared representation of the others. Union field access is considered memory-unsafe and must always be performed inside `unsafe {}` blocks.

#### Step-by-Step Code Walkthrough:

- **Union Declaration & Mutability**:
  `union Data` declares two fields: `f f64` (8 bytes) and `i int` (4 bytes). Because they are in a union, they share the same starting memory address, and the total size of `Data` is 8 bytes. By default in V, union fields are immutable; we must place them under a `mut:` block inside the union declaration to allow their values to be reassigned.
- **Memory Corruption Demonstration**:
  We initialize the union with an integer `i: 10`.
  Inside `unsafe { ... }`, when we assign `d.f = 5.5`, the float value overwrites the shared memory. Reading `d.i` subsequently returns a garbled integer representing the binary layout of the float `5.5`, demonstrating the shared storage layout.
- **Safety Restriction**:
  Accessing any field of a union (`d.i` or `d.f`) is blocked by the compiler unless wrapped in an `unsafe` block, protecting developers from accidental memory misinterpretation.

**Additional Context from Repository docs:**
This example demonstrates the concepts of **unions**.

```v
module main

// Define a union sharing the same memory location, marked mutable
union Data {
mut:
	f f64
	i int
}

fn main() {
	mut d := Data{i: 10}

	// Accessing union members must be performed in an unsafe block
	unsafe {
		println('Union int value: ${d.i}')

		// Modifying one member automatically modifies the other since they share memory
		d.f = 5.5
		println('Union float value: ${d.f}')
		println('Union int value after float update: ${d.i} (shared memory representation)')
	}
}
```

---

# Chapter 8: Error Handling

## Quick Access

Below is an index of all code examples in this chapter. You can use these links to jump directly to any specific code example:

**Option & Result Types**

- [Error Handling](#error-handling)

---

V has no exceptions. Instead, it handles errors using **Option** and **Result** types, which are checked at compile time. This chapter teaches you how to write robust, error-free programs using V's clean error handling syntax.

## Option & Result Types

### Error Handling

_File location: [error_handling/error_handling.v](file:///Users/codecaine/V-Programming-Comprehensive-Guide/error_handling/error_handling.v)_

In many programming languages, errors are handled using exceptions (with `try`, `catch`, and `throw` blocks). Exception blocks can make code hard to read and trace because control flow can jump unpredictably.

V takes a different approach. **V does not have exceptions.** Instead, V handles errors explicitly using two main concepts:

- **Option Types (`?T`)**: Used when a value might simply be missing (like searching for an item that isn't in a list).
- **Result Types (`!T`)**: Used when an operation might actually fail with a specific error (like division by zero or a database timeout).

By forcing you to handle these outcomes explicitly, V makes your code safer and easier to debug.

---

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

### Deep Dive Explanation

#### 1. Option (`?T`) vs. Result (`!T`) Types

V enforces safety by separating missing data from actual runtime failures at the type system level:

- **Option Type (`?T`)**: Declares that a variable or function return value can either hold a value of type `T` or `none` (denoting absence). Use options for operations like lookups or querying optional attributes.
- **Result Type (`!T`)**: Declares that an operation returns either a value of type `T` or an error that implements the `IError` interface. Use results for operations that can fail due to external factors (e.g., IO, math division, DB connection).

#### 2. Unwrapping with the `or` Block

When invoking a function that returns an Option or a Result, V requires you to explicitly unwrap it using an `or` block:

```v
value := maybe_value() or { fallback_value }
```

The `or` block acts as a recovery scope and **must** adhere to one of the following two rules:

1. **Provide a Fallback Value**: It must evaluate to an expression matching type `T`.
2. **Halt or Divert Control Flow**: It must use keywords like `return`, `panic()`, `exit()`, `break`, or `continue` to exit the current scope.

For functions returning a Result type, V automatically exposes an implicit variable named `err` (of type `IError`) inside the `or` block. You can call `err.msg()` or `err.code()` to inspect the failure:

```v
result := divide(10.0, 0.0) or {
    println('Math error: ' + err.msg())
    0.0
}
```

#### 3. Error and Option Propagation

Instead of handling errors immediately with an `or` block, you can bubble them up to the caller using propagation suffixes:

- Use the **`?`** suffix to propagate `none` from an optional-returning function:
  ```v
  item := find_item(id)? // Returns none to the caller if find_item fails
  ```
- Use the **`!`** suffix to propagate errors from a result-returning function:
  ```v
  res := divide(a, b)! // Propagates the IError up to the caller if b == 0.0
  ```
  _Note: A function can only use the propagation suffix if its own return type matches (i.e., returns `?U` or `!U` respectively)._

#### 4. Custom Error Structs and the `IError` Interface

To build custom error types, define a struct and embed the builtin `Error` struct. Embedding `Error` ensures your custom struct implements the `IError` interface:

```v
struct CustomError {
    Error       // Embed standard Error fields and methods
    message string
    code    int
}
```

You can override the `msg()` and `code()` methods to define how the error is printed and what status code it carries.

#### 5. Type Assertions and Smart Casting with `is`

When handling generic `IError` values inside an `or` block, you can query their concrete types using the `is` keyword:

```v
fetch_data(false) or {
    if err is CustomError {
        // V smart-casts 'err' to CustomError here
        println('Custom code: ${err.code}')
    }
    ''
}
```

If the type check matches, V automatically smart-casts `err` inside that block, allowing you to access custom fields (like `code` or `query`) without explicit casting.

---

# Chapter 9: Organizing Code with Modules

## Quick Access

Below is an index of all code examples in this chapter. You can use these links to jump directly to any specific code example:

**Modules & Project Structure**

- [Creating a Simple V Project - Main (modulebasics.v)](#creating-a-simple-v-project---main-modulebasicsv)
- [Creating a Module - Helper (file1.v)](#creating-a-module---helper-file1v)
- [Creating a Module - Main (modulebasics.v)](#creating-a-module---main-modulebasicsv)
- [Importing a Module - Helper (file1.v)](#importing-a-module---helper-file1v)
- [Importing a Module - Main (modulebasics.v)](#importing-a-module---main-modulebasicsv)
- [Accessing Module Members - Helper (file1.v)](#accessing-module-members---helper-file1v)
- [Accessing Module Members - Main (modulebasics.v)](#accessing-module-members---main-modulebasicsv)
- [Multiple Files (After Refactoring) - Helper 1 (file1.v)](#multiple-files-after-refactoring---helper-1-file1v)
- [Multiple Files (After Refactoring) - Helper 2 (file2.v)](#multiple-files-after-refactoring---helper-2-file2v)
- [Multiple Files (After Refactoring) - Main (modulebasics.v)](#multiple-files-after-refactoring---main-modulebasicsv)
- [Multiple Files (Before Refactoring) - Helper 1 (file1.v)](#multiple-files-before-refactoring---helper-1-file1v)
- [Multiple Files (Before Refactoring) - Helper 2 (file2.v)](#multiple-files-before-refactoring---helper-2-file2v)
- [Multiple Files (Before Refactoring) - Main (modulebasics.v)](#multiple-files-before-refactoring---main-modulebasicsv)
- [Member Scope (After Refactoring) - Helper 1 (file1.v)](#member-scope-after-refactoring---helper-1-file1v)
- [Member Scope (After Refactoring) - Helper 2 (file2.v)](#member-scope-after-refactoring---helper-2-file2v)
- [Member Scope (After Refactoring) - Main (modulebasics.v)](#member-scope-after-refactoring---main-modulebasicsv)
- [Member Scope (Before Refactoring) - Helper 1 (file1.v)](#member-scope-before-refactoring---helper-1-file1v)
- [Member Scope (Before Refactoring) - Helper 2 (file2.v)](#member-scope-before-refactoring---helper-2-file2v)
- [Member Scope (Before Refactoring) - Main (modulebasics.v)](#member-scope-before-refactoring---main-modulebasicsv)
- [Cyclic Imports - Module 1 Helper (file1.v)](#cyclic-imports---module-1-helper-file1v)
- [Cyclic Imports - Module 2 Helper (file1.v)](#cyclic-imports---module-2-helper-file1v)
- [Cyclic Imports - Main (modulebasics.v)](#cyclic-imports---main-modulebasicsv)
- [Module Init Function - Helper (file1.v)](#module-init-function---helper-file1v)
- [Module Init Function - Main (modulebasics.v)](#module-init-function---main-modulebasicsv)
- [Accessing Module Constants - Helper (file1.v)](#accessing-module-constants---helper-file1v)
- [Accessing Module Constants - Main (modulebasics.v)](#accessing-module-constants---main-modulebasicsv)
- [Accessing Module Structs - Helper (file1.v)](#accessing-module-structs---helper-file1v)
- [Accessing Module Structs - Main (modulebasics.v)](#accessing-module-structs---main-modulebasicsv)

**Installing External Packages**

- [How to Install Packages with vpm](#how-to-install-packages-with-vpm)
- [Common vpm Commands](#common-vpm-commands)
- [Importing and Using External Packages](#importing-and-using-external-packages)
- [Redis Console Demo](#redis-console-demo)
- [Redis Console Demo - Helper (redis_helper.v)](#redis-console-demo---helper-redis_helperv)
- [Redis Namespaced Demo - Helper (redis_helper.v)](#redis-namespaced-demo---helper-redis_helperv)
- [Redis Namespaced Demo](#redis-namespaced-demo)
- [Redis Webview Demo](#redis-webview-demo)
- [Webview Demo](#webview-demo)

---

Modules help organize larger codebases. In this chapter, you will learn how to create modules, import them, manage member visibility using `pub`, and understand module initialization lifecycle.

## Modules & Project Structure

### Creating a Simple V Project - Main (modulebasics.v)

_File location: [modules/01_creating_simple_v_project/modulebasics/modulebasics.v](file:///Users/codecaine/V-Programming-Comprehensive-Guide/modules/01_creating_simple_v_project/modulebasics/modulebasics.v)_

### Lesson: Creating a Simple V Project

Think of a module as a small toolbox. The `main` module is the entry point of your program, while other modules can hold reusable functions and types.

This first example is intentionally simple: it shows the structure of a single-file V program before we introduce imports and shared modules.

```v
module main

fn main() {
	println('Welcome to the V module demo!')
}
```

---

### Creating a Module - Helper (file1.v)

_File location: [modules/02_creating_modue/modulebasics/mod1/file1.v](file:///Users/codecaine/V-Programming-Comprehensive-Guide/modules/02_creating_modue/modulebasics/mod1/file1.v)_

### Lesson: A Reusable Helper Module

A module can hold functions that other parts of your program can reuse. In this example, the helper module `mod1` exposes a public function called `greet`.

```v
module mod1

pub fn greet(name string) string {
	return 'Hello, ${name}!'
}
```

---

### Creating a Module - Main (modulebasics.v)

_File location: [modules/02_creating_modue/modulebasics/modulebasics.v](file:///Users/codecaine/V-Programming-Comprehensive-Guide/modules/02_creating_modue/modulebasics/modulebasics.v)_

### Lesson: Module Main Entry

This file acts as the application entry point. It imports the helper module and calls one of its public functions.

```v
module main

import mod1

fn main() {
	println(mod1.greet('Ada'))
}
```

---

### Importing a Module - Helper (file1.v)

_File location: [modules/03_importing_module/modulebasics/mod1/file1.v](file:///Users/codecaine/V-Programming-Comprehensive-Guide/modules/03_importing_module/modulebasics/mod1/file1.v)_

### Lesson: Imported Module Helper

Importing a module gives your program access to its public members. The module name becomes the namespace you use when calling those functions.

```v
module mod1

pub fn greet(name string) string {
	return 'Hello, ${name}!'
}
```

---

### Importing a Module - Main (modulebasics.v)

_File location: [modules/03_importing_module/modulebasics/modulebasics.v](file:///Users/codecaine/V-Programming-Comprehensive-Guide/modules/03_importing_module/modulebasics/modulebasics.v)_

### Lesson: Imported Module Main

The main program can now use the imported module without copying its code into the entry file.

```v
module main

import mod1

fn main() {
	message := mod1.greet('Lina')
	println(message)
}
```

---

### Accessing Module Members - Helper (file1.v)

_File location: [modules/04_accessing_members_of_module/modulebasics/mod1/file1.v](file:///Users/codecaine/V-Programming-Comprehensive-Guide/modules/04_accessing_members_of_module/modulebasics/mod1/file1.v)_

### Lesson: Public vs Private Members

Not everything in a module should be accessible from outside. In V, `pub` makes a function available to other modules, while private functions stay inside the module.

```v
module mod1

pub fn greet(name string) string {
	return 'Hello, ${name}!'
}

fn internal_note() string {
	return 'This helper stays inside the module.'
}
```

---

### Accessing Module Members - Main (modulebasics.v)

_File location: [modules/04_accessing_members_of_module/modulebasics/modulebasics.v](file:///Users/codecaine/V-Programming-Comprehensive-Guide/modules/04_accessing_members_of_module/modulebasics/modulebasics.v)_

### Lesson: Member Visibility Main

From the main program, you can call the public function, but private helpers remain hidden.

```v
module main

import mod1

fn main() {
	println(mod1.greet('Noor'))
	// mod1.internal_note() is not allowed from here
}
```

---

### Multiple Files (After Refactoring) - Helper 1 (file1.v)

_File location: [modules/05_working_with_multiple_files_in_module/after/modulebasics/mod1/file1.v](file:///Users/codecaine/V-Programming-Comprehensive-Guide/modules/05_working_with_multiple_files_in_module/after/modulebasics/mod1/file1.v)_

### Lesson: Multiple Files (After Refactoring) - Helper 1

A single module can be split across several files. This makes it easier to keep related helpers organized without changing how the module is imported.

```v
module mod1

pub fn hello() {
	println('Hello from mod1!')
}
```

---

### Multiple Files (After Refactoring) - Helper 2 (file2.v)

_File location: [modules/05_working_with_multiple_files_in_module/after/modulebasics/mod1/file2.v](file:///Users/codecaine/V-Programming-Comprehensive-Guide/modules/05_working_with_multiple_files_in_module/after/modulebasics/mod1/file2.v)_

### Lesson: Multiple Files (After Refactoring) - Helper 2

The second file in the same module can hold additional helper functions. The module still behaves as one logical unit when imported.

```v
module mod1

fn hello2() {
	println('Hello 2 from mod1!')
}
```

---

### Multiple Files (After Refactoring) - Main (modulebasics.v)

_File location: [modules/05_working_with_multiple_files_in_module/after/modulebasics/modulebasics.v](file:///Users/codecaine/V-Programming-Comprehensive-Guide/modules/05_working_with_multiple_files_in_module/after/modulebasics/modulebasics.v)_

### Lesson: Multiple Files (After Refactoring) - Main Entry

Modules help modularize V projects, managing imports and symbol visibility. This lesson on **Modulebasics** demonstrates code structure, module namespaces, access modifiers, or lifecycle rules.

**Additional Context from Repository docs:**
This example demonstrates the concepts of **modulebasics**.

```v
module main

import mod1

fn main() {
	mod1.hello()
	println('Hello World!')
}
```

---

### Multiple Files (Before Refactoring) - Helper 1 (file1.v)

_File location: [modules/05_working_with_multiple_files_in_module/before/modulebasics/mod1/file1.v](file:///Users/codecaine/V-Programming-Comprehensive-Guide/modules/05_working_with_multiple_files_in_module/before/modulebasics/mod1/file1.v)_

### Lesson: Multiple Files (Before Refactoring) - Helper 1

Modules help modularize V projects, managing imports and symbol visibility. This lesson on **File1** demonstrates code structure, module namespaces, access modifiers, or lifecycle rules.

**Additional Context from Repository docs:**
This example demonstrates the concepts of **file1**.

```v
module mod1

pub fn hello() {
	println('Hello from mod1!')
}
```

---

### Multiple Files (Before Refactoring) - Helper 2 (file2.v)

_File location: [modules/05_working_with_multiple_files_in_module/before/modulebasics/mod1/file2.v](file:///Users/codecaine/V-Programming-Comprehensive-Guide/modules/05_working_with_multiple_files_in_module/before/modulebasics/mod1/file2.v)_

### Lesson: Multiple Files (Before Refactoring) - Helper 2

Modules help modularize V projects, managing imports and symbol visibility. This lesson on **File2** demonstrates code structure, module namespaces, access modifiers, or lifecycle rules.

**Additional Context from Repository docs:**
This example demonstrates the concepts of **file2**.

```v
fn hello2() {
	println('Hello 2 from mod1!')
}

fn main() {
}
```

---

### Multiple Files (Before Refactoring) - Main (modulebasics.v)

_File location: [modules/05_working_with_multiple_files_in_module/before/modulebasics/modulebasics.v](file:///Users/codecaine/V-Programming-Comprehensive-Guide/modules/05_working_with_multiple_files_in_module/before/modulebasics/modulebasics.v)_

### Lesson: Multiple Files (Before Refactoring) - Main Entry

Modules help modularize V projects, managing imports and symbol visibility. This lesson on **Modulebasics** demonstrates code structure, module namespaces, access modifiers, or lifecycle rules.

**Additional Context from Repository docs:**
This example demonstrates the concepts of **modulebasics**.

```v
module main

import mod1

fn main() {
	mod1.hello()
	println('Hello World!')
}
```

---

### Member Scope (After Refactoring) - Helper 1 (file1.v)

_File location: [modules/06_member_scope_in_module/after/modulebasics/mod1/file1.v](file:///Users/codecaine/V-Programming-Comprehensive-Guide/modules/06_member_scope_in_module/after/modulebasics/mod1/file1.v)_

### Lesson: Member Scope (After Refactoring) - Helper 1

A function marked `pub` can be called from outside the module, while a private helper can still be used by other functions inside the same module.

```v
module mod1

pub fn hello() {
	println('Hello from mod1!')
	// hello2 is not a public but accessible within mod1
	hello2()
}
```

---

### Member Scope (After Refactoring) - Helper 2 (file2.v)

_File location: [modules/06_member_scope_in_module/after/modulebasics/mod1/file2.v](file:///Users/codecaine/V-Programming-Comprehensive-Guide/modules/06_member_scope_in_module/after/modulebasics/mod1/file2.v)_

### Lesson: Member Scope (After Refactoring) - Helper 2

Modules help modularize V projects, managing imports and symbol visibility. This lesson on **File2** demonstrates code structure, module namespaces, access modifiers, or lifecycle rules.

**Additional Context from Repository docs:**
This example demonstrates the concepts of **file2**.

```v
module mod1

fn hello2() {
	println('Hello 2 from mod1!')
}
```

---

### Member Scope (After Refactoring) - Main (modulebasics.v)

_File location: [modules/06_member_scope_in_module/after/modulebasics/modulebasics.v](file:///Users/codecaine/V-Programming-Comprehensive-Guide/modules/06_member_scope_in_module/after/modulebasics/modulebasics.v)_

### Lesson: Member Scope (After Refactoring) - Main Entry

Modules help modularize V projects, managing imports and symbol visibility. This lesson on **Modulebasics** demonstrates code structure, module namespaces, access modifiers, or lifecycle rules.

**Additional Context from Repository docs:**
This example demonstrates the concepts of **modulebasics**.

```v
module main

import mod1

fn main() {
	mod1.hello()
}
```

---

### Member Scope (Before Refactoring) - Helper 1 (file1.v)

_File location: [modules/06_member_scope_in_module/before/modulebasics/mod1/file1.v](file:///Users/codecaine/V-Programming-Comprehensive-Guide/modules/06_member_scope_in_module/before/modulebasics/mod1/file1.v)_

### Lesson: Member Scope (Before Refactoring) - Helper 1

Modules help modularize V projects, managing imports and symbol visibility. This lesson on **File1** demonstrates code structure, module namespaces, access modifiers, or lifecycle rules.

**Additional Context from Repository docs:**
This example demonstrates the concepts of **file1**.

```v
module mod1

pub fn hello() {
	println('Hello from mod1!')
}
```

---

### Member Scope (Before Refactoring) - Helper 2 (file2.v)

_File location: [modules/06_member_scope_in_module/before/modulebasics/mod1/file2.v](file:///Users/codecaine/V-Programming-Comprehensive-Guide/modules/06_member_scope_in_module/before/modulebasics/mod1/file2.v)_

### Lesson: Member Scope (Before Refactoring) - Helper 2

Modules help modularize V projects, managing imports and symbol visibility. This lesson on **File2** demonstrates code structure, module namespaces, access modifiers, or lifecycle rules.

**Additional Context from Repository docs:**
This example demonstrates the concepts of **file2**.

```v
module mod1

fn hello2() {
	println('Hello 2 from mod1!')
}
```

---

### Member Scope (Before Refactoring) - Main (modulebasics.v)

_File location: [modules/06_member_scope_in_module/before/modulebasics/modulebasics.v](file:///Users/codecaine/V-Programming-Comprehensive-Guide/modules/06_member_scope_in_module/before/modulebasics/modulebasics.v)_

### Lesson: Member Scope (Before Refactoring) - Main Entry

Modules help modularize V projects, managing imports and symbol visibility. This lesson on **Modulebasics** demonstrates code structure, module namespaces, access modifiers, or lifecycle rules.

**Additional Context from Repository docs:**
This example demonstrates the concepts of **modulebasics**.

```v
module main

import mod1

fn main() {
	mod1.hello()
	mod1.hello2()
}
```

---

### Cyclic Imports - Module 1 Helper (file1.v)

_File location: [modules/07_cyclic_imports/modulebasics/m1/file1.v](file:///Users/codecaine/V-Programming-Comprehensive-Guide/modules/07_cyclic_imports/modulebasics/m1/file1.v)_

### Lesson: Cyclic Imports - Module 1

This example shows a circular dependency between two modules. In practice, you should avoid this pattern because it makes the import graph harder to reason about.

```v
module m1

import m2

pub const greet_from_m1 = 'Greetings from m1'

pub fn hello() {
	println(m2.greet_from_m2)
}
```

---

### Cyclic Imports - Module 2 Helper (file1.v)

_File location: [modules/07_cyclic_imports/modulebasics/m2/file1.v](file:///Users/codecaine/V-Programming-Comprehensive-Guide/modules/07_cyclic_imports/modulebasics/m2/file1.v)_

### Lesson: Cyclic Imports - Module 2

Modules help modularize V projects, managing imports and symbol visibility. This lesson on **File1** demonstrates code structure, module namespaces, access modifiers, or lifecycle rules.

**Additional Context from Repository docs:**
This example demonstrates the concepts of **file1**.

```v
module m2

import m1

pub const greet_from_m2 = 'Greetings from m2'

pub fn hello() {
	println(m1.greet_from_m1)
}
```

---

### Cyclic Imports - Main (modulebasics.v)

_File location: [modules/07_cyclic_imports/modulebasics/modulebasics.v](file:///Users/codecaine/V-Programming-Comprehensive-Guide/modules/07_cyclic_imports/modulebasics/modulebasics.v)_

### Lesson: Cyclic Imports - Main Entry

Modules help modularize V projects, managing imports and symbol visibility. This lesson on **Modulebasics** demonstrates code structure, module namespaces, access modifiers, or lifecycle rules.

**Additional Context from Repository docs:**
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

---

### Module Init & Cleanup Functions - Helper (file1.v)

_File location: [modules/08_init_function_for_module/modulebasics/mod1/file1.v](file:///Users/codecaine/V-Programming-Comprehensive-Guide/modules/08_init_function_for_module/modulebasics/mod1/file1.v)_

### Lesson: Module Init & Cleanup Functions Helper

V modules support lifecycle hooks for setting up and tearing down resources:

- **`init()`**: A special private function (`fn init()`) that runs automatically when a module is first imported. It is ideal for one-time initialization, such as preparing C libraries or setting up state.
- **`cleanup()`**: A special private function (`fn cleanup()`) that executes automatically when the program terminates. It runs in the reverse order of the `init()` calls, making it perfect for releasing C library resources or flushing files.

```v
module mod1

pub fn hello() {
	println('Hello from mod1!')
}

fn init() {
	println('Initializing mod1')
}

fn cleanup() {
	println('Cleaning up mod1')
}
```

---

### Module Init & Cleanup Functions - Main (modulebasics.v)

_File location: [modules/08_init_function_for_module/modulebasics/modulebasics.v](file:///Users/codecaine/V-Programming-Comprehensive-Guide/modules/08_init_function_for_module/modulebasics/modulebasics.v)_

### Lesson: Module Init & Cleanup Functions

V is designed to be highly modular. Here is a summary of the core rules governing V modules:

#### 1. Module Basics & Organization

- **Scope:** Every file in a directory belongs to the same module. If no module name is specified at the top of the file, it defaults to `main`.
- **Visibility:** All elements (structs, functions, constants, etc.) inside a module are visible across all files of that same module, regardless of whether they are marked with `pub`.
- **Names:** Module names must be short (ideally under 10 characters) and written in `snake_case`.
- **Circular Imports:** Circular imports are strictly forbidden.

#### 2. Module Lookup & `v.mod`

- V uses `v.mod` files as lookup anchors.
- The directory containing the nearest `v.mod` file is prepended to V's module search path. This enables projects to easily import submodules (e.g. `import myapp.common`) using relative structure anchors.

#### 3. Special Prototyping Rules for Project Roots

- For the top-level project folder (compiled with `v .`), you can have multiple `.v` files belonging to different modules (like `module main` and `module abc`) in the same directory.
- This is a special rule designed to ease prototyping, allowing you to split files easily before moving them to separate directory submodules. In any other non-root directory, all `.v` files must declare the exact same module name matching the folder name.

#### 4. Lifecycle Hooks (`init` & `cleanup`)

- Neither `init()` nor `cleanup()` can be made public (`pub`).
- V calls `init()` exactly once when the module is imported, regardless of how many other modules transitively import it.
- V calls `cleanup()` automatically once at the end of program execution, in the exact reverse order of their `init()` invocations.

```v
module main

import mod1

fn main() {
	mod1.hello()
}
```

---

### Accessing Module Constants - Helper (file1.v)

_File location: [modules/09_accessing_constants_of_module/modulebasics/mod1/file1.v](file:///Users/codecaine/V-Programming-Comprehensive-Guide/modules/09_accessing_constants_of_module/modulebasics/mod1/file1.v)_

### Lesson: Accessing Module Constants Helper

Constants are shared values that belong to a module. They are great for configuration strings or fixed messages that multiple files can use.

```v
module mod1

pub const greet_msg = 'Greeting from mod1!'
```

---

### Accessing Module Constants - Main (modulebasics.v)

_File location: [modules/09_accessing_constants_of_module/modulebasics/modulebasics.v](file:///Users/codecaine/V-Programming-Comprehensive-Guide/modules/09_accessing_constants_of_module/modulebasics/modulebasics.v)_

### Lesson: Accessing Module Constants

Modules help modularize V projects, managing imports and symbol visibility. This lesson on **Modulebasics** demonstrates code structure, module namespaces, access modifiers, or lifecycle rules.

**Additional Context from Repository docs:**
This example demonstrates the concepts of **modulebasics**.

```v
module main

import mod1

fn main() {
	println(mod1.greet_msg)
}
```

---

### Accessing Module Structs - Helper (file1.v)

_File location: [modules/10_accessing_structs_and_embedded_structs_of_module/modulebasics/mod1/file1.v](file:///Users/codecaine/V-Programming-Comprehensive-Guide/modules/10_accessing_structs_and_embedded_structs_of_module/modulebasics/mod1/file1.v)_

### Lesson: Accessing Module Structs Helper

A **struct** is a user-defined custom type that groups related variables (called fields) together. Structs are fundamental to V's object-oriented programming model. By default, struct fields are private and immutable. V provides access modifiers like `mut:`, `pub:`, and `pub mut:` to control field access and mutability.

These examples demonstrate defining structs, updating fields, required fields, default values, and struct methods.

**Additional Context from Repository docs:**
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

---

### Accessing Module Structs - Main (modulebasics.v)

_File location: [modules/10_accessing_structs_and_embedded_structs_of_module/modulebasics/modulebasics.v](file:///Users/codecaine/V-Programming-Comprehensive-Guide/modules/10_accessing_structs_and_embedded_structs_of_module/modulebasics/modulebasics.v)_

### Lesson: Accessing Module Structs

A **struct** is a user-defined custom type that groups related variables (called fields) together. Structs are fundamental to V's object-oriented programming model. By default, struct fields are private and immutable. V provides access modifiers like `mut:`, `pub:`, and `pub mut:` to control field access and mutability.

These examples demonstrate defining structs, updating fields, required fields, default values, and struct methods.

**Additional Context from Repository docs:**
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

---

## Installing External Packages

V has a built-in package manager called `vpm` (V Package Manager) that allows you to easily install, update, and manage third-party modules. External packages are hosted on the official V registry at [vpm.vlang.io](https://vpm.vlang.io).

### How to Install Packages with vpm

To install a package, use the `v install` command followed by the package identifier (usually in the format `author.package_name`):

```bash
v install xiusin.vredis
```

This downloads the package and installs it into the V modules directory (typically located at `~/.vmodules/` on Linux/macOS or `C:\Users\Username\.vmodules\` on Windows).

### Common vpm Commands

- **Install a package:**
  ```bash
  v install author.package_name
  ```
- **Install from a Git repository directly:**
  ```bash
  v install https://github.com/author/package_name
  ```
- **Update an installed package:**
  ```bash
  v update author.package_name
  ```
- **Remove/uninstall a package:**
  ```bash
  v remove author.package_name
  ```
- **Search for packages:**
  ```bash
  v search query
  ```

### Importing and Using External Packages

Once a package is installed via `vpm`, you can import it in your V code just like a standard library module:

```v
import xiusin.vredis

fn main() {
	// Code utilizing the external redis package
}
```

---

### Redis Console Demo

_File location: [modules/11_install_external_packages_and_webview/redis_console_demo/redis_console_demo.v](file:///Users/codecaine/V-Programming-Comprehensive-Guide/modules/11_install_external_packages_and_webview/redis_console_demo/redis_console_demo.v)_

This example demonstrates how to use the external `xiusin.vredis` client package in a console application and demonstrates key namespacing with the custom `NamespacedRedis` helper. It covers:

- Establishing a connection and handling errors gracefully.
- Basic String operations (`set`, `get`, `incr`, `expire`, `ttl`, `del`).
- List operations (`rpush`, `llen`, `lrange`, `lpop`).
- Hash operations (`hset`, `hget`, `hgetall`).
- Set operations (`sadd`, `sismember`, `smembers`).
- Namespaced Redis helper operations using `NamespacedRedis`.
- Cleaning up created keys on application exit.

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

---

### Redis Console Demo - Helper (redis_helper.v)

_File location: [modules/11_install_external_packages_and_webview/redis_console_demo/redis_helper.v](file:///Users/codecaine/V-Programming-Comprehensive-Guide/modules/11_install_external_packages_and_webview/redis_console_demo/redis_helper.v)_

This helper provides a namespaced wrapper struct `NamespacedRedis` that automatically prefixes all Redis keys with a given namespace (e.g. `namespace:key`). This is a great pattern for keeping keys organized and avoiding collisions between multiple apps/environments.

```v
module main

import xiusin.vredis

// NamespacedRedis wraps a standard vredis.Redis client and prefixes all keys with a namespace.
// This simplifies multi-tenant or multi-app key separation.
struct NamespacedRedis {
mut:
	client &vredis.Redis
pub:
	namespace string
}

// new_namespaced_redis creates a new NamespacedRedis helper wrapper.
fn new_namespaced_redis(client &vredis.Redis, namespace string) NamespacedRedis {
	return NamespacedRedis{
		client: client
		namespace: namespace
	}
}

// key constructs the final namespaced key.
// E.g. key('mykey') -> 'app1:mykey'
fn (nr NamespacedRedis) key(name string) string {
	if nr.namespace == '' {
		return name
	}
	return '${nr.namespace}:${name}'
}

// close closes the connection to the Redis server.
fn (mut nr NamespacedRedis) close() ! {
	nr.client.close()!
}

// --- String Operations ---

// set sets a key to a string value.
fn (mut nr NamespacedRedis) set(key string, val string) ! {
	nr.client.set(nr.key(key), val)!
}

// get retrieves a string value by key.
fn (mut nr NamespacedRedis) get(key string) !string {
	return nr.client.get(nr.key(key))!
}

// incr increments a numeric key.
fn (mut nr NamespacedRedis) incr(key string) ! {
	nr.client.incr(nr.key(key))!
}

// expire sets an expiration time (TTL) in seconds on a key.
fn (mut nr NamespacedRedis) expire(key string, seconds int) ! {
	nr.client.expire(nr.key(key), seconds)!
}

// ttl returns the remaining Time-To-Live of a key.
fn (mut nr NamespacedRedis) ttl(key string) !int {
	return nr.client.ttl(nr.key(key))!
}

// del deletes a key.
fn (mut nr NamespacedRedis) del(key string) ! {
	nr.client.del(nr.key(key))!
}

// --- List Operations ---

// rpush appends a value to a list.
fn (mut nr NamespacedRedis) rpush(key string, val string) ! {
	nr.client.rpush(nr.key(key), val)!
}

// lrange retrieves a range of elements from a list.
fn (mut nr NamespacedRedis) lrange(key string, start int, stop int) ![]string {
	return nr.client.lrange(nr.key(key), start, stop)!
}

// lpop removes and returns the first element of a list.
fn (mut nr NamespacedRedis) lpop(key string) !string {
	return nr.client.lpop(nr.key(key))!
}

// llen returns the length of a list.
fn (mut nr NamespacedRedis) llen(key string) !int {
	return nr.client.llen(nr.key(key))!
}

// --- Hash Operations ---

// hset sets a field in a hash to a value.
fn (mut nr NamespacedRedis) hset(key string, field string, val string) ! {
	nr.client.hset(nr.key(key), field, val)!
}

// hget retrieves a field's value from a hash.
fn (mut nr NamespacedRedis) hget(key string, field string) !string {
	return nr.client.hget(nr.key(key), field)!
}

// hgetall retrieves all fields and values of a hash.
fn (mut nr NamespacedRedis) hgetall(key string) !map[string]string {
	return nr.client.hgetall(nr.key(key))!
}

// --- Set Operations ---

// sadd adds a member to a set.
fn (mut nr NamespacedRedis) sadd(key string, member string) ! {
	nr.client.sadd(nr.key(key), member)!
}

// sismember checks if a member belongs to a set.
fn (mut nr NamespacedRedis) sismember(key string, member string) !bool {
	return nr.client.sismember(nr.key(key), member)!
}

// smembers returns all members of a set.
fn (mut nr NamespacedRedis) smembers(key string) ![]string {
	return nr.client.smembers(nr.key(key))!
}
```

---

### Redis Namespaced Demo - Helper (redis_helper.v)

_File location: [modules/11_install_external_packages_and_webview/redis_namespaced_demo/redis_helper.v](file:///Users/codecaine/V-Programming-Comprehensive-Guide/modules/11_install_external_packages_and_webview/redis_namespaced_demo/redis_helper.v)_

### Lesson: Redis Namespaced Helper

Modules help modularize V projects, managing imports and symbol visibility. This lesson on **Redis Helper** demonstrates code structure, module namespaces, access modifiers, or lifecycle rules.

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

// new_namespaced_redis creates a new NamespacedRedis helper wrapper.
fn new_namespaced_redis(client &vredis.Redis, namespace string) NamespacedRedis {
	return NamespacedRedis{
		client: client
		namespace: namespace
	}
}

// key constructs the final namespaced key.
fn (nr NamespacedRedis) key(name string) string {
	if nr.namespace == '' {
		return name
	}
	return '${nr.namespace}:${name}'
}

// close closes the connection to the Redis server.
fn (mut nr NamespacedRedis) close() ! {
	nr.client.close()!
}

// --- String Operations ---

// set sets a key to a string value.
fn (mut nr NamespacedRedis) set(key string, val string) ! {
	nr.client.set(nr.key(key), val)!
}

// get retrieves a string value by key.
fn (mut nr NamespacedRedis) get(key string) !string {
	return nr.client.get(nr.key(key))!
}

// incr increments a numeric key.
fn (mut nr NamespacedRedis) incr(key string) ! {
	nr.client.incr(nr.key(key))!
}

// expire sets an expiration time (TTL) in seconds on a key.
fn (mut nr NamespacedRedis) expire(key string, seconds int) ! {
	nr.client.expire(nr.key(key), seconds)!
}

// ttl returns the remaining Time-To-Live of a key.
fn (mut nr NamespacedRedis) ttl(key string) !int {
	return nr.client.ttl(nr.key(key))!
}

// del deletes a key.
fn (mut nr NamespacedRedis) del(key string) ! {
	nr.client.del(nr.key(key))!
}

// --- List Operations ---

// rpush appends a value to a list.
fn (mut nr NamespacedRedis) rpush(key string, val string) ! {
	nr.client.rpush(nr.key(key), val)!
}

// lrange retrieves a range of elements from a list.
fn (mut nr NamespacedRedis) lrange(key string, start int, stop int) ![]string {
	return nr.client.lrange(nr.key(key), start, stop)!
}

// lpop removes and returns the first element of a list.
fn (mut nr NamespacedRedis) lpop(key string) !string {
	return nr.client.lpop(nr.key(key))!
}

// llen returns the length of a list.
fn (mut nr NamespacedRedis) llen(key string) !int {
	return nr.client.llen(nr.key(key))!
}

// --- Hash Operations ---

// hset sets a field in a hash to a value.
fn (mut nr NamespacedRedis) hset(key string, field string, val string) ! {
	nr.client.hset(nr.key(key), field, val)!
}

// hget retrieves a field's value from a hash.
fn (mut nr NamespacedRedis) hget(key string, field string) !string {
	return nr.client.hget(nr.key(key), field)!
}

// hgetall retrieves all fields and values of a hash.
fn (mut nr NamespacedRedis) hgetall(key string) !map[string]string {
	return nr.client.hgetall(nr.key(key))!
}

// --- Set Operations ---

// sadd adds a member to a set.
fn (mut nr NamespacedRedis) sadd(key string, member string) ! {
	nr.client.sadd(nr.key(key), member)!
}

// sismember checks if a member belongs to a set.
fn (mut nr NamespacedRedis) sismember(key string, member string) !bool {
	return nr.client.sismember(nr.key(key), member)!
}

// smembers returns all members of a set.
fn (mut nr NamespacedRedis) smembers(key string) ![]string {
	return nr.client.smembers(nr.key(key))!
}
```

---

### Redis Namespaced Demo

_File location: [modules/11_install_external_packages_and_webview/redis_namespaced_demo/redis_namespaced_demo.v](file:///Users/codecaine/V-Programming-Comprehensive-Guide/modules/11_install_external_packages_and_webview/redis_namespaced_demo/redis_namespaced_demo.v)_

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

---

### Redis Webview Demo

_File location: [modules/11_install_external_packages_and_webview/redis_webview_demo/redis_webview_demo.v](file:///Users/codecaine/V-Programming-Comprehensive-Guide/modules/11_install_external_packages_and_webview/redis_webview_demo/redis_webview_demo.v)_

### Lesson: Redis Webview Demo

Modules help modularize V projects, managing imports and symbol visibility. This lesson on **Redis Webview Demo** demonstrates code structure, module namespaces, access modifiers, or lifecycle rules.

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
				parts := line.split(':')
				if parts.len >= 2 {
					version = parts[1].trim_space()
				}
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

---

### Webview Demo

_File location: [modules/11_install_external_packages_and_webview/webview_demo/webview_demo.v](file:///Users/codecaine/V-Programming-Comprehensive-Guide/modules/11_install_external_packages_and_webview/webview_demo/webview_demo.v)_

### Lesson: Webview Demo

Modules help modularize V projects, managing imports and symbol visibility. This lesson on **Webview Demo** demonstrates code structure, module namespaces, access modifiers, or lifecycle rules.

**Additional Context from Repository docs:**
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

---

# Chapter 10: Writing Tests in V

## Quick Access

Below is an index of all code examples in this chapter. You can use these links to jump directly to any specific code example:

**Assertions & Unit Testing**

- [Assert Demo](#assert-demo)
- [Simple Test - Before (demo_test.v)](#simple-test---before-demo_testv)
- [Simple Test - After (demo_test.v)](#simple-test---after-demo_testv)
- [Testsuite Demo Test](#testsuite-demo-test)
- [Testing Optional Return Functions (demo_test.v)](#testing-optional-return-functions-demo_testv)
- [Greet](#greet)
- [Greet Test](#greet-test)
- [Main Test](#main-test)
- [Testing Program Modules - Helper (file1.v)](#testing-program-modules---helper-file1v)
- [Mod1 Test](#mod1-test)
- [Modulebasics](#modulebasics)

---

V has testing built directly into the compiler. This chapter explains how to write test files, use assertions, set up test suites with setup/teardown methods, and run test suites.

## Assertions & Unit Testing

### Assert Demo

_File location: [testing/01_assert/assert_demo.v](file:///Users/codecaine/V-Programming-Comprehensive-Guide/testing/01_assert/assert_demo.v)_

### Lesson: Assert Demo

V has built-in testing support. Any file ending with `_test.v` is considered a test file. Inside test files, you write functions starting with `test_` and use `assert` statements to check if conditions are true. You can run all tests in a folder using the `v test .` command.

These examples cover writing simple assertions, test suites, and testing functions that return options or errors.

**Additional Context from Repository docs:**
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

---

### Simple Test - Before (demo_test.v)

_File location: [testing/02_simple_test/01_before/demo_test.v](file:///Users/codecaine/V-Programming-Comprehensive-Guide/testing/02_simple_test/01_before/demo_test.v)_

### Lesson: Simple Test - Before

V has built-in testing support. Any file ending with `_test.v` is considered a test file. Inside test files, you write functions starting with `test_` and use `assert` statements to check if conditions are true. You can run all tests in a folder using the `v test .` command.

These examples cover writing simple assertions, test suites, and testing functions that return options or errors.

**Additional Context from Repository docs:**
This example demonstrates the concepts of **demo test**.

```v
fn test_first() {
	assert 2 != 2
}
```

---

### Simple Test - After (demo_test.v)

_File location: [testing/02_simple_test/02_after/demo_test.v](file:///Users/codecaine/V-Programming-Comprehensive-Guide/testing/02_simple_test/02_after/demo_test.v)_

### Lesson: Simple Test - After

V has built-in testing support. Any file ending with `_test.v` is considered a test file. Inside test files, you write functions starting with `test_` and use `assert` statements to check if conditions are true. You can run all tests in a folder using the `v test .` command.

These examples cover writing simple assertions, test suites, and testing functions that return options or errors.

**Additional Context from Repository docs:**
This example demonstrates the concepts of **demo test**.

```v
fn test_first() {
	assert 2 == 2
}
```

---

### Testsuite Demo Test

_File location: [testing/04_testsuite/testsuite_demo_test.v](file:///Users/codecaine/V-Programming-Comprehensive-Guide/testing/04_testsuite/testsuite_demo_test.v)_

### Lesson: Testsuite Demo Test

V has built-in testing support. Any file ending with `_test.v` is considered a test file. Inside test files, you write functions starting with `test_` and use `assert` statements to check if conditions are true. You can run all tests in a folder using the `v test .` command.

These examples cover writing simple assertions, test suites, and testing functions that return options or errors.

**Additional Context from Repository docs:**
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

---

### Testing Optional Return Functions (demo_test.v)

_File location: [testing/05_test_optional_return_functions/demo_test.v](file:///Users/codecaine/V-Programming-Comprehensive-Guide/testing/05_test_optional_return_functions/demo_test.v)_

### Lesson: Testing Optional Return Functions

V has built-in testing support. Any file ending with `_test.v` is considered a test file. Inside test files, you write functions starting with `test_` and use `assert` statements to check if conditions are true. You can run all tests in a folder using the `v test .` command.

These examples cover writing simple assertions, test suites, and testing functions that return options or errors.

**Additional Context from Repository docs:**
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
	res := greet('Pavan')!
	assert res == 'Hello Pavan!'
}

fn test_greet_when_empty() {
	exp := 'name not provided'
	assert (greet('') or { err.msg() }) == exp
}
```

---

### Greet

_File location: [testing/06_testing_program_file/greet.v](file:///Users/codecaine/V-Programming-Comprehensive-Guide/testing/06_testing_program_file/greet.v)_

### Lesson: Greet

V has built-in testing support. Any file ending with `_test.v` is considered a test file. Inside test files, you write functions starting with `test_` and use `assert` statements to check if conditions are true. You can run all tests in a folder using the `v test .` command.

These examples cover writing simple assertions, test suites, and testing functions that return options or errors.

**Additional Context from Repository docs:**
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

---

### Greet Test

_File location: [testing/06_testing_program_file/greet_test.v](file:///Users/codecaine/V-Programming-Comprehensive-Guide/testing/06_testing_program_file/greet_test.v)_

### Lesson: Greet Test

V has built-in testing support. Any file ending with `_test.v` is considered a test file. Inside test files, you write functions starting with `test_` and use `assert` statements to check if conditions are true. You can run all tests in a folder using the `v test .` command.

These examples cover writing simple assertions, test suites, and testing functions that return options or errors.

**Additional Context from Repository docs:**
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

---

### Main Test

_File location: [testing/07_testing_program_with_modules/modulebasics/main_test.v](file:///Users/codecaine/V-Programming-Comprehensive-Guide/testing/07_testing_program_with_modules/modulebasics/main_test.v)_

### Lesson: Main Test

V has built-in testing support. Any file ending with `_test.v` is considered a test file. Inside test files, you write functions starting with `test_` and use `assert` statements to check if conditions are true. You can run all tests in a folder using the `v test .` command.

These examples cover writing simple assertions, test suites, and testing functions that return options or errors.

**Additional Context from Repository docs:**
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

---

### Testing Program Modules - Helper (file1.v)

_File location: [testing/07_testing_program_with_modules/modulebasics/mod1/file1.v](file:///Users/codecaine/V-Programming-Comprehensive-Guide/testing/07_testing_program_with_modules/modulebasics/mod1/file1.v)_

### Lesson: Testing Program Modules - Helper

V has built-in testing support. Any file ending with `_test.v` is considered a test file. Inside test files, you write functions starting with `test_` and use `assert` statements to check if conditions are true. You can run all tests in a folder using the `v test .` command.

These examples cover writing simple assertions, test suites, and testing functions that return options or errors.

**Additional Context from Repository docs:**
This example demonstrates the concepts of **file1**.

```v
module mod1

pub fn hello() string {
	return 'Hello from mod1!'
}
```

---

### Mod1 Test

_File location: [testing/07_testing_program_with_modules/modulebasics/mod1/mod1_test.v](file:///Users/codecaine/V-Programming-Comprehensive-Guide/testing/07_testing_program_with_modules/modulebasics/mod1/mod1_test.v)_

### Lesson: Mod1 Test

V has built-in testing support. Any file ending with `_test.v` is considered a test file. Inside test files, you write functions starting with `test_` and use `assert` statements to check if conditions are true. You can run all tests in a folder using the `v test .` command.

These examples cover writing simple assertions, test suites, and testing functions that return options or errors.

**Additional Context from Repository docs:**
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

---

### Modulebasics

_File location: [testing/07_testing_program_with_modules/modulebasics/modulebasics.v](file:///Users/codecaine/V-Programming-Comprehensive-Guide/testing/07_testing_program_with_modules/modulebasics/modulebasics.v)_

### Lesson: Modulebasics

V has built-in testing support. Any file ending with `_test.v` is considered a test file. Inside test files, you write functions starting with `test_` and use `assert` statements to check if conditions are true. You can run all tests in a folder using the `v test .` command.

These examples cover writing simple assertions, test suites, and testing functions that return options or errors.

**Additional Context from Repository docs:**
This example demonstrates the concepts of **modulebasics**.

```v
module main

import mod1

fn main() {
	res := mod1.hello()
	println(res)
}
```

---

# Chapter 11: Concurrency and Channels

## Quick Access

Below is an index of all code examples in this chapter. You can use these links to jump directly to any specific code example:

**Channels & Communication**

- [Unbuffered Channel](#unbuffered-channel)
- [Define Buffered Channel (buffered_channel.v)](#define-buffered-channel-buffered_channelv)
- [Push Buffered](#push-buffered)
- [Push Unbuffered](#push-unbuffered)
- [Pop](#pop)
- [Channel Properties](#channel-properties)
- [Try Push Unbuffered](#try-push-unbuffered)
- [Try Push Buffered](#try-push-buffered)
- [Try Pop](#try-pop)
- [Close](#close)
- [Defer Close](#defer-close)
- [Blocking Channels](#blocking-channels)
- [Dealing Before](#dealing-before)
- [Dealing After](#dealing-after)
- [Unbuffered Sync Before (sync_before.v)](#unbuffered-sync-before-sync_beforev)
- [Unbuffered Sync After (sync_after.v)](#unbuffered-sync-after-sync_afterv)
- [Understanding Buffered Channel (buffered_channel.v)](#understanding-buffered-channel-buffered_channelv)
- [Coroutines Communication](#coroutines-communication)
- [Buffered Sync Before (sync_before.v)](#buffered-sync-before-sync_beforev)
- [Buffered Sync After (sync_after.v)](#buffered-sync-after-sync_afterv)
- [Channel Select Before](#channel-select-before)
- [Channel Select](#channel-select)

**V-Routines & Concurrency**

- [Stopwatch Demo](#stopwatch-demo)
- [Spawn Void Function](#spawn-void-function)
- [Waiting On Concurrent Thread](#waiting-on-concurrent-thread)
- [Running Multiple Tasks In Sequence](#running-multiple-tasks-in-sequence)
- [Spawning Multiple Tasks Concurrently](#spawning-multiple-tasks-concurrently)
- [Functions With Return Values](#functions-with-return-values)
- [Spawn Anonymous Funcs Without Input Args](#spawn-anonymous-funcs-without-input-args)
- [Spawn Anonymous Funcs With Input Args](#spawn-anonymous-funcs-with-input-args)
- [Sharing Data Main And Concurrent Tasks](#sharing-data-main-and-concurrent-tasks)

---

V makes concurrent programming easy and safe. This chapter covers spawning threads using `spawn`, communicating safely between threads using channels, and sharing state safely using `shared` and `lock` primitives.

## Channels & Communication

### Unbuffered Channel

_File location: [channels/01_define_channels/01_unbuffered_channel.v](file:///Users/codecaine/V-Programming-Comprehensive-Guide/channels/01_define_channels/01_unbuffered_channel.v)_

### Lesson: Unbuffered Channel

Unbuffered channels in V have a capacity of 0. Sending data into an unbuffered channel blocks the sender thread until a receiver thread is ready to pop the data. This provides a strong synchronization point between execution threads.

**Additional Context from Repository docs:**
This example demonstrates the concepts of **unbuffered channel**.

```v
module main

fn main() {
	// 1. Declare an unbuffered channel of type 'int'.
	// In V, channels are declared using the `chan` keyword followed by the type.
	// An empty initializer `{}` defaults the capacity (`cap`) to 0.
	uc := chan int{}

	// 2. Query the capacity of the channel.
	// For unbuffered channels, the capacity is always 0.
	// This means any send operation (pushing data) will block the sending thread
	// until another thread is actively reading (popping data) from the channel.
	println('Unbuffered channel capacity: ${uc.cap}') // Outputs: 0

	// 3. Print the type name of the channel.
	// V's `typeof().name` provides runtime type reflection names.
	println('Type of channel: ${typeof(uc).name}') // Outputs: chan int
}
```

---

### Define Buffered Channel (buffered_channel.v)

_File location: [channels/01_define_channels/02_buffered_channel.v](file:///Users/codecaine/V-Programming-Comprehensive-Guide/channels/01_define_channels/02_buffered_channel.v)_

### Lesson: Define Buffered Channel

Buffered channels in V are initialized with a specific capacity. The sender thread can push elements into the channel without blocking as long as the buffer is not completely full. Once the buffer is full, subsequent send operations will block until elements are read by another thread.

**Additional Context from Repository docs:**
This example demonstrates the concepts of **buffered channel**.

```v
module main

fn main() {
	// 1. Declare a buffered channel of type 'string' with a capacity of 2.
	// We specify capacity using the `cap` initialization field.
	bc := chan string{cap: 2}

	// 2. Query the capacity of the channel.
	// For buffered channels, this returns the size of the buffer.
	// The sending thread will NOT block when pushing items into the channel
	// until the buffer is completely full (in this case, containing 2 elements).
	println('Buffered channel capacity: ${bc.cap}') // Outputs: 2

	// 3. Print the type name of the channel.
	println('Type of channel: ${typeof(bc).name}') // Outputs: chan string
}
```

---

### Push Buffered

_File location: [channels/02_channel_operations/01_push_buffered.v](file:///Users/codecaine/V-Programming-Comprehensive-Guide/channels/02_channel_operations/01_push_buffered.v)_

### Lesson: Push Buffered

V supports lightweight concurrency using **v-routines** via the `spawn` keyword (which spawns a function in a new thread). Threads communicate safely using **channels**, which prevent race conditions. For shared memory concurrency, V provides the `shared` keyword alongside `lock` and `unlock` blocks to safely synchronize access to variables.

These examples cover spawning tasks, reading/writing channels, buffering, select statements, and thread synchronization.

**Additional Context from Repository docs:**
This example demonstrates the concepts of **push buffered**.

```v
fn main() {
	ch := chan int{cap: 1}
	ch <- 51
	println(ch)
}
```

---

### Push Unbuffered

_File location: [channels/02_channel_operations/02_push_unbuffered.v](file:///Users/codecaine/V-Programming-Comprehensive-Guide/channels/02_channel_operations/02_push_unbuffered.v)_

### Lesson: Push Unbuffered

V supports lightweight concurrency using **v-routines** via the `spawn` keyword (which spawns a function in a new thread). Threads communicate safely using **channels**, which prevent race conditions. For shared memory concurrency, V provides the `shared` keyword alongside `lock` and `unlock` blocks to safely synchronize access to variables.

These examples cover spawning tasks, reading/writing channels, buffering, select statements, and thread synchronization.

**Additional Context from Repository docs:**
This example demonstrates the concepts of **push unbuffered**.

```v
fn main() {
	ch := chan int{}
	ch <- 51
	println(ch) // doesn't prints, due to blocking behavior of unbuffered channels
}
```

---

### Pop

_File location: [channels/02_channel_operations/03_pop.v](file:///Users/codecaine/V-Programming-Comprehensive-Guide/channels/02_channel_operations/03_pop.v)_

### Lesson: Pop

V supports lightweight concurrency using **v-routines** via the `spawn` keyword (which spawns a function in a new thread). Threads communicate safely using **channels**, which prevent race conditions. For shared memory concurrency, V provides the `shared` keyword alongside `lock` and `unlock` blocks to safely synchronize access to variables.

These examples cover spawning tasks, reading/writing channels, buffering, select statements, and thread synchronization.

**Additional Context from Repository docs:**
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

### Deep Dive Explanation: Channels & Basic Operations

#### 1. Unbuffered vs. Buffered Channels

- **Unbuffered Channels (`cap: 0`)**: Initialized via `chan T{}`. They have no intermediate storage. Any send operation (`ch <- value`) blocks the sender until a receiver is ready to pop the data (`<-ch`), and vice versa.
  > [!WARNING]
  > **Deadlock Risk:** In the `Push Unbuffered` example, calling `ch <- 51` in the `main` thread without spawning a concurrent reader thread blocks the program permanently, resulting in a thread deadlock.
- **Buffered Channels (`cap > 0`)**: Initialized via `chan T{cap: N}`. They can hold up to `N` items in a queue. Pushing to a buffered channel does **not** block as long as the current queue size is less than `N`. It only blocks when the buffer is full (`ch.len == N`). Popping blocks only when the buffer is empty (`ch.len == 0`).

#### 2. Channel Operations & Metadata Fields

- **Pushing (`<-`)**: Sends data to the channel. Format: `channel_var <- data`.
- **Popping (`<-`)**: Receives data from the channel. Format: `variable := <-channel_var`.
- **Properties**:
  - `.cap`: The static, defined capacity of the channel (0 for unbuffered).
  - `.len`: The number of currently buffered elements waiting to be popped.
  - `.closed`: A boolean indicating if the channel has been shut down via `close(ch)`.

---

### Channel Properties

_File location: [channels/03_channel_properties/01_channel_properties.v](file:///Users/codecaine/V-Programming-Comprehensive-Guide/channels/03_channel_properties/01_channel_properties.v)_

### Lesson: Channel Properties

V supports lightweight concurrency using **v-routines** via the `spawn` keyword (which spawns a function in a new thread). Threads communicate safely using **channels**, which prevent race conditions. For shared memory concurrency, V provides the `shared` keyword alongside `lock` and `unlock` blocks to safely synchronize access to variables.

These examples cover spawning tasks, reading/writing channels, buffering, select statements, and thread synchronization.

**Additional Context from Repository docs:**
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

---

### Try Push Unbuffered

_File location: [channels/04_channel_methods/01_try_push/01_try_push_unbuffered.v](file:///Users/codecaine/V-Programming-Comprehensive-Guide/channels/04_channel_methods/01_try_push/01_try_push_unbuffered.v)_

### Lesson: Try Push Unbuffered

V supports lightweight concurrency using **v-routines** via the `spawn` keyword (which spawns a function in a new thread). Threads communicate safely using **channels**, which prevent race conditions. For shared memory concurrency, V provides the `shared` keyword alongside `lock` and `unlock` blocks to safely synchronize access to variables.

These examples cover spawning tasks, reading/writing channels, buffering, select statements, and thread synchronization.

**Additional Context from Repository docs:**
This example demonstrates the concepts of **try push unbuffered**.

```v
fn main() {
	v := 'hi'
	ch := chan string{} // unbuffered channel
	res := ch.try_push(v)
	println(res) // not_ready
}
```

---

### Try Push Buffered

_File location: [channels/04_channel_methods/01_try_push/02_try_push_buffered.v](file:///Users/codecaine/V-Programming-Comprehensive-Guide/channels/04_channel_methods/01_try_push/02_try_push_buffered.v)_

### Lesson: Try Push Buffered

V supports lightweight concurrency using **v-routines** via the `spawn` keyword (which spawns a function in a new thread). Threads communicate safely using **channels**, which prevent race conditions. For shared memory concurrency, V provides the `shared` keyword alongside `lock` and `unlock` blocks to safely synchronize access to variables.

These examples cover spawning tasks, reading/writing channels, buffering, select statements, and thread synchronization.

**Additional Context from Repository docs:**
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

---

### Try Pop

_File location: [channels/04_channel_methods/02_try_pop/01_try_pop.v](file:///Users/codecaine/V-Programming-Comprehensive-Guide/channels/04_channel_methods/02_try_pop/01_try_pop.v)_

### Lesson: Try Pop

V supports lightweight concurrency using **v-routines** via the `spawn` keyword (which spawns a function in a new thread). Threads communicate safely using **channels**, which prevent race conditions. For shared memory concurrency, V provides the `shared` keyword alongside `lock` and `unlock` blocks to safely synchronize access to variables.

These examples cover spawning tasks, reading/writing channels, buffering, select statements, and thread synchronization.

**Additional Context from Repository docs:**
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

---

### Close

_File location: [channels/04_channel_methods/03_close/01_close/01_close.v](file:///Users/codecaine/V-Programming-Comprehensive-Guide/channels/04_channel_methods/03_close/01_close/01_close.v)_

### Lesson: Close

V supports lightweight concurrency using **v-routines** via the `spawn` keyword (which spawns a function in a new thread). Threads communicate safely using **channels**, which prevent race conditions. For shared memory concurrency, V provides the `shared` keyword alongside `lock` and `unlock` blocks to safely synchronize access to variables.

These examples cover spawning tasks, reading/writing channels, buffering, select statements, and thread synchronization.

**Additional Context from Repository docs:**
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

---

### Defer Close

_File location: [channels/04_channel_methods/03_close/02_defer_close/01_defer_close.v](file:///Users/codecaine/V-Programming-Comprehensive-Guide/channels/04_channel_methods/03_close/02_defer_close/01_defer_close.v)_

### Lesson: Defer Close

V supports lightweight concurrency using **v-routines** via the `spawn` keyword (which spawns a function in a new thread). Threads communicate safely using **channels**, which prevent race conditions. For shared memory concurrency, V provides the `shared` keyword alongside `lock` and `unlock` blocks to safely synchronize access to variables.

These examples cover spawning tasks, reading/writing channels, buffering, select statements, and thread synchronization.

**Additional Context from Repository docs:**
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

---

### Blocking Channels

_File location: [channels/05_working_with_unbuffered_channels/01_understanding_blocking_nature/01_blocking_channels.v](file:///Users/codecaine/V-Programming-Comprehensive-Guide/channels/05_working_with_unbuffered_channels/01_understanding_blocking_nature/01_blocking_channels.v)_

### Lesson: Blocking Channels

V supports lightweight concurrency using **v-routines** via the `spawn` keyword (which spawns a function in a new thread). Threads communicate safely using **channels**, which prevent race conditions. For shared memory concurrency, V provides the `shared` keyword alongside `lock` and `unlock` blocks to safely synchronize access to variables.

These examples cover spawning tasks, reading/writing channels, buffering, select statements, and thread synchronization.

**Additional Context from Repository docs:**
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

---

### Dealing Before

_File location: [channels/05_working_with_unbuffered_channels/02_dealing_with_blocking_channels/01_before/01_dealing_before.v](file:///Users/codecaine/V-Programming-Comprehensive-Guide/channels/05_working_with_unbuffered_channels/02_dealing_with_blocking_channels/01_before/01_dealing_before.v)_

### Lesson: Dealing Before

V supports lightweight concurrency using **v-routines** via the `spawn` keyword (which spawns a function in a new thread). Threads communicate safely using **channels**, which prevent race conditions. For shared memory concurrency, V provides the `shared` keyword alongside `lock` and `unlock` blocks to safely synchronize access to variables.

These examples cover spawning tasks, reading/writing channels, buffering, select statements, and thread synchronization.

**Additional Context from Repository docs:**
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

---

### Dealing After

_File location: [channels/05_working_with_unbuffered_channels/02_dealing_with_blocking_channels/02_after/01_dealing_after.v](file:///Users/codecaine/V-Programming-Comprehensive-Guide/channels/05_working_with_unbuffered_channels/02_dealing_with_blocking_channels/02_after/01_dealing_after.v)_

### Lesson: Dealing After

V supports lightweight concurrency using **v-routines** via the `spawn` keyword (which spawns a function in a new thread). Threads communicate safely using **channels**, which prevent race conditions. For shared memory concurrency, V provides the `shared` keyword alongside `lock` and `unlock` blocks to safely synchronize access to variables.

These examples cover spawning tasks, reading/writing channels, buffering, select statements, and thread synchronization.

**Additional Context from Repository docs:**
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

---

### Unbuffered Sync Before (sync_before.v)

_File location: [channels/05_working_with_unbuffered_channels/03_synchronizing_data/01_before/01_sync_before.v](file:///Users/codecaine/V-Programming-Comprehensive-Guide/channels/05_working_with_unbuffered_channels/03_synchronizing_data/01_before/01_sync_before.v)_

### Lesson: Unbuffered Sync Before

V supports lightweight concurrency using **v-routines** via the `spawn` keyword (which spawns a function in a new thread). Threads communicate safely using **channels**, which prevent race conditions. For shared memory concurrency, V provides the `shared` keyword alongside `lock` and `unlock` blocks to safely synchronize access to variables.

These examples cover spawning tasks, reading/writing channels, buffering, select statements, and thread synchronization.

**Additional Context from Repository docs:**
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

---

### Unbuffered Sync After (sync_after.v)

_File location: [channels/05_working_with_unbuffered_channels/03_synchronizing_data/02_after/01_sync_after.v](file:///Users/codecaine/V-Programming-Comprehensive-Guide/channels/05_working_with_unbuffered_channels/03_synchronizing_data/02_after/01_sync_after.v)_

### Lesson: Unbuffered Sync After

V supports lightweight concurrency using **v-routines** via the `spawn` keyword (which spawns a function in a new thread). Threads communicate safely using **channels**, which prevent race conditions. For shared memory concurrency, V provides the `shared` keyword alongside `lock` and `unlock` blocks to safely synchronize access to variables.

These examples cover spawning tasks, reading/writing channels, buffering, select statements, and thread synchronization.

**Additional Context from Repository docs:**
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

---

### Understanding Buffered Channel (buffered_channel.v)

_File location: [channels/06_working_with_buffered_channels/01_understanding_buffered_channel/01_buffered_channel.v](file:///Users/codecaine/V-Programming-Comprehensive-Guide/channels/06_working_with_buffered_channels/01_understanding_buffered_channel/01_buffered_channel.v)_

### Lesson: Understanding Buffered Channel

V supports lightweight concurrency using **v-routines** via the `spawn` keyword (which spawns a function in a new thread). Threads communicate safely using **channels**, which prevent race conditions. For shared memory concurrency, V provides the `shared` keyword alongside `lock` and `unlock` blocks to safely synchronize access to variables.

These examples cover spawning tasks, reading/writing channels, buffering, select statements, and thread synchronization.

**Additional Context from Repository docs:**
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

---

### Coroutines Communication

_File location: [channels/06_working_with_buffered_channels/02_establish_communication_between_coroutines/01_coroutines_communication.v](file:///Users/codecaine/V-Programming-Comprehensive-Guide/channels/06_working_with_buffered_channels/02_establish_communication_between_coroutines/01_coroutines_communication.v)_

### Lesson: Coroutines Communication

V supports lightweight concurrency using **v-routines** via the `spawn` keyword (which spawns a function in a new thread). Threads communicate safely using **channels**, which prevent race conditions. For shared memory concurrency, V provides the `shared` keyword alongside `lock` and `unlock` blocks to safely synchronize access to variables.

These examples cover spawning tasks, reading/writing channels, buffering, select statements, and thread synchronization.

**Additional Context from Repository docs:**
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

---

### Buffered Sync Before (sync_before.v)

_File location: [channels/06_working_with_buffered_channels/03_synchronizing_data/01_before/01_sync_before.v](file:///Users/codecaine/V-Programming-Comprehensive-Guide/channels/06_working_with_buffered_channels/03_synchronizing_data/01_before/01_sync_before.v)_

### Lesson: Buffered Sync Before

V supports lightweight concurrency using **v-routines** via the `spawn` keyword (which spawns a function in a new thread). Threads communicate safely using **channels**, which prevent race conditions. For shared memory concurrency, V provides the `shared` keyword alongside `lock` and `unlock` blocks to safely synchronize access to variables.

These examples cover spawning tasks, reading/writing channels, buffering, select statements, and thread synchronization.

**Additional Context from Repository docs:**
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

---

### Buffered Sync After (sync_after.v)

_File location: [channels/06_working_with_buffered_channels/03_synchronizing_data/02_after/01_sync_after.v](file:///Users/codecaine/V-Programming-Comprehensive-Guide/channels/06_working_with_buffered_channels/03_synchronizing_data/02_after/01_sync_after.v)_

### Lesson: Buffered Sync After

V supports lightweight concurrency using **v-routines** via the `spawn` keyword (which spawns a function in a new thread). Threads communicate safely using **channels**, which prevent race conditions. For shared memory concurrency, V provides the `shared` keyword alongside `lock` and `unlock` blocks to safely synchronize access to variables.

These examples cover spawning tasks, reading/writing channels, buffering, select statements, and thread synchronization.

**Additional Context from Repository docs:**
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

---

### Channel Select Before

_File location: [channels/07_channel_select/01_before/01_channel_select_before.v](file:///Users/codecaine/V-Programming-Comprehensive-Guide/channels/07_channel_select/01_before/01_channel_select_before.v)_

### Lesson: Channel Select Before

V supports lightweight concurrency using **v-routines** via the `spawn` keyword (which spawns a function in a new thread). Threads communicate safely using **channels**, which prevent race conditions. For shared memory concurrency, V provides the `shared` keyword alongside `lock` and `unlock` blocks to safely synchronize access to variables.

These examples cover spawning tasks, reading/writing channels, buffering, select statements, and thread synchronization.

**Additional Context from Repository docs:**
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

---

### Channel Select

_File location: [channels/07_channel_select/02_after/01_channel_select.v](file:///Users/codecaine/V-Programming-Comprehensive-Guide/channels/07_channel_select/02_after/01_channel_select.v)_

### Lesson: Channel Select

V supports lightweight concurrency using **v-routines** via the `spawn` keyword (which spawns a function in a new thread). Threads communicate safely using **channels**, which prevent race conditions. For shared memory concurrency, V provides the `shared` keyword alongside `lock` and `unlock` blocks to safely synchronize access to variables.

These examples cover spawning tasks, reading/writing channels, buffering, select statements, and thread synchronization.

**Additional Context from Repository docs:**
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

### Deep Dive Explanation: Advanced Channel Operations & Multiplexing

#### 1. Non-Blocking Senders & Receivers (`try_push` and `try_pop`)

If your program cannot afford to block (e.g., in high-frequency game loops or real-time networking threads), V provides non-blocking channel API methods:

- **`try_push(val)`**: Attempts to send `val` immediately. It returns a `ChanStatus` enum:
  - `.success`: The value was written to the channel's buffer.
  - `.not_ready`: The operation would block (either because the channel is unbuffered with no active reader, or the buffered channel is full).
  - `.closed`: The channel was closed, and writing is invalid.
- **`try_pop(&mut_var)`**: Attempts to read immediately. It takes a reference to a mutable variable where the received value will be stored and returns a `ChanStatus` enum.

#### 2. Channel Multiplexing with `select`

V's `select` statement monitors multiple channel operations simultaneously:

- **Blocking Mode**: The `select` block will halt execution until _at least one_ of the specified channel reads or writes is ready. When a case is ready, its block executes, and control leaves the `select` block.
- **Inactivity Timeouts**: You can declare a timeout block (e.g., `2 * time.second { ... }`). If all other monitored channels remain inactive for that duration, this case triggers. This is highly useful for implementing idle detection or connection timeouts.
- **Non-Blocking Mode (`else`)**: Adding an `else { ... }` block to a `select` statement makes it entirely non-blocking. If no channels are immediately ready, the `else` block executes instantly.

---

## V-Routines & Concurrency

### Stopwatch Demo

_File location: [concurrency/01_time_module_overview/stopwatch_demo.v](file:///Users/codecaine/V-Programming-Comprehensive-Guide/concurrency/01_time_module_overview/stopwatch_demo.v)_

### Lesson: Stopwatch Demo

V supports lightweight concurrency using **v-routines** via the `spawn` keyword (which spawns a function in a new thread). Threads communicate safely using **channels**, which prevent race conditions. For shared memory concurrency, V provides the `shared` keyword alongside `lock` and `unlock` blocks to safely synchronize access to variables.

These examples cover spawning tasks, reading/writing channels, buffering, select statements, and thread synchronization.

**Additional Context from Repository docs:**
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

---

### Spawn Void Function

_File location: [concurrency/02_spawn_void_function/01_check_thread_type/spawn_void_function.v](file:///Users/codecaine/V-Programming-Comprehensive-Guide/concurrency/02_spawn_void_function/01_check_thread_type/spawn_void_function.v)_

### Lesson: Spawn Void Function

V supports lightweight concurrency using **v-routines** via the `spawn` keyword (which spawns a function in a new thread). Threads communicate safely using **channels**, which prevent race conditions. For shared memory concurrency, V provides the `shared` keyword alongside `lock` and `unlock` blocks to safely synchronize access to variables.

These examples cover spawning tasks, reading/writing channels, buffering, select statements, and thread synchronization.

**Additional Context from Repository docs:**
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

---

### Waiting On Concurrent Thread

_File location: [concurrency/02_spawn_void_function/02_waiting_on_concurrent_thread/waiting_on_concurrent_thread.v](file:///Users/codecaine/V-Programming-Comprehensive-Guide/concurrency/02_spawn_void_function/02_waiting_on_concurrent_thread/waiting_on_concurrent_thread.v)_

### Lesson: Waiting On Concurrent Thread

V supports lightweight concurrency using **v-routines** via the `spawn` keyword (which spawns a function in a new thread). Threads communicate safely using **channels**, which prevent race conditions. For shared memory concurrency, V provides the `shared` keyword alongside `lock` and `unlock` blocks to safely synchronize access to variables.

These examples cover spawning tasks, reading/writing channels, buffering, select statements, and thread synchronization.

**Additional Context from Repository docs:**
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

---

### Running Multiple Tasks In Sequence

_File location: [concurrency/03_concurrency_real_life_scenario/01_running_multiple_tasks_in_sequence/01_running_multiple_tasks_in_sequence.v](file:///Users/codecaine/V-Programming-Comprehensive-Guide/concurrency/03_concurrency_real_life_scenario/01_running_multiple_tasks_in_sequence/01_running_multiple_tasks_in_sequence.v)_

### Lesson: Running Multiple Tasks In Sequence

V supports lightweight concurrency using **v-routines** via the `spawn` keyword (which spawns a function in a new thread). Threads communicate safely using **channels**, which prevent race conditions. For shared memory concurrency, V provides the `shared` keyword alongside `lock` and `unlock` blocks to safely synchronize access to variables.

These examples cover spawning tasks, reading/writing channels, buffering, select statements, and thread synchronization.

**Additional Context from Repository docs:**
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

---

### Spawning Multiple Tasks Concurrently

_File location: [concurrency/03_concurrency_real_life_scenario/02_spawning_multiple_tasks_concurrently/01_spawning_multiple_tasks_concurrently.v](file:///Users/codecaine/V-Programming-Comprehensive-Guide/concurrency/03_concurrency_real_life_scenario/02_spawning_multiple_tasks_concurrently/01_spawning_multiple_tasks_concurrently.v)_

### Lesson: Spawning Multiple Tasks Concurrently

V supports lightweight concurrency using **v-routines** via the `spawn` keyword (which spawns a function in a new thread). Threads communicate safely using **channels**, which prevent race conditions. For shared memory concurrency, V provides the `shared` keyword alongside `lock` and `unlock` blocks to safely synchronize access to variables.

These examples cover spawning tasks, reading/writing channels, buffering, select statements, and thread synchronization.

**Additional Context from Repository docs:**
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

---

### Functions With Return Values

_File location: [concurrency/04_implement concurrent programs/01_functions_with_return_values/01_functions_with_return_values.v](file:///Users/codecaine/V-Programming-Comprehensive-Guide/concurrency/04_implement concurrent programs/01_functions_with_return_values/01_functions_with_return_values.v)_

### Lesson: Functions With Return Values

V supports lightweight concurrency using **v-routines** via the `spawn` keyword (which spawns a function in a new thread). Threads communicate safely using **channels**, which prevent race conditions. For shared memory concurrency, V provides the `shared` keyword alongside `lock` and `unlock` blocks to safely synchronize access to variables.

These examples cover spawning tasks, reading/writing channels, buffering, select statements, and thread synchronization.

**Additional Context from Repository docs:**
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

---

### Spawn Anonymous Funcs Without Input Args

_File location: [concurrency/04_implement concurrent programs/02_anonymous_functions/01_spawn_anonymous_funcs_without_input_args/01_spawn_anonymous_funcs_without_input_args.v](file:///Users/codecaine/V-Programming-Comprehensive-Guide/concurrency/04_implement concurrent programs/02_anonymous_functions/01_spawn_anonymous_funcs_without_input_args/01_spawn_anonymous_funcs_without_input_args.v)_

### Lesson: Spawn Anonymous Funcs Without Input Args

V supports lightweight concurrency using **v-routines** via the `spawn` keyword (which spawns a function in a new thread). Threads communicate safely using **channels**, which prevent race conditions. For shared memory concurrency, V provides the `shared` keyword alongside `lock` and `unlock` blocks to safely synchronize access to variables.

These examples cover spawning tasks, reading/writing channels, buffering, select statements, and thread synchronization.

**Additional Context from Repository docs:**
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

---

### Spawn Anonymous Funcs With Input Args

_File location: [concurrency/04_implement concurrent programs/02_anonymous_functions/02_spawn_anonymous_funcs_with_input_args/01_spawn_anonymous_funcs_with_input_args.v](file:///Users/codecaine/V-Programming-Comprehensive-Guide/concurrency/04_implement concurrent programs/02_anonymous_functions/02_spawn_anonymous_funcs_with_input_args/01_spawn_anonymous_funcs_with_input_args.v)_

### Lesson: Spawn Anonymous Funcs With Input Args

V supports lightweight concurrency using **v-routines** via the `spawn` keyword (which spawns a function in a new thread). Threads communicate safely using **channels**, which prevent race conditions. For shared memory concurrency, V provides the `shared` keyword alongside `lock` and `unlock` blocks to safely synchronize access to variables.

These examples cover spawning tasks, reading/writing channels, buffering, select statements, and thread synchronization.

**Additional Context from Repository docs:**
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

---

### Sharing Data Main And Concurrent Tasks

_File location: [concurrency/05_sharing_data_main_and_concurrent_tasks/01_sharing_data_main_and_concurrent_tasks.v](file:///Users/codecaine/V-Programming-Comprehensive-Guide/concurrency/05_sharing_data_main_and_concurrent_tasks/01_sharing_data_main_and_concurrent_tasks.v)_

### Lesson: Sharing Data Main And Concurrent Tasks

In addition to channels, V supports shared-memory concurrency using the `shared` keyword. Multiple threads can safely read and write to the same struct using `lock` (exclusive write lock) and `rlock` (shared read lock) blocks. This prevents race conditions and ensures synchronization without manual mutex management.

**Additional Context from Repository docs:**
This example demonstrates the concepts of **sharing data main and concurrent tasks**.

```v
module main

import rand

// 1. Define a shared struct type.
// Structs that are intended to be shared across multiple threads should be defined normally.
// Mutability of fields is indicated as usual (e.g., total and num_donors under mut:).
struct Fund {
	name   string
	target f32
mut:
	total      f32
	num_donors int
}

// 2. Define a method on a shared receiver.
// In V, a receiver can be marked as 'shared' to indicate that the struct instance
// passed to it will be accessed concurrently.
fn (shared f Fund) collect(amt f32) {
	// 3. Acquire a write lock.
	// The `lock` block ensures exclusive (read-write) access to the shared object 'f'.
	// Only one thread can execute within the lock block at a time. Other threads attempting
	// to lock 'f' will block until this block exits.
	lock f {
		if f.total < f.target {
			f.num_donors += 1
			f.total += amt
			// We can safely read and write to the struct fields inside the lock block.
			println('$f.num_donors \t before: ${f.total - amt} \t funds received: $amt \t total: $f.total')
		}
	}
}

// donation simulates generating a random donation amount.
fn donation() f32 {
	// rand.f32_in_range returns a result/option type, so we use `or` to handle default.
	return rand.f32_in_range(100.00, 250.00) or { 100.00 }
}

fn main() {
	// 4. Declare a shared variable.
	// The `shared` keyword before the variable name makes it a shared object.
	// Under the hood, V automatically associates a mutex with this object.
	shared fund := Fund{
		name: 'A noble cause'
		target: 1000.00
	}

	for {
		// 5. Acquire a read lock (rlock).
		// A read lock allows multiple threads to read the shared object concurrently
		// but prevents any thread from writing to it.
		rlock fund {
			if fund.total >= fund.target {
				break
			}
		}

		// 6. Spawn concurrent tasks.
		// The `go` keyword (interchangeable with `spawn`) starts a function in a new thread.
		// `go donation()` returns a thread handle `h`.
		h := go donation()

		// Spawning `fund.collect` concurrently and passing the result of `h.wait()`.
		// `h.wait()` blocks the main loop until the `donation()` thread finishes and returns its f32 value.
		go fund.collect(h.wait())
	}

	// 7. Final output with read lock.
	rlock fund {
		println('$fund.num_donors donors donated for $fund.name')
		println('$fund.name raised total fund amount: \$ $fund.total')
	}
}
```

### Deep Dive Explanation: V-Routines & Shared Memory Concurrency

#### 1. Coroutines (V-Routines) via `spawn` and `go`

V supports lightweight concurrency using **v-routines**, which are spawned using the `spawn` keyword (the `go` keyword acts as an alias).

- When you call `spawn task()`, V runs the function concurrently.
- V's runtime schedules these v-routines across an OS thread pool, making them highly efficient and lightweight.

#### 2. Thread Handles & Blocking on `.wait()`

Every `spawn` operation returns a thread handle:

- If the function returns a value of type `T`, the handle has the type `thread T`.
- If the function does not return a value (void), the handle is of type `thread`.
- Calling `.wait()` on a thread handle (e.g., `result := handle.wait()`) blocks the calling thread until the spawned routine completes, retrieving its return value.
- You can manage multiple threads by pushing their handles into an array and waiting on all of them at once:
  ```v
  mut threads := []thread int{}
  threads << spawn worker(1)
  threads << spawn worker(2)
  results := threads.wait() // Returns []int containing results from all workers
  ```

#### 3. Shared State Mutexes (`shared`)

For shared-memory concurrency, V does not allow raw, unsynchronized access to global or heap variables across threads. Instead, variables must be explicitly marked as `shared`:

- `shared fund := Fund{...}` instructs the compiler to automatically associate a mutex with the `fund` instance.
- Struct methods can accept a shared receiver (e.g., `fn (shared f Fund) collect(...)`).

#### 4. Safe Synchronization: `lock` and `rlock` Blocks

To prevent data races, V enforces a strict compile-time lock check. You cannot access or modify a `shared` variable's fields directly. You must wrap the access in a lock block:

- **`lock variable { ... }`**: Acquires an exclusive read-write lock. Use this block whenever you mutate fields of the shared structure. Only one thread can hold this lock at a time.
- **`rlock variable { ... }`**: Acquires a shared read-only lock. Multiple threads can enter an `rlock` block concurrently to read fields, but any thread attempting to acquire a `lock` will be blocked until all readers exit.

---

# Chapter 12: Working with Databases and JSON

## Quick Access

Below is an index of all code examples in this chapter. You can use these links to jump directly to any specific code example:

**Case Study: Notes API**

- [Notes API Case Study - Main (main.v)](#notes-api-case-study---main-mainv)
- [Note](#note)
- [Util](#util)

**JSON & ORM**

- [Decode](#decode)
- [Encode](#encode)
- [Json To From File](#json-to-from-file)
- [Json Array Of Objects](#json-array-of-objects)
- [Json Map To From File](#json-map-to-from-file)
- [Json Array To From File](#json-array-to-from-file)
- [Orm Demo](#orm-demo)

**SQLite Integration**

- [Sqlite](#sqlite)

**Sqlite Raw Crud**

- [Sqlite Raw Crud](#sqlite-raw-crud)

---

Most applications need to work with databases or API payloads. This chapter teaches you how to serialize and deserialize JSON data, use V's built-in ORM with SQLite, and covers a complete Notes REST API case study.

## Case Study: Notes API

### Notes API Case Study - Main (main.v)

_File location: [notes_api/notes_api/main.v](file:///Users/codecaine/V-Programming-Comprehensive-Guide/notes_api/notes_api/main.v)_

### Lesson: Notes API Case Study - Main

This is a complete, real-world case study of a REST API built using the V web framework (`veb`). It includes routing, JSON requests/responses, and persistence using SQLite. It is a great example of how all the pieces of V fit together to build a production-grade application.

**Additional Context from Repository docs:**
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

---

### Note

_File location: [notes_api/notes_api/note.v](file:///Users/codecaine/V-Programming-Comprehensive-Guide/notes_api/notes_api/note.v)_

### Lesson: Note

This is a complete, real-world case study of a REST API built using the V web framework (`veb`). It includes routing, JSON requests/responses, and persistence using SQLite. It is a great example of how all the pieces of V fit together to build a production-grade application.

**Additional Context from Repository docs:**
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

---

### Util

_File location: [notes_api/notes_api/util.v](file:///Users/codecaine/V-Programming-Comprehensive-Guide/notes_api/notes_api/util.v)_

### Lesson: Util

This is a complete, real-world case study of a REST API built using the V web framework (`veb`). It includes routing, JSON requests/responses, and persistence using SQLite. It is a great example of how all the pieces of V fit together to build a production-grade application.

**Additional Context from Repository docs:**
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

---

## JSON & ORM

### Decode

_File location: [json_and_orm/01_json/01_decode/decode.v](file:///Users/codecaine/V-Programming-Comprehensive-Guide/json_and_orm/01_json/01_decode/decode.v)_

### Lesson: Decode

Databases and JSON handling are essential parts of backend development. This lesson on **Decode** details V's built-in JSON utilities or its built-in database ORM.

**Additional Context from Repository docs:**
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

---

### Encode

_File location: [json_and_orm/01_json/02_encode/encode.v](file:///Users/codecaine/V-Programming-Comprehensive-Guide/json_and_orm/01_json/02_encode/encode.v)_

### Lesson: Encode

Databases and JSON handling are essential parts of backend development. This lesson on **Encode** details V's built-in JSON utilities or its built-in database ORM.

**Additional Context from Repository docs:**
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

### Deep Dive Explanation: JSON Serialization & Deserialization

#### 1. Compile-Time JSON Parsing

Unlike many languages that rely on slow, runtime reflection to inspect structures, V's compiler generates encoding and decoding code statically at compile time. This ensures extremely fast performance and safety.

#### 2. Decoding JSON (`json.decode`)

- To decode a JSON string, invoke `json.decode(StructName, json_string)`.
- **Result Type Return**: Since incoming JSON strings can be malformed, `json.decode` returns a Result type (`!StructName`). You **must** unwrap it with an `or` block:
  ```v
  user := json.decode(User, raw_json) or {
      println('Failed to parse user JSON: ${err}')
      return
  }
  ```

#### 3. Encoding to JSON (`json.encode`)

- To serialize a V struct instance into a JSON string, invoke `json.encode(instance)`.
- This operation is guaranteed to succeed and returns a standard `string` directly (no `or` block required).

#### 4. Struct JSON Attribute Tags

V provides structural attributes to customize JSON mapping. These are written inside `@[...]` brackets placed on the same line as the field:

- **Custom Naming**: `field string @[json: 'custom_name']` maps the struct field to the `'custom_name'` JSON key.
- **Skip Fields**: `secret string @[json: '-']` prevents the field from being serialized or deserialized.
- **Required Keys**: `id int @[required]` ensures that if the `id` key is missing in the JSON payload, the decoder returns an error.

---

### Json To From File

_File location: [json_and_orm/01_json/03_json_to_from_file/json_to_from_file.v](file:///Users/codecaine/V-Programming-Comprehensive-Guide/json_and_orm/01_json/03_json_to_from_file/json_to_from_file.v)_

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

---

### Json Array Of Objects

_File location: [json_and_orm/01_json/04_json_array_of_objects/json_array_of_objects.v](file:///Users/codecaine/V-Programming-Comprehensive-Guide/json_and_orm/01_json/04_json_array_of_objects/json_array_of_objects.v)_

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

---

### Json Map To From File

_File location: [json_and_orm/01_json/05_json_map_to_from_file/json_map_to_from_file.v](file:///Users/codecaine/V-Programming-Comprehensive-Guide/json_and_orm/01_json/05_json_map_to_from_file/json_map_to_from_file.v)_

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

---

### Json Array To From File

_File location: [json_and_orm/01_json/06_json_array_to_from_file/json_array_to_from_file.v](file:///Users/codecaine/V-Programming-Comprehensive-Guide/json_and_orm/01_json/06_json_array_to_from_file/json_array_to_from_file.v)_

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

---

### Orm Demo

_File location: [json_and_orm/02_orm/orm_demo.v](file:///Users/codecaine/V-Programming-Comprehensive-Guide/json_and_orm/02_orm/orm_demo.v)_

### Lesson: Orm Demo

Databases and JSON handling are essential parts of backend development. This lesson on **Orm Demo** details V's built-in JSON utilities or its built-in database ORM.

**Additional Context from Repository docs:**
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
	// Establishing a connection to the database

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

### Deep Dive Explanation: V's Compile-Safe Database ORM

#### 1. Compile-Time Query Safety

V features a built-in ORM (supporting SQLite, PostgreSQL, and MySQL) that integrates directly with V's type system:

- **The `sql` Block**: All ORM operations are written inside a special `sql db { ... }` block.
- **Type Safety**: The compiler validates table structures, column types, and query logic during compilation. For example, trying to compare a string field to an integer inside the `where` clause will fail to compile.
- **SQL Injection Prevention**: All variables referenced in query clauses (like `where id == id_var`) are automatically treated as query parameters under the hood, making V's ORM immune to SQL injection attacks out of the box.

#### 2. Struct Attributes for ORM Schema Design

You configure your database schema by annotating V structs with attributes:

- **`@[table: 'name']`**: Customizes the table name in the database (defaults to the struct name).
- **`@[primary; sql: serial]`**: Configures the field as an auto-incrementing primary key.
- **`@[sql: 'col_name']`**: Customizes the column name in the database (defaults to the field name).
- **`@[unique]`**: Adds a unique constraint to the column.

#### 3. ORM Operations

- **Create Table**:
  ```v
  sql db { create table Note } or { ... }
  ```
  Generates the SQL DDL statements and creates the table based on the struct fields and attributes.
- **Insert Records**:
  ```v
  sql db { insert n1 into Note } or { ... }
  ```
  Inserts the struct instance into the database. If successful, V updates any auto-incrementing primary keys directly on the passed struct instance.
- **Query Records (`select`)**:
  Queries return a slice of structs (e.g. `[]Note`). Standard SQL clauses are fully supported:
  - `where`: Filter records using standard V boolean operations.
  - `order by`: Sort records (e.g., `order by id desc`).
  - `limit`: Restrict the number of returned records.
  - `offset`: Skip a number of records (used for pagination).
- **Update Records**:
  ```v
  sql db { update Note set status = true where id == 2 } or { ... }
  ```
  Updates the records matching the predicate.
- **Delete Records**:
  ```v
  sql db { delete from Note where id == 2 } or { ... }
  ```
  Deletes the records matching the predicate.

---

## SQLite Integration

### Sqlite

_File location: [sqlite/sqlite.v](file:///Users/codecaine/V-Programming-Comprehensive-Guide/sqlite/sqlite.v)_

### Lesson: Sqlite

Databases and JSON handling are essential parts of backend development. A small SQLite helper module makes your application code cleaner by centralizing connection setup, schema initialization, and CRUD operations in one place.

This example shows a practical pattern you can reuse in small tools, desktop apps, and prototypes:

- connect to a database with a single helper
- enable foreign keys for safer relations
- initialize a table with a reusable setup function
- create, read, update, and delete records with safe parameterized queries
- prevent SQL injection by using `exec_param_many` instead of string interpolation

```v
module sqlite

import db.sqlite as dbsqlite

pub type DB = dbsqlite.DB

pub fn connect(path string) !DB {
	mut db := dbsqlite.connect(path)!
	db.exec('PRAGMA foreign_keys = ON;') or {
		return error('failed to enable foreign keys: ${err}')
	}
	return db
}

pub fn connect_in_memory() !DB {
	return connect(':memory:')
}

pub fn init_notes_table(mut db DB) ! {
	db.exec('CREATE TABLE IF NOT EXISTS notes (id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT NOT NULL, body TEXT NOT NULL);') or {
		return error('failed to create notes table: ${err}')
	}
}

pub fn create_note(mut db DB, title string, body string) !int {
	db.exec_param_many('INSERT INTO notes (title, body) VALUES (?, ?);', [title, body]) or {
		return error('failed to insert note: ${err}')
	}
	return db.last_id()
}

pub fn list_notes(mut db DB) ![]Note {
	rows := db.exec('SELECT id, title, body FROM notes ORDER BY id;') or {
		return error('failed to list notes: ${err}')
	}
	mut notes := []Note{}
	for row in rows {
		notes << Note{
			id: row.vals[0].int()
			title: row.vals[1]
			body: row.vals[2]
		}
	}
	return notes
}

pub fn update_note(mut db DB, id int, title string, body string) ! {
	db.exec_param_many('UPDATE notes SET title = ?, body = ? WHERE id = ?;', [title, body, id.str()]) or {
		return error('failed to update note: ${err}')
	}
}

pub fn delete_note(mut db DB, id int) ! {
	db.exec_param_many('DELETE FROM notes WHERE id = ?;', [id.str()]) or {
		return error('failed to delete note: ${err}')
	}
}
```

> [!TIP]
> **Safe database access:** always pass user input as parameters using `exec_param_many` or `exec` with placeholders like `?`. This prevents SQL injection and keeps your queries readable.

### SQLite CRUD Helper

_File location: [sqlite/sqlite_crud.v](file:///Users/codecaine/V-Programming-Comprehensive-Guide/sqlite/sqlite_crud.v)_

### Lesson: SQLite CRUD Helper

This template demonstrates a complete SQLite database workflow using raw SQL queries. It includes creating tables, clearing data, inserting records with parameterized inputs to prevent SQL injection, and fetching records into structured types.

Key concepts illustrated:

- **Database Connection**: Opening and closing a SQLite database using `sqlite.connect`.
- **Schema Management**: Creating tables dynamically using `db.exec`.
- **Parameterized Queries**: Preventing SQL injection by passing variables inside string arrays using `db.exec_param_many`.
- **Result Mapping**: Manually parsing returned rows into structured V structs.
- **Resource Cleanup**: Appending log files or temporary databases, and deleting them cleanly via `defer` blocks to prevent stray files on disk.

```v
module main

import db.sqlite
import os

struct User {
	id    int
	name  string
	email string
	age   int
}

fn connect_db(path string) !sqlite.DB {
	return sqlite.connect(path)
}

fn init_schema(mut db sqlite.DB) ! {
	db.exec('CREATE TABLE IF NOT EXISTS users (id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT NOT NULL, email TEXT UNIQUE, age INTEGER);') or {
		return error('Could not create table: ${err}')
	}
}

fn reset_users(mut db sqlite.DB) ! {
	db.exec('DELETE FROM users;') or { return error('Could not clear users: ${err}') }
}

fn insert_user(mut db sqlite.DB, name string, email string, age int) !int {
	db.exec_param_many('INSERT INTO users (name, email, age) VALUES (?, ?, ?);', [
		name,
		email,
		age.str(),
	]) or { return error('Insert failed: ${err}') }
	return db.last_id()
}

fn fetch_users(mut db sqlite.DB) ![]User {
	rows := db.exec('SELECT id, name, email, age FROM users ORDER BY id;') or {
		return error('Select failed: ${err}')
	}
	mut users := []User{}
	for row in rows {
		users << User{
			id:    row.vals[0].int()
			name:  row.vals[1]
			email: row.vals[2]
			age:   row.vals[3].int()
		}
	}
	return users
}

// Reusable CRUD helpers for the SQLite boilerplate example.

fn main() {
	println('=== V SQLite CRUD Boilerplate ===')

	db_path := 'demo.db'
	defer {
		if os.exists(db_path) {
			os.rm(db_path) or {}
			println('Cleaned up temporary database: ${db_path}')
		}
	}

	mut db := connect_db(db_path) or {
		eprintln('${err}')
		return
	}
	defer {
		db.close() or { eprint('Failed to close database: ${err}') }
	}

	init_schema(mut db) or {
		eprintln('${err}')
		return
	}

	reset_users(mut db) or {
		eprintln('${err}')
		return
	}

	user_id := insert_user(mut db, 'Ada', 'ada@example.com', 36) or {
		eprintln('${err}')
		return
	}
	println('Inserted user id: ${user_id}')

	users := fetch_users(mut db) or {
		eprintln('${err}')
		return
	}
	for user in users {
		println('User: ${user.id} ${user.name} (${user.email}, age ${user.age})')
	}
}
```

---

## Sqlite Raw Crud

_File location: [json_and_orm/03_sqlite_raw/sqlite_raw_crud.v](file:///Users/codecaine/V-Programming-Comprehensive-Guide/json_and_orm/03_sqlite_raw/sqlite_raw_crud.v)_

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

---

# Chapter 13: Standard Library & Advanced Features

## Quick Access

Below is an index of all code examples in this chapter. You can use these links to jump directly to any specific code example:

**Inline Assembly & C Interop**

- [Inline Assembly](#inline-assembly)
- [C Interop](#c-interop)

**Networking (TCP, UDP, SSL, WebSockets)**

- [Net Urllib](#net-urllib)
- [Net Websocket](#net-websocket)
- [Websocket Persistent](#websocket-persistent)
- [Net Html](#net-html)
- [Net Jsonrpc](#net-jsonrpc)
- [Net Jsonrpc Persistent](#net-jsonrpc-persistent)
- [Net Ssl](#net-ssl)
- [Ssl Persistent](#ssl-persistent)
- [Net Tcp](#net-tcp)
- [Tcp Persistent](#tcp-persistent)
- [Net Udp](#net-udp)
- [Udp Persistent](#udp-persistent)
- [Net Unix](#net-unix)
- [Unix Persistent](#unix-persistent)

**Other Stdlib Updates**

- [Options And Results](#options-and-results)
- [Generics](#generics)
- [Interfaces](#interfaces)
- [Sum Types](#sum-types)
- [Attributes](#attributes)
- [Compile-Time Directives](#compile-time-directives--compile-time-code)
- [Strings Builder](#strings-builder)
- [Os Advanced Io](#os-advanced-io)
- [Os Operations](#os-operations)
- [Os Process Pipe](#os-process-pipe)
- [Os System Info](#os-system-info)
- [Time And Stopwatch](#time-and-stopwatch)
- [Http Client](#http-client)
- [Regex Matching](#regex-matching)
- [Command Line Flags](#command-line-flags)
- [Datatypes Collections](#datatypes-collections)
- [Gg Graphics](#gg-graphics)
- [Command Line Arguments](#command-line-arguments)
- [Math And Rand](#math-and-rand)
- [Crypto Asymmetric](#crypto-asymmetric)
- [Crypto Entropy](#crypto-entropy)
- [Crypto Hash](#crypto-hash)
- [Crypto Kdf](#crypto-kdf)
- [Crypto Mac](#crypto-mac)
- [Crypto Symmetric](#crypto-symmetric)
- [Log And Crypto](#log-and-crypto)
- [Sync Concurrency](#sync-concurrency)
- [Encoding Formats](#encoding-formats)
- [Arrays Utility](#arrays-utility)
- [Toml](#toml)
- [Strconv](#strconv)
- [Term](#term)
- [Benchmark](#benchmark)
- [Clipboard](#clipboard)
- [Semver](#semver)
- [Maps Standard Library Module (maps.v)](#maps-standard-library-module-mapsv)
- [Context](#context)
- [Archive Tar](#archive-tar)
- [Compress Deflate](#compress-deflate)
- [Compress Gzip](#compress-gzip)
- [Compress Szip](#compress-szip)
- [Compress Zlib](#compress-zlib)
- [Compress Zstd](#compress-zstd)
- [Io Fs](#io-fs)
- [Io](#io)
- [Io Util](#io-util)
- [Hash](#hash)
- [Bitfield](#bitfield)
- [Cli](#cli)
- [Veb](#veb)
- [Readline](#readline)
- [Runtime](#runtime)

**Strings.Lorem Helper**

- [Strings Lorem](#strings-lorem)

**WebAssembly Compilation**

- [Compiling V Source to WebAssembly](#compiling-v-source-to-webassembly)
- [Programmatic WASM Generation](#programmatic-wasm-generation)

**Language Updates & Low-Level Features**

- [sizeof and \_\_offsetof](#sizeof-and-__offsetof)
- [Limited Operator Overloading](#limited-operator-overloading)
- [Atomics](#atomics)
- [Static Variables](#static-variables)
- [Hot Code Reloading](#hot-code-reloading)
- [Compile-Time Reflection](#compile-time-reflection)
- [Environment-Specific Files & Compile-Time Types](#environment-specific-files--compile-time-types)

---

This chapter highlights the power of V's standard library and advanced integration features, including low-level socket networking, inline assembly, compilation to WebAssembly, and V's unique memory management models.

## Inline Assembly & C Interop

### Inline Assembly

_File location: [language_updates_and_stdlib/01_language_basics_updates/06_inline_assembly/inline_assembly.v](file:///Users/codecaine/V-Programming-Comprehensive-Guide/language_updates_and_stdlib/01_language_basics_updates/06_inline_assembly/inline_assembly.v)_

V supports inline assembly block definitions using the `asm` keyword, allowing developers to execute architecture-specific instructions directly from V code. It integrates directly with V variables by mapping them to inputs and outputs using register constraints.

This example demonstrates how to:

1. Write inline assembly blocks targeted at specific architectures (e.g. `arm64` and `amd64`).
2. Utilize V's compile-time conditional block `$if` to compile architecture-specific assembly blocks.
3. Map V variables to assembly inputs and outputs using semicolon constraint annotations (e.g. `; +r (res)`).

```v
module main

// add_five adds 5 to the given integer using inline assembly.
// It uses compile-time conditional checks ($if) to select the correct
// assembly instructions depending on the target CPU architecture.
fn add_five(val int) int {
	mut res := val
	$if arm64 {
		// ARM64 inline assembly for Apple Silicon (macOS M-series) and ARM Linux/Android.
		// - Syntax: add destination, operand1, operand2
		// - Constraints: '; +r (res)' specifies that 'res' is both an input and output register.
		asm arm64 {
			add res, res, 5
			; +r (res)
		}
	} $else $if amd64 {
		// AMD64 (x86_64) inline assembly for Intel/AMD processors.
		// - Syntax: add destination, source
		// - Constraints: '; +r (res)' specifies that 'res' is both an input and output register.
		asm amd64 {
			add res, 5
			; +r (res)
		}
	} $else {
		// Fallback for other architectures (e.g. 32-bit x86, RISC-V, WebAssembly, etc.)
		res += 5
	}
	return res
}

// multiply_by_two multiplies the given integer by 2 using bit shifting in inline assembly.
fn multiply_by_two(val int) int {
	mut res := val
	$if arm64 {
		// ARM64 inline assembly using logical shift left (lsl) by 1 bit.
		asm arm64 {
			lsl res, res, 1
			; +r (res)
		}
	} $else $if amd64 {
		// AMD64 inline assembly using shift arithmetic left (sal).
		asm amd64 {
			sal res, 1
			; +r (res)
		}
	} $else {
		res = res << 1
	}
	return res
}

fn main() {
	println('=== V Inline Assembly (asm) Demo ===')

	// Test 1: Addition using inline assembly
	num := 10
	num_plus_five := add_five(num)
	println('Result of add_five(${num}): ${num_plus_five}')
	assert num_plus_five == 15

	// Test 2: Multiplication (bit-shifting) using inline assembly
	val := 21
	val_double := multiply_by_two(val)
	println('Result of multiply_by_two(${val}): ${val_double}')
	assert val_double == 42

	println('All inline assembly assertions successfully verified!')
}
```

---

### C Interop

_File location: [language_updates_and_stdlib/01_language_basics_updates/08_c_interop/c_interop.v](file:///Users/codecaine/V-Programming-Comprehensive-Guide/language_updates_and_stdlib/01_language_basics_updates/08_c_interop/c_interop.v)_

### Lesson: C Interop

V is designed with first-class support for C integration. Since V compiles directly to C, calling C library functions, passing C structs, and compiling legacy C code alongside V is highly performant and requires no heavy wrapper generator.

This example demonstrates how to:

1. Include standard C headers using `#include <header.h>`.
2. Declare C functions using the `fn C.name(args) type` syntax.
3. Map C structures in V using `@[typedef] struct C.name` to represent C typedefs.
4. Interact with C variables, functions, and structs directly from V.

```v
module main

// 1. Include C standard headers.
// V compiles directly to C, so we can use C preprocessor directives like `#include`
// to bring in C standard library definitions or external C headers.
#include <math.h>
#include <stdlib.h>

// 2. Declare C functions.
// We declare C functions using the `fn C.name(args) return_type` syntax.
// The V compiler translates calls to these functions directly to the native C functions.
fn C.abs(x int) int
fn C.sqrt(x f64) f64

// 3. Declare C Structs.
// V can also interact with C structs. We use `struct C.name` to define them.
// The `@[typedef]` attribute tells the V compiler that `div_t` is a typedef structure
// in C (defined in <stdlib.h>) so it does not prefix it with the `struct` keyword in the C output.
@[typedef]
struct C.div_t {
	quot int
	rem  int
}

// Declare C.div function from stdlib.h which returns a C.div_t struct.
fn C.div(numer int, denom int) C.div_t

fn main() {
	println('=== V C Interop Demo ===')

	// 4. Calling C.abs
	negative_val := -42
	absolute_val := C.abs(negative_val)
	println('C.abs(${negative_val}) = ${absolute_val}')
	assert absolute_val == 42

	// 5. Calling C.sqrt
	float_val := 16.0
	square_root := C.sqrt(float_val)
	println('C.sqrt(${float_val}) = ${square_root}')
	assert square_root == 4.0

	// 6. Working with C Structs and functions returning C Structs
	numerator := 10
	denominator := 3
	div_result := C.div(numerator, denominator)
	println('C.div(${numerator}, ${denominator}) -> Quotient: ${div_result.quot}, Remainder: ${div_result.rem}')
	assert div_result.quot == 3
	assert div_result.rem == 1

	println('All C Interop functions successfully executed and verified!')
}
```

---

## Networking (TCP, UDP, SSL, WebSockets)

### Net Urllib

_File location: [language_updates_and_stdlib/02_standard_library/23_net_urllib/net_urllib.v](file:///Users/codecaine/V-Programming-Comprehensive-Guide/language_updates_and_stdlib/02_standard_library/23_net_urllib/net_urllib.v)_

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

---

### Net Websocket

_File location: [language_updates_and_stdlib/02_standard_library/24_net_websocket/net_websocket.v](file:///Users/codecaine/V-Programming-Comprehensive-Guide/language_updates_and_stdlib/02_standard_library/24_net_websocket/net_websocket.v)_

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

---

### Websocket Persistent

_File location: [language_updates_and_stdlib/02_standard_library/24_net_websocket/persistent/websocket_persistent.v](file:///Users/codecaine/V-Programming-Comprehensive-Guide/language_updates_and_stdlib/02_standard_library/24_net_websocket/persistent/websocket_persistent.v)_

This example demonstrates a persistent WebSocket connection with structured JSON message routing, validation of payload size, and connection closure on limit violation.

```v
module main

import net.websocket
import time
import json

// WsMessage represents a structured application-level WebSocket message.
struct WsMessage {
pub:
	action string
	data   string
}

// ClientState maintains state for the WebSocket client across callbacks.
struct ClientState {
mut:
	count int
}

fn main() {
	println('=== Persistent WebSocket Protocol Demo ===')
	port := 38292
	uri := 'ws://localhost:${port}'

	// 1. Initialize and run local WebSocket server
	mut ws_server := websocket.new_server(.ip, port, '/')

	ws_server.on_connect(fn (mut s websocket.ServerClient) !bool {
		println('Server: Client connected from ${s.client_key}')
		return true
	})!

	// Server message handler: validates payload size, decodes JSON, and routes actions.
	ws_server.on_message(fn (mut ws websocket.Client, msg &websocket.Message) ! {
		if msg.opcode == .text_frame {
			payload := msg.payload.bytestr()

			// Safety check: Enforce maximum payload size limit (e.g., 2048 bytes) to prevent DoS (OOM)
			max_allowed_len := 2048
			if payload.len > max_allowed_len {
				println('Server: Rejected message of size ${payload.len} (exceeds ${max_allowed_len} limit)')
				// Close connection with code 1009 (Message Too Big)
				ws.close(1009, 'Message size exceeds limit') or {}
				return
			}

			// Decode the JSON protocol message
			ws_msg := json.decode(WsMessage, payload) or {
				println('Server: Invalid JSON protocol: ${err}')
				err_resp := json.encode(WsMessage{action: 'error', data: 'invalid json'})
				ws.write_string(err_resp) or {}
				return
			}

			println('Server received action "${ws_msg.action}" with data (len: ${ws_msg.data.len})')

			match ws_msg.action {
				'ping' {
					resp := json.encode(WsMessage{action: 'pong', data: ws_msg.data})
					ws.write_string(resp)!
				}
				'goodbye' {
					println('Server received goodbye action. Replying and closing...')
					resp := json.encode(WsMessage{action: 'goodbye_ack', data: 'Goodbye!'})
					ws.write_string(resp)!
					// Clean close from server side
					ws.close(1000, 'done') or {}
				}
				else {
					println('Server: Unknown action: ${ws_msg.action}')
				}
			}
		}
	})

	// Start the server listen loop in a background thread
	spawn fn [mut ws_server] () {
		ws_server.listen() or {
			println('Server error: ${err}')
		}
	}()

	// Allow the server a moment to start
	time.sleep(100 * time.millisecond)

	// 2. RUN CLIENT CONNECTION 1: Clean ping-pong and goodbye handshake
	println('\n--- Connection 1: Standard Chat / Ping-Pong ---')
	mut ws_client1 := websocket.new_client(uri) or {
		println('Client 1 init failed: ${err}')
		return
	}

	mut state1 := &ClientState{
		count: 0
	}

	ws_client1.on_open(fn (mut c websocket.Client) ! {
		println('Client 1: Connection opened!')
		// Initiate the first Ping message
		ping_msg := json.encode(WsMessage{action: 'ping', data: '1'})
		c.write_string(ping_msg)!
	})

	ws_client1.on_message(fn [mut state1] (mut c websocket.Client, msg &websocket.Message) ! {
		if msg.opcode == .text_frame {
			payload := msg.payload.bytestr()
			ws_msg := json.decode(WsMessage, payload) or { return }
			println('Client 1 received response action "${ws_msg.action}" with data: "${ws_msg.data}"')

			if ws_msg.action == 'pong' {
				state1.count++
				if state1.count < 3 {
					next_ping := json.encode(WsMessage{action: 'ping', data: '${state1.count + 1}'})
					println('Client 1 sending: "${next_ping}"')
					c.write_string(next_ping)!
				} else {
					goodbye := json.encode(WsMessage{action: 'goodbye', data: 'Goodbye'})
					println('Client 1 sending goodbye: "${goodbye}"')
					c.write_string(goodbye)!
				}
			} else if ws_msg.action == 'goodbye_ack' {
				println('Client 1 received goodbye ack. Client closing connection.')
				c.close(1000, 'Done') or {}
			}
		}
	})

	ws_client1.on_close(fn (mut c websocket.Client, code int, reason string) ! {
		println('Client 1: Connection closed (code: ${code}, reason: "${reason}")')
	})

	ws_client1.on_error(fn (mut c websocket.Client, error_msg string) ! {
		println('Client 1 error: ${error_msg}')
	})

	ws_client1.connect() or {
		println('Client 1 failed to connect: ${err}')
		return
	}
	spawn ws_client1.listen()

	// Wait for the first flow to complete
	time.sleep(600 * time.millisecond)

	// 3. RUN CLIENT CONNECTION 2: Reject oversized message
	println('\n--- Connection 2: Security Validation (Oversized Message) ---')
	mut ws_client2 := websocket.new_client(uri) or {
		println('Client 2 init failed: ${err}')
		return
	}

	ws_client2.on_open(fn (mut c websocket.Client) ! {
		println('Client 2: Connection opened!')
		// Send oversized data (3000 bytes, exceeding server 2048-byte limit)
		large_payload := 'A'.repeat(3000)
		large_msg := json.encode(WsMessage{action: 'ping', data: large_payload})
		println('Client 2 sending oversized payload (size: ${large_msg.len} bytes)...')
		c.write_string(large_msg)!
	})

	ws_client2.on_close(fn (mut c websocket.Client, code int, reason string) ! {
		println('Client 2: Connection closed (code: ${code}, reason: "${reason}")')
		if code == 1009 {
			println('Client 2: Successfully verified server rejected oversized message with code 1009!')
		} else if code == 1000 {
			// Ignore standard teardown close
		} else {
			println('Client 2: Unexpected close code: ${code}')
		}
	})

	ws_client2.on_error(fn (mut c websocket.Client, error_msg string) ! {
		println('Client 2 error: ${error_msg}')
	})

	ws_client2.connect() or {
		println('Client 2 failed to connect: ${err}')
		return
	}
	spawn ws_client2.listen()

	// Wait for the second flow to finish
	time.sleep(500 * time.millisecond)

	// Clean close of server listener
	println('\nWebSocket Protocol Demo finished.')
}
```

---

### Net Html

_File location: [language_updates_and_stdlib/02_standard_library/25_net/html/net_html.v](file:///Users/codecaine/V-Programming-Comprehensive-Guide/language_updates_and_stdlib/02_standard_library/25_net/html/net_html.v)_

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

---

### Net Jsonrpc

_File location: [language_updates_and_stdlib/02_standard_library/25_net/jsonrpc/net_jsonrpc.v](file:///Users/codecaine/V-Programming-Comprehensive-Guide/language_updates_and_stdlib/02_standard_library/25_net/jsonrpc/net_jsonrpc.v)_

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

---

### Net Jsonrpc Persistent

_File location: [language_updates_and_stdlib/02_standard_library/25_net/jsonrpc_persistent/net_jsonrpc_persistent.v](file:///Users/codecaine/V-Programming-Comprehensive-Guide/language_updates_and_stdlib/02_standard_library/25_net/jsonrpc_persistent/net_jsonrpc_persistent.v)_

This example demonstrates how to build a persistent JSON-RPC 2.0 connection. The server calls `server.start()` to continuously process incoming requests, and the client sends multiple method invocations sequentially over a single socket connection.

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
	params := req.decode_params[MathParams]() or {
		wr.write_error(jsonrpc.invalid_params)
		return
	}

	result := MathResult{
		sum:        params.a + params.b
		difference: params.a - params.b
	}

	wr.write(result)
}

// Start JSON-RPC 2.0 Server over Unix Socket in a persistent loop
fn run_rpc_server(socket_path string) ! {
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

	mut conn := listener.accept() or {
		println('Server: Accept failed: ${err}')
		return err
	}
	defer {
		conn.close() or {}
	}

	println('Server: Client connected, starting persistent JSON-RPC loop.')

	mut router := jsonrpc.Router{}
	router.register('math.compute', handle_math)

	mut server := jsonrpc.new_server(jsonrpc.ServerConfig{
		stream:  conn
		handler: router.handle_jsonrpc
	})

	// Start the server processing loop (calls s.respond() in a loop)
	server.start()
	println('Server: Loop finished.')
}

// Start JSON-RPC 2.0 Client and make multiple requests over the same connection
fn run_rpc_client(socket_path string) ! {
	println('Client: Connecting to server at ${socket_path}...')
	mut conn := unix.connect_stream(socket_path) or {
		println('Client: Connection failed: ${err}')
		return err
	}
	defer {
		conn.close() or {}
	}

	mut client := jsonrpc.new_client(jsonrpc.ClientConfig{
		stream: conn
	})

	// Perform multiple requests over the same persistent connection
	for i in 1 .. 4 {
		params := MathParams{
			a: 10 * i
			b: 5 * i
		}
		req_id := 'req_math_${i}'
		println('Client: Sending request "${req_id}" for math.compute with {a: ${params.a}, b: ${params.b}}')

		resp := client.request('math.compute', params, req_id) or {
			println('Client: Request failed: ${err}')
			return err
		}

		result := resp.decode_result[MathResult]() or {
			println('Client: Failed to decode result: ${err}')
			return err
		}

		println('Client received response for ${resp.id}:')
		println('  sum:        ${result.sum}')
		println('  difference: ${result.difference}')

		time.sleep(50 * time.millisecond)
	}
}

fn main() {
	println('=== Persistent net.jsonrpc Module Demo ===')
	socket_path := os.join_path(os.temp_dir(), 'v_jsonrpc_persistent_socket')

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
	println('Persistent JSON-RPC Demo finished.')
}
```

---

### Net Ssl

_File location: [language_updates_and_stdlib/02_standard_library/25_net/ssl/net_ssl.v](file:///Users/codecaine/V-Programming-Comprehensive-Guide/language_updates_and_stdlib/02_standard_library/25_net/ssl/net_ssl.v)_

This example demonstrates setting up a secure SSL/TLS server and client connection using the standard library's `net.mbedtls` module, including programmatically generating a self-signed key/cert pair using OpenSSL and cleaning them up on exit.

```v
module main

import net.mbedtls
import net
import os
import time

// generate_certs runs openssl to create a temporary self-signed certificate and key.
fn generate_certs() ! {
	println('Generating temporary self-signed SSL certificate...')
	res := os.execute('openssl req -x509 -newkey rsa:2048 -keyout temp_server.key -out temp_server.crt -days 1 -nodes -subj "/CN=localhost"')
	if res.exit_code != 0 {
		return error('Failed to generate certs: ${res.output}')
	}
}

// cleanup_certs deletes the temporary certificate and key files.
fn cleanup_certs() {
	println('Cleaning up temporary certificate files...')
	os.rm('temp_server.key') or {}
	os.rm('temp_server.crt') or {}
}

// run_server starts the SSL server, accepts a client connection,
// reads a message, responds securely, and exits.
fn run_server(port int) ! {
	config := mbedtls.SSLConnectConfig{
		cert: 'temp_server.crt'
		cert_key: 'temp_server.key'
		validate: false
	}

	mut listener := mbedtls.new_ssl_listener('127.0.0.1:${port}', config) or {
		println('Server: Failed to create listener: ${err}')
		return err
	}
	defer {
		listener.shutdown() or {}
	}

	println('Server: Listening on SSL port ${port}...')

	mut conn := listener.accept() or {
		println('Server: Failed to accept SSL connection: ${err}')
		return err
	}
	defer {
		conn.close() or {}
	}

	println('Server: SSL Client connected!')

	mut buf := []u8{len: 1024}
	n := conn.read(mut buf) or {
		println('Server: Read failed: ${err}')
		return err
	}

	message := buf[..n].bytestr()
	println('Server: Received message: "${message}"')

	// Respond securely
	response := 'Echo Secure: ${message}'
	conn.write(response.bytes()) or {
		println('Server: Write failed: ${err}')
		return err
	}
	println('Server: Sent secure response.')
}

// run_client connects to the server port via TCP first, wraps it in SSL,
// sends a message, reads the secure response, and closes.
fn run_client(port int) ! {
	println('Client: Dialing standard TCP port first...')
	mut tcp_conn := net.dial_tcp('127.0.0.1:${port}') or {
		println('Client: Failed to connect standard TCP: ${err}')
		return err
	}

	println('Client: Initiating SSL handshake on top of TCP connection...')
	config := mbedtls.SSLConnectConfig{
		validate: false
	}

	mut ssl_conn := mbedtls.new_ssl_conn(config) or {
		println('Client: Failed to create SSL connection struct: ${err}')
		return err
	}
	defer {
		ssl_conn.close() or {}
	}

	ssl_conn.connect(mut tcp_conn, 'localhost') or {
		println('Client: SSL handshake failed: ${err}')
		return err
	}

	println('Client: Secure connection established!')

	message := 'Hello V Secure Sockets!'
	println('Client: Sending message: "${message}"')
	ssl_conn.write(message.bytes()) or {
		println('Client: Write failed: ${err}')
		return err
	}

	mut buf := []u8{len: 1024}
	n := ssl_conn.read(mut buf) or {
		println('Client: Read failed: ${err}')
		return err
	}

	response := buf[..n].bytestr()
	println('Client: Received response: "${response}"')
}

fn main() {
	println('=== net.ssl Module Demo ===')
	generate_certs() or {
		println('Error generating certs: ${err}')
		return
	}
	defer {
		cleanup_certs()
	}

	port := 38295
	// Spawn server in background
	spawn fn (p int) {
		run_server(p) or {
			println('Server thread failed: ${err}')
		}
	}(port)

	// Wait briefly for server to bind
	time.sleep(200 * time.millisecond)

	// Run client in main thread
	run_client(port) or {
		println('Client failed: ${err}')
	}

	time.sleep(50 * time.millisecond)
	println('SSL Demo finished.')
}
```

---

### Ssl Persistent

_File location: [language_updates_and_stdlib/02_standard_library/25_net/ssl_persistent/ssl_persistent.v](file:///Users/codecaine/V-Programming-Comprehensive-Guide/language_updates_and_stdlib/02_standard_library/25_net/ssl_persistent/ssl_persistent.v)_

This example demonstrates keeping an SSL/TLS connection open for multiple rounds of secure back-and-forth ping-pong communication over `net.mbedtls`.

```v
module main

import net.mbedtls
import net
import os
import time

// generate_certs runs openssl to create a temporary self-signed certificate and key.
fn generate_certs() ! {
	println('Generating temporary self-signed SSL certificate...')
	res := os.execute('openssl req -x509 -newkey rsa:2048 -keyout temp_server.key -out temp_server.crt -days 1 -nodes -subj "/CN=localhost"')
	if res.exit_code != 0 {
		return error('Failed to generate certs: ${res.output}')
	}
}

// cleanup_certs deletes the temporary certificate and key files.
fn cleanup_certs() {
	println('Cleaning up temporary certificate files...')
	os.rm('temp_server.key') or {}
	os.rm('temp_server.crt') or {}
}

// run_server starts the SSL server, accepts a client connection,
// and processes incoming messages in a loop until the client sends "Goodbye".
fn run_server(port int) ! {
	config := mbedtls.SSLConnectConfig{
		cert: 'temp_server.crt'
		cert_key: 'temp_server.key'
		validate: false
	}

	mut listener := mbedtls.new_ssl_listener('127.0.0.1:${port}', config) or {
		println('Server: Failed to create listener: ${err}')
		return err
	}
	defer {
		listener.shutdown() or {}
	}

	println('Server: Listening on SSL port ${port}...')

	mut conn := listener.accept() or {
		println('Server: Failed to accept SSL connection: ${err}')
		return err
	}
	defer {
		conn.close() or {}
	}

	println('Server: SSL Client connected!')

	// Loop to handle back-and-forth messages on the same secure connection
	for {
		mut buf := []u8{len: 1024}
		n := conn.read(mut buf) or {
			println('Server: Secure connection closed or read error: ${err}')
			break
		}
		if n == 0 {
			println('Server: Client disconnected.')
			break
		}

		message := buf[..n].bytestr()
		println('Server received secure: "${message}"')

		if message == 'Goodbye' {
			println('Server received Goodbye. Replying and closing secure connection...')
			conn.write('Goodbye!'.bytes()) or {
				println('Server: Write failed: ${err}')
			}
			break
		}

		response := 'Echo: ${message}'
		println('Server sending secure: "${response}"')
		conn.write(response.bytes()) or {
			println('Server: Write failed: ${err}')
			break
		}
	}
	println('Server finished.')
}

// run_client connects to the server port via TCP first, wraps it in SSL,
// and sends multiple messages in a loop before ending the secure session cleanly.
fn run_client(port int) ! {
	println('Client: Dialing standard TCP port first...')
	mut tcp_conn := net.dial_tcp('127.0.0.1:${port}') or {
		println('Client: Failed to connect standard TCP: ${err}')
		return err
	}

	println('Client: Initiating SSL handshake on top of TCP connection...')
	config := mbedtls.SSLConnectConfig{
		validate: false
	}

	mut ssl_conn := mbedtls.new_ssl_conn(config) or {
		println('Client: Failed to create SSL connection struct: ${err}')
		return err
	}
	defer {
		ssl_conn.close() or {}
	}

	ssl_conn.connect(mut tcp_conn, 'localhost') or {
		println('Client: SSL handshake failed: ${err}')
		return err
	}

	println('Client: Secure connection established!')

	// Exchange multiple messages
	for i in 1 .. 4 {
		message := 'Ping ${i}'
		println('Client sending secure: "${message}"')
		ssl_conn.write(message.bytes()) or {
			println('Client: Write failed: ${err}')
			return err
		}

		// Read response
		mut buf := []u8{len: 1024}
		n := ssl_conn.read(mut buf) or {
			println('Client: Read failed: ${err}')
			return err
		}
		if n == 0 {
			println('Client: Server closed secure connection.')
			return error('Server closed connection unexpectedly')
		}

		response := buf[..n].bytestr()
		println('Client received secure response: "${response}"')

		time.sleep(50 * time.millisecond)
	}

	// Send Goodbye to cleanly terminate the persistent session
	println('Client sending: "Goodbye"')
	ssl_conn.write('Goodbye'.bytes()) or {
		println('Client: Write failed: ${err}')
		return err
	}

	mut buf := []u8{len: 1024}
	n := ssl_conn.read(mut buf) or {
		println('Client: Read failed: ${err}')
		return err
	}
	if n > 0 {
		response := buf[..n].bytestr()
		println('Client received secure response: "${response}"')
	}
	println('Client finished.')
}

fn main() {
	println('=== Persistent SSL Demo ===')
	generate_certs() or {
		println('Error generating certs: ${err}')
		return
	}
	defer {
		cleanup_certs()
	}

	port := 38296
	// Spawn the server in a background thread
	spawn fn (p int) {
		run_server(p) or {
			println('Server thread failed: ${err}')
		}
	}(port)

	// Allow the server thread a short time to start and bind
	time.sleep(200 * time.millisecond)

	// Run the client in the main thread
	run_client(port) or {
		println('Client failed: ${err}')
	}

	// Give the server a small window to finish deferred cleanups
	time.sleep(50 * time.millisecond)
	println('SSL Sockets Demo finished.')
}
```

---

### Net Tcp

_File location: [language_updates_and_stdlib/02_standard_library/25_net/tcp/net_tcp.v](file:///Users/codecaine/V-Programming-Comprehensive-Guide/language_updates_and_stdlib/02_standard_library/25_net/tcp/net_tcp.v)_

This example demonstrates how to create a simple TCP server and client in V. The server listens on a local port, accepts an incoming client connection, receives data, sends a response, and closes the connection.

```v
module main

import net
import time

// run_server starts the TCP server on the specified port, accepts a connection,
// reads a message, responds, and closes the connection.
fn run_server(port int) ! {
	mut listener := net.listen_tcp(.ip, '127.0.0.1:${port}') or {
		println('Server: Failed to listen on port ${port}: ${err}')
		return err
	}
	defer {
		listener.close() or {}
	}

	println('Server: Listening on 127.0.0.1:${port}...')

	mut conn := listener.accept() or {
		println('Server: Failed to accept connection: ${err}')
		return err
	}
	defer {
		conn.close() or {}
	}

	println('Server: Client connected!')

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

// run_client connects to the TCP server, sends a message, reads the response,
// and closes the connection.
fn run_client(port int) ! {
	println('Client: Connecting to 127.0.0.1:${port}...')
	mut conn := net.dial_tcp('127.0.0.1:${port}') or {
		println('Client: Failed to connect: ${err}')
		return err
	}
	defer {
		conn.close() or {}
	}

	println('Client: Connected!')

	// Send message to the server
	message := 'Hello V TCP Sockets!'
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
	println('=== net.tcp Module Demo ===')
	port := 38290

	// Spawn the server in a background thread
	spawn fn (p int) {
		run_server(p) or {
			println('Server thread failed: ${err}')
		}
	}(port)

	// Allow the server thread a short time to start and bind
	time.sleep(100 * time.millisecond)

	// Run the client in the main thread
	run_client(port) or {
		println('Client failed: ${err}')
	}

	// Give the server a small window to finish deferred cleanups
	time.sleep(50 * time.millisecond)
	println('TCP Demo finished.')
}
```

---

### Tcp Persistent

_File location: [language_updates_and_stdlib/02_standard_library/25_net/tcp_persistent/tcp_persistent.v](file:///Users/codecaine/V-Programming-Comprehensive-Guide/language_updates_and_stdlib/02_standard_library/25_net/tcp_persistent/tcp_persistent.v)_

This example demonstrates a persistent length-prefixed TCP connection, processing payloads in chunks, and rejecting messages exceeding safety size boundaries.

```v
module main

import net
import time

const max_message_size = 8192

// write_msg sends a message using a 4-byte magic signature and a 4-byte big-endian length.
fn write_msg(mut conn net.TcpConn, payload string) ! {
	magic := [u8(`M`), `S`, `G`, `0`]
	len := payload.len
	len_bytes := [
		u8((u32(len) >> 24) & 0xff),
		u8((u32(len) >> 16) & 0xff),
		u8((u32(len) >> 8) & 0xff),
		u8(u32(len) & 0xff),
	]
	// Send header (magic signature + message length)
	conn.write(magic) or { return err }
	conn.write(len_bytes) or { return err }
	// Send the actual message payload
	conn.write(payload.bytes()) or { return err }
}

// read_exact reads exactly `size` bytes from the connection, processing data in chunks.
// Real-world performance optimization: Reads directly into mutable slice views of our pre-allocated
// buffer to achieve zero-allocation reads inside the chunking loop.
fn read_exact(mut conn net.TcpConn, size int) ![]u8 {
	mut data := []u8{len: size}
	mut read_bytes := 0
	for read_bytes < size {
		remaining := size - read_bytes
		// Use a small buffer chunk limit (e.g. 512 bytes) to demonstrate reading in chunks
		chunk_limit := if remaining > 512 { 512 } else { remaining }
		n := conn.read(mut data[read_bytes .. read_bytes + chunk_limit]) or { return err }
		if n == 0 {
			return error('unexpected end of stream')
		}
		read_bytes += n
	}
	return data
}

// read_msg reads a single framed message.
fn read_msg(mut conn net.TcpConn, max_size int) !string {
	// Read header: 4 magic bytes + 4 length bytes = 8 bytes
	header_bytes := read_exact(mut conn, 8) or { return err }

	// Validate protocol magic bytes
	if header_bytes[0] != `M` || header_bytes[1] != `S` || header_bytes[2] != `G` || header_bytes[3] != `0` {
		return error('invalid protocol magic bytes')
	}

	// Reconstruct big-endian length
	len := int((u32(header_bytes[4]) << 24) |
	           (u32(header_bytes[5]) << 16) |
	           (u32(header_bytes[6]) << 8) |
	           u32(header_bytes[7]))

	// Real-world security boundary: Reject messages larger than allowed limit to prevent DoS (OOM)
	if len > max_size {
		return error('message size ${len} exceeds limit of ${max_size} bytes')
	}
	if len < 0 {
		return error('invalid negative message length')
	}

	// Read the actual payload
	payload_bytes := read_exact(mut conn, len) or { return err }
	return payload_bytes.bytestr()
}

// run_server starts the TCP server on the specified port, accepts a connection,
// and processes incoming messages in a loop according to our framing protocol.
fn run_server(port int) ! {
	mut listener := net.listen_tcp(.ip, '127.0.0.1:${port}') or {
		println('Server: Failed to listen on port ${port}: ${err}')
		return err
	}
	defer {
		listener.close() or {}
	}

	println('Server: Listening on 127.0.0.1:${port}...')

	mut conn := listener.accept() or {
		println('Server: Failed to accept connection: ${err}')
		return err
	}
	defer {
		conn.close() or {}
	}

	println('Server: Client connected!')

	// Real-world safety practice: Set read and write timeouts to prevent connection hang-ups (Slowloris DoS)
	conn.set_read_timeout(time.second * 5)
	conn.set_write_timeout(time.second * 5)

	for {
		message := read_msg(mut conn, max_message_size) or {
			println('Server: Connection closed or protocol error: ${err}')
			break
		}

		// Preview message content
		preview_len := if message.len > 30 { 30 } else { message.len }
		println('Server received message (len: ${message.len}): "${message[..preview_len]}"...')

		if message == 'Goodbye' {
			println('Server received Goodbye. Replying and closing connection...')
			write_msg(mut conn, 'Goodbye!') or {
				println('Server: Write failed: ${err}')
			}
			break
		}

		response := 'Echo: ${message}'
		write_msg(mut conn, response) or {
			println('Server: Write failed: ${err}')
			break
		}
	}
	println('Server finished.')
}

// run_client connects to the TCP server, sends multiple messages (including
// a large chunked message and an invalid/overflow message), and validates responses.
fn run_client(port int) ! {
	println('Client: Connecting to 127.0.0.1:${port}...')
	mut conn := net.dial_tcp('127.0.0.1:${port}') or {
		println('Client: Failed to connect: ${err}')
		return err
	}
	defer {
		conn.close() or {}
	}

	println('Client: Connected!')

	// Set connection timeouts for the client too
	conn.set_read_timeout(time.second * 5)
	conn.set_write_timeout(time.second * 5)

	// 1. Send a standard small message
	msg1 := 'Ping 1'
	println('Client sending small message: "${msg1}"')
	write_msg(mut conn, msg1)!
	resp1 := read_msg(mut conn, max_message_size)!
	println('Client received response: "${resp1}"')

	time.sleep(50 * time.millisecond)

	// 2. Send a large message within limit (5000 bytes) to trigger chunked read assembly
	msg2 := 'A'.repeat(5000)
	println('Client sending large message of length ${msg2.len}...')
	write_msg(mut conn, msg2)!
	resp2 := read_msg(mut conn, max_message_size)!
	println('Client received response of length ${resp2.len} successfully!')

	time.sleep(50 * time.millisecond)

	// 3. Attempt to send an invalid/overflow message (header length > max_message_size)
	println('Client sending invalid header claiming 100,000 bytes payload...')
	magic := [u8(`M`), `S`, `G`, `0`]
	bad_len_bytes := [u8(0), 1, 134, 160] // 100,000 big-endian
	conn.write(magic)!
	conn.write(bad_len_bytes)!

	// The server must reject the message and terminate the connection
	mut buf := []u8{len: 1}
	n := conn.read(mut buf) or {
		println('Client: Successfully verified server rejected overflow and closed connection: ${err}')
		return
	}
	if n == 0 {
		println('Client: Successfully verified server rejected overflow (EOF received).')
	} else {
		println('Client: Warning - Server did not close connection on overflow!')
	}
}

fn main() {
	println('=== Persistent TCP Protocol Demo ===')
	port := 38293

	// Spawn the server in a background thread
	spawn fn (p int) {
		run_server(p) or {
			println('Server thread failed: ${err}')
		}
	}(port)

	// Allow the server thread a short time to start and bind
	time.sleep(100 * time.millisecond)

	// Run the client in the main thread
	run_client(port) or {
		println('Client failed: ${err}')
	}

	// Give the server a small window to finish deferred cleanups
	time.sleep(50 * time.millisecond)
	println('TCP Protocol Demo finished.')
}
```

### Deep Dive Explanation: Persistent TCP & Custom Protocol Framing

#### 1. Why Message Framing is Essential

TCP is a byte-stream protocol. It does not have any concept of packet or message boundaries; it guarantees only that bytes arrive in order. If a client writes two messages of 100 bytes, the server might read them as a single chunk of 200 bytes, or as several chunks of arbitrary sizes (e.g., 50 and 150 bytes).
To transmit individual messages safely over a persistent connection, we define a custom **Framing Protocol**:

- **Magic Bytes (4 bytes)**: The message starts with a signature (`MSG0` in ASCII). This acts as a sanity check. If the server receives something else, it knows the stream is corrupted or the client is using an incorrect protocol.
- **Length Prefix (4 bytes)**: A big-endian 32-bit integer indicating the exact size of the following payload.
- **Payload**: The actual raw message bytes.

#### 2. Zero-Allocation Chunked Reading (`read_exact`)

The `read_exact(mut conn, size)` function reads bytes in a loop until the full requested size is reached:

```v
n := conn.read(mut data[read_bytes .. read_bytes + chunk_limit])
```

- **Performance Optimization**: Instead of allocating new buffers in each iteration of the loop, V uses slice expressions (`data[start..end]`) to pass a mutable reference to a specific sub-range of the pre-allocated `data` array directly to the socket read function. This avoids any dynamic memory allocation, optimizing throughput and memory usage.

#### 3. Security Boundaries & DoS Protection

Production socket servers must defend against malicious input and network timeouts:

- **Max Payload Checking**: In `read_msg`, the server reads the length prefix from the header. If `len > max_size` (e.g., larger than `8192` bytes), the server immediately rejects the message and closes the connection. Without this check, a client could claim a message size of 2 GB, forcing the server to allocate a huge array and crash due to Out-Of-Memory (OOM).
- **Connection Timeouts**: Calling `conn.set_read_timeout` and `conn.set_write_timeout` prevents threads from blocking indefinitely. If a client connects and then stops sending data (a Slowloris attack), the server will automatically close the socket after the timeout expires (5 seconds in this demo).

---

### Net Udp

_File location: [language_updates_and_stdlib/02_standard_library/25_net/udp/net_udp.v](file:///Users/codecaine/V-Programming-Comprehensive-Guide/language_updates_and_stdlib/02_standard_library/25_net/udp/net_udp.v)_

This example demonstrates sending and receiving connectionless UDP packets. The server binds to a local port and receives a message along with the sender's address, and responds to it using `write_to`.

```v
module main

import net
import time

// run_server starts the UDP server on the specified port, listens for a packet,
// prints the message, sends a response back to the sender, and exits.
fn run_server(port int) ! {
	mut socket := net.listen_udp('127.0.0.1:${port}') or {
		println('Server: Failed to listen on port ${port}: ${err}')
		return err
	}
	defer {
		socket.close() or {}
	}

	println('Server: Listening for UDP packets on port ${port}...')

	mut buf := []u8{len: 1024}
	read, addr := socket.read(mut buf) or {
		println('Server: Read failed: ${err}')
		return err
	}

	message := buf[..read].bytestr()
	println('Server: Received message from ${addr}: "${message}"')

	// Send echo response
	response := 'Echo: ${message}'
	socket.write_to(addr, response.bytes()) or {
		println('Server: Send failed: ${err}')
		return err
	}
	println('Server: Sent echo response.')
}

// run_client creates a UDP client socket, sends a datagram, and waits for a response.
fn run_client(port int) ! {
	mut socket := net.dial_udp('127.0.0.1:${port}') or {
		println('Client: Failed to dial server: ${err}')
		return err
	}
	defer {
		socket.close() or {}
	}

	message := 'Hello V UDP Sockets!'
	println('Client: Sending message: "${message}"')
	socket.write(message.bytes()) or {
		println('Client: Write failed: ${err}')
		return err
	}

	// Read server response
	mut buf := []u8{len: 1024}
	read, addr := socket.read(mut buf) or {
		println('Client: Read failed: ${err}')
		return err
	}

	response := buf[..read].bytestr()
	println('Client: Received response from ${addr}: "${response}"')
}

fn main() {
	println('=== net.udp Module Demo ===')
	port := 38291

	// Spawn the server in a background thread
	spawn fn (p int) {
		run_server(p) or {
			println('Server thread failed: ${err}')
		}
	}(port)

	// Allow the server thread a short time to start and bind
	time.sleep(100 * time.millisecond)

	// Run the client in the main thread
	run_client(port) or {
		println('Client failed: ${err}')
	}

	// Give the server a small window to finish deferred cleanups
	time.sleep(50 * time.millisecond)
	println('UDP Demo finished.')
}
```

---

### Udp Persistent

_File location: [language_updates_and_stdlib/02_standard_library/25_net/udp_persistent/udp_persistent.v](file:///Users/codecaine/V-Programming-Comprehensive-Guide/language_updates_and_stdlib/02_standard_library/25_net/udp_persistent/udp_persistent.v)_

This example demonstrates application-level packet fragmentation, reassembly, and fragment count limit enforcement over UDP.

```v
module main

import net
import time

// UdpReassembler stores state for reassembling fragmented UDP packets.
struct UdpReassembler {
mut:
	fragments map[int][]u8
	total     int
}

// write_udp_msg fragments and sends a message to dialed destination.
fn write_udp_msg(mut socket net.UdpConn, payload string) ! {
	chunk_size := 1024
	payload_bytes := payload.bytes()
	total_frags := (payload_bytes.len + chunk_size - 1) / chunk_size

	if total_frags == 0 {
		header := [u8(`U`), `D`, `P`, `0`, 0, 1, 0, 0]
		socket.write(header) or { return err }
		return
	}

	for i in 0 .. total_frags {
		start := i * chunk_size
		mut end := (i + 1) * chunk_size
		if end > payload_bytes.len {
			end = payload_bytes.len
		}
		frag_payload := payload_bytes[start..end]
		frag_len := frag_payload.len

		header := [
			u8(`U`), `D`, `P`, `0`,
			u8(i),
			u8(total_frags),
			u8((u32(frag_len) >> 8) & 0xff),
			u8(u32(frag_len) & 0xff),
		]

		mut packet := []u8{cap: 8 + frag_len}
		packet << header
		packet << frag_payload

		socket.write(packet) or { return err }
		// Sleep briefly to avoid packet loss during loopback transmission
		time.sleep(2 * time.millisecond)
	}
}

// write_udp_msg_to fragments and sends a message to a specific address using write_to.
fn write_udp_msg_to(mut socket net.UdpConn, addr net.Addr, payload string) ! {
	chunk_size := 1024
	payload_bytes := payload.bytes()
	total_frags := (payload_bytes.len + chunk_size - 1) / chunk_size

	if total_frags == 0 {
		header := [u8(`U`), `D`, `P`, `0`, 0, 1, 0, 0]
		socket.write_to(addr, header) or { return err }
		return
	}

	for i in 0 .. total_frags {
		start := i * chunk_size
		mut end := (i + 1) * chunk_size
		if end > payload_bytes.len {
			end = payload_bytes.len
		}
		frag_payload := payload_bytes[start..end]
		frag_len := frag_payload.len

		header := [
			u8(`U`), `D`, `P`, `0`,
			u8(i),
			u8(total_frags),
			u8((u32(frag_len) >> 8) & 0xff),
			u8(u32(frag_len) & 0xff),
		]

		mut packet := []u8{cap: 8 + frag_len}
		packet << header
		packet << frag_payload

		socket.write_to(addr, packet) or { return err }
		time.sleep(2 * time.millisecond)
	}
}

// read_udp_msg reads packets from a socket and reassembles them into a single string.
fn read_udp_msg(mut socket net.UdpConn, max_allowed_fragments int) !(string, net.Addr) {
	mut fragments := map[int][]u8{}
	mut total_frags := -1
	mut remote_addr := net.Addr{}
	mut buf := []u8{len: 2048}

	for {
		read, addr := socket.read(mut buf) or { return err }
		if read == 0 {
			return error('empty packet read')
		}
		if read < 8 {
			return error('packet too small to contain header')
		}
		if buf[0] != `U` || buf[1] != `D` || buf[2] != `P` || buf[3] != `0` {
			return error('invalid packet magic bytes')
		}

		frag_idx := int(buf[4])
		total := int(buf[5])
		frag_len := int((u32(buf[6]) << 8) | u32(buf[7]))

		if read < 8 + frag_len {
			return error('packet payload length mismatch')
		}

		if total > max_allowed_fragments {
			return error('incoming message total fragments ${total} exceeds limit of ${max_allowed_fragments}')
		}

		if total_frags == -1 {
			total_frags = total
			remote_addr = addr
		}

		fragments[frag_idx] = buf[8 .. 8 + frag_len].clone()

		if fragments.len == total_frags {
			mut full_payload := []u8{}
			for i in 0 .. total_frags {
				if i !in fragments {
					return error('missing fragment ${i} in reassembly')
				}
				full_payload << fragments[i]
			}
			return full_payload.bytestr(), remote_addr
		}
	}
	return error('unexpected read loop termination')
}

// run_server starts the UDP server, processes fragments, reassembles them,
// and echoes back the full message or an error if size is exceeded.
fn run_server(port int) ! {
	mut socket := net.listen_udp('127.0.0.1:${port}') or {
		println('Server: Failed to listen on port ${port}: ${err}')
		return err
	}
	defer {
		socket.close() or {}
	}

	println('Server: Listening for UDP packets on port ${port}...')

	mut reassemblers := map[string]UdpReassembler{}
	mut buf := []u8{len: 2048}

	for {
		read, addr := socket.read(mut buf) or {
			println('Server: Read failed: ${err}')
			break
		}
		if read == 0 {
			break
		}

		if read < 8 {
			println('Server: Received packet too small to contain header')
			continue
		}

		// Verify header magic bytes
		if buf[0] != `U` || buf[1] != `D` || buf[2] != `P` || buf[3] != `0` {
			println('Server: Invalid packet magic bytes')
			continue
		}

		frag_idx := int(buf[4])
		total_frags := int(buf[5])
		frag_len := int((u32(buf[6]) << 8) | u32(buf[7]))

		if read < 8 + frag_len {
			println('Server: Packet payload length mismatch')
			continue
		}

		// Real-world safety limit check: Reject if fragment count exceeds threshold (max 5 fragments = 5KB)
		max_allowed_fragments := 5
		if total_frags > max_allowed_fragments {
			println('Server: Rejected message from ${addr}. Total fragments ${total_frags} exceeds limit of ${max_allowed_fragments}.')
			// Only send one error packet (on the first fragment index) to avoid flooding the client's socket queue
			if frag_idx == 0 {
				write_udp_msg_to(mut socket, addr, 'Error: Message size exceeds limit') or {}
			}
			continue
		}

		addr_str := addr.str()
		if addr_str !in reassemblers {
			reassemblers[addr_str] = UdpReassembler{
				total: total_frags
			}
		}

		mut r := reassemblers[addr_str]
		r.fragments[frag_idx] = buf[8 .. 8 + frag_len].clone()

		if r.fragments.len == r.total {
			mut full_payload := []u8{}
			mut success := true
			for i in 0 .. r.total {
				if i !in r.fragments {
					success = false
					break
				}
				full_payload << r.fragments[i]
			}

			// Clean up reassembler state
			reassemblers.delete(addr_str)

			if success {
				message := full_payload.bytestr()
				preview_len := if message.len > 30 { 30 } else { message.len }
				println('Server received full message from ${addr} (len: ${message.len}): "${message[..preview_len]}"...')

				if message == 'Goodbye' {
					println('Server received Goodbye. Replying and exiting...')
					write_udp_msg_to(mut socket, addr, 'Goodbye!') or {
						println('Server: Write failed: ${err}')
					}
					break
				}

				response := 'Echo: ${message}'
				write_udp_msg_to(mut socket, addr, response) or {
					println('Server: Write failed: ${err}')
					break
				}
			}
		} else {
			reassemblers[addr_str] = r
		}
	}
	println('Server finished.')
}

// run_client connects to the UDP server and runs test cases (small, fragmented, overflow, goodbye).
fn run_client(port int) ! {
	mut socket := net.dial_udp('127.0.0.1:${port}') or {
		println('Client: Failed to dial server: ${err}')
		return err
	}
	defer {
		socket.close() or {}
	}

	println('Client: Bound to server destination.')

	// 1. Send standard small message
	msg1 := 'Ping 1'
	println('Client sending small message: "${msg1}"')
	write_udp_msg(mut socket, msg1)!
	resp1, _ := read_udp_msg(mut socket, 5)!
	println('Client received response: "${resp1}"')

	time.sleep(50 * time.millisecond)

	// 2. Send fragmented message within limit (3000 bytes -> 3 fragments)
	msg2 := 'A'.repeat(3000)
	println('Client sending fragmented message of length ${msg2.len} (3 fragments)...')
	write_udp_msg(mut socket, msg2)!
	resp2, _ := read_udp_msg(mut socket, 5)!
	println('Client received response of length ${resp2.len} successfully!')

	time.sleep(50 * time.millisecond)

	// 3. Attempt to send message exceeding fragments limit (5500 bytes -> 6 fragments)
	msg3 := 'B'.repeat(5500)
	println('Client sending large message of length ${msg3.len} (6 fragments)...')
	write_udp_msg(mut socket, msg3)!
	resp3, _ := read_udp_msg(mut socket, 10)!
	println('Client received response for overflow message: "${resp3}"')

	time.sleep(50 * time.millisecond)

	// 4. Send Goodbye to exit
	println('Client sending: "Goodbye"')
	write_udp_msg(mut socket, 'Goodbye')!
	resp4, _ := read_udp_msg(mut socket, 5)!
	println('Client received response: "${resp4}"')
}

fn main() {
	println('=== Persistent UDP Protocol Demo ===')
	port := 38294

	// Spawn the server in a background thread
	spawn fn (p int) {
		run_server(p) or {
			println('Server thread failed: ${err}')
		}
	}(port)

	// Allow the server thread a short time to start and bind
	time.sleep(100 * time.millisecond)

	// Run the client in the main thread
	run_client(port) or {
		println('Client failed: ${err}')
	}

	// Give the server a small window to finish deferred cleanups
	time.sleep(50 * time.millisecond)
	println('UDP Protocol Demo finished.')
}
```

### Deep Dive Explanation: UDP Packet Fragmentation & Reassembly

#### 1. UDP vs. TCP and the MTU Constraint

Unlike TCP, which handles packet streaming and division transparently, UDP is a datagram-oriented protocol. It sends individual, self-contained packets.

- **Maximum Packet Sizes**: The theoretical maximum size of a UDP packet is 65,535 bytes (including headers), but in practice, any packet larger than the network's **MTU (Maximum Transmission Unit)** (typically 1500 bytes on ethernet/internet routers) will be fragmented at the IP layer.
- **Why IP Fragmentation is Bad**: If _any single_ IP fragment is lost during transmission, the entire UDP packet is discarded. This dramatically increases packet loss rates for large payloads.
- **Solution**: Implement **application-level fragmentation**. By splitting payloads into smaller chunks (e.g. 1024 bytes), we ensure each chunk fits comfortably inside a single MTU window, minimizing packet drops.

#### 2. The Custom UDP Fragmentation Protocol

This example implements application-level fragmentation and reassembly using a custom 8-byte header prefix:

- **Protocol ID (`UDP0`)**: 4 bytes to identify valid application packets.
- **Fragment Index (1 byte)**: The sequence index of the current packet (0-indexed).
- **Total Fragments (1 byte)**: The total number of packets that make up the complete message.
- **Fragment Length (2 bytes)**: The size of the payload following this header (max 1024 bytes).

#### 3. Reassembly Mechanics & State Management

Because UDP does not guarantee packet delivery order, packets can arrive out of sequence.

- **State Tracking**: The server uses a `reassemblers` map, keyed by the client's socket address (`addr.str()`). This maps each client to its own `UdpReassembler` structure containing a map of packet indices to their payload bytes.
- **Sequence Ordering**: Once the number of collected fragments matches `total_frags`, the server iterates from `0` to `total_frags - 1` to assemble the payload in the correct order, bypassing any network out-of-order delivery issues.
- **State Cleanup**: As soon as a message is successfully reassembled, `reassemblers.delete(addr_str)` is called. This frees memory immediately and prevents state leak.

#### 4. Safety & DOS Protections

- **Max Fragment Constraints**: The server enforces `max_allowed_fragments := 5` (equivalent to a maximum total message size of ~5 KB). If a packet arrives claiming a higher fragment count, it is discarded immediately to prevent malicious clients from exhausting server memory by flooding it with un-reassemblable data.

---

### Net Unix

_File location: [language_updates_and_stdlib/02_standard_library/25_net/unix/net_unix.v](file:///Users/codecaine/V-Programming-Comprehensive-Guide/language_updates_and_stdlib/02_standard_library/25_net/unix/net_unix.v)_

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

---

### Unix Persistent

_File location: [language_updates_and_stdlib/02_standard_library/25_net/unix_persistent/unix_persistent.v](file:///Users/codecaine/V-Programming-Comprehensive-Guide/language_updates_and_stdlib/02_standard_library/25_net/unix_persistent/unix_persistent.v)_

This example demonstrates a persistent length-prefixed Unix domain socket connection, processing payloads in chunks, and rejecting messages exceeding safety size boundaries.

```v
module main

import net.unix
import os
import time

const max_message_size = 8192

// write_msg sends a message using a 4-byte magic signature and a 4-byte big-endian length.
fn write_msg(mut conn unix.StreamConn, payload string) ! {
	magic := [u8(`M`), `S`, `G`, `0`]
	len := payload.len
	len_bytes := [
		u8((u32(len) >> 24) & 0xff),
		u8((u32(len) >> 16) & 0xff),
		u8((u32(len) >> 8) & 0xff),
		u8(u32(len) & 0xff),
	]
	// Send header (magic signature + message length)
	conn.write(magic) or { return err }
	conn.write(len_bytes) or { return err }
	// Send the actual message payload
	conn.write(payload.bytes()) or { return err }
}

// read_exact reads exactly `size` bytes from the connection, processing data in chunks.
// Real-world performance optimization: Reads directly into mutable slice views of our pre-allocated
// buffer to achieve zero-allocation reads inside the chunking loop.
fn read_exact(mut conn unix.StreamConn, size int) ![]u8 {
	mut data := []u8{len: size}
	mut read_bytes := 0
	for read_bytes < size {
		remaining := size - read_bytes
		// Use a small buffer chunk limit (e.g. 512 bytes) to demonstrate reading in chunks
		chunk_limit := if remaining > 512 { 512 } else { remaining }
		n := conn.read(mut data[read_bytes .. read_bytes + chunk_limit]) or { return err }
		if n == 0 {
			return error('unexpected end of stream')
		}
		read_bytes += n
	}
	return data
}

// read_msg reads a single framed message.
fn read_msg(mut conn unix.StreamConn, max_size int) !string {
	// Read header: 4 magic bytes + 4 length bytes = 8 bytes
	header_bytes := read_exact(mut conn, 8) or { return err }

	// Validate protocol magic bytes
	if header_bytes[0] != `M` || header_bytes[1] != `S` || header_bytes[2] != `G` || header_bytes[3] != `0` {
		return error('invalid protocol magic bytes')
	}

	// Reconstruct big-endian length
	len := int((u32(header_bytes[4]) << 24) |
	           (u32(header_bytes[5]) << 16) |
	           (u32(header_bytes[6]) << 8) |
	           u32(header_bytes[7]))

	// Real-world security boundary: Reject messages larger than allowed limit to prevent DoS (OOM)
	if len > max_size {
		return error('message size ${len} exceeds limit of ${max_size} bytes')
	}
	if len < 0 {
		return error('invalid negative message length')
	}

	// Read the actual payload
	payload_bytes := read_exact(mut conn, len) or { return err }
	return payload_bytes.bytestr()
}

// run_server starts the Unix socket server, accepts a connection,
// and processes incoming messages in a loop according to our framing protocol.
fn run_server(socket_path string) ! {
	// Clean up any stale socket file from a previous run
	if os.exists(socket_path) {
		os.rm(socket_path)!
	}

	// Listen on the Unix socket path
	mut listener := unix.listen_stream(socket_path, unix.ListenOptions{}) or {
		println('Server: Failed to listen on ${socket_path}: ${err}')
		return err
	}
	defer {
		listener.close() or {}
		listener.unlink() or {}
	}

	println('Server: Listening on socket path: ${socket_path}')

	mut conn := listener.accept() or {
		println('Server: Failed to accept connection: ${err}')
		return err
	}
	defer {
		conn.close() or {}
	}

	println('Server: Client connected!')

	// Real-world safety practice: Set read and write timeouts to prevent connection hang-ups (Slowloris DoS)
	conn.set_read_timeout(time.second * 5)
	conn.set_write_timeout(time.second * 5)

	for {
		message := read_msg(mut conn, max_message_size) or {
			println('Server: Connection closed or protocol error: ${err}')
			break
		}

		// Preview message content
		preview_len := if message.len > 30 { 30 } else { message.len }
		println('Server received message (len: ${message.len}): "${message[..preview_len]}"...')

		if message == 'Goodbye' {
			println('Server received Goodbye. Replying and closing connection...')
			write_msg(mut conn, 'Goodbye!') or {
				println('Server: Write failed: ${err}')
			}
			break
		}

		response := 'Echo: ${message}'
		write_msg(mut conn, response) or {
			println('Server: Write failed: ${err}')
			break
		}
	}
	println('Server finished.')
}

// run_client connects to the Unix socket server, sends multiple messages (including
// a large chunked message and an invalid/overflow message), and validates responses.
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

	// Set connection timeouts for the client too
	conn.set_read_timeout(time.second * 5)
	conn.set_write_timeout(time.second * 5)

	// 1. Send a standard small message
	msg1 := 'Ping 1'
	println('Client sending small message: "${msg1}"')
	write_msg(mut conn, msg1)!
	resp1 := read_msg(mut conn, max_message_size)!
	println('Client received response: "${resp1}"')

	time.sleep(50 * time.millisecond)

	// 2. Send a large message within limit (5000 bytes) to trigger chunked read assembly
	msg2 := 'A'.repeat(5000)
	println('Client sending large message of length ${msg2.len}...')
	write_msg(mut conn, msg2)!
	resp2 := read_msg(mut conn, max_message_size)!
	println('Client received response of length ${resp2.len} successfully!')

	time.sleep(50 * time.millisecond)

	// 3. Attempt to send an invalid/overflow message (header length > max_message_size)
	println('Client sending invalid header claiming 100,000 bytes payload...')
	magic := [u8(`M`), `S`, `G`, `0`]
	bad_len_bytes := [u8(0), 1, 134, 160] // 100,000 big-endian
	conn.write(magic)!
	conn.write(bad_len_bytes)!

	// The server must reject the message and terminate the connection
	mut buf := []u8{len: 1}
	n := conn.read(mut buf) or {
		println('Client: Successfully verified server rejected overflow and closed connection: ${err}')
		return
	}
	if n == 0 {
		println('Client: Successfully verified server rejected overflow (EOF received).')
	} else {
		println('Client: Warning - Server did not close connection on overflow!')
	}
}

fn main() {
	println('=== Persistent Unix Sockets Protocol Demo ===')
	socket_path := os.join_path(os.temp_dir(), 'v_unix_socket_persistent')

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
	println('Unix Sockets Protocol Demo finished.')
}
```

---

## Other Stdlib Updates

This section is grouped into focused subtopics so you can jump quickly to the area you need. The examples here were expanded from the runnable standard-library demos under the repository's language_updates_and_stdlib/02_standard_library folder and verified by running them with V.

### Core Language and Type Features

- [Options And Results](#options-and-results)
- [Generics](#generics)
- [Interfaces](#interfaces)
- [Sum Types](#sum-types)
- [Attributes](#attributes)
- [Compile-Time Directives](#compile-time-directives--compile-time-code)

### Standard Library and OS Modules

- [Strings Builder](#strings-builder)
- [Os Advanced Io](#os-advanced-io)
- [Os Operations](#os-operations)
- [Os Process Pipe](#os-process-pipe)
- [Os System Info](#os-system-info)
- [Time And Stopwatch](#time-and-stopwatch)
- [Http Client](#http-client)
- [Regex Matching](#regex-matching)
- [Command Line Flags](#command-line-flags)
- [Datatypes Collections](#datatypes-collections)
- [Gg Graphics](#gg-graphics)
- [Command Line Arguments](#command-line-arguments)
- [Math And Rand](#math-and-rand)

### Security, Data, and Formats

- [Crypto Asymmetric](#crypto-asymmetric)
- [Crypto Entropy](#crypto-entropy)
- [Crypto Hash](#crypto-hash)
- [Crypto Kdf](#crypto-kdf)
- [Crypto Mac](#crypto-mac)
- [Crypto Symmetric](#crypto-symmetric)
- [Log And Crypto](#log-and-crypto)
- [Encoding Formats](#encoding-formats)
- [Arrays Utility](#arrays-utility)
- [Toml](#toml)
- [Strconv](#strconv)
- [Semver](#semver)
- [Maps Standard Library Module (maps.v)](#maps-standard-library-module-mapsv)
- [Archive Tar](#archive-tar)
- [Compress Deflate](#compress-deflate)
- [Compress Gzip](#compress-gzip)
- [Compress Szip](#compress-szip)
- [Compress Zlib](#compress-zlib)
- [Compress Zstd](#compress-zstd)
- [Hash](#hash)
- [Bitfield](#bitfield)

### Concurrency, CLI, and App Development

- [Sync Concurrency](#sync-concurrency)
- [Cli](#cli)
- [Veb](#veb)
- [Readline](#readline)
- [Runtime](#runtime)

### I/O, Streams, and Terminal

- [Io Fs](#io-fs)
- [Io](#io)
- [Io Util](#io-util)
- [Term](#term)
- [Benchmark](#benchmark)
- [Clipboard](#clipboard)
- [Context](#context)

### Options And Results

_File location: [language_updates_and_stdlib/01_language_basics_updates/01_options_and_results/options_and_results.v](file:///Users/codecaine/V-Programming-Comprehensive-Guide/language_updates_and_stdlib/01_language_basics_updates/01_options_and_results/options_and_results.v)_

### Lesson: Options And Results

V has a very rich and growing standard library and is actively updated. This lesson on **Options And Results** showcases modern standard library packages, system calls, network sockets, inline assembly, or WASM support.

**Additional Context from Repository docs:**
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

---

### Generics

_File location: [language_updates_and_stdlib/01_language_basics_updates/02_generics/generics.v](file:///Users/codecaine/V-Programming-Comprehensive-Guide/language_updates_and_stdlib/01_language_basics_updates/02_generics/generics.v)_

### Lesson: Generics

V has a very rich and growing standard library and is actively updated. This lesson on **Generics** showcases modern standard library packages, system calls, network sockets, inline assembly, or WASM support.

**Additional Context from Repository docs:**
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

---

### Interfaces

_File location: [language_updates_and_stdlib/01_language_basics_updates/03_interfaces/interfaces.v](file:///Users/codecaine/V-Programming-Comprehensive-Guide/language_updates_and_stdlib/01_language_basics_updates/03_interfaces/interfaces.v)_

### Lesson: Interfaces

V has a very rich and growing standard library and is actively updated. This lesson on **Interfaces** showcases modern standard library packages, system calls, network sockets, inline assembly, or WASM support.

**Additional Context from Repository docs:**
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

---

### Sum Types

_File location: [language_updates_and_stdlib/01_language_basics_updates/04_sum_types/sum_types.v](file:///Users/codecaine/V-Programming-Comprehensive-Guide/language_updates_and_stdlib/01_language_basics_updates/04_sum_types/sum_types.v)_

### Lesson: Sum Types

V has a very rich and growing standard library and is actively updated. This lesson on **Sum Types** showcases modern standard library packages, system calls, network sockets, inline assembly, or WASM support.

**Additional Context from Repository docs:**
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

---

### Attributes

_File location: [language_updates_and_stdlib/01_language_basics_updates/05_attributes/attributes.v](file:///Users/codecaine/V-Programming-Comprehensive-Guide/language_updates_and_stdlib/01_language_basics_updates/05_attributes/attributes.v)_

### Lesson: Attributes

V has a very rich and growing standard library and is actively updated. This lesson on **Attributes** showcases modern standard library packages, system calls, network sockets, inline assembly, or WASM support.

**Additional Context from Repository docs:**
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

---

### Compile-Time Directives & Compile-Time Code

_File location: [language_updates_and_stdlib/01_language_basics_updates/07_directives/directives.v](file:///Users/codecaine/V-Programming-Comprehensive-Guide/language_updates_and_stdlib/01_language_basics_updates/07_directives/directives.v)_

### Lesson: Compile-Time Directives & Compile-Time Code

V provides a powerful set of compile-time (or 'comptime') directives and code features, prefixed with `$`. These instructions are evaluated and processed by the compiler during compilation, allowing you to optimize code execution, prune unused branches, dynamically query compilation environment properties, and embed assets directly into the final binary.

#### 1. Conditional Compilation (`$if` Condition)

If you want an `if` expression to be evaluated at compile time, prefix it with `$`. Inactive branches are excluded from compilation entirely, meaning their type checks still occur but no code is generated for them in the final executable.

- **Multiple Conditions:** You can combine multiple platforms or build modes in one branch using logic operators (`||`, `&&`).
- **Expression Usage:** A compile-time `$if` can be used as an expression to conditionally assign values.
- **`$else-$if` Chains:** You can chain compile-time conditions using `$else $if` to check against various compilers, platforms, or custom defines.

##### Builtin `$if` Compilation Target Options

Below is the full list of builtin options supported inside compile-time `$if` conditions:

| OS target                      | Compilers        | Platforms                     | Other                                                    |
| :----------------------------- | :--------------- | :---------------------------- | :------------------------------------------------------- |
| `windows`, `linux`, `macos`    | `gcc`, `tinyc`   | `amd64`, `arm64`, `aarch64`   | `debug`, `prod`, `test`                                  |
| `darwin`, `ios`, `bsd`         | `clang`, `mingw` | `i386`, `arm32`               | `js`, `glibc`, `prealloc`                                |
| `freebsd`, `openbsd`, `netbsd` | `msvc`           | `rv64`, `rv32`, `s390x`       | `no_bounds_checking`, `freestanding`                     |
| `android`, `mach`, `dragonfly` | `cplusplus`      | `ppc64le`                     | `no_segfault_handler`, `no_backtrace`                    |
| `gnu`, `hpux`, `haiku`, `qnx`  |                  | `x64`, `x32`                  | `no_main`, `fast_math`, `apk`, `threads`                 |
| `solaris`, `termux`            |                  | `little_endian`, `big_endian` | `js_node`, `js_browser`, `js_freestanding`               |
| `serenity`, `vinix`, `plan9`   |                  |                               | `interpreter`, `es5`, `profile`, `wasm32`                |
|                                |                  |                               | `wasm32_emscripten`, `wasm32_wasi`, `native`, `autofree` |

#### 2. Compile-Time Flag Defines (`$d`)

V allows retrieving custom flag values defined via the command line with `-d flag=value` or `-d flag` (which defaults to `-d flag=true`).

- To fetch the flag inside your code, use: `$d('flag_name', default_value)`.
- The `default_value` acts as a fallback when the flag is not provided on the command line. It **must** be a pure literal: booleans (`true`/`false`), integers (`0`), floats (`0.0`), strings (`'string'`), or runes (`\`v\``).
- You can also use `$d('flag_name', false)` inside `$if` conditions (e.g. `$if $d('my_flag', false) { ... }`) to selectively enable or disable blocks of code.
- `$d` can also be used in top-level statements like `#flag` and `#include` (e.g., `#flag linux -I $d('my_include', '/usr')/include`).

#### 3. Compile-Time Warnings & Errors

You can generate custom compile-time messages to warn the developer or abort the build:

- `$compile_warn('message')` prints a warning during compilation but allows the build to continue.
- `$compile_error('message')` immediately halts compilation and prints a custom error.
  These are particularly powerful when combined with platform target checks to enforce compatibility (e.g., aborting compilation on unsupported architectures).

#### 4. Environment Variables (`$env`)

`$env('VAR_NAME')` retrieves the value of an environment variable at compilation time and embeds it as a string literal. It can also be used inside top-level `#flag` and `#include` statements.

#### 5. File Asset Embedding (`$embed_file`)

V can embed the raw content of any external file directly inside the compiled binary using `$embed_file('path')`.

- Returns an `EmbedFileData` structure. Use `.to_string()` or `.to_bytes()` to retrieve contents.
- In production builds (`-prod`), `$embed_file` supports optional on-the-fly compression via `.zlib` (e.g. `$embed_file('x.css', .zlib)`).
- For local development ease, compile with `-d embed_only_metadata`. The file won't be embedded, and V will load the file from disk the first time `data()` is called, permitting external live edits without recompiling.

#### 6. Compile-Time Templates (`$tmpl`)

`$tmpl('path/to/template.html')` compiles and parses a simple template file, interpolating any variables (prefixed with `@` in the template) that exist in the calling scope.

---

Here is a comprehensive code example highlighting all compile-time directives and code features in action:

```v
module main

fn main() {
	println('=== V Compile-Time Directives & Code Demo ===')

	// 1. Conditional Compilation ($if) and multiple conditions
	println('\n--- 1. Conditional Compilation (compile-time \$if) ---')
	$if macos {
		println('OS target: macOS')
	}
	$if windows {
		println('OS target: Windows')
	}
	$if linux {
		println('OS target: Linux')
	}

	// Multiple conditions in one branch
	$if ios || android {
		println('Target platform is a mobile device (iOS/Android).')
	} $else $if macos || linux || windows {
		println('Target platform is a desktop OS.')
	}

	$if linux && x64 {
		println('Running specifically on 64-bit Linux.')
	}

	// 2. $if as an expression
	println('\n--- 2. \$if Used as an Expression ---')
	os_family := $if windows { 'Windows' } $else { 'Unix-like' }
	println('OS Family expression: ${os_family}')

	// 3. $else-$if compiler branches
	println('\n--- 3. Compiler Type Detection (\$else-\$if) ---')
	$if tinyc {
		println('Compiled with: TinyC')
	} $else $if clang {
		println('Compiled with: Clang')
	} $else $if gcc {
		println('Compiled with: GCC')
	} $else $if msvc {
		println('Compiled with: MSVC')
	} $else {
		println('Compiled with a different/unspecified compiler')
	}

	// 4. Custom Compile-time Flag defines ($d) with defaults
	println('\n--- 4. Compile-Time Flags (\$d) with Default Values ---')
	// $d brings values defined via compiler flags (-d flag=val or -d flag)
	// Default value must be a pure literal (boolean, int, float, string, or rune)
	custom_str := $d('custom_str', 'Default Text')
	custom_bool := $d('custom_bool', false)
	custom_int := $d('custom_int', 42)
	custom_float := $d('custom_float', 3.14159)
	custom_char := $d('custom_char', `v`)

	println('custom_str: ${custom_str}')
	println('custom_bool: ${custom_bool}')
	println('custom_int: ${custom_int}')
	println('custom_float: ${custom_float}')
	println('custom_char: ${rune(custom_char)}')

	// We can also use $d('ident', false) inside $if condition to conditionally enable/disable code:
	$if $d('enable_feature', false) {
		println('Special feature is ENABLED at compile-time!')
	} $else {
		println('Special feature is DISABLED (default). Compile with `v -d enable_feature run directives.v` to enable.')
	}

	// 5. Compile-time custom errors and warnings
	println('\n--- 5. Compile-Time Errors and Warnings (\$compile_error, \$compile_warn) ---')
	// These only trigger if the enclosing $if branch is active/evaluated at compile time.
	$if $d('trigger_error', false) {
		$compile_error('Explicit compile-time error triggered')
	}
	$if $d('trigger_warn', false) {
		$compile_warn('Explicit compile-time warning triggered')
	}
	println('No compile-time errors/warnings triggered during this compilation run.')

	// 6. $env reads environment values while the program is being compiled.
	println('\n--- 6. Compile-Time Environment (compile-time env) ---')
	compile_path := $env('PATH')
	println('PATH length at compile-time: ${compile_path.len} bytes')

	// 7. $embed_file stores a file's contents inside the compiled binary.
	println('\n--- 7. Asset Embedding (compile-time embed) ---')
	embedded_file := $embed_file('temp_embed.txt')
	content := embedded_file.to_string()
	println('Embedded File Content:')
	println(content)

	// 8. $tmpl renders a template file and injects the current variables.
	println('\n--- 8. Template Interpolation (compile-time template) ---')
	name := 'Developer'
	status := 'active'
	rendered_template := $tmpl('template.html')
	println('Rendered Template Output:')
	println(rendered_template)
}
```

---

### Strings Builder

_File location: [language_updates_and_stdlib/02_standard_library/01_strings_builder/strings_builder.v](file:///Users/codecaine/V-Programming-Comprehensive-Guide/language_updates_and_stdlib/02_standard_library/01_strings_builder/strings_builder.v)_

### Lesson: Strings Builder

V has a very rich and growing standard library and is actively updated. This lesson on **Strings Builder** showcases modern standard library packages, system calls, network sockets, inline assembly, or WASM support.

**Additional Context from Repository docs:**
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

---

### Os Advanced Io

_File location: [language_updates_and_stdlib/02_standard_library/02_os_operations/advanced_io/os_advanced_io.v](file:///Users/codecaine/V-Programming-Comprehensive-Guide/language_updates_and_stdlib/02_standard_library/02_os_operations/advanced_io/os_advanced_io.v)_

This example demonstrates advanced Unix file behaviors such as raw struct binary serialization, cursor seeking (`seek`/`tell`), file size truncation, and recursive directory tree traversal.

---

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

### Os Operations

_File location: [language_updates_and_stdlib/02_standard_library/02_os_operations/basic/os_operations.v](file:///Users/codecaine/V-Programming-Comprehensive-Guide/language_updates_and_stdlib/02_standard_library/02_os_operations/basic/os_operations.v)_

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

---

### Os Process Pipe

_File location: [language_updates_and_stdlib/02_standard_library/02_os_operations/process/os_process_pipe.v](file:///Users/codecaine/V-Programming-Comprehensive-Guide/language_updates_and_stdlib/02_standard_library/02_os_operations/process/os_process_pipe.v)_

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

---

### Os System Info

_File location: [language_updates_and_stdlib/02_standard_library/02_os_operations/system_info/os_system_info.v](file:///Users/codecaine/V-Programming-Comprehensive-Guide/language_updates_and_stdlib/02_standard_library/02_os_operations/system_info/os_system_info.v)_

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

---

### Time And Stopwatch

_File location: [language_updates_and_stdlib/02_standard_library/03_time_and_stopwatch/time_and_stopwatch.v](file:///Users/codecaine/V-Programming-Comprehensive-Guide/language_updates_and_stdlib/02_standard_library/03_time_and_stopwatch/time_and_stopwatch.v)_

### Lesson: Time And Stopwatch

V has a very rich and growing standard library and is actively updated. This lesson on **Time And Stopwatch** showcases modern standard library packages, system calls, network sockets, inline assembly, or WASM support.

**Additional Context from Repository docs:**
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

---

### Http Client

_File location: [language_updates_and_stdlib/02_standard_library/04_http_client/http_client.v](file:///Users/codecaine/V-Programming-Comprehensive-Guide/language_updates_and_stdlib/02_standard_library/04_http_client/http_client.v)_

### Lesson: Http Client

V has a very rich and growing standard library and is actively updated. This lesson on **Http Client** showcases modern standard library packages, system calls, network sockets, inline assembly, or WASM support.

**Additional Context from Repository docs:**
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
		println('POST request failed: ${err}')
		return
	}
	println('POST Status Code: ${post_resp.status_code}')
	println('POST Response Body:')
	println(post_resp.body)
}
```

---

### Regex Matching

_File location: [language_updates_and_stdlib/02_standard_library/05_regex_matching/regex_matching.v](file:///Users/codecaine/V-Programming-Comprehensive-Guide/language_updates_and_stdlib/02_standard_library/05_regex_matching/regex_matching.v)_

### Lesson: Regex Matching

V has a very rich and growing standard library and is actively updated. This lesson on **Regex Matching** showcases modern standard library packages, system calls, network sockets, inline assembly, or WASM support.

**Additional Context from Repository docs:**
This example demonstrates the concepts of **regex matching**.

```v
module main

import regex

fn replace_callback(re regex.RE, in_txt string, start int, end int) string {
	return '[${start}-${end}]'
}

fn main() {
	text := 'We have 15 apples, 32 bananas, and 120 oranges.'

	mut re := regex.regex_opt(r'\d+') or {
		println('Failed to compile regex: ${err}')
		return
	}
	mut re_from_new := regex.new()
	re_from_new.compile_opt(r'\w+') or {
		println('compile_opt() failed: ${err}')
		return
	}
	base_re, base_code, base_err := regex.regex_base(r'\d+')
	println('regex_base(): ${base_code}, ${base_err}')
	println('regex_base query: ${base_re.get_query()}')

	println('=== regex module demo ===')
	println('query: ${re.get_query()}')

	start, end := re.find(text)
	if start >= 0 {
		matched := text[start..end]
		println('find(): "${matched}" at (${start}, ${end})')
	} else {
		println('find(): no match')
	}

	println('find_from(): ${re.find_from(text, 10)}')
	println('find_all(): ${re.find_all(text)}')
	println('find_all_str(): ${re.find_all_str(text)}')
	println('match_string(): ${re.match_string(text)}')
	println('matches_string(): ${re.matches_string(text)}')
	println('replace(): ${re.replace(text, "NUM")}')
	println('replace_n(): ${re.replace_n(text, "NUM", 2)}')
	println('replace_simple(): ${re.replace_simple(text, "NUM")}')
	println('replace_by_fn(): ${re.replace_by_fn(text, replace_callback)}')
	println('split(): ${re.split(text)}')
	println('get_group_list(): ${re.get_group_list()}')
	println('get_code(): ${re.get_code()}')
	println('get_group_by_id(): ${re.get_group_by_id(text, 0)}')
	println('get_group_by_name(): ${re.get_group_by_name(text, "")}')
	println('get_group_bounds_by_id(): ${re.get_group_bounds_by_id(0)}')
	println('get_group_bounds_by_name(): ${re.get_group_bounds_by_name("")}')
	println('match_base(): ${unsafe { re.match_base(text.str, text.len) }}')
	re.reset()
	println('reset() query: ${re.get_query()}')
	println('new() compile_opt query: ${re_from_new.get_query()}')
}
```

---

### Command Line Flags

_File location: [language_updates_and_stdlib/02_standard_library/06_command_line_flags/command_line_flags.v](file:///Users/codecaine/V-Programming-Comprehensive-Guide/language_updates_and_stdlib/02_standard_library/06_command_line_flags/command_line_flags.v)_

### Lesson: Command Line Flags

V has a very rich and growing standard library and is actively updated. This lesson on **Command Line Flags** showcases modern standard library packages, system calls, network sockets, inline assembly, or WASM support.

**Additional Context from Repository docs:**
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

---

### Datatypes Collections

_File location: [language_updates_and_stdlib/02_standard_library/07_datatypes_collections/datatypes_collections.v](file:///Users/codecaine/V-Programming-Comprehensive-Guide/language_updates_and_stdlib/02_standard_library/07_datatypes_collections/datatypes_collections.v)_

### Lesson: Datatypes Collections

V has a very rich and growing standard library and is actively updated. This lesson on **Datatypes Collections** showcases modern standard library packages, system calls, network sockets, inline assembly, or WASM support.

**Additional Context from Repository docs:**
This example demonstrates the concepts of **datatypes collections**.

```v
module main

import datatypes

fn hash_string(value string) u32 {
	mut hash := u32(2166136261)
	for ch in value {
		hash ^= u32(ch)
		hash *= 16777619
	}
	return hash
}

fn main() {
	println('=== datatypes collection demo ===')

	println('\n--- BloomFilter ---')
	mut bloom := datatypes.new_bloom_filter[string](hash_string, 64, 3) or { panic(err) }
	bloom.add('apple')
	bloom.add('banana')
	println('bloom exists apple: ${bloom.exists('apple')}')
	println('bloom exists cherry: ${bloom.exists('cherry')}')

	mut bloom_fast := datatypes.new_bloom_filter[string](hash_string, 64, 3) or { panic(err) }
	bloom_fast.add('date')
	println('fast bloom exists date: ${bloom_fast.exists('date')}')

	union_bloom := bloom.@union(bloom_fast) or { panic(err) }
	println('union bloom exists banana: ${union_bloom.exists('banana')}')
	intersection_bloom := bloom.intersection(bloom_fast) or { panic(err) }
	println('intersection bloom exists apple: ${intersection_bloom.exists('apple')}')

	println('\n--- BSTree ---')
	mut bst := datatypes.BSTree[int]{}
	println('empty before inserts: ${bst.is_empty()}')
	bst.insert(10)
	bst.insert(5)
	bst.insert(15)
	bst.insert(12)
	println('contains 12: ${bst.contains(12)}')
	println('in_order: ${bst.in_order_traversal()}')
	println('pre_order: ${bst.pre_order_traversal()}')
	println('post_order: ${bst.post_order_traversal()}')
	println('left of 10: ${bst.to_left(10) or { -1 }}')
	println('right of 10: ${bst.to_right(10) or { -1 }}')
	println('min: ${bst.min() or { -1 }}')
	println('max: ${bst.max() or { -1 }}')
	bst.remove(5)
	println('contains 5 after remove: ${bst.contains(5)}')

	println('\n--- DoublyLinkedList ---')
	mut dll := datatypes.DoublyLinkedList[string]{}
	dll.push_back('one')
	dll.push_front('zero')
	dll.push_many(['two', 'three'], datatypes.Direction.back)
	println('dll array: ${dll.array()}')
	println('dll first: ${dll.first() or { 'none' }}')
	println('dll last: ${dll.last() or { 'none' }}')
	println('dll index of two: ${dll.index('two') or { -1 }}')
	dll.insert(2, 'inserted')
	println('dll after insert: ${dll.array()}')
	dll.delete(1)
	println('dll after delete: ${dll.array()}')
	println('dll str: ${dll.str()}')
	println('dll next: ${dll.next() or { 'none' }}')
	mut dll_iter := dll.iterator()
	for {
		if value := dll_iter.next() {
			println('dll iter: ${value}')
		} else {
			break
		}
	}
	mut dll_back_iter := dll.back_iterator()
	for {
		if value := dll_back_iter.next() {
			println('dll back iter: ${value}')
		} else {
			break
		}
	}
	println('dll pop_front: ${dll.pop_front() or { 'none' }}')
	println('dll pop_back: ${dll.pop_back() or { 'none' }}')
	println('dll final: ${dll.array()}')

	println('\n--- LinkedList ---')
	mut linked_list := datatypes.LinkedList[int]{}
	println('linked list empty: ${linked_list.is_empty()}')
	linked_list.push(1)
	linked_list.push(2)
	linked_list.push_many([3, 4])
	linked_list.prepend(0)
	linked_list.insert(2, 5)
	println('linked list array: ${linked_list.array()}')
	println('linked list first: ${linked_list.first() or { -1 }}')
	println('linked list last: ${linked_list.last() or { -1 }}')
	println('linked list index 3: ${linked_list.index(3) or { -1 }}')
	println('linked list str: ${linked_list.str()}')
	println('linked list pop: ${linked_list.pop() or { -1 }}')
	println('linked list shift: ${linked_list.shift() or { -1 }}')
	println('linked list next: ${linked_list.next() or { -1 }}')
	mut list_iter := linked_list.iterator()
	for {
		if value := list_iter.next() {
			println('linked list iter: ${value}')
		} else {
			break
		}
	}
	println('linked list len: ${linked_list.len()}')

	println('\n--- MinHeap ---')
	mut heap := datatypes.MinHeap[int]{}
	heap.insert(8)
	heap.insert(3)
	heap.insert_many([5, 1, 7])
	println('heap len: ${heap.len()}')
	println('heap peek: ${heap.peek() or { -1 }}')
	println('heap pop: ${heap.pop() or { -1 }}')
	println('heap pop: ${heap.pop() or { -1 }}')

	println('\n--- Queue ---')
	mut queue := datatypes.Queue[int]{}
	println('queue empty: ${queue.is_empty()}')
	queue.push(100)
	queue.push(200)
	queue.push(300)
	println('queue len: ${queue.len()}')
	println('queue array: ${queue.array()}')
	println('queue peek: ${queue.peek() or { -1 }}')
	println('queue last: ${queue.last() or { -1 }}')
	println('queue index 2: ${queue.index(2) or { -1 }}')
	println('queue str: ${queue.str()}')
	println('queue pop: ${queue.pop() or { -1 }}')
	println('queue pop: ${queue.pop() or { -1 }}')

	println('\n--- RingBuffer ---')
	mut rb := datatypes.new_ringbuffer[string](3)
	println('rb empty: ${rb.is_empty()}')
	rb.push('first') or { panic(err) }
	rb.push('second') or { panic(err) }
	rb.push_many(['third', 'fourth']) or { panic(err) }
	println('rb occupied: ${rb.occupied()}')
	println('rb remaining: ${rb.remaining()}')
	println('rb pop: ${rb.pop() or { 'empty' }}')
	println('rb pop_many: ${rb.pop_many(2) or { []string{} }}')
	println('rb full: ${rb.is_full()}')
	rb.clear()
	println('rb after clear: ${rb.is_empty()}')

	println('\n--- Set ---')
	mut set_a := datatypes.Set[string]{}
	set_a.add_all(['apple', 'banana', 'cherry', 'apple'])
	println('set_a: ${set_a.array()}')
	println('set_a size: ${set_a.size()}')
	println('contains banana: ${set_a.exists('banana')}')
	set_a.remove('banana')
	println('after remove: ${set_a.array()}')
	println('pick: ${set_a.pick() or { 'empty' }}')
	println('rest: ${set_a.rest() or { []string{} }}')
	println('pop: ${set_a.pop() or { 'empty' }}')
	println('is_empty: ${set_a.is_empty()}')
	set_a.clear()
	println('cleared: ${set_a.is_empty()}')

	mut set_b := datatypes.Set[string]{}
	set_b.add_all(['apple', 'cherry'])
	mut set_c := datatypes.Set[string]{}
	set_c.add_all(['cherry', 'date'])
	println('union: ${set_b.@union(set_c).array()}')
	println('intersection: ${set_b.intersection(set_c).array()}')
	println('difference: ${(set_b - set_c).array()}')
	println('subset: ${set_b.subset(set_c)}')
	println('copy: ${set_b.copy().array()}')

	println('\n--- Stack ---')
	mut stack := datatypes.Stack[string]{}
	println('stack empty: ${stack.is_empty()}')
	stack.push('first')
	stack.push('second')
	stack.push('third')
	println('stack len: ${stack.len()}')
	println('stack contents: ${stack.array()}')
	println('stack peek: ${stack.peek() or { 'empty' }}')
	println('stack str: ${stack.str()}')
	println('stack pop: ${stack.pop() or { 'empty' }}')
	println('stack pop: ${stack.pop() or { 'empty' }}')
}
```

---

### Gg Graphics

_File location: [language_updates_and_stdlib/02_standard_library/08_gg_graphics/gg_graphics.v](file:///Users/codecaine/V-Programming-Comprehensive-Guide/language_updates_and_stdlib/02_standard_library/08_gg_graphics/gg_graphics.v)_

### Lesson: Gg Graphics

V has a very rich and growing standard library and is actively updated. This lesson on **Gg Graphics** showcases modern standard library packages, system calls, network sockets, inline assembly, or WASM support.

**Additional Context from Repository docs:**
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

---

### Command Line Arguments

_File location: [language_updates_and_stdlib/02_standard_library/09_command_line_arguments/command_line_arguments.v](file:///Users/codecaine/V-Programming-Comprehensive-Guide/language_updates_and_stdlib/02_standard_library/09_command_line_arguments/command_line_arguments.v)_

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

---

### Math And Rand

_File location: [language_updates_and_stdlib/02_standard_library/10_math_and_rand/math_and_rand.v](file:///Users/codecaine/V-Programming-Comprehensive-Guide/language_updates_and_stdlib/02_standard_library/10_math_and_rand/math_and_rand.v)_

### Lesson: Math And Rand

V's math and rand modules expose far more than the basic trigonometry and random-int helpers. The example below expands the repository walkthrough with additional documented functions from the current V docs, including exponentiation, clamping, logarithms, bytes, hex strings, ULIDs, and ranged integer generation.

```v
module main

import math
import rand

fn main() {
	println('=== Math & Rand Module Examples ===')

	println('\n--- math ---')
	println('Pi constant: ${math.pi}')
	println('E constant:  ${math.e}')

	angle := 45.0 * (math.pi / 180.0)
	println('sin(45 deg): ${math.sin(angle):.4f}')
	println('cos(45 deg): ${math.cos(angle):.4f}')
	println('tan(45 deg): ${math.tan(angle):.4f}')

	println('2^10:        ${math.pow(2.0, 10.0)}')
	println('sqrt(144):   ${math.sqrt(144.0)}')
	println('ln(e):       ${math.log(math.e)}')
	println('log10(100):  ${math.log10(100.0)}')

	println('abs(-5.5):   ${math.abs(-5.5)}')
	println('max(10, 20): ${math.max(10.0, 20.0)}')
	println('min(10, 20): ${math.min(10.0, 20.0)}')
	println('ceil(4.2):   ${math.ceil(4.2)}')
	println('floor(4.8):  ${math.floor(4.8)}')
	println('round(4.5):  ${math.round(4.5)}')
	println('cbrt(27):    ${math.cbrt(27.0):.2f}')
	println('clamp(12, 0, 10): ${math.clamp(12.0, 0.0, 10.0)}')
	println('exp(1):      ${math.exp(1.0):.4f}')
	println('exp2(3):     ${math.exp2(3.0):.4f}')
	println('hypot(3, 4): ${math.hypot(3.0, 4.0):.4f}')
	println('log2(8):     ${math.log2(8.0):.4f}')
	println('trunc(4.9):  ${math.trunc(4.9)}')

	println('\n--- rand ---')
	random_int := rand.int_in_range(1, 100) or { 0 }
	println('Random integer in [1, 100): ${random_int}')

	random_f64 := rand.f64()
	println('Random f64 in [0.0, 1.0):   ${random_f64:.4f}')

	random_bool := (rand.intn(2) or { 0 }) == 0
	println('Random boolean:             ${random_bool}')

	items := ['Apple', 'Banana', 'Cherry', 'Date']
	chosen := rand.element(items) or { 'None' }
	println('Randomly chosen fruit:      ${chosen}')

	random_bytes := rand.bytes(4) or { []u8{} }
	println('Random bytes:               ${random_bytes}')

	random_hex := rand.hex(8)
	println('Random hex string:          ${random_hex}')

	random_string := rand.string(8)
	println('Random ascii string:        ${random_string}')

	random_ulid := rand.ulid()
	println('Random ULID:                ${random_ulid}')

	random_i64 := rand.i64_in_range(i64(-10), i64(10)) or { 0 }
	println('Random i64 in [-10, 10]:    ${random_i64}')

	mut uuid_str := rand.uuid_v4()
	println('Random UUID v4:             ${uuid_str}')
	uuid_str = rand.uuid_v7()
	println('Random UUID v7:             ${uuid_str}')
}
```

---

### Crypto Asymmetric

_File location: [language_updates_and_stdlib/02_standard_library/11_log_and_crypto/crypto/asymmetric/crypto_asymmetric.v](file:///Users/codecaine/V-Programming-Comprehensive-Guide/language_updates_and_stdlib/02_standard_library/11_log_and_crypto/crypto/asymmetric/crypto_asymmetric.v)_

### Lesson: Crypto Asymmetric

V has a very rich and growing standard library and is actively updated. This lesson on **Crypto Asymmetric** showcases modern standard library packages, system calls, network sockets, inline assembly, or WASM support.

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

---

### Crypto Entropy

_File location: [language_updates_and_stdlib/02_standard_library/11_log_and_crypto/crypto/entropy/crypto_entropy.v](file:///Users/codecaine/V-Programming-Comprehensive-Guide/language_updates_and_stdlib/02_standard_library/11_log_and_crypto/crypto/entropy/crypto_entropy.v)_

### Lesson: Crypto Entropy

V has a very rich and growing standard library and is actively updated. This lesson on **Crypto Entropy** showcases modern standard library packages, system calls, network sockets, inline assembly, or WASM support.

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

---

### Crypto Hash

_File location: [language_updates_and_stdlib/02_standard_library/11_log_and_crypto/crypto/hash/crypto_hash.v](file:///Users/codecaine/V-Programming-Comprehensive-Guide/language_updates_and_stdlib/02_standard_library/11_log_and_crypto/crypto/hash/crypto_hash.v)_

For a detailed demonstration of every cryptographic module, the standard library examples are structured into subdirectories under `language_updates_and_stdlib/02_standard_library/11_log_and_crypto/crypto/`.

###### 1. Cryptographic Hash Functions

Demonstrates MD5, SHA-1, SHA-256, SHA-512, SHA-3 (Keccak-256/Keccak-512), RIPEMD-160, BLAKE2b, BLAKE2s, and BLAKE3.

###### 2. Symmetric Ciphers & Block Modes

Demonstrates AES (CBC block mode with PKCS7-like padding), DES, Blowfish (encryption-only), RC4 stream cipher, and general block modes.

###### 3. Asymmetric Cryptography & PEM Formats

Demonstrates ECDSA key generation, signing, and verification; Ed25519 signing and verification; and PEM block encoding/decoding.

###### 4. Key Derivation Functions (KDF)

Demonstrates secure password hashing and key derivation using Bcrypt, Scrypt, and PBKDF2.

###### 5. Message Authentication Codes (MAC)

Demonstrates message integrity and authenticity verification using HMAC-SHA256.

###### 6. Secure Randomness & Entropy

Demonstrates generating secure cryptographically random bytes, `u64` values, and large integers (`big.Integer`).

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

---

### Crypto Kdf

_File location: [language_updates_and_stdlib/02_standard_library/11_log_and_crypto/crypto/kdf/crypto_kdf.v](file:///Users/codecaine/V-Programming-Comprehensive-Guide/language_updates_and_stdlib/02_standard_library/11_log_and_crypto/crypto/kdf/crypto_kdf.v)_

### Lesson: Crypto Kdf

V has a very rich and growing standard library and is actively updated. This lesson on **Crypto Kdf** showcases modern standard library packages, system calls, network sockets, inline assembly, or WASM support.

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

---

### Crypto Mac

_File location: [language_updates_and_stdlib/02_standard_library/11_log_and_crypto/crypto/mac/crypto_mac.v](file:///Users/codecaine/V-Programming-Comprehensive-Guide/language_updates_and_stdlib/02_standard_library/11_log_and_crypto/crypto/mac/crypto_mac.v)_

### Lesson: Crypto Mac

V has a very rich and growing standard library and is actively updated. This lesson on **Crypto Mac** showcases modern standard library packages, system calls, network sockets, inline assembly, or WASM support.

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

---

### Crypto Symmetric

_File location: [language_updates_and_stdlib/02_standard_library/11_log_and_crypto/crypto/symmetric/crypto_symmetric.v](file:///Users/codecaine/V-Programming-Comprehensive-Guide/language_updates_and_stdlib/02_standard_library/11_log_and_crypto/crypto/symmetric/crypto_symmetric.v)_

### Lesson: Crypto Symmetric

V has a very rich and growing standard library and is actively updated. This lesson on **Crypto Symmetric** showcases modern standard library packages, system calls, network sockets, inline assembly, or WASM support.

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

---

### Log And Crypto

_File location: [language_updates_and_stdlib/02_standard_library/11_log_and_crypto/log_and_crypto.v](file:///Users/codecaine/V-Programming-Comprehensive-Guide/language_updates_and_stdlib/02_standard_library/11_log_and_crypto/log_and_crypto.v)_

### Lesson: Log And Crypto

V has a very rich and growing standard library and is actively updated. This lesson on **Log And Crypto** showcases modern standard library packages, system calls, network sockets, inline assembly, or WASM support.

**Additional Context from Repository docs:**
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

---

### Sync Concurrency

_File location: [language_updates_and_stdlib/02_standard_library/12_sync_concurrency/sync_concurrency.v](file:///Users/codecaine/V-Programming-Comprehensive-Guide/language_updates_and_stdlib/02_standard_library/12_sync_concurrency/sync_concurrency.v)_

### Lesson: Sync Concurrency

V supports lightweight concurrency using **v-routines** via the `spawn` keyword (which spawns a function in a new thread). Threads communicate safely using **channels**, which prevent race conditions. For shared memory concurrency, V provides the `shared` keyword alongside `lock` and `unlock` blocks to safely synchronize access to variables.

These examples cover spawning tasks, reading/writing channels, buffering, select statements, and thread synchronization.

**Additional Context from Repository docs:**
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

---

### Encoding Formats

_File location: [language_updates_and_stdlib/02_standard_library/13_encoding_formats/encoding_formats.v](file:///Users/codecaine/V-Programming-Comprehensive-Guide/language_updates_and_stdlib/02_standard_library/13_encoding_formats/encoding_formats.v)_

### Lesson: Encoding Formats

V has a very rich and growing standard library and is actively updated. This lesson on **Encoding Formats** showcases modern standard library packages, system calls, network sockets, inline assembly, or WASM support.

**Additional Context from Repository docs:**
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

---

### Arrays Utility

_File location: [language_updates_and_stdlib/02_standard_library/14_arrays_utility/arrays_utility.v](file:///Users/codecaine/V-Programming-Comprehensive-Guide/language_updates_and_stdlib/02_standard_library/14_arrays_utility/arrays_utility.v)_

### Lesson: Arrays Utility

V's arrays module provides helpers for searching, grouping, partitioning, folding, and reducing collections. The verified demo in this repository exercises many documented helpers, including extremum lookup, chunking, searching, uniqueness, partitioning, windowing, and rotations.

```v
module main

import arrays

fn main() {
	println('=== arrays Utility Module Examples ===')

	nums := [5, 3, 9, 1, 7, 3]
	words := ['apple', 'banana', 'pear', 'banana']
	repeated := [1, 1, 2, 2, 3, 3]

	min_val := arrays.min(nums) or { 0 }
	max_val := arrays.max(nums) or { 0 }
	println('Array: ${nums}')
	println('Min: ${min_val}')
	println('Max: ${max_val}')

	min_idx := arrays.idx_min(nums) or { -1 }
	max_idx := arrays.idx_max(nums) or { -1 }
	println('Index of Min: ${min_idx}')
	println('Index of Max: ${max_idx}')

	chunked := arrays.chunk(nums, 2)
	println('chunk(): ${chunked}')

	distinct_result := arrays.distinct(words)
	println('distinct(): ${distinct_result}')

	filtered := arrays.filter_indexed(nums, fn (idx int, elem int) bool {
		return idx % 2 == 0 && elem > 3
	})
	println('filter_indexed(): ${filtered}')

	find_first := arrays.find_first(nums, fn (elem int) bool {
		return elem > 5
	}) or { 0 }
	println('find_first(): ${find_first}')

	folded := arrays.fold(nums, 0, fn (acc int, elem int) int {
		return acc + elem
	})
	println('fold(): ${folded}')

	part_even, part_odd := arrays.partition(nums, fn (elem int) bool {
		return elem % 2 == 0
	})
	println('partition(): even=${part_even}, odd=${part_odd}')

	unique_result := arrays.uniq(repeated)
	println('uniq(): ${unique_result}')
}
```

This section is intentionally broader than a quick smoke test; it mirrors the runnable repository example and highlights the helpers exposed by the module.

---

### Toml

_File location: [language_updates_and_stdlib/02_standard_library/15_toml/toml.v](file:///Users/codecaine/V-Programming-Comprehensive-Guide/language_updates_and_stdlib/02_standard_library/15_toml/toml.v)_

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

---

### Strconv

_File location: [language_updates_and_stdlib/02_standard_library/16_strconv/strconv.v](file:///Users/codecaine/V-Programming-Comprehensive-Guide/language_updates_and_stdlib/02_standard_library/16_strconv/strconv.v)_

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

---

### Term

_File location: [language_updates_and_stdlib/02_standard_library/17_term/term.v](file:///Users/codecaine/V-Programming-Comprehensive-Guide/language_updates_and_stdlib/02_standard_library/17_term/term.v)_

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

---

### Benchmark

_File location: [language_updates_and_stdlib/02_standard_library/18_benchmark/benchmark.v](file:///Users/codecaine/V-Programming-Comprehensive-Guide/language_updates_and_stdlib/02_standard_library/18_benchmark/benchmark.v)_

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

---

### Clipboard

_File location: [language_updates_and_stdlib/02_standard_library/19_clipboard/clipboard.v](file:///Users/codecaine/V-Programming-Comprehensive-Guide/language_updates_and_stdlib/02_standard_library/19_clipboard/clipboard.v)_

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

---

### Semver

_File location: [language_updates_and_stdlib/02_standard_library/20_semver/semver.v](file:///Users/codecaine/V-Programming-Comprehensive-Guide/language_updates_and_stdlib/02_standard_library/20_semver/semver.v)_

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

---

### Maps Standard Library Module (maps.v)

_File location: [language_updates_and_stdlib/02_standard_library/21_maps/maps.v](file:///Users/codecaine/V-Programming-Comprehensive-Guide/language_updates_and_stdlib/02_standard_library/21_maps/maps.v)_

This example demonstrates the high-level helpers in V's maps module, including filtering, transforming, inverting, merging, and converting between maps and arrays. The repository version is a verified walkthrough that exercises the full set of documented helpers.

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

	filtered := maps.filter(m1, fn (k string, v int) bool {
		return v > 1
	})
	println('filter(): ${filtered}')

	keys_upper := maps.to_array(m1, fn (k string, v int) string {
		return k.to_upper()
	})
	println('to_array(): ${keys_upper}')

	inverted := maps.invert(m1)
	println('invert(): ${inverted}')

	fruits := ['apple', 'banana', 'cherry']
	map_from_arr := maps.from_array(fruits)
	println('from_array(): ${map_from_arr}')

	m2 := {
		'banana': 20
		'date':   4
	}
	merged := maps.merge(m1, m2)
	println('merge(): ${merged}')

	mut mut_map := {
		'a': 1
	}
	maps.merge_in_place(mut mut_map, {
		'b': 2
		'c': 3
	})
	println('merge_in_place(): ${mut_map}')

	flat_items := maps.flat_map[string, int, string](m1, fn (k string, v int) []string {
		return [k, v.str()]
	})
	println('flat_map(): ${flat_items}')

	transformed := maps.to_map[string, int, string, int](m1, fn (k string, v int) (string, int) {
		return k.to_upper(), v * 10
	})
	println('to_map(): ${transformed}')
}
```

---

### Context

_File location: [language_updates_and_stdlib/02_standard_library/22_context/context.v](file:///Users/codecaine/V-Programming-Comprehensive-Guide/language_updates_and_stdlib/02_standard_library/22_context/context.v)_

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

---

### Archive Tar

_File location: [language_updates_and_stdlib/02_standard_library/26_archive_tar/archive_tar.v](file:///Users/codecaine/V-Programming-Comprehensive-Guide/language_updates_and_stdlib/02_standard_library/26_archive_tar/archive_tar.v)_

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

---

### Compress Deflate

_File location: [language_updates_and_stdlib/02_standard_library/27_compress/deflate/compress_deflate.v](file:///Users/codecaine/V-Programming-Comprehensive-Guide/language_updates_and_stdlib/02_standard_library/27_compress/deflate/compress_deflate.v)_

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

---

### Compress Gzip

_File location: [language_updates_and_stdlib/02_standard_library/27_compress/gzip/compress_gzip.v](file:///Users/codecaine/V-Programming-Comprehensive-Guide/language_updates_and_stdlib/02_standard_library/27_compress/gzip/compress_gzip.v)_

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

---

### Compress Szip

_File location: [language_updates_and_stdlib/02_standard_library/27_compress/szip/compress_szip.v](file:///Users/codecaine/V-Programming-Comprehensive-Guide/language_updates_and_stdlib/02_standard_library/27_compress/szip/compress_szip.v)_

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

---

### Compress Zlib

_File location: [language_updates_and_stdlib/02_standard_library/27_compress/zlib/compress_zlib.v](file:///Users/codecaine/V-Programming-Comprehensive-Guide/language_updates_and_stdlib/02_standard_library/27_compress/zlib/compress_zlib.v)_

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

---

### Compress Zstd

_File location: [language_updates_and_stdlib/02_standard_library/27_compress/zstd/compress_zstd.v](file:///Users/codecaine/V-Programming-Comprehensive-Guide/language_updates_and_stdlib/02_standard_library/27_compress/zstd/compress_zstd.v)_

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

---

### Io Fs

_File location: [language_updates_and_stdlib/02_standard_library/28_io/fs/io_fs.v](file:///Users/codecaine/V-Programming-Comprehensive-Guide/language_updates_and_stdlib/02_standard_library/28_io/fs/io_fs.v)_

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

---

### Io

_File location: [language_updates_and_stdlib/02_standard_library/28_io/io.v](file:///Users/codecaine/V-Programming-Comprehensive-Guide/language_updates_and_stdlib/02_standard_library/28_io/io.v)_

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

---

### Io Util

_File location: [language_updates_and_stdlib/02_standard_library/28_io/util/io_util.v](file:///Users/codecaine/V-Programming-Comprehensive-Guide/language_updates_and_stdlib/02_standard_library/28_io/util/io_util.v)_

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

---

### Hash

_File location: [language_updates_and_stdlib/02_standard_library/29_hash/hash.v](file:///Users/codecaine/V-Programming-Comprehensive-Guide/language_updates_and_stdlib/02_standard_library/29_hash/hash.v)_

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

---

### Bitfield

_File location: [language_updates_and_stdlib/02_standard_library/30_bitfield/bitfield.v](file:///Users/codecaine/V-Programming-Comprehensive-Guide/language_updates_and_stdlib/02_standard_library/30_bitfield/bitfield.v)_

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

---

### Cli

_File location: [language_updates_and_stdlib/02_standard_library/31_cli/cli.v](file:///Users/codecaine/V-Programming-Comprehensive-Guide/language_updates_and_stdlib/02_standard_library/31_cli/cli.v)_

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

---

### Veb

_File location: [language_updates_and_stdlib/02_standard_library/32_veb/veb.v](file:///Users/codecaine/V-Programming-Comprehensive-Guide/language_updates_and_stdlib/02_standard_library/32_veb/veb.v)_

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

---

### Readline

_File location: [language_updates_and_stdlib/02_standard_library/33_readline/readline.v](file:///Users/codecaine/V-Programming-Comprehensive-Guide/language_updates_and_stdlib/02_standard_library/33_readline/readline.v)_

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

---

### Runtime

_File location: [language_updates_and_stdlib/02_standard_library/34_runtime/runtime.v](file:///Users/codecaine/V-Programming-Comprehensive-Guide/language_updates_and_stdlib/02_standard_library/34_runtime/runtime.v)_

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

---

## Strings.Lorem Helper

### Strings Lorem

_File location: [language_updates_and_stdlib/02_standard_library/36_strings_lorem/strings_lorem.v](file:///Users/codecaine/V-Programming-Comprehensive-Guide/language_updates_and_stdlib/02_standard_library/36_strings_lorem/strings_lorem.v)_

V's standard library `strings.lorem` module provides a pseudo-random text generator based on a Markov chain built from embedded corpora. It produces structured text in the form of paragraphs and sentences, with options to control layouts, select specific corpora, and configure deterministic output.

This example demonstrates how to:

1. Generate pseudo-random text with default configurations.
2. Customize the output layout by adjusting words per sentence, sentences per paragraph, and paragraphs.
3. Select specific corpora such as `lorem` (Latin), `poe` (Edgar Allan Poe), `darwin` (Charles Darwin), and `bard` (William Shakespeare).
4. Run deterministic generation using an RNG seed and a custom starting phrase.

---

```v
module main

import strings.lorem

fn main() {
	println('=== V strings.lorem Standard Library Demo ===')

	// 1. Basic Generation with Default Configuration
	// By default, it will choose a random corpus, seed phrase, and RNG seed.
	println('\n--- 1. Default Lorem Ipsum Generation ---')
	default_lorem := lorem.generate(lorem.LoremCfg{})
	println(default_lorem)

	// 2. Custom Layout Configuration (Paragraphs, Sentences, Words)
	println('\n--- 2. Custom Layout Generation ---')
	custom_layout := lorem.generate(lorem.LoremCfg{
		paragraphs: 2
		sentences_per_paragraph: 3
		words_per_sentence: 6
	})
	println(custom_layout)

	// 3. Selection of Specific Embedded Corpora
	// V's strings.lorem module supports four built-in corpora:
	// - 'lorem' (Standard Latin Lorem Ipsum)
	// - 'poe' (Edgar Allan Poe's The Raven)
	// - 'darwin' (Charles Darwin's Origin of Species)
	// - 'bard' (William Shakespeare's works)
	println('\n--- 3. Specific Corpora Examples ---')

	corpora := ['lorem', 'poe', 'darwin', 'bard']
	for corpus in corpora {
		text := lorem.generate(lorem.LoremCfg{
			corpus_name: corpus
			paragraphs: 1
			sentences_per_paragraph: 2
			words_per_sentence: 8
		})
		println('Corpus [${corpus}]:')
		println(text)
		println('-'.repeat(40))
	}

	// 4. Deterministic Text Generation using RNG Seed and Custom Seed Phrases
	// Using a specific `rng_seed` guarantees that the generated pseudo-random text is deterministic
	// and identical across multiple runs. Custom `seed_text` provides a starting phrase for the Markov chain.
	println('\n--- 4. Deterministic Generation with Seed & Custom Starting Phrase ---')
	deterministic_lorem_1 := lorem.generate(lorem.LoremCfg{
		corpus_name: 'poe'
		rng_seed: 42
		seed_text: 'once upon a midnight'
		paragraphs: 1
		sentences_per_paragraph: 2
		words_per_sentence: 8
	})

	deterministic_lorem_2 := lorem.generate(lorem.LoremCfg{
		corpus_name: 'poe'
		rng_seed: 42
		seed_text: 'once upon a midnight'
		paragraphs: 1
		sentences_per_paragraph: 2
		words_per_sentence: 8
	})

	println('Run 1:')
	println(deterministic_lorem_1)
	println('\nRun 2:')
	println(deterministic_lorem_2)

	// Assert that they are exactly identical due to deterministic seeding
	assert deterministic_lorem_1 == deterministic_lorem_2
	println('\nDeterministic assertion passed! Both runs generated identical text.')
}
```

---

## WebAssembly Compilation

V has first-class support for WebAssembly (WASM). There are two distinct methods for compiling and working with WebAssembly in V:

1. **Compiling V source code to WASM** (using direct/native backends or Emscripten).
2. **Programmatic WASM generation** (using the built-in `wasm` instruction-level builder).

---

### Compiling V Source to WebAssembly

#### 1. Native Direct Backend (`-b wasm`)

V contains a native compiler backend that bypasses C intermediate code and outputs WebAssembly binary files (`.wasm`) directly. This backend has zero dependencies and is extremely fast, though it is currently in active development and supports a subset of the language.

To compile a V file directly to WASM:

```bash
v -b wasm -o main.wasm main.v
```

##### Executing in JavaScript/Node.js:

To run the natively compiled WASM binary, instantiate it using the standard JavaScript `WebAssembly` API:

```javascript
const fs = require("fs");

async function run() {
  const wasmBuffer = fs.readFileSync("main.wasm");
  const { instance } = await WebAssembly.instantiate(wasmBuffer, {
    env: {
      // Import host functions here if needed
    },
  });
  // Call exported V functions from JS
  console.log(instance.exports.add(5, 10));
}
run();
```

#### 2. Emscripten C Backend (`-os wasm`)

For compiling complex applications, standard library features, or C-linked dependencies to WASM, V relies on the Emscripten toolchain. V translates the V code to intermediate C, and Emscripten compiles it to highly optimized WebAssembly.

##### Prerequisites:

Ensure the Emscripten SDK (`emsdk`) is installed and active on your PATH:

```bash
git clone https://github.com/emscripten-core/emsdk.git
cd emsdk
./emsdk install latest
./emsdk activate latest
source ./emsdk_env.sh
```

##### Compiling with V:

```bash
v -os wasm -o main.js main.v
```

This produces:

- `main.wasm`: The compiled WebAssembly binary.
- `main.js`: Emscripten glue code to load the WASM module and map runtime environments (I/O, memory, filesystem).

##### Running in Node.js:

```bash
node main.js
```

---

### Programmatic WASM Generation

#### Programmatic WASM Builder

_File location: [language_updates_and_stdlib/02_standard_library/35_wasm/wasm.v](file:///Users/codecaine/V-Programming-Comprehensive-Guide/language_updates_and_stdlib/02_standard_library/35_wasm/wasm.v)_

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

### sizeof and \_\_offsetof

_File location: [language_updates_and_stdlib/01_language_basics_updates/09_sizeof_and_offsetof/sizeof_and_offsetof.v](file:///Users/codecaine/V-Programming-Comprehensive-Guide/language_updates_and_stdlib/01_language_basics_updates/09_sizeof_and_offsetof/sizeof_and_offsetof.v)_

### Lesson: sizeof and \_\_offsetof

V provides two built-in operators for determining sizes and memory offsets:

- `sizeof(Type)`: Returns the memory size of the given Type in bytes.
- `__offsetof(Struct, field_name)`: Returns the offset in bytes of a field relative to the start of the struct.

#### Step-by-Step Code Walkthrough:

- **Size of `Point`**:
  `sizeof(Point)` yields `8` bytes because it has two `int` fields (4 bytes each).
- **Size of `Foo` & Alignment Padding**:
  `sizeof(Foo)` yields `12` bytes, even though it contains `a int` (4 bytes), `b u8` (1 byte), and `c int` (4 bytes). This happens because of C ABI alignment: V aligns struct members on word boundaries (in this case, 4 bytes), adding 3 bytes of invisible padding after `b u8`.
- **Offsets of fields in `Foo`**:
  - `__offsetof(Foo, a)` yields `0` because it starts at byte 0.
  - `__offsetof(Foo, b)` yields `4` because it starts right after `a` (4 bytes).
  - `__offsetof(Foo, c)` yields `8` because it aligns on the next 4-byte boundary due to padding after `b`.

**Additional Context from Repository docs:**
This example demonstrates the concepts of **sizeof and \_\_offsetof**.

```v
module main

struct Point {
	x int
	y int
}

struct Foo {
	a int
	b u8
	c int
}

fn main() {
	// sizeof gives the size of a type in bytes
	println('sizeof(Point) = ${sizeof(Point)} bytes') // 8
	println('sizeof(Foo) = ${sizeof(Foo)} bytes')     // 12 (due to alignment/padding in C backend)

	// __offsetof gives the offset in bytes of a struct field
	println('__offsetof(Point, x) = ${__offsetof(Point, x)}') // 0
	println('__offsetof(Point, y) = ${__offsetof(Point, y)}') // 4
	println('__offsetof(Foo, a) = ${__offsetof(Foo, a)}')     // 0
	println('__offsetof(Foo, b) = ${__offsetof(Foo, b)}')     // 4
	println('__offsetof(Foo, c) = ${__offsetof(Foo, c)}')     // 8
}
```

---

### Limited Operator Overloading

_File location: [language_updates_and_stdlib/01_language_basics_updates/10_operator_overloading/operator_overloading.v](file:///Users/codecaine/V-Programming-Comprehensive-Guide/language_updates_and_stdlib/01_language_basics_updates/10_operator_overloading/operator_overloading.v)_

### Lesson: Limited Operator Overloading

Operator overloading is supported for a limited set of binary operators (`+, -, *, **, /, %, <, ==`) to improve readability in scientific, mathematical, and graphics applications. V does not support indexing (`[]`) or assignment (`=`) overloading. Overloading the `+` operator automatically synthesizes the matching assignment operator (e.g., `+=`).

#### Step-by-Step Code Walkthrough:

- **Binary Operator Overloading**:
  We define the `+` and `-` operators for struct `Vec` using the syntax `fn (a Vec) + (b Vec) Vec`. V invokes these methods directly when performing arithmetic expressions like `a + b` or `a - b`.
- **Equality Operator Overloading**:
  We define `==` to verify element-by-element equality: `a.x == b.x && a.y == b.y`.
- **Automatic Assignment Generation**:
  When we overload `+`, V autogenerates the compound assignment operator `+=`. Executing `c += a` resolves to `c = c + a`, compiling and modifying `c` automatically.

**Additional Context from Repository docs:**
This example demonstrates the concepts of **limited operator overloading**.

```v
module main

struct Vec {
	x int
	y int
}

fn (a Vec) str() string {
	return '{${a.x}, ${a.y}}'
}

// Overload addition operator (+)
fn (a Vec) + (b Vec) Vec {
	return Vec{a.x + b.x, a.y + b.y}
}

// Overload subtraction operator (-)
fn (a Vec) - (b Vec) Vec {
	return Vec{a.x - b.x, a.y - b.y}
}

// Overload equality operator (==)
fn (a Vec) == (b Vec) bool {
	return a.x == b.x && a.y == b.y
}

fn main() {
	a := Vec{2, 3}
	b := Vec{4, 5}
	mut c := Vec{1, 2}

	println('a + b = ${a + b}') // {6, 8}
	println('a - b = ${a - b}') // {-2, -2}

	// c += a is autogenerated from the + overload!
	c += a
	println('c after += a: ${c}') // {3, 5}

	println('a == b: ${a == b}') // false
	println('a == Vec{2, 3}: ${a == Vec{2, 3}}') // true
}
```

---

### Atomics

_File location: [language_updates_and_stdlib/01_language_basics_updates/11_atomics/atomics.v](file:///Users/codecaine/V-Programming-Comprehensive-Guide/language_updates_and_stdlib/01_language_basics_updates/11_atomics/atomics.v)_

### Lesson: Atomics

V does not have direct keyword support for atomic operations but integrates standard C11 atomic capabilities through platform-specific wrapper headers (found under `stdatomic/`). Variables can be treated atomically by executing type-specific functions prefixed by `C.atomic_` and passing references to the target variables.

#### Step-by-Step Code Walkthrough:

- **C Header Inclusion**:
  Depending on the compilation target, V includes either the Unix or Windows wrapper headers `atomic.h` containing atomic operations.
- **C declarations**:
  `fn C.atomic_store_u32(&u32, u32)` and other methods are declared. Since V does not automatically parse C headers, we manually declare the C functions we want to invoke.
- **Local Storage**:
  We declare a local variable `atom := u32(0)` inside `main()`. Any variable can be treated atomically by passing its memory reference (pointer) to the C functions. This avoids needing global variables or compiling with `-enable-globals` flag.
- **CAS (Compare-And-Swap)**:
  Inside `unsafe { ... }`, we call `C.atomic_compare_exchange_strong_u32(&atom, &expected, 23)`. If the value at `&atom` matches `expected` (17), it replaces it with `23` and returns `true`. If not, it loads the actual current value into `expected` and returns `false`.

**Additional Context from Repository docs:**
This example demonstrates the concepts of **atomics**.

```v
module main

$if windows {
	#include "@VEXEROOT/thirdparty/stdatomic/win/atomic.h"
} $else {
	#include "@VEXEROOT/thirdparty/stdatomic/nix/atomic.h"
}

// declare the C functions we want to use
fn C.atomic_store_u32(&u32, u32)
fn C.atomic_load_u32(&u32) u32
fn C.atomic_compare_exchange_strong_u32(&u32, &u32, u32) bool

fn main() {
	// Ordinary local variable, treated as atomic by passing its reference
	mut atom := u32(0)

	// Initialize atomic variable
	unsafe {
		C.atomic_store_u32(&atom, 17)

		mut expected := u32(17)
		// Atomic CAS: if atom == expected, set atom to 23 and return true
		if C.atomic_compare_exchange_strong_u32(&atom, &expected, 23) {
			println('Exchange successful, atom is now 23')
		} else {
			println('Exchange failed, atom is ${C.atomic_load_u32(&atom)}')
		}

		println('Final value: ${C.atomic_load_u32(&atom)}')
	}
}
```

---

### Static Variables

_File location: [language_updates_and_stdlib/01_language_basics_updates/12_static_variables/static_variables.v](file:///Users/codecaine/V-Programming-Comprehensive-Guide/language_updates_and_stdlib/01_language_basics_updates/12_static_variables/static_variables.v)_

### Lesson: Static Variables

V supports **Static Variables** within functions. They behave like namespaced global variables, preserving state across function calls, but are restricted to the local scope of a single function. Functions containing static variables must be marked with `@[unsafe]` and calls must occur in `unsafe` blocks. They are primarily intended for facilitating low-level C code translations.

#### Step-by-Step Code Walkthrough:

- **Static Variable Definition**:
  Inside the function `counter()`, we define `mut static x := 42`. The compiler generates this variable in the global data space but restricts access to it exclusively within `counter()`.
- **One-Time Initialization**:
  The initialization expression `= 42` is executed exactly once when the program starts. It is skipped on subsequent calls to `counter()`.
- **Access Rules**:
  Because static variables represent shared mutable state, `counter()` is marked with `@[unsafe]` and called within `unsafe` blocks in `main()`.

**Additional Context from Repository docs:**
This example demonstrates the concepts of **static variables**.

```v
module main

// V supports function-scoped static variables inside unsafe functions
@[unsafe]
fn counter() int {
	// static variables are initialized only once
	mut static x := 42
	x++
	return x
}

fn main() {
	println(unsafe { counter() }) // 43
	println(unsafe { counter() }) // 44
	println(unsafe { counter() }) // 45
}
```

---

### Hot Code Reloading

_File location: [language_updates_and_stdlib/01_language_basics_updates/13_hot_code_reloading/hot_code_reloading.v](file:///Users/codecaine/V-Programming-Comprehensive-Guide/language_updates_and_stdlib/01_language_basics_updates/13_hot_code_reloading/hot_code_reloading.v)_

### Lesson: Hot Code Reloading

V supports **Hot Code Reloading** using the `@[live]` attribute. By compiling a program with the `-live` flag (e.g. `v -live run file.v`), V monitors the source files, automatically recompiles live-annotated functions to a shared library, and reloads them dynamically at runtime without restarting the application.

#### Step-by-Step Code Walkthrough:

- **Live Annotation**:
  The function `print_message()` is marked with the `@[live]` attribute. This instructs the compiler to generate it as a hot-reloadable hook loading from a shared library.
- **Main loop execution**:
  The loop in `main()` runs continuously. If you modify the message in the string print inside `print_message()` and save the file, V's monitoring thread detects the change, rebuilds the code, and subsequent calls in the loop print the updated message instantly.

**Additional Context from Repository docs:**
This example demonstrates the concepts of **hot code reloading**.

```v
module main

import time

// Functions that should be reloaded must have `@[live]` attribute
@[live]
fn print_message() {
	println('Hello! Modify this message while the program is running under -live mode.')
}

fn main() {
	// A simple loop printing the message
	for i in 0 .. 3 {
		print_message()
		time.sleep(100 * time.millisecond)
	}
}
```

---

### Compile-Time Reflection

_File location: [language_updates_and_stdlib/01_language_basics_updates/14_compile_time_reflection/compile_time_reflection.v](file:///Users/codecaine/V-Programming-Comprehensive-Guide/language_updates_and_stdlib/01_language_basics_updates/14_compile_time_reflection/compile_time_reflection.v)_

### Lesson: Compile-Time Reflection

V supports **Compile-Time Reflection** using the `$` prefix to perform type operations, evaluations, and code generation during compilation. V iterates over struct fields, attributes, variants, and methods at compile-time using `$for` loops, providing static safety without any runtime metadata overhead.

- Struct fields can be examined via `Struct.fields`.
- Struct attributes can be examined via `Struct.attributes`.
- Struct methods can be examined via `Struct.methods`, and executed dynamically using `$method()`.

#### Step-by-Step Code Walkthrough:

- **Field Iteration (`$for field in User.fields`)**:
  Iterates over all fields of `User`. Evaluates their names (`field.name`) and type IDs (`field.typ`) at compile-time.
- **Attribute Iteration (`$for attr in User.attributes`)**:
  Inspects attributes attached to the struct, such as `@[COLOR]` (prints `COLOR`).
- **Comptime Method Invocation (`user.$method()`)**:
  Inside `$for m in User.methods`, we check if the method returns a `string`. If so, we execute the method dynamically using the `$method()` comptime syntax, calling `greet()` on the `user` instance and printing `Hello Alice`.

**Additional Context from Repository docs:**
This example demonstrates the concepts of **compile-time reflection**.

```v
module main

@[COLOR]
struct User {
	name string
	age  int
}

fn (u User) greet() string {
	return 'Hello ${u.name}'
}

fn main() {
	println('--- Struct Fields Reflection ---')
	$for field in User.fields {
		println('Field: ${field.name} | Typ: ${field.typ}')
	}

	println('\n--- Struct Attributes Reflection ---')
	$for attr in User.attributes {
		println('Attribute name: ${attr.name}')
	}

	println('\n--- Struct Methods Reflection ---')
	user := User{name: 'Alice', age: 30}
	$for m in User.methods {
		$if m.return_type is string {
			println(user.$method())
		}
	}
}
```

---

### Compile-Time Pseudo Variables

_File location: [language_updates_and_stdlib/01_language_basics_updates/15_compile_time_pseudo_variables/compile_time_pseudo_variables.v](file:///Users/codecaine/V-Programming-Comprehensive-Guide/language_updates_and_stdlib/01_language_basics_updates/15_compile_time_pseudo_variables/compile_time_pseudo_variables.v)_

### Lesson: Compile-Time Pseudo Variables

V provides a set of pseudo-variables starting with `@` that are evaluated and substituted at compile time:

- **Scope Identifiers**:
  - `@FN` -> Replaced with the name of the current V function (as a string).
  - `@METHOD` -> Replaced with the `ReceiverType.MethodName` of the current method (as a string).
  - `@MOD` -> Replaced with the name of the current V module (as a string).
  - `@STRUCT` -> Replaced with the name of the current V struct (as a string).

- **Source File & Location Identifiers**:
  - `@FILE` -> Replaced with the absolute path of the V source file (as a string).
  - `@DIR` -> Replaced with the absolute path of the folder containing the V source file (as a string).
  - `@LINE` -> Replaced with the V line number where it appears (as a string).
  - `@FILE_LINE` -> Like `@FILE:@LINE`, but the file part is a relative path (as a string).
  - `@LOCATION` -> Combines file, line, and type/method name; suitable for logging.
  - `@COLUMN` -> Replaced with the 1-based column offset where it appears (as a string).

- **V Compiler & Git Identifiers**:
  - `@VEXE` -> Replaced with the path to the V compiler executable (as a string).
  - `@VEXEROOT` -> Replaced with the folder containing the V compiler executable (as a string).
  - `@VHASH` -> Replaced with the shortened commit hash of the V compiler (as a string).
  - `@VCURRENTHASH` -> Similar to `@VHASH`, but updates when the compiler is recompiled after local modifications or git bisect.

- **Project Mod Info (requires `v.mod` in project root)**:
  - `@VMOD_FILE` -> Replaced with the contents of the nearest `v.mod` file (as a string).
  - `@VMODHASH` -> Replaced with the shortened commit hash derived from the `.git` directory next to the nearest `v.mod` file (as a string).
  - `@VMODROOT` -> Replaced with the path to the directory containing the nearest `v.mod` file (as a string).

- **Build Time Identifiers (UTC timezone)**:
  - `@BUILD_DATE` -> Replaced with the build date (e.g. `'2026-06-26'`).
  - `@BUILD_TIME` -> Replaced with the UTC build time (e.g. `'17:50:24'`).
  - `@BUILD_TIMESTAMP` -> Replaced with the Unix timestamp of the build (e.g. `'1782496224'`).
  - _Note: Build variables can be overridden by setting the `SOURCE_DATE_EPOCH` environment variable, enabling reproducible builds (e.g., setting it to the latest git commit timestamp)._

- **Target Platform / Toolchain Identifiers**:
  - `@OS` -> Replaced with the OS type (e.g. `'macos'`, `'linux'`, `'windows'`).
  - `@CCOMPILER` -> Replaced with the C compiler used (e.g. `'gcc'`, `'clang'`).
  - `@BACKEND` -> Replaced with the current language backend (e.g. `'c'`, `'js'`).
  - `@PLATFORM` -> Replaced with the CPU architecture type (e.g. `'arm64'`, `'amd64'`).

**Additional Context from Repository docs:**
This example demonstrates the usage and output of all the available compile-time pseudo variables in V.

```v
module main

struct User {
	name string
}

fn (u User) register() {
	println('Executing method: ' + @METHOD) // User.register
	println('Defined in struct: ' + @STRUCT) // User
}

fn log_event() {
	println('Logging from function: ' + @FN) // log_event
}

fn main() {
	println('=== V Compile-Time Pseudo Variables ===')

	// Module & File Info
	println('Current Module: ' + @MOD)
	println('Source File Path: ' + @FILE)
	println('Source Directory: ' + @DIR)
	println('Line Number: ' + @LINE.str())
	println('Relative File/Line: ' + @FILE_LINE)
	println('Log Location: ' + @LOCATION)
	println('Column Number: ' + @COLUMN.str())

	// Compiler Info
	println('V Compiler Executable: ' + @VEXE)
	println('V compiler Root Directory: ' + @VEXEROOT)
	println('V Compiler Commit Hash: ' + @VHASH)
	println('V Compiler Current Hash: ' + @VCURRENTHASH)

	// project Info (from v.mod)
	println('v.mod File Contents: ' + @VMOD_FILE)
	println('v.mod Git Commit Hash: ' + @VMODHASH)
	println('v.mod Root Directory: ' + @VMODROOT)

	// Build Info (UTC timezone)
	println('Build Date: ' + @BUILD_DATE)
	println('Build Time: ' + @BUILD_TIME)
	println('Build Timestamp: ' + @BUILD_TIMESTAMP)

	// Platform / Backend Info
	println('Target OS: ' + @OS)
	println('C Compiler: ' + @CCOMPILER)
	println('V Backend: ' + @BACKEND)
	println('CPU Platform: ' + @PLATFORM)

	u := User{name: 'Alice'}
	u.register()
	log_event()
}
```

---

### Environment-Specific Files & Compile-Time Types

### Lesson: Environment-Specific Files & Compile-Time Types

#### Environment-Specific Files

V supports compile-time filtering of entire files using file suffix conventions instead of conditional directives:

- `.js.v` -> compiled only when targeting the Javascript backend.
- `.c.v` -> compiled only when targeting the C backend.
- `_nix.c.v` -> compiled only on Unix-like platforms.
- `_windows.c.v` -> compiled only on Windows.
- `_d_customflag.v` -> compiled only if `-d customflag` is passed to the compiler.

#### Compile-Time Types

When writing generic code, V provides specialized compile-time type matching identifiers to selectively check generic constraints:

- `$alias` -> matches type aliases.
- `$array` -> matches arrays and fixed-size arrays.
- `$enum` -> matches enum types.
- `$float` / `$int` / `$string` -> matches floating numbers, integers, or string values.
- `$struct` -> matches struct types.

---

### References & Pointers

_File location: [language_updates_and_stdlib/01_language_basics_updates/16_references/references.v](file:///Users/codecaine/V-Programming-Comprehensive-Guide/language_updates_and_stdlib/01_language_basics_updates/16_references/references.v)_

### Lesson: References & Pointers

In V, references are similar to pointers in Go/C and references in C++. They allow you to point to a memory location of another variable without making a copy of its contents.

#### 1. Passing by Value vs. Passing by Reference

When passing immutable arguments (like structs) to functions or methods, V decides under the hood whether to pass them by value or by reference depending on performance characteristics. As a developer, you do not need to worry about this optimization detail.

However, you can explicitly force an argument or method receiver to be passed by reference by prefixing the type with `&` (e.g., `&Foo`).

#### 2. Mutability of References

References in V are immutable by default:

- Even if a function or method receives a reference (`&Foo`), it cannot modify the fields of that struct unless the parameter is marked as mutable.
- To allow modification, the argument must be declared as `mut foo Foo` (which V automatically passes by reference under the hood) and called with `mut` (e.g. `modify_foo(mut my_foo)`). Note that modifiable fields must also be defined under the `mut:` access block in the struct declaration.

#### 3. Dereferencing

To access the underlying value of a reference directly, or to create a copy of the pointed-to object, use the dereferencing operator `*` (e.g., `copied_foo := *ref_to_foo`), similar to Go and C.

#### 4. Recursive Structures

Recursive data structures (such as linked lists or trees) require fields that reference their own type. Because V needs to calculate the memory size of structs at compile time, recursive fields must be declared as references (e.g., `left ?&Node[T]`) because references have a fixed pointer size.

- To allow optional/empty references (like leaf node terminations in trees), V supports **optional references** (e.g. `?&Node[T]`). These are automatically initialized to `none` by default, avoiding the need for `unsafe { nil }` pointers or dummy nodes.

---

Here is the complete demonstration program showcasing V references and recursive struct designs:

```v
module main

struct Foo {
mut:
	abc int
}

// 1. A method receiving a reference. The receiver type is &Foo.
// Even though it is a reference, `foo` is immutable and cannot be changed here.
fn (foo &Foo) print_abc() {
	println('print_abc: foo.abc = ${foo.abc}')
}

// 2. A regular function receiving a reference to Foo.
fn show_foo(foo &Foo) {
	println('show_foo: foo.abc = ${foo.abc}')
}

// 3. To modify a reference, we must pass it as mutable.
// Note that mutable parameters are passed by reference under the hood.
fn modify_foo(mut foo Foo, new_val int) {
	foo.abc = new_val
}

// 4. References are crucial for recursive types (like trees or linked lists).
// Since the size of Node must be known at compile time, recursive fields must be references.
// To allow optional/empty references (like leaf node terminations), V uses optional references (?&Node[T]).
struct Node[T] {
	val   T
	left  ?&Node[T]
	right ?&Node[T]
}

fn main() {
	println('=== V References & Pointers Demo ===')

	// Creating a struct instance
	mut my_foo := Foo{
		abc: 100
	}

	// Calling method on reference. V automatically takes the address of my_foo.
	my_foo.print_abc()

	// Calling a function expecting a reference using & operator.
	show_foo(&my_foo)

	// Modifying the struct via a mutable receiver/argument.
	modify_foo(mut my_foo, 200)
	println('After modify_foo: my_foo.abc = ${my_foo.abc}')

	// 5. Dereferencing a reference using the `*` operator.
	ref_to_foo := &my_foo
	// To copy the value of the struct pointed to by ref_to_foo:
	copied_foo := *ref_to_foo
	println('Copied foo abc: ${copied_foo.abc}')

	// 6. Generic Tree structure using optional references
	// Optional references are auto-initialized to `none`, so we don't need dummy nodes or `unsafe` blocks.
	left_leaf := Node[int]{
		val: 5
	}

	right_leaf := Node[int]{
		val: 15
	}

	// Create root node pointing to leaf references
	root := Node[int]{
		val: 10
		left: &left_leaf
		right: &right_leaf
	}

	println('Root val: ${root.val}')

	// Access the optional child nodes safely using if guards
	if left := root.left {
		println('Left leaf val: ${left.val}')
	}
	if right := root.right {
		println('Right leaf val: ${right.val}')
	}
}
```

---

# Chapter 14: Useful Boilerplates and Application Templates

## Quick Access

Below is an index of all code examples in this chapter. You can use these links to jump directly to any specific code example:

**Boilerplate Templates**

- [CLI Command-Line Application Boilerplate](#cli-command-line-application-boilerplate)
- [REST API Server Boilerplate](#rest-api-server-boilerplate)
- [Worker Pool Concurrency Boilerplate](#worker-pool-concurrency-boilerplate)
- [OS and File Utilities Boilerplate](#os-and-file-utilities-boilerplate)
- [String Utilities Boilerplate](#string-utilities-boilerplate)
- [Math and Statistics Boilerplate](#math-and-statistics-boilerplate)
- [Array Utilities Boilerplate](#array-utilities-boilerplate)
- [Configuration Management Boilerplate](#configuration-management-boilerplate)
- [JSON File Store Boilerplate](#json-file-store-boilerplate)
- [Retry and Backoff Boilerplate](#retry-and-backoff-boilerplate)
- [HTTP Client Boilerplate](#http-client-boilerplate)
- [CSV Processor Boilerplate](#csv-processor-boilerplate)
- [Logging Boilerplate](#logging-boilerplate)

---

This chapter provides a collection of production-ready, fully commented boilerplate templates designed to jumpstart your development with V. These examples showcase common application patterns, standard library usage, and best practices.

## Boilerplate Templates

### CLI Command-Line Application Boilerplate

_File location: [boilerplate_templates/01_cli_app/cli_app.v](file:///Users/codecaine/V-Programming-Comprehensive-Guide/boilerplate_templates/01_cli_app/cli_app.v)_

### Lesson: CLI Command-Line Application Boilerplate

When building command-line utilities, V provides a highly featured standard `flag` module. Rather than manually parsing arguments from `os.args`, the `flag` module simplifies declaring options, validation, and auto-generates helpful usage/help text.

Key concepts illustrated:

- **Initializing flag parser**: Creating a new parser with `flag.new_flag_parser(os.args)`.
- **Defining Flags**: Specifying flag names, short character abbreviations, default values, and description text.
- **Config Struct Pattern**: Cleanly separating parsed options from application logic using a custom config struct.
- **Error Handling & Finalization**: Handling invalid command usage gracefully using `fp.finalize()`.

```v
module main

import flag
import os

// Config holds the validated configuration settings for the application.
struct Config {
	input_file  string
	output_file string
	verbose     bool
	retries     int
	mode        string
}

fn main() {
	// 1. Initialize the flag parser with command-line arguments (os.args)
	mut fp := flag.new_flag_parser(os.args)
	fp.application('v-cli-boilerplate')
	fp.version('1.0.0')
	fp.description('A professional CLI boilerplate showing flag parsing, validation, and structured configurations in V.')

	// 2. Skip the executable path during parsing
	fp.skip_executable()

	// 3. Define flags with short abbreviations, default values, and descriptions
	input_file := fp.string('input', `i`, '', 'Path to the input file (required)')
	output_file := fp.string('output', `o`, 'output.txt', 'Path to the output file')
	verbose := fp.bool('verbose', `v`, false, 'Enable verbose logging')
	retries := fp.int('retries', `r`, 3, 'Number of retries for operation')
	mode := fp.string('mode', `m`, 'default', 'Operation mode (default, fast, safe)')

	// 4. Finalize parsing. This returns remaining non-flag arguments or an error.
	additional_args := fp.finalize() or {
		eprintln('Error: ${err}')
		println(fp.usage())
		exit(1)
	}

	// 5. Validate required flags and values
	if input_file == '' {
		eprintln('Error: --input (-i) flag is required.')
		println(fp.usage())
		exit(1)
	}

	// Validate allowed values for a string enum
	if mode !in ['default', 'fast', 'safe'] {
		eprintln('Error: Invalid mode "${mode}". Must be one of: default, fast, safe.')
		println(fp.usage())
		exit(1)
	}

	// 6. Map parsed arguments to the Config struct for clean division of concerns
	config := Config{
		input_file: input_file
		output_file: output_file
		verbose: verbose
		retries: retries
		mode: mode
	}

	// 7. Run the application logic
	run_app(config, additional_args)
}

fn run_app(cfg Config, args []string) {
	if cfg.verbose {
		println('[DEBUG] Starting application execution...')
		println('[DEBUG] Config: ${cfg}')
		if args.len > 0 {
			println('[DEBUG] Positional Arguments: ${args}')
		}
	}

	println('Processing input file: ${cfg.input_file}')
	println('Operation mode: ${cfg.mode}')
	println('Retries configured: ${cfg.retries}')

	// Perform work here...
	println('Writing results to output file: ${cfg.output_file}')

	println('Success: Application executed successfully!')
}
```

---

### REST API Server Boilerplate

_File location: [boilerplate_templates/02_rest_api/rest_api.v](file:///Users/codecaine/V-Programming-Comprehensive-Guide/boilerplate_templates/02_rest_api/rest_api.v)_

### Lesson: REST API Server Boilerplate

V's standard web framework, `veb`, is optimized for building fast, high-conformance web apps and APIs. This template serves as a quick-start scaffolding for a JSON REST service, illustrating CRUD routing and request decoding.

Key concepts illustrated:

- **Routing Attributes**: Tagging methods with route paths and HTTP verbs (e.g. `@['/api/items'; get]`).
- **Path Parameters**: Defining routes with dynamic segments like `@['/api/items/:id'; get]` which map directly to method arguments.
- **JSON Serialization/Deserialization**: Using `json.encode` and `json.decode` to work with HTTP requests and responses.
- **State Management & Thread Safety**: Using fields in the global `App` struct to share resources, protected by a `sync.RwMutex` to ensure thread-safe concurrent access.

```v
module main

import json
import os
import sync
import veb

// Item represents a data model in our API.
struct Item {
	id   int    @[json: 'id']
	name string @[json: 'name']
	done bool   @[json: 'done']
}

// App holds the global state of the application.
struct App {
mut:
	lock  sync.RwMutex
	items []Item
}

// Context wraps veb's request/response lifecycle.
struct Context {
	veb.Context
}

// 1. GET / - Simple text response index endpoint
fn (mut app App) index(mut ctx Context) veb.Result {
	return ctx.text('Welcome to the V REST API Boilerplate! Use /api/items to interact with the service.')
}

// 2. GET /api/items - Returns list of all items as JSON
@['/api/items'; get]
fn (mut app App) get_items(mut ctx Context) veb.Result {
	app.lock.@rlock()
	defer { app.lock.runlock() }
	return ctx.json(json.encode(app.items))
}

// 3. GET /api/items/:id - Returns a single item by id, or 404
@['/api/items/:id'; get]
fn (mut app App) get_item(mut ctx Context, id int) veb.Result {
	app.lock.@rlock()
	defer { app.lock.runlock() }
	for item in app.items {
		if item.id == id {
			return ctx.json(json.encode(item))
		}
	}
	ctx.res.set_status(.not_found)
	return ctx.json('{"error": "Item not found"}')
}

// 4. POST /api/items - Decodes JSON request body and adds a new item
@['/api/items'; post]
fn (mut app App) create_item(mut ctx Context) veb.Result {
	new_item := json.decode(Item, ctx.req.data) or {
		ctx.res.set_status(.bad_request)
		return ctx.json('{"error": "Invalid JSON format"}')
	}

	app.lock.@lock()
	defer { app.lock.unlock() }

	// Auto-increment ID based on length
	item_to_add := Item{
		id: app.items.len + 1
		name: new_item.name
		done: new_item.done
	}

	app.items << item_to_add
	ctx.res.set_status(.created)
	return ctx.json(json.encode(item_to_add))
}

fn main() {
	// Initialize App with mock seed data
	mut app := &App{
		items: [
			Item{id: 1, name: 'Learn V syntax', done: true},
			Item{id: 2, name: 'Build a REST API in V', done: false},
		]
	}

	// Read port from environment variable or default to 8082 to avoid common conflicts on 8080
	port_env := os.getenv('PORT')
	port := if port_env != '' { port_env.int() } else { 8082 }

	println('Starting REST API server on http://localhost:${port}...')

	// Start veb web server
	veb.run[App, Context](mut app, port)
}
```

---

### Worker Pool Concurrency Boilerplate

_File location: [boilerplate_templates/03_worker_pool/worker_pool.v](file:///Users/codecaine/V-Programming-Comprehensive-Guide/boilerplate_templates/03_worker_pool/worker_pool.v)_

### Lesson: Worker Pool Concurrency Boilerplate

V offers lightweight concurrency out of the box. By combining `spawn` (thread creation) with typed channels (`chan`), you can build thread-safe worker pools that process computationally intensive or high-latency tasks in parallel without lock overhead.

Key concepts illustrated:

- **Channel Communication**: Sending and receiving tasks and results over thread-safe queues.
- **Spawned Threads**: Running worker functions concurrently using the `spawn` keyword.
- **Synchronization with WaitGroups**: Using `sync.WaitGroup` to track and coordinate concurrent worker completion.
- **Monitor Thread Pattern**: Spawning a monitor thread to wait for workers to finish and close the results channel, avoiding channel deadlocks.
- **Graceful Shutdown**: Closing the tasks channel (`tasks_chan.close()`) to signal worker threads to cleanly exit.

```v
module main

import time
import sync

// Task represents the unit of work to be processed.
struct Task {
	id   int
	data string
}

// Result represents the outcome of processing a Task.
struct Result {
	task_id   int
	worker_id int
	output    string
	duration  time.Duration
}

// worker runs in a separate thread, consuming from tasks_chan and producing to results_chan.
fn worker(id int, tasks_chan chan Task, results_chan chan Result, mut wg sync.WaitGroup) {
	defer {
		wg.done()
	}
	for {
		// Receive a task from the channel.
		// If the channel is closed and empty, it returns `none`
		t := <-tasks_chan or {
			break
		}

		start_time := time.now()

		// Simulate intensive processing/I/O task
		time.sleep(50 * time.millisecond)

		elapsed := time.since(start_time)

		// Send the result to the output channel
		results_chan <- Result{
			task_id: t.id
			worker_id: id
			output: 'Processed: ' + t.data.to_upper()
			duration: elapsed
		}
	}
}

// wait_and_close waits for all workers to finish and then closes the results channel.
fn wait_and_close(mut wg sync.WaitGroup, results_chan chan Result) {
	wg.wait()
	results_chan.close()
}

fn main() {
	println('=== V Worker Pool Concurrency Boilerplate ===')

	// 1. Create channels for tasks and results with capacities
	tasks_chan := chan Task{cap: 10}
	results_chan := chan Result{cap: 10}

	num_workers := 3
	num_tasks := 5

	mut wg := sync.new_waitgroup()

	// 2. Spawn concurrent worker threads
	println('Spawning ${num_workers} workers...')
	for i in 0 .. num_workers {
		wg.add(1)
		spawn worker(i + 1, tasks_chan, results_chan, mut wg)
	}

	// Spawn the monitor thread to close results_chan when all workers are done
	spawn wait_and_close(mut wg, results_chan)

	// 3. Dispatch tasks to the queue
	println('Dispatching ${num_tasks} tasks to worker pool...')
	for i in 0 .. num_tasks {
		tasks_chan <- Task{
			id: i + 1
			data: 'task-payload-${i + 1}'
		}
	}

	// 4. Close tasks channel to signal workers that no more work is coming
	tasks_chan.close()
	println('Tasks dispatched, queue closed. Collecting results...')

	// 5. Collect results from results channel by iterating until it is closed
	mut results := []Result{}
	for {
		res := <-results_chan or { break }
		results << res
		println('Received: Task #${res.task_id} from Worker #${res.worker_id} (took ${res.duration.milliseconds()}ms)')
	}

	// 6. Print summary
	println('\n=== Processing Summary ===')
	for res in results {
		println('- Task #${res.task_id} -> ${res.output} (Worker #${res.worker_id})')
	}
}
```

---

### OS and File Utilities Boilerplate

_File location: [boilerplate_templates/04_file_utilities/file_utilities.v](file:///Users/codecaine/V-Programming-Comprehensive-Guide/boilerplate_templates/04_file_utilities/file_utilities.v)_

### Lesson: OS and File Utilities Boilerplate

V's standard `os` module contains comprehensive and platform-agnostic tools for interacting with the file system and host operating system.

Key concepts illustrated:

- **Path Manipulation**: Using `os.join_path` to build paths correctly across Linux, macOS, and Windows.
- **File I/O**: Performing quick reads and writes using `os.read_file` and `os.write_file`.
- **Directory Operations**: Checking folder existence, recursively creating folders via `os.mkdir_all`, and listing files via `os.ls`.
- **Metadata Inspection**: Interrogating file properties like sizes and types (`os.is_file`/`os.is_dir`).
- **Resource Cleanup**: Ensuring system hygiene by safely removing files (`os.rm`) and folders (`os.rmdir`).

```v
module main

import os

fn main() {
	println('=== V OS & File Utilities Boilerplate ===')

	// 1. Join paths safely across different operating systems using os.join_path
	cwd := os.getwd()
	temp_dir := os.join_path(cwd, 'temp_file_demo')
	println('Target directory: ${temp_dir}')

	// 2. Check if a directory exists, and create it recursively if not
	if !os.exists(temp_dir) {
		println('Directory does not exist. Creating...')
		os.mkdir_all(temp_dir) or {
			eprintln('Failed to create directory: ${err}')
			exit(1)
		}
	}

	target_file := os.join_path(temp_dir, 'sample.txt')
	println('Target file path: ${target_file}')

	// 3. Write data to a file (overwrites if it already exists)
	content_to_write := 'Hello V Developers!\nThis is a sample file created by the OS and File utilities boilerplate.'
	os.write_file(target_file, content_to_write) or {
		eprintln('Failed to write to file: ${err}')
		exit(1)
	}
	println('File written successfully.')

	// 4. Read data from a file back into memory
	read_content := os.read_file(target_file) or {
		eprintln('Failed to read file: ${err}')
		exit(1)
	}
	println('\n--- Read Content ---')
	println(read_content)
	println('--------------------\n')

	// 5. Query file metadata
	size := os.file_size(target_file)
	is_file := os.is_file(target_file)
	is_dir := os.is_dir(temp_dir)
	println('File properties:')
	println('- Size: ${size} bytes')
	println('- Is File: ${is_file}')
	println('- Is Directory: ${is_dir}')

	// 6. List all files and folders inside a directory
	println('\nListing contents of directory: ${temp_dir}')
	files := os.ls(temp_dir) or { []string{} }
	for file in files {
		full_path := os.join_path(temp_dir, file)
		file_type := if os.is_dir(full_path) { '[DIR]' } else { '[FILE]' }
		println('  ${file_type} ${file}')
	}

	// 7. Clean up by deleting the file and directory
	println('\nCleaning up temporary files and directories...')
	os.rm(target_file) or {
		eprintln('Failed to delete file: ${err}')
	}
	os.rmdir(temp_dir) or {
		eprintln('Failed to delete directory: ${err}')
	}
	println('Cleanup completed successfully.')
}
```

---

### String Utilities Boilerplate

_File location: [boilerplate_templates/05_string_utilities/string_utilities.v](file:///Users/codecaine/V-Programming-Comprehensive-Guide/boilerplate_templates/05_string_utilities/string_utilities.v)_

### Lesson: String Utilities Boilerplate

This boilerplate demonstrates how to implement highly useful custom string operations that are not natively built into V's core string type. It highlights UTF-8 rune handling, string tokenization, filtering, and text manipulation.

Key concepts illustrated:

- **UTF-8 Safe String Reversal**: Reversing strings correctly by iterating over `runes` rather than raw bytes, ensuring multi-byte Unicode characters (like emojis) are not corrupted.
- **Title Casing**: Capitalizing the first letter of _each_ word in a sentence (V's native `.capitalize()` only capitalizes the first letter of the entire string).
- **Alphanumeric Palindrome Checking**: Checking if a string is a palindrome while ignoring non-alphanumeric symbols and character casing.
- **Rune-based Truncation**: Cutting off a string at a specific character limit and adding an ellipsis, avoiding splitting UTF-8 byte sequences.
- **Slugification**: Generating clean, URL-friendly slugs (e.g. low-cased, hyphen-separated, special characters stripped) from user-supplied titles.

```v
module main

// reverse_string reverses a string, properly handling multi-byte UTF-8 characters (runes).
fn reverse_string(s string) string {
	runes := s.runes()
	mut rev_runes := []rune{cap: runes.len}
	for i := runes.len - 1; i >= 0; i-- {
		rev_runes << runes[i]
	}
	return rev_runes.string()
}

// title_case capitalizes the first letter of each word in a string.
fn title_case(s string) string {
	words := s.split(' ')
	mut titled_words := []string{cap: words.len}
	for word in words {
		if word.len == 0 {
			titled_words << ''
			continue
		}
		titled_words << word.capitalize()
	}
	return titled_words.join(' ')
}

// is_palindrome checks if a string reads the same forwards and backwards,
// ignoring case and non-alphanumeric characters.
fn is_palindrome(s string) bool {
	// Filter to lowercase alphanumeric characters
	mut clean_chars := []rune{}
	for r in s.to_lower().runes() {
		if (r >= `a` && r <= `z`) || (r >= `0` && r <= `9`) {
			clean_chars << r
		}
	}

	for i in 0 .. clean_chars.len / 2 {
		if clean_chars[i] != clean_chars[clean_chars.len - 1 - i] {
			return false
		}
	}
	return true
}

// truncate cuts off a string at a specified limit (by rune count) and appends an ellipsis.
fn truncate(s string, limit int) string {
	runes := s.runes()
	if runes.len <= limit {
		return s
	}
	return runes[0..limit].string() + '...'
}

// slugify converts a string into a clean, URL-friendly slug.
fn slugify(s string) string {
	mut res := []rune{}
	mut last_was_dash := false

	for r in s.to_lower().runes() {
		if (r >= `a` && r <= `z`) || (r >= `0` && r <= `9`) {
			res << r
			last_was_dash = false
		} else if r == ` ` || r == `-` || r == `_` {
			if !last_was_dash && res.len > 0 {
				res << `-`
				last_was_dash = true
			}
		}
	}

	// Trim trailing dash if any
	mut slug := res.string()
	if slug.ends_with('-') {
		slug = slug[0..slug.len - 1]
	}
	return slug
}

fn main() {
	println('=== V Custom String Utilities Boilerplate ===')

	// 1. Reverse String (UTF-8 safe)
	phrase := 'Hello, 🚀 World!'
	println('Original:  "${phrase}"')
	println('Reversed:  "${reverse_string(phrase)}"')

	// 2. Title Case (capitalizing every word)
	title := 'v programming language complete textbook guide'
	println('\nOriginal:  "${title}"')
	println('Title Case: "${title_case(title)}"')

	// 3. Palindrome Check
	pal1 := 'A man, a plan, a canal: Panama!'
	pal2 := 'Hello Vlang'
	println('\nIs "${pal1}" a palindrome? ${is_palindrome(pal1)}')
	println('Is "${pal2}" a palindrome? ${is_palindrome(pal2)}')

	// 4. Truncation
	long_text := 'V is a statically typed compiled programming language designed for building maintainable software.'
	println('\nOriginal:  "${long_text}"')
	println('Truncated: "${truncate(long_text, 35)}"')

	// 5. Slugify
	title_to_slug := '  Vlang: Concurrency, Channels, & Web APIs!  '
	println('\nOriginal:  "${title_to_slug}"')
	println('Slugified: "${slugify(title_to_slug)}"')
}
```

---

### Math and Statistics Boilerplate

_File location: [boilerplate_templates/06_math_and_stats/math_and_stats.v](file:///Users/codecaine/V-Programming-Comprehensive-Guide/boilerplate_templates/06_math_and_stats/math_and_stats.v)_

### Lesson: Math and Statistics Boilerplate

This template showcases how to perform numerical operations and custom statistical computations on numeric arrays. It implements several custom algorithmic functions that are not built directly into V's basic numeric types or standard math package.

Key concepts illustrated:

- **Descriptive Statistics**: Iterating over elements to calculate min, max, sum, and average (mean) on float slices.
- **Array Sorting & Cloning**: Using `.clone()` to copy data and sorting arrays in-place using `.sort()`.
- **Median, Variance & Deviation**: Custom implementations to calculate distribution variance and standard deviation using V's `math.sqrt()`.
- **Factorial Calculation**: An iterative, overflow-aware custom factorial function using V's `!` result type to report overflow on inputs greater than 20.
- **Fibonacci Sequence Generator**: A custom dynamic programming function generating the first $N$ numbers of the Fibonacci sequence, using `!` to report overflow on inputs greater than 93.
- **Prime Number Checker**: A highly optimized primality test (`is_prime`) using trial division of form $6k \pm 1$.
- **GCD and LCM**: Custom implementations for finding the Greatest Common Divisor (Euclidean algorithm) and Least Common Multiple of two numbers.

```v
module main

import math

// Stats holds the computed statistical properties of a dataset.
struct Stats {
	count    int
	min      f64
	max      f64
	sum      f64
	mean     f64
	median   f64
	variance f64
	std_dev  f64
}

// calculate_stats calculates standard descriptive statistics on a float dataset (not built into V arrays).
fn calculate_stats(numbers []f64) ?Stats {
	if numbers.len == 0 {
		return none
	}

	mut sum := 0.0
	mut min := numbers[0]
	mut max := numbers[0]

	for val in numbers {
		sum += val
		if val < min {
			min = val
		}
		if val > max {
			max = val
		}
	}

	mean := sum / numbers.len

	// Calculate median (requires a sorted copy of the numbers)
	mut sorted := numbers.clone()
	sorted.sort()

	mut median := 0.0
	mid := sorted.len / 2
	if sorted.len % 2 == 0 {
		median = (sorted[mid - 1] + sorted[mid]) / 2.0
	} else {
		median = sorted[mid]
	}

	// Calculate variance and standard deviation
	mut variance_sum := 0.0
	for val in numbers {
		diff := val - mean
		variance_sum += diff * diff
	}
	variance := variance_sum / numbers.len
	std_dev := math.sqrt(variance)

	return Stats{
		count: numbers.len
		min: min
		max: max
		sum: sum
		mean: mean
		median: median
		variance: variance
		std_dev: std_dev
	}
}

// factorial calculates the factorial of a number iteratively, with overflow checks.
fn factorial(n int) !u64 {
	if n < 0 {
		return error('Factorial is not defined for negative numbers')
	}
	if n > 20 {
		return error('Factorial of ${n} overflows 64-bit unsigned integer limit (max n is 20)')
	}
	mut result := u64(1)
	for i in 2 .. n + 1 {
		result *= u64(i)
	}
	return result
}

// fibonacci generates the first n Fibonacci numbers, with overflow checks.
fn fibonacci(n int) ![]u64 {
	if n < 0 {
		return error('Count must be non-negative')
	}
	if n > 93 {
		return error('Fibonacci sequence beyond 93 elements overflows 64-bit unsigned integer limit')
	}
	if n == 0 {
		return []u64{}
	}
	if n == 1 {
		return [u64(0)]
	}
	mut sequence := []u64{cap: n}
	sequence << u64(0)
	sequence << u64(1)
	for i in 2 .. n {
		sequence << sequence[i - 1] + sequence[i - 2]
	}
	return sequence
}

// is_prime checks if a number is prime.
fn is_prime(n int) bool {
	if n <= 1 {
		return false
	}
	if n <= 3 {
		return true
	}
	if n % 2 == 0 || n % 3 == 0 {
		return false
	}
	mut i := 5
	for i * i <= n {
		if n % i == 0 || n % (i + 2) == 0 {
			return false
		}
		i += 6
	}
	return true
}

// gcd computes the Greatest Common Divisor of two integers.
fn gcd(a int, b int) int {
	mut x := math.abs(a)
	mut y := math.abs(b)
	for y != 0 {
		temp := y
		y = x % y
		x = temp
	}
	return x
}

// lcm computes the Least Common Multiple of two integers.
fn lcm(a int, b int) int {
	if a == 0 || b == 0 {
		return 0
	}
	return (math.abs(a) * math.abs(b)) / gcd(a, b)
}

fn main() {
	println('=== V Custom Math & Statistics Boilerplate ===')

	// 1. Descriptive Statistics Demo
	data := [72.5, 81.0, 68.5, 90.0, 75.5, 78.0, 85.5]
	println('Dataset: ${data}')

	stats := calculate_stats(data) or {
		println('Error: Empty dataset')
		return
	}

	println('\nStatistical Results:')
	println('- Count:              ${stats.count}')
	println('- Minimum:            ${stats.min:.2f}')
	println('- Maximum:            ${stats.max:.2f}')
	println('- Sum:                ${stats.sum:.2f}')
	println('- Mean (Average):     ${stats.mean:.2f}')
	println('- Median:             ${stats.median:.2f}')
	println('- Variance:           ${stats.variance:.2f}')
	println('- Standard Deviation: ${stats.std_dev:.2f}')

	// 2. Custom Math Functions Demo
	n := 10
	println('\nCustom Number Functions:')
	
	fact := factorial(n) or {
		eprintln('Error: ${err}')
		u64(0)
	}
	println('- Factorial of ${n}:    ${fact}')

	fib := fibonacci(n) or {
		eprintln('Error: ${err}')
		[]u64{}
	}
	println('- Fibonacci first ${n}: ${fib}')

	test_primes := [7, 12, 19, 25, 97]
	for p in test_primes {
		println('  Is ${p} prime?       ${is_prime(p)}')
	}

	a, b := 24, 36
	println('\nCommon Number Relations:')
	println('- GCD of ${a} and ${b}:    ${gcd(a, b)}')
	println('- LCM of ${a} and ${b}:    ${lcm(a, b)}')
}
```

---

### Array Utilities Boilerplate

_File location: [boilerplate_templates/07_array_utilities/array_utilities.v](file:///Users/codecaine/V-Programming-Comprehensive-Guide/boilerplate_templates/07_array_utilities/array_utilities.v)_

### Lesson: Array Utilities Boilerplate

V's standard array implementation is powerful but focused. This template showcases how to implement useful custom generic utilities for manipulating, comparing, and organizing arrays.

Key concepts illustrated:

- **Generics in V**: Writing reusable algorithms using type parameters `[T]`.
- **Deduplication (`unique`)**: Removing duplicates from an array using containment checks (`!in`).
- **Chunking (`chunk`)**: Partitioning an array into smaller sub-slices of a fixed maximum length.
- **Set Operations (`intersection`, `difference`)**: Calculating overlapping elements and unique elements between two arrays.
- **Flattening (`flatten`)**: Condensing nested 2D slices (`[][]T`) into flat 1D slices (`[]T`).
- **In-place Shuffling (`shuffle`)**: Implementing the Fisher-Yates shuffle algorithm using V's standard `rand` package.

```v
module main

import rand

// unique returns a new array with duplicate elements removed.
fn unique[T](arr []T) []T {
	mut result := []T{cap: arr.len}
	for item in arr {
		if item !in result {
			result << item
		}
	}
	return result
}

// chunk splits an array into sub-arrays of the specified size.
fn chunk[T](arr []T, size int) [][]T {
	if size <= 0 || arr.len == 0 {
		return [][]T{}
	}
	mut result := [][]T{}
	mut current_chunk := []T{}

	for item in arr {
		current_chunk << item
		if current_chunk.len == size {
			result << current_chunk
			current_chunk = []T{}
		}
	}
	if current_chunk.len > 0 {
		result << current_chunk
	}
	return result
}

// intersection returns a new array containing elements present in both arrays.
fn intersection[T](a []T, b []T) []T {
	mut result := []T{}
	for item in a {
		if item in b && item !in result {
			result << item
		}
	}
	return result
}

// difference returns a new array containing elements present in a but not in b.
fn difference[T](a []T, b []T) []T {
	mut result := []T{}
	for item in a {
		if item !in b && item !in result {
			result << item
		}
	}
	return result
}

// flatten flattens a 2D array into a 1D array.
fn flatten[T](arr [][]T) []T {
	mut result := []T{}
	for sub_arr in arr {
		for item in sub_arr {
			result << item
		}
	}
	return result
}

// shuffle randomizes the order of elements in-place using the Fisher-Yates algorithm.
fn shuffle[T](mut arr []T) {
	for i := arr.len - 1; i > 0; i-- {
		j := rand.intn(i + 1) or { 0 }
		temp := arr[i]
		arr[i] = arr[j]
		arr[j] = temp
	}
}

fn main() {
	println('=== V Custom Array Utilities Boilerplate ===')

	// 1. Unique / Deduplication Demo
	duplicates := [1, 2, 2, 3, 1, 4, 3, 5, 2]
	println('Original:    ${duplicates}')
	println('Deduplicated: ${unique(duplicates)}')

	// 2. Chunking Demo
	to_chunk := ['a', 'b', 'c', 'd', 'e', 'f', 'g']
	chunk_size := 3
	println('\nOriginal:    ${to_chunk}')
	println('Chunked (${chunk_size}): ${chunk[string](to_chunk, chunk_size)}')

	// 3. Intersection & Difference Demo
	arr_a := [1, 2, 3, 4, 5]
	arr_b := [4, 5, 6, 7, 8]
	println('\nArray A:     ${arr_a}')
	println('Array B:     ${arr_b}')
	println('Intersection: ${intersection(arr_a, arr_b)}')
	println('Difference:  ${difference(arr_a, arr_b)}')

	// 4. Flattening Demo
	nested := [[1, 2], [3, 4, 5], [6]]
	println('\nNested:      ${nested}')
	println('Flattened:   ${flatten(nested)}')

	// 5. In-place Shuffling Demo
	mut to_shuffle := [10, 20, 30, 40, 50, 60, 70]
	println('\nBefore Shuffle: ${to_shuffle}')
	shuffle(mut to_shuffle)
	println('After Shuffle:  ${to_shuffle}')
}
```

---

### Configuration Management Boilerplate

_File location: [boilerplate_templates/08_config_management/config_management.v](file:///Users/codecaine/V-Programming-Comprehensive-Guide/boilerplate_templates/08_config_management/config_management.v)_

### Lesson: Configuration Management Boilerplate

Most practical applications need configuration values that can come from a file, environment variables, or defaults. This template shows a clean pattern for loading a JSON config, falling back to safe defaults, and saving updated settings.

Key concepts illustrated:

- **Default Configuration**: Establishing a safe baseline before reading external settings.
- **Environment Variable Overrides**: Adapting the app without changing source files.
- **JSON Persistence**: Reading and writing structured config files with `json.decode` and `json.encode`.
- **Practical Separation of Concerns**: Keeping parsing and application logic in dedicated functions.

```v
module main

import json
import os

struct AppConfig {
mut:
	host    string
	port    int
	debug   bool
	retries int
}

fn default_config() AppConfig {
	return AppConfig{
		host:    '127.0.0.1'
		port:    8080
		debug:   false
		retries: 3
	}
}

fn load_config(path string) AppConfig {
	mut cfg := default_config()

	// 1. If path is provided and exists, load config from the JSON file first
	if path != '' && os.exists(path) {
		raw := os.read_file(path) or {
			eprintln('Warning: could not read config file: ${err}')
			''
		}
		if raw != '' {
			cfg = json.decode(AppConfig, raw) or {
				eprintln('Warning: could not decode config file: ${err}')
				cfg
			}
		}
	} else if path != '' {
		println('Config file not found. Using defaults with environment overrides.')
	}

	// 2. Overlay / override with environment variables (crucial for production container envs)
	env_host := os.getenv('APP_HOST')
	if env_host != '' {
		cfg.host = env_host
	}
	env_port := os.getenv('APP_PORT')
	if env_port != '' {
		cfg.port = env_port.int()
	}
	env_debug := os.getenv('APP_DEBUG')
	if env_debug != '' {
		cfg.debug = env_debug == 'true'
	}
	env_retries := os.getenv('APP_RETRIES')
	if env_retries != '' {
		cfg.retries = env_retries.int()
	}

	return cfg
}

fn save_config(path string, cfg AppConfig) {
	data := json.encode(cfg)
	os.write_file(path, data) or { eprint('Failed to save config file: ${err}') }
}

fn main() {
	println('=== V Configuration Management Boilerplate ===')

	config_path := 'app_config.json'
	
	// Ensure we cleanup the generated file on exit
	defer {
		if os.exists(config_path) {
			os.rm(config_path) or {}
			println('Cleaned up temporary config file: ${config_path}')
		}
	}

	mut cfg := load_config(config_path)

	println('Loaded configuration:')
	println('- host: ${cfg.host}')
	println('- port: ${cfg.port}')
	println('- debug: ${cfg.debug}')
	println('- retries: ${cfg.retries}')

	cfg.debug = true
	save_config(config_path, cfg)

	println('Saved configuration to ${config_path}')
}
```

---

### JSON File Store Boilerplate

_File location: [boilerplate_templates/09_json_file_store/json_file_store.v](file:///Users/codecaine/V-Programming-Comprehensive-Guide/boilerplate_templates/09_json_file_store/json_file_store.v)_

### Lesson: JSON File Store Boilerplate

A simple JSON file store is often enough for small tools, prototypes, or local productivity apps. This template shows how to load persisted data from disk, add new records, update them, and save the state again.

Key concepts illustrated:

- **Persistent Data**: Keeping application state across runs with a simple file-backed format.
- **Structured Records**: Storing typed data in a `TodoItem` model.
- **CRUD Style Helpers**: Adding, updating, and listing records without introducing a database dependency.
- **Safe Serialization**: Using `json.encode` and `json.decode` for portability.

```v
module main

import json
import os

struct TodoItem {
	id    int
	title string
mut:
	done bool
}

struct TodoStore {
mut:
	items []TodoItem
}

fn load_store(path string) TodoStore {
	if !os.exists(path) {
		return TodoStore{}
	}

	raw := os.read_file(path) or {
		eprintln('Could not read store: ${err}')
		return TodoStore{}
	}

	decoded := json.decode(TodoStore, raw) or {
		eprintln('Could not decode store: ${err}')
		return TodoStore{}
	}

	return decoded
}

fn save_store(path string, store TodoStore) {
	data := json.encode(store)
	os.write_file(path, data) or { eprintln('Could not save store: ${err}') }
}

fn add_item(mut store TodoStore, title string) TodoItem {
	item := TodoItem{
		id:    store.items.len + 1
		title: title
		done:  false
	}
	store.items << item
	return item
}

fn mark_done(mut store TodoStore, id int) bool {
	for i, item in store.items {
		if item.id == id {
			store.items[i].done = true
			return true
		}
	}
	return false
}

fn list_items(store TodoStore) {
	for item in store.items {
		status := if item.done { '[x]' } else { '[ ]' }
		println('${status} ${item.id}. ${item.title}')
	}
}

fn main() {
	println('=== V JSON File Store Boilerplate ===')

	store_path := 'todos.json'
	
	// Ensure we cleanup the generated file on exit
	defer {
		if os.exists(store_path) {
			os.rm(store_path) or {}
			println('Cleaned up temporary store file: ${store_path}')
		}
	}

	mut store := load_store(store_path)

	add_item(mut store, 'Write a V tutorial')
	add_item(mut store, 'Ship a new boilerplate example')

	println('Current todos:')
	list_items(store)

	if mark_done(mut store, 1) {
		println('Marked todo #1 as done.')
	} else {
		println('Todo #1 was not found.')
	}

	save_store(store_path, store)
	println('Saved todos to ${store_path}')
}
```

---

### Retry and Backoff Boilerplate

_File location: [boilerplate_templates/10_retry_and_backoff/retry_and_backoff.v](file:///Users/codecaine/V-Programming-Comprehensive-Guide/boilerplate_templates/10_retry_and_backoff/retry_and_backoff.v)_

### Lesson: Retry and Backoff Boilerplate

Transient failures are common in distributed systems, network clients, and file operations. This template demonstrates a practical retry loop that delays between attempts and surfaces a final failure only after the allowed number of tries is exhausted.

Key concepts illustrated:

- **Resilient Operations**: Using a generic function structure to wrap any callback in a robust retry cycle.
- **Exponential Backoff**: Multiplying delays by a backoff factor after each failed attempt to reduce load on resources.
- **Random Jitter**: Adding a small, random time variation (jitter) to sleep intervals to prevent synchronized retries (thundering herd problem).
- **Result & Error Propagation**: Leveraging V's `!` result type to return either the successful generic value `T` or propagate the final failure.

```v
module main

import os
import time
import rand

// RetryConfig configures the retry and backoff behavior.
struct RetryConfig {
	attempts      int           = 3
	initial_delay time.Duration = 100 * time.millisecond
	factor        f64           = 2.0
	max_delay     time.Duration = 3 * time.second
	jitter        bool          = true
}

// retry executes the operation `op` up to `cfg.attempts` times.
// It uses exponential backoff with optional random jitter.
fn retry[T](cfg RetryConfig, op fn () !T) !T {
	mut delay := cfg.initial_delay
	for attempt in 1 .. cfg.attempts + 1 {
		res := op() or {
			if attempt == cfg.attempts {
				return error('Operation failed after ${cfg.attempts} attempts. Last error: ${err}')
			}
			
			eprintln('Attempt ${attempt}/${cfg.attempts} failed: ${err}. Retrying in ${delay.milliseconds()}ms...')
			
			// Sleep with optional jitter to prevent thundering herd problems
			mut sleep_dur := delay
			if cfg.jitter {
				jitter_ms := rand.intn(100) or { 0 }
				sleep_dur += jitter_ms * time.millisecond
			}
			time.sleep(sleep_dur)

			// Increase the delay for the next attempt, up to max_delay
			delay = time.Duration(i64(f64(delay) * cfg.factor))
			if delay > cfg.max_delay {
				delay = cfg.max_delay
			}
			continue
		}
		return res
	}
	return error('Unreachable')
}

fn main() {
	println('=== V Retry & Backoff Boilerplate ===')

	// Create a dummy file to read successfully on the 3rd attempt
	file_path := 'temp_retry_demo.txt'
	defer {
		if os.exists(file_path) {
			os.rm(file_path) or {}
		}
	}

	// Spawn a thread to create the file after a short delay
	spawn fn [file_path] () {
		time.sleep(300 * time.millisecond)
		os.write_file(file_path, 'Success: Data retrieved from temporary file!') or {}
		println('[System] File created on disk.')
	}()

	// Define our retry configuration
	cfg := RetryConfig{
		attempts: 4
		initial_delay: 150 * time.millisecond
		factor: 1.5
		jitter: true
	}

	// Define the retriable operation closure
	op := fn [file_path] () !string {
		if !os.exists(file_path) {
			return error('File does not exist yet')
		}
		return os.read_file(file_path)
	}

	// Run the retry loop
	println('Starting resilient file read operation...')
	content := retry[string](cfg, op) or {
		eprintln('Final failure: ${err}')
		return
	}

	println('\nOperation Succeeded!')
	println('Read content: "${content}"')
}
```

---

### HTTP Client Boilerplate

_File location: [boilerplate_templates/11_http_client/http_client.v](file:///Users/codecaine/V-Programming-Comprehensive-Guide/boilerplate_templates/11_http_client/http_client.v)_

### Lesson: HTTP Client Boilerplate

Many real-world tools need to call web services. This template shows a simple yet practical pattern for performing HTTP GET and POST requests, decoding JSON responses, and handling failures with clear errors.

Key concepts illustrated:

- **HTTP Requests**: Using `net.http` for GET and POST requests.
- **JSON POST Headers**: Using `http.Request` directly to configure headers explicitly, including `Content-Type: application/json` for strict APIs.
- **JSON Payloads**: Encoding and decoding structured data with `json`.
- **Error Handling**: Returning and surfacing client errors cleanly.
- **Reusable Helpers**: Keeping request logic in dedicated functions for later reuse.

```v
module main

import net.http
import json

struct PostPayload {
	title   string @[json: 'title']
	body    string @[json: 'body']
	user_id int    @[json: 'userId']
}

struct PostResponse {
	id      int    @[json: 'id']
	title   string @[json: 'title']
	body    string @[json: 'body']
	user_id int    @[json: 'userId']
}

fn fetch_json(url string) !string {
	resp := http.get(url) or { return error('GET request failed: ${err}') }
	if resp.status_code >= 400 {
		return error('Request failed with status ${resp.status_code}')
	}
	return resp.body
}

fn post_json(url string, payload PostPayload) !PostResponse {
	body := json.encode(payload)
	
	// Set Content-Type explicitly for compliance with strict JSON APIs
	mut req := http.Request{
		method: .post
		url: url
		data: body
	}
	req.header.set(.content_type, 'application/json')

	resp := req.do() or { return error('POST request failed: ${err}') }
	if resp.status_code >= 400 {
		return error('Request failed with status ${resp.status_code}')
	}
	return json.decode(PostResponse, resp.body) or { return error('Invalid JSON response') }
}

fn main() {
	println('=== V HTTP Client Boilerplate ===')

	body := fetch_json('https://httpbin.org/get') or {
		eprintln('${err}')
		return
	}
	println('GET response body:')
	println(body)

	response := post_json('https://jsonplaceholder.typicode.com/posts', PostPayload{
		title: 'Ada'
		body: 'Developer'
		user_id: 1
	}) or {
		eprintln('${err}')
		return
	}

	println('\nPOST response:')
	println('id:      ${response.id}')
	println('title:   ${response.title}')
	println('body:    ${response.body}')
	println('user_id: ${response.user_id}')
}
```

---

### CSV Processor Boilerplate

_File location: [boilerplate_templates/12_csv_processor/csv_processor.v](file:///Users/codecaine/V-Programming-Comprehensive-Guide/boilerplate_templates/12_csv_processor/csv_processor.v)_

### Lesson: CSV Processor Boilerplate

CSV files are still common for importing and exporting tabular data. This template shows how to read records from CSV, transform them into typed structs, and write them back out in a clean format.

Key concepts illustrated:

- **CSV Parsing**: Reading rows with `encoding.csv`.
- **Typed Data Models**: Mapping each row into a struct.
- **File I/O**: Reading and writing files with `os` helpers.
- **Practical Data Pipelines**: Transforming input files into processed output files.

```v
module main

import os
import encoding.csv

struct Person {
	name string
	age  int
	city string
}

fn read_people(path string) ![]Person {
	content := os.read_file(path) or { return error('Could not read ${path}: ${err}') }
	mut reader := csv.new_reader(content)

	mut people := []Person{}
	for {
		row := reader.read() or { break }
		if row.len == 0 {
			continue
		}
		if row[0] == 'name' {
			continue
		}
		people << Person{
			name: row[0]
			age:  row[1].int()
			city: row[2]
		}
	}
	return people
}

fn write_people(path string, people []Person) ! {
	mut output := []string{}
	output << 'name,age,city'
	for person in people {
		output << '${person.name},${person.age},${person.city}'
	}
	os.write_file(path, output.join('\n')) or { return error('Could not write ${path}: ${err}') }
}

fn main() {
	println('=== V CSV Processor Boilerplate ===')

	input_path := 'people.csv'
	output_path := 'people_out.csv'

	// Ensure temporary CSV files are cleaned up on exit
	defer {
		if os.exists(input_path) {
			os.rm(input_path) or {}
		}
		if os.exists(output_path) {
			os.rm(output_path) or {}
		}
		println('Cleaned up temporary CSV files.')
	}

	os.write_file(input_path, 'name,age,city\nAlice,30,New York\nBob,25,San Francisco') or {
		eprintln('Could not create sample CSV: ${err}')
		return
	}

	people := read_people(input_path) or {
		eprintln('${err}')
		return
	}

	for person in people {
		println('Loaded: ${person.name} (${person.age}) from ${person.city}')
	}

	write_people(output_path, people) or {
		eprintln('${err}')
		return
	}
	println('Wrote processed CSV to ${output_path}')
}
```

---

### Logging Boilerplate

_File location: [boilerplate_templates/14_logging/logging.v](file:///Users/codecaine/V-Programming-Comprehensive-Guide/boilerplate_templates/14_logging/logging.v)_

### Lesson: Logging Boilerplate

Structured logging is essential for debugging, monitoring, and understanding how an application behaves over time. This template shows a simple logger that writes messages with levels, timestamps, and optional file output.

Key concepts illustrated:

- **Log Levels**: Using `debug`, `info`, `warn`, and `error` categories.
- **Simple Logger Struct**: Encapsulating configuration and behavior in one reusable type.
- **File Output**: Appending log entries to a file for later inspection.
- **Filtering**: Only emitting messages at or above the configured severity level.

```v
module main

import os
import time

enum LogLevel {
	debug
	info
	warn
	error
}

struct Logger {
	log_file string
	level    LogLevel
}

fn (logger Logger) log(level LogLevel, message string) {
	if int(level) < int(logger.level) {
		return
	}

	timestamp := time.now().str()
	prefix := match level {
		.debug { '[DEBUG]' }
		.info { '[INFO]' }
		.warn { '[WARN]' }
		.error { '[ERROR]' }
	}

	line := '${timestamp} ${prefix} ${message}'
	println(line)
	if logger.log_file != '' {
		mut f := os.open_file(logger.log_file, 'a') or {
			eprintln('Failed to open log file: ${err}')
			return
		}
		f.write((line + '\n').bytes()) or {
			eprintln('Failed to append log: ${err}')
		}
		f.close()
	}
}

fn main() {
	println('=== V Logging Boilerplate ===')

	log_path := 'app.log'
	defer {
		if os.exists(log_path) {
			os.rm(log_path) or {}
			println('Cleaned up temporary log file: ${log_path}')
		}
	}

	logger := Logger{
		log_file: log_path
		level:    .info
	}

	logger.log(.debug, 'This debug message is filtered out')
	logger.log(.info, 'Application started')
	logger.log(.warn, 'Configuration value is missing')
	logger.log(.error, 'Something went wrong')
}
```

---

# End of Tutorial

Congratulations! You have completed the comprehensive V Programming tutorial.

```

```
