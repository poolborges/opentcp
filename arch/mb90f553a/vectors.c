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

/** \file vectors.c
 *	\brief Fujitsu MB90F553A specific vector definitions
 *	\author 
 *		\li Jari Lahti (jari.lahti@violasystems.com)
 *	\version 1.0
 *	\date 26.07.2002
 *	\bug
 *	\warning
 *	\todo
 *  
 *	This file contains interrupt level priority settings and interrupt
 *	vector definitions.
 */
 

#include <inet/arch/mb90f553a/mb90550.h>
#include <inet/datatypes.h>
#include <inet/timers.h>
#include <inet/system.h>



/*------------------------------------------------------------------------
   InitIrqLevels()

   This function  pre-sets all interrupt control registers. It can be used
   to set all interrupt priorities in static applications. If this file
   contains assignments to dedicated resources, verify  that the
   appropriate controller is used.

   NOTE: value 7 disables the interrupt and value 0 sets highest priority.
   NOTE: Two resource interrupts always share one ICR register.
*/
void InitIrqLevels(void)
{
/*  ICRxx               shared IRQs for ICR */

    ICR00 = 7;      /*  IRQ11
                        IRQ12 */
    ICR01 = 7;      /*  IRQ13     
                        IRQ14 */
    ICR02 = 7;      /*  IRQ15
                        IRQ16 */
    ICR03 = 7;      /*  IRQ17
                        IRQ18 */
    ICR04 = 7;      /*  IRQ19
                        IRQ20 */
    ICR05 = 7;      /*  IRQ21
                        IRQ22 */
    ICR06 = 7;      /*  IRQ23
                        IRQ24 */
    ICR07 = 7;      /*  IRQ25	Reload timer 0
                        IRQ26 */
    ICR08 = 5;      /*  IRQ27	Reload timer 1
                        IRQ28 */
    ICR09 = 7;      /*  IRQ29
                        IRQ30 */
    ICR10 = 7;      /*  IRQ31
                        IRQ32 */
    ICR11 = 7;      /*  IRQ33
                        IRQ34 */
    ICR12 = 2;      /*  IRQ35	Time-base timer
                        IRQ36 */
    ICR13 = 7;      /*  IRQ37
                        IRQ38 */
    ICR14 = 3;      /*  IRQ39	UART RX
                        IRQ40 */
    ICR15 = 7;      /*  IRQ41
                        IRQ42 */
}
/*------------------------------------------------------------------------
   Prototypes
   
   Add your own prototypes here. Each vector definition needs is proto-
   type. Either do it here or include a header file containing them.

*/
__interrupt void DefaultIRQHandler(void);
__interrupt void RLDTMR1IRQHandler(void);
__interrupt void SYSTMRIRQHandler(void);

/*------------------------------------------------------------------------
   Vector definiton

   Use following statements to define vectors. All resource related
   vectors are predefined. Remaining software interrupts can be added here
   as well.
   NOTE: If software interrupts 0 to 7 are defined here, this might 
   conflict with the reset vector in the start-up file.
*/

#pragma intvect DefaultIRQHandler  9    /* software interrupt 9         */
#pragma intvect DefaultIRQHandler 10    /* exeception handler           */
#pragma intvect DefaultIRQHandler 11    /* A/D converter                */
#pragma intvect SYSTMRIRQHandler  12    /* timebase timer               */
#pragma intvect DefaultIRQHandler 13    /* DTP #0                       */
#pragma intvect DefaultIRQHandler 14    /* DTP #4/5                     */
#pragma intvect DefaultIRQHandler 15    /* DTP #1                       */
#pragma intvect DefaultIRQHandler 16    /* 8/16-bit PPG #0 (borrow)     */
#pragma intvect DefaultIRQHandler 17    /* DTP #2                       */
#pragma intvect DefaultIRQHandler 18    /* 8/16-bit PPG #1 (borrow)     */
#pragma intvect DefaultIRQHandler 19    /* DTP #3                       */
#pragma intvect DefaultIRQHandler 20    /* 8/16-bit PPG #2 (borrow)     */
#pragma intvect DefaultIRQHandler 21    /* extended I/O serial #0       */
#pragma intvect DefaultIRQHandler 22    /* 8/16-bit PPG #3 (borrow)     */
#pragma intvect DefaultIRQHandler 23    /* extended I/O serial #1       */
#pragma intvect DefaultIRQHandler 24    /* 16-bit free-run timer(overfl)*/
#pragma intvect DefaultIRQHandler 25    /* 16-bit reload timer #0       */
#pragma intvect DefaultIRQHandler 26    /* DTP #6/7                     */
#pragma intvect RLDTMR1IRQHandler 27    /* 16-bit reload timer #1       */
#pragma intvect DefaultIRQHandler 28    /* 8/16-bit PPG #4/5 (borrow)   */
#pragma intvect DefaultIRQHandler 29    /* input capture CH.0           */
#pragma intvect DefaultIRQHandler 30    /* input capture CH.1           */
#pragma intvect DefaultIRQHandler 31    /* input capture CH.2           */
#pragma intvect DefaultIRQHandler 32    /* input capture CH.3           */
#pragma intvect DefaultIRQHandler 33    /* output compare CH.0          */
#pragma intvect DefaultIRQHandler 34    /* output compare CH.1          */
#pragma intvect DefaultIRQHandler 35    /* output compare CH.2          */
#pragma intvect DefaultIRQHandler 36    /* output compare CH.3          */
#pragma intvect DefaultIRQHandler 37    /* UART (transmission complete) */
#pragma intvect DefaultIRQHandler 38    /* IIC #0                       */
#pragma intvect DefaultIRQHandler 39    /* UART (receive complete)      */
#pragma intvect DefaultIRQHandler 40    /* IIC #1                       */
#pragma intvect DefaultIRQHandler 41    /* IRQ41-handler                */
#pragma intvect DefaultIRQHandler 42    /* delayed interrupt            */

/*------------------------------------------------------------------------
   DefaultIRQHandler()

   This function is a placeholder for all vector definitions. Either use
   your own placeholder or add necessary code here. 
*/
__interrupt 
void DefaultIRQHandler (void)
{
    __DI();                              /* disable interrupts */
    while(1)
        __wait_nop();                    /* halt system */
}



/* 16-bit reload timer #1       */
/* inline decrement timers function */
#pragma inline decrement_timers

__interrupt
void RLDTMR1IRQHandler  (void)
{
	/* This function is called when 16 bit reload-timer */
	/* overflows. Period can be changet by modifying 	*/
	/* the value of reload register TMRLR0				*/
	decrement_timers();
	TMCSR1_UF = 0;		/* Clear Interrupt request */
}  


/** Time-base timer	**/

__interrupt
void SYSTMRIRQHandler (void)
{
	base_timer++;
	
	TBTC_TBOF = 0;							/* Clear interrupt request	*/
}
