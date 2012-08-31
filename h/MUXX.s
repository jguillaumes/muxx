	.NOLIST
	/*
	** Offsets into TCB fields
	*/
	TCB.TASKNAME	= 0
	TCB.PID		= 8
	TCB.PPID	= 10
	TCB.UIC		= 12
	TCB.STATUS	= 16
	TCB.FLAGS	= 18
	TCB.PRIVILEGES	= 20
	TCB.TASKTYPE	= 22
	TCB.FIRSTCHILD	= 24
	TCB.LASTCHILD	= 26
	TCB.NEXTSIBLING	= 28
	TCB.NEXTINQUEUE	= 30
	TCB.PREVINQUEUE	= 32
	TCB.CPUSTATE	= 34
	
	TCB.R0 = (TCB.CPUSTATE + 0)
	TCB.R1 = (TCB.CPUSTATE + 2)
	TCB.R2 = (TCB.CPUSTATE + 4)
	TCB.R3 = (TCB.CPUSTATE + 6)
	TCB.R4 = (TCB.CPUSTATE + 8)
	TCB.R5 = (TCB.CPUSTATE + 10)
	TCB.R6 = (TCB.CPUSTATE + 12)
	TCB.SP = TCB.R6
	TCB.R7 = (TCB.CPUSTATE + 14)
	TCB.PC = TCB.R7
	TCB.PSW = (TCB.CPUSTATE + 16)
	TCB.USP = (TCB.CPUSTATE + 18)
	TCB.SSP = (TCB.CPUSTATE + 20)
	TCB.KSP = (TCB.CPUSTATE + 22)

	TCB.MMUSTATE = (TCB.CPUSTATE + 24)

	TCB.UPAR = (TCB.MMUSTATE + 0)
	
	TCB.UPAR0 = (TCB.UPAR + 0)
	TCB.UPAR1 = (TCB.UPAR + 2)
	TCB.UPAR2 = (TCB.UPAR + 4)
	TCB.UPAR3 = (TCB.UPAR + 6)
	TCB.UPAR4 = (TCB.UPAR + 8)
	TCB.UPAR5 = (TCB.UPAR + 10)
	TCB.UPAR6 = (TCB.UPAR + 12)
	TCB.UPAR7 = (TCB.UPAR + 14)

	TCB.UPDR = (TCB.UPAR + 16)
	
	TCB.UPDR0 = (TCB.UPDR + 0)
	TCB.UPDR1 = (TCB.UPDR + 2)
	TCB.UPDR2 = (TCB.UPDR + 4)
	TCB.UPDR3 = (TCB.UPDR + 6)
	TCB.UPDR4 = (TCB.UPDR + 8)
	TCB.UPDR5 = (TCB.UPDR + 10)
	TCB.UPDR6 = (TCB.UPDR + 12)
	TCB.UPDR7 = (TCB.UPDR + 14)

	.if CPU_HAS_SUPER == 1
	.print "Assembling with supervisor mode support"
	TCB.SPAR = (TCB.UPDR + 16)
	
	TCB.SPAR0 = (TCB.SPAR + 0)
	TCB.SPAR1 = (TCB.SPAR + 2)
	TCB.SPAR2 = (TCB.SPAR + 4)
	TCB.SPAR3 = (TCB.SPAR + 6)
	TCB.SPAR4 = (TCB.SPAR + 8)
	TCB.SPAR5 = (TCB.SPAR + 10)
	TCB.SPAR6 = (TCB.SPAR + 12)
	TCB.SPAR7 = (TCB.SPAR + 14)

	TCB.SPDR = (TCB.SPAR + 16)

	TCB.SPDR0 = (TCB.SPDR + 0)
	TCB.SPDR1 = (TCB.SPDR + 2)
	TCB.SPDR2 = (TCB.SPDR + 4)
	TCB.SPDR3 = (TCB.SPDR + 6)
	TCB.SPDR4 = (TCB.SPDR + 8)
	TCB.SPDR5 = (TCB.SPDR + 10)
	TCB.SPDR6 = (TCB.SPDR + 12)
	TCB.SPDR7 = (TCB.SPDR + 14)
	
	TCB.KPAR = (TCB.SPDR + 16)
	.else
	.print "Assembling without supervisor mode support"
	TCB.KPAR = (TCB.UPDR + 16)
	.endif
	
	TCB.KPAR0 = (TCB.KPAR + 0)
	TCB.KPAR1 = (TCB.KPAR + 2)
	TCB.KPAR2 = (TCB.KPAR + 4)
	TCB.KPAR3 = (TCB.KPAR + 6)
	TCB.KPAR4 = (TCB.KPAR + 8)
	TCB.KPAR5 = (TCB.KPAR + 10)
	TCB.KPAR6 = (TCB.KPAR + 12)
	TCB.KPAR7 = (TCB.KPAR + 14)

	TCB.KPDR = (TCB.KPAR + 16)

	TCB.KPDR0 = (TCB.KPDR + 0)
	TCB.KPDR1 = (TCB.KPDR + 2)
	TCB.KPDR2 = (TCB.KPDR + 4)
	TCB.KPDR3 = (TCB.KPDR + 6)
	TCB.KPDR4 = (TCB.KPDR + 8)
	TCB.KPDR5 = (TCB.KPDR + 10)
	TCB.KPDR6 = (TCB.KPDR + 12)
	TCB.KPDR7 = (TCB.KPDR + 14)

	.if CPU_HAS_SUPER == 1
	TCB.CLOCKTICKS = (TCB.MMUSTATE + (32 * 3))
	.else
	TCB.CLOCKTICKS = (TCB.MMUSTATE + (32 * 2))
	.endif

	TCB.CREATSTAMP	= (TCB.CLOCKTICKS + 4)
	TCB.LOCALFLAGS  = (TCB.CREATSTAMP + 4)




	.LIST
