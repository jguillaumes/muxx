#ifndef _MUXXLIB_H


int congetc();
int conputc(char);

int putstr(char *, int);
int putstrz(char *);
int putstrl(char *, int);
int putstrzl(char *);
int putoct(WORD);

void itoo(WORD const, char *);
void itoh(WORD const, char *);
void itod(WORD const, char *);
void itohb(WORD const, char *);
void itodb(WORD const, char *);

#define _MUXXLIB_H
#endif
