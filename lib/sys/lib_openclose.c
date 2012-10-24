#include "muxxlib.h"
#include "externals.h"
#include "muxxdef.h"
#include "muxx.h"
#include "errno.h"

PIOTE _open(char *, int);
int _close(PIOTE); 

int open(char *filename, WORD mode) {
  int fd=-1;
  PTUCB ptucb = NULL;
  PIOTE piote = NULL;
  int i=0;

  ptucb = curtcb->taskTUCB;
  errno = EOK;
  for (i=0; i<IOT_TENTRIES && fd==-1; i++) {
    if (ptucb->iote[i] == NULL) {
      fd = i;
    }
  }
  if (fd == -1) {
    errno = ENOSYSRES;
    return ENOSYSRES;
  } 
  
  piote = _open(filename, mode);
  if ( piote == NULL) {
    return errno;
  } else {
    ptucb->iote[fd] = piote;
  }

  return fd;
}

int close(int fd) {
  PTUCB ptucb = NULL;
  int rc=EOK;
  ptucb = curtcb->taskTUCB;

  if (fd < 0 || fd > IOT_TENTRIES) {
    rc = EINVVAL;
    errno =rc;
  } else {
    if (ptucb->iote[fd] == NULL) {
      rc = ENOTOPEN;
      errno = ENOTOPEN;
    } else {
      rc = _close(ptucb->iote[fd]);
      if (rc == EOK) {
	ptucb->iote[fd] = NULL;
      } else {
	errno = rc;
      }
    }
  }
  return rc;
}
