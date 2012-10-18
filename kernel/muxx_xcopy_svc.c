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
  WORD *pdr4,*pdr5,*par4,*par5;
  WORD oldpdr4,oldpdr5,oldpar4,oldpar5;
  WORD oldpsw;
  WORD spagenum=0,dpagenum=0;
  WORD soffset=0,doffset=0;
  LONGWORD sphy,dphy;
  int n;
  BYTE *sbyte, *dbyte;

  // kprintf("srcpid=%o, srcaddr=%o\n", srcpid, srcaddr);
  // kprintf("dstpid=%o, dstaddr=%o\n", dstpid, dstaddr);

  if (size == 0) return rc;             // Nothing to do

  if (dstpid == 0 && srcpid == 0) {     // Same process, just a memcpy
    memcpy(dstaddr, srcaddr, size);
  }
   
  oldpsw = setpl7();
  
  pdr4 = (WORD *) MMU_KISDR4;
  pdr5 = (WORD *) MMU_KISDR5;
  par4 = (WORD *) MMU_KISAR4;
  par5 = (WORD *) MMU_KISAR5;

  oldpdr4 = *pdr4;
  oldpdr5 = *pdr5;
  oldpar4 = *par4;
  oldpar5 = *par5;

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

    spagenum = ( srcaddr & 0xE000 ) >> 13;
    soffset  = ( srcaddr & 0x1FFF );
    *par4 = srctcb->mmuState.upar[spagenum];
    
    dpagenum = ( dstaddr & 0xE000 ) >> 13;
    doffset  = ( dstaddr & 0x1FFF );
    *par5 = dsttcb->mmuState.upar[dpagenum];
    
    *pdr4 = PDR_ACC_RW | PDR_SIZ_8K | PDR_DIR_UP;
    *pdr5 = *pdr4;
   
    // kprintf("spag=%o, dpag=%o\n", *par4, *par5);
 
    // sphy = (LONGWORD) *par4 * 64 + soffset;
    // dphy = (LONGWORD) *par5 * 64 + doffset;
    // kprintf("spagenum=%o, soffset=%o, sphys=%O\ndpagenum=%o, doffset=%o, dphys=%O\n",
    //	    spagenum, soffset, sphy,
    //	    dpagenum, doffset, dphy);
    
    sbyte = (BYTE *) (WORD) (4*PAGESIZE + soffset);
    dbyte = (BYTE *) (WORD) (5*PAGESIZE + doffset);
    // kprintf("sbyte=%o, dbyte=%o\n", sbyte, dbyte);
    for (n=0; n<size; n++) {
      if (soffset >= 8192) {
	par4    += 0200;
	soffset -= 8192;
	sbyte = (BYTE *) (WORD) (5*PAGESIZE + soffset);
      }
      if (doffset >= 8192) {
	par5    += 0200;
	doffset -= 8192;
	dbyte = (BYTE *) (WORD) (6*PAGESIZE + doffset);
      }
      *dbyte++ = *sbyte++;
      soffset++;
      doffset++;
    }
    
    *par4 = oldpar4;
    *par5 = oldpar5;
    *pdr4 = oldpdr4;
    *pdr5 = oldpdr5;
  }
  
  setpl(oldpsw);
  return rc;
}
