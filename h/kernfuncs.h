#ifndef _H_KERNFUNCS_H

#include "types.h"
#include "muxx.h"
#include "queues.h"

int setpl(int);
int setpl7();
int getpl();

int muxx_taskinit(int, WORD, ADDRESS, WORD);
void muxx_tcbinit(PTCB);
int muxx_setup_taskmem(PTCB);

int kputstr(char *, int);
int kputstrz(char *);
int kputstrl(char *, int);
int kputstrzl(char *);
int kputoct(WORD);
int kconputc(char);

void copytrapf();
void copytrapfp(void *);
void restoretrapf();
void copyMMUstate();
void restoreMMUstate();

void muxx_switch();

void muxx_dumpregs(CPUSTATE *);
void muxx_dumptcbregs();
void muxx_dumptcb(PTCB);
void muxx_dumpctcb();
void muxx_dumpmmu(MMUSTATE *);

void muxx_qAddTask(PTQUEUE,PTCB);
PTCB muxx_qGetTask(PTQUEUE);
PTCB muxx_qRemoveTask(PTQUEUE,PTCB);

int muxx_svc_creprc(char *, int, ADDRESS, WORD);

void muxx_yield();
void muxx_schedule();

#define _H_KERFUNCS_H
#endif

