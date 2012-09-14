.SUFFIXES: .lda .out .o .s .c

MUXXBASE=../../
MUXXH=$(MUXXBASE)/h
BIN2LOAD=/home/jguillaumes/retroutils/bin2load/bin2load
AS=pdp11-aout-as
CC=pdp11-aout-gcc
LD=pdp11-aout-ld
AR=pdp11-aout-ar
LDFLAGS=-T ldkern.cmd -M --cref --traditional -lgcc -lpdp11
CFLAGS=-c -Wall -I $(MUXXH) -Os -fomit-frame-pointer
ASMFLAGS=-acmghlsd -I $(MUXXH) 

OBJECTS=malloc.o calloc.o sleep.o

.s.o:
	$(AS) $(ASMFLAGS) $< -o $@ > $*.lst


all:	$(OBJECTS)

clean:
	@rm *.a *.o *.lst

