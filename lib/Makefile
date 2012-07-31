.SUFFIXES: .lda .out .o .s .c

BIN2LOAD=/home/jguillaumes/retroutils/bin2load/bin2load
AS=pdp11-aout-as
CC=pdp11-aout-gcc
LD=pdp11-aout-ld
AR=pdp11-aout-ar
LDFLAGS=-T ldaout.cmd -M --cref --traditional
CCFLAGS=-c -O3 -I../h
ASMFLAGS=-acmghlsd -I../h 

TARGETS=memblocks.o

.out.lda:	
	$(BIN2LOAD) -a -f $< -o $@

.s.o:
	$(AS) $(ASMFLAGS) $< -o $@ > $*.lst


all:	$(TARGETS)

clean:
	rm *.o *.lst *.map *.out *.lda

memblocks.o:	memblocks.s