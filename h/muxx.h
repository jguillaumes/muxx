#ifndef _MUXX_H

#include "types.h"
#include "config.h"
#include "muxxdef.h"

/*
** CPU state block
** Contains the values of all the GPRs and the three stack pointers
*/
struct CPUSTATE_S {
  WORD gpr[6];          //   0
  WORD sp;              // +12
  WORD pc;              // +14
  WORD psw;             // +16
  WORD usp;             // +18
  WORD ssp;             // +20
  WORD ksp;             // +22
};

typedef struct CPUSTATE_S CPUSTATE;


/* 
** MMU state block
** Contains the values for the 8 PARs of the three modes
** The PDRs are not stored, since they can be built of the
** MMCBs
*/
struct MMUSTATE_S {
  WORD upar[8];
  WORD updr[8];
#if CPU_HAS_SUPER == 1
  WORD spar[8];
  WORD spdr[8];
#endif
  WORD kpar[8];
  WORD kpdr[8];
};

typedef struct MMUSTATE_S MMUSTATE;

/*
** TCB - Task control block
** Structure representing a process state
**
** This version does not support multithreading, so each task has one
** and only one "thread". To implement multithreading it would be 
** necessary to move the CPUSTATE information out of the TCB and relate
** it to the TCB in an 1..n relationship.
**
** The offsets to the individual fields are declared in MUXX.s and must
** be updated if this structure is modified.
*/
struct TCB_S {
  char taskname[8];         // Process name
  WORD pid;                 // Process id.
  WORD ppid;                // Parent process id.
  LONGWORD uic;             // Process owner (not used now)

  WORD status;
  union {
    WORD flword;
    struct {
      int sending   :1;     // Task is waiting to send a message 
      int receiving :1;     // Task is waiting to receive a message
      int suspended :1;     // Task is suspended
      int msgwait   :1;     // Task is waiting to send or receive message
      int filler    :12;
    } flflags;
  } flags;

  union {
    WORD prvword;
    struct {
      int operprv  :1;        // Operation privilege (full access)
      int ioprv     :1;       // I/O privilege (access to iospace)
      int auditprv  :1;       // Can see any memory page
      int filler    :13;
    } prvflags;
  } privileges;
  WORD taskType;             // Kernel or User task

  struct TCB_S *firstChild;  // First descendent
  struct TCB_S *lastChild;   // Last descendent
  struct TCB_S *nextSibling; // First younger sibling 
  struct TCB_S *nextInQueue; // Next task in wait queue (ready or blocked)
  struct TCB_S *prevInQueue; // Previous task in wait queue
  
  CPUSTATE cpuState;  // Saved CPU status
  MMUSTATE mmuState;  // Saved MMU status
 
  LONGWORD clockTicks;        // CPU in use clock ticks since task creation
  LONGWORD created_timestamp; // Timestamp of creation
  LONGWORD localFlags;        // Local event flags
};

typedef struct TCB_S TCB;
typedef struct TCB_S *PTCB;

/*
** Macros for reading, setting and clearing local flags
*/
#define LOCALFLAG(x,f) (((x)->localFlags >> (f)) & 0x0001)
#define SETLOCALF(x,f) (((x)->localFlags) | (0x0001 << (f)))
#define CLRLOCALF(x,f) (((x)->localFlags) & (~(0x0001 << (f))))
/*
** Task control table
**
** Array of MAX_TASKS TCBs with eyecatcher
*/
struct TCTA_S {
  char tcteye[8];
  TCB tctTable[MAX_TASKS];
};

typedef struct TCTA_S TCTA;
typedef struct TCTA_S *PTCTA;

/*
** Memory Management Control Block (MMCB)
**
** Each MMCB controls a "chunk" of physical memory
** The address corresponds to a "block" address. A "block" in PDP-11 MMU
** is a chunk of 64 bytes (32 words).
** The size is expressed also in blocks
**
*/
struct MMCB_S {
  WORD blockAddr;
  WORD blockSize;
  WORD ownerPID;
  WORD ownerPAR;
  struct MMCB_S *nextBlock;
  struct MMCB_S *prevBlock;
  union {
    struct {
      int sharedBlock: 1;   // This is a shared memory block
      int fixedBlock: 1;    // This block is fixed in physical memory
      int privBlock: 1;     // Privilege (oper) required to access this block
      int iopage: 1;        // This is an iopage block (requires iopriv)
      int stack: 1;         // This is a stack page
      int iobuffer: 1;      // This page is used for I/O buffers
      int filler: 10;       
    } flags;
    WORD word;
  } mmcbFlags;
  WORD reserved;
};

typedef struct MMCB_S MMCB;
typedef struct MMCB_S *PMMCB;

/*
** Memory management control block table
** Array of MMCBs with eyecatcher
** The array is sized so the memory could be completely divided in chunks
*/
 struct MMCBT_S {
   char mcbeye[8];              // Eyecatcher
   WORD numEntries; 
   MMCB mmcbt[MEM_NMCBS];    // Each chunk = 2KB.  2048/64 = 32
};

typedef struct MMCBT_S MMCBT;
typedef struct MMCBT_S *PMMCBT;


/*
** Device interrupt structure
*/
struct DRVISR_S {
  ADDRESS handler;
  ADDRESS vector;
  WORD    ilevel;
};

typedef struct DRVISR_S  DRVISR;
typedef struct DRVISR_S *PDRVISR;

/*
** Device driver descriptor
**
** See muxxdef.h for callback names
*/
struct DRVDESC_S {
  ADDRESS callbacks[8];
  union {
    struct {
      int shareable: 1;
      int files    : 1;
      int reserved : 14;
    } flags;
    WORD wflags;
  } attributes;
  char    devname[8];
  WORD    numisr;
  DRVISR  isrtable[4];
};

typedef struct DRVDESC_S DRVDESC;
typedef struct DRVDESC_S *PDRVDESC;

/*
** Device driver table definitions
*/
struct DRVCB_S {
  char drvname[8];           // Driver name
  PDRVDESC desc;             // Driver descriptor
  struct {
    int free     :1;         // Unused entry
    int loaded   :1;         // Device driver has been loaded
    int active   :1;         // Device driver is active
    int stopped  :1;         // Device driver has been stopped
    int alloc    :1;         // Device dricer has been allocated
    int reserved :11;
  } flags;
  PTCB taskid;               // Controller task
  PTCB ownerid;              // Owning task
  WORD status;               // Last error code
};

typedef struct DRVCB_S  DRVCB;
typedef struct DRVCB_S *PDRVCB;

struct DRVCBT_S {
  char eyecat[8];           // Eyecatcher (DRVCBT--)
  WORD  numdrvcb;           // Number of loaded drivers
  DRVCB drvcbt[MAX_DRV];    // DRVCB table
};

typedef struct DRVCBT_S DRVCBT;
typedef struct DRVCBT_S *PDRVCBT;

struct IOPKT_S {
  WORD function;
  WORD param[4];
  WORD size;
  BYTE ioarea[0];
};

typedef struct IOPKT_S IOPKT;
typedef struct IOPKT_S *PIOPKT;

struct IOTE_S {
  WORD channel;
  PDRVCB driver;
  union {
    struct {
      int open:      1;
      int eof:       1;
      int ioerror:   1;
      int reserved: 13;
    } flags;
    WORD wflags;
  } status;
  LONGWORD position;
  BYTE controller;
  BYTE unit;
  WORD error;
  char reserved[2];
};

typedef struct IOTE_S IOTE;
typedef struct IOTE_S *PIOTE;  

#define _MUXX_H
#endif
