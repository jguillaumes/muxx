.SUFFIXES: .lda .out .o .s .c
include ../def.mk

LDFLAGS=-T ldaout.cmd -M --cref --traditional -lgcc -lpdp11
CFLAGS=-c -Wall -I../h -Os -ffreestanding -fomit-frame-pointer -fno-builtin-alloca
ASMFLAGS=-acmghlsd -I../h

TARGETS=libkmuxx.a
OBJECTS=muxx_mmu.o muxx_cputrap.o muxx_kconio.o muxx_systrap.o muxx_tctinit.o \
	muxx_taskinit.o muxx_static.o muxx_fakeproc.o spl.o muxx_clock.o \
	muxx_clock_svc.o muxx_memsvc.o muxx_cputrap_svc.o muxx_systrap_svc.o \
	muxx_panic.o muxx_dumpregs.o muxx_copytrapframe.o muxx_creprc.o \
	muxx_taskqueues.o muxx_switch.o muxx_dumptcb.o muxx_dumpmmu.o \
	muxx_kconio1.o muxx_yield.o muxx_schedule.o kprintf.o muxx_drvinit.o \
	muxx_drvctl.o muxx_drvctl_a.o muxx_channels.o muxx_readwrite_svc.o \
	muxx_task_svc.o muxx_xcopy_svc.o muxx_protmem_svc.o

.out.lda:
	$(BIN2LOAD) -a -f $< -o $@

.s.o:
	$(AS) $(ASMFLAGS) $< -o $@ > $*.lst


all:	$(TARGETS)

clean:
	-rm *.a *.o *.lst &>/dev/null

mrproper:
	-rm *.a *.o *.lst *~ \#*\# &>/dev/null

libkmuxx.a:	$(OBJECTS)
	$(AR) rs $@ $^

#kprintf.o:	../lib/stdio/printf.c
#	$(CC) $(CFLAGS) -DMUXX_KERNEL -c -o $@  $<
