#include <stdio.h>

#include "hello.h"

int main(int argc, char *argv[]) {
  if (argc != 2) {
    printf("usage: hello <name>\n");
    return 1;
  }
  hello(argv[1]);
  return 0;
}
