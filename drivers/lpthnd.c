#include "muxxlib.h"
#include "muxxdef.h"

/*
** Line Printer handler task
*/

void lpthnd() {
  for(;;) {
    yield();
  }
}
