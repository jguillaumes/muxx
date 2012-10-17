#include <string.h>
#include "config.h"
#include "muxxlib.h"
#include "muxxdef.h"


typedef int (*MAINPROG)(int, char **, char **);

int rshell() {
  char *parm = (char *) TASK_BASE;
  ADDRESS entry = NULL;
  MAINPROG pgm = NULL;
  int rc = 0;

  rc = load(parm, parm, &entry);
  if (rc >= 0) {
    pgm = (MAINPROG) entry;
    rc = (*pgm)(0,NULL,NULL);
  }
  return rc;
}
