	.TITLE lib_channels - C bindings for open() and close() syscalls
	.IDENT "V01.00"
	.GLOBAL __open,__close

	.INCLUDE "MUXXDEF.s"
	.INCLUDE "MUXXMAC.s"
	.INCLUDE "MACLIB.s"

__open:	procentry saver2=no,saver3=no,saver4=no
	OPEN	devnam=4(r5),flags=6(r5)
	procexit  getr2=no,getr3=no,getr4=no

__close: procentry saver2=no,saver3=no,saver4=no
	CLOSE	fd=4(r5)
	procexit  getr2=no,getr3=no,getr4=no

	.end
