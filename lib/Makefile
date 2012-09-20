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

OBJECTS=memblocks.o itoo.o itoh.o itod.o conio.o

DIRS= gen machine stdio sys
ADIRS= crt0
SUBDIRS=gen/done machine/done stdio/done sys/done

.s.o:
	$(AS) $(ASMFLAGS) $< -o $@ > $*.lst


all:	subdirs $(TARGETS)

subdirs:
	set -e; for d in $(DIRS); do $(MAKE) -C $$d ; done
	set -e; for d in $(ADIRS); do $(MAKE) -C $$d ; done

clean:
	-@rm *.a *.o *.lst 

mrproper:
	-@rm *.a *.o *.lst *~ 

queues.o:	queues.c ../h/queues.h

libmuxx.a:	$(OBJECTS) $(SUBDIRS)
	$(AR) rs $@ $(OBJECTS)
	set -e; for d in $(DIRS); do $(AR) rs $@ $$d/*.o ; done
