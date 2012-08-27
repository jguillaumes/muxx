#ifndef _MUXDEF_H

/*
** "Public" service calls
*/
#define KRN_HALT     0
#define SRV_CREPRC   1
#define SRV_DELPRC   2
#define SRV_CHGPRC   3
#define SRV_LOAD     4
#define SRV_UNLOAD   5
#define SRV_GETCORE  6
#define SRV_FREECORE 7
#define SRV_SUSPEND  8
#define SRV_AWAKE    9
#define SRV_OPEN    10
#define SRV_CLOSE   11
#define SRV_IOCTL   12
#define SRV_READ    13
#define SRV_WRITE   14
#define SRV_CREATE  15
#define SRV_DELETE  16
#define SRV_SEND    17
#define SRV_RECEIVE 18
#define SRV_CRESEM  19
#define SRV_DELSEM  20
#define SRV_INCSEM  21
#define SRV_DECSEM  22
#define SRV_GETSHM  23
#define SRV_FREESHM 24
#define SRV_YIELD   25
#define SRV_GETTPI  26
#define SRV_LAST    26

/*
** Kernel service calls
*/
#define KRN_DRVREG   (SRV_LAST+1)
#define KRN_DRVUNREG (SRV_LAST+2)
#define KRN_DEVSTOP  (SRV_LAST+3)
#define KRN_BUGCHECK (SRV_LAST+4)
#define KRN_PUTCON   (SRV_LAST+5)
#define KRN_GETCON   (SRV_LAST+6)
// #define KRN_PANIC    (SRV_LAST+7)

/*
** Task types
*/
#define SYS_TASK     0
#define USR_TASK     1

/*
** Task states
*/
#define TSK_INIT     0
#define TSK_READY    1
#define TSK_BLOCKED  2
#define TSK_RUN      3
#define TSK_SUSP     4
#define TSK_DISPOSE  5

/*
** System latches
*/
#define LTC_LATCHES 16
#define LTC_READYQ   1
#define LTC_BLOCKQ   2
#define LTC_SUSPNQ   3
#define LTC_MCB      4

#define _MUXDEF_H
#endif
