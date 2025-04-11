;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;  configuration parameters 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;     MCU STM88S207K8T 

; version 
    MAJOR=1 
    MINOR=0 
    REV=0
    
FMSTR=16 ; MHZ

; flags 
FTX=0 ; set to 1 when transmitting data to computer, otherwise reset  
FCOMP_RDY=1 ; set this bit when computer is ready to receive, otherwise reset 



S207=1
.if S207
    L151=0 
    .include "inc/stm8s207.inc" 
;UART=UART3 

; interface port 
; communication with computer PIA W65C22 PORT A 
; using 8 bits bus. 
ITF_PORT=PD_BASE ; data transfert bus 
ITF_DDR=PD_DDR 
ITF_ODR=PD_ODR 
ITF_IDR=PD_IDR 
ITF_CR1=PD_CR1 
ITF_CR2=PD_CR2 
; handshake 
ITF_CTRL_PORT=PB_BASE 
ITF_CTRL_ODR=PB_ODR 
ITF_CTRL_IDR=PB_IDR 
ITF_CTRL_DDR=PB_DDR 
ITF_CTRL_CR1=PB_CR1 
ITF_CTRL_CR2=PB_CR2
; handshake control lines 
ITF_CA1=BIT1 ; drive ready signal on PB1 
ITF_CA2=BIT0 ; computer ready signal on PB0 
EXTI_CR=EXTI_CR1 ; external interrupt control register 
ITF_CA2_PBIS=BIT2 ; EXTI_CR1 ext. int. control bits 2:3

; clock enable bit 
UART_PCKEN=CLK_PCKENR1_UART3 

; uart registers 
UART_SR=UART3_SR
UART_DR=UART3_DR
UART_BRR1=UART3_BRR1
UART_BRR2=UART3_BRR2
UART_CR1=UART3_CR1
UART_CR2=UART3_CR2

; TX, RX pin
UART_TX_PIN=UART3_TX_PIN 
UART_RX_PIN=UART3_RX_PIN 
;-------------------------
;  SPI interface 
;-------------------------
; SPI port 
SPI_PORT= PC_BASE
SPI_PORT_ODR=PC_ODR 
SPI_PORT_IDR=PC_IDR 
SPI_PORT_DDR=PC_DDR 
SPI_PORT_CR1=PC_CR1 
SPI_PORT_CR2=PC_CR2 
; spi pins bits 
SPI_MISO= 7;PC7 
SPI_MOSI= 6;PC6
SPI_CLK=  5;PC5 
; SPI channel select pins 
SPI_CS0=3   ; PC3 FLASH0  
SPI_CS1=4   ; PC4 FLASH1  
FLASH0=SPI_CS0 ; fixed internal
FLASH1=SPI_CS1 ; removable external 

.else 
    L151=1 
    .include "inc/stm8l151.inc" 

; clock enable bit 
UART_PCKEN=CLK_PCKENR1_USART1 

; uart registers 
UART_SR=USART1_SR
UART_DR=USART1_DR
UART_BRR1=USART1_BRR1
UART_BRR2=USART1_BRR2
UART_CR1=USART1_CR1
UART_CR2=USART1_CR2

; TX, RX pin
UART_TX_PIN=UART1_TX_PIN 
UART_RX_PIN=UART1_RX_PIN 
;-------------------------
;  SPI interface 
;-------------------------
; SPI port 
SPI_PORT_PORT= PORT_C 
SPI_PORT_ODR=PC_ODR 
SPI_PORT_IDR=PC_IDR 
SPI_PORT_DDR=PC_DDR 
SPI_PORT_CR1=PC_CR1 
SPI_PORT_CR2=PC_CR2 
; spi pins bits 
SPI_MISO= 7;PC7 
SPI_MOSI= 6;PC6
SPI_CLK=  5;PC5 
; SPI channel select pins 
SPI_CS0=0   ; PC3 FLASH0  
SPI_CS1=1   ; PC4 FLASH1  
FLASH0=SPI_CS0 ; fixed internal
FLASH1=SPI_CS1 ; removable external 

.endif 




	.include "inc/ascii.inc"
	.include "inc/gen_macros.inc" 
	.include "app_macros.inc" 

