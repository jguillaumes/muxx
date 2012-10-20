#include "muxxdef.h"
#include "config.h"
#include "errno.h"
#include "externals.h"
#include "kernfuncs.h"

/*
** Change a user space memory page protection.
** A process can change its own non-shared pages
** A PRIVILEGED (operprv) process can change any page
**
** This syscall forces a YIELD to make sure the MMU registers
** get updated with the changed PDR values.
*/
int muxx_svc_protmem(ADDRESS fp, WORD pid, WORD page, WORD prot) {
  PTCB tcb = NULL;
  WORD *updr = (WORD *) MMU_UISDR0;
  WORD *kpdr = (WORD *) MMU_KISDR0;
  
  if (prot != PDR_ACC_RW &&
      prot != PDR_ACC_RO &&
      prot != PDR_ACC_NA) return EINVVAL;

  if ((pid != curtcb->pid && pid != 0) && 
    !curtcb->privileges.prvflags.operprv) {
    return ENOPRIV;               // Privileges required for non-own pages
  }
  
  if (page > 7) return EINVVAL;   // Page requested is out of range
  
  if (page <= 2 && !curtcb->privileges.prvflags.operprv) {
    return ENOPRIV;               // Privileges required for shared pages
  }
  
  if (pid == 0) {
    tcb = curtcb;
  } else {
    tcb = muxx_findtcb(pid);
  }
  if (tcb != NULL) {
    tcb->mmuState.updr[page] &= 0xfff8;
    tcb->mmuState.updr[page] |= prot;
    updr[page] = tcb->mmuState.updr[page]; 
    tcb->mmuState.kpdr[page] = tcb->mmuState.updr[page];
    kpdr[page] = tcb->mmuState.updr[page]; 
  } else {
    return ENOTFOUND;
  }
  return EOK;
}
