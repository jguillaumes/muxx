#include "muxxlib.h"

#define	PUTC(c)	conputc(c)
#define PUTSTR(s,l)	putstr(s,l)

int puts(char *string) {
  char c;
  int n=0;

  while((c=*string++) != 0) {
    if (c == '\n') {
      PUTSTR("\n\r",2);
      n += 2;
    } else {
      PUTC(c);
      n++;
    }
  }
  return(n);
}
