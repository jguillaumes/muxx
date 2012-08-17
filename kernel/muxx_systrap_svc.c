#include "muxx.h"
#include "muxxdef.h"
#include "errno.h"
#include "config.h"

extern int conputc(char);
extern int muxx_svc_creprc(char *, int, ADDRESS, WORD);

typedef int (*SVC)(int,...);

struct SVC_S {
  SVC svc;
  int nparams;
};

static int muxx_svc_conputc(char c) {
 kconputc(c);
}

static int muxx_svc_muxxhlt() {
  asm("halt");
}

static int muxx_unimpl() {
  return ENOIMPL;
}

int muxx_systrap_handler(int numtrap, WORD p1, WORD p2, WORD p3, WORD p4) {
  static struct SVC_S trap_table[] = {
    {(SVC) muxx_svc_muxxhlt,0}, //  0;
    {(SVC) muxx_svc_creprc, 4},	  //  1;
    {(SVC) muxx_unimpl, 0},     //  2:
    {(SVC) muxx_unimpl, 0},	  //  3:
    {(SVC) muxx_unimpl, 0},	  //  4:
    {(SVC) muxx_unimpl, 0},	  //  5:
    {(SVC) muxx_unimpl, 0},	  //  6:
    {(SVC) muxx_unimpl, 0},	  //  7:
    {(SVC) muxx_unimpl, 0},	  //  8:
    {(SVC) muxx_unimpl, 0},	  //  9:
    {(SVC) muxx_unimpl, 0},	  // 10:
    {(SVC) muxx_unimpl, 0},	  // 11:
    {(SVC) muxx_unimpl, 0},	  // 12:
    {(SVC) muxx_unimpl, 0},	  // 13:
    {(SVC) muxx_unimpl, 0},	  // 14:
    {(SVC) muxx_unimpl, 0},	  // 15:
    {(SVC) muxx_unimpl, 0},	  // 16:
    {(SVC) muxx_unimpl, 0},	  // 17:
    {(SVC) muxx_unimpl, 0},	  // 18:
    {(SVC) muxx_unimpl, 0},	  // 19:
    {(SVC) muxx_unimpl, 0},	  // 20:
    {(SVC) muxx_unimpl, 0},	  // 21:
    {(SVC) muxx_unimpl, 0},	  // 22:
    {(SVC) muxx_unimpl, 0},	  // 23:
    {(SVC) muxx_unimpl, 0},	  // 24:
    
    {(SVC) muxx_unimpl, 0},	  // KRNL 01
    {(SVC) muxx_unimpl, 0},	  // KRNL 02
    {(SVC) muxx_unimpl, 0},	  // KRNL 03
    {(SVC) muxx_unimpl, 0},	  // KRNL 04
    {(SVC) muxx_svc_conputc, 1},// KRNL 05
    {(SVC) muxx_unimpl, 0}
  };	
  
  static int trap_table_entries = sizeof(trap_table)/sizeof(void *());	

  struct SVC_S *syssvc;
  int (*svcimpl)();
  int rc=0;

  if (numtrap < 0 || numtrap > trap_table_entries) {
    return(EINVVAL);
  }

  syssvc = &(trap_table[numtrap]);
 
  // Temporary fix for gas assembler bug (it does not assemble
  // correctly JSR PC,@(R0) ).
  // svcimpl = syssvc->svc;
  // rc = (*svcimpl)(syssvc->nparams, args);

  switch(numtrap) {
    case KRN_HALT:
      rc = muxx_svc_muxxhlt();
      break;
    case KRN_PUTCON:
      rc = muxx_svc_conputc((char) p1);
      break;
    case SRV_CREPRC:
      rc = muxx_svc_creprc((char *) p1,(int) p2,(ADDRESS) p3,(WORD) p4);
      break;
    default:
      rc = muxx_unimpl();
  }
  return rc;
}
