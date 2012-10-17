.SUFFIXES: .lda .out .o .s .c

BIN2LOAD=bin2load
AS=pdp11-aout-as
CC=pdp11-aout-gcc
LD=pdp11-aout-ld
SIZE=pdp11-aout-size
STRIP=pdp11-aout-strip
LIBS=-L../lib -lmuxx -L../kernel -lkmuxx -L../drivers -lmuxxdrv -L../shell -lshell -lgcc -lpdp11 
LDFLAGS=-M --cref --traditional 
CFLAGS=-c -Os -ffreestanding -I../h -fomit-frame-pointer
ASMFLAGS=-aghls -am -I../h 
MACROS=../h/SCB.s ../h/MUXXDEF.s ../h/MACLIB.s ../h/MUXXMAC.s

.out.lda:	
	$(BIN2LOAD) -a -f $< -o $@

.s.o:
	$(AS) $(ASMFLAGS) $< -o $@ -ald > $*.lst

all: muxx.lda taskc.lda

clean:
	-@rm *.o *.out *.lda *.map *.lst

mrproper:
	-@rm *.o *.out *.lda *.map *.lst *~

muxx.o:	muxx.s $(MACROS)

muxx.out:	muxx.o startup.o ../lib/libmuxx.a ../kernel/libkmuxx.a ../shell/libshell.a
	$(LD) -T ldkern.cmd $(LDFLAGS) muxx.o startup.o -o $@ --start-group $(LIBS) --end-group > muxx.map
	$(STRIP) $@
	$(SIZE) $@ --format=sysv -o 

taskc.out:	taskc.o ../lib/libmuxx.a ../kernel/libkmuxx.a
	$(LD) -T ldtask.cmd $(LDFLAGS) $^ -o $@ $(LIBS) > taskc.map
	$(STRIP) $@
	$(SIZE) $@ --format=sysv -o 
