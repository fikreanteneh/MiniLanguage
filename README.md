# Mini Language

## MINI Language Scanner

This project implements a **scanner (lexer)** for the **MINI Language**.

- The `mini.mini` file is an example MINI language source file.
- To compile the scanner, use `flex` and `gcc`:

  1. Save the Lex file as `mini.l`
  2. Generate the lexer:

     ```bash
     flex mini.l
     ```

  3. Compile the generated C file:

     ```bash
     gcc lex.yy.c -o mini_scanner
     ```

  4. Run the scanner on a MINI source file:

     ```bash
     ./mini_scanner mini.mini
     ```

- Alternatively, if `mini_scanner` is already compiled, you can test it directly by running:

  ```bash
  ./mini_scanner source_file
  ```

---

## MINI Language Parser

## 🚀 Features

- Lexical analysis for MINI language
- Recognition of all language keywords and symbols
- Skips whitespace and comments
- Token stream output for further compiler phases (e.g., parsing)

---

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

---

## 🧠 Tokens Defined

| Token Name | Pattern | Description |
|------------|---------|-------------|
| `IF`       | `if`       | Beginning of an if-statement |
| `THEN`     | `then`     | Marks the body of an if |
| `ELSE`     | `else`     | Optional part of an if-statement |
| `END`      | `end`      | Ends an if-statement |
| `REPEAT`   | `repeat`   | Starts a repeat loop |
| `UNTIL`    | `until`    | Terminates a repeat loop |
| `READ`     | `read`     | Input a variable |
| `WRITE`    | `write`    | Output a variable or expression |
| `ASSIGN`   | `:=`       | Assignment operator |
| `PLUS`     | `+`        | Addition |
| `MINUS`    | `-`        | Subtraction |
| `TIMES`    | `*`        | Multiplication |
| `DIVIDE`   | `/`        | Integer division |
| `LT`       | `<`        | Less than comparison |
| `EQ`       | `=`        | Equality comparison |
| `SEMICOLON`| `;`        | Statement separator |
| `LPAREN`   | `(`        | Left parenthesis |
| `RPAREN`   | `)`        | Right parenthesis |
| `ID`       | `[a-zA-Z_][a-zA-Z0-9_]*` | Identifier (variable name) |
| `NUM`      | `[0-9]+`    | Integer constant |
| `COMMENT`  | `{[^}]*}`  | Comment (ignored) |
| `WHITESPACE` | `[ \t\n]+` | Skipped whitespace |

---
