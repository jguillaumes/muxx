#if defined(LIBC_SCCS) && !defined(lint)
static char sccsid[] = "@(#)strout.c	5.2 (Berkeley) 3/9/86";
#endif 

#include	<stdio.h>

void _strout(int, char *, int, FILE*, int) 
  __attribute__ ((optimize("no-omit-frame-pointer")));

void _strout(int count, char *string, int adjust, FILE *file, int fillch)
{
	while (adjust < 0) {
		if (*string=='-' && fillch=='0') {
			putc(*string++, file);
			count--;
		}
		putc(fillch, file);
		adjust++;
	}
	while (--count>=0)
		putc(*string++, file);
	while (adjust) {
		putc(fillch, file);
		adjust--;
	}
}
