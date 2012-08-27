#include "muxx.h"
#include "muxxlib.h"
#include "externals.h"

static char msga[] = ">>> AAA - This is task A - AAA <<<"; 

taska() {
  for(;;) {
    printf("%s - (%d)\n",msga,(WORD) utimeticks);
    yield();
  }
}
