all:	MUXXDEF.s ERRNO.s


MUXXDEF.s:	muxxdef.h htos.awk
	awk -f htos.awk < muxxdef.h > MUXXDEF.s


ERRNO.s:	errno.h htos.awk
	awk -f htos.awk < errno.h > ERRNO.s