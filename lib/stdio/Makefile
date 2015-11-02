.SUFFIXES: .lda .out .o .s .c
include ../../def.mk

MUXXBASE=../../
MUXXH=$(MUXXBASE)/h
LDFLAGS=-T ldkern.cmd -M --cref --traditional -lgcc -lpdp11
CFLAGS=-c -Wall -I $(MUXXH) -Os -fomit-frame-pointer -ffreestanding
ASMFLAGS=-acmghlsd -I $(MUXXH)

OBJECTS=printf.o puts.o doprnt.o ffltpr.o strout.o putc.o

.s.o:
	$(AS) $(ASMFLAGS) $< -o $@ > $*.lst


all:	done
	touch done

done:	$(OBJECTS)

clean:
	-rm *.o *.lst done

mrproper:
	-rm *.o *.lst done *~
