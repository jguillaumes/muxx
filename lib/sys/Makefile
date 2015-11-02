.SUFFIXES: .lda .out .o .s .c
include ../../def.mk

MUXXBASE=../../
MUXXH=$(MUXXBASE)/h
LDFLAGS=-T ldkern.cmd -M --cref --traditional -lgcc -lpdp11
CFLAGS=-c -Wall -I $(MUXXH) -Os -fomit-frame-pointer -ffreestanding
ASMFLAGS=-acmghlsd -I $(MUXXH)

OBJECTS=lib_externals.o lib_syscalls.o lib_getpid.o lib_mutex.o \
	lib_alloc.o lib_allocw.o lib_channels.o lib_openclose.o \
	lib_readwrite.o _readwrite.o lib_load.o lib_creprc.o

.s.o:
	$(AS) $(ASMFLAGS) $< -o $@ > $*.lst


all:	done
	touch done

done:	$(OBJECTS)

clean:
	-rm *.a *.o *.lst done

mrproper:
	-rm *.a *.o *.lst done
	-rm *~
