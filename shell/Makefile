.SUFFIXES: .lda .out .o .s .c

BIN2LOAD=/home/jguillaumes/retroutils/bin2load/bin2load
AS=pdp11-aout-as
CC=pdp11-aout-gcc
LD=pdp11-aout-ld
AR=pdp11-aout-ar
LDFLAGS=-T ldaout.cmd -M --cref --traditional -lgcc -lpdp11
CFLAGS=-c -Wall -I../h -Os -ffreestanding -fomit-frame-pointer -fno-builtin-alloca
ASMFLAGS=-acmghlsd -I../h 

TARGETS=libshell.a
OBJECTS=rshell.o

.out.lda:	
	$(BIN2LOAD) -a -f $< -o $@

.s.o:
	$(AS) $(ASMFLAGS) $< -o $@ > $*.lst


all:	$(TARGETS)

clean:
	@rm *.a *.o *.lst &>/dev/null

mrproper:
	@rm *.a *.o *.lst *~ \#*\# &>/dev/null

libshell.a:	$(OBJECTS)
	$(AR) rs $@ $^ 

#kprintf.o:	../lib/stdio/printf.c
#	$(CC) $(CFLAGS) -DMUXX_KERNEL -c -o $@  $<
