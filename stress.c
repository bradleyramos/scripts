// Compile yourself. gcc stress.c -o stress.exe

#include <stdio.h>
#include <stdlib.h>

int main (int argc, char** argv) {
  int i = 2;
  while (i != 0) {
    i *= i;
    i /= i;
    i += 1;
  }
}
  
