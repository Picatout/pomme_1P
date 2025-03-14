;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Copyright Jacques Deschênes 2019,2020,2021 
;; This file is part of stm32_eforth  
;;
;;     stm8_eforth is free software: you can redistribute it and/or modify
;;     it under the terms of the GNU General Public License as published by
;;     the Free Software Foundation, either version 3 of the License, or
;;     (at your option) any later version.
;;
;;     stm32_eforth is distributed in the hope that it will be useful,
;;     but WITHOUT ANY WARRANTY;; without even the implied warranty of
;;     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;;     GNU General Public License for more details.
;;
;;     You should have received a copy of the GNU General Public License
;;     along with stm32_eforth.  If not, see <http:;;www.gnu.org/licenses/>.
;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; 2019/04/26
; STM8S105x4/6 µC registers map
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	.module stm8s105c6
	
;;;;;;;;;;
; bit mask
;;;;;;;;;;
 BIT0 = (0)
 BIT1 = (1)
 BIT2 = (2)
 BIT3 = (3)
 BIT4 = (4)
 BIT5 = (5)
 BIT6 = (6)
 BIT7 = (7)

; controller memory regions
RAM_SIZE = (1024) 
EEPROM_SIZE = (640) 
FLASH_SIZE = (8192)

 RAM_BASE = (0)
 RAM_END = (RAM_BASE+RAM_SIZE-1)
 EEPROM_BASE = (0x4000)
 EEPROM_END = (EEPROM_BASE+EEPROM_SIZE-1)
 SFR_BASE = (0x5000)
 SFR_END = (0x57FF)
 FLASH_BASE = (0x8000)
 OPTION_BASE = (0x4800)
 OPTION_END = (0x480A)
 DEVID_BASE = (0x4865)
 DEVID_END = (0x4870)
 BLOCK_SIZE = 64 ; flash|eeprom block size
GPIO_BASE = (0x4000)
GPIO_END = (0x57ff)

; options bytes
; this one can be programmed only from SWIM  (ICP)
 OPT0  = (0x4800)
; these can be programmed at runtime (IAP)
 OPT1  = (0x4801)
 NOPT1  = (0x4802)
 OPT2  = (0x4803)
 NOPT2  = (0x4804)
 OPT3  = (0x4805)
 NOPT3  = (0x4806)
 OPT4  = (0x4807)
 NOPT4  = (0x4808)
 OPT5  = (0x4809)
 NOPT5  = (0x480A)
; option registers usage
; read out protection, value 0xAA enable ROP
 ROP = OPT0  
; user boot code, {0..0x3e} 512 bytes row
 UBC = OPT1
 NUBC = NOPT1
; alternate function register
 AFR = OPT2
 NAFR = NOPT2
; miscelinous options
 MISCOPT = OPT3
 NMISCOPT = NOPT3
; clock options
 CLKOPT = OPT4
 NCLKOPT = NOPT4
; HSE clock startup delay
 HSECNT = OPT5
 NHSECNT = NOPT5

; MISCOPT bits
  MISCOPT_HSITRIM =  BIT4
  MISCOPT_LSIEN   =  BIT3
  MISCOPT_IWDG_HW =  BIT2
  MISCOPT_WWDG_HW =  BIT1
  MISCOPT_WWDG_HALT = BIT0
; NMISCOPT bits
  NMISCOPT_NHSITRIM  = ~BIT4
  NMISCOPT_NLSIEN    = ~BIT3
  NMISCOPT_NIWDG_HW  = ~BIT2
  NMISCOPT_NWWDG_HW  = ~BIT1
  NMISCOPT_NWWDG_HALT = ~BIT0
; CLKOPT bits
 CLKOPT_EXT_CLK  = BIT3
 CLKOPT_CKAWUSEL = BIT2
 CLKOPT_PRS_C1   = BIT1
 CLKOPT_PRS_C0   = BIT0

; AFR option, remapable functions
 AFR7 = BIT7 ;Port C3 = TIM1_CH1N; port C4 = TIM1_CH2N.
 AFR6 = BIT6 ;reserved  
 AFR5 = BIT5 ;reserved 
 AFR4 = BIT4 ;Port B4 = ADC1_ETR; port B5 =TIM1_BKIN
 AFR3 = BIT3 ;Port C3 = TLI
 AFR2 = BIT2 ;reserved
 AFR1 = BIT1 ;Port A3 = SPI_NSS; port D2 =TIM2_CH3
 AFR0 = BIT0 ;Port C5 = TIM2_CH1; port C6 =TIM1_CH1; port C7 = TIM1_CH2

; device ID = (read only)
 DEVID_XL  = (0x48CD)
 DEVID_XH  = (0x48CE)
 DEVID_YL  = (0x48CF)
 DEVID_YH  = (0x48D0)
 DEVID_WAF  = (0x48D1)
 DEVID_LOT0  = (0x48D2)
 DEVID_LOT1  = (0x48D3)
 DEVID_LOT2  = (0x48D4)
 DEVID_LOT3  = (0x48D5)
 DEVID_LOT4  = (0x48D6)
 DEVID_LOT5  = (0x48D7)
 DEVID_LOT6  = (0x48D8)


; port bit
 PIN0 = (0)
 PIN1 = (1)
 PIN2 = (2)
 PIN3 = (3)
 PIN4 = (4)
 PIN5 = (5)
 PIN6 = (6)
 PIN7 = (7)

; GPIO PORTS base addresses
PA = 0x5000
PB = 0x5005
PC = 0x500A
PD = 0x500F
PE = 0x5014
PF = 0x5019

; GPIO register offset 
GPIO_ODR = (0)
GPIO_IDR = (1)
GPIO_DDR = (2)
GPIO_CR1 = (3)
GPIO_CR2 = (4)

; GPIO
 PA_ODR  = (0x5000)
 PA_IDR  = (0x5001)
 PA_DDR  = (0x5002)
 PA_CR1  = (0x5003)
 PA_CR2  = (0x5004)

 PB_ODR  = (0x5005)
 PB_IDR  = (0x5006)
 PB_DDR  = (0x5007)
 PB_CR1  = (0x5008)
 PB_CR2  = (0x5009)

 PC_ODR  = (0x500A)
 PC_IDR  = (0x500B)
 PC_DDR  = (0x500C)
 PC_CR1  = (0x500D)
 PC_CR2  = (0x500E)

 PD_ODR  = (0x500F)
 PD_IDR  = (0x5010)
 PD_DDR  = (0x5011)
 PD_CR1  = (0x5012)
 PD_CR2  = (0x5013)

 PE_ODR  = (0x5014)
 PE_IDR  = (0x5015)
 PE_DDR  = (0x5016)
 PE_CR1  = (0x5017)
 PE_CR2  = (0x5018)

 PF_ODR  = (0x5019)
 PF_IDR  = (0x501A)
 PF_DDR  = (0x501B)
 PF_CR1  = (0x501C)
 PF_CR2  = (0x501D)

 ; input modes CR1
 INPUT_FLOAT = (0)
 INPUT_PULLUP = (1)
; output mode CR1
 OUTPUT_OD = (0)
 OUTPUT_PP = (1)
; input modes CR2
 INPUT_DI = (0)
 INPUT_EI = (1)
; output speed CR2
 OUTPUT_SLOW = (0)
 OUTPUT_FAST = (1)


; Flash
 FLASH_CR1  = (0x505A)
 FLASH_CR2  = (0x505B)
 FLASH_NCR2  = (0x505C)
 FLASH_FPR  = (0x505D)
 FLASH_NFPR  = (0x505E)
 FLASH_IAPSR  = (0x505F)
 FLASH_PUKR  = (0x5062)
 FLASH_DUKR  = (0x5064)
; data memory unlock keys
 FLASH_DUKR_KEY1 = (0xae)
 FLASH_DUKR_KEY2 = (0x56)
; flash memory unlock keys
 FLASH_PUKR_KEY1 = (0x56)
 FLASH_PUKR_KEY2 = (0xae)
; FLASH_CR1 bits
 FLASH_CR1_HALT = BIT3
 FLASH_CR1_AHALT = BIT2
 FLASH_CR1_IE = BIT1
 FLASH_CR1_FIX = BIT0
; FLASH_CR2 bits
 FLASH_CR2_OPT = BIT7
 FLASH_CR2_WPRG = BIT6
 FLASH_CR2_ERASE = BIT5
 FLASH_CR2_FPRG = BIT4
 FLASH_CR2_PRG = BIT0
; FLASH_FPR bits
 FLASH_FPR_WPB5 = BIT5
 FLASH_FPR_WPB4 = BIT4
 FLASH_FPR_WPB3 = BIT3
 FLASH_FPR_WPB2 = BIT2
 FLASH_FPR_WPB1 = BIT1
 FLASH_FPR_WPB0 = BIT0
; FLASH_NFPR bits
 FLASH_NFPR_NWPB5 = BIT5
 FLASH_NFPR_NWPB4 = BIT4
 FLASH_NFPR_NWPB3 = BIT3
 FLASH_NFPR_NWPB2 = BIT2
 FLASH_NFPR_NWPB1 = BIT1
 FLASH_NFPR_NWPB0 = BIT0
; FLASH_IAPSR bits
 FLASH_IAPSR_HVOFF = BIT6
 FLASH_IAPSR_DUL = BIT3
 FLASH_IAPSR_EOP = BIT2
 FLASH_IAPSR_PUL = BIT1
 FLASH_IAPSR_WR_PG_DIS = BIT0

; Interrupt control
 EXTI_CR1  = (0x50A0)
 EXTI_CR2  = (0x50A1)

; Reset Status
 RST_SR  = (0x50B3)

; Clock Registers
 CLK_ICKR  = (0x50c0)
 CLK_ECKR  = (0x50c1)
 CLK_CMSR  = (0x50C3)
 CLK_SWR  = (0x50C4)
 CLK_SWCR  = (0x50C5)
 CLK_CKDIVR  = (0x50C6)
 CLK_PCKENR1  = (0x50C7)
 CLK_CSSR  = (0x50C8)
 CLK_CCOR  = (0x50C9)
 CLK_PCKENR2  = (0x50CA)
 CLK_HSITRIMR  = (0x50CC)
 CLK_SWIMCCR  = (0x50CD)

; Peripherals clock gating
; CLK_PCKENR1 
 CLK_PCKENR1_TIM1 = (7)
 CLK_PCKENR1_TIM2 = (5)
 CLK_PCKENR1_TIM4 = (4)
 CLK_PCKENR1_UART1 = (3)
 CLK_PCKENR1_SPI = (1)
 CLK_PCKENR1_I2C = (0)
; CLK_PCKENR2
 CLK_PCKENR2_ADC1 = (3)
 CLK_PCKENR2_AWU = (2)

; Clock bits
 CLK_ICKR_REGAH = (5)
 CLK_ICKR_LSIRDY = (4)
 CLK_ICKR_LSIEN = (3)
 CLK_ICKR_FHW = (2)
 CLK_ICKR_HSIRDY = (1)
 CLK_ICKR_HSIEN = (0)

 CLK_ECKR_HSERDY = (1)
 CLK_ECKR_HSEEN = (0)
; clock source
 CLK_SWR_HSI = 0xE1
 CLK_SWR_LSI = 0xD2
 CLK_SWR_HSE = 0xB4

 CLK_SWCR_SWIF = (3)
 CLK_SWCR_SWIEN = (2)
 CLK_SWCR_SWEN = (1)
 CLK_SWCR_SWBSY = (0)

 CLK_CKDIVR_HSIDIV1 = (4)
 CLK_CKDIVR_HSIDIV0 = (3)
 CLK_CKDIVR_CPUDIV2 = (2)
 CLK_CKDIVR_CPUDIV1 = (1)
 CLK_CKDIVR_CPUDIV0 = (0)

; Watchdog
 WWDG_CR  = (0x50D1)
 WWDG_WR  = (0x50D2)
 IWDG_KR  = (0x50E0)
 IWDG_PR  = (0x50E1)
 IWDG_RLR  = (0x50E2)
 AWU_CSR1  = (0x50F0)
 AWU_APR  = (0x50F1)
 AWU_TBR  = (0x50F2)

; Beep
 BEEP_CSR  = (0x50F3)

; SPI
 SPI_CR1  = (0x5200)
 SPI_CR2  = (0x5201)
 SPI_ICR  = (0x5202)
 SPI_SR  = (0x5203)
 SPI_DR  = (0x5204)
 SPI_CRCPR  = (0x5205)
 SPI_RXCRCR  = (0x5206)
 SPI_TXCRCR  = (0x5207)

; I2C
 I2C_CR1  = (0x5210)
 I2C_CR2  = (0x5211)
 I2C_FREQR  = (0x5212)
 I2C_OARL  = (0x5213)
 I2C_OARH  = (0x5214)
 I2C_DR  = (0x5216)
 I2C_SR1  = (0x5217)
 I2C_SR2  = (0x5218)
 I2C_SR3  = (0x5219)
 I2C_ITR  = (0x521A)
 I2C_CCRL  = (0x521B)
 I2C_CCRH  = (0x521C)
 I2C_TRISER  = (0x521D)
 I2C_PECR  = (0x521E)

 I2C_STD = 0 
 I2C_FAST = 1 


 I2C_CR1_NOSTRETCH = (7)
 I2C_CR1_ENGC = (6)
 I2C_CR1_PE = (0)

 I2C_CR2_SWRST = (7)
 I2C_CR2_POS = (3)
 I2C_CR2_ACK = (2)
 I2C_CR2_STOP = (1)
 I2C_CR2_START = (0)

 I2C_OARL_ADD0 = (0)

 I2C_OAR_ADDR_7BIT = ((I2C_OARL & 0xFE) >> 1)
 I2C_OAR_ADDR_10BIT = (((I2C_OARH & 0x06) << 9) | (I2C_OARL & 0xFF))

 I2C_OARH_ADDMODE = (7)
 I2C_OARH_ADDCONF = (6)
 I2C_OARH_ADD9 = (2)
 I2C_OARH_ADD8 = (1)

 I2C_SR1_TXE = (7)
 I2C_SR1_RXNE = (6)
 I2C_SR1_STOPF = (4)
 I2C_SR1_ADD10 = (3)
 I2C_SR1_BTF = (2)
 I2C_SR1_ADDR = (1)
 I2C_SR1_SB = (0)

 I2C_SR2_WUFH = (5)
 I2C_SR2_OVR = (3)
 I2C_SR2_AF = (2)
 I2C_SR2_ARLO = (1)
 I2C_SR2_BERR = (0)

 I2C_SR3_DUALF = (7)
 I2C_SR3_GENCALL = (4)
 I2C_SR3_TRA = (2)
 I2C_SR3_BUSY = (1)
 I2C_SR3_MSL = (0)

 I2C_ITR_ITBUFEN = (2)
 I2C_ITR_ITEVTEN = (1)
 I2C_ITR_ITERREN = (0)

; Precalculated values, all in KHz
 I2C_CCRH_16MHZ_FAST_400 = 0x80
 I2C_CCRL_16MHZ_FAST_400 = 0x0D
;
; Fast I2C mode max rise time = 300ns
; I2C_FREQR = 16 = (MHz) => tMASTER = 1/16 = 62.5 ns
; TRISER = = (300/62.5) + 1 = floor(4.8) + 1 = 5.

 I2C_TRISER_16MHZ_FAST_400 = 0x05

 I2C_CCRH_16MHZ_FAST_320 = 0xC0
 I2C_CCRL_16MHZ_FAST_320 = 0x02
 I2C_TRISER_16MHZ_FAST_320 = 0x05

 I2C_CCRH_16MHZ_FAST_200 = 0x80
 I2C_CCRL_16MHZ_FAST_200 = 0x1A
 I2C_TRISER_16MHZ_FAST_200 = 0x05

 I2C_CCRH_16MHZ_STD_100 = 0x00
 I2C_CCRL_16MHZ_STD_100 = 0x50
;
; Standard I2C mode max rise time = 1000ns
; I2C_FREQR = 16 = (MHz) => tMASTER = 1/16 = 62.5 ns
; TRISER = = (1000/62.5) + 1 = floor(16) + 1 = 17.

 I2C_TRISER_16MHZ_STD_100 = 0x11

 I2C_CCRH_16MHZ_STD_50 = 0x00
 I2C_CCRL_16MHZ_STD_50 = 0xA0
 I2C_TRISER_16MHZ_STD_50 = 0x11

 I2C_CCRH_16MHZ_STD_20 = 0x01
 I2C_CCRL_16MHZ_STD_20 = 0x90
 I2C_TRISER_16MHZ_STD_20 = 0x11;

 I2C_READ = 1
 I2C_WRITE = 0

; baudrate constant for brr_value table access
B2400=0
B4800=1
B9600=2
B19200=3
B38400=4
B57600=5
B115200=6
B230400=7
B460800=8
B921600=9

; UART1
 UART1_SR    = (0x5230)
 UART1_DR    = (0x5231)
 UART1_BRR1  = (0x5232)
 UART1_BRR2  = (0x5233)
 UART1_CR1   = (0x5234)
 UART1_CR2   = (0x5235)
 UART1_CR3   = (0x5236)
 UART1_CR4   = (0x5237)
 UART1_CR5   = (0x5238)
 UART1_GTR   = (0x5239)
 UART1_PSCR  = (0x523A)

 UART1_TX_PIN = 2 ; PD5
 UART1_RX_PIN = 3 ; PD6 
 UART1_PORT = GPIO_BASE+PD 

; UART Status Register bits
 UART_SR_TXE = (7)
 UART_SR_TC = (6)
 UART_SR_RXNE = (5)
 UART_SR_IDLE = (4)
 UART_SR_OR = (3)
 UART_SR_NF = (2)
 UART_SR_FE = (1)
 UART_SR_PE = (0)

; Uart Control Register bits
 UART_CR1_R8 = (7)
 UART_CR1_T8 = (6)
 UART_CR1_UARTD = (5)
 UART_CR1_M = (4)
 UART_CR1_WAKE = (3)
 UART_CR1_PCEN = (2)
 UART_CR1_PS = (1)
 UART_CR1_PIEN = (0)

 UART_CR2_TIEN = (7)
 UART_CR2_TCIEN = (6)
 UART_CR2_RIEN = (5)
 UART_CR2_ILIEN = (4)
 UART_CR2_TEN = (3)
 UART_CR2_REN = (2)
 UART_CR2_RWU = (1)
 UART_CR2_SBK = (0)

 UART_CR3_LINEN = (6)
 UART_CR3_STOP1 = (5)
 UART_CR3_STOP0 = (4)
 UART_CR3_CLKEN = (3)
 UART_CR3_CPOL = (2)
 UART_CR3_CPHA = (1)
 UART_CR3_LBCL = (0)

 UART_CR4_LBDIEN = (6)
 UART_CR4_LBDL = (5)
 UART_CR4_LBDF = (4)
 UART_CR4_ADD3 = (3)
 UART_CR4_ADD2 = (2)
 UART_CR4_ADD1 = (1)
 UART_CR4_ADD0 = (0)

 UART_CR5_SCEN = (5)
 UART_CR5_NACK = (4)
 UART_CR5_HDSEL = (3)
 UART_CR5_IRLP = (2)
 UART_CR5_IREN = (1)

; TIMERS
; Timer 1 - 16-bit timer with complementary PWM outputs
 TIM1_CR1  = (0x5250)
 TIM1_CR2  = (0x5251)
 TIM1_SMCR  = (0x5252)
 TIM1_ETR  = (0x5253)
 TIM1_IER  = (0x5254)
 TIM1_SR1  = (0x5255)
 TIM1_SR2  = (0x5256)
 TIM1_EGR  = (0x5257)
 TIM1_CCMR1  = (0x5258)
 TIM1_CCMR2  = (0x5259)
 TIM1_CCMR3  = (0x525A)
 TIM1_CCMR4  = (0x525B)
 TIM1_CCER1  = (0x525C)
 TIM1_CCER2  = (0x525D)
 TIM1_CNTRH  = (0x525E)
 TIM1_CNTRL  = (0x525F)
 TIM1_PSCRH  = (0x5260)
 TIM1_PSCRL  = (0x5261)
 TIM1_ARRH  = (0x5262)
 TIM1_ARRL  = (0x5263)
 TIM1_RCR  = (0x5264)
 TIM1_CCR1H  = (0x5265)
 TIM1_CCR1L  = (0x5266)
 TIM1_CCR2H  = (0x5267)
 TIM1_CCR2L  = (0x5268)
 TIM1_CCR3H  = (0x5269)
 TIM1_CCR3L  = (0x526A)
 TIM1_CCR4H  = (0x526B)
 TIM1_CCR4L  = (0x526C)
 TIM1_BKR  = (0x526D)
 TIM1_DTR  = (0x526E)
 TIM1_OISR  = (0x526F)

; Timer Control Register bits
 TIM_CR1_ARPE = (7)
 TIM_CR1_CMSH = (6)
 TIM_CR1_CMSL = (5)
 TIM_CR1_DIR = (4)
 TIM_CR1_OPM = (3)
 TIM_CR1_URS = (2)
 TIM_CR1_UDIS = (1)
 TIM_CR1_CEN = (0)

 TIM1_CR2_MMS2 = (6)
 TIM1_CR2_MMS1 = (5)
 TIM1_CR2_MMS0 = (4)
 TIM1_CR2_COMS = (2)
 TIM1_CR2_CCPC = (0)

; Timer Slave Mode Control bits
 TIM1_SMCR_MSM = (7)
 TIM1_SMCR_TS2 = (6)
 TIM1_SMCR_TS1 = (5)
 TIM1_SMCR_TS0 = (4)
 TIM1_SMCR_SMS2 = (2)
 TIM1_SMCR_SMS1 = (1)
 TIM1_SMCR_SMS0 = (0)

; Timer External Trigger Enable bits
 TIM1_ETR_ETP = (7)
 TIM1_ETR_ECE = (6)
 TIM1_ETR_ETPS1 = (5)
 TIM1_ETR_ETPS0 = (4)
 TIM1_ETR_ETF3 = (3)
 TIM1_ETR_ETF2 = (2)
 TIM1_ETR_ETF1 = (1)
 TIM1_ETR_ETF0 = (0)

; Timer Interrupt Enable bits
 TIM1_IER_BIE = (7)
 TIM1_IER_TIE = (6)
 TIM1_IER_COMIE = (5)
 TIM1_IER_CC4IE = (4)
 TIM1_IER_CC3IE = (3)
 TIM1_IER_CC2IE = (2)
 TIM1_IER_CC1IE = (1)
 TIM1_IER_UIE = (0)

; Timer Status Register bits
 TIM1_SR1_BIF = (7)
 TIM1_SR1_TIF = (6)
 TIM1_SR1_COMIF = (5)
 TIM1_SR1_CC4IF = (4)
 TIM1_SR1_CC3IF = (3)
 TIM1_SR1_CC2IF = (2)
 TIM1_SR1_CC1IF = (1)
 TIM1_SR1_UIF = (0)

 TIM1_SR2_CC4OF = (4)
 TIM1_SR2_CC3OF = (3)
 TIM1_SR2_CC2OF = (2)
 TIM1_SR2_CC1OF = (1)

; Timer Event Generation Register bits
 TIM_EGR_BG = (7)
 TIM_EGR_TG = (6)
 TIM_EGR_COMG = (5)
 TIM_EGR_CC4G = (4)
 TIM_EGR_CC3G = (3)
 TIM_EGR_CC2G = (2)
 TIM_EGR_CC1G = (1)
 TIM_EGR_UG = (0)

; timer capture compare enable register 
; bit fields 
TIM_CCER1_CC1E=0 
TIM_CCER1_CC1P=1 
TIM_CCER1_CC1NE=2
TIM_CCER1_CC2NP=3
TIM_CCER1_CC2E=4 
TIM_CCER1_CC2P=5
TIM_CCER1_CC2NE=6
TIM_CCER1_CC2NP=7
TIM_CCER2_CC3E=0 
TIM_CCER2_CC3P=1 
TIM_CCER2_CC2NE=2
TIM_CCER2_CC2NP=3
TIM_CCER2_CC4E=4
TIM_CCER2_CC4P=5 


; Capture/Compare Mode Register 1 - channel configured in output
 TIM1_CCMR1_OC1CE = (7)
 TIM1_CCMR1_OC1M2 = (6)
 TIM1_CCMR1_OC1M1 = (5)
 TIM1_CCMR1_OC1M0 = (4)
 TIM1_CCMR1_OC1PE = (3)
 TIM1_CCMR1_OC1FE = (2)
 TIM1_CCMR1_CC1S1 = (1)
 TIM1_CCMR1_CC1S0 = (0)

; Capture/Compare Mode Register 1 - channel configured in input
 TIM1_CCMR1_IC1F3 = (7)
 TIM1_CCMR1_IC1F2 = (6)
 TIM1_CCMR1_IC1F1 = (5)
 TIM1_CCMR1_IC1F0 = (4)
 TIM1_CCMR1_IC1PSC1 = (3)
 TIM1_CCMR1_IC1PSC0 = (2)
;  TIM1_CCMR1_CC1S1 = (1)
 TIM1_CCMR1_CC1S0 = (0)

; Capture/Compare Mode Register 2 - channel configured in output
 TIM1_CCMR2_OC2CE = (7)
 TIM1_CCMR2_OC2M2 = (6)
 TIM1_CCMR2_OC2M1 = (5)
 TIM1_CCMR2_OC2M0 = (4)
 TIM1_CCMR2_OC2PE = (3)
 TIM1_CCMR2_OC2FE = (2)
 TIM1_CCMR2_CC2S1 = (1)
 TIM1_CCMR2_CC2S0 = (0)

; Capture/Compare Mode Register 2 - channel configured in input
 TIM1_CCMR2_IC2F3 = (7)
 TIM1_CCMR2_IC2F2 = (6)
 TIM1_CCMR2_IC2F1 = (5)
 TIM1_CCMR2_IC2F0 = (4)
 TIM1_CCMR2_IC2PSC1 = (3)
 TIM1_CCMR2_IC2PSC0 = (2)
;  TIM1_CCMR2_CC2S1 = (1)
 TIM1_CCMR2_CC2S0 = (0)

; Capture/Compare Mode Register 3 - channel configured in output
 TIM1_CCMR3_OC3CE = (7)
 TIM1_CCMR3_OC3M2 = (6)
 TIM1_CCMR3_OC3M1 = (5)
 TIM1_CCMR3_OC3M0 = (4)
 TIM1_CCMR3_OC3PE = (3)
 TIM1_CCMR3_OC3FE = (2)
 TIM1_CCMR3_CC3S1 = (1)
 TIM1_CCMR3_CC3S0 = (0)

; Capture/Compare Mode Register 3 - channel configured in input
 TIM1_CCMR3_IC3F3 = (7)
 TIM1_CCMR3_IC3F2 = (6)
 TIM1_CCMR3_IC3F1 = (5)
 TIM1_CCMR3_IC3F0 = (4)
 TIM1_CCMR3_IC3PSC1 = (3)
 TIM1_CCMR3_IC3PSC0 = (2)
;  TIM1_CCMR3_CC3S1 = (1)
 TIM1_CCMR3_CC3S0 = (0)

; Capture/Compare Mode Register 4 - channel configured in output
 TIM1_CCMR4_OC4CE = (7)
 TIM1_CCMR4_OC4M2 = (6)
 TIM1_CCMR4_OC4M1 = (5)
 TIM1_CCMR4_OC4M0 = (4)
 TIM1_CCMR4_OC4PE = (3)
 TIM1_CCMR4_OC4FE = (2)
 TIM1_CCMR4_CC4S1 = (1)
 TIM1_CCMR4_CC4S0 = (0)

; Capture/Compare Mode Register 4 - channel configured in input
 TIM1_CCMR4_IC4F3 = (7)
 TIM1_CCMR4_IC4F2 = (6)
 TIM1_CCMR4_IC4F1 = (5)
 TIM1_CCMR4_IC4F0 = (4)
 TIM1_CCMR4_IC4PSC1 = (3)
 TIM1_CCMR4_IC4PSC0 = (2)
;  TIM1_CCMR4_CC4S1 = (1)
 TIM1_CCMR4_CC4S0 = (0)

; timer 1 break register bits 
TIM1_BKR_LOCK=0 ;(0:1) lock configuration
TIM1_BKR_OSSI=2 ; Off state selection for idle mode
TIM1_BKR_OSSR=3 ; Off state selection for Run mode
TIM1_BKR_BKE=4  ; Break enable
TIM1_BKR_BKP=5  ; Break polarity
TIM1_BKR_AOE=6  ; Automatic output enable
TIM1_BKR_MOE=7  ; Main output enable

; timer 1 output idle state register bits 
TIM1_OISR_OS1=0 
TIM1_OISR_OSN1=1 
TIM1_OISR_OS2=2 
TIM1_OISR_OSN2=3 
TIM1_OISR_OS3=4 
TIM1_OISR_OSN3=5
TIM1_OISR_OS4=6 
TIM1_OISR_OSN4=7

; Timer 2 - 16-bit timer
 TIM2_CR1  = (0x5300)
 TIM2_IER  = (0x5303)
 TIM2_SR1  = (0x5304)
 TIM2_SR2  = (0x5305)
 TIM2_EGR  = (0x5306)
 TIM2_CCMR1  = (0x5307)
 TIM2_CCMR2  = (0x5308)
 TIM2_CCMR3  = (0x5309)
 TIM2_CCER1  = (0x530A)
 TIM2_CCER2  = (0x530B)
 TIM2_CNTRH  = (0x530C)
 TIM2_CNTRL  = (0x530C)
 TIM2_PSCR  = (0x530E)
 TIM2_ARRH  = (0x530F)
 TIM2_ARRL  = (0x5319)
 TIM2_CCR1H  = (0x5311)
 TIM2_CCR1L  = (0x5312)
 TIM2_CCR2H  = (0x5313)
 TIM2_CCR2L  = (0x5314)
 TIM2_CCR3H  = (0x5315)
 TIM2_CCR3L  = (0x5316)

; Timer 4
 TIM4_CR1  = (0x5340)
 TIM4_IER  = (0x5343)
 TIM4_SR  = (0x5344)
 TIM4_EGR  = (0x5345)
 TIM4_CNTR  = (0x5346)
 TIM4_PSCR  = (0x5347)
 TIM4_ARR  = (0x5348)

; Timer 4 bitmasks

 TIM4_CR1_ARPE = (7)
 TIM4_CR1_OPM = (3)
 TIM4_CR1_URS = (2)
 TIM4_CR1_UDIS = (1)
 TIM4_CR1_CEN = (0)

 TIM4_IER_UIE = (0)

 TIM4_SR_UIF = (0)

 TIM4_EGR_UG = (0)

 TIM4_PSCR_PSC2 = (2)
 TIM4_PSCR_PSC1 = (1)
 TIM4_PSCR_PSC0 = (0)

 TIM4_PSCR_1 = 0
 TIM4_PSCR_2 = 1
 TIM4_PSCR_4 = 2
 TIM4_PSCR_8 = 3
 TIM4_PSCR_16 = 4
 TIM4_PSCR_32 = 5
 TIM4_PSCR_64 = 6
 TIM4_PSCR_128 = 7

; TIMx_CCMRx bit fields 
TIMx_CCRM1_OC1M=4
TIMx_CCRM1_OC1PE=3 
TIMx_CCRM1_CC1S=0 

; ADC1 individual element access
 ADC1_DB0RH  = (0x53E0)
 ADC1_DB0RL  = (0x53E1)
 ADC1_DB1RH  = (0x53E2)
 ADC1_DB1RL  = (0x53E3)
 ADC1_DB2RH  = (0x53E4)
 ADC1_DB2RL  = (0x53E5)
 ADC1_DB3RH  = (0x53E6)
 ADC1_DB3RL  = (0x53E7)
 ADC1_DB4RH  = (0x53E8)
 ADC1_DB4RL  = (0x53E9)
 ADC1_DB5RH  = (0x53EA)
 ADC1_DB5RL  = (0x53EB)
 ADC1_DB6RH  = (0x53EC)
 ADC1_DB6RL  = (0x53ED)
 ADC1_DB7RH  = (0x53EE)
 ADC1_DB7RL  = (0x53EF)
 ADC1_DB8RH  = (0x53F0)
 ADC1_DB8RL  = (0x53F1)
 ADC1_DB9RH  = (0x53F2)
 ADC1_DB9RL  = (0x53F3)

 ADC1_CSR  = (0x5400)
 ADC1_CR1  = (0x5401)
 ADC1_CR2  = (0x5402)
 ADC1_CR3  = (0x5403)
 ADC1_DRH  = (0x5404)
 ADC1_DRL  = (0x5405)
 ADC1_TDRH  = (0x5406)
 ADC1_TDRL  = (0x5407)
 ADC1_HTRH  = (0x5408)
 ADC1_HTRL  = (0x5409)
 ADC1_LTRH  = (0x540A)
 ADC1_LTRL  = (0x540B)
 ADC1_AWSRH  = (0x540C)
 ADC1_AWSRL  = (0x540D)
 ADC1_AWCRH  = (0x540E)
 ADC1_AWCRL  = (0x540F)

; ADC1 bitmasks

 ADC1_CSR_EOC = (7)
 ADC1_CSR_AWD = (6)
 ADC1_CSR_EOCIE = (5)
 ADC1_CSR_AWDIE = (4)
 ADC1_CSR_CH3 = (3)
 ADC1_CSR_CH2 = (2)
 ADC1_CSR_CH1 = (1)
 ADC1_CSR_CH0 = (0)

 ADC1_CR1_SPSEL2 = (6)
 ADC1_CR1_SPSEL1 = (5)
 ADC1_CR1_SPSEL0 = (4)
 ADC1_CR1_CONT = (1)
 ADC1_CR1_ADON = (0)

 ADC1_CR2_EXTTRIG = (6)
 ADC1_CR2_EXTSEL1 = (5)
 ADC1_CR2_EXTSEL0 = (4)
 ADC1_CR2_ALIGN = (3)
 ADC1_CR2_SCAN = (1)

 ADC1_CR3_DBUF = (7)
 ADC1_CR3_DRH = (6)

; CPU
 CPU_A  = (0x7F00)
 CPU_PCE  = (0x7F01)
 CPU_PCH  = (0x7F02)
 CPU_PCL  = (0x7F03)
 CPU_XH  = (0x7F04)
 CPU_XL  = (0x7F05)
 CPU_YH  = (0x7F06)
 CPU_YL  = (0x7F07)
 CPU_SPH  = (0x7F08)
 CPU_SPL   = (0x7F09)
 CPU_CCR   = (0x7F0A)

; global configuration register
 CFG_GCR   = (0x7F60)

; interrupt control registers
 ITC_SPR1   = (0x7F70)
 ITC_SPR2   = (0x7F71)
 ITC_SPR3   = (0x7F72)
 ITC_SPR4   = (0x7F73)
 ITC_SPR5   = (0x7F74)
 ITC_SPR6   = (0x7F75)
 ITC_SPR7   = (0x7F76)
 ITC_SPR8   = (0x7F77)

ITC_SPR_LEVEL1=1 
ITC_SPR_LEVEL2=0
ITC_SPR_LEVEL3=3 

; interrupt priority
 IPR0 = 2
 IPR1 = 1
 IPR2 = 0
 IPR3 = 3 
 IPR_MASK = 3

; SWIM, control and status register
 SWIM_CSR   = (0x7F80)
; debug registers
 DM_BK1RE   = (0x7F90)
 DM_BK1RH   = (0x7F91)
 DM_BK1RL   = (0x7F92)
 DM_BK2RE   = (0x7F93)
 DM_BK2RH   = (0x7F94)
 DM_BK2RL   = (0x7F95)
 DM_CR1   = (0x7F96)
 DM_CR2   = (0x7F97)
 DM_CSR1   = (0x7F98)
 DM_CSR2   = (0x7F99)
 DM_ENFCTR   = (0x7F9A)

; Interrupt Numbers
 INT_TLI = 0
 INT_AWU = 1
 INT_CLK = 2
 INT_EXTI0 = 3
 INT_EXTI1 = 4
 INT_EXTI2 = 5
 INT_EXTI3 = 6
 INT_EXTI4 = 7
 INT_RES1 = 8
 INT_RES2 = 9
 INT_SPI = 10
 INT_TIM1_OVF = 11
 INT_TIM1_CCM = 12
 INT_TIM2_OVF = 13
 INT_TIM2_CCM = 14
 INT_RES3 = 15
 INT_RES4 = 16
 INT_UART1_TXC = 17
 INT_UART1_RX_FULL = 18
 INT_I2C = 19
 INT_RES5 = 20
 INT_RES6 = 21
 INT_ADC1 = 22
 INT_TIM4_OVF = 23
 INT_FLASH = 24

; Interrupt Vectors
 INT_VECTOR_RESET = 0x8000
 INT_VECTOR_TRAP = 0x8004
 INT_VECTOR_TLI = 0x8008
 INT_VECTOR_AWU = 0x800C
 INT_VECTOR_CLK = 0x8010
 INT_VECTOR_EXTI0 = 0x8014
 INT_VECTOR_EXTI1 = 0x8018
 INT_VECTOR_EXTI2 = 0x801C
 INT_VECTOR_EXTI3 = 0x8020
 INT_VECTOR_EXTI4 = 0x8024
 INT_VECTOR_SPI = 0x8030
 INT_VECTOR_TIM1_OVF = 0x8034
 INT_VECTOR_TIM1_CCM = 0x8038
 INT_VECTOR_TIM2_OVF = 0x803C
 INT_VECTOR_TIM2_CCM = 0x8040
 INT_VECTOR_UART1_TX_COMPLETE = 0x804c
 INT_VECTOR_UART1_RX_FULL = 0x8050
 INT_VECTOR_I2C = 0x8054
 INT_VECTOR_ADC1 = 0x8060
 INT_VECTOR_TIM4_OVF = 0x8064
 INT_VECTOR_FLASH = 0x8068

 
