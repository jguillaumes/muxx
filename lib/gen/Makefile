.SUFFIXES: .lda .out .o .s .c

include ../../def.mk
MUXXBASE=../../
MUXXH=$(MUXXBASE)/h
LDFLAGS=-T ldkern.cmd -M --cref --traditional -lgcc -lpdp11
CFLAGS=-c -Wall -I $(MUXXH) -Os -fomit-frame-pointer -ffreestanding
ASMFLAGS=-acmghlsd -I $(MUXXH)

OBJECTS=malloc.o calloc.o sleep.o ctype_.o perror.o strlen.o alloca.o

.s.o:
	$(AS) $(ASMFLAGS) $< -o $@ > $*.lst


all:	done
	touch done

done:	$(OBJECTS)

clean:
	-rm *.a *.o *.lst done
