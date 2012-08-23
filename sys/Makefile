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
OBJECTS=taska.o taskb.o startup.o

.out.lda:	
	$(BIN2LOAD) -a -f $< -o $@

.s.o:
	$(AS) $(ASMFLAGS) $< -o $@ -ald > $*.lst

all: muxx.lda

clean:
	rm *.o *.out *.lda *.map *.lst

mrproper:
	rm *.o *.out *.lda *.map *.lst *~

muxx.o:	muxx.s $(MACROS)

muxx.out:	muxx.o $(OBJECTS) ../lib/libmuxx.a ../kernel/libkmuxx.a
	$(LD) $(LDFLAGS) $^ -o $@ $(LIBS) > muxx.map
	$(SIZE) $@ --format=sysv -o 
