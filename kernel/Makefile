.SUFFIXES: .lda .out .o .s .c

BIN2LOAD=/home/jguillaumes/retroutils/bin2load/bin2load
AS=pdp11-aout-as
CC=pdp11-aout-gcc
LD=pdp11-aout-ld
AR=pdp11-aout-ar
LDFLAGS=-T ldaout.cmd -M --cref --traditional -lgcc -lpdp11
CFLAGS=-c -I../h -Os -ffreestanding
ASMFLAGS=-acmghlsd -I../h -m11/45

TARGETS=libkmuxx.a
OBJECTS=muxx_mmu.o muxx_cputrap.o muxx_kconio.o muxx_systrap.o muxx_tctinit.o \
	muxx_taskinit.o muxx_static.o muxx_fakeproc.o spl.o muxx_clock.o \
	muxx_clock_svc.o muxx_memsvc.o muxx_cputrap_svc.o muxx_systrap_svc.o \
	muxx_panic.o muxx_dumpregs.o muxx_copytrapframe.o muxx_creprc.o \
	muxx_taskqueues.o

.out.lda:	
	$(BIN2LOAD) -a -f $< -o $@

.s.o:
	$(AS) $(ASMFLAGS) $< -o $@ > $*.lst


all:	$(TARGETS)

clean:
	@rm *.a *.o *.lst *.map *.out *.lda

libkmuxx.a:	$(OBJECTS)
	$(AR) rs $@ $^ 
