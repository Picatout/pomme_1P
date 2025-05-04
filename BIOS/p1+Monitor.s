;----------------------------
; Wozmon adapté au pomme-1.5
;----------------------------
	
	.PC02
	

	
; mode constants 
	M_XAM = 0  ; ADR<CR> examine 1 memory byte 
	M_BLOKXAM = '.'  ; $2E,  ADR1.ADR2 examine a block of memory 
	M_STORE = ':'    ; $3A<<1=$74 , ADR: BYTE ... store data to memory 

; other operations:
;	ADR'R'<CR>  run application at ADR 
;	SECT#'X'<CR>  erase W25Q080 SECTOR# 
;	'*'<CR>  erase W25Q080 chip  
;   ADR'!'PAGE<CR> store 256 memory bytes in W25Q080 flash memory 
;   ADR'@'PAGE<CR> load 256 bytes from W25Q080 to memory 
;   'Q'<CR> quit monitor 

	XAML=FLASH_BUFF 
	XAMH=FLASH_BUFF+1
	STL=FLASH_ADR+1
	STH=FLASH_ADR+2
	L=BCOUNT
	H=BCOUNT+1 
	YSAV=PZ_FREE 
	MODE=PZ_FREE+1
	
    .SEGMENT "MONITOR" 
    .ORG $FE00 
MON_INFO: .BYTE "pomme 1+ monitor version 1.0R0",CR,0

MONITOR:
	_PUTS MON_INFO 
GETLINE:
	JSR NEW_LINE
	LDA #'#'    ; prompt character  
	JSR PUTC      ; show prompt  
	JSR READLN    ; read line from terminal
	BEQ GETLINE   ; empty line 
	LDY  #$FF     ; reset text index 
	LDA #0        ; default mode = M_XAM 
	TAX           ; hex digit accumulator = 0 
SETSTOR:
	ASL 
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
    BNE @T0
	JSR STORE_PAGE
	BRA GETLINE     
@T0:  
	CMP #'.'       ; exam block 
    BEQ SETMODE    ; '.'  set MODE=BLOKXAM 
	CMP #':'       ;  ':' set MODE=M_STORE  
    BEQ SETSTOR 
    CMP #'X' 
    BNE @T1    ; erase W25Q080 4KB sector 
    JSR ERASE_SECTOR 
    BRA GETLINE 
@T1:
    CMP #'*'       ; erase W25Q080 chip 
    BNE @T2 
    JSR ERASE_ALL 
    BRA GETLINE 
@T2: 
    CMP #'R'       ; check for RUN 
	BNE @T3		   ; run application at XAM address 
	JMP (XAML)
@T3: 
    CMP #'Q'       ; quit monitor 
    BNE @T4  
    RTS 
@T4:
	CMP #'@'
	BNE @T5 
	JSR LOAD_PAGE 
	BRA GETLINE 
@T5:	
	JSR PARSE_HEX  
	CPY YSAV       ; check there was an HEX number in buffer 
	BEQ GETLINE    ; if Y as not changed there was not 
	BIT MODE 
	BVC NOTSTOR    ; XAM OR XAMBLK  
	LDA L 		   ; STORE  mode, get byte to store 
	STA (STL,X)    ; save last address parsed in STL:STH 
	INC STL        ; increment STL:STH 
	BNE TONEXTITEM   
	INC STH        ; STL overflowed then increment STH 
TONEXTITEM:        ; go to accept next buffer token
	JMP NEXTITEM
NOTSTOR:           ; MODE is XAM or BLOKXAM? 
	LDA MODE       
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
	JSR PRT_HEX     ; print address high byte 
	LDA XAML        ; address low byte 
	JSR PRT_HEX     ; print address low byte 
	LDA #':'        ; display ':' after address 
	JSR PUTC  
PRDATA:             ; print data byte to terminal  
	LDA #SPACE      ; separate by a blank 
	JSR PUTC  
	LDA (XAML,X)    ; get data from memory
	JSR PRT_HEX     ; print it to terminal.
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
	BRA NXTPRNT     ; alway taken 
	

;----------------------------
; parse hexadecimal number 
;---------------------------
PARSE_HEX:
    LDA #0
	STA L          ; 0 in L:H 
	STA H 
	STY YSAV       ; save Y 
NEXTHEX:           ; check for HEXADECIMAL digit 
	LDA TIB,Y
	JSR UPPER      ; convert {'a'..'f'} -> {'A'..'F'}
	CMP #'0' 
	BMI NOTHEX 
	CMP #'G' 
	BPL NOTHEX
	SEC
	SBC #'0'       ;
	CMP #10        ; if a<10 then
	BCC DIG        ; A in {0..9} 
	CMP #17
	BMI NOTHEX 
	SBC #7         ; map {A..F} to {10..15}
DIG:               ;  A=A*16 then transfer in L:H  
	ASL            
	ASL             
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
	RTS 

;------------------------------
; erase W25Q080 4KB sector 
; SECTOR#'X'<CR>
;------------------------------
ERASE_SECTOR:
	_PUTS CONFIRM 
	JSR GETC 
	JSR UPPER 
	CMP #'Y'
	BNE @EXIT  
; FLASH_ADR=SECTOR#*4096 
	LDX #4
@LOOP:
	CLC 
	ROL L 
	ROL H
	DEC 
	BNE @LOOP 
	LDA L 
	STA FLASH_ADR+1 
	LDA H 
	STA FLASH_ADR+2
	LDA #0 
	STA FLASH_ADR
	LDA #CODE_ERASE_4K
	JSR ERASE_BLOCK  
@EXIT: 
    RTS 

CONFIRM: .BYTE "CONFIRM FLASH ERASE(Y/N)",CR,0

;-----------------------------
; store 256 bytes buffer in W25Q080
; ADR!PG#<CR>
; XAM -> buffer address 
; L:H -> W25Q080 page#
;-----------------------------
STORE_PAGE:
	INY 
	JSR PARSE_HEX 
	CPY YSAV 
	BEQ @EXIT 
; FLASH_ADR=L:H*256
	LDA L 
	STA FLASH_ADR+1 
	LDA H 
	STA FLASH_ADR+2 
	LDA #0 
	STA FLASH_ADR 
	JSR FLASH_WRITE	
@EXIT:
    RTS 

;------------------------------
; load page from W25Q080  
; from W25Q080 
; ADR@PG# 
; XAM -> buffer address 
; L:H -> W25Q080 page#
;-----------------------------
LOAD_PAGE:
	INY 
	JSR PARSE_HEX 
	CPY YSAV 
	BEQ @EXIT 
; FLASH_ADR=L:H*256
	LDA L 
	STA FLASH_ADR+1 
	LDA H 
	STA FLASH_ADR+2 
	LDA #0 
	STA FLASH_ADR 
	JSR FLASH_READ	
@EXIT: 
    RTS 


	
	
	
