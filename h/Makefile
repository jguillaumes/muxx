include ../def.mk

all:	MUXXDEF.s ERRORS.s config.h

clean:
	-rm MUXXDEF.s ERRORS.s config.h

mrproper:
	-@rm *~

MUXXDEF.s:	muxxdef.h htos.awk
	awk -f htos.awk muxxdef.h > MUXXDEF.s


ERRORS.s:	errors.h htos.awk
	awk -f htos.awk errors.h > ERRORS.s

config.h:	CONFIG.s stoh.awk
	awk -f stoh.awk CONFIG.s > config.h
