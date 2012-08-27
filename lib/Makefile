.SUFFIXES: .lda .out .o .s .c

BIN2LOAD=/home/jguillaumes/retroutils/bin2load/bin2load
AS=pdp11-aout-as
CC=pdp11-aout-gcc
LD=pdp11-aout-ld
AR=pdp11-aout-ar
LDFLAGS=-T ldkern.cmd -M --cref --traditional -lgcc -lpdp11
CFLAGS=-c -Wall -I../h -Os -ffreestanding -fomit-frame-pointer
ASMFLAGS=-acmghlsd -I../h 

TARGETS=libmuxx.a
OBJECTS=memblocks.o itoo.o itoh.o itod.o kmsgaddr.o conio.o lib_syscalls.o \
	empty_proc.o printf.o

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

