#include <string.h>

void panic(char *msg) {
  int pl = setpl7();

  kputstrl("System panic!",13) ;
  kputstrzl(msg);
  kputstrl("Last saved frame:",17);
  muxx_dumpregs();
  kputstrzl("Halting system...");
  asm("halt");
  asm("halt");
  asm("halt");
}
