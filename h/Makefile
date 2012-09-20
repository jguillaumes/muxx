all:	MUXXDEF.s ERRNO.s config.h

clean:
	echo 

mrproper:
	-@rm *~

MUXXDEF.s:	muxxdef.h htos.awk
	awk -f htos.awk muxxdef.h > MUXXDEF.s


ERRNO.s:	errno.h htos.awk
	awk -f htos.awk errno.h > ERRNO.s

config.h:	CONFIG.s stoh.awk
	awk -f stoh.awk CONFIG.s > config.h
