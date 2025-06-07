# Compiler Design Project

This repository contains implementations of various compiler components and language processors, including the MINI Language compiler and assignments from chapters 2 and 3.

## 🏗️ Project Structure

- **mini language compiler/** - The MINI Language compiler implementation
- **chapter 2/** - Lexical analysis assignments
  - C++ token recognizer
  - Number counter implementation
  - Counter implementation
- **chapter 3 enhanced calculator/** - Enhanced calculator implementation using Flex and Bison

## 📚 Project Components

### Chapter 2: Lexical Analysis

Contains implementations of various lexical analyzers:

- **cpp_recognizer.l**: A lexical analyzer for C++ tokens
- **number_counter.l**: Implementation for counting numbers in input
- **counter.l**: A basic counter implementation
- Test files for validating the implementations

### Chapter 3: Enhanced Calculator

An implementation of a calculator using Flex and Bison that includes:

- **calc.l**: Lexical analyzer for calculator expressions
- **calc.y**: Parser for calculator expressions
- **Makefile**: Build configuration
- Comprehensive documentation in its README

### Mini Language Compiler

The main compiler implementation that includes:

- Scanner (Lexer)
- Parser
- Syntax Tree Generation
- Error Handling

## 🚀 Features

### MINI Language Features

- Lexical analysis for MINI language
- Recognition of all language keywords and symbols
- Skips whitespace and comments
- Token stream output for further compiler phases
- Syntax tree generation
- Error handling and reporting

### Chapter 2 Features

- C++ token recognition
- Number counting and analysis
- Basic counter implementation
- Test suite for validation

### Chapter 3 Features

- Arithmetic expression parsing
- Operator precedence handling
- Error detection and reporting
- Build system integration

## 📜 MINI Language Overview

### Supported Features

- **Integer variables only**
- **No procedures or declarations**
- **Control structures**: `if-then[-else]-end`, `repeat-until`
- **I/O operations**: `read`, `write`
- **Arithmetic operations**: `+`, `-`, `*`, `/`
- **Boolean comparisons**: `<`, `=`
- **Comments**: `{ ... }` (non-nestable)
- **Expressions**: integers, variables, and arithmetic/boolean expressions

## 🧠 Tokens Defined

| Token Name   | Pattern                  | Description                      |
| ------------ | ------------------------ | -------------------------------- |
| `IF`         | `if`                     | Beginning of an if-statement     |
| `THEN`       | `then`                   | Marks the body of an if          |
| `ELSE`       | `else`                   | Optional part of an if-statement |
| `END`        | `end`                    | Ends an if-statement             |
| `REPEAT`     | `repeat`                 | Starts a repeat loop             |
| `UNTIL`      | `until`                  | Terminates a repeat loop         |
| `READ`       | `read`                   | Input a variable                 |
| `WRITE`      | `write`                  | Output a variable or expression  |
| `ASSIGN`     | `:=`                     | Assignment operator              |
| `PLUS`       | `+`                      | Addition                         |
| `MINUS`      | `-`                      | Subtraction                      |
| `TIMES`      | `*`                      | Multiplication                   |
| `DIVIDE`     | `/`                      | Integer division                 |
| `LT`         | `<`                      | Less than comparison             |
| `EQ`         | `=`                      | Equality comparison              |
| `SEMICOLON`  | `;`                      | Statement separator              |
| `LPAREN`     | `(`                      | Left parenthesis                 |
| `RPAREN`     | `)`                      | Right parenthesis                |
| `ID`         | `[a-zA-Z_][a-zA-Z0-9_]*` | Identifier (variable name)       |
| `NUM`        | `[0-9]+`                 | Integer constant                 |
| `COMMENT`    | `{[^}]*}`                | Comment (ignored)                |
| `WHITESPACE` | `[ \t\n]+`               | Skipped whitespace               |
