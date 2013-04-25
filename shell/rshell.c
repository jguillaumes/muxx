// #include <string.h>
#include "config.h"
#include "muxxlib.h"
#include "muxxdef.h"
#include "errno.h"

typedef int (*MAINPROG)(int, char **, char **);
#define NULL	0x0

int rshell() {
  char *parm = (char *) TASK_BASE;
  ADDRESS entry = NULL;
  MAINPROG pgm = NULL;
  int rc = 0;


  printf("Loading from device %8s...\n", parm);
  rc = load(parm, parm, &entry);
  while (rc == ENOAVAIL || rc == ENOSYSRES) {
    printf("Device not available (%d), sleeping and retrying...\n", rc);
    sleep(1);
    rc = load(parm, parm, &entry);
  }
  if (rc >= 0) {
    printf("Load OK, %d bytes loaded.\n", rc);
    printf("Task entry point: %o\n", entry);
    pgm = (MAINPROG) entry;
    rc = (*pgm)(0,NULL,NULL);
  } else {
    printf("Load failed, rc=%d\n", rc);
  }
  while(1) {
    // TO-DO Write task exit code here
    // printf("Rshell ended...\n");
    printf("Task exited - we don't know to handle that yet!\n");
    printf("Suspending this task...");
    suspend(NULL);
  }
}
