;----------------------------
; Wozmon adapté au pomme-1.5
;----------------------------
	
	.PC02
	
	
	ACIA_DATA = $D000
	ACIA_STATUS = $D001 
	ACIA_CMD = $D002
	ACIA_CR = $D003
	
	; variables 
	XAML = 4
	XAMH = 5
	STL  = 6 
	STH  = 7
	L    = 8
	H    = 9
	YSAV = $A
	MODE = $B
	IN   = $200
	
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

	.segment "CODE"
	.org $E000 
.PROC HELLO	
	CLD   ; clear decimal mode
	CLI   ; disable interrupts, not used 
; SETUP ACIA FOR 115200 BAUD,8N1 
	LDA #3         ; DTR ready, no IRQ
	STA ACIA_CMD   ; 
MSG_LOOP:
	LDY #0       ; initialize Y to -2 
MSG_LOOP2:
	LDA (MSG,Y)
	BEQ MSG_LOOP 
	BSR ECHO 
	INC Y 
	BRA MSG_LOOP2 

MSG: .asciiz "Hello world! "	
.ENDPROC 
	
	.segment "WOZMON"
	.org $FF00
	
.PROC RESET	
	CLD   ; clear decimal mode
	CLI   ; disable interrupts, not used 
; SETUP ACIA FOR 115200 BAUD,8N1 
	LDA #3         ; DTR ready, no IRQ
	STA ACIA_CMD   ; 
	LDY #$FE       ; initialize Y to -2 
NOTCR:             ; character input loop
	CMP #BS        ; backspace ? 
	BEQ BACKSPACE  ; yes then cursor left 
	CMP #ESC       ; ESCAPE? 
	BEQ ESCAPE    
	INY            ; inc Y to accept next character in buffer
	BPL NEXTCHAR 
ESCAPE:            ; display '\' character 
	LDA #BSLASH
	JSR ECHO 
GETLINE:           ; readline loop 
	LDA #CR        ; move terminal cursor    
	JSR ECHO       ; to start of next line
	LDY #1         ; iniatilize Y to input buffer+1
BACKSPACE:
	DEY            ; cursor left 
	BMI GETLINE    ; if back space empty line then start new line 
	JSR ECHO       ; else move display cursor left.
NEXTCHAR:          ; get next character 
	LDA ACIA_STATUS ; wait loop until status bit "character received" set. 
	AND #8         ; bit 3 is RX bit in ACIA status register.
	BEQ NEXTCHAR   ; no character received yet.
	LDA ACIA_DATA  ; read character from ACIA 
	STA IN,Y       ; store it un buffer 
	JSR ECHO       ; echo it to terminal 
	CMP #CR        ; Carriage return ? 
	BNE NOTCR 	   ; not end of line then test character 
	LDY #$FF       ; end of line 
	LDA #0         ; prepare for line parsing 
	TAX            ; X=0
SETSTOR:
	ASL            ; multiply A by 2 
SETMODE:           ; set operation MODE 
	STA MODE       ; 0 = XAM, $74 = STOR, $2E=BLOKXAM
BLSKIP:
	INY            ; move Y index to next buffer character 
NEXTITEM:          ; parse next token 
	LDA IN,Y
	CMP #CR        ; if carriage return parsing done 
	BEQ GETLINE    ; accept next input 
	CMP #DOT       ; check for MODE character 
	BCC BLSKIP     ;  if char < '.' char invalid, ignore it.
	BEQ SETMODE    ; '.'  set MODE=BLOKXAM 
	CMP #COLUMN    ;  ':' character 
	BEQ SETSTOR    ;  set MODE=STORE
	CMP #LETTER_R  ; check for 'R'
	BEQ RUN        ; run application at XAM address 
	STX L          ; store input hex number in L:H 
	STX H 
	STY YSAV       ; save Y 
NEXTHEX:           ; check for HEXADECIMAL digit 
	LDA IN,Y
	EOR #48        ; A=A-'0' 
	CMP #10        ; if a<10 then
	BCC DIG        ; A in {0..9}
	SBC #7         ; else A-7 map to {10..15}
	CMP #16        ; if A>15 then   
	BCS NOTHEX     ;  this is not en HEX digit
DIG:               ;  shift digit bit 7:4 of A 
	ASL            ; shift A left 1 bit 
	ASL            ; repeat 4 times 
	ASL
	ASL 
	LDX #4         ; shift count to transfert
HEXSHIFT:          ; this digit in L:H variable 
	ASL            ; A bit 7 in Carry
	ROL L          ; carry in bit 0 of L and bit 7 in Carry
	ROL H          ; Carry in bit 0 of H.
	DEX            ; decrement X 
	BNE HEXSHIFT   ; repeat 4 times 
	INY            ; move Y to next char in buffer 
	BNE NEXTHEX    ; check if another HEX number  
NOTHEX:            ; Y rollover means buffer overflow 
	CPY YSAV       ; check there was an HEX number in buffer 
	BEQ ESCAPE     ; if Y as not changed there was not 
	BIT MODE       ; check for MODE state, A:7 in carry, A:6 in overflow 
	BVC NOTSTOR    ; if bit 6 is cleared then not STORE
	LDA L 		   ; either XAM or BLOKXAM mode 
	STA (STL,X)    ; save last address parsed in STL:STH 
	INC STL        ; increment STL:STH 
	BNE NEXTITEM   
	INC STH        ; STL overflowed then increment STH 
TONEXTITEM:        ; go to accept next buffer token
	JMP NEXTITEM
RUN:               ; if RUN mode jmp here 
	JMP (XAML)     ; jump to address in XAM 
NOTSTOR:           ; MODE is XAM or BLOKXAM? 
	BNE XAMNEXT    ; if Z=0 -> BLOKXAM
	LDX #2
SETADR:            ; copy Address from L:H to ST and XAM
	LDA L-1,X
	STA STL-1,X
	STA XAML-1,X 
	DEX 
	BNE SETADR      ; 2 bytes to copy
NXTPRNT:            
	BNE PRDATA      ; if A==0 then end of line 
	LDA #CR         ; display 8 data bytes per line 
	JSR ECHO        ; send carriage return to terminal
	LDA XAMH        ; print next address at start of next line 
	JSR PRBYTE      ; print address high byte 
	LDA XAML        ; address low byte 
	JSR PRBYTE      ; print address low byte 
	LDA #COLUMN     ; display ':' after address 
	JSR ECHO 
PRDATA:             ; print data byte to terminal  
	LDA #SPACE      ; separate by a blank 
	JSR ECHO 
	LDA (XAML,X)    ; get data from memory
	JSR PRBYTE      ; print it to terminal.
XAMNEXT:            ; next data item 
	STX MODE        ; here X==0, reset MODE to XAM.
	LDA XAML        ; compare XAM address with L:H address
	CMP L           ; when equal no more data to display
	LDA XAMH        ; XAM high byte 
	SBC H           ; A=A-H-carry 
	BCS TONEXTITEM  ; XAM<L:H then next item
	INC XAML        ; increment XAM address
	BNE MOD8CHK     ; no overflow
	INC XAMH        ; XAML overflow, increment XAMH 
MOD8CHK:           
	LDA XAML        ; load A with low byte of address 
	AND #7          ; Address modulo 8 (bytes per line)
	BPL NXTPRNT     ; alway taken 
PRBYTE:  
	PHA             ; save A on stack
		            ; shift A7:4 in A3:0
	LSR             ; shift A 1 bit right 
	LSR             ; repeat 4 times 
	LSR 
	LSR 
	JSR PRHEX      ; print high digit 
	PLA            ; pull low digit and print it.
PRHEX:
	AND #$F        ; precaution an hex digit is 4 bits 
	ORA #48        ; add ASCII '0' to A 
	CMP #58        ; if <= ASCII '9' 
	BCC ECHO       ; print it
	ADC #6         ; adjust to {'A'..'F'} range 
ECHO:              ; send character to terminal 
	STA ACIA_DATA 
	PHX            ; save X on stack 
	LDX #64        ; transmission delay, 320µsec/5cy  for Fclk=3.6864Mhz 
DELAY:
	DEX 		   ; 2cy
	BNE DELAY      ; 3cy = 5cy 
	PLX            ; pull X from stack 
	RTS            ; done 
	.ENDPROC 
	
	.segment "VECTORS" 
	.org $FFFA    
	.WORD $F00   ; (NMI)
	.WORD $E000 ;$FF00  ; (RESET)
	.WORD 0      ; (IRQ)

	
	
	
