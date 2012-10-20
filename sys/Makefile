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
TASKS=taska.out taskb.out taskc.out taskd.out
KTASKS=startup.o 

.out.lda:	
	$(BIN2LOAD) -a -f $< -o $@

.s.o:
	$(AS) $(ASMFLAGS) $< -o $@ -ald > $*.lst

all: muxx.lda tasks.tap

clean:
	-@rm *.o *.out *.lda *.map *.lst *.tap

mrproper:
	-@rm *.o *.out *.lda *.map *.lst *.tap *~

muxx.o:	muxx.s $(MACROS)

muxx.out:	muxx.o $(KTASKS) ../lib/libmuxx.a ../kernel/libkmuxx.a ../shell/libshell.a
	$(LD) -T ldkern.cmd $(LDFLAGS) muxx.o $(KTASKS) -o $@ --start-group $(LIBS) --end-group > muxx.map
	$(STRIP) $@
	$(SIZE) $@ --format=sysv -o 

.o.out:
	$(LD) -T ldtask.cmd $(LDFLAGS) $^ -o $@ $(LIBS) > $@.map
	$(STRIP) $@
	$(SIZE) $@ --format=sysv -o 

tasks.tap:	$(TASKS)
	cat $^ > tasks.tap
	echo "$@ has been rebuilt"
