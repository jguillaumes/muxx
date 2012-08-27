#include <types.h>
#include <muxxlib.h>
#include <string.h>
 
static char CRLF[]="\r\n";


int getlin(char *buffer, int size, char *term, int termsiz) {

  BYTE inchar;
  int i=0,j=0,end=0;

  while(i<size && end==0) {
    inchar = kcongetc();
    for (j=0;j<termsiz && end==0; j++) {
      if (inchar == term[i]) end = 1;
    } 
    if (end == 0) {
      buffer[i++] = inchar;
    }
  }
  return (i);
}


int putstr(char *buffer, int size) {
  int i=0,rc=0;
  char *ptr=buffer;

  for (i=0; i<size && rc==0 ; i++) {
    rc = conputc(*ptr++);
  }
  return rc;
}

int putoct(WORD w) {
  char buffer[6];
  otoa(w,buffer);
  putstr(buffer,6);
}

int putstrl(char *buffer, int size) {
  int rc=0;
 
  rc = kputstr(buffer, size);
  if (rc==0) rc = putstr(CRLF, 2);
  return rc;
}

int putstrz(char *buffer) {
  int rc=0;
  char *ptr=buffer;

  while((*ptr != 0) && (rc==0)) {
    rc = conputc(*ptr++);
  }
  return rc;
}

int putstrzl(char *buffer) {
  int rc = putstrz(buffer);
  if (rc == 0) rc = putstr(CRLF,2);
  return rc;
}
