.SUFFIXES: .lda .out .o .s .c

BIN2LOAD=bin2load
AS=pdp11-aout-as
CC=pdp11-aout-gcc
LD=pdp11-aout-ld
SIZE=pdp11-aout-size
LIBS=-lgcc -lc -lpdp11 -L../lib -lmuxx -L../kernel -lkmuxx
LDFLAGS=-T ldkern.cmd -M --cref --traditional 
CFLAGS=-c -Os -ffreestanding -I../h
ASMFLAGS=-aghls -am -I../h
MACROS=../h/SCB.s ../h/MUXXDEF.s ../h/MACLIB.s ../h/MUXXMAC.s
OBJECTS=taska.o taskb.o

.out.lda:	
	$(BIN2LOAD) -a -f $< -o $@

.s.o:
	$(AS) $(ASMFLAGS) $< -o $@ -ald > $*.lst

all: startup.lda

clean:
	rm *.o *.out *.lda *.map *.lst

startup.o:	startup.s $(MACROS)

startup.out:	startup.o $(OBJECTS) ../lib/libmuxx.a ../kernel/libkmuxx.a
	$(LD) $(LDFLAGS) $^ -o $@ $(LIBS) > startup.map
	$(SIZE) $@ --format=sysv -o 
