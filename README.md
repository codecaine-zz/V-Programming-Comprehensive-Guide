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
- [Notes Api](#notes-api)
  - [Notes Api](#notes-api)
- [Language Updates And Stdlib](#language-updates-and-stdlib)
  - [Language Basics Updates](#language-basics-updates)
  - [Standard Library](#standard-library)

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

### Numeric Types

#### Shift Operators

_File location: `primitive_types/02_numeric_types/03_operations_on_numeric_types/03_shift_operators/01_shift_operators.v`_

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

_File location: `primitive_types/02_numeric_types/03_operations_on_numeric_types/03_shift_operators/02_shift_operator_on_range_of_integers.v`_

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

_File location: `primitive_types/02_numeric_types/01_declaring_integers/01_declaring_integers.v`_

This example demonstrates the concepts of **declaring integers**.

```v
x := 1
println(typeof(x).name)
// int

i := 1_000
j := 1000

println(i == j) // true

```

#### Hex Binary Octa Notation Of Declaring Integers

_File location: `primitive_types/02_numeric_types/01_declaring_integers/02_hex_binary_octa_notation_of_declaring_integers.v`_

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

### Rune Type

#### Declare Rune

_File location: `primitive_types/04_rune_type/01_declare_rune.v`_

This example demonstrates the concepts of **declare rune**.

```v
fn main() {
    l := `a`
    println(typeof(l).name)
    // rune
}

```

#### Rune Operations With Strings

_File location: `primitive_types/04_rune_type/02_rune_operations_with_strings.v`_

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

### String Type

#### Declare String

_File location: `primitive_types/03_string_type/01_declare_string.v`_

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

_File location: `primitive_types/03_string_type/01_working_with_strings/01_string_read_only_array_of_bytes.v`_

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

#### Strings Immurable By Default

_File location: `primitive_types/03_string_type/01_working_with_strings/02_strings_immurable_by_default.v`_

This example demonstrates the concepts of **strings immurable by default**.

```v
fn main() {
    s := 'hello'
    // variable s is immutable
    s = 'Hello!'
    // this results in error
}

```

#### Declaring Mutable Strings

_File location: `primitive_types/03_string_type/01_working_with_strings/03_declaring_mutable_strings.v`_

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

_File location: `primitive_types/03_string_type/01_working_with_strings/04_cannot_mutate_string_elements.v`_

This example demonstrates the concepts of **cannot mutate string elements**.

```v
fn main() {
    mut greet := 'good Day'

    greet[0] = 'G' // this results in error
}

```

#### Escape Special Characters

_File location: `primitive_types/03_string_type/02_operations_on_string_types/02_string_manipulation/01_escape_special_characters.v`_

This example demonstrates the concepts of **escape special characters**.

```v
sen := "It's my Daughter's birthday!"
println(sen)

```

#### Declare Raw Strings

_File location: `primitive_types/03_string_type/02_operations_on_string_types/02_string_manipulation/02_declare_raw_strings.v`_

This example demonstrates the concepts of **declare raw strings**.

```v
i := r'hi \how are you/?'
println(i)

```

#### String Concatenation Using Plus Sign

_File location: `primitive_types/03_string_type/02_operations_on_string_types/02_string_manipulation/03_string_concatenation_using_plus_sign.v`_

This example demonstrates the concepts of **string concatenation using plus sign**.

```v
a := 'con'
b := 'cat'
println(a + b)
// concat

```

#### String Concatenation Using Interpolation

_File location: `primitive_types/03_string_type/02_operations_on_string_types/02_string_manipulation/04_string_concatenation_using_interpolation.v`_

This example demonstrates the concepts of **string concatenation using interpolation**.

```v
i := 1
j := 'man army'
println('${i} ${j}')

```

#### Extract Substring From String Literal

_File location: `primitive_types/03_string_type/02_operations_on_string_types/02_string_manipulation/05_extract_substring_from_string_literal.v`_

This example demonstrates the concepts of **extract substring from string literal**.

```v
a := 'Camel'
b := a.substr(0, 3)
println(b)
// Cam

```

#### Split String

_File location: `primitive_types/03_string_type/02_operations_on_string_types/02_string_manipulation/06_split_string.v`_

This example demonstrates the concepts of **split string**.

```v
sp := 'The tiny tiger tied the tie tighter to its tail'
res := sp.split(' ')
// split by space as delimiter
println(typeof(res).name)
// []string
println(res)
// ['The', 'tiny', 'tiger', 'tied', 'the', 'tie', 'tighter', 'to', 'its', 'tail']

```

#### String To Runes Array

_File location: `primitive_types/03_string_type/02_operations_on_string_types/02_string_manipulation/07_string_to_runes_array.v`_

This example demonstrates the concepts of **string to runes array**.

```v
doge_moon := '🐕+🚀=🌑'
doge_moon_runes := doge_moon.runes()
println(doge_moon_runes)
println(typeof(doge_moon_runes).name) // []rune

```

#### Count Sub String Occurences

_File location: `primitive_types/03_string_type/02_operations_on_string_types/02_string_manipulation/08_count_sub_string_occurences.v`_

This example demonstrates the concepts of **count sub string occurences**.

```v
sp := 'The tiny tiger tied the tie tighter to its tail'
println(sp.count('t'))
// 10
println(sp.count('T'))
// 1
println(sp.count('tie'))
// 2
println(sp.count('-'))
// 0

```

#### Check String Contains Substring

_File location: `primitive_types/03_string_type/02_operations_on_string_types/02_string_manipulation/09_check_string_contains_substring.v`_

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

_File location: `primitive_types/03_string_type/02_operations_on_string_types/02_string_manipulation/10_string_contains_is_case_sensitive.v`_

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

_File location: `arrays_and_maps/01_arrays/04_array_operators/01_in_operator_with_array.v`_

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

_File location: `arrays_and_maps/01_arrays/04_array_operators/02_append_array.v`_

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

_File location: `arrays_and_maps/01_arrays/07_array_operations/01_clone_array/01_clone_array.v`_

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

_File location: `arrays_and_maps/01_arrays/07_array_operations/01_clone_array/02_copy_array.v`_

This example demonstrates the concepts of **copy array**.

```v
fn main() {
    r := [1, 2, 3, 4]
    s := unsafe { r }
    println(s)
}

```

#### Map Array Items

_File location: `arrays_and_maps/01_arrays/07_array_operations/04_map_array/01_map_array_items.v`_

This example demonstrates the concepts of **map array items**.

```v
fn main() {
    visitor := ['Tom', 'Ram', 'Rao']
    res := visitor.map('Mr. ' + it)
    println(res)
}

```

#### Map Using Anonymous Funcs On Array

_File location: `arrays_and_maps/01_arrays/07_array_operations/04_map_array/02_map_using_anonymous_funcs_on_array.v`_

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

_File location: `arrays_and_maps/01_arrays/07_array_operations/03_filter_array/01_filter_array.v`_

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

_File location: `arrays_and_maps/01_arrays/07_array_operations/03_filter_array/02_filter_with_anonymous_funcs_on_array.v`_

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

_File location: `arrays_and_maps/01_arrays/07_array_operations/02_sort_array/01_sort_integer_array.v`_

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

_File location: `arrays_and_maps/01_arrays/07_array_operations/02_sort_array/02_sort_string_array.v`_

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

_File location: `arrays_and_maps/01_arrays/01_array_declaration/01_declare_and_initialize.v`_

This example demonstrates the concepts of **declare and initialize**.

```v
fn main() {
    mut sports := ['cricket', 'hockey', 'football']
    println(sports)
}

```

#### Declare Empty Array

_File location: `arrays_and_maps/01_arrays/01_array_declaration/02_declare_empty_array.v`_

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

_File location: `arrays_and_maps/01_arrays/01_array_declaration/03_declare_array_with_len.v`_

This example demonstrates the concepts of **declare array with len**.

```v
fn main() {
    mut i := []int{len: 3}
    println(i)
}

```

#### Declare Array With Init And Len

_File location: `arrays_and_maps/01_arrays/01_array_declaration/04_declare_array_with_init_and_len.v`_

This example demonstrates the concepts of **declare array with init and len**.

```v
fn main() {
    mut j := []int{len: 3, init: 1}
    println(j)
}

```

#### Declare Array With Cap

_File location: `arrays_and_maps/01_arrays/01_array_declaration/05_declare_array_with_cap.v`_

This example demonstrates the concepts of **declare array with cap**.

```v
fn main() {
    mut k := []int{cap: 2}
    println(k)
}

```

#### Define Fixed Size Array

_File location: `arrays_and_maps/01_arrays/05_fixed_size_arrays/01_define_fixed_size_array.v`_

This example demonstrates the concepts of **define fixed size array**.

```v
fn main() {
    mut fix := [4]int{}
    println(fix)
    // [0, 0, 0, 0]
}

```

#### Update Fixed Size Array Elements

_File location: `arrays_and_maps/01_arrays/05_fixed_size_arrays/02_update_fixed_size_array_elements.v`_

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

_File location: `arrays_and_maps/01_arrays/05_fixed_size_arrays/03_determining_type_of_fixed_array.v`_

This example demonstrates the concepts of **determining type of fixed array**.

```v
fn main() {
    mut fix := [4]int{}
    println(typeof(fix).name) // [4]int
}

```

#### Slicing Fixed Size Array Results In Ordinary Array

_File location: `arrays_and_maps/01_arrays/05_fixed_size_arrays/04_slicing_fixed_size_array_results_in_ordinary_array.v`_

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

_File location: `arrays_and_maps/01_arrays/06_multi_dimensional_arrays/01_declaring_multi_dimensional_arrays.v`_

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

_File location: `arrays_and_maps/01_arrays/06_multi_dimensional_arrays/02_updating_multi_dimensional_arrays.v`_

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

_File location: `arrays_and_maps/01_arrays/06_multi_dimensional_arrays/03_updating_multi_dimensional_arrays.v`_

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

_File location: `arrays_and_maps/01_arrays/03_accessing_array_elements/01_access_array_elements_using_index.v`_

This example demonstrates the concepts of **access array elements using index**.

```v
fn main() {
    mut sports := ['cricket', 'hockey', 'football']
    s := sports[1]
    println(s) // hockey
}

```

#### Access Array Elements Using Slices

_File location: `arrays_and_maps/01_arrays/03_accessing_array_elements/02_access_array_elements_using_slices.v`_

This example demonstrates the concepts of **access array elements using slices**.

```v
fn main() {
    mut sports := ['cricket', 'hockey', 'football']
    println(sports[1..3])
}

```

### Maps

#### Explicit Map Initialization

_File location: `arrays_and_maps/02_maps/01_explicit_map_initialization.v`_

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

_File location: `arrays_and_maps/02_maps/02_short_syntax_initialization_of_map.v`_

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

_File location: `arrays_and_maps/02_maps/03_count_key_value_pairs_in_map.v`_

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

_File location: `arrays_and_maps/02_maps/04_value_given_key_of_map.v`_

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

_File location: `arrays_and_maps/02_maps/05_value_given_non_existent_key_of_map.v`_

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

_File location: `arrays_and_maps/02_maps/06_handling_missing_keys_in_map.v`_

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

_File location: `arrays_and_maps/02_maps/07_update_value_given_a_key_in_map.v`_

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

_File location: `arrays_and_maps/02_maps/08_delete_key_value_pair_from_map.v`_

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

_File location: `structs/03_approaches_defining_struct_fields/03_required_fields_in_struct/01_required_fields_example_01.v`_

This example demonstrates the concepts of **required fields example 01**.

```v
pub struct Note {
pub:
    id int
pub mut:
    message string @[required]
    status  bool
}

_ := Note{
    id:     1
    status: false
}
// throws error

```

#### Required Fields Example 02

_File location: `structs/03_approaches_defining_struct_fields/03_required_fields_in_struct/02_required_fields_example_02.v`_

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

_File location: `structs/01_introducing_structs/01_defining_struct/01_defining_struct.v`_

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

_File location: `structs/01_introducing_structs/01_defining_struct/02_initialize_struct_example_1.v`_

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

_File location: `structs/01_introducing_structs/01_defining_struct/03_initialize_struct_example_2.v`_

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

### Orm

#### Orm Demo

_File location: `json_and_orm/02_orm/orm_demo.v`_

This example demonstrates the concepts of **orm demo**.

```v
module main

import sqlite

[table: 'Notes']
struct Note {
    id      int    [primary; sql: serial]
    message string [sql: 'detail'; unique]
    status  bool   [nonull]
}

fn main() {
    // Establishing a connection to the database

    db := sqlite.connect('NotesDB.db') or { panic(err) }
    db.exec('drop table if exists Notes')

    // Creating a table
    sql db {
        create table Note
    }

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
    }

    println(db.last_id() as int)

    // Select records
    all_notes := sql db {
        select from Note
    }

    println(all_notes)
    println('Type of all_notes is : ${typeof(all_notes).name}')

    // Select using order by clause
    notes_sorted := sql db {
        select from Note order by id desc
    }
    println(notes_sorted)

    // Select using the limit clause
    notes_limited := sql db {
        select from Note order by id desc limit 1
    }

    println(notes_limited)
    println('Type returned by select when limit is 1:  ${typeof(notes_limited).name}')

    // Select using where clause
    notes_latest := sql db {
        select from Note where id > 1
    }

    println(notes_latest)

    // Update record(s)
    sql db {
        update Note set status = true where id == 2
    }

    notes_updated := sql db {
        select from Note where id == 2
    }
    println(notes_updated)

    // Delete record(s)
    sql db {
        delete from Note where id == 2
    }

    notes_leftover := sql db {
        select from Note
    }
    println(notes_leftover)

    sql db {
        drop table Note
    }
    println('Dropped the Note table from database!')
}

```

## Notes Api

### Notes Api

#### Main

_File location: `notes_api/notes_api/main.v`_

This example demonstrates the concepts of **main**.

```v
module main

import vweb
import sqlite

struct App {
    vweb.Context
mut:
    db sqlite.DB
}

fn main() {
    db := sqlite.connect('notes.db') or { panic(err) }
    db.exec('drop table if exists Notes')
    sql db {
        create table Note
    }
    http_port := 8000
    app := &App{
        db: db
    }
    vweb.run(app, http_port)
}

```

#### Note

_File location: `notes_api/notes_api/note.v`_

This example demonstrates the concepts of **note**.

```v
module main

import json
import vweb

[table: 'Notes']
struct Note {
    id      int    [primary; sql: serial]
    message string [sql: 'detail'; unique]
    status  bool   [nonull]
}

fn (n Note) to_json() string {
    return json.encode(n)
}

['/notes'; post]
fn (mut app App) create() vweb.Result {
    // malformed json
    n := json.decode(Note, app.req.data) or {
        app.set_status(400, 'Bad Request')
        er := CustomResponse{400, invalid_json}
        return app.json(er.to_json())
    }

    // before we save, we must ensure the note's message is unique
    notes_found := sql app.db {
        select from Note where message == n.message
    }
    if notes_found.len > 0 {
        app.set_status(400, 'Bad Request')
        er := CustomResponse{400, unique_message}
        return app.json(er.to_json())
    }

    // save to db
    sql app.db {
        insert n into Note
    }

    // retrieve the last id from the db to build full Note object
    new_id := app.db.last_id() as int

    // build new note object including the new_id and send it as JSON response
    note_created := Note{new_id, n.message, n.status}
    app.set_status(201, 'created')
    app.add_header('Content-Location', '/notes/$new_id')
    return app.json(note_created.to_json())
}

['/notes/:id'; get]
fn (mut app App) read(id int) vweb.Result {
    n := sql app.db {
        select from Note where id == id
    }

    // check if note exists
    if n.id != id {
        app.set_status(404, 'Not Found')
        er := CustomResponse{400, note_not_found}
        return app.json(er.to_json())
    }

    // found note, return it
    ret := json.encode(n)
    app.set_status(200, 'OK')
    return app.json(ret)
}

['/notes/'; get]
fn (mut app App) read_all() vweb.Result {
    n := sql app.db {
        select from Note
    }

    ret := json.encode(n)
    app.set_status(200, 'OK')
    return app.json(ret)
}

['/notes/:id'; put]
fn (mut app App) update(id int) vweb.Result {
    // malformed json
    n := json.decode(Note, app.req.data) or {
        app.set_status(400, 'Bad Request')
        er := CustomResponse{400, invalid_json}
        return app.json(er.to_json())
    }

    // check if note to be updated exists
    note_to_update := sql app.db {
        select from Note where id == id
    }

    if note_to_update.id != id {
        app.set_status(404, 'Not Found')
        er := CustomResponse{404, note_not_found}
        return app.json(er.to_json())
    }

    // before update, we must ensure the note's message is unique
    // id != id for idempotency
    // message == n.message for unique check
    res := sql app.db {
        select from Note where message == n.message && id != id
    }

    if res.len > 0 {
        app.set_status(400, 'Bad Request')
        er := CustomResponse{400, unique_message}
        return app.json(er.to_json())
    }

    // update the note
    sql app.db {
        update Note set message = n.message, status = n.status where id == id
    }

    // build the updated note using the :id and request body
    // instead of making one more db call
    updated_note := Note{id, n.message, n.status}

    ret := json.encode(updated_note)
    app.set_status(200, 'OK')
    return app.json(ret)
}

['/notes/:id'; delete]
fn (mut app App) delete(id int) vweb.Result {
    sql app.db {
        delete from Note where id == id
    }
    app.set_status(204, 'No Content')
    return app.ok('')
}

```

#### Util

_File location: `notes_api/notes_api/util.v`_

This example demonstrates the concepts of **util**.

```v
module main

import json

struct CustomResponse {
    status  int
    message string
}

fn (c CustomResponse) to_json() string {
    return json.encode(c)
}

const (
    invalid_json   = 'Invalid JSON Payload'
    note_not_found = 'Note not found'
    unique_message = 'Please provide a unique message for Note'
)

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
        println('POST request failed: ${err}')
        return
    }
    println('POST Status Code: ${post_resp.status_code}')
    println('POST Response Body:')
    println(post_resp.body)
}

```

#### Os Operations

_File location: `language_updates_and_stdlib/02_standard_library/02_os_operations/os_operations.v`_

This example demonstrates the concepts of **os operations**.

```v
module main

import os

fn main() {
    filename := 'temp_book_example.txt'
    content := 'V standard library makes OS operations very straightforward.'

    // 1. Writing to a file
    println('Writing text to ${filename}...')
    os.write_file(filename, content) or {
        println('Failed to write file: ${err}')
        return
    }

    // 2. Checking file existence
    if os.exists(filename) {
        println('Confirmed: File exists.')
    }

    // 3. Reading from a file
    read_content := os.read_file(filename) or {
        println('Failed to read file: ${err}')
        return
    }
    println('Read content from file: "${read_content}"')

    // 4. Listing directory contents
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

    // 5. Reading environment variables
    home_dir := os.getenv('HOME')
    println('User HOME directory: ${home_dir}')

    // 6. Executing OS commands
    // os.execute runs command in a subshell and returns a Result struct containing exit_code and output.
    println('Running command "uname"...')
    res := os.execute('uname')
    if res.exit_code == 0 {
        println('Operating System: ${res.output.trim_space()}')
    } else {
        println('Command execution failed with code ${res.exit_code}: ${res.output}')
    }

    // 7. Deleting a file
    println('Removing temporary file...')
    os.rm(filename) or {
        println('Failed to remove file: ${err}')
        return
    }
    println('File removed successfully.')
}

```

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

---

## Official Documentation

For comprehensive and up-to-date information about V, please refer to the official documentation:

- **[V Official Documentation](https://github.com/vlang/v/blob/master/doc/docs.md)** - Complete reference guide for the V programming language
