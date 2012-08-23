#include <string.h>
#include "kernfuncs.h"

void panic(char *) __attribute__ ((noreturn,optimize("omit-frame-pointer")));

void panic(char *msg) {

  kputstrl("System panic!",13) ;
  kputstrzl(msg);
  kputstrl("Last saved frame:",17);
  muxx_dumptcbregs();
  kputstrzl("Halting system...");
  asm("halt");
  asm("halt");
  asm("halt");
 loop:
  goto loop;
}
