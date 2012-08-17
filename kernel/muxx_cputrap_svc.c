#include "muxx.h"
#include "externals.h"
#include "config.h"
#include "muxxdef.h"

void muxx_handle_cpuerr(void *fp) {
  copytrapf();
  kputstrl("CPUERR exception", 16);
  panic("CPUERR");
}

void muxx_handle_illins(void *fp) {
  copytrapf();
  kputstrl("ILLINS exception", 16);
  panic("ILLINS");
}

void muxx_handle_iot(void *fp) {
  copytrapf();
  kputstrl("IOT    exception", 16);
  panic("IOT");
}

void muxx_handle_buserr(void *fp) {
  copytrapf();
  kputstrl("BUSERR exception", 16);
  panic("BUSERR");
}

void muxx_handle_fperr(void *fp) {
  copytrapf();
  kputstrl("FPERR  exception", 16);
  panic("FPERR");
}

void muxx_handle_mmuerr(void *fp) {
  copytrapf();
  kputstrl("MMUERR exception", 16);
  panic("MMUERR");
}

void muxx_handle_unimpl(void *fp) {
  copytrapf();
  kputstrl("UNIMPL exception", 16);
  panic("unimplemented");
}


