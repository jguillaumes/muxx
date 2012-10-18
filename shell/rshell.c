#include <string.h>
#include "config.h"
#include "muxxlib.h"
#include "muxxdef.h"
#include "errno.h"

typedef int (*MAINPROG)(int, char **, char **);

int rshell() {
  char *parm = (char *) TASK_BASE;
  ADDRESS entry = NULL;
  MAINPROG pgm = NULL;
  int rc = 0;
  printf("Loading from device %8s... ", parm);
  rc = load(parm, parm, &entry);
  while (rc == ENOAVAIL) {
    printf("Device not available, sleeping and retrying...\n");
    sleep(1);
    rc = load(parm, parm, &entry);
  }
  printf("load rc=%d\n", rc);
  if (rc >= 0) {
    printf("Task entry point: %o\n", entry);
    pgm = (MAINPROG) entry;
    rc = (*pgm)(0,NULL,NULL);
  }
  while(1) {
    printf("Rshell ended...\n");
    yield();
  }
}
