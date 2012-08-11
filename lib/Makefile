.SUFFIXES: .lda .out .o .s .c

BIN2LOAD=/home/jguillaumes/retroutils/bin2load/bin2load
AS=pdp11-aout-as
CC=pdp11-aout-gcc
LD=pdp11-aout-ld
AR=pdp11-aout-ar
LDFLAGS=-T ldkern.cmd -M --cref --traditional -lgcc -lpdp11
CFLAGS=-c -Os -I../h
ASMFLAGS=-acmghlsd -I../h 

TARGETS=libmuxx.a
OBJECTS=memblocks.o otoa.o htoa.o dtoa.o kmsgaddr.o kconio.o lib_syscalls.o \
	dumpregs.o queues.o empty_proc.o

.out.lda:	
	$(BIN2LOAD) -a -f $< -o $@

.s.o:
	$(AS) $(ASMFLAGS) $< -o $@ > $*.lst


all:	$(TARGETS)

clean:
	@rm *.a *.o *.lst *.map *.out *.lda

queues.o:	queues.c ../h/queues.h

libmuxx.a:	$(OBJECTS)
	$(AR) rs $@ $^ 

