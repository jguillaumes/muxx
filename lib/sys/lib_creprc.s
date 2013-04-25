	.TITLE lib_syscalls - C bindindings for system calls
	.GLOBAL _creprc,_loadprc

	.INCLUDE "MACLIB.s"
	.INCLUDE "MUXXDEF.s"
	.INCLUDE "MUXXMAC.s"

	.text

_creprc:
	procentry saver2=no,saver3=no,saver4=no
	CREPRC	4(r5),6(r5),8(r5),10(r5)
	procexit  getr2=no,getr3=no,getr4=no

_loadprc:
	procentry saver2=no,saver3=no,saver4=no
	LOADPRC	4(r5),6(r5),8(r5),10(r5)
	procexit  getr2=no,getr3=no,getr4=no

	.end
