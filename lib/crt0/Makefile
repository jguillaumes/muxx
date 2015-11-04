.SUFFIXES: .lda .out .o .S .s .c
include ../../def.mk

MUXXBASE=../..
MUXXH=$(MUXXBASE)/h
LDFLAGS=-T ldkern.cmd -M --cref --traditional -lgcc -lpdp11
CFLAGS=-c -Wall -I $(MUXXH) -Os -fomit-frame-pointer
ASMFLAGS=-acmghlsd -I $(MUXXH)

OBJECTS=crt0.o

.s.o:
	$(AS) $(ASMFLAGS) $< -o $@ > $*.lst

.S.o:
	$(CC) $(CFLAGS) $< -o $@

all:	done
	touch done

done:	$(OBJECTS)		

clean:
	-rm *.a *.o *.lst done

mrproper:
	-rm *.a *.o *.lst done
