#include "muxx.h"
#include "muxxlib.h"
#include "externals.h"

static char msga[] = ">>> AAA - This is task A - AAA <<<"; 

taska() {

  int n=0;

  for(;;) {
    printf("%s - Called %d times\n", msga, ++n);
//    yield();
  }
}
