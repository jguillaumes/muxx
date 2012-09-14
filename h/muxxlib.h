#ifndef _MUXXLIB_H

#include "muxx.h"

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
void itods(WORD const, char *);
void itohb(WORD const, char *);
void itodb(WORD const, char *);
void itodl(LONGWORD const, char *);

WORD gettpi(WORD, PTCB);
WORD getpid();

WORD suspend(WORD);
WORD yield();

WORD mutex(WORD, WORD);
WORD mutexw(WORD, WORD);
WORD sleep(int);
WORD alloc(char *, WORD);
WORD allocw(char *, WORD);


int printf(char *,...);

#define _MUXXLIB_H
#endif
