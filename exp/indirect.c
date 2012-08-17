#include <stdarg.h>

struct SVC_S {
  int (*svc)(int,va_list);
  int nparams;
};

static int muxx_svc_conputc(int np, va_list args) {
  char *chr = va_arg(args,char *);
  // asm("halt");
  kconputc(*chr);
}

static int muxx_svc_muxxhlt(int np, va_list args) {
  asm("halt");
}

static int muxx_unimpl(int np, va_list args) {
  return -1;
}

int muxx_systrap_handler(int numtrap, ...) {
  static struct SVC_S trap_table[] = {
    {muxx_svc_muxxhlt,0}, //  0;
    {muxx_unimpl, 0},	//  1;
    {muxx_unimpl, 0},     //  2:
    {muxx_unimpl, 0},	//  3:
    
    {muxx_unimpl, 0},	// KRNL 01
    {muxx_unimpl, 0},	// KRNL 02
    {muxx_unimpl, 0},	// KRNL 03
    {muxx_unimpl, 0},	// KRNL 04
    {muxx_svc_conputc, 1},	// KRNL 05
    {muxx_unimpl, 0}
  };	
  
  static int trap_table_entries = sizeof(trap_table)/sizeof(void *());	

  struct SVC_S *syssvc;
  int (*svcimpl)(int np,va_list);
  va_list args;
  int rc=0;

  syssvc = &(trap_table[numtrap]);
 
  va_start(args,numtrap);
  svcimpl = syssvc->svc;
  rc = (*svcimpl)(syssvc->nparams, args);
  va_end(args);
}
