// board configuration 

TERM=PC // STM8_TERMINAL 
BOARD=NUCLEO_G431

#if BOARD=NUCLEO_G431  
  .include "stm32g431.inc"
#else
#endif 

#if BOARD=NUCLEO_G431
  .equ LED_GPIO, GPIOB_BASE_ADR
  .equ LED_PIN, 8
#if TERM=PC 
  .equ UART,USART1_BASE_ADR
#else  
  .equ UART,USART1_BASE_ADR
#endif 
#endif 

  .include "ascii.inc"
  .include "tbi_macros.inc"
  .include "cmd_index.inc"
