

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

   ;set VIA shift register to shift out mode 
   ; bits field 4:2 set shift register mode 
   ; expect shift register in shift in mode 
   .MACRO _SWITCH_SR_OUT 
      LDA #(1<<4)
      TSB VIA_ACR 
   .ENDMACRO 

   ;set VIA shift register to shift in mode 
   ; expect mode is out 
   ;reset bit 6 of VIA_ACR 
   .MACRO _SWITCH_SR_IN 
      LDA #(1<<4)
      TRB VIA_ACR 
   .ENDMACRO 

   ; switch off VIA shift register 
   .MACRO _SWITCH_SR_OFF 
      LDA #SHIFT_MASK 
      TRB VIA_ACR 
   .ENDMACRO 

   ; set VIA shift register to input mode 
   .MACRO _SET_SR_IN   
      LDA #(SHIFT_IN_PHI2<<ACR_SR_MODE)
      TSB VIA_ACR 
   .ENDMACRO 

   ; set VIA shift register to output mode 
   .MACRO _SET_SR_OUT 
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

