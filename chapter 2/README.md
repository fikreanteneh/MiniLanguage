# Chapter 2: Lexical Analysis with Flex

This directory contains three lexical analyzers.

## Lexer Files

### 1. `counter.l`

- **Description**: This lexer counts the number of vowels and consonants in a given input file. It ignores all other characters.

### 2. `number_counter.l`

- **Description**: This lexer identifies and counts positive and negative integers and floating-point numbers (fractions) within a file. It is designed to ignore comments, string literals, and identifiers, focusing only on numerical values.

### 3. `cpp_recognizer.l`

- **Description**: This lexer recognizes basic tokens of the C++ programming language, including keywords, identifiers, constants (integer, float, char), string literals, operators, and preprocessor directives. It also handles single-line and multi-line comments.

## How to Compile and Run

To compile and run any of the `.l` files, you need to have `flex` and a C compiler like `gcc` installed.

### Compilation Steps

1.  **Generate C source code from the `.l` file using Flex:**

    Open your terminal and run the following command, replacing `[lexer_name]` with the name of the file you want to compile (e.g., `counter`, `number_counter`, or `cpp_recognizer`).

    ```bash
    flex -o "MiniLanguage/chapter 2/[lexer_name].c" "MiniLanguage/chapter 2/[lexer_name].l"
    ```

2.  **Compile the generated C code using GCC:**

    This command will create an executable file named `[lexer_name].exe`.

    ```bash
    gcc -o "MiniLanguage/chapter 2/[lexer_name].exe" "MiniLanguage/chapter 2/[lexer_name].c" -lfl
    ```

    _Note: The `-lfl` flag is sometimes required to link the Flex library._

### Execution Steps

Once you have compiled the lexer, you can run it on an input file.

```bash
./"MiniLanguage/chapter 2/[lexer_name].exe" [input_file_path]
```

**Example:**

To compile and run the `cpp_recognizer.l` lexer on a file named `test.cpp`:

1.  **Compile:**

    ```bash
    flex -o "MiniLanguage/chapter 2/cpp_recognizer.c" "MiniLanguage/chapter 2/cpp_recognizer.l"
    gcc -o "MiniLanguage/chapter 2/cpp_recognizer.exe" "MiniLanguage/chapter 2/cpp_recognizer.c" -lfl
    ```

2.  **Run:**
    ```bash
    ./"MiniLanguage/chapter 2/cpp_recognizer.exe" "MiniLanguage/chapter 2/test.cpp"
    ```

The output will be printed to the console, showing the tokens recognized or the counts calculated by the lexer.
