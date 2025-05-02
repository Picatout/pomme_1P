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
	RX_BUFF_SIZE=$20 ; UART RX buffer size, keep it power of 2 
    TIB_ORG = $200
    TIB_SIZE = 128 
    PAD_SIZE = 128 
    PROG_LOAD = $300 ; program load address 

;----------------------------
; BOOLEAN FLAGS 
; masks to be used with 
; AND,OR,TRB,TSB instructions 
;----------------------------
    F_SR_TX=(1<<0) ; SR set to transmit mode when 1 
    F_TIMER=(1<<1) ; timer active when 1 
    F_SOUND=(1<<2) ; sound timer active 

    RAM_SIZE=32768 ; installed RAM size 
    CODE_SIZE=RAM_SIZE-PROG_LOAD ; maximum application code size  

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
FLASH_BUFF: .res 2 ; FLASH memory transaction buffer address
BCOUNT: .res 2 ; flash memory transaction bytes count 
FLASH_ADR: .res 3   ; 24 bits flash memory address  
RX_HEAD: .res 1  ; ACIA RX queue head pointer 
RX_TAIL: .res 1  ; ACIA RX queue tail pointer 
STR_PTR: .res 2  ; pointer to string printed by PUTS 
RX_BUFF: .RES RX_BUFF_SIZE  
PZ_FREE: .res 0  ; page zero free space *..$FF 


PZ_FREE_SIZE=256-* ; size of page zero available to application  

; transaction input buffer 
    .ORG TIB_ORG 
TIB: 
    .RES TIB_SIZE 
; working area 
PAD: .RES PAD_SIZE 

	.CODE  
    .ORG $E000 

; BIOS code here 

;-----------------------------
;  COLD START 
;  hardware initialization
;-----------------------------    
RESET:	
; initialize stack pointer     
    LDX   $FF 
    TXS 
; set heap address  
    LDA #>PROG_LOAD 
    LDX #<PROG_LOAD 
    STA HEAP_ADR+1 
    STX HEAP_ADR 
; available RAM space for programs     
    LDA #>CODE_SIZE 
    LDX #<CODE_SIZE 
    STA HEAP_FREE+1
    STX HEAP_FREE          
; intialize Status register 
; disable iterrupts 
    SEI 
; initialize ACIA and terminal 
    JSR ACIA_INIT 
; initialize VIA to interface to 
; W25Q080DV flash memory 
    JSR VIA_INIT
; enable interrupts 
    CLI 
; print BIOS information 
    JSR CLS ; clear terminal screen 
    _PUTS BIOS_INFO 
    JSR MONITOR       

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
	LDA #0 
	STA RX_HEAD 
	STA RX_TAIL  
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

VIA_INIT:
; configure PB0 as output
    LDA #FLASH_CS 
    TSB VIA_DDRB
    TSB VIA_IORB ; CS0 high 
;  set timer1 for 1 msec interrupt 
; timer1 mode 1 and shift register mode 6  
; default mode for shift register is SHIFT_OUT 
    LDA #(T1_INTR_CONT<<ACR_T1_MODE)
    STA VIA_ACR
; count base on Fsys=3.6864 Mhz
    LDA #<3686 
    STA VIA_T1CL
    LDA #>3686
    STA VIA_T1LH
    STA VIA_T1CH
;enable T1 interrupt 
    LDA #VIA_SET_IE+VIA_T1_IE  
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
    LDA #VIA_T1_IF
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

FLASH_READ_STATUS=5   ; read status register 1
FLASH_WRITE_ENABLE=6  ; enable write|erase 
FLASH_WR=2          ; write {1..256} bytes 
FLASH_RD=3          ; read n bytes 
FLASH_ERASE_4K=$20  ; erase 4KB block 
FLASH_ERASE_32K=$52 ; erase 32KB block 
FLASH_ERASE_64K=$D8 ; erase 64KB block 
FLASH_ERASE_ALL=$60 ; erase chip 
FLASH_DEVID=$90 ; get device ID 
FLASH_BUSY=1 

;------------------------------
; VIA shift register interrupt 
; handler 
; transmit or receive next byte 
; depending of state F_SR_TX
;------------------------------
VIA_INTR:
; test T1_IF  
    AND #VIA_T1_IF   
    BEQ @EXIT  
; timer 2 interrupt handler 
; increment millisecond counter
; this is a 32 bits variable  
@TMR1_INTR: 
    INC MSEC 
    BNE @TMR_DECR 
    INC MSEC+1
    BNE @TMR_DECR 
    INC MSEC+2 
    BNE @TMR_DECR 
    INC MSEC+3 
@TMR_DECR: ; decrement timer is enabled  
    LDA FLAGS 
    AND #F_TIMER 
    BEQ @EXIT
    _DECW TIMER 
    BNE @EXIT 
; timeout, reset timer flag
    LDA #F_TIMER 
    TRB FLAGS 
@EXIT: 
; clear T1 IF bit 
    LDA #VIA_T1_IF
    STA VIA_IFR 
    PLA 
    RTI 


;---------------------------------
;  send one byte to FLASH via
;  VIA shift register 
;  input:
;     A    byte to send 
;---------------------------------
SEND_BYTE:
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
    _SET_SR_OUT
    _FLASH_SEL ; enable flash memory 
; send W25Q080 command 
    LDA #FLASH_READ_STATUS
    STA VIA_SR
    JSR WAIT_SR_IF  
; switch to shift in mode 
    _SET_SR_IN 
    LDA VIA_SR ; start shifin   
@LOOP:
    JSR WAIT_SR_IF ; wait shift in completed 
    LDA VIA_SR 
    AND #FLASH_BUSY 
    BNE @LOOP 
    _FLASH_DESEL
    RTS 


;------------------------------------
;  enable write bite in W25Q080 
;  status register 
;------------------------------------
ENABLE_WRITE:
    _SET_SR_OUT
    _FLASH_SEL
    LDA #FLASH_WRITE_ENABLE
    STA VIA_SR   
    JSR WAIT_SR_IF
    _FLASH_DESEL 
    RTS 

;-------------------------------------
;  erase block in W25Q080 
;  input:
;     A   OPCODE: {FLASH_ERASE_4K,FLASH_ERASE_32K,
;                  FLASH_ERASE_64K}
;     farptr  block address 
;-------------------------------------
ERASE_BLOCK:
    PHA 
    JSR ENABLE_WRITE 
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
;  chip erae W25Q080
;  OPCODE $60 
;---------------------------------------
ERASE_ALL:
    JSR ENABLE_WRITE 
    _FLASH_SEL 
    LDA #FLASH_ERASE_ALL
    STA VIA_SR 
    JSR WAIT_SR_IF 
    _FLASH_DESEL 
    JSR WAIT_COMPLETED 
    RTS 
 

;----------------------------------------
;  write up to 256 bytes in W25Q080 
;  input:
;      A    byte count 
;----------------------------------------
FLASH_WRITE: 
    STA BCOUNT 
    PHX 
    JSR ENABLE_WRITE
    _FLASH_SEL
    LDA #FLASH_WR 
    STA VIA_SR 
    JSR WAIT_SR_IF
    JSR FLASH_SEND_ADR
@LOOP:
    LDA FLASH_BUFF,X 
    STA VIA_SR 
    JSR WAIT_SR_IF 
    INX 
    DEC BCOUNT 
    BNE @LOOP
    _SWITCH_SR_OFF 
    _FLASH_DESEL
    JSR WAIT_COMPLETED 
    PLX 
    RTS  

;------------------------------------------
; read a bloc of bytes from W25Q080 
;------------------------------------------
FLASH_READ: 
    PHX 
    LDA #FLASH_RD 
    JSR SEND_BYTE 
    JSR FLASH_SEND_ADR 
    _SWITCH_SR_IN
    LDX #0
    LDA VIA_SR ; start shift in  
@LOOP:
    JSR WAIT_SR_IF
    LDA VIA_SR 
    STA FLASH_BUFF,X 
    INX 
    DEC BCOUNT 
    BNE @LOOP 
    _FLASH_DESEL 
    _SWITCH_SR_OFF 
    PLX 
    RTS 

;-----------------------------------
; read FLASH chip mfg device ID 
; output:
;    A   devid 
;    X   mfg id 
;-----------------------------------
FLASH_RD_DEVID: 
    LDA #0 
    STA FLASH_ADR 
    STA FLASH_ADR+1
    STA FLASH_ADR+2
; send command 
    _SET_SR_OUT
    _FLASH_SEL
    LDA #FLASH_DEVID
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
    LDA #CR 
    BRA PUTC 
 

;----------------------
; PRT_SPC 
; print space 
;----------------------
PRT_SPC: 
    LDA #SPACE 
    BRA PUTC 

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
    .ORG $FE00 
BIOS_CALL:
    ASL A
    PHY 
    TAY 
    PLA 
    JMP (FNTABLE,X)  


;-----------------------------------
; BIOS function table 
FNTABLE: 
    .WORD 0 

;----------------------------
; monitor wozmon style
;----------------------------
    .SEGMENT "MONITOR" 
    .ORG $FF00 
MONITOR: 
    JSR GETC
    CMP #'Q' 
    BEQ @EXIT  
@ECHO:      
    JSR PUTC 
    BRA MONITOR    
@EXIT:
    JSR NEW_LINE
    RTS 


	.SEGMENT "VECTORS" 
	.ORG $FFFA    
	.WORD RESET   ; (NMI)
	.WORD RESET   ; (RESET)
	.WORD INTR_SELECTOR   ; (IRQ)

	
	
	
