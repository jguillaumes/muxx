/*
 * Copyright (c) 1987 Regents of the University of California.
 * All rights reserved.  The Berkeley software License Agreement
 * specifies the terms and conditions for redistribution.
*
* Changes: Copyright (c) 2012 Jordi Guillaumes Pons
*/


/*
 * Fake floating output support for doprnt. 
 */

.globl	pgen, pfloat, pscien

pfloat:
pscien:
pgen:
	add	$8,r4		/ Simply output a "?"
	movb	$'?,(r3)+
	rts	pc
