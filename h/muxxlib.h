#ifndef _MUXXLIB_H


int congetc();
int conputc(char);

int kgetlin(char *buffer, int size, char *terms, int termsize);
int kputstr(char *buffer, int size);
int kputstrl(char *buffer, int size);

void otoa(WORD const, char *);
void htoa(WORD const, char *);
void dtoa(WORD const, char *);
void htoab(WORD const, char *);
void dtoab(WORD const, char *);

#define _MUXXLIB_H
#endif
