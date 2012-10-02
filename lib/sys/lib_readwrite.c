#include "muxx.h"
#include "muxxdef.h"
#include "externals.h"

int write(int fd, int size, char *buffer) {
  PIOTE iote;

  iote = curtcb->taskTUCB->iote[fd];
  return _write(iote, size, buffer);
}

int read(int fd, int size, char *buffer) {
  PIOTE iote;

  iote = curtcb->taskTUCB->iote[fd];
  return _read(iote, size, buffer);
}
