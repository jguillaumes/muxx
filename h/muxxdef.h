#ifndef _MUXDEF_H

/*
** "Public" service calls
*/
#define KRN_HALT     0    // System halt
#define SRV_CREPRC   1    // Create process
#define SRV_DELPRC   2    // Delete process
#define SRV_CHGPRC   3    // Change (modify) process
#define SRV_LOADPRC  4    // Create process and load task
#define SRV_UNLOAD   5    // Unload (remove) task
#define SRV_GETCORE  6    // Get physical memory
#define SRV_FREECORE 7    // Free physical memory
#define SRV_SUSPEND  8    // Suspend process 
#define SRV_AWAKE    9    // Awake (unsuspend) process
#define SRV_OPEN    10    // Open channel (to device)
#define SRV_CLOSE   11    // Close channel (to device)
#define SRV_IOCTL   12    // Send control command to device
#define SRV_READ    13    // Read (from channel)
#define SRV_WRITE   14    // Write (to channel)
#define SRV_CREATE  15    // Create logical file
#define SRV_DELETE  16    // Delete logical file
#define SRV_SEND    17    // Send IPC message (synchronous) 
#define SRV_RECEIVE 18    // Listen to receive IPC message (synchronous)
#define SRV_CRESEM  19    // Create semaphore
#define SRV_DELSEM  20    // Delete semaphore
#define SRV_INCSEM  21    // Increment semaphore value
#define SRV_DECSEM  22    // Decrement semaphore value
#define SRV_GETSHM  23    // Get shared memory blocks
#define SRV_FREESHM 24    // Free shared memory blocks
#define SRV_MUTEX   25    // Lock/Unlock/Read MUTEX
#define SRV_YIELD   26    // Yield processor
#define SRV_GETTPI  27    // Get task and process information
#define SRV_EXIT    28    // Exit task
#define SRV_ABORT   29    // Abort task
#define SRV_ALLOC   30    // Allocate/deallocate device
#define SRV_LAST    30

/*
** Kernel service calls
*/
#define KRN_DRVREG   (SRV_LAST+1)    // Register device driver
#define KRN_DRVUNREG (SRV_LAST+2)    // Unregister device driver
#define KRN_DRVSTART (SRV_LAST+3)    // Start device driver
#define KRN_DRVSTOP  (SRV_LAST+4)    // Stop device driver
#define KRN_BUGCHECK (SRV_LAST+5)    // Cause a bugcheck error
#define KRN_PUTCON   (SRV_LAST+6)    // Put character to system console
#define KRN_GETCON   (SRV_LAST+7)    // Get character from system console
#define KRN_XCOPY    (SRV_LAST+8)    // Copy memory between processes
#define KRN_PROTMEM  (SRV_LAST+9)    // Change memory page protection

/*
** Task types
*/
#define SYS_TASK     0000000         // System task
#define USR_TASK     0000001         // User task
#define DRV_TASK     0000002         // Device driver handler task

/*
** Task code+static size bitmasks
*/
#define TSZ_SMALL    0000000         //  8 KB task (1 page)
#define TSZ_MED      0000010         // 16 KB task (2 pages)
#define TSZ_BIG      0000020         // 24 KB task (3 pages)

/*
** Task stack size bitmasks
*/
#define TSZ_SMALLS   0000000         //  3KB user + 1 KB kernel ( 1/2 page  )
#define TSZ_MEDS     0000100         //  6KB user + 2 KB kernel ( 1   page  )
#define TSZ_BIGS     0000200         // 12KB user + 4 KB kernel ( 2   pages )

/*
** Task states
*/
#define TSK_INIT     0               // Task is ready to start 
#define TSK_READY    1               // Task is ready to run
#define TSK_BLOCKED  2               // Task is blocked
#define TSK_RUN      3               // Task is now running
#define TSK_SUSP     4               // Task is suspended
#define TSK_DISPOSE  5               // Task finished, waiting deletion

/*
** System mutexes
*/
#define MUT_MUTEXES 16       // Number of system mutexes
#define MUT_READYQ   1       // Ready Queue manipulation
#define MUT_BLOCKQ   2       // Blocked Queue manipulation
#define MUT_SUSPNQ   3       // Suspended Queue manipulation
#define MUT_MCB      4       // Memory control block manipulation
#define MUT_DRV      5       // Device driver manipulation
#define MUT_CHAN     6       // Channel manipulation

#define MUT_READ     0
#define MUT_ALLOC    1
#define MUT_DEALLOC  2

/*
** Driver descriptor attribute bits
*/
#define DRVDESC_SHAREABLE 0x0001
#define DRVDESC_RECORD    0x0002
#define DRVDESC_FILES     0x0004
#define DRVDESC_BUFFERED  0x0008

/*
** Device driver callbacks and functions
*/
#define DRV_START     0
#define DRV_STOP      1
#define DRV_OPEN      2
#define DRV_CLOSE     3
#define DRV_READ      4
#define DRV_WRITE     5
#define DRV_IOCTL     6
#define DRV_QUERY     7
#define DRV_SEEK      8
#define DRV_FLUSH     9

#define DRV_ALLOC     0
#define DRV_DEALLOC   1

/*
** DRVCB offsets and constants
*/
#define DRV_DESCSIZE  40
#define DRV_DRVNAME   0
#define DRV_DESC      8
#define DRV_FLAGS     (DRV_DESC+2)
#define DRV_TASKID    (DRV_FLAGS+2)
#define DRV_OWNERID   (DRV_TASKID+2)
#define DRV_STATUS    (DRV_OWNERID+2)

/*
** IOPKT offsets
*/
#define IOP_FUNCTION  0
#define IOP_ERROR     2
#define IOP_PARAMS    4
#define IOP_SIZE      12
#define IOP_IOAREA    14

/*
** IOT offsets and definitions
*/
#define IOT_SIZE       16
#define IOT_DRIVER      0
#define IOT_STATUS      2
#define IOT_POSITION    6
#define IOT_CONTROLLER  8
#define IOT_UNIT        9
#define IOT_ERROR      10
#define IOT_ATTRADDR   12
#define IOT_BUFFADDR   14

/*
** OPEN flags
*/
#define OO_READ      0         // Open file for reading
#define OO_WRITE     1         // Open file for writing
#define OO_CREATE    2         // Create file if it does not exist
#define OO_TRUNC     4         // Truncate file if it exists
#define OO_TEMP      8         // Delete on close
#define OO_UNBUFF   16         // Force unbuffered mode
#define OO_STREAM   32         // Force stream mode (for record devices)


/*
** Named local flags
*/
#define LEF_TT      0          // Terminal related 
#define LEF_PT      1          // Paper tape related
#define LEF_DK      2          // Disk related
#define LEF_MT      3          // Magtape related
#define LEF_ET      4          // Ethernet related (someday)
#define LEF_TM      5          // Timer related
                               // 6:15 reserved to MUXX
#define LEF_USR     16         // First used-available flag


/*
** Constants for memory management bits
*/

#define PDR_ACC_RW 0x0006      // Read-write access
#define PDR_ACC_RO 0x0002      // Read-only access
#define PDR_ACC_NA 0x0000      // No access

#define PDR_DIR_UP 0x0000      // Page grows upwards
#define PDR_DIR_DN 0x0008      // Page grows downwards (stack)

#define PDR_SIZ_0K 0x0000      // Empty page
#define PDR_SIZ_1K 0x1000      // 1 Kilobyte 
#define PDR_SIZ_2K 0x2000      // 2 Kilobytes
#define PDR_SIZ_4K 0x4000      // 4 Kilobytes
#define PDR_SIZ_8K 0x7F00      // 8 Kilobytes

#define MMCB_FLG_SHR 0x0001    // Shared page
#define MMCB_FLG_FIX 0x0002    // Fixed page (not moveable in physical memory)
#define MMCB_FLG_PRV 0x0004    // Accessible just from priv. tasks (operprv)
#define MMCB_FLG_IO  0x0008    // IO space page (needs ioprv)
#define MMCB_FLG_STK 0x0010    // Stack page
#define MMCB_FLG_BUF 0x0020    // Buffer page

/*
** Constants for TCB bits
*/

#define TSK_SENDING    0x0001  // Task is sending a message, blocked till recv
#define TSK_RECEIVING  0x0002  // Task is receiving a message
#define TSK_SUSPENDED  0x0004  // Task is suspended
#define TSK_MSGWAIT    0x0008  // Task is wating for a message

#define TSK_OPERPRV    0x0001  // Oper privilege, can access anything
#define TSK_IOPRV      0x0002  // IO Privilege, can access IOspace
#define TSK_AUDITPRV   0x0004  // Audit priv, can read anything

#define _MUXDEF_H
#endif
