/*
* Very basic printf() implementation for kernel/basic OS output
*/

#include <string.h>
#include <limits.h>
#include <stdarg.h>
#include "types.h"
#include "kernfuncs.h"
#include "muxxlib.h"

#ifdef MUXX_KERNEL
#define PRINTF	kprintf
#define PUTC(c)	kconputc(c)
#define PUTSTR(s,l)	kputstr(s,l)
#define PUTSTRZ(s)	kputstrz(s)
#else
#define	PRINTF	printf
#define	PUTC(c)	conputc(c)
#define PUTSTR(s,l)	putstr(s,l)
#define PUTSTRZ(s)	putstrz(s)
#endif

int PRINTF(char *fmt,...) {
  int numc = 0;
  int rc=0;
  char buffer[16];
  char c=0;
  char *chr = fmt;
  va_list arglist;

  va_start(arglist, fmt);

  while(*chr != 0) {
    c = *(chr++);
    switch(c) {
    case '%':
      switch(*chr++) {
      case 'c':
	rc = PUTC(va_arg(arglist,int));
	if (rc == 0) numc++;
	break;
      case 's':
	rc = PUTSTRZ(va_arg(arglist,char *));
	if (rc >=0) {
	  numc += rc;
	} else {
	  va_end(arglist);
	  return(rc);
	}
	break;
      case 'o':
	itoo(va_arg(arglist,unsigned int),buffer);
	rc = PUTSTR(buffer,6);
	if (rc >= 0) {
	  numc += rc;
	} else {
	  va_end(arglist);
	  return rc;
	}
	break;
      case 'd':
	itod(va_arg(arglist,unsigned int),buffer);
	PUTSTR(buffer,5);
	if (rc >= 0) {
	  numc += rc;
	} else {
	  va_end(arglist);
	  return rc;
	}
	break;
      case 'x':
      case 'X':
	itoh(va_arg(arglist,unsigned int),buffer);
	PUTSTR(buffer,4);
	if (rc >= 0) {
	  numc += rc;
	} else {
	  va_end(arglist);
	  return rc;
	}
	break;
      default:
	if ((rc = PUTC('%'))==0) {
	    numc++;
	} else {
	  va_end(arglist);
	  return rc;
	}
	break;
      }
      break;
    case '\n':
      rc = PUTSTR("\r\n",2);
      if (rc == 0) {
	numc += 2;
      } else {
	va_end(arglist);
	return(rc);
      }
      break;
    case 0:
      break;
    default:
      if ((rc = PUTC(c))==0) {
	numc++;
      } else {
	va_end(arglist);
	return rc;
      }
    }
  }
  va_end(arglist);
  return numc;
}
