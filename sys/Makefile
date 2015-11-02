.SUFFIXES: .lda .out .o .s .c
include ../def.mk

#	$(AS) $(ASMFLAGS) $< -o $@ -ald > $*.lst

LIBS=-L../lib -lmuxx -L../kernel -lkmuxx -L../drivers -lmuxxdrv -L../shell -lshell  -L $(GCCPATH)/lib/gcc/pdp11-aout/$(GCCVERSION) -lgcc
LDFLAGS=-M --cref --traditional
CFLAGS=-c -Os -ffreestanding -I../h -fomit-frame-pointer
ASMFLAGS=-aghls -am -I../h
MACROS=../h/SCB.s ../h/MUXXDEF.s ../h/MACLIB.s ../h/MUXXMAC.s
TASKS=startup.out taska.out taskb.out taskc.out taskd.out
KTASKS=init.o

.out.lda:
	$(BIN2LOAD) -a -f $< -o $@

.s.o:
	$(AS) $(ASMFLAGS) $< -o $@ -ald > $*.lst

all: muxx.lda tasks.tap

clean:
	-rm *.o *.out *.lda *.map *.lst *.tap printer.txt

mrproper:
	-rm *.o *.out *.lda *.map *.lst *.tap *~ printer.txt

sys.o:	sys.s $(MACROS)
	$(AS) $(ASMFLAGS) $< -o $@ -ald > $*.lst

muxx.out:	sys.o $(KTASKS) ../lib/libmuxx.a ../kernel/libkmuxx.a ../shell/libshell.a
	$(LD) -T ldkern.cmd $(LDFLAGS) sys.o $(KTASKS) -o $@ --start-group $(LIBS) --end-group > muxx.map
	$(STRIP) $@
	$(SIZE) $@ --format=sysv -o

.o.out:
	$(LD) -T ldtask.cmd $(LDFLAGS) $^ -o $@ $(LIBS) > $@.map
	$(STRIP) $@
	$(SIZE) $@ --format=sysv -o

tasks.tap:	$(TASKS)
	cat $^ > tasks.tap
	echo "$@ has been rebuilt"
