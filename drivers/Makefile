.SUFFIXES: .lda .out .o .s .c
include ../def.mk

LDFLAGS=-T ldaout.cmd -M --cref --traditional -lgcc -lpdp11
CFLAGS=-c -Wall -I../h -Os -ffreestanding -fomit-frame-pointer
ASMFLAGS=-acmghlsd -I../h
TARGETS=libmuxxdrv.a
OBJECTS=ptpdrv.o ptphnd.o lptdrv.o lpthnd.o

.out.lda:
	$(BIN2LOAD) -a -f $< -o $@

.s.o:
	$(AS) $(ASMFLAGS) $< -o $@ > $*.lst


all:	$(TARGETS)

clean:
	-rm *.a *.o *.lst &>/dev/null

mrproper:
	-rm *.a *.o *.lst *~ \#*\# &>/dev/null

libmuxxdrv.a:	$(OBJECTS)
	$(AR) rs $@ $^
