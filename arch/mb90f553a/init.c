/*
 *Copyright (c) 2000-2002 Viola Systems Ltd.
 *All rights reserved.
 *
 *Redistribution and use in source and binary forms, with or without 
 *modification, are permitted provided that the following conditions 
 *are met:
 *
 *1. Redistributions of source code must retain the above copyright 
 *notice, this list of conditions and the following disclaimer.
 *
 *2. Redistributions in binary form must reproduce the above copyright 
 *notice, this list of conditions and the following disclaimer in the 
 *documentation and/or other materials provided with the distribution.
 *
 *3. The end-user documentation included with the redistribution, if 
 *any, must include the following acknowledgment:
 *	"This product includes software developed by Viola 
 *	Systems (http://www.violasystems.com/)."
 *
 *Alternately, this acknowledgment may appear in the software itself, 
 *if and wherever such third-party acknowledgments normally appear.
 *
 *4. The names "OpenTCP" and "Viola Systems" must not be used to 
 *endorse or promote products derived from this software without prior 
 *written permission. For written permission, please contact 
 *opentcp@opentcp.org.
 *
 *5. Products derived from this software may not be called "OpenTCP", 
 *nor may "OpenTCP" appear in their name, without prior written 
 *permission of the Viola Systems Ltd.
 *
 *THIS SOFTWARE IS PROVIDED "AS IS" AND ANY EXPRESSED OR IMPLIED 
 *WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF 
 *MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. 
 *IN NO EVENT SHALL VIOLA SYSTEMS LTD. OR ITS CONTRIBUTORS BE LIABLE 
 *FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR 
 *CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF 
 *SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR 
 *BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, 
 *WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE 
 *OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, 
 *EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 *====================================================================
 *
 *OpenTCP is the unified open source TCP/IP stack available on a series 
 *of 8/16-bit microcontrollers, please see <http://www.opentcp.org>.
 *
 *For more information on how to network-enable your devices, or how to 
 *obtain commercial technical support for OpenTCP, please see 
 *<http://www.violasystems.com/>.
 */

/** \file init.c
 *	\brief Default initialization file for OpenTCP on Fujitsu's MB90F553A
 *	\author 
 *		\li Jari Lahti (jari.lahti@violasystems.com)
 *	\version 1.0
 *	\date 22.6.2002
 *	\bug
 *	\warning
 *	\todo
 *  
 *	This file contains a function that initializes the HW resources 
 *	of processor (Pins, Peripherals). For stack and memory mode 
 *	selection modify start.asm. For Interrupt level modify VECTORS.C. 
 */

#include <inet/arch/mb90f553a/mb90550.h>
#include <inet/datatypes.h>


void init (void)
{

	/** INIT I/O PINS	**/


	/*	Port 0	*/

	DDR0 = 0x9F;	/* Direction. 1=O, 0=I 		*/
	PDR0 = 0x00;	/* State					*/
	RDR0 = 0x00;	/* Internal Pull-Up states	*/
	
	/*	Port 1	*/
	
	DDR1 = 0x00;
	PDR1 = 0x00;
	RDR1 = 0xFF;
	
	/*	Port 2	*/
	
	DDR2 = 0xFF;
	PDR2 = 0xFF;
	
	/* 	Port 3	*/
	
	DDR3 = 0xBF;
	PDR3 = 0x80;
	
	/* 	Port 4	*/
	
	DDR4 = 0xF3;
	PDR4 = 0x10;
	
	/*	Port 5	*/
	
	PDR5 = 0x00;
	
	/*	Port 6	*/
	
	DDR6 = 0xFF;
	PDR6 = 0x00;
	
	/*	Port 7	*/
	
	DDR7 = 0xFF;
	PDR7 = 0x00;
	
	/*	Port 8	*/
	
	DDR8 = 0x8E;
	PDR8 = 0x0C;
	
	/* 	Port 9	*/
	
	DDR9 = 0xFF;
	PDR9 = 0x00;
	
	/* 	Port A	*/
	
	DDRA = 0x0F;
	PDRA = 0x00;	
	
	
	/* Initialize 16 bit reload tmr 1 for slow 10 ms step SW timers	*/
	
	TMRLR1	=	2500;		/* 10 ms interrupt interval @ 4us step	*/
	
	TMCSR1_CSL1 = 1;		/*	4 us step @ 8MHz input clock		*/
	TMCSR1_CSL0	= 0;
	TMCSR1_MOD2 = 0;		/* 	Disable trigger from external pin	*/
	TMCSR1_MOD1 = 0;
	TMCSR1_MOD0 = 0;
	TMCSR1_OUTE = 0;		/* 	Timer output pin disabled			*/
	TMCSR1_OUTL = 0;		/* 	Output level (Don't care)			*/
	TMCSR1_RELD = 1;		/*	Enable reload operation				*/
	TMCSR1_INTE	= 1;		/* 	Enable interrupt request			*/
	TMCSR1_CNTE = 1;		/* 	Enable counting from trigger		*/
	TMCSR1_TRG 	= 1;		/* 	Trigger it!							*/ 

	/* Initialize 16 bit reload tmr 0 for UART clock (used on speed 38400)	*/
	
	TMRLR0 = 0;
	TMCSR0_CSL1 = 0;		/*	Divide PLL clock by 2				*/
	TMCSR0_CSL0	= 0;
	TMCSR0_MOD2 = 0;		/* 	Disable trigger from external pin	*/
	TMCSR0_MOD1 = 0;
	TMCSR0_MOD0 = 0;
	TMCSR0_OUTE = 0;		/* 	Timer output pin disabled			*/
	TMCSR0_OUTL = 0;		/* 	Output level (Don't care)			*/
	TMCSR0_RELD = 1;		/*	Enable reload operation				*/
	TMCSR0_CNTE = 0;		/* 	Disable counting untill we need it	*/


	/* Initialize the time-base timer for fast 1ms interrupt for system timer	*/
	/* This timer is not affected by PLL and clocks always on oscillation clock	*/
	
	TBTC_TBOF = 0;			/* Clear the request					*/
	TBTC_TBC1 = 0;			/* 1.024 ms interrupt interval @ 4 MHz	*/
	TBTC_TBC0 = 0;
	TBTC_TBIE = 1;			/* Enable interrupt	request				*/
	
	
	/* Initialize serial port	*/

	CDCR_MD = 1;			/* Enable communication prescaler		*/
	
	CDCR_DIV3 = 1;			/* Set port to 9600,8,N,1				*/
	CDCR_DIV2 = 1;
	CDCR_DIV1 = 0;
	CDCR_DIV0 = 0;
	SMR_CS2 = 0;
	SMR_CS1 = 0;
	SMR_CS0 = 0;
	SMR_SCKE = 0;
	
	SMR_MD1 = 0;			/* Asynchronous normal mode				*/
	SMR_MD0 = 0;
	SMR_SOE = 1;			/* Enable TX pin						*/
	SCR_RXE = 1;			/* Enable RX							*/
	SCR_TXE = 1;			/* Enable TX							*/
	SCR_PEN = 0;
	SCR_P = 0;
	SCR_SBL = 0;
	SCR_CL = 1;
	SCR_AD = 0;
	SCR_REC = 0;
	
	SSR_RIE = 0;			/* Disable RX Interrupt request			*/
	SSR_TIE = 0;			/* Disable TX Interrupt request			*/
	
	/* Kick WD	*/
	
	WDTC_WTE=0;

}

