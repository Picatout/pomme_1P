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
	YSAV=ZP_FREE 
	MODE=ZP_FREE+1
	
    .SEGMENT "MONITOR" 
    .ORG $FD00 
MON_INFO: .BYTE "pomme 1+ monitor version 1.1R0",CR,0

MONITOR:
	_PUTS MON_INFO
	STZ XAML 
	STZ XAMH
	STZ L 
	STZ H  
GETLINE:
	JSR NEW_LINE
	LDA #'#'    ; prompt character  
	JSR PUTC      ; show prompt  
	JSR READLN    ; read line from terminal
	BEQ GETLINE   ; empty line 
	LDY  #$FF     ; reset text index 
	LDX #0         ; hex digit accumulator = 0 
	LDA #0 
SETMODE:           ; set operation MODE 
	STA MODE       ; 0 = M_XAM
BLSKIP:
	INY            ; move Y index to next buffer character 
NEXTITEM:          ; parse next token 
	LDA TIB,Y 
	CMP #SPACE 
	BEQ BLSKIP
	JSR UPPER 
	CMP #CR        ;
	BNE @N0        ; 
	LDA MODE 
	BNE @DISPR
	LDA XAML 
	STA L 
	LDA XAMH 
	STA H 
@DISPR:	 
	JSR DISPLAY_RANGE
	BRA GETLINE 
@N0:
	CMP #'!'       ; check for MODE character 
	BMI BLSKIP     ;  if char < '!' char invalid, ignore it.
    BNE @T0
	JSR STORE_RANGE
	BRA GETLINE     
@T0:  
	CMP #'.'       ; exam block 
    BEQ SETMODE    ; '.'  set MODE=BLOKXAM 
	CMP #':'       ;  ':' set MODE=M_STORE  
    BNE @T1
	JSR MODIFY 
	BRA GETLINE 
@T1:	  
    CMP #'X' 
    BNE @T2    ; erase W25Q080 4KB sector 
    JSR ERASE_SECTOR 
    BRA GETLINE 
@T2:
    CMP #'*'       ; erase W25Q080 chip 
    BNE @T3 
    JSR ERASE_ALL 
    BRA GETLINE 
@T3: 
    CMP #'R'       ; check for RUN 
	BNE @T4		   ; run application at XAM address 
	JMP (XAML)
@T4: 
    CMP #'Q'       ; quit monitor 
    BNE @T5  
    RTS 
@T5:
	CMP #'@'
	BNE @T6 
	JSR LOAD_RANGE 
	BRA GETLINE 
@T6:	
	JSR PARSE_HEX  
	CPY YSAV       ; check there was an HEX number in buffer 
	BEQ GETLINE    ; if Y as not changed there was not 
	LDA MODE 
	BNE NEXTITEM 
	LDA L 
	STA XAML
	STA STL  
	LDA H 
	STA XAMH 
	STA STH  
	BRA NEXTITEM 

;----------------------------
; parse hexadecimal number 
;---------------------------
PARSE_HEX:
	DEY 
@SKPSPC:
	INY 
	LDA TIB,Y 
	CMP #CR 
	BEQ @NOTSPC 
	CMP #SPACE 
	BEQ @SKPSPC 
@NOTSPC:
	STZ L          ; 0 in L:H 
	STZ H 
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

;-------------------------
; store quoted string 
;--------------------------
STORE_STRING:
	INY 
	LDA TIB,Y 
	CMP #CR 
	BEQ @EXIT 
	CMP #'"' 
	BEQ @STREND
	STA (STL)
	INC STL 
	BNE STORE_STRING 
	INC STH 
	BRA STORE_STRING 
@STREND:
	LDA #0
	STA (STL)
	INC STL 
	BNE @N0 
	INC STH 
@N0: 	
	INY 
@EXIT:
	RTS 

;--------------------------
; modify memory starting 
; at STL 
;-------------------------
MODIFY:
	INY ; skip ':' character 
@LOOP:	
	JSR PARSE_HEX 
	CPY YSAV 
	BEQ @TRY_QUOTE  
	LDA L 
	STA (STL)
	INC STL 
	BNE @LOOP 
	INC STH 
	BRA @LOOP
@TRY_QUOTE:
	LDA TIB,Y 
	CMP #'"'
	BNE @EXIT 
	JSR STORE_STRING 
	BRA @LOOP	  
@EXIT: 
	RTS 

;-------------------------
; display address 
; input:
;   AX  address 
;-------------------------
DISPLAY_ADDR:
	JSR NEW_LINE
	JSR PRT_HWORD 
	LDA #':'
	JSR PUTC 
	JSR PRT_SPC
	RTS 

;-----------------------
; display ASCCII value 
; at end of each row 
;-----------------------
PRT_ASCII:
	JSR PRT_SPC 
	LDA #';'
	JSR PUTC
	LDY #$FF 
@SPC:
	LDA #SPACE   
@LOOP:
	JSR PUTC 
	INY 
	TYA 
	CMP #16
	BEQ @EXIT 
	LDA PAD,Y 
	CMP #SPACE
	BMI @SPC
	CMP #127 
	BPL @SPC  
	BRA @LOOP 
@EXIT:	  
	RTS 

;------------------------------
; display memory content 
; from XAM..L 
;------------------------------
DISPLAY_RANGE:
	STY YSAV
@NEW_ROW:
	LDA XAMH
	LDX XAML
	JSR DISPLAY_ADDR 
	LDY #$FF 
@LOOP:
	LDA (XAML)
	INY 
	STA PAD,Y 
	JSR PRT_HEX 
	JSR PRT_SPC 
	_INCW XAML
	LDA L 
	SEC 
	CMP XAML  
	LDA H 
	SBC XAMH 
	BMI @EXIT 
	LDA XAML 
	AND #15
	BNE @LOOP
	JSR PRT_ASCII 
	BRA @NEW_ROW   
@EXIT:
	JSR PRT_ASCII 
	LDA XAML 
	STA L 
	LDA XAMH 
	STA H 
	LDY YSAV 
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
STORE_RANGE:
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
; load range from W25Q080  
; from W25Q080 
; ADR1.ADR2'L'PG# 
; XAM -> buffer address 
; L:H -> W25Q080 page#
;-----------------------------
LOAD_RANGE:
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


	
	
	
