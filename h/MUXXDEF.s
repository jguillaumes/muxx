	.NOLIST 
/*
 * This is a generated file - DO NOT EDIT 
 * Edit the .h file and run "make" to regenerate the .s
*/
/*
** "Public" service calls
*/
KRN_HALT = 0		// System halt
SRV_CREPRC = 1		// Create process
SRV_DELPRC = 2		// Delete process
SRV_CHGPRC = 3		// Change (modify) process
SRV_LOAD = 4		// Load task
SRV_UNLOAD = 5		// Unload (remove) task
SRV_GETCORE = 6		// Get physical memory
SRV_FREECORE = 7		// Free physical memory
SRV_SUSPEND = 8		// Suspend process 
SRV_AWAKE = 9		// Awake (unsuspend) process
SRV_OPEN = 10		// Open channel (to device)
SRV_CLOSE = 11		// Close channel (to device)
SRV_IOCTL = 12		// Send control command to device
SRV_READ = 13		// Read (from channel)
SRV_WRITE = 14		// Write (to channel)
SRV_CREATE = 15		// Create logical file
SRV_DELETE = 16		// Delete logical file
SRV_SEND = 17		// Send IPC message (synchronous) 
SRV_RECEIVE = 18		// Listen to receive IPC message (synchronous)
SRV_CRESEM = 19		// Create semaphore
SRV_DELSEM = 20		// Delete semaphore
SRV_INCSEM = 21		// Increment semaphore value
SRV_DECSEM = 22		// Decrement semaphore value
SRV_GETSHM = 23		// Get shared memory blocks
SRV_FREESHM = 24		// Free shared memory blocks
SRV_MUTEX = 25		// Lock/Unlock/Read MUTEX
SRV_YIELD = 26		// Yield processor
SRV_GETTPI = 27		// Get task and process information
SRV_EXIT = 28		// Exit task
SRV_ABORT = 29		// Abort task
SRV_ALLOC = 30		// Allocate/deallocate device
SRV_LAST = 30
/*
** Kernel service calls
*/
KRN_DRVREG = (SRV_LAST+1)		// Register device driver
KRN_DRVUNREG = (SRV_LAST+2)		// Unregister device driver
KRN_DRVSTART = (SRV_LAST+3)		// Start device driver
KRN_DRVSTOP = (SRV_LAST+4)		// Stop device driver
KRN_BUGCHECK = (SRV_LAST+5)		// Cause a bugcheck error
KRN_PUTCON = (SRV_LAST+6)		// Put character to system console
KRN_GETCON = (SRV_LAST+7)		// Get character from system console
/*
** Task types
*/
SYS_TASK = 0000000		// System task
USR_TASK = 0000001		// User task
DRV_TASK = 0000002		// Device driver handler task
/*
** Task code+static size bitmasks
*/
TSZ_SMALL = 0000000		//  8 KB task (1 page)
TSZ_MED = 0000010		// 16 KB task (2 pages)
TSZ_BIG = 0000020		// 24 KB task (3 pages)
/*
** Task stack size bitmasks
*/
TSZ_SMALLS = 0000000		//  3KB user + 1 KB kernel ( 1/2 page  )
TSZ_MEDS = 0000100		//  6KB user + 2 KB kernel ( 1   page  )
TSZ_BIGS = 0000200		// 12KB user + 4 KB kernel ( 2   pages )
/*
** Task states
*/
TSK_INIT = 0		// Task is ready to start 
TSK_READY = 1		// Task is ready to run
TSK_BLOCKED = 2		// Task is blocked
TSK_RUN = 3		// Task is now running
TSK_SUSP = 4		// Task is suspended
TSK_DISPOSE = 5		// Task finished, waiting deletion
/*
** System mutexes
*/
MUT_MUTEXES = 16		// Number of system mutexes
MUT_READYQ = 1		// Ready Queue manipulation
MUT_BLOCKQ = 2		// Blocked Queue manipulation
MUT_SUSPNQ = 3		// Suspended Queue manipulation
MUT_MCB = 4		// Memory control block manipulation
MUT_DRV = 5		// Device driver manipulation
MUT_CHAN = 6		// Channel manipulation
MUT_READ = 0
MUT_ALLOC = 1
MUT_DEALLOC = 2
/*
** Driver descriptor attribute bits
*/
DRVDESC_SHAREABLE = 0x0001
DRVDESC_RECORD = 0x0002
DRVDESC_FILES = 0x0004
DRVDESC_BUFFERED = 0x0008
/*
** Device driver callbacks and functions
*/
DRV_START = 0
DRV_STOP = 1
DRV_OPEN = 2
DRV_CLOSE = 3
DRV_READ = 4
DRV_WRITE = 5
DRV_IOCTL = 6
DRV_QUERY = 7
DRV_SEEK = 8
DRV_FLUSH = 9
DRV_ALLOC = 0
DRV_DEALLOC = 1
/*
** DRVCB offsets and constants
*/
DRV_DESCSIZE = 40
DRV_DRVNAME = 0
DRV_DESC = 8
DRV_FLAGS = (DRV_DESC+2)
DRV_TASKID = (DRV_FLAGS+2)
DRV_OWNERID = (DRV_TASKID+2)
DRV_STATUS = (DRV_OWNERID+2)
/*
** IOPKT offsets
*/
IOP_FUNCTION = 0
IOP_ERROR = 2
IOP_PARAMS = 4
IOP_SIZE = 12
IOP_IOAREA = 14
/*
** IOT offsets and definitions
*/
IOT_SIZE = 16
IOT_DRIVER = 0
IOT_STATUS = 2
IOT_POSITION = 6
IOT_CONTROLLER = 8
IOT_UNIT = 9
IOT_ERROR = 10
IOT_ATTRADDR = 12
IOT_BUFFADDR = 14
/*
** OPEN flags
*/
OO_READ = 0		// Open file for reading
OO_WRITE = 1		// Open file for writing
OO_CREATE = 2		// Create file if it does not exist
OO_TRUNC = 4		// Truncate file if it exists
OO_TEMP = 8		// Delete on close
OO_UNBUFF = 16		// Force unbuffered mode
OO_STREAM = 32		// Force stream mode (for record devices)
/*
** Named local flags
*/
LEF_TT = 0		// Terminal related 
LEF_PT = 1		// Paper tape related
LEF_DK = 2		// Disk related
LEF_MT = 3		// Magtape related
LEF_ET = 4		// Ethernet related (someday)
LEF_TM = 5		// Timer related
LEF_USR = 16		// First used-available flag
/*
** Constants for memory management bits
*/
PDR_ACC_RW = 0x0006		// Read-write access
PDR_ACC_RO = 0x0004		// Read-only access
PDR_ACC_NA = 0x0000		// No access
PDR_DIR_UP = 0x0000		// Page grows upwards
PDR_DIR_DN = 0x0008		// Page grows downwards (stack)
PDR_SIZ_0K = 0x0000		// Empty page
PDR_SIZ_1K = 0x1000		// 1 Kilobyte 
PDR_SIZ_2K = 0x2000		// 2 Kilobytes
PDR_SIZ_4K = 0x4000		// 4 Kilobytes
PDR_SIZ_8K = 0x7F00		// 8 Kilobytes
MMCB_FLG_SHR = 0x0001		// Shared page
MMCB_FLG_FIX = 0x0002		// Fixed page (not moveable in physical memory)
MMCB_FLG_PRV = 0x0004		// Accessible just from priv. tasks (operprv)
MMCB_FLG_IO = 0x0008		// IO space page (needs ioprv)
MMCB_FLG_STK = 0x0010		// Stack page
MMCB_FLG_BUF = 0x0020		// Buffer page
/*
** Constants for TCB bits
*/
TSK_SENDING = 0x0001		// Task is sending a message, blocked till recv
TSK_RECEIVING = 0x0002		// Task is receiving a message
TSK_SUSPENDED = 0x0004		// Task is suspended
TSK_MSGWAIT = 0x0008		// Task is wating for a message
TSK_OPERPRV = 0x0001		// Oper privilege, can access anything
TSK_IOPRV = 0x0002		// IO Privilege, can access IOspace
TSK_AUDITPRV = 0x0004		// Audit priv, can read anything
	.LIST 
