# Mini Language Parser

This directory contains the parser implementation for the Mini language, including the lexical analyzer and grammar definitions.

## Prerequisites

- GCC compiler
- Flex (for lexical analysis)
- Bison/Yacc (for grammar parsing)
- Make utility

## Building the Parser

To build the parser, simply run:

```bash
make
```

This will:

1. Generate the lexical analyzer from `lexer.l`
2. Generate the parser from `grammar.y`
3. Compile everything into an executable named `parser`

## Running the Parser

To parse a Mini language source file:

```bash
./parser < input_file.mini
```

For example:

```bash
./parser < mini.mini
```

## Cleaning Up

To remove generated files:

```bash
make clean
```

## Files in this Directory

- `lexer.l`: Lexical analyzer definition
- `grammar.y`: Grammar rules and intermediate code generation
- `mini.mini`: Example Mini language program
- `Makefile`: Build configuration
- `diagrams.excalidraw`: Visual representations of the language structure

## Output

The parser generates intermediate code in three-address format. Each line of output represents a single operation in the form:

```
t1 := t2 op t3
```

Where:

- `t1`, `t2`, `t3` are temporary variables
- `op` is an operation (+, -, \*, /, <, =)

## Example

For the input program in `mini.mini`, the parser will generate corresponding intermediate code that can be used for further compilation steps.
