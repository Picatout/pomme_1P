

   ; print string macro 
    .MACRO _PUTS  label 
      LDA #>label  
      LDX #<label 
      JSR PUTS 
    .ENDMACRO 

   ; suspend execution 
   ; for msec 
    .MACRO _PAUSE msec 
      LDA #>msec 
      LDX #<msec 
      JSR PAUSE 
    .ENDMACRO 

    ; W25Q080 chip select 
    ; enable flash memory 
    .MACRO _FLASH_SEL 
      LDA #FLASH_CS 
      TRB VIA_IORB 
    .ENDMACRO 

    ; disable W25Q080 flash memory 
    .MACRO _FLASH_DESEL 
      LDA #FLASH_CS 
      TSB VIA_IORB 
    .ENDMACRO 

   ; switch off VIA shift register 
   .MACRO _SWITCH_SR_OFF 
      LDA #SHIFT_MASK 
      TRB VIA_ACR 
   .ENDMACRO 

   ; set VIA shift register to input mode 
   .MACRO _SET_SR_IN   
      LDA #SHIFT_MASK 
      TRB VIA_ACR 
      LDA #(SHIFT_IN_PHI2<<ACR_SR_MODE)
      TSB VIA_ACR 
   .ENDMACRO 

   ; set VIA shift register to output mode 
   .MACRO _SET_SR_OUT 
      LDA #SHIFT_MASK 
      TRB VIA_ACR 
      LDA #(SHIFT_OUT_PHI2<<ACR_SR_MODE)
      TSB VIA_ACR 
   .ENDMACRO 

   ; decrement 16 bits variable  
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

; enable tone output on VIA 
   .MACRO _TONE_ON  
 ;setting timer 1 as square wave generator  
   LDA #(T1_PB7_SQRWAV<<ACR_T1_MODE)
   STA VIA_ACR
.IF 0
   LDA #F_SOUND 
   TSB FLAGS 
.ELSE 
   _SETF F_SOUND 
.ENDIF 
   .ENDMACRO 

; disable tone output on VIA 
   .MACRO _TONE_OFF  
 ;using timer 1 as generator  
.IF 0
   LDA #(T1_PB7_SQRWAV<<ACR_T1_MODE)
   TRB VIA_ACR
   LDA #F_SOUND 
   TRB FLAGS
.ELSE 
    STZ VIA_ACR 
.ENDIF 
    _RSTF F_SOUND 
   .ENDMACRO 

; move 16 bits variable to another variable
   .MACRO _MOVW V1, V2 
   LDA V2 
   STA V1 
   LDA V2+1 
   STA V1+1
   .ENDMACRO 


; set flag in 'flags' variable 
   .MACRO _SETF flag 
   .byte $80+flag<<4+7, FLAGS 
   .ENDMACRO  

; reset flag in 'flags' variable 
   .MACRO _RSTF flag  
   .byte flag<<4+7, FLAGS 
   .ENDMACRO 
   
; branch if flag bit set 
   .MACRO _BFR flag, target  
   .byte flag<<4+$F, FLAGS,target-(*+1) 
   .ENDMACRO 

;branch if flag bit set 
   .MACRO _BFS flag, target 
   .byte $80+flag<<4+$F, FLAGS, target-(*+1) 
   .ENDMACRO 

