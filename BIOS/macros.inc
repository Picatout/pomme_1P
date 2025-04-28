

    .MACRO _PUTS  label 
    LDA #>label  
    LDX #<label 
    JSR PUTS 
    .ENDMACRO 

    .MACRO _PAUSE msec 
    LDA #>msec 
    LDX #<msec 
    JSR PAUSE 
    .ENDMACRO 
