/*  FFMC-16 IO-MAP HEADER FILE      */
/*  ==========================      */
/* CREATED BY IO-WIZARD V2.2   */
/* DATE: 20/09/99 TIME: 11:28:03 */
/* *********************************************************** */
/*               FUJITSU MIKROELEKTRONIK GMBH                  */
/*               Am Siebenstein 6-10, 63303 Dreieich           */
/*               Tel.:++49/6103/690-0,Fax - 122                */
/*                                                             */
/* The following software is for demonstration purposes only.  */
/* It is not fully tested, nor validated in order to fullfill  */
/* its task under all circumstances. Therefore, this software  */
/* or any part of it must only be used in an evaluation        */
/* laboratory environment.                                     */
/* This software is subject to the rules of our standard       */
/* DISCLAIMER, that is delivered with our SW-tools (on the CD  */
/* "Micros Documentation & Software V3.0" see "\START.HTM" or  */
/* see our Internet Page -                                     */
/* http://www.fujitsu-ede.com/products/micro/disclaimer.html   */
/* *********************************************************** */
/* History:                                                      */
/* Date      Version     Author      Description                 */
/* 09.10.98  1.0     	T.Kaprolat  created                          */
/*                                                               */
/* 15.05.99  1.1 		J. Rohn */
/*  - converted for Suftune Workbench */
/*  - disclaimer added                                           */
/* 22.06.99  1.2		V.Satanovskiy */
/*  - 21h SCR bit 0 PIN renamed to PEN (error in HM !) */
/*                                                               */
/* 10.08.99  1.3			V.Satanovskiy */
/*  - AEh FMCS is added */
/* 20.09.99  1.4        M.Steeg */
/*  - 45hex PPGC1 bit13 PE10 renamed to POE1  */
/*  - 55hex PPGC5 bit13 PE50 renamed to POE5 */

 .PROGRAM MB90550
 .TITLE   MB90550

;------------------------
; IO-AREA DEFINITIONS :
;------------------------



 .section IOBASE, IO, locate=0x0000  ; /*  PORT DATA */
 .GLOBAL __pdr0,     __pdr1,     __pdr2,     __pdr3,     __pdr4,     __pdr5
 .GLOBAL __pdr6,     __pdr7,     __pdr8,     __pdr9,     __pdra,     __ddr0
 .GLOBAL __ddr1,     __ddr2,     __ddr3,     __ddr4,     __ddr6,     __ddr7
 .GLOBAL __ddr8,     __ddr9,     __ddra,     __odr4,     __rdr0,     __rdr1
 .GLOBAL __ader,     __smr,      __scr,      __sidr,     __sodr,     __ssr
 .GLOBAL __smcs0,    __sdr0,     __cdcr,     __smcs1,    __sdr1,     __ibsr0
 .GLOBAL __ibcr0,    __iccr0,    __iadr0,    __idar0,    __ibsr1,    __ibcr1
 .GLOBAL __iccr1,    __iadr1,    __idar1,    __isel,     __enir,     __eirr
 .GLOBAL __elvr,     __adcs1,    __adcs2,    __adcr1,    __adcr2,    __prll0
 .GLOBAL __prlh0,    __prll1,    __prlh1,    __ppgc0,    __ppgc1,    __ppgoe0
 .GLOBAL __ppgoe1,   __prll2,    __prlh2,    __prll3,    __prlh3,    __ppgc2
 .GLOBAL __ppgc3,    __ppgoe2,   __ppgoe3,   __prll4,    __prlh4,    __prll5
 .GLOBAL __prlh5,    __ppgc4,    __ppgc5,    __ppgoe4,   __ppgoe5,   __clkr
 .GLOBAL __tmcsr0,   __tmr0,     __tmrlr0,   __tmcsr1,   __tmr1,     __tmrlr1
 .GLOBAL __ipcp0,    __ipcp1,    __ipcp2,    __ipcp3,    __ics01,    __ics23
 .GLOBAL __tcdt,     __tccs,     __romm,     __occp0,    __occp1,    __occp2
 .GLOBAL __occp3,    __ocs0,     __ocs1,     __ocs2,     __ocs3,     __pacsr
 .GLOBAL __dirr,     __lpmcr,    __ckscr,    __arsr,     __hacr,     __ecsr
 .GLOBAL __wdtc,     __tbtc,     __fmcs,     __icr

__pdr0   .res.b 1             ;000000  /*  PORT DATA */
PDR0    .equ 0x0000
__pdr1   .res.b 1             ;000001
PDR1    .equ 0x0001
__pdr2   .res.b 1             ;000002
PDR2    .equ 0x0002
__pdr3   .res.b 1             ;000003
PDR3    .equ 0x0003
__pdr4   .res.b 1             ;000004
PDR4    .equ 0x0004
__pdr5   .res.b 1             ;000005
PDR5    .equ 0x0005
__pdr6   .res.b 1             ;000006
PDR6    .equ 0x0006
__pdr7   .res.b 1             ;000007
PDR7    .equ 0x0007
__pdr8   .res.b 1             ;000008
PDR8    .equ 0x0008
__pdr9   .res.b 1             ;000009
PDR9    .equ 0x0009
__pdra   .res.b 1             ;00000A
PDRA    .equ 0x000A
 .org 0x0010
__ddr0   .res.b 1             ;000010  /* PORT DIR */
DDR0    .equ 0x0010
__ddr1   .res.b 1             ;000011
DDR1    .equ 0x0011
__ddr2   .res.b 1             ;000012
DDR2    .equ 0x0012
__ddr3   .res.b 1             ;000013
DDR3    .equ 0x0013
__ddr4   .res.b 1             ;000014
DDR4    .equ 0x0014
 .org 0x0016
__ddr6   .res.b 1             ;000016
DDR6    .equ 0x0016
__ddr7   .res.b 1             ;000017
DDR7    .equ 0x0017
__ddr8   .res.b 1             ;000018
DDR8    .equ 0x0018
__ddr9   .res.b 1             ;000019
DDR9    .equ 0x0019
__ddra   .res.b 1             ;00001A
DDRA    .equ 0x001A
__odr4   .res.b 1             ;00001B  /* Output Pin Register */
ODR4    .equ 0x001B
__rdr0   .res.b 1             ;00001C  /* Input Resistance Register */
RDR0    .equ 0x001C
__rdr1   .res.b 1             ;00001D
RDR1    .equ 0x001D
 .org 0x001F
__ader   .res.b 1             ;00001F  /* Analog Input Enable Register */
ADER    .equ 0x001F
__smr   .res.b 1             ;000020  /* UART0,1 */
SMR    .equ 0x0020
__scr   .res.b 1             ;000021
SCR    .equ 0x0021
__sidr   .res.b 1             ;000022
SIDR    .equ 0x0022
 .org 0x0022
__sodr   .res.b 1             ;000022
SODR    .equ 0x0022
__ssr   .res.b 1             ;000023
SSR    .equ 0x0023
__smcs0   .res.b 2             ;000024  /* SIO channels 0,1 */
SMCS0    .equ 0x0024
__sdr0   .res.b 1             ;000026
SDR0    .equ 0x0026
__cdcr   .res.b 1             ;000027
CDCR    .equ 0x0027
__smcs1   .res.b 2             ;000028
SMCS1    .equ 0x0028
__sdr1   .res.b 1             ;00002A
SDR1    .equ 0x002A
 .org 0x002C
__ibsr0   .res.b 1             ;00002C  /* Iih Quadrat C */
IBSR0    .equ 0x002C
__ibcr0   .res.b 1             ;00002D
IBCR0    .equ 0x002D
__iccr0   .res.b 1             ;00002E
ICCR0    .equ 0x002E
__iadr0   .res.b 1             ;00002F
IADR0    .equ 0x002F
__idar0   .res.b 1             ;000030
IDAR0    .equ 0x0030
 .org 0x0032
__ibsr1   .res.b 1             ;000032
IBSR1    .equ 0x0032
__ibcr1   .res.b 1             ;000033
IBCR1    .equ 0x0033
__iccr1   .res.b 1             ;000034
ICCR1    .equ 0x0034
__iadr1   .res.b 1             ;000035
IADR1    .equ 0x0035
__idar1   .res.b 1             ;000036
IDAR1    .equ 0x0036
__isel   .res.b 1             ;000037
ISEL    .equ 0x0037
__enir   .res.b 1             ;000038  /* DTP, External Interrupts */
ENIR    .equ 0x0038
__eirr   .res.b 1             ;000039
EIRR    .equ 0x0039
__elvr   .res.b 2             ;00003A
ELVR    .equ 0x003A
__adcs1   .res.b 1             ;00003C  /* AD Converter */
ADCS1    .equ 0x003C
__adcs2   .res.b 1             ;00003D
ADCS2    .equ 0x003D
__adcr1   .res.b 1             ;00003E
ADCR1    .equ 0x003E
__adcr2   .res.b 1             ;00003F
ADCR2    .equ 0x003F
__prll0   .res.b 1             ;000040  /* Puls Pattern Generator Channel 0,1 */
PRLL0    .equ 0x0040
__prlh0   .res.b 1             ;000041
PRLH0    .equ 0x0041
__prll1   .res.b 1             ;000042
PRLL1    .equ 0x0042
__prlh1   .res.b 1             ;000043
PRLH1    .equ 0x0043
__ppgc0   .res.b 1             ;000044
PPGC0    .equ 0x0044
__ppgc1   .res.b 1             ;000045
PPGC1    .equ 0x0045
__ppgoe0   .res.b 1             ;000046
PPGOE0    .equ 0x0046
 .org 0x0046
__ppgoe1   .res.b 1             ;000046
PPGOE1    .equ 0x0046
 .org 0x0048
__prll2   .res.b 1             ;000048
PRLL2    .equ 0x0048
__prlh2   .res.b 1             ;000049
PRLH2    .equ 0x0049
__prll3   .res.b 1             ;00004A
PRLL3    .equ 0x004A
__prlh3   .res.b 1             ;00004B
PRLH3    .equ 0x004B
__ppgc2   .res.b 1             ;00004C
PPGC2    .equ 0x004C
__ppgc3   .res.b 1             ;00004D
PPGC3    .equ 0x004D
__ppgoe2   .res.b 1             ;00004E
PPGOE2    .equ 0x004E
 .org 0x004E
__ppgoe3   .res.b 1             ;00004E
PPGOE3    .equ 0x004E
 .org 0x0050
__prll4   .res.b 1             ;000050
PRLL4    .equ 0x0050
__prlh4   .res.b 1             ;000051
PRLH4    .equ 0x0051
__prll5   .res.b 1             ;000052
PRLL5    .equ 0x0052
__prlh5   .res.b 1             ;000053
PRLH5    .equ 0x0053
__ppgc4   .res.b 1             ;000054
PPGC4    .equ 0x0054
__ppgc5   .res.b 1             ;000055
PPGC5    .equ 0x0055
__ppgoe4   .res.b 1             ;000056
PPGOE4    .equ 0x0056
 .org 0x0056
__ppgoe5   .res.b 1             ;000056
PPGOE5    .equ 0x0056
 .org 0x0058
__clkr   .res.b 1             ;000058  /* Clock Monitor Function */
CLKR    .equ 0x0058
 .org 0x005A
__tmcsr0   .res.b 2             ;00005A  /* Reload Timer */
TMCSR0    .equ 0x005A
__tmr0   .res.b 2             ;00005C
TMR0    .equ 0x005C
 .org 0x005C
__tmrlr0   .res.b 2             ;00005C
TMRLR0    .equ 0x005C
__tmcsr1   .res.b 2             ;00005E
TMCSR1    .equ 0x005E
__tmr1   .res.b 2             ;000060
TMR1    .equ 0x0060
 .org 0x0060
__tmrlr1   .res.b 2             ;000060
TMRLR1    .equ 0x0060
__ipcp0   .res.b 2             ;000062  /* ICU OCU units */
IPCP0    .equ 0x0062
__ipcp1   .res.b 2             ;000064
IPCP1    .equ 0x0064
__ipcp2   .res.b 2             ;000066
IPCP2    .equ 0x0066
__ipcp3   .res.b 2             ;000068
IPCP3    .equ 0x0068
__ics01   .res.b 1             ;00006A
ICS01    .equ 0x006A
__ics23   .res.b 1             ;00006B
ICS23    .equ 0x006B
__tcdt   .res.b 2             ;00006C
TCDT    .equ 0x006C
__tccs   .res.b 1             ;00006E
TCCS    .equ 0x006E
__romm   .res.b 1             ;00006F  /* ROM mirror function */
ROMM    .equ 0x006F
__occp0   .res.b 2             ;000070  /* ICU OCU units */
OCCP0    .equ 0x0070
__occp1   .res.b 2             ;000072
OCCP1    .equ 0x0072
__occp2   .res.b 2             ;000074
OCCP2    .equ 0x0074
__occp3   .res.b 2             ;000076
OCCP3    .equ 0x0076
__ocs0   .res.b 1             ;000078
OCS0    .equ 0x0078
__ocs1   .res.b 1             ;000079
OCS1    .equ 0x0079
__ocs2   .res.b 1             ;00007A
OCS2    .equ 0x007A
__ocs3   .res.b 1             ;00007B
OCS3    .equ 0x007B
 .org 0x009E
__pacsr   .res.b 1             ;00009E  /* Program Patch Function */
PACSR    .equ 0x009E
__dirr   .res.b 1             ;00009F  /* Delayed Interrupt */
DIRR    .equ 0x009F
__lpmcr   .res.b 1             ;0000A0  /* Low Power Control Registers */
LPMCR    .equ 0x00A0
__ckscr   .res.b 1             ;0000A1
CKSCR    .equ 0x00A1
 .org 0x00A5
__arsr   .res.b 1             ;0000A5  /* External Bus I/F */
ARSR    .equ 0x00A5
__hacr   .res.b 1             ;0000A6
HACR    .equ 0x00A6
__ecsr   .res.b 1             ;0000A7
ECSR    .equ 0x00A7
__wdtc   .res.b 1             ;0000A8  /* Watch Dog */
WDTC    .equ 0x00A8
__tbtc   .res.b 1             ;0000A9  /* Time Base Timer */
TBTC    .equ 0x00A9
 .org 0x00AE
__fmcs   .res.b 1             ;0000AE  /* Flash Control Register */
FMCS    .equ 0x00AE
 .org 0x00B0
__icr   .res.b 0x10          ;0000B0  /* Interrupt Control Registers */
ICR    .equ 0x00B0


 .end
