#include "config.h"
#include "muxx.h"
#include "muxxdef.h"

WORD muxx_mem_getblock(WORD owner, WORD numMCBs, WORD mode, WORD page) {
  PMCBE mcbe;
  PMCB pmcb;
  int i=0;

  pmcb = _mcbaddr;

  if (numMCBs > pmcb->freeBlocks) {
    return EINVVAL;
  }

  


}


int muxx_mem_markblock(WORD owner, WORD firstMCB, WORD numMCBs, WORD mode, WORD page) {
  int i=0;
  PMCBE mcbe;
  PMCB pmcb;
  WORD numMCBs

    if ( numMCBs >  16) {
      return(EINVVAL);
    }

  pmcb = _mcbaddr;

  for(i=firstMCB; i<numMCBs; i++) {
    mcbe = pmcb->mcb[i];
    mcbe->owner = owner;
    mcbe->mode  = mode;
    mcbe->page  = page;
  }
  pmcb->freeBlocks -= numMCBs;
  return EOK;
}

void muxx_mem_freeblock(WORD firstBlock, WORD blocks) {

}
