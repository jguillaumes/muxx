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
void itool(LONGWORD const, char *);
void itoh(WORD const, char *);
void itod(WORD const, char *);
void itods(WORD const, char *);
void itohb(WORD const, char *);
void itodb(WORD const, char *);
void itodl(LONGWORD const, char *);

int gettpi(WORD, PTCB);
int getpid();

int suspend(WORD);
int yield();

int mutex(WORD, WORD);
int mutexw(WORD, WORD);
int sleep(int);
int alloc(char *, WORD);
int allocw(char *, WORD);
int open(char *, WORD);
int close(int);
int read(int, WORD, char *);
int write(int, WORD, char *);
int load(char *, ADDRESS, ADDRESS *);

void *alloca(int);

#if MUXX_DEBUG != 0
#define DPRINTF  printf
#define DPUTSTRL putstrl
#else
#define DPRINTF
#define DPUTSTRL

#endif


#define _MUXXLIB_H
#endif
