#ifndef _MUX_H

/*
** "Public" service calls
*/

#define SRV_CREPRC   1
#define SRV_DELPRC   2
#define SRV_CHGPRC   3
#define SRV_LOAD     4
#define SRV_UNLOAD   5
#define SRV_GETCORE  6
#define SRV_FREECORE 7
#define SRV_SUSPEND  8
#define SRV_AWAKE    9

#define SRV_OPEN    11
#define SRV_CLOSE   12
#define SRV_IOCTL   13
#define SRV_READ    14
#define SRV_WRITE   15
#define SRV_CREATE  16
#define SRV_DELETE  17

#define SRV_SEND    31
#define SRV_RECEIVE 32
#define SRV_CRESEM  33
#define SRV_DELSEM  34
#define SRV_INCSEM  35
#define SRV_DECSEM  36
#define SRV_GETSHM  37
#define SRV_FREESHM 38

/*
** Kernel service calls
*/
#define KRN_HALT     0

#define KRN_DRVREG   1
#define KRN_DRVUNREG 2
#define KRN_DEVSTOP  3

#define KRN_BUGCHECK 4
#define KRN_PRINTMSG 5

#define _MUX_H
#endif
