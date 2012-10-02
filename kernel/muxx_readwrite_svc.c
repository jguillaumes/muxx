#include <string.h>
#include <ctype.h>
#include "muxx.h"
#include "muxxdef.h"
#include "muxxlib.h"
#include "kernfuncs.h"
#include "errno.h"
#include "externals.h"


int muxx_svc_write(ADDRESS fp, PIOTE channel, int size, char *buffer) {
  int i;
  int numchars = 0;
  int bufsiz = 0;
  char *bufaddr;
  int rc=EOK;
  PDRVCB pdrv = NULL;
  PIOPKT iopkt = NULL;

  pdrv = channel->driver;

  if (!channel->status.flags.open) {
    rc = ENOTOPEN;
  } else {
    if (pdrv->desc->attributes.flags.buffered) {
      kprintf("Buffered I/O not implemented yet\n");
      rc = ENOIMPL;
    } else {
      iopkt = (PIOPKT) alloca(sizeof(IOPKT)+1);
      memset(iopkt->param, 0, 4 * sizeof(WORD));
      iopkt->error = EOK;
      iopkt->function = DRV_WRITE;
      iopkt->param[0] = channel->controller;
      iopkt->param[1] = channel->unit;
      iopkt->size = 1;
      rc = EOK;
      for(i=0; i<size && rc>=0; i++) {
	iopkt->ioarea[0] = buffer[i];
	rc = muxx_drv_exec(pdrv, iopkt);
	if (rc > 0) {
	  numchars += rc;
	}
      }
    }
  }
  if (rc < 0) {
    errno = rc;
    channel->status.flags.ioerror = 1;
  }
  else {
    errno = EOK;
    channel->status.flags.ioerror = 0;
  }
  return numchars;
}

int muxx_svc_read(ADDRESS fp, PIOTE channel, int size, char *buffer) {
  int i;
  int numchars = 0;
  int bufsiz = 0;
  char *bufaddr;
  int rc=EOK;
  PDRVCB pdrv = NULL;
  PIOPKT iopkt = NULL;

  pdrv = channel->driver;

  if (!channel->status.flags.open) {
    rc = ENOTOPEN;
  } else {
    if (pdrv->desc->attributes.flags.buffered) {
      kprintf("Buffered I/O not implemented yet\n");
      rc = ENOIMPL;
    } else {
      iopkt = (PIOPKT) alloca(sizeof(IOPKT)+1);
      memset(iopkt->param, 0, 4 * sizeof(WORD));
      iopkt->error = EOK;
      iopkt->function = DRV_READ;
      iopkt->param[0] = channel->controller;
      iopkt->param[1] = channel->unit;
      iopkt->size = 1;
      rc = 0;
      for(i=0; i<size && rc>=0; i++) {
	rc = muxx_drv_exec(pdrv, iopkt);
	if (rc > 0) {
	  buffer[i] = iopkt->ioarea[0];
	  numchars += rc;
	}
      }
    }
  }
  if (rc < 0) {
    if (rc == EEOF) {
      channel->status.flags.eof = 1;
      channel->status.flags.ioerror = 0;
    } else {
      channel->status.flags.ioerror = 1;
    }
    errno = rc;
  }
  else {
    errno = EOK;
    channel->status.flags.ioerror = 0;
    channel->status.flags.eof = 0;
  }
  return numchars;
}
