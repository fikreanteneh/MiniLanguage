#include <stdio.h>

int main() {
    // This is a test C program.
    printf("Hello, World!");
    
    int a = 10;
    int b = -20;
    int c = +30;
    
    float x = 1.23;
    float y = -0.5;
    float z = +5.0e-2;
    float w = 1e5;

    // Numbers in comments should be ignored: -50, 60.5
    /* 
       Also in multi-line comments:
       70, -80.8
    */
   
    printf("Numbers in strings should be ignored: 100, -200.2");
    
    return 0;
} 