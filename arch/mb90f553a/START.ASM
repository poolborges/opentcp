;====================================================================
;    MB90500/MB90600/MB90700/MB90700H/MB90200 Series C Compiler,
;    (C) FUJITSU MICROELECTRONICS EUROPE 1998-99
;
;    Startup file for memory and basic controller initialisation 
;====================================================================

          .PROGRAM  STARTUP  
          .TITLE    "STARTUP FILE FOR MEMORY INITIALISATION"

;====================================================================
; 1  Contents
;====================================================================
; 1   Contents
; 2   Disclaimer
; 3   History
;
; 4   SETTINGS              (USER INTERFACE)
; 4.1   Controller Family
; 4.2   Memory model
; 4.3   Constant Data Handling
; 4.4   Stack Type and Stack Size
; 4.5   General Register Bank
; 4.6   Low-Level Library Interface
; 4.7   Clock Selection
; 4.8   External Bus Interface
; 4.9   Reset Vector
; 4.10  Enable RAMCODE Copying
;
; 5   Section and Data Declaration
; 5.1   Several fixed addresses (fixed for MB90xxx controllers)
; 5.2   Declaration of __near addressed data sections
; 5.3   Declaration of RAMCODE section and labels
; 5.4   Declaration of sections containing other sections description
; 5.5   Stack area and stack top definition
; 5.6   Direct page register dummy label definition
;
; 6   Start-Up Code
; 6.1   Import external symbols
; 6.2   "NOT RESET YET" WARNING
; 6.3   Program start (the reset vector should point here)
; 6.4   Set clock ratio 
; 6.5   Set external bus configuaration
; 6.6   Copy initial values to data areas.
; 6.7   Clear uninitialised data areas to zero
; 6.8   Prepare stacks and set the default stack type
; 6.9   Set Data Bank Register (DTB) and Direct Page Register (DPR)
; 6.10  Wait for PLL to stabilise
; 6.11  Initialise Low-Level Library Interface
; 6.12  Call C-language main function
; 6.13  Shut down library
; 6.14  Program end loop
; 6.15  Debug address specification
;
;====================================================================
; 2  Disclaimer
;====================================================================
;                  FUJITSU MIKROELEKTRONIK GMBH                 
;                  Am Siebenstein 6-10, 63303 Dreieich          
;                  Tel.:++49/6103/690-0,Fax - 122               
;                                                               
;    The following software is for demonstration purposes only. 
;    It is not fully tested, nor validated in order to fullfill 
;    its task under all circumstances. Therefore, this software 
;    or any part of it must only be used in an evaluation       
;    laboratory environment.                                    
;    This software is subject to the rules of our standard      
;    DISCLAIMER, that is delivered with our SW-tools on the CD 
;    "Micros Documentation & Software" (V3.0 see "\START.HTM") or 
;    see our Internet Page -                                      
;    http://www.fujitsu-ede.com/products/micro/disclaimer.html    
;																  
;====================================================================
; 3  History
;====================================================================
;                               
; Version 1.00      25 Aug 98   Holger Loesche
;   - original version
; Version 1.01      31 Aug 98   Holger Loesche
;   - bug: conditional for reset vector was missing
; Version 1.02      16 Oct 98   Holger Loesche
;   - memory model AUTO introduced (use far calls only and repair
;     stack, if necessary
;   - colons removed from EQU labels
;   - stream_init call added
;   - RAMCONST set as default (also for ROMCONST systems)
; Version 1.03      19 Oct 98   Holger Loesche
;   - bug: SEGCOPY macro: used size changed from sizeof(src) to 
;     sizeof(dest). It was conflicting with RAMCONST, if compiler
;     is set to ROMCONST.
; Version 1.04      21 Oct 98   Holger Loesche
;   - ROM mirror option added
;   - _exit call added
;   - bug: EQU ON/OFF move to upper lines 
; Version 1.05      28 Oct 98   Holger Loesche
;   - CALL/CALLP _exit was not differed
; Version 1.06      18 Feb 99   Holger Loesche
;   - default external bus configuration: WR signal enabled
;   - ROMMIRROR macro processing simplified (less warnings>
; Version 1.07      01 April 99   Holger Loesche
;   - Version string had wrong number (1.05 instead of 1.06)
;   - Copyright slightly changed
; Version 1.08      16 April 99   Juergen Rohn
;   - Version placed in separate section (caused problems with fixed
;     reset vector)
; Version 1.09      12 May 99     Holger Loesche
;   - MB90400 family added
;   - several coments changed
;   - INTROM_EXTBUS macro was wrong
;   - BUSWIDTH macro removed, now resolved from bus signal
;   - disclaimer added
;   - disabling interrupts added
; Version 1.10      17 May 99     Holger Loesche
;   - change in 1.09 (MODEBYTE) related to BUSWIDTH was not complete
; Version 1.11      1 June 99     Holger Loesche
;   - confusing old line with comment removed, was refering to unused
;     old BUSWIDTH
; Version 1.12      23 June 99    Holger Loesche
;   - CLIBINIT is using ON/OFF instead of extra macro now
; Version 2.00      23 July 99    Holger Loesche
;   - decriptors of __near sections now in DCLEAR/DTRANS
;   - code for __near section init removed, now initialised by DCLEAR
;     and DTRANS processing
;   - RAMCODE option added
;   - table of contents added
;   - memory model AUTO renamed to AUTOMODEL
;   - CONSTDATA mode AUTOCONST introduced to make it clearer
;
;====================================================================
          .SECTION  VERSIONS, CONST
          .SDATA    "Start 2.00\n"      ; comment this line to remove

;====================================================================
; 4  Settings
;====================================================================
;
; CHECK ALL OPTIONS WHETHER THEY FIT TO THE APPLICATION;
;
; Configure this startup file in the "Settings" section. Search for
; comments with leading "; <<<". This points to the items to be set.
;====================================================================
#set      OFF       0
#set      ON        1

;====================================================================
; 4.1  Controller Family
;====================================================================

#set      MB90700   0
#set      MB90200   1
#set      MB90600   2
#set      MB90500   3
#set      MB90400   4

#set      FAMILY    MB90500        ; <<< select family

;====================================================================
; 4.2  Memory model
;====================================================================

                                   ;      data      code   
#set      SMALL     0              ;     16 Bit    16 Bit
#set      MEDIUM    1              ;     16 Bit    24 Bit
#set      COMPACT   2              ;     24 Bit    16 Bit
#set      LARGE     3              ;     24 Bit    24 Bit
#set      AUTOMODEL 4              ; works always, might waste 2 bytes


#set      MEMMODEL  AUTOMODEL      ; <<< C-memory model

; The selected memory model should be set in order to fit to the
; model selected for the compiler. 
; Note, in this startup version AUTOMODEL will work for all
; C-models. However, if the compiler is configured for SMALL or
; COMPACT, two bytes on stack will be lost. If this is not
; acceptable, the above setting should be set to the correct model.

;====================================================================
; 4.3  Constant Data Handling
;====================================================================

#set      ROMCONST    0            ; works only with compiler ROMCONST
#set      RAMCONST    1            ; works with BOTH compiler settings
#set      AUTOCONST   RAMCONST     ; works with BOTH compiler settings
                              
#set      CONSTDATA   ROMCONST    ; <<< set RAM/ROM/AUTOCONST

; - AUTOCONST (default) is a the same as RAMCONST
; - RAMCONST/AUTOCONST should always work, even if compiler is set to
;   ROMCONST. If compiler is set to ROMCONST and this startup file is
;   set to RAMCONST or AUTOCONST, this startup file will only generate
;   an empty section CINIT. The code, which copies from CONST to CINIT 
;   will not have any effect then.
; - It is highly recommended to set the compiler to ROMCONST for 
;   single-chip mode or internal ROM+ext bus. The start-up file 
;   should be set to AUTOCONST.
; - ROMCONST setting on systems with full external bus requires exter-
;   nal address mapping.
;   Single-chip can be emulated by the emulator debugger.
;   ROM mirror can also be used with simulator.
;
; see also MIRROR options of external bus settings

;====================================================================
; 4.4  Stack Type and Stack Size
;====================================================================

#set      USRSTACK  0    ; use user stack, system stack for interrupts
#set      SYSSTACK  1    ; use system stack for all (program + inter)

#set      STACKUSE  SYSSTACK       ; <<< set used stacks

; - If only system stack is used and SSB is linked to a different bank
;   than USB, make sure that all C-modules (which generate far pointers 
;   to stack data) have "#pragma SSB". Applies only to exclusive confi-
;   gurations.
; - Note, several library functions require quite a big stack (due to 
;   ANSI). Check the stack information files (*.stk) in the LIB\907
;   directory.

;changed SSIZE from 120 to 200 because (suspected) stack overflow (VlJ)
SSSIZE         .EQU 200            ; <<< system stack size in words
#if STACKUSE == USRSTACK
USSIZE         .EQU 384            ; <<< user stack size, if used
#else
USSIZE         .EQU 1              ; just a dummy
#endif


#if STACKUSE == USRSTACK
#  macro RELOAD_SP                 ; used after function call
          MOVW A, #USTACK_TOP      ; repair stack, if stream_init
          MOVW SP,A                ; was completed by RET (not RETP)
#  endm
#else
#  macro RELOAD_SP                 ; used after function call
          MOVW A, #SSTACK_TOP      ; repair stack, in case stream_init
          MOVW SP,A                ; was completed by RET (not RETP)
#  endm
#endif

;====================================================================
; 4.5  General Register Bank
;====================================================================

#set      REGBANK   0              ; <<< set default register bank

; set the General Register Bank that is to be used after startup.
; Usually, this is bank 0, which applies to address H'180..H'18F. Set
; in the range from 0 to 31.

#if REGBANK > 31 || REGBANK < 0
#  error REGBANK setting out of range
#endif

;====================================================================
; 4.6  Low-Level Library Interface
;====================================================================

#set          CLIBINIT  OFF        ; <<< select extended libray usage

; This option has only to be set, if stream-IO/standard-IO function of
; the C-libraray have to be used (printf(), fopen()...). This also 
; requires low-level functions to be defined by the application 
; software.
; For other library functions like (e.g. sprintf()) all this is not
; necessary. However, several functions consume a large amount of stack.

;====================================================================
; 4.7  Clock Selection
;====================================================================

#set      NOCLOCK        0         ; do not touch CKSCR register
#set      MAINCLOCK      1         ; select main clock (1/2 external)
#set      PLLx1          2         ; set PLL to x1 ext. clock/quartz
#set      PLLx2          3         ; set PLL to x2 ext. clock/quartz
#set      PLLx3          4         ; set PLL to x3 ext. clock/quartz
#set      PLLx4          5         ; set PLL to x4 ext. clock/quartz

#set      CLOCKSPEED    PLLx2      ; <<< set PLL ratio
#set      CLOCKWAIT      ON        ; <<< wait for stabilized PLL, if
                                   ;     PLL is used
; The clock is set quiet early. However, if CLOCKWAIT is ON, polling 
; for machine clock to be switched to PLL is done at the end of this
; file. Therefore, the stabilization time is not wasted. Main() will
; finally start at correct speed. Resources can immediately be used.
;
; This startup file version does not support subclock.

;====================================================================
; 4.8  External Bus Interface
;====================================================================

#set      SINGLE_CHIP    0         ; all internal
#set      INTROM_EXTBUS  1         ; mask ROM, FLASH, or OTP ROM used
#set      EXTROM_EXTBUS  2         ; full external bus (INROM not used) 

#set      BUSMODE SINGLE_CHIP      ; <<< set bus mode (see mode pins)

#set      ROMMIRROR      ON        ; <<< ROM mirror function ON/OFF
                                   ;     MB90500/400 family only

; In Internal ROM / External Bus mode one can select whether to mirror
; area FF4000..FFFFFF to 004000..00FFFF. This is necessary to get the 
; compiler ROMCONST option working. However, if ROMCONST is not used,
; this area might be used to access external memory. This is intended
; to increase performance, if a lot of dynamic data have to be accessed.
; In SMALL and MEDIUM model these data can be accessed within bank 0,
; which allows to use near addressing.
; These controller without the ROMM-control register always have the
; mirror function on in INROM mode.

; If BUSMODE is "SINGLE_CHIP", ignore remaining bus settings.

#set      WIDTH_8        0         ; 8 Bit external bus
#set      WIDTH_16       1         ; 16 Bit external bus

#set      AUTOWAIT_IO    0         ; <<< 0..3 waitstates for IO area
#set      AUTOWAIT_LO    0         ; <<< 0..3 for lower external area
#set      AUTOWAIT_HI    0         ; <<< 0..3 for higher external area

#set      ADDR_PINS B'00000000     ; <<< select used address lines 
                                   ;     A23..A16 to be output.
; This is the value to be set in HACR-register. "1" means: pin used as
; IO-port. (B'10000000 => A23 not used, B'00000001 => A16 not used)

#set      BUS_SIGNAL B'00000100    ; <<< enable bus control signals 
;                      |||||||+-- ignored
;                      ||||||+--- bus width lower memory (0:16, 1:8Bit)
;                      |||||+---- output WR signal(s)    (1: enabled  )
;                      ||||+----- bus width upper memory (0:16, 1:8Bit)
;                      |||+------ bus width ext IO area  (0:16, 1:8Bit)
;                      ||+------- enable HRQ input       (1: enabled  )
;                      |+-------- enable RDY input       (1: enabled  )
;                      +--------- output CLK signal      (1:enabled   )

; These settings correspond to the EPCR-register.
; Hint: Except for MB90500/400 devices the clock output is needed for 
; external RDY synchronisation, if Ready function is used.
; Hint: Don't forget to enable WR signals, if external RAM has to be
; written to.

#set      iARSR     ((AUTOWAIT_IO<<6)|((AUTOWAIT_HI&3)<<4)|(AUTOWAIT_LO&3))

;====================================================================
; 4.9  Reset Vector
;====================================================================

#set      RESET_VECTOR   ON        ; <<< enable reset vector

#if BUSMODE == SINGLE_CHIP
#  set    MODEBYTE       0
#else
#  set    MODEBYTE       ( ((BUSMODE&3)<<6) | ((~BUS_SIGNAL)&8) )
#endif

; Above setting can also be used, if all other interrupt vectors are
; specified via "pragma intvect". Only if interrupts 0..7 are specified
; via "pragma intvect", this will conflict with the vector in this
; module. The reason is the INTVECT section, which includes the whole
; area from the lowest to the highest specified vector.

#if RESET_VECTOR == ON
          .SECTION        RESVECT, CONST, LOCATE=H'FFFFDC
          .DATA.E _start
          .DATA.B MODEBYTE
#endif

;====================================================================
; 4.10  Enable RAMCODE Copying
;====================================================================

#set      COPY_RAMCODE      OFF     ; <<< enable RAMCODE section to
                                    ; be copied from ROM to RAM

; to get this option properly working the code to be executed has to
; be linked to section RAMCODE (e.g. by #pragma section). The section
; RAMCODE has be located in RAM and the section @RAMCODE has to be
; located at a fixed address in ROM by linker settings.

; <<< END OF SETTINGS >>>

;====================================================================
; 5  Section and Data Declaration
;====================================================================

;====================================================================
; 5.1  Several fixed addresses (fixed for MB90xxx controllers)
;====================================================================

LPMCR     .EQU      0xA0           ; Low power mode control register
CKSCR     .EQU      0xA1           ; Clock select control register
#if BUSMODE != SINGLE_CHIP
ARSR      .EQU      0xA5           ; *1) Automatic ready function reg
HACR      .EQU      0xA6           ; *1) External address output reg
EPCR      .EQU      0xA7           ; *1) Bus control signal selection
#endif
#if FAMILY == MB90500 || FAMILY == MB90400
ROMM      .EQU      0x6F           ; *2) ROM mirror control register
#endif
WDTC      .EQU      0xA8           ; Watchdog control register
TBTC      .EQU      0xA9           ; Timerbase timer control register

; *1 only for devices with external bus
; *2 only for MB905xx (FFMC-16LX) devices

;====================================================================
; 5.2  Declaration of __near addressed data sections
;====================================================================

; sections to be cleared
          .SECTION  DATA,      DATA,   ALIGN=2  ; zero clear area
          .SECTION  DIRDATA,   DIR,    ALIGN=2  ; zero clear direct
          .SECTION  LIBDATA,   DATA,   ALIGN=2  ; zero clear lib area

; sections to be initialised with start-up values
          .SECTION  INIT,      DATA,   ALIGN=2  ; initialised area
          .SECTION  DIRINIT,   DIR,    ALIGN=2  ; initialised dir
          .SECTION  LIBINIT,   DATA,   ALIGN=2  ; initialised lib area
#if CONSTDATA == RAMCONST
          .SECTION  CINIT,     DATA,   ALIGN=2  ; initialised const
#endif

; sections containing start-up values for initialised sections above
          .SECTION  DCONST,    CONST,  ALIGN=2  ; DINIT initialisers
          .SECTION  DIRCONST, DIRCONST,ALIGN=2  ; DIRINIT initialisers
          .SECTION  LIBDCONST, CONST,  ALIGN=2  ; LIBDCONST init val

          ; following setion is either copied to CINIT (RAMCONST) or
          ; mapped by ROM-mirror function (ROMCONST)
          .SECTION  CONST,     CONST,  ALIGN=2  ; CINIT initialisers

;====================================================================
; 5.3  Declaration of RAMCODE section and labels
;====================================================================

#if COPY_RAMCODE == ON
          .SECTION  RAMCODE,   CODE,  ALIGN=1  
          .IMPORT _RAM_RAMCODE                  ; provided by linker
          .IMPORT _ROM_RAMCODE                  ; provided by linker
#endif


;====================================================================
; 5.4  Declaration of sections containing other sections description
;====================================================================

; DCLEAR contains start address and size of all sections to be cleared
; DTRANS contains source and destination address and size of all 
; sections to be initialised with start-up values
; The compiler automatically adds a descriptor for each __far addressed
; data section to DCLEAR or DTRANS. These __far section are separated 
; for each C-module.

; In addition the start-up file adds the descriptors of the previously
; declared __near section here. This way the same code can be used.

   .SECTION  DCLEAR,    CONST,  ALIGN=2  ; zero clear table
   ;    Address         Bank            Size
   .DATA.H DATA,    BNKSEC DATA,    SIZEOF(DATA   )
   .DATA.H DIRDATA, BNKSEC DIRDATA, SIZEOF(DIRDATA)
   .DATA.H LIBDATA, BNKSEC LIBDATA, SIZEOF(LIBDATA)

   .SECTION  DTRANS,    CONST,  ALIGN=2  ; copy table
   ;    Address         Bank          Address     Bank          Size
   .DATA.H DCONST,   BNKSEC DCONST,   INIT,   BNKSEC INIT,   SIZEOF INIT   
   .DATA.H DIRCONST, BNKSEC DIRCONST, DIRINIT,BNKSEC DIRINIT,SIZEOF DIRINIT
   .DATA.H LIBDCONST,BNKSEC LIBDCONST,LIBINIT,BNKSEC LIBINIT,SIZEOF LIBINIT

#if CONSTDATA == RAMCONST
   .DATA.H CONST,    BNKSEC CONST,    CINIT,  BNKSEC CINIT,  SIZEOF CINIT  
#endif

#if COPY_RAMCODE == ON
   .DATA.L _ROM_RAMCODE, _RAM_RAMCODE
   .DATA.H SIZEOF RAMCODE
#endif

;====================================================================
; 5.5  Stack area and stack top definition
;====================================================================

               .SECTION  SSTACK, STACK, ALIGN=2
          .RES.H    SSSIZE
SSTACK_TOP:
               .SECTION  USTACK, STACK, ALIGN=2
          .RES.H    USSIZE
USTACK_TOP:

;====================================================================
; 5.6  Direct page register dummy label definition
;====================================================================

          .SECTION  DIRDATA  ; zero clear direct
DIRDATA_S:                                      ; label for DPR init       

; This label is used to get the page of the __direct data.
; Depending on the linkage order  order this startup file the label is
; placed anywhere within the __direct data page. However, the
; statement "PAGE (DIRDATA_S)" is processed. Therefore, the lower 
; 8 Bit of the address of DIRDATA_S are not relevant and this feature 
; becomes linkage order independent. 
; Note, the linker settings have to make sure that the all __direct
; data are located within the same physical page (256 Byte block).

;====================================================================
; 6  Start-Up Code
;====================================================================

;====================================================================
; 6.1  Import external symbols
;====================================================================

          .IMPORT   _main                    ; user code entrance
#if CLIBINIT == ON
          .IMPORT   __stream_init
          .IMPORT   _exit
          .EXPORT   __exit
#endif          
          .EXPORT   _start

;====================================================================
;   ___  _____   __    ___  _____
;  /       |    /  \  |   \   |                  
;  \___    |   |    | |___/   |   
;      \   |   |----| |  \    |   
;   ___/   |   |    | |   \   |      Begin of actual code section
;====================================================================
          .SECTION  CODE_START, CODE, ALIGN=1

;====================================================================
; 6.2  "NOT RESET YET" WARNING
;====================================================================
notresetyet:
          NOP  ; read hint below!!!!!!!
; If the debugger stays at the NOP above, the controller has not been
; reset yet. In order to reset all hardware register it is highly re-
; commended to reset the controller.
; However, if no reset vector has been defined on purpose, this dummy
; start address can also be used.
; This mechanism is using the .END instruction at the end of this mo-
; dule. It is not necessary for controller operation but improves 
; security during debugging (mainly emulator debugger).

;====================================================================
; 6.3  Program start (the reset vector should point here)
;====================================================================
_start:
          AND  CCR, #0             ; disable interrups
          MOV  ILM,#7              ; set interrupt level mask to ALL
          MOV  RP,#REGBANK         ; set register bank pointer 

;====================================================================
; 6.4  Set clock ratio (ignore subclock)
;====================================================================
#if CLOCKSPEED != NOCLOCK
          SETB I:CKSCR:2           ; set main clock
#  if CLOCKSPEED > MAINCLOCK
          MOV  A, I:CKSCR          ; copy clock register
          AND  A, #0xFC            ; set x1 for PLL
#    if CLOCKSPEED == PLLx2
          OR   A, #0x01            ; set x2 for PLL
#    elif CLOCKSPEED == PLLx3
          OR   A, #0x02            ; set x3 for PLL
#    elif CLOCKSPEED == PLLx4
          OR   A, #0x03            ; set x4 for PLL
#    endif
          MOV  I:CKSCR, A          ; write back 
          CLRB I:CKSCR:2           ; enable PLL, PLL is not switched
                                   ; to the MCU yet but after stabi-
                                   ; lizing it switchs on its own to
                                   ; higher speed (see below)
#  endif ; CLOCKSPEED > MAINCLOCK 
#endif ; CLOCKSPEED != NOCLOCK 

;====================================================================
; 6.5  Set external bus configuaration
;====================================================================

#if BUSMODE != SINGLE_CHIP         ; ext bus used
          MOV  I:HACR, #ADDR_PINS  ; set used upper address lines
          MOV  I:EPCR, #BUS_SIGNAL ; set used bus signals
          MOV  I:ARSR, #iARSR      ; set auto-wait cycles
#endif 

#if FAMILY == MB90500 || FAMILY == MB90400 ; only these have ROMM

#  if BUSMODE == INTROM_EXTBUS     ; EXTBUS and INTROM/EXTROM
#    if ROMMIRROR == OFF && CONSTDATA == ROMCONST
#      error Mirror function must be ON to mirror internal ROM
#    endif
#  endif

          MOV  I:ROMM, #ROMMIRROR
#endif

;====================================================================
; 6.6  Copy initial values to data areas.
;====================================================================
;
; Each C-module has its own __far INIT section. The names are generic.
; DCONST_module contains the initialisers for the far data of the one
; module. INIT_module reserves the RAM area, which has to be loaded
; with the data from DCONST_module. ("module" is the name of the *.c
; file) 
; All separated DCONST_module/INIT_module areas are described in 
; DTRANS section by start addresses and length of each far section.
;   0000 1. source address (ROM)
;   0004 1. destination address (RAM)
;   0008 length of sections 1
;   000A 2. source address  (ROM)
;   000E 2. destination address (RAM)
;   0012 length of sections 2
;   0014 3. source address ...
; In addition the start-up file adds the descriptors of the __near 
; sections to this table. The order of the descriptors in this table 
; depends on the linkage order.
;====================================================================
          MOV  A, #BNKSEC DTRANS   ; get bank of table
          MOV  DTB, A              ; store bank in DTB
          MOVW RW1, #DTRANS        ; get start offset of table
          OR   CCR, #H'20          ; System stack flag set (SSB used)
          BRA  LABEL2              ; branch to loop condition
LABEL1:
          MOVW A, @RW1+6           ; get bank of destination
          MOV  SSB, A              ; save dest bank in SSB
          MOVW A, @RW1+2           ; get source bank
          MOV  ADB, A              ; save source bank in ADB
          MOVW A, @RW1+4           ; move destination addr in AL
          MOVW A, @RW1             ; AL ->AH, src addr -> AL 
          MOVW RW0, @RW1+8         ; number of bytes to copy -> RW0
          MOVSI     SPB, ADB       ; copy data
          MOVN A, #10              ; length of one table entry is 10
          ADDW RW1, A              ; set pointer to next table entry
LABEL2:                             
          MOVW A, RW1              ; get address of next block
          SUBW A, #DTRANS          ; sub address of first block
          CMPW A, #SIZEOF (DTRANS) ; all blocks processed ?
          BNE  LABEL1              ; if not, branch

;====================================================================
; 6.7   Clear uninitialised data areas to zero
;====================================================================
;
; Each C-module has its own __far DATA section. The names are generic.
; DATA_module contains the reserved area (RAM) to be cleared.
; ("module" is the name of the *.c file) 
; All separated DATA_module areas are described in DCLEAR section by
; start addresses and length of all far section.
;   0000 1. section address (RAM)
;   0004 length of section 1
;   0006 2. section address (RAM)
;   000A length of section 2
;   000C 3. section address (RAM)
;   0010 length of section 3 ...
; In addition the start-up file adds the descriptors of the __near 
; section. to this table. The order of the descriptors in this table 
; depends on the linkage order.
;====================================================================
          MOV  A, #BNKSEC DCLEAR   ; get bank of table
          MOV  DTB, A              ; store bank in DTB
          MOVW RW1, #DCLEAR        ; get start offset of table
          BRA  LABEL4              ; branch to loop condition
LABEL3:                            
          MOV  A, @RW1+2           ; get section bank
          MOV  ADB, A              ; save section bank in ADB
          MOVW RW0, @RW1+4         ; number of bytes to copy -> RW0
          MOVW A, @RW1             ; move section addr in AL
          MOVN A, #0               ; AL ->AH, init value -> AL 
          FILSI     ADB            ; write 0 to section
          MOVN A, #6               ; length of one table entry is 6
          ADDW RW1, A              ; set pointer to next table entry
LABEL4:
          MOVW A, RW1              ; get address of next block
          SUBW A, #DCLEAR          ; sub address of first block
          CMPW A, #SIZEOF (DCLEAR) ; all blocks processed ?
          BNE  LABEL3              ; if not, branch

;====================================================================
; 6.8  Prepare stacks and set the default stack type
;====================================================================
#macro SYSSTACKINI
          OR   CCR,#H'20               ; set System stack flag
          MOV  A,#BNKSYM SSTACK_TOP    ; System stack set
          MOV  SSB,A                   
          MOVW A,#SSTACK_TOP
          MOVW SP,A
#endm
#macro USRSTACKINI
          AND  CCR,#H'DF               ; User stack flag set
          MOV  A,#BNKSYM USTACK_TOP    ; User stack set
          MOV  USB,A
          MOVW A,#USTACK_TOP
          MOVW SP,A
#endm
#if STACKUSE == USRSTACK
          SYSSTACKINI
          USRSTACKINI                  ; finally user stack selected
#else
          USRSTACKINI
          SYSSTACKINI                  ; finally system stack selected
#endif

;====================================================================
; 6.9  Set Data Bank Register (DTB) and Direct Page Register (DPR)
;====================================================================
          MOV  A,#BNKSEC DATA          ; User data bank offset
          MOV  DTB,A

          MOV  A,#PAGE DIRDATA_S       ; User direct page
          MOV  DPR,A

;====================================================================
; 6.10  Wait for PLL to stabilise
;====================================================================

#if CLOCKSPEED > MAINCLOCK && CLOCKWAIT == ON
no_PLL_yet:
          BBS  I:CKSCR:6,no_PLL_yet    ; check MCM and wait for
                                       ; PLL to stabilize
#endif

;====================================================================
; 6.11  Initialise Low-Level Library Interface
;====================================================================
;
; Call lib init functionand reload stack afterwards, if AUTOMODEL
;====================================================================
#if CLIBINIT == ON
#  if MEMMODEL == SMALL || MEMMODEL == COMPACT
          CALL __stream_init       ; initialise library IO
#  else                            ; MEDIUM, LARGE, AUTOMODEL
          CALLP __stream_init      ; initialise library IO
#    if MEMMODEL == AUTOMODEL          
          RELOAD_SP                ; repair stack since stream_init was
                                   ; possibly left by RET (not RETP)
#    endif  ; AUTOMODEL
#  endif  ; MEDIUM, LARGE, AUTOMODEL
#endif  ; LIBINI

;====================================================================
; 6.12  Call C-language main function
;====================================================================
#if MEMMODEL == SMALL || MEMMODEL == COMPACT
          CALL _main               ; Start main function
#else                              ; MEDIUM, LARGE, AUTOMODEL
          CALLP _main              ; Start main function
                                   ; ignore remaining word on stack, 
                                   ; if main was completed by RET
;====================================================================
; 6.13  Shut down library
;====================================================================
#endif
#if CLIBINIT == ON
#  if MEMMODEL == SMALL || MEMMODEL == COMPACT
          CALL _exit               
#  else                            ; MEDIUM, LARGE, AUTOMODEL
          CALLP _exit              ; ignore remaining word on stack, 
                                   ; if main was completed by RET
#  endif
__exit:
#endif          

;====================================================================
; 6.14  Program end loop
;====================================================================

end:      BRA  end                 ; Loop

;====================================================================
; 6.15 Debug address specification
;====================================================================
          .END notresetyet         ; define debugger start address

;====================================================================
; ----------------------- End of Start-up file ---------------------
;====================================================================
