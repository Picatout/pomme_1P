;----------------------------
; Wozmon adapté au pomme-1.5
;----------------------------
	
	.PC02
	
	.include "../inc/ascii.inc"
    .include "../inc/macros.inc" 

	ACIA_DATA = $D000
	ACIA_STATUS = $D001 
	ACIA_CMD = $D002
	ACIA_CTRL = $D003
	RX_FULL = 1<<4 ; receive buffer full is bit 4 

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


	.segment "DATA"
; string pointer for PUTS 
    .org 0 
RX_HEAD: .res 1  ; ACIA RX queue head pointer 
RX_TAIL: .res 1  ; ACIA RX queue tail pointer 
STR_PTR: .res 2  ; pointer to string printed by PUTS 

; terminal input buffer.
	.org IN
RX_BUFFER: .RES BUFF_SIZE  

; transaction input buffer 
    .org TIB_ORG 
TIB: 
    .res TIB_SIZE 

	.segment "CODE"
	.org $E000 

 
;-----------------------------
;  COLD START 
;  hardware initialization
;-----------------------------    
RESET:	
; initialize stack pointer     
    LDX   $FF 
    TXS   
; intialize Status register 
; disable iterrupts 
    LDA   #PSR_IRQ_DIS
    PHA 
    PLP   
; clear input buffer 	
	LDA #0 
	STA RX_HEAD 
	STA RX_TAIL  
; SETUP ACIA FOR 115200 BAUD,8N1 
	LDA #$89       ; DTR ready, no parity
	STA ACIA_CMD   ; 
	LDA #16
	STA ACIA_CTRL
	CLI          ; enable interrupt           
	LDY #0       ; initialize Y to 0  
; print BIOS information 
    JSR CLS ; clear terminal screen 
    _puts BIOS_INFO 
    JSR NEW_LINE          ; 
    JMP MONITOR  ; embedded application 

BIOS_INFO: .asciiz "pomme I+ BIOS version 1.0R0"	

;---------------------------
; send character to terminal
; input:
;    A   character to send
;---------------------------
PUTC:
	STA ACIA_DATA  ; store character in ACIA register 
	PHX            ; save X on stack 
; need delay to avoid character overwrite in ACIA data register 
; 10 bits at 115200 BAUD = 86.8µsec 
; if Fclk=3.6864Mhz transmission delay --> 320 cycles/5cy = 64 loops  
	LDX #64         
DELAY:
	DEX 		   ; 2cy
	BNE DELAY      ; 3cy = 5cy per loop 
	PLX            ; pull X from stack 
	RTS            ; done 

;------------------------
; send new line character 
;------------------------
NEW_LINE:
    PHA 
    LDA #CR 
    JSR PUTC 
    PLA 
    RTS 

;---------------------------------
; print string to console 
; input:
;   STR_PTR   pointer to .ASCIIZ
;--------------------------------- 
PUTS:
    PHA
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
    PLA
    RTS  

;-----------------------------
; get character from IN buffer
; output:
;     A    0||character 
;----------------------------- 
GETC:
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

;-------------------------	
; read line from terminal
; line terminated byte CR
;   BS delete last character 
; output:
;    TIB   text line 
;    A     line length
;-------------------------
READLN:
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
    LDA #LETTER_C+LOWER  
    JSR PUTC 
    PLA 
    RTS 

;-----------------------------
;  upper case letter 
; input:
;    A    character 
; output:
;    A   upper if letter 
;------------------------------
UPPER:
    CMP #$61 ; 'a' 
    BMI UPPER_EXIT
    CMP #$7B ; '{'
    BPL UPPER_EXIT 
    AND #$DF
UPPER_EXIT:
    RTS 

;--------------------------------
; UART receive Interrupt handler
;--------------------------------
RX_IRQ_HANDLER:
                PHA
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


	.segment "VECTORS" 
	.org $FFFA    
	.WORD RESET   ; (NMI)
	.WORD RESET   ; (RESET)
	.WORD RX_IRQ_HANDLER      ; (IRQ)

	
	
	
