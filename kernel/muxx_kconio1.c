#include "kernfuncs.h"
#include "muxxlib.h"

int kputoct(WORD w) {
  char buff[7];
  otoa(w, buff);
  return kputstr(buff,6);
}
