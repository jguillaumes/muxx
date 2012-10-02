#include "muxx.h"
#include "muxxdef.h"
#include "errno.h"
#include "config.h"
#include "kernfuncs.h"
#include "muxxlib.h"
#include "externals.h"
#include <string.h>

typedef int (*SVC)(int, ADDRESS, ...);
typedef int (*DRV)(int, void *);

static int muxx_svc_muxxhlt(ADDRESS) __attribute__ ((noreturn));

struct SVC_S {
  SVC svc;
  int nparams;
};

static int muxx_svc_drvreg(ADDRESS fp, char *name,  
			   PDRVDESC descriptor, ADDRESS handler) {
  kputstr(name,8);
  kprintf(", descr: %o, hnd: %o\n", descriptor, handler);

  DRVCBT *drvt = (DRVCBT *) drvcbtaddr;
  int i;
  int rc;
  int done=0;
  WORD *vectaddr,*pswaddr;

  /*
  ** Check DRVCBT eyecatcher
  */
  if (memcmp(drvt, "DRVCBT--",8) != 0) {
    panic("Invalid DRVCBT eyecatcher");
  }
  
  /*
  ** The caller process must be privileged
  */
  if (!curtcb->privileges.prvflags.operprv) {
    return ENOPRIV;
  }

  /*
  ** Find a DRVCBT free slot and use it
  */
  rc = ETCTFULL;                             // Be pessimistic
  for (i=0;i<MAX_DRV && !done; i++) {
    if (drvt->drvcbt[i].flags.free) {
      rc = EOK;
      memcpy(drvt->drvcbt[i].drvname,name,8);
      drvt->drvcbt[i].desc = (PDRVDESC) descriptor;
      drvt->drvcbt[i].flags.free = 0;	     
      drvt->drvcbt[i].flags.loaded = 1;	     
      drvt->drvcbt[i].flags.stopped = 1;
      drvt->drvcbt[i].taskid = handler;
      kprintf("Registered device driver: ");
      kputstr(name,8);
      kprintf(" task handler address: %o\n", handler);
      /*
      ** Install interrupt service routines
      ** (but do not enable interrupts)
      */
      for (i=0;i < descriptor->numisr; i++) {
	vectaddr = (WORD *) descriptor->isrtable[i].vector;
	pswaddr = vectaddr + 1;
	*vectaddr = (WORD) descriptor->isrtable[i].handler;
	*pswaddr =  (WORD) descriptor->isrtable[i].ilevel << 5;
	kprintf("\tVector %o, Handler %o, IRQ level %o\n", vectaddr, 
		*vectaddr, ((*pswaddr) & 0x00E0) >> 5);
      }
      done = 1;
    }
    kprintf("\n");
  }
  return rc;
}


static int muxx_svc_gettpi(ADDRESS fp, WORD pid, PTCB area) {
  PTCB source = NULL;
  if (pid == 0) {
    source = curtcb;
  } else {
    return ENOIMPL;
  }
  memcpy(area, source, sizeof(TCB));
  return EOK;
}

static int muxx_svc_conputc(ADDRESS fp, char c) {
 return kconputc(c);
}

static int muxx_svc_muxxhlt(ADDRESS fp) {
  asm("halt");
  asm("halt");  
  asm("halt");
  return 0;
}

static int muxx_svc_suspend(ADDRESS fp, PTCB task) {
  PTCB theTask = NULL;
  int curpl=0;

  if (task == NULL) {
    theTask = curtcb;
  } else {
    theTask = task;
  }
  if (curtcb->privileges.prvflags.operprv ||
      (curtcb->uic == theTask->uic)) {
    curpl = setpl7();
    muxx_qRemoveTask(readyq, theTask);
    theTask->status = TSK_SUSP;
    muxx_qAddTask(suspq, theTask);
    if (theTask == curtcb) {
      copytrapfp(fp);
      copyMMUstate();
      muxx_schedule();
    }
    setpl(curpl);
  } else {
    return ENOPRIV;
  }
  return EOK;
}

static int muxx_svc_yield(ADDRESS fp) {
  setpl7();                 
  curtcb->status = TSK_READY;
  muxx_qAddTask(readyq, curtcb);
  copytrapfp(fp);
  copyMMUstate();
  muxx_schedule();
  panic("YIELD returning!");            // Should not execute this
  return EINVVAL;
}

static int muxx_unimpl(ADDRESS fp) {
  return ENOIMPL;
}

static int muxx_svc_exit(ADDRESS fp, WORD rc) {
    rc = muxx_unimpl(fp);
}

static int muxx_svc_abort(ADDRESS fp, WORD rc) {
    rc = muxx_unimpl(fp);
}

int muxx_svc_mutex(ADDRESS fp, WORD mutex, WORD op) {
  BYTE *mutexes = &muxx_mutexes;
  int rc=0;
  int curpl;

  KDPRINTF("Mutex service called, mutex=%d, op=%d, pid=%o\n", mutex,op,curtcb->pid);

  if (mutex < 0 || mutex > MUT_MUTEXES) {
    return EINVVAL;
  }

  switch(op) {
  case MUT_READ:
    return mutexes[mutex];
  case MUT_ALLOC:
    curpl = setpl7();
    if (mutexes[mutex] == 0) {
      mutexes[mutex] = curtcb->pid;
      setpl(curpl);
      rc = EOK;
    } else {
      rc = ELOCKED;
    }
    break;
  case MUT_DEALLOC:
    curpl = setpl7();
    if (mutexes[mutex] == curtcb->pid) {
      mutexes[mutex] = 0;
      setpl(curpl);
      rc = EOK;
    } else {
      rc = ELOCKED;
    }
    break;
  default:
    return EINVVAL;
  }
  KDPRINTF("muxx_mutex returning %d, pid %o\n", rc, curtcb->pid);
  return rc;
}


int muxx_systrap_handler(int numtrap, ADDRESS fp, WORD p1, WORD p2, 
			                          WORD p3, WORD p4) {
  static struct SVC_S trap_table[] = {
    {(SVC) muxx_svc_muxxhlt,0}, //  0;
    {(SVC) muxx_svc_creprc, 4},	  //  1;
    {(SVC) muxx_unimpl, 0},     //  2:
    {(SVC) muxx_unimpl, 0},	  //  3:
    {(SVC) muxx_unimpl, 0},	  //  4:
    {(SVC) muxx_unimpl, 0},	  //  5:
    {(SVC) muxx_unimpl, 0},	  //  6:
    {(SVC) muxx_unimpl, 0},	  //  7:
    {(SVC) muxx_svc_suspend, 1},  //  8:
    {(SVC) muxx_unimpl, 0},	  //  9:
    {(SVC) muxx_svc_open, 2},	  // 10:
    {(SVC) muxx_svc_close, 1},	  // 11:
    {(SVC) muxx_unimpl, 0},	  // 12:
    {(SVC) muxx_svc_read, 3},	  // 13:
    {(SVC) muxx_svc_write, 3},	  // 14:
    {(SVC) muxx_unimpl, 0},	  // 15:
    {(SVC) muxx_unimpl, 0},	  // 16:
    {(SVC) muxx_unimpl, 0},	  // 17:
    {(SVC) muxx_unimpl, 0},	  // 18:
    {(SVC) muxx_unimpl, 0},	  // 19:
    {(SVC) muxx_unimpl, 0},	  // 20:
    {(SVC) muxx_unimpl, 0},	  // 21:
    {(SVC) muxx_unimpl, 0},	  // 22:
    {(SVC) muxx_unimpl, 0},	  // 23:
    {(SVC) muxx_unimpl, 0},	  // 24:
    {(SVC) muxx_svc_mutex,2},     // 25     
    {(SVC) muxx_svc_yield,0},     // 26
    {(SVC) muxx_svc_gettpi,2},    // 27
    {(SVC) muxx_svc_exit,1},      // 28
    {(SVC) muxx_svc_abort,1},     // 29
    {(SVC) muxx_svc_alloc,2},     // 30

    {(SVC) muxx_svc_drvreg, 2},	  // KRNL 01
    {(SVC) muxx_unimpl, 0},	  // KRNL 02
    {(SVC) muxx_svc_drvstart, 2}, // KRNL 03
    {(SVC) muxx_svc_drvstop, 2},  // KRNL 04
    {(SVC) muxx_unimpl, 0},	  // KRNL 05
    {(SVC) muxx_svc_conputc, 1},  // KRNL 06
    {(SVC) muxx_unimpl, 0}        // KRNL 07
  };	
  
  static int trap_table_entries = sizeof(trap_table)/sizeof(void *());	

  //  struct SVC_S *syssvc;
  // int (*svcimpl)();
  int rc=0;

 
  if (numtrap < 0 || numtrap > trap_table_entries) {
    return(EINVVAL);
  }

  // syssvc = &(trap_table[numtrap]);
 
  // Temporary fix for gas assembler bug (it does not assemble
  // correctly JSR PC,@(R0) ).
  // svcimpl = syssvc->svc;
  // rc = (*svcimpl)(syssvc->nparams, args);

  switch(numtrap) {
  case SRV_OPEN:
    rc= muxx_svc_open(fp, (char *) p1, (WORD) p2);
    break;
  case SRV_CLOSE:
    rc = muxx_svc_close(fp, (PIOTE) p1);
    break;
  case SRV_WRITE:
    rc = muxx_svc_write(fp, (PIOTE) p1, (int) p2, (char *) p3);
    break;
  case SRV_READ:
    rc = muxx_svc_read(fp, (PIOTE) p1, (int) p2, (char *) p3);
    break;
  case SRV_EXIT:
    rc = muxx_svc_exit(fp, (WORD) p1);
    break;
  case SRV_ABORT:
    rc = muxx_svc_abort(fp, (WORD) p1);
    break;
  case KRN_HALT:
    rc = muxx_svc_muxxhlt(fp);
    break;
  case KRN_PUTCON:
    rc = muxx_svc_conputc(fp, (char) p1);
    break;
  case SRV_CREPRC:
    rc = muxx_svc_creprc(fp, (char *) p1,(int) p2,(ADDRESS) p3,(WORD) p4);
    break;
  case SRV_SUSPEND:
    rc = muxx_svc_suspend(fp, (PTCB) p1);
    break;
  case SRV_YIELD:
    rc = muxx_svc_yield(fp);
    break;
  case SRV_GETTPI:
    rc = muxx_svc_gettpi(fp, (WORD) p1, (PTCB) p2);
    break;
  case SRV_MUTEX:
    rc = muxx_svc_mutex(fp, (WORD) p1, (WORD) p2);
    break;
  case SRV_ALLOC:
    rc = muxx_svc_alloc(fp, (char *) p1, (WORD) p2);
    break;
  case KRN_DRVREG:
    rc = muxx_svc_drvreg(fp, (char *) p1, (ADDRESS) p2, (PTCB) p3);
    break;    
  case KRN_DRVSTART:
    rc = muxx_svc_drvstart(fp, (char *) p1);
    break;
  case KRN_DRVSTOP:
    rc = muxx_svc_drvstop(fp, (PDRVCB) p1);
    break;
  default:
    kprintf("Called unimplemented SYSCALL %d\n", numtrap);
    rc = muxx_unimpl(fp);
  }
  return rc;
}
