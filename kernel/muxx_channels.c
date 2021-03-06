// #include <string.h>
#include "kernfuncs.h"
#include "externals.h"
#include "errno.h"

void muxx_iottinit() {
  int i=0;
  
  memcpy(iott->ioteye,"IOTT----",8);
  for(i=0;i<IOT_SENTRIES;i++) {
    memset(&(iott->iote[i]),0,IOT_SIZE);
  }
}

static int muxx_find_free_iote() {
  int i=0,idx=-1;

  for(i=0;i<IOT_SENTRIES && idx==-1; i++) {
    if (iott->iote[i].driver == NULL) idx=i;
  }
  if (idx == -1) {
    return ENOSYSRES;
  } else {
    KDPRINTF("Using IOTE entry %d\n", idx);
    return idx;
  }
}

PIOBUF muxx_allocate_iobuffer(int size) {
  errno = ENOIMPL;
  return NULL;
}

int muxx_deallocate_iobuffer(PIOBUF pbuf) {
    errno = ENOIMPL;
    kputstrzl("Channel buffer allocation not implemented");
    return ENOIMPL;
}

PIOTE muxx_svc_open (ADDRESS fp, char *device, WORD flags) {
  int iotidx = 0;
  PIOTE io = NULL;
  int rc = EOK, rc1=EOK;

  rc = muxx_svc_mutex(fp, MUT_CHAN, MUT_ALLOC);
  if (rc == EOK) {
    iotidx = muxx_find_free_iote();
    if (iotidx >= 0) {
      io = &(iott->iote[iotidx]);
      rc = muxx_locate_dev(device, io);
      if (rc == EOK) {
	if (io->driver->flags.active) {
	  io->status.wflags = 0;
	  io->error = EOK;
	  io->position = 0L;
	  if (!io->driver->desc->attributes.flags.shareable) {
	    if (!(io->driver->flags.alloc)) {
	      rc = muxx_svc_alloc(fp, io->driver->drvname, DRV_ALLOC);
	      if (rc == EOK) {
		io->status.flags.dealloc = 1;
	      } else {
		io->error = rc;
	      }
	    } else {
	      if (io->driver->ownerid != curtcb) {
		rc = ENOAVAIL;
		io->error = ENOAVAIL;
	      }
	    }
	  }
	  if (io->error == EOK) {
	    if (io->driver->desc->attributes.flags.buffered == 1) {
	      io->buffaddr = muxx_allocate_iobuffer(io->driver->desc->defbufsiz);
	      if (io->buffaddr == NULL) {
		rc = errno;
	      } else {
		io->status.flags.open = 1;
	      }
	    } else {
	      io->status.flags.open = 1;
	    }
	  }
	} else {
	  rc = EOFFLINE;
	}
      }
    } else {
      KDPRINTF("Error finding free IOTE: %d\n", iotidx);
      rc = iotidx;
    }
  }
  rc1 = muxx_svc_mutex(fp, MUT_CHAN, MUT_DEALLOC);
  if (rc1 != EOK) {
    kprintf("panic - CHAN: %d\n", rc1);
    panic("muxx_svc_open: dealloc mutex");
  }
  if (rc == EOK) {
    return io;
  } else {
    errno = rc;
    return NULL;
  }
}

int muxx_svc_close(ADDRESS fp, PIOTE io) {
  int iotidx = 0;
  int rc = EOK, rc1=EOK;
  int i=0;

  rc = muxx_svc_mutex(fp, MUT_CHAN, MUT_ALLOC);
  if (rc==EOK) {
    if (io->status.flags.open) {
      if (io->status.flags.dealloc) {
	rc = muxx_svc_alloc(fp, io->driver->drvname, DRV_DEALLOC);
	if (rc != EOK) {
	  kprintf("close: %d\n", rc);
	  panic("muxx_svc_close");
	} 
      }
      io->status.flags.open = 0;
      io->driver = NULL;
      io->controller = 0;
      io->unit = 0;
      if (io->buffaddr != NULL) {
	rc = muxx_deallocate_iobuffer(io->buffaddr);
	if (rc != EOK) {
	  kprintf("Error deallocating IOBuffer => Memory leak!!\n");
	  rc = EOK;
	}
      }
    } else {
      rc = ENOTOPEN;
    }
  } 
  rc1 = muxx_svc_mutex(fp, MUT_CHAN, MUT_DEALLOC);
  if (rc1 != EOK) {
    kprintf("panic - CHAN: %d\n", rc1);
    panic("muxx_svc_close: dealloc mutex");
  }

  errno = rc;
  return rc;
}
