#ifndef _MUXX_H

#include "types.h"
#include "config.h"
#include "muxxdef.h"

struct CPUSTATE_S {
  WORD gpr[6];
  WORD sp;
  WORD pc;
  WORD psw;
  WORD usp;
  WORD ssp;
  WORD ksp;
};

typedef struct CPUSTATE_S CPUSTATE;

struct MMUSTATE_S {
  WORD upar[8];
  WORD spar[8];
  WORD kpar[8];
};

typedef struct MMUSTATE_S MMUSTATE;

struct TCB_S {
  char taskname[8];     // Process name
  WORD pid;             // Process id.
  WORD ppid;            // Parent process id.
  LONGWORD uic;         // Process owner (not used now)

  WORD status;
  union {
    WORD flword;
    struct {
      int sending   :1;
      int receiving :1;
      int suspended :1;
      int msgwait   :1;
      int filler    :12;
    } flflags;
  } flags;

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
  struct TCB_S *nextInQueue;
  struct TCB_S *prevInQueue;
  
  CPUSTATE cpuState;  // Saved CPU status
  MMUSTATE mmuState;  // Saved MMU status
 
  LONGWORD clockTicks;
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

struct MCBE_S {
  WORD owner;
  BYTE mode;
  BYTE page;
};

typedef struct MCBE_S MCBE;
typedef struct MCBE_S *PMCBE;

struct MCB_S {
  WORD blocks;
  WORD freeBlocks;
  MCBE mcb[MEM_NMCBS];
};

typedef struct MCB_S MCB;
typedef struct MCB_S *PMCB;

#define _MUXX_H
#endif
