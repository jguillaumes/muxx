extern char congtchr();
extern int  conptchr(char c);
#define NULL 0

int congtstr(char *buffer, short size, char term) {

  char *ptrBuffer = NULL;
  int count = 0;
  char c = 0;

  ptrBuffer = buffer;
  while(count < size && c != term) {
    c = congtchr();
    (void) conptchr(c);
    if (c != term) {
      *ptrBuffer++ = c;
      count++;
    }
  }
  return count;
}
