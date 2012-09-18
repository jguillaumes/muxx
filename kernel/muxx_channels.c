#include <string.h>
#include "kernfuncs.h"
#include "externals.h"
#include "errno.h"

void muxx_iottinit() {
  int i=0;
  
  memcpy(iott->ioteye,"IOTT----",8);
  for(i=0;i<IOT_SENTRIES;i++) {
    iott->iote[i].channel = 0;
    iott->iote[i].driver  = NULL;
    iott->iote[i].status.wflags = 0;
    iott->iote[i].position = 0L;
    iott->iote[i].controller = 0;
    iott->iote[i].unit  = 0;
    iott->iote[i].error  = 0;
    memset(iott->iote[i].reserved, 0, 2);
  }
}

static int muxx_find_free_iote() {
  int i=0,idx=0;

  for(i=0;i<IOT_SENTRIES && idx==0; i++) {
    if (iott->iote[i].driver == NULL) idx=i;
  }
  if (idx == NULL) {
    return ENOAVAIL;
  } else {
    return idx;
  }
}

int muxx_svc_open (ADDRESS fp, char *device, WORD flags) {
  int iotidx = 0;
  PIOTE io = NULL;
  int rc = EOK, rc1=EOK;
  
  rc = muxx_svc_mutex(fp, MUT_CHAN, MUT_ALLOC);
  if (rc == EOK) {
    iotidx = muxx_find_free_iote();
    if (rc == EOK) {
      io = &(iott->iote[iotidx]);
      rc = muxx_locate_dev(device, io);
      if (io->driver->flags.active) {
	if (io->driver->desc->attributes.flags.shareable) {
	  io->channel = iotidx;
	  io->status.wflags = 0;
	  io->status.flags.open = 1;
	  io->position = 0L;
	  io->error = EOK;
	} else {
	  if (!(io->driver->flags.alloc)) {
	    rc = muxx_svc_alloc(fp, io->driver->drvname, DRV_ALLOC);
	    if (rc == EOK) {
	      io->status.flags.dealloc = 1;
	      io->channel = iotidx;
	      io->status.wflags = 0;
	      io->status.flags.open = 1;
	      io->position = 0L;
	      io->error = EOK;
	    }
	  } else {
	    if (io->driver->ownerid != curtcb) {
	      rc = ENOAVAIL;
	    } else {
	      io->channel = iotidx;
	      io->status.wflags = 0;
	      io->status.flags.open = 1;
	      io->position = 0L;
	      io->error = EOK;
	    }
	  }
	}
      } else {
	rc = EOFFLINE;
      }
    }
  }
  rc1 = muxx_svc_mutex(fp, MUT_CHAN, MUT_DEALLOC);
  if (rc1 != EOK) {
    panic("muxx_svc_open: dealloc CHAN mutex");
  }
  return rc;
}

int muxx_svc_close(ADDRESS fp, int channel) {
  return ENOIMPL;
}
