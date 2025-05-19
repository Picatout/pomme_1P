;----------------------------
; Wozmon adapté au pomme-1.5
;----------------------------
	
	.PC02
	

	
; mode constants 
	M_XAM = 0  ; ADR<CR> examine 1 memory byte 
	M_BLOKXAM = '.'  ; $2E,  ADR1.ADR2 examine a block of memory 
	M_STORE = ':'    ; $3A<<1=$74 , ADR: BYTE ... store data to memory 

; other operations:
;	ADR'G'<CR>  run application at ADR 
;	SECT#'X'<CR>  erase W25Q080 SECTOR# 
;	'*'<CR>  erase W25Q080 chip  
;   ADR'W'PAGE<CR> store 256 memory bytes in W25Q080 flash memory 
;   ADR'R'PAGE<CR> load 256 bytes from W25Q080 to memory 
;   'Q'<CR> quit monitor 


    ; examine address 
	XAML=ZP_FREE 
	XAMH=XAML+1
	; store address 
	STL=XAMH+1
	STH=STL+1
	; last parsed number 
	L=STH+1
	H=L+1 
	; savec Y register 
	YSAV=H+1 
	; operation mode 
	MODE=YSAV+1
	; range size 
	RANGEL=MODE+1 
	RANGEH=RANGEL+1 
	; 16 bits accumulator 
	ACCL=RANGEH+1 
	ACCH=ACCL+1  

    .SEGMENT "MONITOR" 
    .ORG $FC00 
MON_INFO: .BYTE "pomme 1+ monitor version 1.2R0",CR,0

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
	CLC 
	ADC #15
	STA L 
	LDA XAMH
	ADC #0  
	STA H 
@DISPR:	 
	JSR DISPLAY_RANGE
	BRA GETLINE 
@N0: ; check for write to W25Qxxx
	CMP #'W'       ; check for MODE character 
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
    CMP #'G'       ; check for GOSUB   
	BNE @T4		   ; run application at XAM address 
	JMP CALL_SUB  
@T4: 
    CMP #'Q'       ; quit monitor 
    BNE @T5  
    RTS 
@T5: ; read W25Qxxx flash
	CMP #'R'
	BNE @T6 
	JSR LOAD_RANGE 
	JMP GETLINE 
@T6: ; zero fill range 
	CMP #'Z'
	BNE @T7 
	JSR ZERO_FILL
@JP6:
	JMP GETLINE
@T7:
	CMP #'M' 
	BNE @T8 
	JSR MOVE 
	JMP GETLINE
@T8:
	CMP #'V' 
	BNE @T9 
	JSR VERIFY
	JMP GETLINE 
@T9:	
	JSR PARSE_HEX  
	CPY YSAV       ; check there was an HEX number in buffer 
	BEQ @JP6    ; if Y as not changed there was not 
	LDA MODE 
	BEQ @T11 
	JMP NEXTITEM 
@T11: 
	LDA L 
	STA XAML
	STA STL  
	LDA H 
	STA XAMH 
	STA STH 
@T12:	 
	JMP NEXTITEM 

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

;------------------------
; execute a machine code 
; routine 
;  ADRH'G'<CR>
;------------------------
CALL_SUB:
	LDA #>GETLINE  
	LDX #<GETLINE 
	DEX  
	BNE @SKIP
	DEC A 
@SKIP:
	PHA 
	PHX 
	JMP (XAML)

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
; 16 bits substraction  
; from accumulator ACC
; AX - ACC 
; input:
;    AX    first operand 
;    ACC   second operand 
; output:
;    AX   result 
;---------------------------
MINUS_ACC:
	PHA
	TXA 
	SEC 
	SBC ACCL
	TAX 
	PLA 
	SBC ACCH 
	RTS 

;--------------------------
; count of byte in range 
; XAM.LAST
; RANGE=L:H+1-XAML:XAMH 
;-------------------------
SET_RANGE_SIZE:
	INC L  
	BNE @L1 
	INC H 
@L1:
	_MOVW ACCL, XAML
	LDA H 
	LDX L 
	JSR MINUS_ACC 
	STA RANGEH 
	STX RANGEL 
	RTS 

;------------------------------
;expect page number in 
; TIB 
; put it in FLASH_ADR variable 
; output:
;   LH    flash page 
;------------------------------
PARSE_FLASH_PAGE:
	STZ FLASH_ADR ; low byte always zero  
	INY 
	JSR PARSE_HEX 
	CPY YSAV 
	RTS 

;---------------------------
; set bytes count 
; for flash r/w 
;--------------------------
SET_COUNT:
; save byte count in ACC 
	STZ ACCH 
	LDA RANGEH  
	BNE @GE256 ; >=256	
	LDA RANGEL
	PHP 
	BEQ @EXIT 
@GE256:
	INC ACCH 
	LDA #0
@EXIT: 
	STA ACCL  
	PLP 
	RTS 

;-------------------------
; increment flash page#
; decrement range_left 
;-------------------------
UPDATE_PARAMS:
; increment flash page number 
	INC FLASH_ADR+1
	BNE @DEC_COUNT 
	INC FLASH_ADR+2 
@DEC_COUNT: ; how many left 
	LDA RANGEH 
	LDX RANGEL 
	JSR MINUS_ACC ; bytes stored in ACC 
	STA RANGEH    ; what is left to store 
	STX RANGEL   
	RTS 

;-----------------------------
; store memory range to W25Qxxx
; ADR1'W'PG#<CR>
; XAM -> buffer address 
; L:H -> W25QXXX page#
;-----------------------------
STORE_RANGE:
; copy XAM to FLASH_BUFF 
   _MOVW FLASH_BUFF, XAML 
   STZ FLASH_ADR
   INY   
   JSR PARSE_HEX
   BEQ @EXIT 
   _MOVW FLASH_ADR+1,L
   LDA #0 
   JSR FLASH_WRITE  
@EXIT:  
   RTS 

;------------------------------
; load range from W25Q080  
; from W25Q080 
; ADR1'R'PG# 
; XAM -> buffer address 
; L:H -> W25Q080 page#
;-----------------------------
LOAD_RANGE:
; copy XAM to FLASH_BUFF 
   _MOVW FLASH_BUFF, XAML 
   STZ FLASH_ADR 
   INY 
   JSR PARSE_HEX
   BEQ @EXIT
   _MOVW FLASH_ADR+1,L
   LDA #0 
   JSR FLASH_READ 
@EXIT:
   RTS 


;-------------------
; zero fill range 
; ADR1.ADR2'Z' 
;------------------
ZERO_FILL:
	LDX #0
@L00:	 
	TXA 
	STA (XAML,x)
	INC XAML 
	BNE @L01
	INC XAMH 
@L01:
	LDA L
	CMP XAML   
	LDA H 
	SBC XAMH 
	BPL @L00  
	RTS 


;------------------------
; get 3th parameter 
; for 'M' and 'V' command 
;------------------------
GET_TARGET:
	LDA L 
	STA RANGEL 
	LDA H 
	STA RANGEH 
	INY 
	JSR PARSE_HEX 
	BEQ @EXIT
	LDA L 
	STA STL 
	LDA H 
	STA STH  
@EXIT:  
	RTS 

;--------------------
; move range to ADR3  
; ADR1'.'ADR2'M'ADR3
;--------------------  
MOVE:
	JSR GET_TARGET
	BEQ @EXIT 
@LOOP:
	LDA (XAML)
	STA (STL)
	INC XAML 
	BNE @INCR_ST 
    INC XAMH
@INCR_ST:
	INC STL 
	BNE @CHECK_LIMIT 
	INC STH 	 
@CHECK_LIMIT:
	LDA RANGEL  
	CMP XAML 
	LDA RANGEH 
	SBC XAMH 
	BPL @LOOP
@EXIT:
	RTS 
	
;-----------------------
; COMPARE 2 ranges 
; display difference 
; ADR1'.'ADR2'V'ADR3
;-----------------------
VERIFY:
	JSR GET_TARGET
	BEQ @EXIT 
@LOOP:
	LDA (XAML)
	CMP (STL)
	BNE @DIFF 
@NEXT:
	INC XAML 
	BNE @INCR_ST 
	INC XAMH 
@INCR_ST:
	INC STL 
	BNE @CHECK_LIMIT 
	INC STH 
@CHECK_LIMIT:
	LDA RANGEL 
	CMP XAML
	LDA RANGEH 
	SBC XAMH  
	BPL @LOOP
	BRA @EXIT 
@DIFF:
	LDA XAMH 
	LDX XAML 
	JSR PRT_HWORD
	JSR PRT_SPC
	LDA (XAML)
	JSR PRT_HEX 
	JSR PRT_SPC
	JSR PRT_SPC
	LDA STH 
	LDX STL  
	JSR PRT_HWORD
	JSR PRT_SPC   
	LDA (STL)
	JSR PRT_HEX 
	JSR NEW_LINE
	BRA @NEXT 
@EXIT:
	RTS 
