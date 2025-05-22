;----------------------------
; pomme 1+ BIOS 
;----------------------------
	
	.PC02

	.include "../inc/ascii.inc"
    .include "macros.inc" 

;------------------------------------
; W65C51 ACIA base address
;------------------------------------
    ACIA_BASE=$D000 
    .INCLUDE "w65c51n.inc" 

;-----------------------------------
; W65C22 VIA base address
;-----------------------------------
    VIA_BASE = $D060
    .INCLUDE "w65c22s.inc" 


; Processor status register bits 
    PSR_CARRY = 1   ; carry|borrow bit 
    PSR_ZERO = 2    ; ALU result is 0 
    PSR_IRQ_DIS = 4 ; disable IRQ 
    PSR_DMODE = 8   ; decimal mode 
    PSR_BRK = 16    ; set by BRK instruction 
    PSR_OVF = 64    ; ALU overflow 
    PSR_NEG = 128   ; ALU signed negative result 

   ; system constants 
    RAM_SIZE=32768 ; installed RAM size 
	RX_BUFF_SIZE=$20 ; UART RX buffer size, keep it power of 2 
    TIB_ORG = $200
    TIB_SIZE = 128 
    PAD_SIZE = 128 
    PROG_LOAD = $300 ; program load address 
    CODE_SIZE=RAM_SIZE-PROG_LOAD ; maximum application code size  
   ; parameter stack 32 words  
 
;----------------------------
; BOOLEAN FLAGS 
; masks to be used with 
; AND,OR,TRB,TSB instructions 
;----------------------------
    F_SR_TX=0 ; SR set to transmit mode when 1 
    F_TIMER=1 ; timer active when 1 
    F_SOUND=2 ; sound timer active 

	.SEGMENT "DATA"
; string pointer for PUTS 
    .ORG 0
MSEC: .res 4  ; millisecond counter
TIMER: .res 2 ; msec timer   
SND_TMR: .res 2 ; sound duration timer 
SEED: .res 2 ; pseudo random number generator seed 
FLAGS: .res 1 ; boolean flags 
HEAP_ADR: .res 2 ; address free RAM after program load 
HEAP_FREE: .res 2 ; size free RAM after program load + allocated heap space 
FLASH_SIZE: .res 2 ; W25Q080|160 last page (256 bytes), i.e. W25Q080 -> $FFFF (0..4095) , W25Q160 -> $FFFF (0..65535)
FLASH_BUFF: .res 2 ; FLASH memory transaction buffer address
BCOUNT: .res 1 ; flash memory transaction bytes count 
FLASH_ADR: .res 3   ; 24 bits flash memory address  
RX_HEAD: .res 1  ; ACIA RX queue head pointer 
RX_TAIL: .res 1  ; ACIA RX queue tail pointer 
STR_PTR: .res 2  ; pointer to string printed by PUTS 
RX_BUFF: .RES RX_BUFF_SIZE  
ACC16: .res 2 ; 16 bits accumulator 
ZP_FREE: .res 0  ; zero page free space *..$BF  


ZP_FREE_SIZE=$C0-* ; size of zero page available to application variables 

; transaction input buffer 
    .ORG TIB_ORG 
TIB: 
    .RES TIB_SIZE 
; working area 
PAD: .RES PAD_SIZE 

	.CODE  
    .ORG $E000 

    .include "stack.s" 

; BIOS code here 

;-----------------------------
;  COLD START 
;  hardware initialization
;-----------------------------    
RESET:	
; initialize stack pointer     
    LDX #$FF ;parameter stack empty 
    TXS      ; hardware stack empty 
; set heap address  
    LDA #<PROG_LOAD 
    STA HEAP_ADR 
    LDA #>PROG_LOAD 
    STA HEAP_ADR+1 
; available RAM space for programs     
    LDA #<CODE_SIZE 
    STA HEAP_FREE
    LDA #>CODE_SIZE 
    STA HEAP_FREE+1 
    STZ FLAGS         
; intialize Status register 
; disable iterrupts 
    SEI 
; initialize ACIA and terminal 
    JSR ACIA_INIT 
; initialize VIA to interface to 
; W25Qxxx flash memory 
    JSR VIA_INIT
;get flash memory size 
    LDA #$FF 
    STA FLASH_SIZE 
    JSR FLASH_RD_DEVID 
    CMP #$13 
    BNE @W160   
    LDA #$F  ; W25Q080 1MB 
    BRA @STORE_SIZE      
@W160:  
    LDA #$FF ; W25Q160 16MB 
@STORE_SIZE:
    STA FLASH_SIZE+1
; enable interrupts 
    CLI 
; print BIOS information 
    JSR CLS ; clear terminal screen 
    _PUTS BIOS_INFO 
    JSR BEEP   
    JSR MONITOR       
DEFAULT_APP:
    JSR RANDOMIZE 

DEBUG=1 
;;;;;;;;;;;;;;;;;;;;;;;;;
; test code 
;;;;;;;;;;;;;;;;;;;;;;;;;
.IF DEBUG
    .include "bios_test.s" 
.ENDIF 

    JMP RESET 

BIOS_INFO: .BYTE "pomme I+ BIOS version 1.0R0",CR,0	



;-------------------------------
; initialize W65C51 ACIA and 
; terminal queue 
;-------------------------------
ACIA_INIT: 
; clear input buffer 	
	STZ RX_HEAD 
	STZ RX_TAIL  
; SETUP ACIA FOR 115200 BAUD,8N1 
	LDA #$89       ; DTR ready, no parity
	STA ACIA_CMD   ; 
	LDA #16
	STA ACIA_CTRL
    RTS 

;-----------------------------
; initialize W65C22 VIA 
; to interface W25Q080DV 
; flash memory 
; CB1 SPI clock 
; CB2 SPI DATA I/O 
; PB0 chip select 
; IRQ triggerred when byte 
; TX|RX completed
;-----------------------------

    FLASH_CS=(1<<0) ; VIA PB0 used as chip select 
    MS_DELAY=3680 ; for 1msec delay 

VIA_INIT:
; configure PB0 as W25Q080 ~CS output
    LDA #FLASH_CS 
    TSB VIA_DDRB
    TSB VIA_IORB ; CS0 high 
; set PB7 as output for square wave 
    LDA #(1<<7)
    TSB VIA_DDRB 
; configure 1 msec delay on TIMER2 
    LDA #<MS_DELAY 
    STA VIA_T2CL 
    LDA #>MS_DELAY 
    STA VIA_T2CH 
    LDA #VIA_SET_IE+VIA_T2_IE 
    STA VIA_IER  
    RTS 


;-------------------------------
; check for interrupt origin 
; and execute the corresponding 
; handler 
; 2 possible sources 
;   VIA   W65C22 
;   ACIA  W65C51 
;-------------------------------
INTR_SELECTOR:
    PHA  
    LDA #VIA_T2_IF 
    AND VIA_IFR 
    BNE VIA_INTR 
; W65C51 ACIA interrupt
@ACIA_TEST:
    LDA #(1<<ACIA_STATUS_RX_FULL) 
    AND ACIA_STATUS
    BEQ @EXIT  
    JMP ACIA_HANDLER
@EXIT:
    PLA 
    RTI 


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;  FLASH memory basic functions 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

CODE_READ_SR1=5   ; read status register 1
CODE_READ_SR2=$35 ; read status register 2fff
CODE_SET_WEL=6  ; set WEL bit in status register 1
CODE_RST_WEL=4 ; reset WEL bit in status register 1
CODE_WRITE=2          ; write {1..256} bytes 
CODE_READ=3          ; read n bytes 
CODE_ERASE_4K=$20  ; erase 4KB block 
CODE_ERASE_32K=$52 ; erase 32KB block 
CODE_ERASE_64K=$D8 ; erase 64KB block 
CODE_ERASE_CHIP=$60 ; erase chip 
CODE_DEV_ID=$90 ; get device ID 
BUSY_BIT=1 

;------------------------------
; VIA shift register interrupt 
; handler 
; transmit or receive next byte 
; depending of state F_SR_TX
;------------------------------
VIA_INTR:
; compensate T2CL for 
; interrupt latency 
    CLC 
    LDA #<MS_DELAY 
    ADC VIA_T2CL 
    STA VIA_T2CL
;restart timer 2      
    LDA #>MS_DELAY
    STA VIA_T2CH 
; increment MSEC variable 
@TMR1_INTR: 
    INC MSEC 
    BNE @TMR_DECR 
    INC MSEC+1
    BNE @TMR_DECR 
    INC MSEC+2 
    BNE @TMR_DECR 
    INC MSEC+3
; decrement timer if enabled     
@TMR_DECR:   
.IF 0
    LDA FLAGS 
    AND #F_TIMER 
    BEQ @DEC_SND_TIMER 
.ELSE 
    _BFR F_TIMER,@DEC_SND_TIMER ; branch if TIMER flag is reset 
.ENDIF 
    _DECW TIMER 
    BNE @EXIT 
; timeout, reset timer flag
    LDA #F_TIMER 
    TRB FLAGS 
;    _RSTF F_TIMER
;decrement sound timer if enabled     
@DEC_SND_TIMER: 
.IF 0  
    LDA FLAGS 
    AND #F_SOUND
    BEQ @EXIT
.ELSE      
    _BFR F_SOUND,@EXIT ; branch if sound timer is reset 
.ENDIF 
    _DECW SND_TMR
    BNE @EXIT 
; stop sound
    _TONE_OFF 
@EXIT: 
    PLA 
    RTI 


;---------------------------------
;  send one byte to FLASH via
;  VIA shift register 
;  input:
;     A    byte to send 
;---------------------------------
FLASH_SEND_CODE:
    PHA
    _SET_SR_OUT 
    _FLASH_SEL 
    PLA 
    STA VIA_SR  
; wait for SR interrupt flag set 
WAIT_SR_IF: 
@LOOP:
    LDA #VIA_SR_IF 
    AND VIA_IFR
    BEQ @LOOP   ; loop until shift out completed 
    STA VIA_IFR ; reset interrupt flag 
    RTS 


;-----------------------------------
;  receive one byte from 
;  VIA shift register 
; output:
;     A   byte received 
;------------------------------------
RCV_BYTE:
; set shift in mode 
    _SET_SR_IN
    LDA VIA_SR ; start shifting 
    JSR WAIT_SR_IF ; wait shift completed 
    LDA VIA_SR ; get byte 
    RTS 
 

;---------------------------------
; wait write/erase operation 
; to complete 
; busy bit in flash SR1 is 1 when busy 
;---------------------------------
WAIT_COMPLETED: 
    JSR FLASH_READ_SR1
    AND #BUSY_BIT 
    BNE WAIT_COMPLETED 
    RTS 

;------------------------------------
;  enable write bite in W25Q080 
;  status register 
;------------------------------------
FLASH_SET_WEL:
    _SET_SR_OUT
    _FLASH_SEL
    LDA #CODE_SET_WEL
    STA VIA_SR   
    JSR WAIT_SR_IF
    _FLASH_DESEL 
    RTS 

 ;---------------------------
 ; reset WEL bit in status 
 ; register 1 
 ;---------------------------   
FLASH_RST_WEL:
    _SET_SR_OUT
    _FLASH_SEL
    LDA #CODE_RST_WEL
    STA VIA_SR   
    JSR WAIT_SR_IF
    _FLASH_DESEL 
    RTS 

;--------------------------------------
; read W25Q080 status register 1 
;--------------------------------------
FLASH_READ_SR1:
    _SET_SR_OUT 
    _FLASH_SEL 
    LDA #CODE_READ_SR1
    STA VIA_SR 
    JSR WAIT_SR_IF 
    _SET_SR_IN 
    LDA VIA_SR ; start shift in 
    JSR WAIT_SR_IF ; wait completed 
    _FLASH_DESEL
    LDA VIA_SR  ; get input value 
    PHA 
    _SWITCH_SR_OFF
    PLA 
    RTS 

;-------------------------------------
;  erase block in W25Q080 
;  input:
;     A   OPCODE: {CODE_ERASE_4K,CODE_ERASE_32K,
;                  CODE_ERASE_64K}
;     FLASH_ADR  block address 
;-------------------------------------
ERASE_BLOCK:
    PHA 
    JSR FLASH_SET_WEL 
    _FLASH_SEL
    PLA 
SEND_OP_CODE:
    STA VIA_SR 
    JSR WAIT_SR_IF
    JSR FLASH_SEND_ADR 
    _SWITCH_SR_OFF 
    _FLASH_DESEL
    JSR WAIT_COMPLETED
    RTS 

;--------------------------------------
;  send address in FLASH_ADR variable 
;  to W25Q080 
;  prerequites:
;    flash select 
;    SR mode in shift out 
;--------------------------------------
FLASH_SEND_ADR:      
    LDA FLASH_ADR+2 
    STA VIA_SR 
    JSR WAIT_SR_IF 
    LDA FLASH_ADR+1 
    STA VIA_SR 
    JSR WAIT_SR_IF 
    LDA FLASH_ADR 
    STA VIA_SR 
    JSR WAIT_SR_IF
    RTS 

;---------------------------------------
;  chip erase W25Q128
;  OPCODE $60 
;---------------------------------------
ERASE_ALL:
    JSR FLASH_SET_WEL 
    _FLASH_SEL 
    LDA #CODE_ERASE_CHIP
    STA VIA_SR 
    JSR WAIT_SR_IF 
    _SWITCH_SR_OFF
    _FLASH_DESEL 
    JMP WAIT_COMPLETED 
 

;----------------------------------------
;  write up to 256 bytes in W25Q080 
;  input:
;      A    byte count 
;----------------------------------------
FLASH_WRITE: 
    PHY 
    STA BCOUNT 
    JSR FLASH_SET_WEL
    _FLASH_SEL
    LDA #CODE_WRITE 
    STA VIA_SR 
    JSR WAIT_SR_IF
    JSR FLASH_SEND_ADR
    LDY #0 
@LOOP:
    LDA (FLASH_BUFF),Y 
    STA VIA_SR 
    JSR WAIT_SR_IF 
    INY 
    DEC BCOUNT 
    BNE @LOOP
    _SWITCH_SR_OFF 
    _FLASH_DESEL
    JSR WAIT_COMPLETED 
    PLY 
    RTS  

;------------------------------------------
; read a bloc of bytes from W25Q080 
; {1..256}
; input:
;   A  BCOUNT
;  FLASH_BUFF  input buffer 
;  FLASH_ADR   flash address to read  
;------------------------------------------
FLASH_READ: 
    PHY
    STA BCOUNT 
    LDA #CODE_READ 
    JSR FLASH_SEND_CODE 
    JSR FLASH_SEND_ADR 
    _SET_SR_IN
    LDY #0
    LDA VIA_SR ; start shift in  
@LOOP:
    JSR WAIT_SR_IF
    LDA VIA_SR 
    STA (FLASH_BUFF),Y 
    INY 
    DEC BCOUNT 
    BNE @LOOP 
    _FLASH_DESEL 
    _SWITCH_SR_OFF 
    PLY 
    RTS 

;-----------------------------------
; read FLASH chip mfg device ID 
; output:
;    A   devid 
;    X   mfg id 
;-----------------------------------
FLASH_RD_DEVID: 
    STZ FLASH_ADR 
    STZ FLASH_ADR+1
    STZ FLASH_ADR+2
; send command 
    _SET_SR_OUT
    _FLASH_SEL
    LDA #CODE_DEV_ID
    STA VIA_SR 
    JSR WAIT_SR_IF
    JSR FLASH_SEND_ADR
    _SET_SR_IN 
    LDA VIA_SR  ; start shifting 
    JSR WAIT_SR_IF
    LDX VIA_SR  ; read value, start next shifting   
    JSR WAIT_SR_IF
    LDA VIA_SR 
    PHA 
    _SWITCH_SR_OFF ; turn off shift register 
    _FLASH_DESEL
    PLA 
    RTS 

;----------------------------------
; return number of 256 bytes pages 
; available on W25Qxxx
; ouput:
;    A:X   value 
;----------------------------------
FLASH_CAPACITY:
    LDA FLASH_SIZE+1
    LDX FLASH_SIZE 
    RTS 


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; miscelanous functions
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;------------------------------------------
; start timer 
; input:
;   A    timer high byte 
;   X    timer low byte 
;------------------------------------------
SET_TIMER: 
    STA TIMER+1 
    STX TIMER 
; set TIMER flag 
    LDA #F_TIMER 
    TSB FLAGS 
    RTS  

;-----------------------------------
; suspend execution for msec 
; input:
;   A    timer high byte 
;   X    timer low byte 
;-----------------------------------
PAUSE: 
; set delay     
    JSR SET_TIMER 
@WAIT: ; wait timeout 
    LDA #F_TIMER 
    AND FLAGS 
    BNE @WAIT 
    RTS     

;-------------------------------------
; generate 1KHZ tone for 1 second 
;-------------------------------------
    TONE_1KHZ=1843 ; T1 count for PHI2=3.6864Mhz 
BEEP:
    LDA #<100
    STA SND_TMR
    LDA #>100
    STA SND_TMR+1
    LDA #>TONE_1KHZ
    LDX #<TONE_1KHZ 

;-----------------------------------
; sound a tone 
; input:
;   SND_TMR   duration in msec 
;   A:X       timer1 count  
;------------------------------------
TONE:
; set timer 1 coun value  
    PHA 
    _TONE_ON 
    STX VIA_T1LL 
    PLA 
    STA VIA_T1CH  
    RTS 


;---------------------------------------
; 16 bits linear feedback shift register 
;---------------------------------------
EOR_MASK=$B4
LFSR: 
    ROR SEED+1 
    ROR SEED 
    BCC @EXIT 
    LDA #EOR_MASK 
    EOR SEED+1 
    STA SEED+1
@EXIT:
    RTS 

;----------------------------------------
; pseudo randmon number generator 
; output:
;   A:X   prng 
;------------------------------------------
RAND:
    PHY 
    LDY #5
@LOOP:
    JSR LFSR 
    DEY 
    BNE @LOOP
    LDA SEED+1 
    LDX SEED  
    PLY 
    RTS 

;---------------------------------------
; randomize PRNG seed using MSEC counter 
;---------------------------------------
RANDOMIZE:
    LDA MSEC+1 
    STA SEED+1 
;SEED can be any value except zero 
    LDA MSEC 
    BNE @OK
    INC A   ; for case where MSEC+1==0   
@OK: 
    STA SEED
    RTS


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;   terminal functions 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;--------------------------------
; W65C51 ACIA triggered interrupt 
; UART receive Interrupt handler
;--------------------------------
ACIA_HANDLER:
                PHX 
                LDA     ACIA_STATUS 
                AND     #(1<<ACIA_STATUS_RX_FULL) ; check rx bit 
                BEQ     @NOT_ACIA    ; interrupt was not trigerred by ACIA 
                LDA     ACIA_DATA 
				CMP     #CTRL_C 
                BNE     @RX1
                JMP     RESET ; CTRL+C reset computer 
@RX1:
                CMP     #127 
                BPL     @RX_DISCARD   ; ignore codes >126
@RX_ACCEPT:
                LDX     RX_HEAD ; update queue head index 
				STA     RX_BUFF,X 
				INX
				TXA 
				AND     #RX_BUFF_SIZE-1 
				STA     RX_HEAD  
@NOT_ACIA:
@RX_DISCARD:
                PLX
                PLA
                RTI 


;---------------------------
; send character to terminal
; input:
;    A   character to send
;---------------------------
PUTC:
	STA ACIA_DATA  ; store character in ACIA register 
; need delay to avoid character overwrite in ACIA data register 
; 10 bits at 115200 BAUD = 86.8µsec 
; if Fclk=3.6864Mhz transmission delay --> 320 cycles/5cy = 64 loops  
	LDA #65         
@DELAY:
	DEC	A	       ; 2cy
	BNE @DELAY      ; 3cy = 5cy per loop 
	RTS            ; done 
 

;------------------------
; send new line character 
;------------------------
NEW_LINE:
    PHA 
    LDA #CR 
    BRA PRT_PLA 

;----------------------
; PRT_SPC 
; print space 
;----------------------
PRT_SPC: 
    PHA 
    LDA #SPACE 
PRT_PLA: ; restore A after PUTC 
    JSR PUTC 
    PLA 
    RTS 

;---------------------------------
; print string to console 
; input:
;   A   string address high byte 
;   X   sring address low byte 
;--------------------------------- 
PUTS:
    STA STR_PTR+1 
    STX STR_PTR 
    PHY  
    LDY #0     
@LOOP:     
	LDA (STR_PTR),Y
	BEQ @EXIT 
	JSR PUTC 
	INY 
	BRA @LOOP 
@EXIT:
    PLY  
    RTS  

;--------------------------------
; query for character in rx_queue
; output:
;    Z   flag set if char in queue
;--------------------------------- 
QCHAR:
	LDA      RX_TAIL 
	CMP      RX_HEAD 
    RTS 

;-----------------------------
; get character from RX_BUFF buffer
; output:
;     A    0||character 
;----------------------------- 
 GETC:
	LDA      RX_TAIL 
	CMP      RX_HEAD 
	BEQ      GETC 
	TAX
	LDA      RX_BUFF,X 
	PHA 
	INX                     ; update queue tail index 
	TXA
	AND     #RX_BUFF_SIZE-1   
	STA     RX_TAIL
	PLA    
	RTS 

;-------------------------	
; read line from terminal
; line terminated byte CR
;   BS delete last character 
; output:
;    TIB   input buffer 
;    A     line length
;-------------------------
READLN:
    LDY #0
@LOOP:
    JSR GETC 
    BEQ @LOOP 
    CMP #BS
    BNE @TEST_CR 
    TYA 
    BEQ @LOOP 
    JSR BACK_SPACE
    DEY 
    BRA @LOOP   
@TEST_CR: 
    CMP #CR 
    BNE @NEXT_TEST 
    STA TIB,Y 
    INY
    JSR PUTC  
    BRA @EXIT
@NEXT_TEST:
    CMP #SPACE 
    BMI @LOOP ; ignore it 
    CMP #127 
    BPL @LOOP ; >126 ignore it     
@KEEP_IT:
    STA TIB,Y 
    INY
    JSR PUTC ; echo character   
    BRA @LOOP 
@EXIT:
    TYA 
    RTS 
 
;----------------------
; delete last character
;----------------------
BACK_SPACE:
    PHA 
    LDA #BS 
    JSR PUTC 
    LDA #SPACE 
    JSR PUTC 
    LDA #BS 
    JSR PUTC
    PLA  
    RTS 

;----------------------
; clear terminal screen
;----------------------
CLS:
    PHA 
    LDA #ESC 
    JSR PUTC 
    LDA #'c' 
    JSR PUTC 
    PLA 
    RTS 

;-----------------------------
;  lower case letter 
; input:
;    A    character 
; output:
;    A   upper if letter 
;------------------------------
LOWER:
    CMP #'A' 
    BMI @EXIT
    CMP #'Z'+1
    BPL @EXIT 
    ORA #$20 
@EXIT:
    RTS 

;-----------------------------
;  upper case letter 
; input:
;    A    character 
; output:
;    A   upper if letter 
;------------------------------
UPPER:
    CMP #'a' 
    BMI @EXIT
    CMP #'{'
    BPL @EXIT 
    AND #$DF
@EXIT:
    RTS 


;-----------------------------
; PRT_HWORD 
; print X:A word in hexadecimal 
; input:
;    A   word high byte 
;    X   word low byte 
;------------------------------
PRT_HWORD: 
    JSR PRT_HEX 
    TXA 

;-----------------------------
; PRT_HEX 
; print byte in hexadecimal 
; input:
;    A   byte to print 
;-----------------------------
PRT_HEX: 
    PHA 
    LSR A 
    LSR A 
    LSR A 
    LSR A
    JSR @TO_HEX
    PLA 
    AND #$F   
@TO_HEX: 
    CLC 
    ADC #'0'
    CMP #'9'+1
    BMI @PRT 
    CLC 
    ADC #7 
@PRT:
    JSR PUTC 
    RTS 

;--------------------------------
;  BIOS function call dispatcher 
;  parameter in Y transfered in 
;  A before jumping to function 
;  input:
;     A    function #
;     X,Y  function parameters 
;--------------------------------
    .SEGMENT "SYSCALL" 
    .ORG $FB00 
BIOS_CALL:
    PHX 
    ASL A  
    TAX  
    PLA  
    JMP (FNTABLE,X)  


;-----------------------------------
; BIOS function table 
FNTABLE: 
    .WORD 0 

;----------------------------
; monitor wozmon style
;----------------------------
    .include "p1+Monitor.s"


	.SEGMENT "VECTORS" 
	.ORG $FFFA    
	.WORD RESET   ; (NMI)
	.WORD RESET   ; (RESET)
	.WORD INTR_SELECTOR   ; (IRQ)

	
	
	
