	.TITLE lib_alloc - C bindings for ALLOC system calls
	.IDENT "V01.00"

	.GLOBAL _alloc,_allocw
	
	.INCLUDE "MACLIB.s"
	.INCLUDE "MUXXDEF.s"
	.INCLUDE "MUXXMAC.s"
	.INCLUDE "ERRNO.s"
	
	.text

_alloc:
	procentry saver2=no,saver3=no,saver4=no
	ALLOC     4(r5),6(r5)
	procexit  getr2=NO,getr3=no,getr4=no
	
_allocw:
	procentry saver2=no,saver3=no,saver4=no
10$:	ALLOC	4(r5),6(r5)
	cmp	$ENOAVAIL,r0
	bne 	20$
	YIELD
	br	10$
20$:	procexit  getr2=no,getr3=no,getr4=no

	.end
