;----------------------------
; Wozmon adapté au pomme-1.5
;----------------------------
	
	.PC02
	
	
	ACIA_DATA = $D000
	ACIA_STATUS = $D001 
	ACIA_CMD = $D002
	ACIA_CTRL = $D003
	
	; variables 
	XAML = 4
	XAMH = 5
	STL  = 6 
	STH  = 7
	L    = 8
	H    = 9
	YSAV = $A
	MODE = $B
	RX_HEAD=$C 
	RX_TAIL=$D 
	IN   = $80
	BUFF_SIZE=$80 
	; ASCII constant 
	CTRL_C = 3
	CR = 13 
	BS = 8
	ESC = 27
	SPACE = 32 
	BSLASH = $5C 
	DOT = $2E
	COLUMN = $3A 
	LETTER_F = $46
	LETTER_R = $52

	.segment "DATA" 
	.org IN
RX_BUFFER: .RES BUFF_SIZE  

	.segment "CODE"
	.org $E000 
RESET:	
	CLD   ; clear decimal mode
	SEI   ; disable interrupts, not used
; clear inpu buffer 	
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
PRT_MSG:
	LDA MSG,Y
	BEQ MSG_EXIT 
	JSR ECHO 
	INY 
	BRA PRT_MSG 
MSG_EXIT:
	LDA #13 
	JSR ECHO 
NEXTCHAR:          ; get next character 
	JSR GETC  
	BEQ NEXTCHAR   ; no char in buffer
	JSR ECHO       ; echo it to terminal 
	BRA NEXTCHAR 

ECHO:              ; send character to terminal 
	STA ACIA_DATA 
	PHX            ; save X on stack 
	LDX #64        ; transmission delay, 320µsec/5cy  for Fclk=3.6864Mhz 
DELAY:
	DEX 		   ; 2cy
	BNE DELAY      ; 3cy = 5cy 
	PLX            ; pull X from stack 
	RTS            ; done 

MSG: .asciiz "Hello world!"	

; get character from IN buffer 
GETC:
	LDA      RX_TAIL 
	CMP      RX_HEAD 
	BEQ      NO_CHAR 
	TAX
	LDA      IN,X 
	PHA 
	INX
	TXA
	AND     #$7F   
	STA     RX_TAIL
	PLA    
	RTS 
NO_CHAR:
	LDA #0 
	RTS 
	
; UART receive Interrupt handler
RX_IRQ_HANDLER:
                PHA
                PHX 
                LDA     ACIA_STATUS
                LDA     ACIA_DATA
				LDX     RX_HEAD 
				STA     IN,X 
				INX
				TXA 
				AND     #$7F 
				STA     RX_HEAD 
                PLX
                PLA
                RTI 

	
	.segment "VECTORS" 
	.org $FFFA    
	.WORD $F00   ; (NMI)
	.WORD RESET  ; (RESET)
	.WORD RX_IRQ_HANDLER      ; (IRQ)

	
	
	
