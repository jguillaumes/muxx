#ifndef _CONFIG_H
/*
 * This is a generated file - DO NOT EDIT 
 * Edit the CONFIG.s file and run "make" to regenerate it.
*/
#define VEC_CPUERR		0004
#define VEC_ILLINS		0010
#define VEC_TRACE		0014
#define VEC_IOT		0020
#define VEC_POWER		0024
#define VEC_EMT		0030
#define VEC_TRAP		0034
#define VEC_BUSERR		0114
#define VEC_FPERR		0244
#define VEC_MMUERR		0250
#define CON_RCSR		0177560
#define CON_RBUF		0177562
#define CON_XCSR		0177564
#define CON_XBUF		0177566
#define CLK_LKS		0177546
#define CLK_VECTOR		0100
#define CLK_PL		06
#define PTP_PRS		0177550
#define PTP_PRB		0177552
#define PTP_PPS		0177554
#define PTP_PPB		0177556
#define PTP_RVEC		070
#define PTP_PVEC		074
#define PTP_PL		04
#define CPU_LOWER		0177760
#define CPU_UPPER		0177762
#define CPU_SYSID		0177764
#define CPU_ERR		0177766
#define CPU_KSP		0177706
#define CPU_SSP		0177716
#define CPU_USP		0177717
#define CPU_PIR		0177772
#define CPU_STACKLIM		0177774
#define CPU_PSW		0177776
#define MMU_MMR0		0177572
#define MMU_MMR1		0177574
#define MMU_MMR2		0177576
#define MMU_MMR3		0172516
#define MMU_UIDR0		0177600
#define MMU_UDSDR0		0177620
#define MMU_UISAR0		0177640
#define MMU_UDSAR0		0177660
#define MMU_SISDR0		0172200
#define MMU_SDDR0		0172220
#define MMU_SISAR0		0172240
#define MMU_SDSAR0		0172260
#define MMU_KISDR0		0172300
#define MMU_KDSDR0		0172320
#define MMU_KISAR0		0172340
#define MMU_KDSAR0		0172360
#define MAX_TASKS		16
#define CLK_FREQ		60
#define CLK_QUANTUM		6
#define KRN_STACK		1024
#define USR_STACK		3072
#define TOP_STACK		0160000
#define MEM_BLOCKS		4096
#define MEM_NMCBS		128
#define CPU_HAS_SPL		0
#define CPU_HAS_ERROR		1
#define _CONFIG_H
#endif
