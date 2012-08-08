.SUFFIXES: .lda .out .o .s .c

BIN2LOAD=/home/jguillaumes/retroutils/bin2load/bin2load
AS=pdp11-aout-as
CC=pdp11-aout-gcc
LD=pdp11-aout-ld
AR=pdp11-aout-ar
LDFLAGS=-T ldaout.cmd -M --cref --traditional -lgcc -lpdp11
CFLAGS=-c -Os -I../h -ffreestanding
ASMFLAGS=-acmghlsd -I../h -m11/45

TARGETS=libkmuxx.a
OBJECTS=muxx_mmu.o muxx_cputrap.o muxx_kconio.o muxx_systrap.o muxx_tctinit.o \
	muxx_taskinit.o muxx_static.o

.out.lda:	
	$(BIN2LOAD) -a -f $< -o $@

.s.o:
	$(AS) $(ASMFLAGS) $< -o $@ > $*.lst


all:	$(TARGETS)

clean:
	@rm *.a *.o *.lst *.map *.out *.lda

libkmuxx.a:	$(OBJECTS)
	$(AR) rs $@ $^ 
