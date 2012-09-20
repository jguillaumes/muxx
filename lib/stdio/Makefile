.SUFFIXES: .lda .out .o .s .c

MUXXBASE=../../
MUXXH=$(MUXXBASE)/h
BIN2LOAD=/home/jguillaumes/retroutils/bin2load/bin2load
AS=pdp11-aout-as
CC=pdp11-aout-gcc
LD=pdp11-aout-ld
AR=pdp11-aout-ar
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
	-@rm *.o *.lst done

mrproper:
	-@rm *.o *.lst done *~
