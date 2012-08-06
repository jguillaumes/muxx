#include "types.h"
#include "muxxlib.h"

int kmsgaddr(char *message, char *addrptr, WORD address, int const size) {
  otoa(address, addrptr);
  return kputstr(message, size);
}
