#include <stdio.h>
#include "muxx.h"
#include "muxxlib.h"
#include "externals.h"


static char msga[] = ">>> CCC - This is task C - CCC <<<"; 

extern WORD toptask;
extern WORD end;

main() {
  int n=0;
 
  for(;;) {
    printf("TASC A - Top of code: %o, top of task: %o\n", &end, &toptask); 
    // yield();
  }
}
