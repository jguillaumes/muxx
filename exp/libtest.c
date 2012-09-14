#include <stdio.h>

int prova() {
  char buffer[80];
  int i=1;
  long j=2;

  sprintf(buffer,"Prova %d, %l\n", i, j);
  exit(0);
}
