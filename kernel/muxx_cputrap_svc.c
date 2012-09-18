#include "muxx.h"
#include "externals.h"
#include "config.h"
#include "muxxdef.h"
#include "kernfuncs.h"
#include "muxxlib.h"

void muxx_handle_cpuerr(void *fp) {
  copytrapfp(fp);
  kprintf("\nCPUERR exception\n");
#if CPU_HAS_ERROR == 1
  WORD *cpuerr = (WORD *) CPU_ERR;

  kprintf("Error mask: %o\n", *cpuerr);

  if (*cpuerr & 0x0004) kprintf("Stack overflow (red)\n");
  if (*cpuerr & 0x0008) kprintf("Stack overflow (yellow)\n");
  if (*cpuerr & 0x0010) kprintf("UNIBUS timeout\n");
  if (*cpuerr & 0x0020) kprintf("Non-existent memory\n");
  if (*cpuerr & 0x0040) kprintf("Odd address\n");
  if (*cpuerr & 0x0080) kprintf("Illegal HALT\n");

#endif
  panic("CPUERR");
}

void muxx_handle_illins(void *fp) {
  copytrapfp(fp);
  kprintf("\nILLINS exception\n");
  panic("ILLINS");
}

void muxx_handle_iot(void *fp) {
  copytrapfp(fp);
  kprintf("\nIOT    exception\n");
  panic("IOT");
}

void muxx_handle_buserr(void *fp) {
  copytrapfp(fp);
  kprintf("\nBUSERR exception\n");
  panic("BUSERR");
}

void muxx_handle_fperr(void *fp) {
  copytrapfp(fp);
  kprintf("\nFPERR  exception\n");
  panic("FPERR");
}

void muxx_handle_mmuerr(void *fp) {
  copytrapfp(fp);
  copyMMUstate();
 
  WORD *mmr0 = (WORD *) MMU_MMR0;
  WORD *mmr2 = (WORD *) MMU_MMR2;
  WORD page = 0;

  page = ((*mmr0) & 0x000D) >> 1;
  
  kprintf("\nMMUERR exception at %o\n", *mmr2);
  kprintf("MMR0: %o - page %o\n", *mmr0, page);

  if (*mmr0 & 0x8000) kprintf("Non resident\n");
  if (*mmr0 & 0x4000) kprintf("Page length\n");
  if (*mmr0 & 0x2000) kprintf("Read only abort\n");
  if (*mmr0 & 0x1000) kprintf("MMU trap\n");
  muxx_dumpmmu(&(curtcb->mmuState));
  panic("MMUERR");
}

void muxx_handle_trace(void *fp) {
  copytrapfp(fp);
  kprintf("\nTRACE trap\n");
  panic("TRACE");
}

void muxx_handle_power(void *fp) {
  copytrapfp(fp);
  kprintf("\nPOWER exception\n");
  panic("POWER");
}

void muxx_handle_unimpl(void *fp) {
  copytrapfp(fp);
  kprintf("\nUNIMPL exception\n");
  panic("unimplemented");
}
