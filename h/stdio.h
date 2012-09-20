#ifndef _STDIO_H

// Placeholder for FILE definition (when it is done...)
#define FILE void

// Subset of stdio implemented in MUXX
int putc(char, FILE *);
int printf(char *,...);
void strout(int, char *, int, FILE *, char);

#define _STDIO_H
#endif
