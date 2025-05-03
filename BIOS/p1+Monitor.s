;----------------------------
; Wozmon adapté au pomme-1.5
;----------------------------
	
	.PC02
	

	
; mode constants 
	M_XAM = 0  ; examine 1 memory byte 
	M_BLOKXAM = '.'  ; examine a block of memory 
	M_STORE = ':'    ; store data to memory 
    M_PG_STORE='!'   ; store 256 memory bytes in W25Q080 flash memory 
    M_PG_LOAD='@'   ; load 256 bytes from W251080 to memory 
    M_SECT_ERASE='X' ; erase W25Q080 4KB sector 
    M_CHIP_ERASE='*' ; erase W25Q080 chip

	.segment "DATA" 
	; monitor variables 
	.org $3A    
	XAML: .res 1 
	XAMH: .res 1
	STL: .res 1 
	STH: .res 1 
	L: .res 1 
	H: .res 1 
	YSAV: .res 1 
	MODE: .res 1
	
    .SEGMENT "MONITOR" 
    .ORG $FE00 
MON_INFO: .ASCIIZ "pomme 1+ monitor version 1.0R0"

MONITOR:
	_PUTS MON_INFO 
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
SETMODE:           ; set operation MODE 
	STA MODE       ; 0 = M_XAM
BLSKIP:
	INY            ; move Y index to next buffer character 
NEXTITEM:          ; parse next token 
	LDA TIB,Y 
	JSR UPPER 
	CMP #CR        ; if carriage return parsing done 
	BEQ GETLINE    ; accept next input 
	CMP #'!'       ; check for MODE character 
	BMI BLSKIP     ;  if char < '!' char invalid, ignore it.
    BEQ SETMODE    
	CMP #'.'       ; exam block 
    BEQ SETMODE    ; '.'  set MODE=BLOKXAM 
	CMP #':'       ;  ':' set MODE=M_STORE  
	BEQ SETMODE    ;  set MODE=STORE
	CMP #'@' 
    BEQ SETMODE 
    CMP #'*'       ; erase W25Q080 chip 
    BNE NEXT_TEST 
    JSR ERASE_ALL 
    BRA GETLINE 
NEXT_TEST: 
    CMP #'R'       ; check for RUN 
	BEQ RUN        ; run application at XAM address 
    CMP #'Q'       ; quit monitor 
    BNE SAVE_ADR
    RTS 
SAVE_ADR:
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
	LDA #':'        ; display ':' after address 
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

;------------------------
; parse hexadecimal
; from tib 
PARSE_HEX:

    RTS 

;------------------------------
; fetch and display page 
; from W25Q080 
;-----------------------------
FETCH_PAGE:
    LDX #4 
@LOOP:
    ASL L 
    ROL H
    DEX 
    BNE @LOOP  
    LDX L 
    LDA H 
    STA FLASH_ADR+1
    STX FLASH_ADR
;input buffer at $300 
    LDA #3
    LDX #0
;---------------------------
; read 256 bytes from W25Q080
; display it 
; parameters:
;     A:X  input buffer 
;     FLASH_ADR  page address 
;---------------------------
DSPL_PAGE:
	STA FLASH_BUFF+1 
	STX FLASH_BUFF 
	LDA #0 
	JSR FLASH_READ 
	LDY #0 
	LDX #0
@LOOP:
	LDA (FLASH_BUFF),Y 
	JSR PRT_HEX 
	JSR PRT_SPC 
	INY 
	DEX
	BEQ @EXIT 	 
	TXA 
	AND #15 
	BNE @LOOP 
	JSR NEW_LINE 
	BRA @LOOP 
@EXIT:
	RTS 

	
	
	
