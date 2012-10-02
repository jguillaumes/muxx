	.TITLE alloca - Get memory from current stack
	.IDENT "V01.00"

	.GLOBAL _alloca

/*
 * Copyright (c) 1987 Regents of the University of California.
 * All rights reserved.  The Berkeley software License Agreement
 * specifies the terms and conditions for redistribution.
 */


/* like alloc, but automatic free in return */



	
/*
 * We simply copy the size an return address down round(size, 2) down the
 * stack and return.  NOTE: if alloca is called in the middle of building an
 * argument list for a function call, the previously built arguments will
 * *not* be copied down below the new space, causing all sorts of nastiness.
 */

_alloca:	
	mov	(sp)+,r0	/ snatch return address
	mov	(sp)+,r1	/   and size
	sub	r1,sp		/ subtract size from stack
	bic	$1,sp		/   ensuring word alignment ...
	mov	r1,-(sp)	/ put size and return address back onto stack
	mov	r0,-(sp)
	mov	sp,r0		/ compute address of new area and return
	cmp	(r0)+,(r0)+
	rts	pc
