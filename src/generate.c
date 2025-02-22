#include <stdlib.h>

#include <uuid.h>

#include "generate.h"

char *generate() {
  uuid_t binuuid;
  uuid_generate_random(binuuid);

  char* uuid = malloc(UUID_STR_LEN);
  uuid_unparse(binuuid, uuid);

  return uuid;
}
