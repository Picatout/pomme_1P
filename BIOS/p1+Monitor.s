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
	LIML=XAMH+1
	LIMH=LIML+1
	; store address 
	STL=LIMH+1
	STH=STL+1
	; last parsed number 
	L=STH+1
	H=L+1 
	; savec Y register 
	YSAV=H+1 
	; operation mode 
	MODE=YSAV+1
	; 16 bits accumulator 
	ACCL=MODE+1 
	ACCH=ACCL+1  

    .SEGMENT "MONITOR" 
    .ORG $FC00 
MON_INFO: .BYTE "pomme 1+ monitor version 1.3R3",CR,0

MONITOR:
	_PUTS MON_INFO
	STZ XAML 
	STZ XAMH
	STZ LIML 
	STZ LIMH  
GETLINE:
	JSR NEW_LINE
	LDA #'#'    ; prompt character  
	JSR PUTC      ; show prompt  
	JSR READLN    ; read line from terminal
	BEQ GETLINE   ; empty line 
	LDY  #$FF     ; reset text index 
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
	CMP #CR        
	BNE VALID_CMD      
	LDA MODE 
	BNE CMD_EXEC 
	JSR DISP16B
	BRA GETLINE 
VALID_CMD: ; check if character is in command list 
	CMP #':' 
	BNE @T0 
	JSR MODIFY 
	BRA GETLINE 
@T0:
	STA ACCL 
	LDX #10
@LOOP:
	DEX 
	BMI @TRY_HEX
	LDA CMD_TABLE,X 	
	CMP ACCL 
	BNE @LOOP 
	TXA 
	STA MODE 
	BRA BLSKIP
@TRY_HEX:	
	JSR PARSE_HEX  
	CPY YSAV       ; check there was an HEX number in buffer 
	BNE @T10
	BRA GETLINE    ; if Y as not changed there was not 
@T10: 
	LDA MODE 
	BEQ @T11 
	CMP #9 
	BEQ @T12
; 3th parameter , address or else 
	LDA L 
	STA STL 
	LDA H 
	STA STH  
	BRA NEXTITEM
@T11: ; first address 
	LDA L 
	STA XAML
	STA STL
	LDA H 
	STA XAMH 
	STA STH
	JMP NEXTITEM 
@T12: ; adress after '.', range limit 
	LDA L 
	STA LIML 
	LDA H 
	STA LIMH 	 
	JMP NEXTITEM 
CMD_EXEC:
; set return address to GETLINE 
	LDA #>GETLINE  
	LDX #<GETLINE 
	DEX  
	BNE @SKIP
	DEC A 
@SKIP: 
; jump to command 
	PHA 
	PHX 
	LDA MODE 
	ASL 	 
	TAX
	JMP (CALL_TABLE,X)


CMD_TABLE: .byte 0,'Z','X','*','W','R','M','V','G','.'
CALL_TABLE: .word 0,ZERO_FILL,ERASE_SECTOR,ERASE_CHIP,STORE_RANGE,LOAD_RANGE,MOVE,VERIFY,RUN,DISPLAY_RANGE 


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
; routine, the routine 
; must terminate by RTS  
;  XAM'G'<CR>
;------------------------
RUN:
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
	STA L 
	JSR STORE_BYTE 
	INC STL 
	BNE STORE_STRING 
	INC STH 
	BRA STORE_STRING 
@STREND:
	LDA #0
	STA L 
	JSR STORE_BYTE 
	INC STL 
	BNE @N0 
	INC STH 
@N0: 	
	INY 
@EXIT:
	RTS 

;--------------------------
; modify memory starting 
; ST: byte||"string" ... 
;-------------------------
MODIFY:
	INY ; skip CR character 
@LOOP:	
	JSR PARSE_HEX 
	CPY YSAV 
	BEQ @TRY_QUOTE  
	JSR STORE_BYTE 
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

;--------------------------
; check address 
; if in range $C000...$DFFF 
; then EEWRITE 
;--------------------------
STORE_BYTE:
	LDA #$C0 
	CMP STH 
	BMI @RAM 
	LDA #$E0 
	BPL @EXIT ; out of range  
	BRA EEWRITE 
@RAM:
	LDA L 
	STA (STL)
@EXIT:	
	RTS 

;--------------------------
; write a byte to AT28BV64 
; EEPROM 
; addr: $C0000...$DFFF
; input:
;    A    byte to write 
;--------------------------
EEWRITE:
	_EEWRITE_ENABLE
	LDA L  
	STA (STL)
	_EEWRITE_DISABLE
; wait programming completion 
; bit 7 is inverterd 
; while EEPROM is busy programming byte.
:	LDA (STL)
	CMP L 
	BNE :-  
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

;------------------------
; display next 16 bytes 
; from XAM 
;-----------------------
DISP16B:	 
	LDA XAML 
	CLC 
	ADC #15
	STA LIML  
	LDA XAMH
	ADC #0  
	STA LIMH 

;------------------------------
; display memory content 
; XAM.LIM 
;------------------------------
DISPLAY_RANGE:
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
	LDA LIML 
	CMP XAML  
	LDA LIMH 
	SBC XAMH 
	BMI @EXIT 
	LDA XAML 
	AND #15
	BNE @LOOP
	JSR PRT_ASCII 
	BRA @NEW_ROW   
@EXIT:
	JSR PRT_ASCII 
	RTS 

;---------------------
; '*' erase all W25128 
;-----------------------
ERASE_CHIP:
	INY 
	_PUTS WARNING
	JSR GETC 
	JSR UPPER 
	CMP #'Y'
	BNE @EXIT  
	_PUTS WAIT40S
	JMP ERASE_ALL 
@EXIT: 	
	RTS 

WARNING: .byte "THIS WILL ERASE WHOLE SSD, (Y/N)?",CR,0
WAIT40S: .byte "Be patient it take 40+ seconds",CR,0 


;------------------------------
; erase W25Q080 4KB sector 
; SECTOR#'X'<CR>
;------------------------------
ERASE_SECTOR:
	INY 
	_PUTS CONFIRM 
	JSR GETC 
	JSR UPPER 
	CMP #'Y'
	BNE @EXIT  
; FLASH_ADR=SECTOR#*4096 
	LDX #4
@LOOP:
	CLC 
	ROL XAML  
	ROL XAMH 
	DEX 
	BNE @LOOP 
	LDA XAML  
	STA FLASH_ADR+1 
	LDA XAMH 
	STA FLASH_ADR+2
	LDA #0 
	STA FLASH_ADR
	LDA #CODE_ERASE_4K
	JSR ERASE_BLOCK  
@EXIT: 
    RTS 

CONFIRM: .BYTE "CONFIRM FLASH ERASE(Y/N)",CR,0

;-----------------------------
; store memory range to W25Qxxx
; write multiple of 256 bytes 
; ADR1.ADR2'W'PG#<CR>
; ADR1 -> XAM , start address 
; ADR2 -> LIM , last address 
; PG# -> ST, W25QXXX page#
;-----------------------------
STORE_RANGE:
; copy XAM to FLASH_BUFF 
   _MOVW FLASH_BUFF, XAML 
   STZ FLASH_ADR ; low byte always 0 
   _MOVW FLASH_ADR+1,STL
@LOOP:
   LDA #0 ; count of bytes to write 0=256 
   JSR FLASH_WRITE  
   INC FLASH_BUFF+1 ; next source page  	
   INC FLASH_ADR+1 ; next ssd page 
   BNE :+
   INC FLASH_ADR+2
: ; compare with limit 
   LDA LIMH 
   CMP FLASH_BUFF+1
   BPL @LOOP	
   RTS 


;------------------------------
; load range from W25Q080  
; from W25Q080 
; range must be 256 bytes multiple
; ADR1.ADR2'R'PG# 
; ADR1 -> XAM , load address 
; ADR2 -> LIM , last addr 
; PG# -> ST , W25Q080 page#
;-----------------------------
LOAD_RANGE:
; copy XAM to FLASH_BUFF 
   _MOVW FLASH_BUFF, XAML 
   STZ FLASH_ADR ; low byte always 0
   _MOVW FLASH_ADR+1,STL
@LOOP:
   LDA #0 
   JSR FLASH_READ 
   INC FLASH_BUFF+1 ; next load page 
   INC FLASH_ADR+1 ; next ssd page
   BNE :+
   INC FLASH_ADR+2  
: 
;  compare FLASH_BUFF+1 with LIMH
   LDA LIMH 
   CMP FLASH_BUFF+1
   BPL @LOOP 
@EXIT:
   RTS 


;-------------------
; zero fill range 
; XAM.LIM'Z' 
;------------------
ZERO_FILL:
@L00:	 
	LDA #0
	STA L 
	JSR STORE_BYTE 
	INC STL 
	BNE @L01
	INC STH 
@L01:
	LDA LIML 
	CMP STL   
	LDA LIMH 
	SBC STH 
	BPL @L00  
	RTS 

;--------------------
; move range to ADR3  
; XAM'.'LIM'M'ST 
;--------------------  
MOVE:
@LOOP:
	LDA (XAML)
	STA L 
	JSR STORE_BYTE 
	INC XAML 
	BNE @INCR_ST 
    INC XAMH
@INCR_ST:
	INC STL 
	BNE @CHECK_LIMIT 
	INC STH 	 
@CHECK_LIMIT:
	LDA LIML  
	CMP XAML 
	LDA LIMH 
	SBC XAMH 
	BPL @LOOP
@EXIT:
	RTS 
	
;-----------------------
; COMPARE 2 ranges 
; display difference 
; XAM'.'LIM'V'ST
;-----------------------
VERIFY:
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
	LDA LIML 
	CMP XAML
	LDA LIMH 
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

