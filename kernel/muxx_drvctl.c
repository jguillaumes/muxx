#include <string.h>
#include <ctype.h>
#include "muxx.h"
#include "muxxdef.h"
#include "kernfuncs.h"
#include "errno.h"
#include "externals.h"


/*
** Find a device driver by name
*/
PDRVCB muxx_find_driver(char *devnam) {
  PDRVCBT drivers = drvcbtaddr;
  PDRVCB  driver = NULL;
  int i=0;
  
  for (i=0; i<MAX_DRV && driver==NULL; i++) {
    if (!(drivers->drvcbt[i].flags.free)) {
      if (memcmp(devnam, drivers->drvcbt[i].drvname, 8) == 0)  {
	driver = &(drivers->drvcbt[i]);
      }
    }
  }
  return driver;
}

/*
** Build a IOT entry from a physical device name
*/
int muxx_locate_pdev(char *devname, PIOTE iote) {
  PDRVCB driver = NULL;
  char wdev[9];
  int i=0,l=0,found=0,rc=EOK;
  BYTE unit=0,controller=0;
  char u,c;

  memset(wdev,0,9);
  memcpy(wdev,devname,8);

  for(i=strlen(wdev); i>=0 && wdev[i]==' '; i--) wdev[i]=0;
  l = i;

  KDPRINTF("Searching dev [%s], length=%d\n", wdev,l);

  for(i=0; i<MAX_DRV && driver==NULL; i++) {
    if (!(drvcbtaddr->drvcbt[i].flags.free)) {
      driver = &(drvcbtaddr->drvcbt[i]);

      // 1: Try whole device name
      if (memcmp(devname,driver->desc->devname,l) == 0) {
	KDPRINTF("Found driver: ");
	KDPUTSTRL(driver->drvname,8);
	controller = 0;
	unit       = 0;
	found = 1;
      } else {
	// 2: Try device + unit
	u = wdev[l];
	if (isdigit((int)u)) {
	  unit  = (BYTE) u;
	  l = l-1;
	  if (memcmp(devname,driver->desc->devname,l) == 0) {
	    controller = 0;
	    found = 1;
	  } else {
	    // 3: Try device + controller + unit
	    c = wdev[l];
	    if (isalpha((int)c)) {
	      controller = (BYTE) c;
	      if (memcmp(devname,driver->desc->devname,l) == 0) {
		found = 1;
	      }
	    }
	  }
	}
      }
    }
  }
  if (found == 1) {
    iote->driver = driver;
    iote->controller = controller;
    iote->unit = unit;
  } else {
    rc = ENOTFOUND;
  }
  return rc;
}

/*
** Build a IOT entry from a logical device name
**
** The logical device translation is still not implemented, so
** this function just calls the physical device locator
*/
int muxx_locate_dev(char *devname, PIOTE iote) {
  return muxx_locate_pdev(devname, iote);
}

/*
** Allocate a device for the current process
*/
int muxx_svc_alloc(ADDRESS fp, char *devnam, WORD op) {
  
  PDRVCB  driver = NULL;
  int rc=0;
  
  rc = EOK;
  driver = muxx_find_driver(devnam);
  if (driver == NULL) {
    rc = ENOTFOUND;
  } else {
    rc = muxx_svc_mutex(fp, MUT_DRV, MUT_ALLOC);
    if (rc == EOK) {
      if (op == DRV_ALLOC) {
	if (!driver->flags.alloc) {
	  driver->ownerid = curtcb;
	  driver->flags.alloc = 1;
	} else {
	  rc = ENOAVAIL;
	}
      } else {
	if (driver->flags.alloc) {
	  if (driver->ownerid != curtcb &&
	      curtcb->privileges.prvflags.operprv) {
	    rc = ENOPRIV;
	  }
	  driver->ownerid = 0;
	  driver->flags.alloc = 0;
	} else {
	  rc = ENOTALLOC;
	}
      }
      muxx_svc_mutex(fp, MUT_DRV, MUT_DEALLOC);
    }
  } 
  return rc;
}

static int muxx_drv_startstop(ADDRESS fp, int op, char *drvnam) {
  PDRVCB driver = NULL;
  int rc = EOK;
  union {
    IOPKT iopkt;
    char  ciopkt[IOPKT_FIXSIZE+0];
  } u_iopkt;

  if (!curtcb->privileges.prvflags.operprv) {
    rc = ENOPRIV;
  } else {
    driver = muxx_find_driver(drvnam);
    if (driver == NULL) {
      rc = ENOTFOUND;
    } else {
      memset(u_iopkt.ciopkt, 0, sizeof(u_iopkt));
      u_iopkt.iopkt.function = op;
      u_iopkt.iopkt.size     = 0;
      rc = muxx_drv_exec(driver, &(u_iopkt.iopkt));
      if (rc==EOK) {
	u_iopkt.iopkt.error = EOK;
	driver->flags.active  = ( op == DRV_START ? 1 : 0);
	driver->flags.stopped = ( op == DRV_START ? 0 : 1);
      } else {
	u_iopkt.iopkt.error = rc;
      }
    }
  }
  return rc;
} 

int muxx_svc_drvstart(ADDRESS fp, char *drvnam) {
  return muxx_drv_startstop(fp, DRV_START, drvnam);
}

int muxx_svc_drvstop(ADDRESS fp, char *drvnam) {
  return muxx_drv_startstop(fp, DRV_STOP, drvnam);
}
