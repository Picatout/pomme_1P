;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;  16 bits two's complement 
;  arithmetic operations 
;  integer range {-32767...32767}
;  -32768 used as error marker 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 




;------------------
;   AX=AX+BX 
;------------------
ADD: 
    CLC 
    LDA AX 
    ADC BX 
    STA AX 
    LDA AX+1
    ADC BX+1 
    STA AX+1    
    RTS 

;------------------------
; increment AX 
; AX=AX+1
;------------------------
INCR:
    INC AX 
    BNE @EXIT 
    INC AX+1
@EXIT:
    RTS 

;-------------------
; AX=AX-BX 
;-------------------
SUBST: 
    SEC 
    LDA AX 
    SBC BX 
    STA AX 
    LDA AX+1 
    SBC BX+1 
    STA AX+1
    RTS 

;----------------------
; decrement AX 
; AX=AX-1
;----------------------
DECR:
    SEC
    LDA AX 
    SBC #1
    STA AX 
    LDA AX+1 
    SBC #0
    STA AX+1
    RTS 

;---------------------
;  AX=AX*BX 
;---------------------
MULT:
    LDA AX 
    EOR BX 
    PHA  ; product sign 
; make both integers positive 
    LDA AX+1 
    BPL :+
    _NEG_VAR AX 
: 
    LDA BX+1 
    BPL :+
    _NEG_VAR BX 
:
    JSR UPROD16 ; unsigned product 
    PLA ; get sign 
    BPL :+
    _NEG_VAR AX 
: 
    RTS 

;---------------------
; unsigned product 
; AX=AX*BX 
;--------------------
UPROD16:
    PHY 
    LDY #16
; initialize product variable to 0      
    STZ CX 
    STZ CX+1
; if one operand is zero then product is zero  
    LDA AX 
    ORA AX+1
    BEQ @EXIT 
    LDA BX 
    ORA BX+1
    BEQ @EXIT 
@LOOP: ; for each bit set in BX add AX to CX 
    LSR BX+1
    ROR BX 
    BCC @SHIFT_AX 
; if BX LSB==1 then add AX TO CX 
; CX=CX+AX 
    CLC 
    LDA AX 
    ADC CX 
    STA CX 
    LDA AX+1 
    ADC CX+1 
    STA CX+1
    BCS @OVF  ; product overflow    
@SHIFT_AX: ; shift left AX for next addition to CX 
    ASL AX 
    ROL AX+1
    BCS @OVF  ; product overflow 
    DEY 
    BNE @LOOP
@EXIT:
    _MOVW AX,CX       
    PLY 
    RTS 
@OVF: ; overflow 
    STZ CX 
    LDA #$80 
    STA CX+1     
    BRA @EXIT 


;-------------------------------
; AX=AX/BX 
; NOTE: This not euclidiean division  
; as quotient and remainder are not 
; corrected when quotient and divisor are 
; opposite sign. For more information see  
; ref: https://en.wikipedia.org/wiki/Euclidean_division  
;--------------------------------
DIV:
; must keep sign of quotient and divisor 
    LDA AX+1 
    EOR BX+1 
    PHA  ;  quotient sign 
    EOR BX+1 
    BPL :+
    _NEG_VAR AX 
: 
    LDA BX+1 
    BPL :+
    _NEG_VAR BX 
:
    JSR UDIV16 ; unsigned division 
; check quotient sign 
    PLA  ; quotient sign 
    BPL :+
    _NEG_VAR AX ; negative quotient 
: 
    RTS 

;-----------------------
; AX=AX%BX 
;-----------------------
MOD:
    JSR DIV 
    _MOVW AX,CX 
    RTS 

;------------------------
; DIVIDE 16 BITS 
; BY 8 BITS UNSIGNED 
; input:
;   AX dividend 
;   BX divisor 
; output:
;   AX  quotient
;   CX  remainder   
;-----------------------
    DIVIDEND=AX
    QUOTIENT=AX  
    DIVISOR=BX
    REMAINDER=CX  
UDIV16:
    PHY 
    STZ REMAINDER 
    STZ REMAINDER+1
; if dividend==0 then QUOTIENT=0
    LDA DIVIDEND 
    ORA DIVIDEND+1 
    BEQ @EXIT 
; if divisor==0 then error  
    LDA DIVISOR
    ORA DIVISOR+1 
    BNE @NOT_ZERO 
; division by 0 return $8000
    STZ QUOTIENT 
    LDA #$80 
    STA QUOTIENT+1
    BRA @EXIT     
@NOT_ZERO: 
    LDY #16 ; need 16 rotations as we rotate throught carry 
@DIV_LOOP:
; roll carry bit in QUOTIENT 
    ROL QUOTIENT 
    ROL QUOTIENT+1
; roll DIVIDEND MSB in REMAINDER      
    ROL REMAINDER 
    ROL REMAINDER+1
    SEC 
    LDA REMAINDER 
    SBC DIVISOR
    TAX  
    LDA REMAINDER+1
    SBC DIVISOR+1  
    BCC @TO_SMALL 
; replace REMAINDER by substraction result 
    STA REMAINDER+1
    TXA
    STA REMAINDER
@TO_SMALL:      
    DEY 
    BNE @DIV_LOOP
; shift last bit of quotient 
    ROL QUOTIENT
    ROL QUOTIENT+1
@EXIT:
    PLY  
    RTS 

;-------------------------
; shift right n bits 
; AX=AX >> BX 
;------------------------
RSHIFT:
    LDX BX 
@LOOP:
    BEQ @EXIT 
    LSR AX+1 
    ROR AX 
    DEX 
    BNE @LOOP 
@EXIT:
    RTS 

;------------------------
; shift left n bits 
;  AX=AX << BX 
;------------------------
LSHIFT:
    LDX BX 
@LOOP:
    BEQ @EXIT 
    ASL AX 
    ROL AX+1 
    DEX 
    BNE @LOOP 
@EXIT:
    RTS 


;------------------------
; bit and 
;  AX=AX AND BX 
;-------------------------
BIT_AND:
    LDA AX 
    AND BX 
    STA AX 
    LDA AX+1
    AND BX+1
    STA AX+1 
    RTS 

;-------------------------
; bit or 
; AX=AX OR BX 
;-------------------------
BIT_OR:
    LDA AX 
    ORA BX 
    STA AX 
    LDA AX+1
    ORA BX+1
    STA AX+1 
    RTS 

;--------------------------
; bit exclusive or 
; AX= AX XOR BX 
;--------------------------
BIT_XOR:
    LDA AX 
    EOR BX 
    STA AX 
    LDA AX+1
    EOR BX+1
    STA AX+1 
    RTS 


