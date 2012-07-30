.SUFFIXES: .lda .out .o .s .c

BIN2LOAD=/home/jguillaumes/retroutils/bin2load/bin2load
AS=pdp11-aout-as
CC=pdp11-aout-gcc
LD=pdp11-aout-ld
LDFLAGS=-T ldaout.cmd -M --cref --traditional
CCFLAGS=-c -O3
ASMFLAGS=-aghls -am

CONIO=muxx_consvc.o congtstr.o conptstr.o
MMU=mmu.o
MUXX=$(CONIO) $(MMU) muxxlib.o muxxstart.o muxx_init.o


.out.lda:	
	$(BIN2LOAD) -a -f $< -o $@

.s.o:
	$(AS) $(ASMFLAGS) $< -o $@ -ald > $*.lst


all: pdpreadstr.lda

clean:
	rm *.o *.out *.lda *.map *.lst

pdpreadstr.out:	pdpreadstr.o $(MUXX)
	$(LD) $(LDFLAGS) $^ -o $@ > pdpreadstr.map
