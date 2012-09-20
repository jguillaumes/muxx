#if defined(LIBC_SCCS) && !defined(lint)
static char sccsid[] = "@(#)printf.c	5.2 (Berkeley) 3/9/86";
#endif 

#include	<stdio.h>

int printf(char *fmt,...) __attribute__ ((optimize("no-omit-frame-pointer"))); 

void doprnt(char *, void *, FILE *);
#define stdout ((FILE *)0)

int printf(char *fmt,...) {
  void *args;

  /*
  putstr("[",1);
  putstrz(fmt);
  putstrl("]",1);
  */

  args = (void *) (&fmt + 2);
  doprnt(fmt, args, stdout);
  return 0;

}
