;----------------------------
; Wozmon adapté au pomme-1.5
;----------------------------
	
	.PC02

	.include "../inc/ascii.inc"
    .include "macros.inc" 

;-------------------------------
; W65C21 ACIA registers addresses
;-------------------------------
	ACIA_DATA = $D000
	ACIA_STATUS = $D001 
	ACIA_CMD = $D002
	ACIA_CTRL = $D003
	RX_FULL = 1<<4 ; receive buffer full is bit 4 

;-------------------------------
; W65C22 VIA registers addresses
;-------------------------------
    VIA_IORB = $D060 ; input/output data register port B 
    VIA_IORA = $D061 ; input/output data register port A
    VIA_DDRB = $D062 ; Data direction register port B 
    VIA_DDRA = $D063 ; Data direction register port A
    VIA_T1CL =  $D064 ; timer1 low order counter 
    VIA_T1CH =  $D065 ; timer1 high order counter 
    VIA_T1LL =  $D066 ; timer1 low order latch 
    VIA_T1LH =  $D067 ; timer 1 high order latch 
    VIA_T2CL =  $D068 ; timer 2 low order counter 
    VIA_T2CH = $D069  ; timere 2 high order counter 
    VIA_SR  =  $D06A  ; shift register 
    VIA_ACR =  $D06B  ; auxiliary control register 
    VIA_PCR =  $D06C  ; peripheral control register 
    VIA_IFR =  $D06D  ; interrupt flags register 
    VIA_IER =  $D06E  ; interrupt enable register 
    VIA_IORA_NHS = $D06F ; input/output data register A, no handshake 


;----------------------------------    
; VIA_ACR configuration 
; To use CB1,CB2 for SPI transfert 
; CB1 is SPI clock 
; CB2 is data I/O
; PB0 used as chip select output 
; configure IRQ to trigger when shift is completed  
;----------------------------------
    SHIFT_IN = (2<<2) ; VIA_SR shift in on PHI2  control  in VIA_ACR 
    SHIFT_OUT = (6<<2) ; VIA_SR shift out on PHI2 control in VIA_ACR 
    SHIFT_DISABLE = (7<<2) ; VIA SR disabled
    SR_IER=(1<<2) ; to set interrupt on shift register in VIA_IER 
    SR_IFR=(1<<2) ; shift register interrupt flag in VIA_IFR 
    T1_IER=(1<<6) ; timer 1 interrupt enable bit in VIA_IER 
    T1_IFR=(1<<6) ; timer 1 interrupt flag bit in VIA_IFR 
    T2_IER=(1<<5) ; timer 2 interrupt enable bit in VIA_IER 
    T2_IFR=(1<<5) ; timer 2 interrupt flag bit in VIA_IFR 
    FLASH_CS=(1<<0) ; PB0 used as chip select 

; Processor status register bits 
    PSR_CARRY = 1
    PSR_ZERO = 2
    PSR_IRQ_DIS = 4
    PSR_DMODE = 8 
    PSR_BRK = 16 
    PSR_OVF = 64 
    PSR_NEG = 128 

   ; constants 
	BUFF_SIZE=$20 ; keep it power of 2 <= 256 
	IN   = $100-BUFF_SIZE 
    TIB_ORG = $200
    TIB_SIZE = 128 

;----------------------------
; BOOLEAN FLAGS 
;----------------------------
    F_SR_TX=1 ; SR set to transmit mode when 1 
    F_TIMER=2 ; timer active when 1 

	.SEGMENT "DATA"
; string pointer for PUTS 
    .ORG 0
MSEC: .res 4  ; millisecond counter
TIMER: .res 2 ; msec timer   
FLAGS: .res 1 ; boolean flags 
BUF_ADR: .res 2 ; transaction buffer address
BCOUNT: .res 2 ; transaction bytes count 
FLASH_ADR: .res 3   ; 24 bits address to access external flash memory  
RX_HEAD: .res 1  ; ACIA RX queue head pointer 
RX_TAIL: .res 1  ; ACIA RX queue tail pointer 
STR_PTR: .res 2  ; pointer to string printed by PUTS 

; terminal input buffer.
	.ORG IN
RX_BUFFER: .RES BUFF_SIZE  

; transaction input buffer 
    .ORG TIB_ORG 
TIB: 
    .RES TIB_SIZE 

	.SEGMENT "CODE"
    .ORG $E000 
; BIOS code here 


;-----------------------------
;  COLD START 
;  hardware initialization
;-----------------------------    
    .PROC RESET	
; initialize stack pointer     
    LDX   $FF 
    TXS   
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
    JSR NEW_LINE
    JSR MONITOR       
; test code 
TEST:
INF_LOOP:
    _PUTS QBF
    JSR NEW_LINE 
    _PAUSE 1000
    BRA TEST  

    .ENDPROC 

    .PROC DELAY 
    LDA #0 
DLY0:    
    LDX #0 
DLY1:
    DEX 
    BNE DLY1
    DEC A 
    BNE DLY0  
    RTS 
    .ENDPROC 


BIOS_INFO: .asciiz "pomme I+ BIOS version 1.0R0"	

QBF: .ASCIIZ "THE QUICK BROWN FOX JUMP OVER THE LAZY DOG."


;-------------------------------
; initialize W65C51 ACIA and 
; terminal queue 
;-------------------------------
    .PROC ACIA_INIT 
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
    .ENDPROC 

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
    .PROC VIA_INIT
; configure PB0 as output
    LDA #1 
    STA VIA_DDRB
    STA VIA_IORB ; CS0 high 
;  set timer1 for 1 msec interrupt 
; mode 1 
    LDA #(1<<6)
    STA VIA_ACR
; count base on Fsys=3.6864 Mhz
    LDA #<3686 
    STA VIA_T1CL
    LDA #>3686
    STA VIA_T1LH
    STA VIA_T1CH
;enable T1 and SR interrupt 
    LDA #(1<<7)+T1_IER 
    STA VIA_IER 
    RTS 
    .ENDPROC 

;-------------------------------
; check for interrupt origin 
; and execute the corresponding 
; handler 
; 2 possible sources 
;   VIA   W65C22 
;   ACIA  W65C51 
;-------------------------------
    .PROC INTR_SELECTOR
    PHA 
    LDA VIA_IFR 
    BPL ACIA_TEST  
; W65C22 VIA interrupt  
    JMP VIA_INTR 
; W65C51 ACIA interrupt
ACIA_TEST:
    LDA #RX_FULL 
    AND ACIA_STATUS
    BEQ EXIT  
    JMP ACIA_HANDLER
EXIT:
    PLA 
    RTI 
    .ENDPROC 

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;  FLASH memory basic functions 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

FLASH_READ_STATUS=5
FLASH_WRITE_ENABLE=6 
FLASH_WR=2 
FLASH_RD=3 
FLASH_ERASE_4K=$20
FLASH_ERASE_32K=$52
FLASH_ERASE_64K=$D8 
FLASH_ERASE_ALL=$60
FLASH_BUSY=1 

;------------------------------
; VIA shift register interrupt 
; handler 
; transmit or receive next byte 
; depending of state F_SR_TX
;------------------------------
    .PROC VIA_INTR
; test T1_IFR  
    AND #T1_IFR  
    BEQ EXIT  
; timer 2 interrupt handler 
; increment millisecond counter
; this is a 32 bits variable  
TMR1_INTR: 
    INC MSEC 
    BNE TMR_DECR 
    INC MSEC+1
    BNE TMR_DECR 
    INC MSEC+2 
    BNE TMR_DECR 
    INC MSEC+3 
TMR_DECR: ; decrement timer is enabled  
    LDA FLAGS 
    AND #F_TIMER 
    BEQ EXIT 
    DEC TIMER
    BNE EXIT  
    DEC TIMER+1 
    BNE EXIT 
; timeout, reset timer flag
    LDA #F_TIMER 
    TRB FLAGS 
EXIT: 
; clear all IF bits 
    LDA #127  
    STA VIA_IFR 
    PLA 
    RTI 
    .ENDPROC 

;---------------------------------
;  send one byte to FLASH via
;  VIA shift register 
;  input:
;     A    byte to send 
;---------------------------------
SEND_BYTE:
    PHA 
    LDA #SHIFT_OUT 
    STA VIA_ACR 
    _FLASH_SEL 
    PLA 
    STA VIA_SR  
; wait for SR interrupt flag set 
WAIT_SR_IF: 
@LOOP:
    LDA #SR_IFR 
    AND VIA_SR 
    BEQ @LOOP   ; loop until shift out completed 
    TRB VIA_SR ; reset interrupt flag 
    RTS 


;-----------------------------------
;  receive one byte from 
;  VIA shift register 
; output:
;     A   byte received 
;------------------------------------
RCV_BYTE:
; set shift in mode 
    LDA #SHIFT_IN 
    TSB VIA_ACR 
    LDA VIA_SR ; start shifting 
    JSR WAIT_SR_IF ; wait shift completed 
; disable shift register     
    LDA #SHIFT_DISABLE
    TRB VIA_ACR 
    LDA VIA_SR ; get byte 
    RTS 
 

;---------------------------------
; wait write/erase operation 
; to complete 
; busy bit in flash SR1 is 1 when busy 
;---------------------------------
WAIT_COMPLETED: 
    _FLASH_SEL ; enable flash memory 
    LDA #SHIFT_OUT
    TSB VIA_ACR ; set shift out mode 
    LDA #FLASH_READ_STATUS
    STA VIA_SR
    JSR WAIT_SR_IF  
    LDA #SHIFT_DISABLE
    TRB VIA_ACR ; disable shift register  
    LDA #SHIFT_IN 
    TSB VIA_ACR  ; enable shift in 
    LDA VIA_SR ; start shifin  
@LOOP: 
    JSR WAIT_SR_IF ; wait shift in completed 
    LDA VIA_SR 
    AND #FLASH_BUSY 
    BNE @LOOP 
    LDA #SHIFT_DISABLE
    TRB VIA_ACR ; disable shift register 
    _FLASH_DESEL
    RTS 


;------------------------------------
;  enable write bite in W25Q080 
;  status register 
;------------------------------------
ENABLE_WRITE:
    LDA #SHIFT_OUT 
    TSB VIA_ACR ; set shift out mode 
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
    JSR SEND_ADR 
    LDA #SHIFT_DISABLE
    TRB VIA_ACR 
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
SEND_ADR:      
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
    LDA #SHIFT_DISABLE
    TRB VIA_ACR 
    _FLASH_DESEL 
    JSR WAIT_COMPLETED 
    RTS 
 

;----------------------------------------
;  write up to 256 bytes in W25Q080 
;  input:
;      A    byte count 
;----------------------------------------
    .PROC FLASH_WRITE 
    STA BCOUNT 
    PHX 
    JSR ENABLE_WRITE
    _FLASH_SEL
    LDA #FLASH_WR 
    STA VIA_SR 
    JSR WAIT_SR_IF
    JSR SEND_ADR
@LOOP:
    LDA BUF_ADR,X 
    STA VIA_SR 
    JSR WAIT_SR_IF 
    INX 
    DEC BCOUNT 
    BNE @LOOP
    _FLASH_DESEL
    LDA #SHIFT_DISABLE
    TRB VIA_ACR 
    JSR WAIT_COMPLETED 
    PLX 
    RTS 
    .ENDPROC 

;------------------------------------------
; read a bloc of bytes from W25Q080 
;------------------------------------------
FLASH_READ: 
    PHX 
    LDA #FLASH_RD 
    JSR SEND_BYTE 
    JSR SEND_ADR 
    LDA #SHIFT_IN 
    STA VIA_ACR ; set shift in mode 
    LDX #0
    LDA VIA_SR ; start shift in  
@LOOP:
    JSR WAIT_SR_IF
    LDA VIA_SR 
    STA BUF_ADR,X 
    INX 
    DEC BCOUNT 
    BNE @LOOP 
    _FLASH_DESEL 
    LDA #SHIFT_DISABLE
    TRB VIA_ACR 
    PLX 
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
    .PROC SET_TIMER 
    STA TIMER+1 
    STX TIMER 
; set TIMER flag 
    LDA #F_TIMER 
    TSB FLAGS 
    RTS 
    .ENDPROC 

;-----------------------------------
; suspend execution for msec 
; input:
;   A    timer high byte 
;   X    timer low byte 
;-----------------------------------
    .PROC PAUSE 
; set delay     
    JSR SET_TIMER 
WAIT: ; wait timeout 
    LDA #F_TIMER 
    AND FLAGS 
    BNE WAIT 
    RTS     
    .ENDPROC 

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;   terminal functions 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;--------------------------------
; W65C51 ACIA triggered interrupt 
; UART receive Interrupt handler
;--------------------------------
    .PROC ACIA_HANDLER
                PHX 
                LDA     ACIA_STATUS 
                AND     #RX_FULL ; check rx bit 
                BEQ     NOT_ACIA    ; interrupt was not trigerred by ACIA 
                LDA     ACIA_DATA 
				CMP     #CTRL_C 
                BNE     RX1
                JMP     RESET ; CTRL+C reset computer 
RX1:
                CMP     #127 
                BPL     RX_DISCARD   ; ignore codes >126
RX_ACCEPT:
                LDX     RX_HEAD ; update queue head index 
				STA     IN,X 
				INX
				TXA 
				AND     #BUFF_SIZE-1 
				STA     RX_HEAD  
NOT_ACIA:
RX_DISCARD:
                PLX
                PLA
                RTI 
    .ENDPROC 

;---------------------------
; send character to terminal
; input:
;    A   character to send
;---------------------------
    .PROC PUTC
	STA ACIA_DATA  ; store character in ACIA register 
; need delay to avoid character overwrite in ACIA data register 
; 10 bits at 115200 BAUD = 86.8µsec 
; if Fclk=3.6864Mhz transmission delay --> 320 cycles/5cy = 64 loops  
	LDA #65         
DELAY:
	DEC	A	       ; 2cy
	BNE DELAY      ; 3cy = 5cy per loop 
	RTS            ; done 
    .ENDPROC 

;------------------------
; send new line character 
;------------------------
    .PROC NEW_LINE
    LDA #CR 
    BRA PUTC 
    .ENDPROC 

;----------------------
; PRT_SPC 
; print space 
;----------------------
    .PROC PRT_SPC 
    LDA #SPACE 
    BRA PUTC 
    .ENDPROC

;---------------------------------
; print string to console 
; input:
;   A   string address high byte 
;   X   sring address low byte 
;--------------------------------- 
    .PROC PUTS
    STA STR_PTR+1 
    STX STR_PTR 
    PHY  
    LDY #0     
PUTS_NEXT:     
	LDA (STR_PTR),Y
	BEQ PUTS_EXIT 
	JSR PUTC 
	INY 
	BRA PUTS_NEXT 
PUTS_EXIT:
    PLY  
    RTS  
    .ENDPROC 

;-----------------------------
; get character from IN buffer
; output:
;     A    0||character 
;----------------------------- 
    .PROC GETC
	LDA      RX_TAIL 
	CMP      RX_HEAD 
	BEQ      NO_CHAR 
	TAX
	LDA      IN,X 
	PHA 
	INX                     ; update queue tail index 
	TXA
	AND     #BUFF_SIZE-1   
	STA     RX_TAIL
	PLA    
	RTS 
NO_CHAR:
	LDA #0 
	RTS 
    .ENDPROC 

;-------------------------	
; read line from terminal
; line terminated byte CR
;   BS delete last character 
; output:
;    TIB   text line 
;    A     line length
;-------------------------
    .PROC READLN
    LDY #0
READLN_LOOP:
    JSR GETC 
    BEQ READLN_LOOP 
    CMP #BS
    BNE TEST_CR 
    TYA 
    BEQ READLN_LOOP 
    JSR BACK_SPACE
    DEY 
    BRA READLN_LOOP   
TEST_CR: 
    CMP #CR 
    BNE NEXT_TEST 
    STA TIB,Y 
    INY
    JSR PUTC  
    BRA READLN_EXIT
NEXT_TEST:
    CMP #SPACE 
    BMI READLN_LOOP ; ignore it 
    CMP #127 
    BPL READLN_LOOP ; >126 ignore it     
KEEP_IT:
    STA TIB,Y 
    INY
    JSR PUTC  
    BRA READLN_LOOP 
READLN_EXIT:
    TYA 
    RTS 
    .ENDPROC 

;----------------------
; delete last character
;----------------------
    .PROC BACK_SPACE
    PHA 
    LDA #BS 
    JSR PUTC 
    LDA #SPACE 
    JSR PUTC 
    LDA #BS 
    JSR PUTC
    PLA  
    RTS 
    .ENDPROC 

;----------------------
; clear terminal screen
;----------------------
    .PROC CLS
    PHA 
    LDA #ESC 
    JSR PUTC 
    LDA #'c' 
    JSR PUTC 
    PLA 
    RTS 
    .ENDPROC 

;-----------------------------
;  upper case letter 
; input:
;    A    character 
; output:
;    A   upper if letter 
;------------------------------
    .PROC UPPER
    CMP #'a' 
    BMI UPPER_EXIT
    CMP #'{'
    BPL UPPER_EXIT 
    AND #$DF
UPPER_EXIT:
    RTS 
    .ENDPROC 

;-----------------------------
; PRT_HEX 
; print byte in hexadecimal 
; input:
;    A   byte to print 
;-----------------------------
    .PROC PRT_HEX 
    PHA 
    LSR A 
    LSR A 
    LSR A 
    LSR A
    JSR TO_HEX
    PLA 
    AND #$F   
TO_HEX: 
    CLC 
    ADC #'0'
    CMP #'9'+1
    BMI PRT 
    ADC #7 
PRT:
    JSR PUTC 
    RTS 
    .ENDPROC 

;-----------------------------
; PRT_HWORD 
; print X:A word in hexadecimal 
; input:
;    A   word high byte 
;    X   word low byte 
;------------------------------
    .PROC PRT_HWORD 
    JSR PRT_HEX 
    TXA 
    BRA PRT_HEX 
    .ENDPROC 


;----------------------------
; monitor wozmon style
;----------------------------
    .SEGMENT "MONITOR" 
    .ORG $FF00 
    .PROC MONITOR 
    JSR GETC
    CMP #'Q' 
    BEQ EXIT  
ECHO:      
    JSR PUTC 
    BRA MONITOR    
EXIT:
    JSR NEW_LINE
    RTS 
    .ENDPROC 

	.SEGMENT "VECTORS" 
	.ORG $FFFA    
	.WORD RESET   ; (NMI)
	.WORD RESET   ; (RESET)
	.WORD INTR_SELECTOR   ; (IRQ)

	
	
	
