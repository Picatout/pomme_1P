;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; parameters stack in zero page 
; 64 bytes reserved 
; addr:  $C0..$FF 
;  Y register is used as 
;  stack pointer 
; threading model: subroutine call
; cell size: 2 bytes 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

    .PC02 


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; stack manipulation macros 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
SP_BASE=$80 ; argument stack range $80..$FF 
SP_EMPTY=0 ; Y value when stack is empty   
; offset relative to Y 
TOPL=SP_BASE    ; top cell low byte 
TOPH=SP_BASE+1  ; top cell high byte 
NEXTL=SP_BASE+2 ; second cell low byte 
NEXTH=SP_BASE+3 ; seconde cell high byte 

; header flags 
    IMMED=(1<<7) ; immediate word 
    COMPO=(1<<6) ; compile only word 
    NAM_MASK=$1F ; 31 character maximum 

; dictionary HEADER 
    .MACRO _HEADER NLEN, NAME, LBL 
    .WORD LINK
    LINK .SET * 
    .BYTE NLEN, NAME 
    LBL:
    .ENDMACRO 

; push AX on stack 
    .MACRO _PUSH  
    DEY 
    LDA AX 
    STA SP_BASE,Y 
    DEY 
    LDA #AX+1 
    STA SP_BASE,Y 
    .ENDMACRO 

; pop to AX 
    .MACRO _POP 
    LDA SP_BASE,Y 
    STA AX 
    INY 
    LDA SP_BASE,Y 
    STA AX+1
    INY 
    .ENDMACRO 


;;;;;;;;;;;;;;;;;;;;;;
; stack routines 
;;;;;;;;;;;;;;;;;;;;;;

    LINK .SET 0 

    _HEADER 4,"COLD",COLD 
    LDY #0 
    JSR QUIT 
    RTS  

;------------------------
; interpreter loop 
;-------------------------
    _HEADER 4,"QUIT",QUIT 

    RTS 

;---------------------------
; compile time for LITERAL 
;--------------------------
DO_LIT: 
    DEY 
    LDA AX 
    STA SP_BASE,Y 
    DEY 
    LDA #AX+1 
    STA SP_BASE,Y 
    RTS 

;-------------------------
; push a literal 
; ( -- n )
;-------------------------
    _HEADER 7,"LITERAL",LIT 
    _PUSH ; push AX on stack 
     RTS 


;-------------------------
; two's complement 
; ( n -- -n )
;-------------------------
    _HEADER 3,"NEG",NEG 
    CLC 
    LDA TOPL,Y 
    EOR #255
    ADC #1  
    STA TOPL,Y 
    LDA TOPH,Y 
    EOR #255
    BCC :+
    INC 
:   STA TOPH,Y 
    RTS 

;-------------------------
;  16 bits sum 
; ( n1 n2 -- n1+n2 )
;-------------------------
    _HEADER 4,"PLUS",PLUS
    CLC 
    LDA NEXTL,Y 
    ADC TOPL,Y 
    STA NEXTL,Y 
    LDA NEXTH,Y 
    ADC TOPH,Y 
    STA NEXTH,Y 
    INY 
    INY 
    RTS 

;---------------------------
; 16 bits substraction 
; ( n1 n2 -- n1-n2 )
;---------------------------
    _HEADER 4,"MINUS",MINUS 
    SEC 
    LDA NEXTL,Y 
    SBC TOPL,Y 
    STA NEXTL,Y 
    LDA NEXTH,Y 
    SBC TOPH,Y 
    STA NEXTH,Y 
    INY 
    INY 
    RTS 

;--------------------------
; 16 bits product
; ( n1 n2 -- n1*n2 ) 
;-------------------------
    _HEADER 1,"*",STAR 

    RTS 

;---------------------------
; 16 bits division 
; (n1 n2 -- n1/n2 )
;---------------------------
    _HEADER 1,"/",SLASH

    RTS 

;----------------------------
; 16 bits modulo 
; ( n1 n2 -- n1 mod n2 )
;----------------------------
    _HEADER 3,"MOD",MOD


    RTS 

; keep it at end of dictionary 

    LAST = LINK 
