	.TITLE muxxlib - C bindings for the system services
	.IDENT "V01.00"

	.INCLUDE "MUXXMAC.s"

	.GLOBAL _conptchr
	.GLOBAL _congtchr


_conptchr:	CONPTCHR 4(sp)
		rts	pc

_congtchr:	CONGTCHR
		rts	pc

		.END
