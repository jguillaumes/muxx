#include <types.h>
#include <muxxlib.h>
 
int kgetlin(char *buffer, int size, char *term, int termsiz) {

  BYTE inchar;
  int i=0,j=0,end=0;

  while(i<size && end==0) {
    inchar = congetc();
    for (j=0;j<termsiz && end==0; j++) {
      if (inchar == term[i]) end = 1;
    } 
    if (end == 0) {
      buffer[i++] = inchar;
    }
  }
  return (i);
}

int kputstr(char *buffer, int size) {
  int i=0,rc=0;
  char *ptr=buffer;

  for (i=0; i<size && rc==0 ; i++) {
    rc = conputc(*ptr++);
  }
  return rc;
}

int kputstrl(char *buffer, int size) {
  static char *cr="\n\r";
  int rc=0;
 
  rc = kputstr(buffer, size);
  if (rc==0) rc = kputstr(cr, 2);
  return rc;
}
