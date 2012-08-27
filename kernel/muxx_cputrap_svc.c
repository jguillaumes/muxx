#include "muxx.h"
#include "externals.h"
#include "config.h"
#include "muxxdef.h"
#include "kernfuncs.h"
#include "muxxlib.h"

void muxx_handle_cpuerr(void *fp) {
  copytrapfp(fp);
  kputstrl("\r\n",2);
  kputstrl("CPUERR exception", 16);
#if CPU_HAS_ERROR == 1
  WORD *cpuerr = (WORD *) CPU_ERR;

  kprintf("Error mask: %o\n", *cpuerr);

  if (*cpuerr & 0x0004) kputstrzl("Stack overflow (red)");
  if (*cpuerr & 0x0008) kputstrzl("Stack overflow (yellow)");
  if (*cpuerr & 0x0010) kputstrzl("UNIBUS timeout");
  if (*cpuerr & 0x0020) kputstrzl("Non-existent memory");
  if (*cpuerr & 0x0040) kputstrzl("Odd address");
  if (*cpuerr & 0x0080) kputstrzl("Illegal HALT");

#endif
  panic("CPUERR");
}

void muxx_handle_illins(void *fp) {
  copytrapfp(fp);
  kputstrl("\r\n",2);
  kputstrl("ILLINS exception", 16);
  panic("ILLINS");
}

void muxx_handle_iot(void *fp) {
  copytrapfp(fp);
  kputstrl("\r\n",2);
  kputstrl("IOT    exception", 16);
  panic("IOT");
}

void muxx_handle_buserr(void *fp) {
  copytrapfp(fp);
  kputstrl("\r\n",2);
  kputstrl("BUSERR exception", 16);
  panic("BUSERR");
}

void muxx_handle_fperr(void *fp) {
  copytrapfp(fp);
  kputstrl("\r\n",2);
  kputstrl("FPERR  exception", 16);
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

  if (*mmr0 & 0x8000) kputstrzl("Non resident");
  if (*mmr0 & 0x4000) kputstrzl("Page length");
  if (*mmr0 & 0x2000) kputstrzl("Read only abort");
  if (*mmr0 & 0x1000) kputstrzl("MMU trap");
  muxx_dumpmmu(&(curtcb->mmuState));
  panic("MMUERR");
}

void muxx_handle_trace(void *fp) {
  copytrapfp(fp);
  kputstrl("\r\n",2);
  kputstrl("TRACE trap", 16);
  panic("TRACE");
}

void muxx_handle_power(void *fp) {
  copytrapfp(fp);
  kputstrl("\r\n",2);
  kputstrl("POWER exception", 16);
  panic("POWER");
}

void muxx_handle_unimpl(void *fp) {
  copytrapfp(fp);
  kputstrl("\r\n",2);
  kputstrl("UNIMPL exception", 16);
  panic("unimplemented");
}
