;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; parameters stack in zero page 
; 64 bytes reserved 
; addr:  $C0..$FF 
;  X register is used as 
;  stack pointer 
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

; dictionary HEADER 
    .MACRO _HEADER NLEN, NAME, LBL 
    .WORD LINK
    LINK .SET * 
    .BYTE NLEN, NAME 
    LBL:
    .ENDMACRO 

; push integer on stack 
    .MACRO _PUSH N 
    DEY 
    LDA #>N 
    STA SP_BASE,Y 
    DEY 
    LDA #<N 
    STA SP_BASE,Y 
    .ENDMACRO 

; pop to ACC16 
    .MACRO _POP 
    LDA SP_BASE,Y 
    STA ACC16 
    INY 
    LDA SP_BASE,Y 
    STA ACC16+1
    INY 
    .ENDMACRO 


;;;;;;;;;;;;;;;;;;;;;;
; stack routines 
;;;;;;;;;;;;;;;;;;;;;;

    LINK .SET 0 

    _HEADER 4,"COLD",COLD 
    LDY #0 


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


; keep it at end of dictionary 

    LAST = LINK 
