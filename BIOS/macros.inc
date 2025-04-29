

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

    ; enable W25Q080 flash memory 
    .MACRO _FLASH_SEL 
    LDA #FLASH_CS 
    TRB VIA_IORB 
    .ENDMACRO 

    ; disable W25Q080 flash memory 
    .MACRO _FLASH_DESEL 
    LDA #FLASH_CS 
    TSB VIA_IORB 
    .ENDMACRO 

