;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;  configuration parameters 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;     MCU STM88S207K8T 

; version 
    MAJOR=1 
    MINOR=0 
    REV=0
    
FMSTR=16 ; MHZ

;UART=UART3 
; port used by  UART3 
UART_PORT_ODR=PD_ODR 
UART_PORT_DDR=PD_DDR 
UART_PORT_IDR=PD_IDR 
UART_PORT_CR1=PD_CR1 
UART_PORT_CR2=PD_CR2 

; clock enable bit 
UART_PCKEN=CLK_PCKENR1_UART3 

; uart3 registers 
UART_SR=UART3_SR
UART_DR=UART3_DR
UART_BRR1=UART3_BRR1
UART_BRR2=UART3_BRR2
UART_CR1=UART3_CR1
UART_CR2=UART3_CR2

; TX, RX pin
UART_TX_PIN=UART3_TX_PIN 
UART_RX_PIN=UART3_RX_PIN 


    .include "inc/stm8s207.inc" 
	.include "inc/ascii.inc"
	.include "inc/gen_macros.inc" 
	.include "app_macros.inc" 

