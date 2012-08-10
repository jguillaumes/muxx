	.NOLIST 
/*
 * This is a generated file - DO NOT EDIT 
 * Edit the .h file and run "make" to regenerate the .s
*/
/*
** "Public" service calls
*/
	KRN_HALT = 0
	SRV_CREPRC = 1
	SRV_DELPRC = 2
	SRV_CHGPRC = 3
	SRV_LOAD = 4
	SRV_UNLOAD = 5
	SRV_GETCORE = 6
	SRV_FREECORE = 7
	SRV_SUSPEND = 8
	SRV_AWAKE = 9
	SRV_OPEN = 10
	SRV_CLOSE = 11
	SRV_IOCTL = 12
	SRV_READ = 13
	SRV_WRITE = 14
	SRV_CREATE = 15
	SRV_DELETE = 16
	SRV_SEND = 17
	SRV_RECEIVE = 18
	SRV_CRESEM = 19
	SRV_DELSEM = 20
	SRV_INCSEM = 21
	SRV_DECSEM = 22
	SRV_GETSHM = 23
	SRV_FREESHM = 24
	SRV_LAST = 24
/*
** Kernel service calls
*/
	KRN_DRVREG = (SRV_LAST+1)
	KRN_DRVUNREG = (SRV_LAST+2)
	KRN_DEVSTOP = (SRV_LAST+3)
	KRN_BUGCHECK = (SRV_LAST+4)
	KRN_PUTCON = (SRV_LAST+5)
	KRN_GETCON = (SRV_LAST+6)
	KRN_PANIC = (SRV_LAST+7)
/*
** Task types
*/
	SYS_TASK = 0
	USR_TASK = 1
/*
** Task states
*/
	TSK_INIT = 0
	TSK_READY = 1
	TSK_BLOCKED = 2
	TSK_RUN = 3
	TSK_DISPOSE = 4
/*
** Kernel configuration constants
*/
	.LIST 
