;----------------------------
; Wozmon adapté au pomme-1.5
;----------------------------
	
	.PC02
	
	.include "bios.s"
	
; mode constants 
	M_XAM = 0 
	M_BLOKXAM = $2E ; '.'
	M_STORE = $74  ; ':' << 1 

	.segment "DATA" 
	; monitor variables 
	.org $10   ; first 16 reserved for system variables 
	XAML: .res 1 
	XAMH: .res 1
	STL: .res 1 
	STH: .res 1 
	L: .res 1 
	H: .res 1 
	YSAV: .res 1 
	MODE: .res 1
	

	.segment "MONITOR"
	.org $FF00
	
MON_INFO: .ASCIIZ "pomme 1+ monitor version 1.0R0"

MONITOR:
	_puts MON_INFO 
	JSR NEW_LINE
GETLINE:
	JSR NEW_LINE
	LDA #SHARP    ; prompt character '#'  
	JSR PUTC      ; show prompt  
	JSR READLN    ; read line from terminal
	BEQ GETLINE   ; empty line 
	LDY  #$FF     ; reset text index 
	LDA #0        ; default mode = M_XAM 
	TAX           ; hex digit accumulator = 0 
SETSTOR:
	ASL            ; multiply ':' by 2 = $74  
SETMODE:           ; set operation MODE 
	STA MODE       ; 0 = XAM, $74 = STOR, $2E=BLOKXAM
BLSKIP:
	INY            ; move Y index to next buffer character 
NEXTITEM:          ; parse next token 
	LDA TIB,Y 
	JSR UPPER 
	CMP #CR        ; if carriage return parsing done 
	BEQ GETLINE    ; accept next input 
	CMP #DOT       ; check for MODE character 
	BCC BLSKIP     ;  if char < '.' char invalid, ignore it.
	BEQ SETMODE    ; '.'  set MODE=BLOKXAM 
	CMP #COLUMN    ;  ':' character 
	BEQ SETSTOR    ;  set MODE=STORE
	CMP #LETTER_R  ; check for 'R'
	BEQ RUN        ; run application at XAM address 
	STX L          ; 0 in L:H 
	STX H 
	STY YSAV       ; save Y 
NEXTHEX:           ; check for HEXADECIMAL digit 
	LDA TIB,Y
	JSR UPPER      ; convert {'a'..'f'} -> {'A'..'F'}
	EOR #48        ; A=A EOR '0' if A in {'0'..'9'} then A in {0..9} else if A in {'A'..'Z'} then a in {'q'..'v'}
	CMP #10        ; if a<10 then
	BCC DIG        ; A in {0..9}
	ADC #$98       ; else if A in {$71..$76} then map to {10..15}
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
	BEQ GETLINE    ; if Y as not changed there was not 
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
	JSR PUTC        ; send carriage return to terminal
	LDA XAMH        ; print next address at start of next line 
	JSR PRBYTE      ; print address high byte 
	LDA XAML        ; address low byte 
	JSR PRBYTE      ; print address low byte 
	LDA #COLUMN     ; display ':' after address 
	JSR PUTC  
PRDATA:             ; print data byte to terminal  
	LDA #SPACE      ; separate by a blank 
	JSR PUTC  
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
	AND #15         ; Address modulo 16 (bytes per line)
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
ECHO:
	JSR PUTC 
	RTS 



	
	
	
