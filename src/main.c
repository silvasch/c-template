#include <stdio.h>
#include <stdlib.h>

#include "generate.h"

int main(int argc, char *argv[]) {
  if (argc < 2) {
    fprintf(stderr, "usage: generate-uuids <count>\n");
    return 1;
  }

  char *raw_count = argv[1];
  int count = atoi(raw_count);

  for (int i = 0; i < count; i++) {
    char *uuid = generate();
    printf("%s\n", uuid);
    free(uuid);
  }
  
  return 0;
}
