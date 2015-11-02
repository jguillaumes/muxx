.SUFFIXES: .lda .out .o .s .c
include ../../def.mk

MUXXBASE=../../
MUXXH=$(MUXXBASE)/h
LDFLAGS=-T ldkern.cmd -M --cref --traditional -lgcc -lpdp11
CFLAGS=-c -Wall -I $(MUXXH) -Os -ffreestanding -fomit-frame-pointer
ASMFLAGS=-acmghlsd -I $(MUXXH)

TARGETS=../libmuxx.a
OBJECTS=sbrk.o

.s.o:
	$(AS) $(ASMFLAGS) $< -o $@ > $*.lst


all:	done
	touch done

done:	$(OBJECTS)

clean:
	-rm *.a *.o *.lst done
