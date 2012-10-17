#include <string.h>
#include "types.h"
#include "config.h"
#include "muxx.h"
#include "muxxdef.h"
#include "kernfuncs.h"
#include "errno.h"
#include "externals.h"
#include "kernfuncs.h"

#define PAGESIZE 8192


int muxx_svc_xcopy(ADDRESS fp, WORD dstpid, WORD dstaddr, WORD srcpid, WORD srcaddr, WORD size){
  int rc = EOK;
  PTCB srctcb,dsttcb;
  WORD *pdr5,*pdr6,*par5,*par6;
  WORD oldpdr5,oldpdr6,oldpar5,oldpar6;
  WORD oldpsw;
  WORD spagenum,dpagenum;
  WORD soffset,doffset;
  int n;
  BYTE *sbyte, *dbyte;

  if (size == 0) return rc;             // Nothing to do

  if (dstpid == 0 && srcpid == 0) {     // Same process, just a memcpy
    memcpy(dstaddr, srcaddr, size);
  }
   
  oldpsw = setpl7();
  
  pdr5 = (WORD *) MMU_KISDR5;
  pdr6 = (WORD *) MMU_KISDR6;
  par5 = (WORD *) MMU_KISAR5;
  par6 = (WORD *) MMU_KISAR6;

  oldpdr5 = *pdr5;
  oldpdr6 = *pdr6;
  oldpar5 = *par5;
  oldpar6 = *par6;

  if (srcpid == 0) {
    srctcb = curtcb;
  } else {
    srctcb = muxx_findtcb(srcpid);
    if (srctcb == NULL) rc = ENOPID;
  }

  if (dstpid == 0) {
    dsttcb = curtcb;
  } else {
    dsttcb = muxx_findtcb(dstpid);
    if (dsttcb == NULL) rc = ENOPID;
  }

  /*
  ** Permission checking for source task
  */
  if (srctcb->uic == curtcb->uic ||            // Same owner
      curtcb->privileges.prvflags.operprv ||   // Oper privilege
      curtcb->privileges.prvflags.auditprv) {  // Audit privilege
    /*
    ** Permission checking for dest. task
    */
    if (dsttcb->uic == curtcb->uic ||          // Same owner
	curtcb->privileges.prvflags.operprv) { // Oper privilege
      rc = EOK;
    } else {
      rc = ENOPRIV;
    }
  } else {
    rc = ENOPRIV;
  }

  if (rc == EOK) {

    spagenum = ( srcaddr & 0xC000 ) >> 14;
    soffset  = ( srcaddr & 0x3FFF );
    *par5 = spagenum;
    
    dpagenum = ( dstaddr & 0xC000 ) >> 14;
    doffset  = ( dstaddr & 0x3FFF );
    *par6 = dpagenum;
    
    *pdr5 = PDR_ACC_RW | PDR_SIZ_8K | PDR_DIR_UP;
    *pdr6 = *pdr5;
    
    sbyte = (BYTE *) (WORD) (5*PAGESIZE + soffset);
    dbyte = (BYTE *) (WORD) (6*PAGESIZE + doffset);
    for (n=0; n<size; n++) {
      if (soffset >= 8192) {
	par5    += 0200;
	soffset -= 8192;
	sbyte = (BYTE *) (WORD) (5*PAGESIZE + soffset);
      }
      if (doffset >= 8192) {
	par6    += 0200;
	doffset -= 8192;
	dbyte = (BYTE *) (WORD) (6*PAGESIZE + doffset);
      }
      *dbyte++ = *sbyte++;
      soffset++;
      doffset++;
    }
    
    *par5 = oldpar5;
    *par6 = oldpar6;
    *pdr5 = oldpdr5;
    *pdr6 = oldpdr6;
  }
  
  setpl(oldpsw);
  return rc;
}
