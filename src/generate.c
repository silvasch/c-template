#include <stdlib.h>

#include <uuid.h>

#include "generate.h"

// Generate a uuid.
// The result should be `free()`'d after use.
char *generate() {
  uuid_t binuuid;
  uuid_generate_random(binuuid);

  char* uuid = malloc(UUID_STR_LEN);
  uuid_unparse(binuuid, uuid);

  return uuid;
}
