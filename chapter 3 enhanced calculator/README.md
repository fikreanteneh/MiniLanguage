# Enhanced Calculator

This is an enhanced calculator implementation using Lex and Yacc (Flex and Bison).

## Features

- Basic arithmetic operations:

  - Addition (+)
  - Subtraction (-)
  - Multiplication (\*)
  - Division (/)
  - Power (^)
  - Parentheses for grouping

- Mathematical functions:

  - Trigonometric functions: sin(), cos(), tan()
  - Logarithm (base 10): log()
  - Factorial: factorial()
  - PI constant

- Variable support:
  - Single letter variables (a-z)
  - Can store both integer and floating-point values
  - Assignment using '=' operator

## Example Usage

```
3 * (4 + 5)        # Basic arithmetic
x = 3 * (4 + 5)    # Variable assignment
y = 5
x + 2*y           # Using variables
2^3/6             # Power operation
sin(1) + cos(PI)  # Trigonometric functions
factorial(5)      # Factorial calculation
log(100)          # Logarithm
tan(0.5)          # Tangent function
```

## Building and Running

1. Make sure you have the required tools installed:

   - GCC compiler
   - Flex (Lex)
   - Bison (Yacc)
   - Make

2. Compile the calculator:

   ```bash
   make
   ```

3. Run the calculator:

   ```bash
   ./calc
   ```

4. To clean up compiled files:
   ```bash
   make clean
   ```

## Implementation Details

- The calculator uses a lexer (calc.l) to tokenize input
- The parser (calc.y) handles the grammar and calculations
- Variables are stored in a symbol table (sym array)
- Floating-point precision is supported for all operations
- Error handling for invalid input

## Notes

- Trigonometric functions use radians
- Logarithm is base 10
- Factorial only works with non-negative integers
- Variables are case-sensitive and must be single letters (a-z)
