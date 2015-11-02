OUTPUT_FORMAT("a.out-pdp11")
OUTPUT_ARCH(pdp11)
STARTUP("../lib/crt0/crt0.o");
ENTRY(start)
phys  =  3 * 8192;
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
