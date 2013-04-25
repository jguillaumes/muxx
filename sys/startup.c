#include "muxx.h"
#include "muxxlib.h"

main() {
  int rc = 0;
  
  printf("Loading task TASKA...");
  rc = loadprc("TASKA   ", USR_TASK+TSZ_SMALL, "PT", 0);
  printf(" rc=%d\n",rc);

  printf("Loading task TASKB...");
  rc = loadprc("TASKB   ", USR_TASK+TSZ_SMALL, "PT", 0);
  printf(" rc=%d\n",rc);  

  printf("Loading task TASKC...");
  rc = loadprc("TASKC   ", USR_TASK+TSZ_SMALL, "PT", 0);
  printf(" rc=%d\n",rc);

  printf("Loading task TASKD...");
  rc = loadprc("TASKD   ", USR_TASK+TSZ_BIG, "PT", 0);
  printf(" rc=%d\n",rc);

  printf("Suspending STARTUP task...");
  suspend(0);
}
