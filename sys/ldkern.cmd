OUTPUT_FORMAT("a.out-pdp11")
OUTPUT_ARCH(pdp11)
SEARCH_DIR("/usr/local/pdp11-aout/lib");
SEARCH_DIR("/usr/local/lib/gcc/pdp11-aout/4.6.4/");
ENTRY(sysstart)
phys    =  01000;
_toptask =  3 * 8192;
SECTIONS
{
  .text phys : AT(phys) {
    code = .;
    *(.text)
    *(.rodata)
    . = ALIGN(0100);
  }
  .data : AT(phys + (data - code))
  {
    data = .;
    *(.data)
    . = ALIGN(0100);
    PROVIDE(tempstack = .);
    PROVIDE(scratchpad = .);
    . = . + 256;
    PROVIDE(tempstackt = .);
    . = ALIGN(0100);
  }
  .bss : AT(phys + (bss - code))
  {
    bss = .;
    *(.bss)
    . = ALIGN(0100);
  }
  PROVIDE(end = .);
  PROVIDE(_end = .);
}

