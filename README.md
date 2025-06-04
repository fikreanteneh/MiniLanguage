# MINI Language Scanner

This project implements a **scanner (lexer)** for the **MINI Language** — a simple educational programming language used to teach basic compiler design concepts.

---

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
| `NUM`      | `-?[0-9]+`    | Integer constant |
| `COMMENT`  | `{[^}]*}`  | Comment (ignored) |
| `WHITESPACE` | `[ \t\n]+` | Skipped whitespace |

---

## 🛠️ How to Run

### Prerequisites

- `flex` and `gcc` installed on your system

### Steps

1. Save the Lex file as `mini.l`
2. Generate the lexer:

   ```bash
   flex mini.l
