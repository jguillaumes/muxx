#include <stdio.h>
#include "muxxlib.h"

/*
** Output a character to a file specified by stream descriptor
**
** At this time the f parameter is ignored, and the character is sent
** to the console using the conputc() system call.
**
** The complete implementation will make use of the write() system
** call, when it is available...
*/


int putc(char c, FILE *f) {
  if (c=='\n') conputc('\r');
  return conputc(c);
}
