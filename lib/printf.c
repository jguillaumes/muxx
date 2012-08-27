/*
** Very basic printf() implementation for kernel/basic OS output
*/

#include <string.h>
#include <limits.h>
#include <stdarg.h>


int printf(char *fmt,...) {
  int numc = 0;
  int rc=0;
  char buffer[16];
  char *chr = NULL;
  va_list arglist;
  int narg=0;

  va_start(arglist, fmt);

  chr = fmt;
  while(*chr != '\0') {
    switch(*chr) {
    case '%':
      switch(*++chr) {
      case 'c':
#ifdef _MUXX_KERNEL
	rc = kputcon(va_arg(arglist,char));
#else
	rc = putcon(va_arg(arglist,char));
#endif
	if (rc == 0) numc++;
	break;
      case 's':
#ifdef _MUXX_KERNEL
	rc = kputstr(va_arg(arglist,char));
#else
	rc = putstr(va_arg(arglist,char));
#endif
	if (rc >=0 ) {
	  numc += rc;
	} else {
	  va_end(arglist);
	  return(rc);
	}
	break;
      case 'o':
	otoa(va_arg(arglist,WORD),buffer);
#ifdef _MUXX_KERNEL
	rc = kputstr(buffer,6);
#else
	rc = putstr(buffer,6);
#endif
	if (rc >= 0) {
	  numc += rc;
	} else {
	  va_end(arglist);
	  return rc;
	}
	break;
      case 'd':
	dtoa(va_arg(arglist,WORD),buffer);
#ifdef _MUXX_KERNEL
	kputstr(buffer,5);
#else
	putstr(buffer,5);
#endif
	if (rc >= 0) {
	  numc += rc;
	} else {
	  va_end(arglist);
	  return rc;
	}
	break;
      case 'x':
      case 'X':
      default:
	htoa(va_arg(arglist,WORD),buffer);
#ifdef _MUXX_KERNEL
      if (rc = kputcon('%')) {
#else
      if (rc = putcon('%')) {
#endif
      }
	if (rc >= 0) {
	  numc += rc;
	} else {
	  va_end(arglist);
	  return rc;
	}
      break;
      default:
#ifdef _MUXX_KERNEL
      if (rc = kputcon(*chr++)) {
#else
      if (rc = putcon(*chr++)) {
#endif
	numc++;
      } else {
	va_end(arglist);
	return rc;
      }
    }
  }
}

