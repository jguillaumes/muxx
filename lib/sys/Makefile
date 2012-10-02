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

OBJECTS=lib_externals.o lib_syscalls.o lib_getpid.o lib_mutex.o \
	lib_alloc.o lib_allocw.o lib_channels.o lib_openclose.o lib_write.o \
	_write.o

.s.o:
	$(AS) $(ASMFLAGS) $< -o $@ > $*.lst


all:	done
	touch done

done:	$(OBJECTS)

clean:
	-@rm *.a *.o *.lst done

mrproper:
	-@rm *.a *.o *.lst done
	-@rm *~ 
