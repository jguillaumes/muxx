#ifndef _MUXX_H

#include "types.h"
#include "muxxdef.h"

struct TCB_S {
  WORD pid;             // Process id.
  WORD ppid;            // Parent process id.

  LONGWORD uic;             // Process owner (not used now)

  union {
    WORD stword;
    struct {
      int ready     :1;
      int receiving :1;
      int suspended :1;
      int msgwait   :1;
      int filler    :12;
    } stflags;
  } status;

  union {
    WORD prvword;
    struct {
      int operprv  :1;
      int ioprv    :1;
      int filler   :14;
    } prvflags;
  } privileges;
  WORD taskType;

  struct TCB_S *firstChild;
  struct TCB_S *lastChild;
  struct TCB_S *nextSibling;
  
  WORD regs[6];         // Saved CPU regs 0-5
  WORD usp;             // Saved User stack pointer
  WORD ksp;             // Saved Kernel stack pointer
  WORD ssp;             // Saved Supervisor stack pointer (not used)
  WORD pc;              // Saved program counter
  WORD psw;             // Saved processor status word

  WORD upar[8];         // Saved user mode MMU Page Address Registers
  WORD spar[8];         // Saved supervisor mode MMU PARs (not used)
  WORD kpar[8];         // Saved kernel mode MMU PARs 
 
  LONGWORD clock_ticks;
  LONGWORD created_timestamp;

};

typedef struct TCB_S TCB;
typedef struct TCB_S *PTCB;

struct TCTA_S {
  char tcteye[8];
  TCB tctTable[MAX_TASKS];
};

typedef struct TCTA_S TCTA;
typedef struct TCTA_S *PTCTA;

extern ADDRESS tct;
extern WORD tctsize;
extern WORD curtasks;
extern ADDRESS kstackt;
extern ADDRESS  kstackb;
extern ADDRESS  ustackt;
extern ADDRESS  ustackb;

extern WORD topspid;
extern WORD minspid;
extern WORD maxspid;

extern WORD topupid;
extern WORD minupid;
extern WORD maxuipd;

extern WORD clkfreq;
extern LONGWORD utime;
extern LONGWORD datetime;

#define _MUXX_H
#endif
