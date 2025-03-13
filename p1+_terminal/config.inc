;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;  configuration parameters 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;   NOTE: 
;;      ON NUCLEO_8S207K8 
;;      JUMPERS  SB3,SB4 MUST BE MOVE ON SB7,SB9 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

DEBUG=0 ; set to 1 to include debugging code 

; version 
    MAJOR=1 
    MINOR=1 
    REV=0
    
HSE=1   
MAX_FREQ=1 ; 24MHZ maximum frequency, for 20Mhz crystal set to 0 
.if MAX_FREQ   
FMSTR=24 ; MHZ
.else
FMSTR=20 ; MHZ 
.endif 


    .include "inc/stm8s207.inc" 
    .include "inc/nucleo_8s207.inc"
	.include "inc/ascii.inc"
	.include "inc/gen_macros.inc" 
	.include "app_macros.inc" 

