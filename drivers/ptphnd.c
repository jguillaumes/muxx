#include "muxxlib.h"
#include "muxxdef.h"

/*
** Paper tape handler task
*/

void ptphnd() {
  for(;;) {
    yield();
  }
}
