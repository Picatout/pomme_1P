; decrement 16 bits variable  
; set ZERO flag 
   .MACRO _DECW V16  
      SEC     
      LDA V16
      SBC #1
      STA V16  
      LDA V16+1
      SBC #0
      STA V16+1
      ORA V16 ; to set Z flag if V16==0
   .ENDMACRO 

; increment 16 bits variable
; set ZERO flag  
   .MACRO _INCW V16 
      CLC 
      LDA V16 
      ADC #1
      STA V16 
      LDA V16+1 
      ADC #0 
      STA V16+1 
      ORA V16 ; to set Z flag if V16==0
   .ENDMACRO 

; move 16 bits variable to another variable
   .MACRO _MOVW V1, V2 
   LDA V2 
   STA V1 
   LDA V2+1 
   STA V1+1
   .ENDMACRO 

; negate 16 bits two's complement variable 
   .MACRO _NEG_VAR V 
   .SCOPE 
   LDA V 
   EOR #$FF 
   STA V 
   LDA V+1 
   EOR #$FF 
   STA V+1 
   INC V 
   BNE SKIP 
   INC V+1 
SKIP:
   .ENDSCOPE 
   .ENDMACRO
   
