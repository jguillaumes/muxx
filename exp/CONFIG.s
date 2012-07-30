	.NOLIST

	/*
	** Interrupt vectors
	*/
	VEC.EMT		= 030		// Vector for EMT instruction
	VEC.TRAP	= 034		// Vector for TRAP instruction
	
	/*
	** PSW:	
	** 	0: 	C
	**	1: 	V
	**	2: 	Z
	**	3: 	N
	**	4: 	T
	**	5-7:	Priority (0-7, 7:inhibited)	
	**	8:	CIS Suspension
	**	9-10:	Reserved (MBZ)
	**	11:	GPR set
	**	12-13:	Previous mode  
	**	14-15:	Current mode
	**			00: Kernel
	**			01: Supervisor
	**			11: User
	*/
	
	/*
	** Console device registers
	*/
	CON.RCSR 	= 0177560	// DL11 receive control register
	CON.RBUF 	= 0177562	// DL11 receive buffer
	CON.XCSR 	= 0177564	// DL11 transmit control reg.
	CON.XBUF 	= 0177566	// DL11 transmit buffer

	/*
	** CPU registers
	*/
	CPU.PSW		= 0177776

	/*
	** MMU registers
	**
	** MMR0:
	** MMR1:
	** MMR2:
	** MMR3:
	** PAR:
	** PDR:
	**	0-2: Access Control Field
	**		000: No access (abort)
	**		001: Read access with trap on read (abort on write)
	**		010: Read access (abort on write)
	**		011: Unuse (aborts)
	**		100: Read/write (with trap on both read and write)
	**		101: Read/write (with trap on write)
	**		110: Read/write
	**		111: Unused (aborts)
	**	3:   Expansion direction (0: Up, 1: Down)
	**	4-5: Reserved (MBZ)
	**	6:   W: Modified page
	**	7:   A: One access caused trap per ACF value
	**	8-14:PLF (length), in 64 byte blocks
	**	15:  Bypass cache
	*/
	MMU.MMR0	= 0177572	// Mem. Mgt. Reg #0
	MMU.MMR1	= 0177574	// Mem. Mgt. Reg #1
	MMU.MMR2	= 0177576 	// Mem. Mgt. Reg #2
	MMU.MMR3	= 0172516	// Mem. Mgt. Reg #3

	MMU.UIDR0	= 0177600	// User I space descriptor reg
	MMU.UDSDR0	= 0177620	// User D space descriptor reg.
	MMU.UISAR0	= 0177640	// User I space address reg.
	MMU.UDSAR0	= 0177660	// User D space address reg.
	MMU.SISDR0	= 0172200	// Supervisor I space descriptor reg.
	MMU.SDDR0	= 0172220	// Supervisor D space descriptor reg.
	MMU.SISAR0	= 0172240	// Supervisor I space address reg.
	MMU.SDSAR0	= 0172260	// Supervisor D space address reg.
	MMU.KISDR0	= 0172300	// Kernel I space descriptor reg.
	MMU.KDSDR0	= 0172320	// Kernel D space descriptor reg.
	MMU.KISAR0	= 0172340	// Kernel I space address reg.
	MMU.KDSAR0	= 0172360	// Kernel D space address reg.
	.LIST
	