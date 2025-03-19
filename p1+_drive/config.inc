;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;  configuration parameters 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;     MCU STM88S207K8T 

DEBUG=0 ; set to 1 to include debugging code 

; version 
    MAJOR=1 
    MINOR=0 
    REV=0
    
FMSTR=16 ; MHZ

    .include "inc/stm8s207.inc" 
    .include "inc/nucleo_8s207.inc"
	.include "inc/ascii.inc"
	.include "inc/gen_macros.inc" 
	.include "app_macros.inc" 

