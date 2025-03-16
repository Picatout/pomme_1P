ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 1.
Hexadecimal [24-Bits]



                                      1 ;;
                                      2 ; Copyright Jacques Deschênes 2023  
                                      3 ; This file is part of stm8_terminal 
                                      4 ;
                                      5 ;     stm8_terminal is free software: you can redistribute it and/or modify
                                      6 ;     it under the terms of the GNU General Public License as published by
                                      7 ;     the Free Software Foundation, either version 3 of the License, or
                                      8 ;     (at your option) any later version.
                                      9 ;
                                     10 ;     stm8_terminal is distributed in the hope that it will be useful,
                                     11 ;     but WITHOUT ANY WARRANTY; without even the implied warranty of
                                     12 ;     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
                                     13 ;     GNU General Public License for more details.
                                     14 ;
                                     15 ;     You should have received a copy of the GNU General Public License
                                     16 ;     along with stm8_terminal.  If not, see <http://www.gnu.org/licenses/>.
                                     17 ;;
                                     18 
                                     19 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                                     20 ;;; hardware initialization
                                     21 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 
                                     22 
                                     23 ;------------------------
                                     24 ; if unified compilation 
                                     25 ; must be first in list 
                                     26 ;-----------------------
                                     27 
                                     28     .module HW_INIT 
                                     29 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 2.
Hexadecimal [24-Bits]



                                     30     .include "config.inc"
                                      1 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                                      2 ;;  configuration parameters 
                                      3 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                                      4 
                                      5 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                                      6 ;;   NOTE: 
                                      7 ;;      ON NUCLEO_8S207K8 
                                      8 ;;      JUMPERS  SB3,SB4 MUST BE MOVED TO SB7,SB9 
                                      9 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                                     10 
                           000000    11 DEBUG=0 ; set to 1 to include debugging code 
                                     12 
                                     13 ; version 
                           000001    14     MAJOR=1 
                           000001    15     MINOR=1 
                           000000    16     REV=0
                                     17     
                           000001    18 HSE=1   
                           000001    19 MAX_FREQ=1 ; 24MHZ maximum frequency, for 20Mhz crystal set to 0 
                           000001    20 .if MAX_FREQ   
                           000018    21 FMSTR=24 ; MHZ
                           000000    22 .else
                                     23 FMSTR=20 ; MHZ 
                                     24 .endif 
                                     25 
                                     26 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 3.
Hexadecimal [24-Bits]



                                     27     .include "inc/stm8s207.inc" 
                                      1 ;;
                                      2 ; Copyright Jacques Deschênes 2019,2022 
                                      3 ; This file is part of MONA 
                                      4 ;
                                      5 ;     MONA is free software: you can redistribute it and/or modify
                                      6 ;     it under the terms of the GNU General Public License as published by
                                      7 ;     the Free Software Foundation, either version 3 of the License, or
                                      8 ;     (at your option) any later version.
                                      9 ;
                                     10 ;     MONA is distributed in the hope that it will be useful,
                                     11 ;     but WITHOUT ANY WARRANTY; without even the implied warranty of
                                     12 ;     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
                                     13 ;     GNU General Public License for more details.
                                     14 ;
                                     15 ;     You should have received a copy of the GNU General Public License
                                     16 ;     along with MONA.  If not, see <http://www.gnu.org/licenses/>.
                                     17 ;;
                                     18 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                                     19 ; 2022/11/14
                                     20 ; STM8S207K8 µC registers map
                                     21 ; sdas source file
                                     22 ; author: Jacques Deschênes, copyright 2018,2019,2022
                                     23 ; licence: GPLv3
                                     24 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                                     25 
                                     26 ;;;;;;;;;;;
                                     27 ; bits
                                     28 ;;;;;;;;;;;;
                           000000    29  BIT0 = 0
                           000001    30  BIT1 = 1
                           000002    31  BIT2 = 2
                           000003    32  BIT3 = 3
                           000004    33  BIT4 = 4
                           000005    34  BIT5 = 5
                           000006    35  BIT6 = 6
                           000007    36  BIT7 = 7
                                     37  	
                                     38 ;;;;;;;;;;;;
                                     39 ; bits masks
                                     40 ;;;;;;;;;;;;
                           000001    41  B0_MASK = (1<<0)
                           000002    42  B1_MASK = (1<<1)
                           000004    43  B2_MASK = (1<<2)
                           000008    44  B3_MASK = (1<<3)
                           000010    45  B4_MASK = (1<<4)
                           000020    46  B5_MASK = (1<<5)
                           000040    47  B6_MASK = (1<<6)
                           000080    48  B7_MASK = (1<<7)
                                     49 
                                     50 ; HSI oscillator frequency 16Mhz
                           F42400    51  FHSI = 16000000
                                     52 ; LSI oscillator frequency 128Khz
                           01F400    53  FLSI = 128000 
                                     54 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 4.
Hexadecimal [24-Bits]



                                     55 ; controller memory regions
                           001800    56  RAM_SIZE = (0x1800) ; 6KB 
                           000400    57  EEPROM_SIZE = (0x400) ; 1KB
                                     58 ; STM8S207K8 have 64K flash
                           010000    59  FLASH_SIZE = (0x10000)
                                     60 ; erase block size 
                           000080    61 BLOCK_SIZE=128 ; bytes 
                                     62 
                           000000    63  RAM_BASE = (0)
                           0017FF    64  RAM_END = (RAM_BASE+RAM_SIZE-1)
                           004000    65  EEPROM_BASE = (0x4000)
                           0043FF    66  EEPROM_END = (EEPROM_BASE+EEPROM_SIZE-1)
                           005000    67  SFR_BASE = (0x5000)
                           0057FF    68  SFR_END = (0x57FF)
                           006000    69  BOOT_ROM_BASE = (0x6000)
                           007FFF    70  BOOT_ROM_END = (0x7fff)
                           008000    71  FLASH_BASE = (0x8000)
                           017FFF    72  FLASH_END = (FLASH_BASE+FLASH_SIZE-1)
                           004800    73  OPTION_BASE = (0x4800)
                           000080    74  OPTION_SIZE = (0x80)
                           00487F    75  OPTION_END = (OPTION_BASE+OPTION_SIZE-1)
                           0048CD    76  DEVID_BASE = (0x48CD)
                           0048D8    77  DEVID_END = (0x48D8)
                           007F00    78  DEBUG_BASE = (0X7F00)
                           007FFF    79  DEBUG_END = (0X7FFF)
                                     80 
                                     81 ; options bytes
                                     82 ; this one can be programmed only from SWIM  (ICP)
                           004800    83  OPT0  = (0x4800)
                                     84 ; these can be programmed at runtime (IAP)
                           004801    85  OPT1  = (0x4801)
                           004802    86  NOPT1  = (0x4802)
                           004803    87  OPT2  = (0x4803)
                           004804    88  NOPT2  = (0x4804)
                           004805    89  OPT3  = (0x4805)
                           004806    90  NOPT3  = (0x4806)
                           004807    91  OPT4  = (0x4807)
                           004808    92  NOPT4  = (0x4808)
                           004809    93  OPT5  = (0x4809)
                           00480A    94  NOPT5  = (0x480A)
                           00480B    95  OPT6  = (0x480B)
                           00480C    96  NOPT6 = (0x480C)
                           00480D    97  OPT7 = (0x480D)
                           00480E    98  NOPT7 = (0x480E)
                           00487E    99  OPTBL  = (0x487E)
                           00487F   100  NOPTBL  = (0x487F)
                                    101 ; option registers usage
                                    102 ; read out protection, value 0xAA enable ROP
                           004800   103  ROP = OPT0  
                                    104 ; user boot code, {0..0x3e} 512 bytes row
                           004801   105  UBC = OPT1
                           004802   106  NUBC = NOPT1
                                    107 ; alternate function register
                           004803   108  AFR = OPT2
                           004804   109  NAFR = NOPT2
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 5.
Hexadecimal [24-Bits]



                                    110 ; miscelinous options
                           004805   111  WDGOPT = OPT3
                           004806   112  NWDGOPT = NOPT3
                                    113 ; clock options
                           004807   114  CLKOPT = OPT4
                           004808   115  NCLKOPT = NOPT4
                                    116 ; HSE clock startup delay
                           004809   117  HSECNT = OPT5
                           00480A   118  NHSECNT = NOPT5
                                    119 ; flash wait state
                           00480D   120 FLASH_WS = OPT7
                           00480E   121 NFLASH_WS = NOPT7
                                    122 
                                    123 ; watchdog options bits
                           000003   124   WDGOPT_LSIEN   =  BIT3
                           000002   125   WDGOPT_IWDG_HW =  BIT2
                           000001   126   WDGOPT_WWDG_HW =  BIT1
                           000000   127   WDGOPT_WWDG_HALT = BIT0
                                    128 ; NWDGOPT bits
                           FFFFFFFC   129   NWDGOPT_LSIEN    = ~BIT3
                           FFFFFFFD   130   NWDGOPT_IWDG_HW  = ~BIT2
                           FFFFFFFE   131   NWDGOPT_WWDG_HW  = ~BIT1
                           FFFFFFFF   132   NWDGOPT_WWDG_HALT = ~BIT0
                                    133 
                                    134 ; CLKOPT bits
                           000003   135  CLKOPT_EXT_CLK  = BIT3
                           000002   136  CLKOPT_CKAWUSEL = BIT2
                           000001   137  CLKOPT_PRS_C1   = BIT1
                           000000   138  CLKOPT_PRS_C0   = BIT0
                                    139 
                                    140 ; AFR option, remapable functions
                           000007   141  AFR7_BEEP    = BIT7
                           000006   142  AFR6_I2C     = BIT6
                           000005   143  AFR5_TIM1    = BIT5
                           000004   144  AFR4_TIM1    = BIT4
                           000003   145  AFR3_TIM1    = BIT3
                           000002   146  AFR2_CCO     = BIT2
                           000001   147  AFR1_TIM2    = BIT1
                           000000   148  AFR0_ADC     = BIT0
                                    149 
                                    150 ; device ID = (read only)
                           0048CD   151  DEVID_XL  = (0x48CD)
                           0048CE   152  DEVID_XH  = (0x48CE)
                           0048CF   153  DEVID_YL  = (0x48CF)
                           0048D0   154  DEVID_YH  = (0x48D0)
                           0048D1   155  DEVID_WAF  = (0x48D1)
                           0048D2   156  DEVID_LOT0  = (0x48D2)
                           0048D3   157  DEVID_LOT1  = (0x48D3)
                           0048D4   158  DEVID_LOT2  = (0x48D4)
                           0048D5   159  DEVID_LOT3  = (0x48D5)
                           0048D6   160  DEVID_LOT4  = (0x48D6)
                           0048D7   161  DEVID_LOT5  = (0x48D7)
                           0048D8   162  DEVID_LOT6  = (0x48D8)
                                    163 
                                    164 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 6.
Hexadecimal [24-Bits]



                           005000   165 GPIO_BASE = (0x5000)
                           000005   166 GPIO_SIZE = (5)
                                    167 ; PORTS SFR OFFSET
                           000000   168 PA = 0
                           000005   169 PB = 5
                           00000A   170 PC = 10
                           00000F   171 PD = 15
                           000014   172 PE = 20
                           000019   173 PF = 25
                           00001E   174 PG = 30
                           000023   175 PH = 35 
                           000028   176 PI = 40 
                                    177 
                                    178 ; GPIO
                                    179 ; gpio register offset to base
                           000000   180  GPIO_ODR = 0
                           000001   181  GPIO_IDR = 1
                           000002   182  GPIO_DDR = 2
                           000003   183  GPIO_CR1 = 3
                           000004   184  GPIO_CR2 = 4
                           005000   185  GPIO_BASE=(0X5000)
                                    186  
                                    187 ; port A
                           005000   188  PA_BASE = (0X5000)
                           005000   189  PA_ODR  = (0x5000)
                           005001   190  PA_IDR  = (0x5001)
                           005002   191  PA_DDR  = (0x5002)
                           005003   192  PA_CR1  = (0x5003)
                           005004   193  PA_CR2  = (0x5004)
                                    194 ; port B
                           005005   195  PB_BASE = (0X5005)
                           005005   196  PB_ODR  = (0x5005)
                           005006   197  PB_IDR  = (0x5006)
                           005007   198  PB_DDR  = (0x5007)
                           005008   199  PB_CR1  = (0x5008)
                           005009   200  PB_CR2  = (0x5009)
                                    201 ; port C
                           00500A   202  PC_BASE = (0X500A)
                           00500A   203  PC_ODR  = (0x500A)
                           00500B   204  PC_IDR  = (0x500B)
                           00500C   205  PC_DDR  = (0x500C)
                           00500D   206  PC_CR1  = (0x500D)
                           00500E   207  PC_CR2  = (0x500E)
                                    208 ; port D
                           00500F   209  PD_BASE = (0X500F)
                           00500F   210  PD_ODR  = (0x500F)
                           005010   211  PD_IDR  = (0x5010)
                           005011   212  PD_DDR  = (0x5011)
                           005012   213  PD_CR1  = (0x5012)
                           005013   214  PD_CR2  = (0x5013)
                                    215 ; port E
                           005014   216  PE_BASE = (0X5014)
                           005014   217  PE_ODR  = (0x5014)
                           005015   218  PE_IDR  = (0x5015)
                           005016   219  PE_DDR  = (0x5016)
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 7.
Hexadecimal [24-Bits]



                           005017   220  PE_CR1  = (0x5017)
                           005018   221  PE_CR2  = (0x5018)
                                    222 ; port F
                           005019   223  PF_BASE = (0X5019)
                           005019   224  PF_ODR  = (0x5019)
                           00501A   225  PF_IDR  = (0x501A)
                           00501B   226  PF_DDR  = (0x501B)
                           00501C   227  PF_CR1  = (0x501C)
                           00501D   228  PF_CR2  = (0x501D)
                                    229 ; port G
                           00501E   230  PG_BASE = (0X501E)
                           00501E   231  PG_ODR  = (0x501E)
                           00501F   232  PG_IDR  = (0x501F)
                           005020   233  PG_DDR  = (0x5020)
                           005021   234  PG_CR1  = (0x5021)
                           005022   235  PG_CR2  = (0x5022)
                                    236 ; port H not present on LQFP48/LQFP64 package
                           005023   237  PH_BASE = (0X5023)
                           005023   238  PH_ODR  = (0x5023)
                           005024   239  PH_IDR  = (0x5024)
                           005025   240  PH_DDR  = (0x5025)
                           005026   241  PH_CR1  = (0x5026)
                           005027   242  PH_CR2  = (0x5027)
                                    243 ; port I ; only bit 0 on LQFP64 package, not present on LQFP48
                           005028   244  PI_BASE = (0X5028)
                           005028   245  PI_ODR  = (0x5028)
                           005029   246  PI_IDR  = (0x5029)
                           00502A   247  PI_DDR  = (0x502a)
                           00502B   248  PI_CR1  = (0x502b)
                           00502C   249  PI_CR2  = (0x502c)
                                    250 
                                    251 ; input modes CR1
                           000000   252  INPUT_FLOAT = (0) ; no pullup resistor
                           000001   253  INPUT_PULLUP = (1)
                                    254 ; output mode CR1
                           000000   255  OUTPUT_OD = (0) ; open drain
                           000001   256  OUTPUT_PP = (1) ; push pull
                                    257 ; input modes CR2
                           000000   258  INPUT_DI = (0)
                           000001   259  INPUT_EI = (1)
                                    260 ; output speed CR2
                           000000   261  OUTPUT_SLOW = (0)
                           000001   262  OUTPUT_FAST = (1)
                                    263 
                                    264 
                                    265 ; Flash memory
                           000080   266  BLOCK_SIZE=128 
                           00505A   267  FLASH_CR1  = (0x505A)
                           00505B   268  FLASH_CR2  = (0x505B)
                           00505C   269  FLASH_NCR2  = (0x505C)
                           00505D   270  FLASH_FPR  = (0x505D)
                           00505E   271  FLASH_NFPR  = (0x505E)
                           00505F   272  FLASH_IAPSR  = (0x505F)
                           005062   273  FLASH_PUKR  = (0x5062)
                           005064   274  FLASH_DUKR  = (0x5064)
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 8.
Hexadecimal [24-Bits]



                                    275 ; data memory unlock keys
                           0000AE   276  FLASH_DUKR_KEY1 = (0xae)
                           000056   277  FLASH_DUKR_KEY2 = (0x56)
                                    278 ; flash memory unlock keys
                           000056   279  FLASH_PUKR_KEY1 = (0x56)
                           0000AE   280  FLASH_PUKR_KEY2 = (0xae)
                                    281 ; FLASH_CR1 bits
                           000003   282  FLASH_CR1_HALT = BIT3
                           000002   283  FLASH_CR1_AHALT = BIT2
                           000001   284  FLASH_CR1_IE = BIT1
                           000000   285  FLASH_CR1_FIX = BIT0
                                    286 ; FLASH_CR2 bits
                           000007   287  FLASH_CR2_OPT = BIT7
                           000006   288  FLASH_CR2_WPRG = BIT6
                           000005   289  FLASH_CR2_ERASE = BIT5
                           000004   290  FLASH_CR2_FPRG = BIT4
                           000000   291  FLASH_CR2_PRG = BIT0
                                    292 ; FLASH_FPR bits
                           000005   293  FLASH_FPR_WPB5 = BIT5
                           000004   294  FLASH_FPR_WPB4 = BIT4
                           000003   295  FLASH_FPR_WPB3 = BIT3
                           000002   296  FLASH_FPR_WPB2 = BIT2
                           000001   297  FLASH_FPR_WPB1 = BIT1
                           000000   298  FLASH_FPR_WPB0 = BIT0
                                    299 ; FLASH_NFPR bits
                           000005   300  FLASH_NFPR_NWPB5 = BIT5
                           000004   301  FLASH_NFPR_NWPB4 = BIT4
                           000003   302  FLASH_NFPR_NWPB3 = BIT3
                           000002   303  FLASH_NFPR_NWPB2 = BIT2
                           000001   304  FLASH_NFPR_NWPB1 = BIT1
                           000000   305  FLASH_NFPR_NWPB0 = BIT0
                                    306 ; FLASH_IAPSR bits
                           000006   307  FLASH_IAPSR_HVOFF = BIT6
                           000003   308  FLASH_IAPSR_DUL = BIT3
                           000002   309  FLASH_IAPSR_EOP = BIT2
                           000001   310  FLASH_IAPSR_PUL = BIT1
                           000000   311  FLASH_IAPSR_WR_PG_DIS = BIT0
                                    312 
                                    313 ; Interrupt control
                           0050A0   314  EXTI_CR1  = (0x50A0)
                           0050A1   315  EXTI_CR2  = (0x50A1)
                                    316 
                                    317 ; Reset Status
                           0050B3   318  RST_SR  = (0x50B3)
                                    319 
                                    320 ; Clock Registers
                           0050C0   321  CLK_ICKR  = (0x50c0)
                           0050C1   322  CLK_ECKR  = (0x50c1)
                           0050C3   323  CLK_CMSR  = (0x50C3)
                           0050C4   324  CLK_SWR  = (0x50C4)
                           0050C5   325  CLK_SWCR  = (0x50C5)
                           0050C6   326  CLK_CKDIVR  = (0x50C6)
                           0050C7   327  CLK_PCKENR1  = (0x50C7)
                           0050C8   328  CLK_CSSR  = (0x50C8)
                           0050C9   329  CLK_CCOR  = (0x50C9)
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 9.
Hexadecimal [24-Bits]



                           0050CA   330  CLK_PCKENR2  = (0x50CA)
                           0050CC   331  CLK_HSITRIMR  = (0x50CC)
                           0050CD   332  CLK_SWIMCCR  = (0x50CD)
                                    333 
                                    334 ; Peripherals clock gating
                                    335 ; CLK_PCKENR1 
                           000007   336  CLK_PCKENR1_TIM1 = (7)
                           000006   337  CLK_PCKENR1_TIM3 = (6)
                           000005   338  CLK_PCKENR1_TIM2 = (5)
                           000004   339  CLK_PCKENR1_TIM4 = (4)
                           000003   340  CLK_PCKENR1_UART3 = (3)
                           000002   341  CLK_PCKENR1_UART1 = (2)
                           000001   342  CLK_PCKENR1_SPI = (1)
                           000000   343  CLK_PCKENR1_I2C = (0)
                                    344 ; CLK_PCKENR2
                           000007   345  CLK_PCKENR2_CAN = (7)
                           000003   346  CLK_PCKENR2_ADC = (3)
                           000002   347  CLK_PCKENR2_AWU = (2)
                                    348 
                                    349 ; Clock bits
                           000005   350  CLK_ICKR_REGAH = (5)
                           000004   351  CLK_ICKR_LSIRDY = (4)
                           000003   352  CLK_ICKR_LSIEN = (3)
                           000002   353  CLK_ICKR_FHW = (2)
                           000001   354  CLK_ICKR_HSIRDY = (1)
                           000000   355  CLK_ICKR_HSIEN = (0)
                                    356 
                           000001   357  CLK_ECKR_HSERDY = (1)
                           000000   358  CLK_ECKR_HSEEN = (0)
                                    359 ; clock source
                           0000E1   360  CLK_SWR_HSI = 0xE1
                           0000D2   361  CLK_SWR_LSI = 0xD2
                           0000B4   362  CLK_SWR_HSE = 0xB4
                                    363 
                           000003   364  CLK_SWCR_SWIF = (3)
                           000002   365  CLK_SWCR_SWIEN = (2)
                           000001   366  CLK_SWCR_SWEN = (1)
                           000000   367  CLK_SWCR_SWBSY = (0)
                                    368 
                           000004   369  CLK_CKDIVR_HSIDIV1 = (4)
                           000003   370  CLK_CKDIVR_HSIDIV0 = (3)
                           000002   371  CLK_CKDIVR_CPUDIV2 = (2)
                           000001   372  CLK_CKDIVR_CPUDIV1 = (1)
                           000000   373  CLK_CKDIVR_CPUDIV0 = (0)
                                    374 
                                    375 ; Watchdog
                           0050D1   376  WWDG_CR  = (0x50D1)
                           0050D2   377  WWDG_WR  = (0x50D2)
                           0050E0   378  IWDG_KR  = (0x50E0)
                           0050E1   379  IWDG_PR  = (0x50E1)
                           0050E2   380  IWDG_RLR  = (0x50E2)
                           0000CC   381  IWDG_KEY_ENABLE = 0xCC  ; enable IWDG key 
                           0000AA   382  IWDG_KEY_REFRESH = 0xAA ; refresh counter key 
                           000055   383  IWDG_KEY_ACCESS = 0x55 ; write register key 
                                    384  
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 10.
Hexadecimal [24-Bits]



                           0050F0   385  AWU_CSR  = (0x50F0)
                           0050F1   386  AWU_APR  = (0x50F1)
                           0050F2   387  AWU_TBR  = (0x50F2)
                           000004   388  AWU_CSR_AWUEN = 4
                                    389 
                                    390 
                                    391 
                                    392 ; Beeper
                                    393 ; beeper output is alternate function AFR7 on PD4
                                    394 ; connected to CN9-6
                           0050F3   395  BEEP_CSR  = (0x50F3)
                           00000F   396  BEEP_PORT = PD
                           000004   397  BEEP_BIT = 4
                           000010   398  BEEP_MASK = B4_MASK
                                    399 
                                    400 ; SPI
                           005200   401  SPI_CR1  = (0x5200)
                           005201   402  SPI_CR2  = (0x5201)
                           005202   403  SPI_ICR  = (0x5202)
                           005203   404  SPI_SR  = (0x5203)
                           005204   405  SPI_DR  = (0x5204)
                           005205   406  SPI_CRCPR  = (0x5205)
                           005206   407  SPI_RXCRCR  = (0x5206)
                           005207   408  SPI_TXCRCR  = (0x5207)
                                    409 
                                    410 ; SPI_CR1 bit fields 
                           000000   411   SPI_CR1_CPHA=0
                           000001   412   SPI_CR1_CPOL=1
                           000002   413   SPI_CR1_MSTR=2
                           000003   414   SPI_CR1_BR=3
                           000006   415   SPI_CR1_SPE=6
                           000007   416   SPI_CR1_LSBFIRST=7
                                    417   
                                    418 ; SPI_CR2 bit fields 
                           000000   419   SPI_CR2_SSI=0
                           000001   420   SPI_CR2_SSM=1
                           000002   421   SPI_CR2_RXONLY=2
                           000004   422   SPI_CR2_CRCNEXT=4
                           000005   423   SPI_CR2_CRCEN=5
                           000006   424   SPI_CR2_BDOE=6
                           000007   425   SPI_CR2_BDM=7  
                                    426 
                                    427 ; SPI_SR bit fields 
                           000000   428   SPI_SR_RXNE=0
                           000001   429   SPI_SR_TXE=1
                           000003   430   SPI_SR_WKUP=3
                           000004   431   SPI_SR_CRCERR=4
                           000005   432   SPI_SR_MODF=5
                           000006   433   SPI_SR_OVR=6
                           000007   434   SPI_SR_BSY=7
                                    435 
                                    436 ; I2C
                           005210   437  I2C_BASE_ADDR = 0x5210 
                           005210   438  I2C_CR1  = (0x5210)
                           005211   439  I2C_CR2  = (0x5211)
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 11.
Hexadecimal [24-Bits]



                           005212   440  I2C_FREQR  = (0x5212)
                           005213   441  I2C_OARL  = (0x5213)
                           005214   442  I2C_OARH  = (0x5214)
                           005216   443  I2C_DR  = (0x5216)
                           005217   444  I2C_SR1  = (0x5217)
                           005218   445  I2C_SR2  = (0x5218)
                           005219   446  I2C_SR3  = (0x5219)
                           00521A   447  I2C_ITR  = (0x521A)
                           00521B   448  I2C_CCRL  = (0x521B)
                           00521C   449  I2C_CCRH  = (0x521C)
                           00521D   450  I2C_TRISER  = (0x521D)
                           00521E   451  I2C_PECR  = (0x521E)
                                    452 
                           000007   453  I2C_CR1_NOSTRETCH = (7)
                           000006   454  I2C_CR1_ENGC = (6)
                           000000   455  I2C_CR1_PE = (0)
                                    456 
                           000007   457  I2C_CR2_SWRST = (7)
                           000003   458  I2C_CR2_POS = (3)
                           000002   459  I2C_CR2_ACK = (2)
                           000001   460  I2C_CR2_STOP = (1)
                           000000   461  I2C_CR2_START = (0)
                                    462 
                           000000   463  I2C_OARL_ADD0 = (0)
                                    464 
                           000009   465  I2C_OAR_ADDR_7BIT = ((I2C_OARL & 0xFE) >> 1)
                           000813   466  I2C_OAR_ADDR_10BIT = (((I2C_OARH & 0x06) << 9) | (I2C_OARL & 0xFF))
                                    467 
                           000007   468  I2C_OARH_ADDMODE = (7)
                           000006   469  I2C_OARH_ADDCONF = (6)
                           000002   470  I2C_OARH_ADD9 = (2)
                           000001   471  I2C_OARH_ADD8 = (1)
                                    472 
                           000007   473  I2C_SR1_TXE = (7)
                           000006   474  I2C_SR1_RXNE = (6)
                           000004   475  I2C_SR1_STOPF = (4)
                           000003   476  I2C_SR1_ADD10 = (3)
                           000002   477  I2C_SR1_BTF = (2)
                           000001   478  I2C_SR1_ADDR = (1)
                           000000   479  I2C_SR1_SB = (0)
                                    480 
                           000005   481  I2C_SR2_WUFH = (5)
                           000003   482  I2C_SR2_OVR = (3)
                           000002   483  I2C_SR2_AF = (2)
                           000001   484  I2C_SR2_ARLO = (1)
                           000000   485  I2C_SR2_BERR = (0)
                                    486 
                           000007   487  I2C_SR3_DUALF = (7)
                           000004   488  I2C_SR3_GENCALL = (4)
                           000002   489  I2C_SR3_TRA = (2)
                           000001   490  I2C_SR3_BUSY = (1)
                           000000   491  I2C_SR3_MSL = (0)
                                    492 
                           000002   493  I2C_ITR_ITBUFEN = (2)
                           000001   494  I2C_ITR_ITEVTEN = (1)
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 12.
Hexadecimal [24-Bits]



                           000000   495  I2C_ITR_ITERREN = (0)
                                    496 
                           000007   497  I2C_CCRH_FAST = 7 
                           000006   498  I2C_CCRH_DUTY = 6 
                                    499  
                                    500 ; Precalculated values, all in KHz
                           000080   501  I2C_CCRH_16MHZ_FAST_400 = 0x80
                           00000D   502  I2C_CCRL_16MHZ_FAST_400 = 0x0D
                                    503 ;
                                    504 ; Fast I2C mode max rise time = 300ns
                                    505 ; I2C_FREQR = 16 = (MHz) => tMASTER = 1/16 = 62.5 ns
                                    506 ; TRISER = = (300/62.5) + 1 = floor(4.8) + 1 = 5.
                                    507 
                           000005   508  I2C_TRISER_16MHZ_FAST_400 = 0x05
                                    509 
                           0000C0   510  I2C_CCRH_16MHZ_FAST_320 = 0xC0
                           000002   511  I2C_CCRL_16MHZ_FAST_320 = 0x02
                           000005   512  I2C_TRISER_16MHZ_FAST_320 = 0x05
                                    513 
                           000080   514  I2C_CCRH_16MHZ_FAST_200 = 0x80
                           00001A   515  I2C_CCRL_16MHZ_FAST_200 = 0x1A
                           000005   516  I2C_TRISER_16MHZ_FAST_200 = 0x05
                                    517 
                           000000   518  I2C_CCRH_16MHZ_STD_100 = 0x00
                           000050   519  I2C_CCRL_16MHZ_STD_100 = 0x50
                                    520 ;
                                    521 ; Standard I2C mode max rise time = 1000ns
                                    522 ; I2C_FREQR = 16 = (MHz) => tMASTER = 1/16 = 62.5 ns
                                    523 ; TRISER = = (1000/62.5) + 1 = floor(16) + 1 = 17.
                                    524 
                           000011   525  I2C_TRISER_16MHZ_STD_100 = 0x11
                                    526 
                           000000   527  I2C_CCRH_16MHZ_STD_50 = 0x00
                           0000A0   528  I2C_CCRL_16MHZ_STD_50 = 0xA0
                           000011   529  I2C_TRISER_16MHZ_STD_50 = 0x11
                                    530 
                           000001   531  I2C_CCRH_16MHZ_STD_20 = 0x01
                           000090   532  I2C_CCRL_16MHZ_STD_20 = 0x90
                           000011   533  I2C_TRISER_16MHZ_STD_20 = 0x11;
                                    534 
                           000001   535  I2C_READ = 1
                           000000   536  I2C_WRITE = 0
                                    537 
                                    538 ; baudrate constant for brr_value table access
                                    539 ; to be used by uart_init 
                           000000   540 B2400=0
                           000001   541 B4800=1
                           000002   542 B9600=2
                           000003   543 B19200=3
                           000004   544 B38400=4
                           000005   545 B57600=5
                           000006   546 B115200=6
                           000007   547 B230400=7
                           000008   548 B460800=8
                           000009   549 B921600=9
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 13.
Hexadecimal [24-Bits]



                                    550 
                                    551 ; UART registers offset from
                                    552 ; base address 
                           000000   553 OFS_UART_SR=0
                           000001   554 OFS_UART_DR=1
                           000002   555 OFS_UART_BRR1=2
                           000003   556 OFS_UART_BRR2=3
                           000004   557 OFS_UART_CR1=4
                           000005   558 OFS_UART_CR2=5
                           000006   559 OFS_UART_CR3=6
                           000007   560 OFS_UART_CR4=7
                           000008   561 OFS_UART_CR5=8
                           000009   562 OFS_UART_CR6=9
                           000009   563 OFS_UART_GTR=9
                           00000A   564 OFS_UART_PSCR=10
                                    565 
                                    566 ; uart identifier
                           000000   567  UART1 = 0 
                           000001   568  UART2 = 1
                           000002   569  UART3 = 2
                                    570 
                                    571 ; pins used by uart 
                           000005   572 UART1_TX_PIN=BIT5
                           000004   573 UART1_RX_PIN=BIT4
                           000005   574 UART3_TX_PIN=BIT5
                           000006   575 UART3_RX_PIN=BIT6
                                    576 ; uart port base address 
                           000000   577 UART1_PORT=PA 
                           00000F   578 UART3_PORT=PD
                                    579 
                                    580 ; UART1 
                           005230   581  UART1_BASE  = (0x5230)
                           005230   582  UART1_SR    = (0x5230)
                           005231   583  UART1_DR    = (0x5231)
                           005232   584  UART1_BRR1  = (0x5232)
                           005233   585  UART1_BRR2  = (0x5233)
                           005234   586  UART1_CR1   = (0x5234)
                           005235   587  UART1_CR2   = (0x5235)
                           005236   588  UART1_CR3   = (0x5236)
                           005237   589  UART1_CR4   = (0x5237)
                           005238   590  UART1_CR5   = (0x5238)
                           005239   591  UART1_GTR   = (0x5239)
                           00523A   592  UART1_PSCR  = (0x523A)
                                    593 
                                    594 ; UART3
                           005240   595  UART3_BASE  = (0x5240)
                           005240   596  UART3_SR    = (0x5240)
                           005241   597  UART3_DR    = (0x5241)
                           005242   598  UART3_BRR1  = (0x5242)
                           005243   599  UART3_BRR2  = (0x5243)
                           005244   600  UART3_CR1   = (0x5244)
                           005245   601  UART3_CR2   = (0x5245)
                           005246   602  UART3_CR3   = (0x5246)
                           005247   603  UART3_CR4   = (0x5247)
                           005249   604  UART3_CR6   = (0x5249)
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 14.
Hexadecimal [24-Bits]



                                    605 
                                    606 ; UART Status Register bits
                           000007   607  UART_SR_TXE = (7)
                           000006   608  UART_SR_TC = (6)
                           000005   609  UART_SR_RXNE = (5)
                           000004   610  UART_SR_IDLE = (4)
                           000003   611  UART_SR_OR = (3)
                           000002   612  UART_SR_NF = (2)
                           000001   613  UART_SR_FE = (1)
                           000000   614  UART_SR_PE = (0)
                                    615 
                                    616 ; Uart Control Register bits
                           000007   617  UART_CR1_R8 = (7)
                           000006   618  UART_CR1_T8 = (6)
                           000005   619  UART_CR1_UARTD = (5)
                           000004   620  UART_CR1_M = (4)
                           000003   621  UART_CR1_WAKE = (3)
                           000002   622  UART_CR1_PCEN = (2)
                           000001   623  UART_CR1_PS = (1)
                           000000   624  UART_CR1_PIEN = (0)
                                    625 
                           000007   626  UART_CR2_TIEN = (7)
                           000006   627  UART_CR2_TCIEN = (6)
                           000005   628  UART_CR2_RIEN = (5)
                           000004   629  UART_CR2_ILIEN = (4)
                           000003   630  UART_CR2_TEN = (3)
                           000002   631  UART_CR2_REN = (2)
                           000001   632  UART_CR2_RWU = (1)
                           000000   633  UART_CR2_SBK = (0)
                                    634 
                           000006   635  UART_CR3_LINEN = (6)
                           000005   636  UART_CR3_STOP1 = (5)
                           000004   637  UART_CR3_STOP0 = (4)
                           000003   638  UART_CR3_CLKEN = (3)
                           000002   639  UART_CR3_CPOL = (2)
                           000001   640  UART_CR3_CPHA = (1)
                           000000   641  UART_CR3_LBCL = (0)
                                    642 
                           000006   643  UART_CR4_LBDIEN = (6)
                           000005   644  UART_CR4_LBDL = (5)
                           000004   645  UART_CR4_LBDF = (4)
                           000003   646  UART_CR4_ADD3 = (3)
                           000002   647  UART_CR4_ADD2 = (2)
                           000001   648  UART_CR4_ADD1 = (1)
                           000000   649  UART_CR4_ADD0 = (0)
                                    650 
                           000005   651  UART_CR5_SCEN = (5)
                           000004   652  UART_CR5_NACK = (4)
                           000003   653  UART_CR5_HDSEL = (3)
                           000002   654  UART_CR5_IRLP = (2)
                           000001   655  UART_CR5_IREN = (1)
                                    656 ; LIN mode config register
                           000007   657  UART_CR6_LDUM = (7)
                           000005   658  UART_CR6_LSLV = (5)
                           000004   659  UART_CR6_LASE = (4)
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 15.
Hexadecimal [24-Bits]



                           000002   660  UART_CR6_LHDIEN = (2) 
                           000001   661  UART_CR6_LHDF = (1)
                           000000   662  UART_CR6_LSF = (0)
                                    663 
                                    664 ; TIMERS
                                    665 ; Timer 1 - 16-bit timer with complementary PWM outputs
                           005250   666  TIM1_CR1  = (0x5250)
                           005251   667  TIM1_CR2  = (0x5251)
                           005252   668  TIM1_SMCR  = (0x5252)
                           005253   669  TIM1_ETR  = (0x5253)
                           005254   670  TIM1_IER  = (0x5254)
                           005255   671  TIM1_SR1  = (0x5255)
                           005256   672  TIM1_SR2  = (0x5256)
                           005257   673  TIM1_EGR  = (0x5257)
                           005258   674  TIM1_CCMR1  = (0x5258)
                           005259   675  TIM1_CCMR2  = (0x5259)
                           00525A   676  TIM1_CCMR3  = (0x525A)
                           00525B   677  TIM1_CCMR4  = (0x525B)
                           00525C   678  TIM1_CCER1  = (0x525C)
                           00525D   679  TIM1_CCER2  = (0x525D)
                           00525E   680  TIM1_CNTRH  = (0x525E)
                           00525F   681  TIM1_CNTRL  = (0x525F)
                           005260   682  TIM1_PSCRH  = (0x5260)
                           005261   683  TIM1_PSCRL  = (0x5261)
                           005262   684  TIM1_ARRH  = (0x5262)
                           005263   685  TIM1_ARRL  = (0x5263)
                           005264   686  TIM1_RCR  = (0x5264)
                           005265   687  TIM1_CCR1H  = (0x5265)
                           005266   688  TIM1_CCR1L  = (0x5266)
                           005267   689  TIM1_CCR2H  = (0x5267)
                           005268   690  TIM1_CCR2L  = (0x5268)
                           005269   691  TIM1_CCR3H  = (0x5269)
                           00526A   692  TIM1_CCR3L  = (0x526A)
                           00526B   693  TIM1_CCR4H  = (0x526B)
                           00526C   694  TIM1_CCR4L  = (0x526C)
                           00526D   695  TIM1_BKR  = (0x526D)
                           00526E   696  TIM1_DTR  = (0x526E)
                           00526F   697  TIM1_OISR  = (0x526F)
                                    698 
                                    699 ; Timer Control Register bits
                           000007   700  TIM1_CR1_ARPE = (7)
                           000006   701  TIM1_CR1_CMSH = (6)
                           000005   702  TIM1_CR1_CMSL = (5)
                           000004   703  TIM1_CR1_DIR = (4)
                           000003   704  TIM1_CR1_OPM = (3)
                           000002   705  TIM1_CR1_URS = (2)
                           000001   706  TIM1_CR1_UDIS = (1)
                           000000   707  TIM1_CR1_CEN = (0)
                                    708 
                           000006   709  TIM1_CR2_MMS2 = (6)
                           000005   710  TIM1_CR2_MMS1 = (5)
                           000004   711  TIM1_CR2_MMS0 = (4)
                           000002   712  TIM1_CR2_COMS = (2)
                           000000   713  TIM1_CR2_CCPC = (0)
                                    714 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 16.
Hexadecimal [24-Bits]



                                    715 ; Timer Slave Mode Control bits
                           000007   716  TIM1_SMCR_MSM = (7)
                           000006   717  TIM1_SMCR_TS2 = (6)
                           000005   718  TIM1_SMCR_TS1 = (5)
                           000004   719  TIM1_SMCR_TS0 = (4)
                           000002   720  TIM1_SMCR_SMS2 = (2)
                           000001   721  TIM1_SMCR_SMS1 = (1)
                           000000   722  TIM1_SMCR_SMS0 = (0)
                                    723 
                                    724 ; Timer External Trigger Enable bits
                           000007   725  TIM1_ETR_ETP = (7)
                           000006   726  TIM1_ETR_ECE = (6)
                           000005   727  TIM1_ETR_ETPS1 = (5)
                           000004   728  TIM1_ETR_ETPS0 = (4)
                           000003   729  TIM1_ETR_ETF3 = (3)
                           000002   730  TIM1_ETR_ETF2 = (2)
                           000001   731  TIM1_ETR_ETF1 = (1)
                           000000   732  TIM1_ETR_ETF0 = (0)
                                    733 
                                    734 ; Timer Interrupt Enable bits
                           000007   735  TIM1_IER_BIE = (7)
                           000006   736  TIM1_IER_TIE = (6)
                           000005   737  TIM1_IER_COMIE = (5)
                           000004   738  TIM1_IER_CC4IE = (4)
                           000003   739  TIM1_IER_CC3IE = (3)
                           000002   740  TIM1_IER_CC2IE = (2)
                           000001   741  TIM1_IER_CC1IE = (1)
                           000000   742  TIM1_IER_UIE = (0)
                                    743 
                                    744 ; Timer Status Register bits
                           000007   745  TIM1_SR1_BIF = (7)
                           000006   746  TIM1_SR1_TIF = (6)
                           000005   747  TIM1_SR1_COMIF = (5)
                           000004   748  TIM1_SR1_CC4IF = (4)
                           000003   749  TIM1_SR1_CC3IF = (3)
                           000002   750  TIM1_SR1_CC2IF = (2)
                           000001   751  TIM1_SR1_CC1IF = (1)
                           000000   752  TIM1_SR1_UIF = (0)
                                    753 
                           000004   754  TIM1_SR2_CC4OF = (4)
                           000003   755  TIM1_SR2_CC3OF = (3)
                           000002   756  TIM1_SR2_CC2OF = (2)
                           000001   757  TIM1_SR2_CC1OF = (1)
                                    758 
                                    759 ; Timer Event Generation Register bits
                           000007   760  TIM1_EGR_BG = (7)
                           000006   761  TIM1_EGR_TG = (6)
                           000005   762  TIM1_EGR_COMG = (5)
                           000004   763  TIM1_EGR_CC4G = (4)
                           000003   764  TIM1_EGR_CC3G = (3)
                           000002   765  TIM1_EGR_CC2G = (2)
                           000001   766  TIM1_EGR_CC1G = (1)
                           000000   767  TIM1_EGR_UG = (0)
                                    768 
                                    769 ; Capture/Compare Mode Register 1 - channel configured in output
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 17.
Hexadecimal [24-Bits]



                           000007   770  TIM1_CCMR1_OC1CE = (7)
                           000006   771  TIM1_CCMR1_OC1M2 = (6)
                           000005   772  TIM1_CCMR1_OC1M1 = (5)
                           000004   773  TIM1_CCMR1_OC1M0 = (4)
                           000004   774  TIM1_CCMR1_OCMODE=(4)
                           000003   775  TIM1_CCMR1_OC1PE = (3)
                           000002   776  TIM1_CCMR1_OC1FE = (2)
                           000001   777  TIM1_CCMR1_CC1S1 = (1)
                           000000   778  TIM1_CCMR1_CC1S0 = (0)
                                    779 
                                    780 ; Capture/Compare Mode Register 1 - channel configured in input
                           000007   781  TIM1_CCMR1_IC1F3 = (7)
                           000006   782  TIM1_CCMR1_IC1F2 = (6)
                           000005   783  TIM1_CCMR1_IC1F1 = (5)
                           000004   784  TIM1_CCMR1_IC1F0 = (4)
                           000003   785  TIM1_CCMR1_IC1PSC1 = (3)
                           000002   786  TIM1_CCMR1_IC1PSC0 = (2)
                                    787 ;  TIM1_CCMR1_CC1S1 = (1)
                           000000   788  TIM1_CCMR1_CC1S0 = (0)
                                    789 
                                    790 ; Capture/Compare Mode Register 2 - channel configured in output
                           000007   791  TIM1_CCMR2_OC2CE = (7)
                           000006   792  TIM1_CCMR2_OC2M2 = (6)
                           000005   793  TIM1_CCMR2_OC2M1 = (5)
                           000004   794  TIM1_CCMR2_OC2M0 = (4)
                           000004   795  TIM1_CCMR2_OCMODE=(4)
                           000003   796  TIM1_CCMR2_OC2PE = (3)
                           000002   797  TIM1_CCMR2_OC2FE = (2)
                           000001   798  TIM1_CCMR2_CC2S1 = (1)
                           000000   799  TIM1_CCMR2_CC2S0 = (0)
                                    800 
                                    801 ; Capture/Compare Mode Register 2 - channel configured in input
                           000007   802  TIM1_CCMR2_IC2F3 = (7)
                           000006   803  TIM1_CCMR2_IC2F2 = (6)
                           000005   804  TIM1_CCMR2_IC2F1 = (5)
                           000004   805  TIM1_CCMR2_IC2F0 = (4)
                           000003   806  TIM1_CCMR2_IC2PSC1 = (3)
                           000002   807  TIM1_CCMR2_IC2PSC0 = (2)
                                    808 ;  TIM1_CCMR2_CC2S1 = (1)
                           000000   809  TIM1_CCMR2_CC2S0 = (0)
                                    810 
                                    811 ; Capture/Compare Mode Register 3 - channel configured in output
                           000007   812  TIM1_CCMR3_OC3CE = (7)
                           000006   813  TIM1_CCMR3_OC3M2 = (6)
                           000005   814  TIM1_CCMR3_OC3M1 = (5)
                           000004   815  TIM1_CCMR3_OC3M0 = (4)
                           000004   816  TIM1_CCMR3_OCMODE = (4)
                           000003   817  TIM1_CCMR3_OC3PE = (3)
                           000002   818  TIM1_CCMR3_OC3FE = (2)
                           000001   819  TIM1_CCMR3_CC3S1 = (1)
                           000000   820  TIM1_CCMR3_CC3S0 = (0)
                                    821 
                                    822 ; Capture/Compare Mode Register 3 - channel configured in input
                           000007   823  TIM1_CCMR3_IC3F3 = (7)
                           000006   824  TIM1_CCMR3_IC3F2 = (6)
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 18.
Hexadecimal [24-Bits]



                           000005   825  TIM1_CCMR3_IC3F1 = (5)
                           000004   826  TIM1_CCMR3_IC3F0 = (4)
                           000003   827  TIM1_CCMR3_IC3PSC1 = (3)
                           000002   828  TIM1_CCMR3_IC3PSC0 = (2)
                                    829 ;  TIM1_CCMR3_CC3S1 = (1)
                           000000   830  TIM1_CCMR3_CC3S0 = (0)
                                    831 
                                    832 ; Capture/Compare Mode Register 4 - channel configured in output
                           000007   833  TIM1_CCMR4_OC4CE = (7)
                           000006   834  TIM1_CCMR4_OC4M2 = (6)
                           000005   835  TIM1_CCMR4_OC4M1 = (5)
                           000004   836  TIM1_CCMR4_OC4M0 = (4)
                           000004   837  TIM1_CCMR4_OCMODE = (4)
                           000003   838  TIM1_CCMR4_OC4PE = (3)
                           000002   839  TIM1_CCMR4_OC4FE = (2)
                           000001   840  TIM1_CCMR4_CC4S1 = (1)
                           000000   841  TIM1_CCMR4_CC4S0 = (0)
                                    842 
                                    843 ; Capture/Compare Mode Register 4 - channel configured in input
                           000007   844  TIM1_CCMR4_IC4F3 = (7)
                           000006   845  TIM1_CCMR4_IC4F2 = (6)
                           000005   846  TIM1_CCMR4_IC4F1 = (5)
                           000004   847  TIM1_CCMR4_IC4F0 = (4)
                           000003   848  TIM1_CCMR4_IC4PSC1 = (3)
                           000002   849  TIM1_CCMR4_IC4PSC0 = (2)
                                    850 ;  TIM1_CCMR4_CC4S1 = (1)
                           000000   851  TIM1_CCMR4_CC4S0 = (0)
                                    852 
                                    853 ; Timer 2 - 16-bit timer
                           005300   854  TIM2_CR1  = (0x5300)
                           005301   855  TIM2_IER  = (0x5301)
                           005302   856  TIM2_SR1  = (0x5302)
                           005303   857  TIM2_SR2  = (0x5303)
                           005304   858  TIM2_EGR  = (0x5304)
                           005305   859  TIM2_CCMR1  = (0x5305)
                           005306   860  TIM2_CCMR2  = (0x5306)
                           005307   861  TIM2_CCMR3  = (0x5307)
                           005308   862  TIM2_CCER1  = (0x5308)
                           005309   863  TIM2_CCER2  = (0x5309)
                           00530A   864  TIM2_CNTRH  = (0x530A)
                           00530B   865  TIM2_CNTRL  = (0x530B)
                           00530C   866  TIM2_PSCR  = (0x530C)
                           00530D   867  TIM2_ARRH  = (0x530D)
                           00530E   868  TIM2_ARRL  = (0x530E)
                           00530F   869  TIM2_CCR1H  = (0x530F)
                           005310   870  TIM2_CCR1L  = (0x5310)
                           005311   871  TIM2_CCR2H  = (0x5311)
                           005312   872  TIM2_CCR2L  = (0x5312)
                           005313   873  TIM2_CCR3H  = (0x5313)
                           005314   874  TIM2_CCR3L  = (0x5314)
                                    875 
                                    876 ; TIM2_CR1 bitfields
                           000000   877  TIM2_CR1_CEN=(0) ; Counter enable
                           000001   878  TIM2_CR1_UDIS=(1) ; Update disable
                           000002   879  TIM2_CR1_URS=(2) ; Update request source
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 19.
Hexadecimal [24-Bits]



                           000003   880  TIM2_CR1_OPM=(3) ; One-pulse mode
                           000007   881  TIM2_CR1_ARPE=(7) ; Auto-reload preload enable
                                    882 
                                    883 ; TIMER2_CCMR bitfields 
                           000000   884  TIM2_CCMR_CCS=(0) ; input/output select
                           000003   885  TIM2_CCMR_OCPE=(3) ; preload enable
                           000004   886  TIM2_CCMR_OCM=(4)  ; output compare mode 
                                    887 
                                    888 ; TIMER2_CCER1 bitfields
                           000000   889  TIM2_CCER1_CC1E=(0)
                           000001   890  TIM2_CCER1_CC1P=(1)
                           000004   891  TIM2_CCER1_CC2E=(4)
                           000005   892  TIM2_CCER1_CC2P=(5)
                                    893 
                                    894 ; TIMER2_EGR bitfields
                           000000   895  TIM2_EGR_UG=(0) ; update generation
                           000001   896  TIM2_EGR_CC1G=(1) ; Capture/compare 1 generation
                           000002   897  TIM2_EGR_CC2G=(2) ; Capture/compare 2 generation
                           000003   898  TIM2_EGR_CC3G=(3) ; Capture/compare 3 generation
                           000006   899  TIM2_EGR_TG=(6); Trigger generation
                                    900 
                                    901 ; Timer 3
                           005320   902  TIM3_CR1  = (0x5320)
                           005321   903  TIM3_IER  = (0x5321)
                           005322   904  TIM3_SR1  = (0x5322)
                           005323   905  TIM3_SR2  = (0x5323)
                           005324   906  TIM3_EGR  = (0x5324)
                           005325   907  TIM3_CCMR1  = (0x5325)
                           005326   908  TIM3_CCMR2  = (0x5326)
                           005327   909  TIM3_CCER1  = (0x5327)
                           005328   910  TIM3_CNTRH  = (0x5328)
                           005329   911  TIM3_CNTRL  = (0x5329)
                           00532A   912  TIM3_PSCR  = (0x532A)
                           00532B   913  TIM3_ARRH  = (0x532B)
                           00532C   914  TIM3_ARRL  = (0x532C)
                           00532D   915  TIM3_CCR1H  = (0x532D)
                           00532E   916  TIM3_CCR1L  = (0x532E)
                           00532F   917  TIM3_CCR2H  = (0x532F)
                           005330   918  TIM3_CCR2L  = (0x5330)
                                    919 
                                    920 ; TIM3_CR1  fields
                           000000   921  TIM3_CR1_CEN = (0)
                           000001   922  TIM3_CR1_UDIS = (1)
                           000002   923  TIM3_CR1_URS = (2)
                           000003   924  TIM3_CR1_OPM = (3)
                           000007   925  TIM3_CR1_ARPE = (7)
                                    926 ; TIM3_CCR2  fields
                           000000   927  TIM3_CCMR2_CC2S_POS = (0)
                           000003   928  TIM3_CCMR2_OC2PE_POS = (3)
                           000004   929  TIM3_CCMR2_OC2M_POS = (4)  
                                    930 ; TIM3_CCER1 fields
                           000000   931  TIM3_CCER1_CC1E = (0)
                           000001   932  TIM3_CCER1_CC1P = (1)
                           000004   933  TIM3_CCER1_CC2E = (4)
                           000005   934  TIM3_CCER1_CC2P = (5)
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 20.
Hexadecimal [24-Bits]



                                    935 ; TIM3_CCER2 fields
                           000000   936  TIM3_CCER2_CC3E = (0)
                           000001   937  TIM3_CCER2_CC3P = (1)
                                    938 
                                    939 ; Timer 4
                           005340   940  TIM4_CR1  = (0x5340)
                           005341   941  TIM4_IER  = (0x5341)
                           005342   942  TIM4_SR  = (0x5342)
                           005343   943  TIM4_EGR  = (0x5343)
                           005344   944  TIM4_CNTR  = (0x5344)
                           005345   945  TIM4_PSCR  = (0x5345)
                           005346   946  TIM4_ARR  = (0x5346)
                                    947 
                                    948 ; Timer 4 bitmasks
                                    949 
                           000007   950  TIM4_CR1_ARPE = (7)
                           000003   951  TIM4_CR1_OPM = (3)
                           000002   952  TIM4_CR1_URS = (2)
                           000001   953  TIM4_CR1_UDIS = (1)
                           000000   954  TIM4_CR1_CEN = (0)
                                    955 
                           000000   956  TIM4_IER_UIE = (0)
                                    957 
                           000000   958  TIM4_SR_UIF = (0)
                                    959 
                           000000   960  TIM4_EGR_UG = (0)
                                    961 
                           000002   962  TIM4_PSCR_PSC2 = (2)
                           000001   963  TIM4_PSCR_PSC1 = (1)
                           000000   964  TIM4_PSCR_PSC0 = (0)
                                    965 
                           000000   966  TIM4_PSCR_1 = 0
                           000001   967  TIM4_PSCR_2 = 1
                           000002   968  TIM4_PSCR_4 = 2
                           000003   969  TIM4_PSCR_8 = 3
                           000004   970  TIM4_PSCR_16 = 4
                           000005   971  TIM4_PSCR_32 = 5
                           000006   972  TIM4_PSCR_64 = 6
                           000007   973  TIM4_PSCR_128 = 7
                                    974 
                                    975 ; ADC2
                           005400   976  ADC_CSR  = (0x5400)
                           005401   977  ADC_CR1  = (0x5401)
                           005402   978  ADC_CR2  = (0x5402)
                           005403   979  ADC_CR3  = (0x5403)
                           005404   980  ADC_DRH  = (0x5404)
                           005405   981  ADC_DRL  = (0x5405)
                           005406   982  ADC_TDRH  = (0x5406)
                           005407   983  ADC_TDRL  = (0x5407)
                                    984  
                                    985 ; ADC bitmasks
                                    986 
                           000007   987  ADC_CSR_EOC = (7)
                           000006   988  ADC_CSR_AWD = (6)
                           000005   989  ADC_CSR_EOCIE = (5)
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 21.
Hexadecimal [24-Bits]



                           000004   990  ADC_CSR_AWDIE = (4)
                           000003   991  ADC_CSR_CH3 = (3)
                           000002   992  ADC_CSR_CH2 = (2)
                           000001   993  ADC_CSR_CH1 = (1)
                           000000   994  ADC_CSR_CH0 = (0)
                                    995 
                           000006   996  ADC_CR1_SPSEL2 = (6)
                           000005   997  ADC_CR1_SPSEL1 = (5)
                           000004   998  ADC_CR1_SPSEL0 = (4)
                           000001   999  ADC_CR1_CONT = (1)
                           000000  1000  ADC_CR1_ADON = (0)
                                   1001 
                           000006  1002  ADC_CR2_EXTTRIG = (6)
                           000005  1003  ADC_CR2_EXTSEL1 = (5)
                           000004  1004  ADC_CR2_EXTSEL0 = (4)
                           000003  1005  ADC_CR2_ALIGN = (3)
                           000001  1006  ADC_CR2_SCAN = (1)
                                   1007 
                           000007  1008  ADC_CR3_DBUF = (7)
                           000006  1009  ADC_CR3_DRH = (6)
                                   1010 
                                   1011 ; beCAN
                           005420  1012  CAN_MCR = (0x5420)
                           005421  1013  CAN_MSR = (0x5421)
                           005422  1014  CAN_TSR = (0x5422)
                           005423  1015  CAN_TPR = (0x5423)
                           005424  1016  CAN_RFR = (0x5424)
                           005425  1017  CAN_IER = (0x5425)
                           005426  1018  CAN_DGR = (0x5426)
                           005427  1019  CAN_FPSR = (0x5427)
                           005428  1020  CAN_P0 = (0x5428)
                           005429  1021  CAN_P1 = (0x5429)
                           00542A  1022  CAN_P2 = (0x542A)
                           00542B  1023  CAN_P3 = (0x542B)
                           00542C  1024  CAN_P4 = (0x542C)
                           00542D  1025  CAN_P5 = (0x542D)
                           00542E  1026  CAN_P6 = (0x542E)
                           00542F  1027  CAN_P7 = (0x542F)
                           005430  1028  CAN_P8 = (0x5430)
                           005431  1029  CAN_P9 = (0x5431)
                           005432  1030  CAN_PA = (0x5432)
                           005433  1031  CAN_PB = (0x5433)
                           005434  1032  CAN_PC = (0x5434)
                           005435  1033  CAN_PD = (0x5435)
                           005436  1034  CAN_PE = (0x5436)
                           005437  1035  CAN_PF = (0x5437)
                                   1036 
                                   1037 
                                   1038 ; CPU
                           007F00  1039  CPU_A  = (0x7F00)
                           007F01  1040  CPU_PCE  = (0x7F01)
                           007F02  1041  CPU_PCH  = (0x7F02)
                           007F03  1042  CPU_PCL  = (0x7F03)
                           007F04  1043  CPU_XH  = (0x7F04)
                           007F05  1044  CPU_XL  = (0x7F05)
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 22.
Hexadecimal [24-Bits]



                           007F06  1045  CPU_YH  = (0x7F06)
                           007F07  1046  CPU_YL  = (0x7F07)
                           007F08  1047  CPU_SPH  = (0x7F08)
                           007F09  1048  CPU_SPL   = (0x7F09)
                           007F0A  1049  CPU_CCR   = (0x7F0A)
                                   1050 
                                   1051 ; global configuration register
                           007F60  1052  CFG_GCR   = (0x7F60)
                           000001  1053  CFG_GCR_AL = 1
                           000000  1054  CFG_GCR_SWIM = 0
                                   1055 
                                   1056 ; interrupt software priority 
                           007F70  1057  ITC_SPR1   = (0x7F70) ; (0..3) 0->resreved,AWU..EXT0 
                           007F71  1058  ITC_SPR2   = (0x7F71) ; (4..7) EXT1..EXT4 RX 
                           007F72  1059  ITC_SPR3   = (0x7F72) ; (8..11) beCAN RX..TIM1 UPDT/OVR  
                           007F73  1060  ITC_SPR4   = (0x7F73) ; (12..15) TIM1 CAP/CMP .. TIM3 UPDT/OVR 
                           007F74  1061  ITC_SPR5   = (0x7F74) ; (16..19) TIM3 CAP/CMP..I2C  
                           007F75  1062  ITC_SPR6   = (0x7F75) ; (20..23) UART3 TX..TIM4 CAP/OVR 
                           007F76  1063  ITC_SPR7   = (0x7F76) ; (24..29) FLASH WR..
                           007F77  1064  ITC_SPR8   = (0x7F77) ; (30..32) ..
                                   1065 
                           000001  1066 ITC_SPR_LEVEL1=1 
                           000000  1067 ITC_SPR_LEVEL2=0
                           000003  1068 ITC_SPR_LEVEL3=3 
                                   1069 
                                   1070 ; SWIM, control and status register
                           007F80  1071  SWIM_CSR   = (0x7F80)
                                   1072 ; debug registers
                           007F90  1073  DM_BK1RE   = (0x7F90)
                           007F91  1074  DM_BK1RH   = (0x7F91)
                           007F92  1075  DM_BK1RL   = (0x7F92)
                           007F93  1076  DM_BK2RE   = (0x7F93)
                           007F94  1077  DM_BK2RH   = (0x7F94)
                           007F95  1078  DM_BK2RL   = (0x7F95)
                           007F96  1079  DM_CR1   = (0x7F96)
                           007F97  1080  DM_CR2   = (0x7F97)
                           007F98  1081  DM_CSR1   = (0x7F98)
                           007F99  1082  DM_CSR2   = (0x7F99)
                           007F9A  1083  DM_ENFCTR   = (0x7F9A)
                                   1084 
                                   1085 ; Interrupt Numbers
                           000000  1086  INT_TLI = 0
                           000001  1087  INT_AWU = 1
                           000002  1088  INT_CLK = 2
                           000003  1089  INT_EXTI0 = 3
                           000004  1090  INT_EXTI1 = 4
                           000005  1091  INT_EXTI2 = 5
                           000006  1092  INT_EXTI3 = 6
                           000007  1093  INT_EXTI4 = 7
                           000008  1094  INT_CAN_RX = 8
                           000009  1095  INT_CAN_TX = 9
                           00000A  1096  INT_SPI = 10
                           00000B  1097  INT_TIM1_OVF = 11
                           00000C  1098  INT_TIM1_CCM = 12
                           00000D  1099  INT_TIM2_OVF = 13
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 23.
Hexadecimal [24-Bits]



                           00000E  1100  INT_TIM2_CCM = 14
                           00000F  1101  INT_TIM3_OVF = 15
                           000010  1102  INT_TIM3_CCM = 16
                           000011  1103  INT_UART1_TX_COMPLETED = 17
                           000012  1104  INT_AUART1_RX_FULL = 18
                           000013  1105  INT_I2C = 19
                           000014  1106  INT_UART3_TX_COMPLETED = 20
                           000015  1107  INT_UART3_RX_FULL = 21
                           000016  1108  INT_ADC2 = 22
                           000017  1109  INT_TIM4_OVF = 23
                           000018  1110  INT_FLASH = 24
                                   1111 
                                   1112 ; Interrupt Vectors
                           008000  1113  INT_VECTOR_RESET = 0x8000
                           008004  1114  INT_VECTOR_TRAP = 0x8004
                           008008  1115  INT_VECTOR_TLI = 0x8008
                           00800C  1116  INT_VECTOR_AWU = 0x800C
                           008010  1117  INT_VECTOR_CLK = 0x8010
                           008014  1118  INT_VECTOR_EXTI0 = 0x8014
                           008018  1119  INT_VECTOR_EXTI1 = 0x8018
                           00801C  1120  INT_VECTOR_EXTI2 = 0x801C
                           008020  1121  INT_VECTOR_EXTI3 = 0x8020
                           008024  1122  INT_VECTOR_EXTI4 = 0x8024
                           008028  1123  INT_VECTOR_CAN_RX = 0x8028
                           00802C  1124  INT_VECTOR_CAN_TX = 0x802c
                           008030  1125  INT_VECTOR_SPI = 0x8030
                           008034  1126  INT_VECTOR_TIM1_OVF = 0x8034
                           008038  1127  INT_VECTOR_TIM1_CCM = 0x8038
                           00803C  1128  INT_VECTOR_TIM2_OVF = 0x803C
                           008040  1129  INT_VECTOR_TIM2_CCM = 0x8040
                           008044  1130  INT_VECTOR_TIM3_OVF = 0x8044
                           008048  1131  INT_VECTOR_TIM3_CCM = 0x8048
                           00804C  1132  INT_VECTOR_UART1_TX_COMPLETED = 0x804c
                           008050  1133  INT_VECTOR_UART1_RX_FULL = 0x8050
                           008054  1134  INT_VECTOR_I2C = 0x8054
                           008058  1135  INT_VECTOR_UART3_TX_COMPLETED = 0x8058
                           00805C  1136  INT_VECTOR_UART3_RX_FULL = 0x805C
                           008060  1137  INT_VECTOR_ADC2 = 0x8060
                           008064  1138  INT_VECTOR_TIM4_OVF = 0x8064
                           008068  1139  INT_VECTOR_FLASH = 0x8068
                                   1140 
                                   1141 ; Condition code register bits
                           000007  1142 CC_V = 7  ; overflow flag 
                           000005  1143 CC_I1= 5  ; interrupt bit 1
                           000004  1144 CC_H = 4  ; half carry 
                           000003  1145 CC_I0 = 3 ; interrupt bit 0
                           000002  1146 CC_N = 2 ;  negative flag 
                           000001  1147 CC_Z = 1 ;  zero flag  
                           000000  1148 CC_C = 0 ; carry bit 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 24.
Hexadecimal [24-Bits]



                                     28     .include "inc/nucleo_8s207.inc"
                                      1 ;;
                                      2 ; Copyright Jacques Deschênes 2019 
                                      3 ; This file is part of MONA 
                                      4 ;
                                      5 ;     MONA is free software: you can redistribute it and/or modify
                                      6 ;     it under the terms of the GNU General Public License as published by
                                      7 ;     the Free Software Foundation, either version 3 of the License, or
                                      8 ;     (at your option) any later version.
                                      9 ;
                                     10 ;     MONA is distributed in the hope that it will be useful,
                                     11 ;     but WITHOUT ANY WARRANTY; without even the implied warranty of
                                     12 ;     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
                                     13 ;     GNU General Public License for more details.
                                     14 ;
                                     15 ;     You should have received a copy of the GNU General Public License
                                     16 ;     along with MONA.  If not, see <http://www.gnu.org/licenses/>.
                                     17 ;;
                                     18 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                                     19 ; NUCLEO-8S208RB board specific definitions
                                     20 ; Date: 2019/10/29
                                     21 ; author: Jacques Deschênes, copyright 2018,2019
                                     22 ; licence: GPLv3
                                     23 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                                     24 
                                     25 ; mcu on board is stm8s207k8
                                     26 
                                     27 ; crystal on board is 8Mhz
                                     28 ; st-link crystal 
                           7A1200    29 FHSE = 8000000
                                     30 
                                     31 ; LD3 is user LED
                                     32 ; connected to PC5 via Q2
                           00500A    33 LED_PORT = PC_BASE ;port C
                           000005    34 LED_BIT = 5
                           000020    35 LED_MASK = (1<<LED_BIT) ;bit 5 mask
                                     36 
                                     37 
                                     38 ; user interface UART via STLINK (T_VCP)
                                     39 
                           000002    40 UART=UART3 
                                     41 ; port used by  UART3 
                           00500A    42 UART_PORT_ODR=PC_ODR 
                           00500C    43 UART_PORT_DDR=PC_DDR 
                           00500B    44 UART_PORT_IDR=PC_IDR 
                           00500D    45 UART_PORT_CR1=PC_CR1 
                           00500E    46 UART_PORT_CR2=PC_CR2 
                                     47 
                                     48 ; clock enable bit 
                           000003    49 UART_PCKEN=CLK_PCKENR1_UART3 
                                     50 
                                     51 ; uart3 registers 
                           005240    52 UART_SR=UART3_SR
                           005241    53 UART_DR=UART3_DR
                           005242    54 UART_BRR1=UART3_BRR1
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 25.
Hexadecimal [24-Bits]



                           005243    55 UART_BRR2=UART3_BRR2
                           005244    56 UART_CR1=UART3_CR1
                           005245    57 UART_CR2=UART3_CR2
                                     58 
                                     59 ; TX, RX pin
                           000005    60 UART_TX_PIN=UART3_TX_PIN 
                           000006    61 UART_RX_PIN=UART3_RX_PIN 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 26.
Hexadecimal [24-Bits]



                                     29 	.include "inc/ascii.inc"
                                      1 ;------------------------------------------------------
                                      2 ;   ASCII code list  with symbolic names 
                                      3 ;-------------------------------------------------------
                                      4 
                                      5 ;-------------------------------------------------------
                                      6 ;     ASCII control  values
                                      7 ;     CTRL_x   are VT100 keyboard values  
                                      8 ; REF: https://en.wikipedia.org/wiki/ASCII    
                                      9 ;-------------------------------------------------------
                           000000    10 		NUL = 0  ; null 
                           000001    11 		CTRL_A = 1
                           000001    12 		SOH=CTRL_A  ; start of heading 
                           000002    13 		CTRL_B = 2
                           000002    14 		STX=CTRL_B  ; start of text 
                           000003    15 		CTRL_C = 3
                           000003    16 		ETX=CTRL_C  ; end of text 
                           000004    17 		CTRL_D = 4
                           000004    18 		EOT=CTRL_D  ; end of transmission 
                           000005    19 		CTRL_E = 5
                           000005    20 		ENQ=CTRL_E  ; enquery 
                           000006    21 		CTRL_F = 6
                           000006    22 		ACK=CTRL_F  ; acknowledge
                           000007    23 		CTRL_G = 7
                           000007    24         BELL = 7    ; vt100 terminal generate a sound.
                           000008    25 		CTRL_H = 8  
                           000008    26 		BS = 8     ; back space 
                           000009    27         CTRL_I = 9
                           000009    28     	TAB = 9     ; horizontal tabulation
                           00000A    29         CTRL_J = 10 
                           00000A    30 		LF = 10     ; line feed
                           00000B    31 		CTRL_K = 11
                           00000B    32         VT = 11     ; vertical tabulation 
                           00000C    33 		CTRL_L = 12
                           00000C    34         FF = 12      ; new page
                           00000D    35 		CTRL_M = 13
                           00000D    36 		CR = 13      ; carriage return 
                           00000E    37 		CTRL_N = 14
                           00000E    38 		SO=CTRL_N    ; shift out 
                           00000F    39 		CTRL_O = 15
                           00000F    40 		SI=CTRL_O    ; shift in 
                           000010    41 		CTRL_P = 16
                           000010    42 		DLE=CTRL_P   ; data link escape 
                           000011    43 		CTRL_Q = 17
                           000011    44 		DC1=CTRL_Q   ; device control 1 
                           000011    45 		XON=DC1 
                           000012    46 		CTRL_R = 18
                           000012    47 		DC2=CTRL_R   ; device control 2 
                           000013    48 		CTRL_S = 19
                           000013    49 		DC3=CTRL_S   ; device control 3
                           000013    50 		XOFF=DC3 
                           000014    51 		CTRL_T = 20
                           000014    52 		DC4=CTRL_T   ; device control 4 
                           000015    53 		CTRL_U = 21
                           000015    54 		NAK=CTRL_U   ; negative acknowledge
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 27.
Hexadecimal [24-Bits]



                           000016    55 		CTRL_V = 22
                           000016    56 		SYN=CTRL_V   ; synchronous idle 
                           000017    57 		CTRL_W = 23
                           000017    58 		ETB=CTRL_W   ; end of transmission block
                           000018    59 		CTRL_X = 24
                           000018    60 		CAN=CTRL_X   ; cancel 
                           000019    61 		CTRL_Y = 25
                           000019    62 		EM=CTRL_Y    ; end of medium
                           00001A    63 		CTRL_Z = 26
                           00001A    64 		SUB=CTRL_Z   ; substitute 
                           00001A    65 		EOF=SUB      ; end of text file in MSDOS 
                           00001B    66 		ESC = 27     ; escape 
                           00001C    67 		FS=28        ; file separator 
                           00001D    68 		GS=29        ; group separator 
                           00001E    69 		RS=30		 ; record separator 
                           00001F    70 		US=31 		 ; unit separator 
                           000020    71 		SPACE = 32   ; ' ' 
                           000021    72 		EXCLA	=	33  ; '!'
                           000022    73 		DQUOT	=	34  ; '"'	
                           000023    74 		SHARP =	35  ; '#'
                           000024    75 		DOLLR	=	36  ; '$'
                           000025    76 		PRCNT	=	37  ; '%'
                           000026    77 		AMP	=	38  ; '&'
                           000027    78 		TICK	=	39  ; '\''
                           000028    79 		LPAR	=	40  ; '('
                           000029    80 		RPAR  =	41  ; ')'
                           00002A    81 		STAR  =	42  ; '*'
                           00002B    82 		PLUS	=	43  ; '+'
                           00002C    83 		COMMA = 44  
                           00002D    84 		DASH  =	45  ; '-'
                           00002E    85 		DOT	=	46  ; '.'
                           00002F    86 		SLASH =	47  ; '/'
                           000030    87 		ZERO =	48  ; '0'
                           000031    88 		ONE	=	49  ; '1'
                           000032    89 		TWO 	=	50  ; '2'
                           000033    90 		THREE	=	51  ; '3'	
                           000034    91 		FOUR	=	52  ; '4'
                           000035    92 		FIVE	=	53  ; '5'
                           000036    93 		SIX	=	54  ; '6'
                           000037    94 		SEVEN	=	55  ; '7'
                           000038    95 		EIGHT	=	56  ; '8'
                           000039    96 		NINE	=	57  ; '9'
                           00003A    97 		COLON = 58 
                           00003B    98 		SEMIC = 59  
                           00003C    99 		LT	=	60  ; '<'
                           00003D   100 		EQUAL =	61  ; '='
                           00003E   101 		GT	=	62  ; '>'
                           00003F   102 		QUST	=	63  ; '?'
                           000040   103 		AROB	=	64  ; '@'
                           000041   104 		AU	=	65  ; 'A'
                           000042   105 		BU	=	66  ; 'B'
                           000043   106 		CU	=	67  ; 'C'
                           000044   107 		DU	=	68  ; 'D'
                           000045   108 		EU	=	69  ; 'E'
                           000046   109 		FU	=	70  ; 'F'
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 28.
Hexadecimal [24-Bits]



                           000047   110 		GU	=	71  ; 'G'
                           000048   111 		HU	=	72  ; 'H'
                           000049   112 		IU	=	73  ; 'I'
                           00004A   113 		JU	=	74  ; 'J'
                           00004B   114 		KU	=	75  ; 'K'
                           00004C   115 		LU	=	76  ; 'L'
                           00004D   116 		MU	=	77  ; 'M'
                           00004E   117 		NU	=	78  ; 'N'
                           00004F   118 		OU	=	79  ; 'O'
                           000050   119 		PU	=	80  ; 'P'
                           000051   120 		QU	=	81  ; 'Q'
                           000052   121 		RU	=	82  ; 'R'
                           000053   122 		SU	=	83  ; 'S'
                           000054   123 		TU	=	84  ; 'T'
                           000055   124 		UU	=	85  ; 'U'
                           000056   125 		VU	=	86  ; 'V'
                           000057   126 		WU	=	87  ; 'W'
                           000058   127 		XU	=	88  ; 'X'
                           000059   128 		YU	=	89  ; 'Y'
                           00005A   129 		ZU	=	90  ; 'Z'
                           00005B   130 		LBRK	=	91  ; '['
                           00005C   131 		BSLA	=	92  ; '\\'
                           00005D   132 		RBRK	=	93  ; ']'
                           00005E   133 		CIRC	=	94  ; '^'
                           00005F   134 		UNDR	=	95  ; '_'
                           000060   135 		ACUT	=	96  ; '`'
                           000061   136 		AL	=	97  ; 'a'
                           000062   137 		BL	=	98  ; 'b'
                           000063   138 		CL	=	99  ; 'c'
                           000064   139 		DL	=	100 ; 'd'
                           000065   140 		EL	=	101 ; 'e'
                           000066   141 		FL	=	102 ; 'f'
                           000067   142 		GL	=	103 ; 'g'
                           000068   143 		HL	=	104 ; 'h'
                           000069   144 		IL	=	105 ; 'i'
                           00006A   145 		JL	=	106 ; 'j'
                           00006B   146 		KL	=	107 ; 'k'
                           00006C   147 		LL	=	108 ; 'l'
                           00006D   148 		ML	=	109 ; 'm'
                           00006E   149 		NL	=	110 ; 'n'
                           00006F   150 		OL	=	111 ; 'o'
                           000070   151 		PL	=	112 ; 'p'
                           000071   152 		QL	=	113 ; 'q'
                           000072   153 		RL	=	114 ; 'r'
                           000073   154 		SL	=	115 ; 's'
                           000074   155 		TL	=	116 ; 't'
                           000075   156 		UL	=	117 ; 'u'
                           000076   157 		VL	=	118 ; 'v'
                           000077   158 		WL	=	119 ; 'w'
                           000078   159 		XL	=	120 ; 'x'
                           000079   160 		YL	=	121 ; 'y'
                           00007A   161 		ZL	=	122 ; 'z'
                           00007B   162 		LBRC	=	123 ; '{'
                           00007C   163 		PIPE	=	124 ; '|'
                           00007D   164 		RBRC	=	125 ; '}'
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 29.
Hexadecimal [24-Bits]



                           00007E   165 		TILD	=	126 ; '~'
                           00007F   166 		DEL	=	127 ; DELETE	
                                    167 	
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 30.
Hexadecimal [24-Bits]



                                     30 	.include "inc/gen_macros.inc" 
                                      1 ;;
                                      2 ; Copyright Jacques Deschênes 2019 
                                      3 ; This file is part of STM8_NUCLEO 
                                      4 ;
                                      5 ;     STM8_NUCLEO is free software: you can redistribute it and/or modify
                                      6 ;     it under the terms of the GNU General Public License as published by
                                      7 ;     the Free Software Foundation, either version 3 of the License, or
                                      8 ;     (at your option) any later version.
                                      9 ;
                                     10 ;     STM8_NUCLEO is distributed in the hope that it will be useful,
                                     11 ;     but WITHOUT ANY WARRANTY; without even the implied warranty of
                                     12 ;     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
                                     13 ;     GNU General Public License for more details.
                                     14 ;
                                     15 ;     You should have received a copy of the GNU General Public License
                                     16 ;     along with STM8_NUCLEO.  If not, see <http://www.gnu.org/licenses/>.
                                     17 ;;
                                     18 ;--------------------------------------
                                     19 ;   console Input/Output module
                                     20 ;   DATE: 2019-12-11
                                     21 ;    
                                     22 ;   General usage macros.   
                                     23 ;
                                     24 ;--------------------------------------
                                     25 
                                     26     ; reserve space on stack
                                     27     ; for local variables
                                     28     .macro _vars n 
                                     29     sub sp,#n 
                                     30     .endm 
                                     31     
                                     32     ; free space on stack
                                     33     .macro _drop n 
                                     34     addw sp,#n 
                                     35     .endm
                                     36 
                                     37     ; declare ARG_OFS for arguments 
                                     38     ; displacement on stack. This 
                                     39     ; value depend on local variables 
                                     40     ; size.
                                     41     .macro _argofs n 
                                     42     ARG_OFS=2+n 
                                     43     .endm 
                                     44 
                                     45     ; declare a function argument 
                                     46     ; position relative to stack pointer 
                                     47     ; _argofs must be called before it.
                                     48     .macro _arg name ofs 
                                     49     name=ARG_OFS+ofs 
                                     50     .endm 
                                     51 
                                     52     ; software reset 
                                     53     .macro _swreset
                                     54     mov WWDG_CR,#0X80
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 31.
Hexadecimal [24-Bits]



                                     55     .endm 
                                     56 
                                     57     ; increment zero page variable 
                                     58     .macro _incz v 
                                     59     .byte 0x3c, v 
                                     60     .endm 
                                     61 
                                     62     ; decrement zero page variable 
                                     63     .macro _decz v 
                                     64     .byte 0x3a,v 
                                     65     .endm 
                                     66 
                                     67     ; clear zero page variable 
                                     68     .macro _clrz v 
                                     69     .byte 0x3f, v 
                                     70     .endm 
                                     71 
                                     72     ; load A zero page variable 
                                     73     .macro _ldaz v 
                                     74     .byte 0xb6,v 
                                     75     .endm 
                                     76 
                                     77     ; store A zero page variable 
                                     78     .macro _straz v 
                                     79     .byte 0xb7,v 
                                     80     .endm 
                                     81 
                                     82     ; tnz zero page variable 
                                     83     .macro _tnz v 
                                     84     .byte 0x3d,v 
                                     85     .endm 
                                     86 
                                     87     ; load x from variable in zero page 
                                     88     .macro _ldxz v 
                                     89     .byte 0xbe,v 
                                     90     .endm 
                                     91 
                                     92     ; load y from variable in zero page 
                                     93     .macro _ldyz v 
                                     94     .byte 0x90,0xbe,v 
                                     95     .endm 
                                     96 
                                     97     ; store x in zero page variable 
                                     98     .macro _strxz v 
                                     99     .byte 0xbf,v 
                                    100     .endm 
                                    101 
                                    102     ; store y in zero page variable 
                                    103     .macro _stryz v 
                                    104     .byte 0x90,0xbf,v 
                                    105     .endm 
                                    106 
                                    107     ;  increment 16 bits variable
                                    108     ;  use 10 bytes  
                                    109     .macro _incwz  v 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 32.
Hexadecimal [24-Bits]



                                    110         _incz v+1   ; 1 cy, 2 bytes 
                                    111         jrne .+4  ; 1|2 cy, 2 bytes 
                                    112         _incz v     ; 1 cy, 2 bytes  
                                    113     .endm ; 3 cy 
                                    114 
                                    115     ; xor op with zero page variable 
                                    116     .macro _xorz v 
                                    117     .byte 0xb8,v 
                                    118     .endm 
                                    119     
                                    120     ; move memory to memory in 0 page 
                                    121     .macro _movzz a1, a2 
                                    122     .byte 0x45,a2,a1 
                                    123     .endm 
                                    124 
                                    125     ; check point 
                                    126     ; for debugging help 
                                    127     ; display a character 
                                    128     .macro _cp ch 
                                    129     push a 
                                    130     ld a,#ch 
                                    131     call uart_putc 
                                    132     pop a 
                                    133     .endm 
                                    134     
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 33.
Hexadecimal [24-Bits]



                                     31 	.include "app_macros.inc" 
                                      1 ;;
                                      2 ; Copyright Jacques Deschênes 2019 
                                      3 ; This file is part of STM8_NUCLEO 
                                      4 ;
                                      5 ;     STM8_NUCLEO is free software: you can redistribute it and/or modify
                                      6 ;     it under the terms of the GNU General Public License as published by
                                      7 ;     the Free Software Foundation, either version 3 of the License, or
                                      8 ;     (at your option) any later version.
                                      9 ;
                                     10 ;     STM8_NUCLEO is distributed in the hope that it will be useful,
                                     11 ;     but WITHOUT ANY WARRANTY; without even the implied warranty of
                                     12 ;     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
                                     13 ;     GNU General Public License for more details.
                                     14 ;
                                     15 ;     You should have received a copy of the GNU General Public License
                                     16 ;     along with STM8_NUCLEO.  If not, see <http://www.gnu.org/licenses/>.
                                     17 ;;
                                     18 ;--------------------------------------
                           000004    19         TAB_WIDTH=4 ; default tabulation width 
                           0000FF    20         EOF=0xff ; end of file marker 
                           00000F    21         NLEN_MASK=0xf  ; mask to extract name len 
                           0000F0    22         KW_TYPE_MASK=0xf0 ; mask to extract keyword type 
                                     23 
                                     24 
                           000080    25 	STACK_SIZE=128
                           0017FF    26 	STACK_EMPTY=RAM_SIZE-1  
                                     27 	
                                     28 
                                     29 ; external options switches 
                                     30 
                                     31 ; select local  echo option 
                                     32 ; 0 no echo | 1 local echo 
                           005010    33 ECHO_PORT=PD_IDR 
                           000000    34 ECHO_BIT=0 
                                     35 
                                     36 ; select device ID 
                           005006    37 DEV_ID_PORT=PB_IDR 
                           000002    38 DEV_ID0_BIT=2 
                           000003    39 DEV_ID1_BIT=3
                                     40 ; default device ID 
                           00000C    41 DEV_ID=3<<2
                                     42 
                                     43 ;--------------------------------------
                                     44 ;   assembler flags 
                                     45 ;-------------------------------------
                                     46 
                                     47 ;------------------------------------
                                     48 ;  board user LED control macros 
                                     49 ;------------------------------------
                                     50 
                                     51     .macro _led_on 
                                     52         bset LED_PORT,#LED_BIT 
                                     53     .endm 
                                     54 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 34.
Hexadecimal [24-Bits]



                                     55     .macro _led_off 
                                     56         bres LED_PORT,#LED_BIT 
                                     57     .endm 
                                     58 
                                     59     .macro _led_toggle 
                                     60         bcpl LED_PORT,#LED_BIT 
                                     61     .endm 
                                     62 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 35.
Hexadecimal [24-Bits]



                                     32 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 36.
Hexadecimal [24-Bits]



                                     31 
                           000080    32 STACK_SIZE=128   
                                     33 ;;-----------------------------------
                                     34     .area SSEG (ABS)
                                     35 ;; working buffers and stack at end of RAM. 	
                                     36 ;;-----------------------------------
      001780                         37     .org RAM_SIZE-STACK_SIZE
      001780                         38 stack_full:: .ds STACK_SIZE   ; control stack full 
      001800                         39 stack_unf: ; stack underflow ; RAM end +1 -> 0x1800
                                     40 
                                     41 
                                     42 ;;--------------------------------------
                                     43     .area HOME 
                                     44 ;; interrupt vector table at 0x8000
                                     45 ;;--------------------------------------
                                     46 
      008000 82 00 80 EE             47     int cold_start			; RESET vector 
      008004 82 00 80 81             48 	int NonHandledInterrupt ; trap instruction 
      008008 82 00 80 81             49 	int NonHandledInterrupt ;int0 TLI   external top level interrupt
      00800C 82 00 80 81             50 	int NonHandledInterrupt ;int1 AWU   auto wake up from halt
      008010 82 00 80 81             51 	int NonHandledInterrupt ;int2 CLK   clock controller
      008014 82 00 80 81             52 	int NonHandledInterrupt ;int3 EXTI0 gpio A external interrupts
      008018 82 00 82 D9             53 	int ps2_intr_handler    ;int4 EXTI1 gpio B external interrupts
      00801C 82 00 80 81             54 	int NonHandledInterrupt ;int5 EXTI2 gpio C external interrupts
      008020 82 00 80 81             55 	int NonHandledInterrupt ;int6 EXTI3 gpio D external interrupts
      008024 82 00 80 81             56 	int NonHandledInterrupt ;int7 EXTI4 gpio E external interrupts
      008028 82 00 80 81             57 	int NonHandledInterrupt ;int8 beCAN RX interrupt
      00802C 82 00 80 81             58 	int NonHandledInterrupt ;int9 beCAN TX/ER/SC interrupt
      008030 82 00 80 81             59 	int NonHandledInterrupt ;int10 SPI End of transfer
      008034 82 00 87 5F             60 	int ntsc_sync_interrupt ;int11 TIM1 update/overflow/underflow/trigger/break
      008038 82 00 88 12             61 	int ntsc_video_interrupt ; int12 TIM1 capture/compare
      00803C 82 00 80 81             62 	int NonHandledInterrupt ;int13 TIM2 update /overflow
      008040 82 00 80 81             63 	int NonHandledInterrupt ;int14 TIM2 capture/compare
      008044 82 00 80 81             64 	int NonHandledInterrupt ;int15 TIM3 Update/overflow
      008048 82 00 80 81             65 	int NonHandledInterrupt ;int16 TIM3 Capture/compare
      00804C 82 00 80 81             66 	int NonHandledInterrupt ;int17 UART1 TX completed
      008050 82 00 80 81             67 	int NonHandledInterrupt ;int18 UART1 RX full 
      008054 82 00 80 81             68 	int NonHandledInterrupt ;int19 I2C 
      008058 82 00 80 81             69 	int NonHandledInterrupt ;int20 UART3 TX completed
      00805C 82 00 8D BC             70 	int UartRxHandler 		;int21 UART3 RX full
      008060 82 00 80 81             71 	int NonHandledInterrupt ;int22 ADC2 end of conversion
      008064 82 00 80 81             72 	int NonHandledInterrupt	;int23 TIM4 update/overflow ; use to blink tv cursor 
      008068 82 00 80 81             73 	int NonHandledInterrupt ;int24 flash writing EOP/WR_PG_DIS
      00806C 82 00 80 81             74 	int NonHandledInterrupt ;int25  not used
      008070 82 00 80 81             75 	int NonHandledInterrupt ;int26  not used
      008074 82 00 80 81             76 	int NonHandledInterrupt ;int27  not used
      008078 82 00 80 81             77 	int NonHandledInterrupt ;int28  not used
      00807C 82 00 80 81             78 	int NonHandledInterrupt ;int29  not used
                                     79 
                                     80 
                           000004    81 KERNEL_VAR_ORG=4
                                     82 ;--------------------------------------
                                     83     .area DATA (ABS)
      000004                         84 	.org KERNEL_VAR_ORG 
                                     85 ;--------------------------------------	
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 37.
Hexadecimal [24-Bits]



                                     86 
                                     87 ; keep the following 3 variables in this order 
      000004                         88 acc16:: .blkb 1 ; 16 bits accumulator, acc24 high-byte
      000005                         89 acc8::  .blkb 1 ;  8 bits accumulator, acc24 low-byte  
      000006                         90 ptr16::  .blkb 1 ; 16 bits pointer , farptr high-byte 
      000007                         91 ptr8:   .blkb 1 ; 8 bits pointer, farptr low-byte  
      000008                         92 flags:: .blkb 1 ; various boolean flags
                                     93 
                                     94 ; keyboard variables
                                     95 ; received scan codes queue 
                           000020    96 SC_QUEUE_SIZE=32  
      000009                         97 sc_queue: .blkb SC_QUEUE_SIZE ; scan codes queue 
      000029                         98 sc_qhead: .blkb 1  ; sc_queue head index 
      00002A                         99 sc_qtail: .blkb 1  ; sc_queue tail index 
      00002B                        100 in_byte:  .blkb 1 ; shift in byte buffer 
      00002C                        101 parity:   .blkb 1 ; parity bit 
      00002D                        102 sc_rx_flags: .blkb 1 ; receive code flags 
      00002E                        103 sc_rx_phase: .blkb 1 ; scan code receive phase 
                                    104 ;; transmission to keyboard variables 
      00002F                        105 out_byte: .blkb 1 ; send byte to keyboard 
      000030                        106 tx_bit_cntr: .blkb 1 ;bit counter for out_byte shifting.
      000031                        107 tx_phase: .blkb 1 ; sending to keyboard phases 
      000032                        108 tx_parity: .blkb 1 ; parity counter  
                                    109 
                           000010   110 KBD_QUEUE_SIZE=16
      000033                        111 kbd_queue: .blkb KBD_QUEUE_SIZE 
      000043                        112 kbd_queue_head: .blkb 1 
      000044                        113 kbd_queue_tail: .blkb 1 
      000045                        114 kbd_state: .blkb 1 ; keyboard state flags 
                                    115 
                                    116 ; tvout variables 
      000046                        117 ntsc_flags: .blkb 1 
      000047                        118 ntsc_phase: .blkb 1 ; 
      000048                        119 scan_line: .blkw 1 ; video lines {0..262} 
      00004A                        120 font_addr: .blkw 1 ; font table address 
                                    121 
                                    122 ; tv terminal variables 
      00004C                        123 cursor_x: .blkb 1 
      00004D                        124 cursor_y: .blkb 1 
      00004E                        125 cursor_delay: .blkb 1 ;  20/60 sec delay 
      00004F                        126 char_under: .blkb 1 ; character under cursor 
      000050                        127 char_cursor: .blkb 1 ; character used for cursor 
      000051                        128 saved_cx: .blkb 1 ; saved cursor position
      000052                        129 saved_cy: .blkb 1 ; restored cursor position 
                                    130 
                                    131 ; uart variable 
                           000040   132 RX_QUEUE_SIZE=64
      000053                        133 rx1_queue: .ds RX_QUEUE_SIZE ; UART1 receive circular queue 
      000093                        134 rx1_head:  .blkb 1 ; rx1_queue head pointer
      000094                        135 rx1_tail:   .blkb 1 ; rx1_queue tail pointer  
      000095                        136 dev_id:  .blkb 1 ; device identifier {0..3}, default 3  
                                    137 
                                    138 ; free ram for user font 
      000100                        139 	.org 256 
      000100                        140 user_font:
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 38.
Hexadecimal [24-Bits]



                                    141 
      0008DA                        142 	.org RAM_SIZE-STACK_SIZE-(2*CHAR_PER_LINE*LINE_PER_SCREEN)
      0008DA                        143 video_buffer: .blkw CHAR_PER_LINE*LINE_PER_SCREEN
                                    144 
                                    145 
                                    146 	.area CODE 
                                    147 
                                    148 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                                    149 ; do nothing interrupt UartRxHandler
                                    150 ; debug support 
                                    151 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
      008080                        152 DoNothing:
      008080 80               [11]  153 	iret 
                                    154 
                                    155 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                                    156 ; non handled interrupt 
                                    157 ; reset MCU
                                    158 ;;;;;;;;;;;;;;;;;;;;;;;;;;;
      008081                        159 NonHandledInterrupt:
      000001                        160 	_swreset ; see "inc/gen_macros.inc"
      008081 35 80 50 D1      [ 1]    1     mov WWDG_CR,#0X80
                                    161 
                                    162 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                                    163 ;    peripherals initialization
                                    164 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                                    165 
                                    166 ;----------------------------
                                    167 ; if FMSTR>16Mhz 
                                    168 ; program 1 wait state in OPT7 
                                    169 ;----------------------------
      008085                        170 wait_state:
      008085 A6 18            [ 1]  171 	ld a,#FMSTR 
      008087 A1 10            [ 1]  172 	cp a,#16 
      008089 23 0A            [ 2]  173 	jrule no_ws 
      00808B                        174 set_ws:	; for FMSTR>16Mhz 1 wait required 
      00808B 72 5D 48 0D      [ 1]  175 	tnz FLASH_WS ; OPT7  
      00808F 26 23            [ 1]  176 	jrne opt_done ; already set  
      008091 A6 01            [ 1]  177 	ld a,#1 
      008093 20 07            [ 2]  178 	jra prog_opt7 	
      008095                        179 no_ws: ; FMSTR<=16Mhz no wait required 
      008095 72 5D 48 0D      [ 1]  180 	tnz FLASH_WS 
      008099 27 19            [ 1]  181 	jreq opt_done ; already cleared 
      00809B 4F               [ 1]  182 	clr a 
      00809C                        183 prog_opt7:
      00809C CD 80 B5         [ 4]  184 	call unlock_eeprom 
      00809F C7 48 0D         [ 1]  185 	ld FLASH_WS,a 
      0080A2 43               [ 1]  186 	cpl a 
      0080A3 C7 48 0E         [ 1]  187 	ld FLASH_WS+1,a 
      0080A6 72 05 50 5F FB   [ 2]  188 	btjf FLASH_IAPSR,#FLASH_IAPSR_EOP,.
      0080AB 72 0D 50 5F FB   [ 2]  189 	btjf FLASH_IAPSR,#FLASH_IAPSR_HVOFF,.
      000030                        190 	_swreset 
      0080B0 35 80 50 D1      [ 1]    1     mov WWDG_CR,#0X80
      0080B4                        191 opt_done:
      0080B4 81               [ 4]  192 	ret  
                                    193 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 39.
Hexadecimal [24-Bits]



      0080B5                        194 unlock_eeprom:
      0080B5 72 06 50 5F 15   [ 2]  195 	btjt FLASH_IAPSR,#FLASH_IAPSR_DUL,9$
      0080BA 35 00 50 5B      [ 1]  196 	mov FLASH_CR2,#0 
      0080BE 35 FF 50 5C      [ 1]  197 	mov FLASH_NCR2,#0xFF 
      0080C2 35 AE 50 64      [ 1]  198 	mov FLASH_DUKR,#FLASH_DUKR_KEY1
      0080C6 35 56 50 64      [ 1]  199     mov FLASH_DUKR,#FLASH_DUKR_KEY2
      0080CA 72 07 50 5F FB   [ 2]  200 	btjf FLASH_IAPSR,#FLASH_IAPSR_DUL,.
      0080CF                        201 9$:	
      0080CF 72 1E 50 5B      [ 1]  202     bset FLASH_CR2,#FLASH_CR2_OPT
      0080D3 72 1F 50 5C      [ 1]  203     bres FLASH_NCR2,#FLASH_CR2_OPT 
      0080D7 81               [ 4]  204 	ret
                                    205 
                                    206 ;----------------------------------------
                                    207 ; inialize MCU clock 
                                    208 ; input:
                                    209 ;   A      CLK_CKDIVR , clock divisor
                                    210 ;   XL     HSI|HSE   
                                    211 ; output:
                                    212 ;   none 
                                    213 ;----------------------------------------
      0080D8                        214 clock_init:	
                                    215 ; cpu clock divisor 
      0080D8 88               [ 1]  216 	push a   
      0080D9 9F               [ 1]  217 	ld a,xl ; clock source CLK_SWR_HSI|CLK_SWR_HSE 
      0080DA 72 17 50 C5      [ 1]  218 	bres CLK_SWCR,#CLK_SWCR_SWIF 
      0080DE C1 50 C3         [ 1]  219 	cp a,CLK_CMSR 
      0080E1 27 07            [ 1]  220 	jreq 2$ ; no switching required 
                                    221 ; select clock source 
      0080E3 72 12 50 C5      [ 1]  222 	bset CLK_SWCR,#CLK_SWCR_SWEN
      0080E7 C7 50 C4         [ 1]  223 	ld CLK_SWR,a
      0080EA                        224 2$: 
      0080EA 32 50 C6         [ 1]  225 	pop CLK_CKDIVR   	
      0080ED 81               [ 4]  226 	ret
                                    227 
                           000000   228 .if 0	
                                    229 ;--------------------------
                                    230 ; set software interrupt 
                                    231 ; priority 
                                    232 ; input:
                                    233 ;   A    priority 1,2,3 
                                    234 ;   X    vector 
                                    235 ;---------------------------
                                    236 	SPR_ADDR=1 
                                    237 	PRIORITY=3
                                    238 	SLOT=4
                                    239 	MASKED=5  
                                    240 	VSIZE=5
                                    241 set_int_priority::
                                    242 	_vars VSIZE
                                    243 	and a,#3  
                                    244 	ld (PRIORITY,sp),a 
                                    245 	ld a,#4 
                                    246 	div x,a 
                                    247 	sll a  ; slot*2 
                                    248 	ld (SLOT,sp),a
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 40.
Hexadecimal [24-Bits]



                                    249 	addw x,#ITC_SPR1 
                                    250 	ldw (SPR_ADDR,sp),x 
                                    251 ; build mask
                                    252 	ldw x,#0xfffc 	
                                    253 	ld a,(SLOT,sp)
                                    254 	jreq 2$ 
                                    255 	scf 
                                    256 1$:	rlcw x 
                                    257 	dec a 
                                    258 	jrne 1$
                                    259 2$:	ld a,xl 
                                    260 ; apply mask to slot 
                                    261 	ldw x,(SPR_ADDR,sp)
                                    262 	and a,(x)
                                    263 	ld (MASKED,sp),a 
                                    264 ; shift priority to slot 
                                    265 	ld a,(PRIORITY,sp)
                                    266 	ld xl,a 
                                    267 	ld a,(SLOT,sp)
                                    268 	jreq 4$
                                    269 3$:	sllw x 
                                    270 	dec a 
                                    271 	jrne 3$
                                    272 4$:	ld a,xl 
                                    273 	or a,(MASKED,sp)
                                    274 	ldw x,(SPR_ADDR,sp)
                                    275 	ld (x),a 
                                    276 	_drop VSIZE 
                                    277 	ret 
                                    278 .endif 
                                    279 
                                    280 ;-------------------------------------
                                    281 ;  initialization entry point 
                                    282 ;-------------------------------------
      0080EE                        283 cold_start:
                                    284 ;set stack 
      0080EE AE 17 FF         [ 2]  285 	ldw x,#STACK_EMPTY
      0080F1 94               [ 1]  286 	ldw sp,x
                                    287 ; clear all ram 
      0080F2 7F               [ 1]  288 0$: clr (x)
      0080F3 5A               [ 2]  289 	decw x 
      0080F4 26 FC            [ 1]  290 	jrne 0$
                                    291 ; activate pull up on all inputs 
      0080F6 A6 FF            [ 1]  292 	ld a,#255 
      0080F8 C7 50 03         [ 1]  293 	ld PA_CR1,a 
      0080FB C7 50 08         [ 1]  294 	ld PB_CR1,a 
      0080FE C7 50 0D         [ 1]  295 	ld PC_CR1,a 
      008101 C7 50 12         [ 1]  296 	ld PD_CR1,a
      008104 C7 50 17         [ 1]  297 	ld PE_CR1,a 
      008107 C7 50 1C         [ 1]  298 	ld PF_CR1,a 
      00810A C7 50 21         [ 1]  299 	ld PG_CR1,a 
      00810D C7 50 2B         [ 1]  300 	ld PI_CR1,a
      008110 72 1B 50 12      [ 1]  301 	bres PD_CR1,#5 ; uart_tx 
      008114 72 17 50 12      [ 1]  302     bres PD_CR1,#3 ; connected to PC6 
      008118 72 1B 50 17      [ 1]  303     bres PE_CR1,#5 ; connected to PD4 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 41.
Hexadecimal [24-Bits]



                                    304 ; read device id switches 
      00811C A6 06            [ 1]  305 	ld a,#DEV_ID_PORT
      00811E A4 0C            [ 1]  306 	and a, #((1<<DEV_ID0_BIT)+(1<<DEV_ID1_BIT))
      008120 44               [ 1]  307 	srl a 
      008121 44               [ 1]  308 	srl a 
      0000A2                        309 	_straz dev_id  
      008122 B7 95                    1     .byte 0xb7,dev_id 
                                    310 ; set user LED pin as output 
      008124 72 1A 50 0D      [ 1]  311     bset LED_PORT+GPIO_CR1,#LED_BIT
      008128 72 1A 50 0E      [ 1]  312     bset LED_PORT+GPIO_CR2,#LED_BIT
      00812C 72 1A 50 0C      [ 1]  313     bset LED_PORT+ GPIO_DDR,#LED_BIT
      0000B0                        314 	_led_off 
      008130 72 1B 50 0A      [ 1]    1         bres LED_PORT,#LED_BIT 
                                    315 ; disable schmitt triggers on Arduino CN4 analog inputs
      008134 55 00 3F 54 07   [ 1]  316 	mov ADC_TDRL,0x3f
      008139 CD 80 85         [ 4]  317     call wait_state 
                                    318 ; select external clock no divisor	
      00813C 4F               [ 1]  319 	clr a ; FMSTR no divisor 
      00813D AE 00 B4         [ 2]  320     ldw x,#CLK_SWR_HSE ; external clock 
      008140 CD 80 D8         [ 4]  321 	call clock_init	
      008143 CD 8D DC         [ 4]  322 	call uart_init
      008146 CD 82 AE         [ 4]  323 	call ps2_init    
      008149 9A               [ 1]  324 	rim ; enable interrupts 
      00814A CD 86 A8         [ 4]  325 	call ntsc_init ;
                                    326 
                           000001   327 .if 1 ; TEST CODE 
      00814D AE 81 B5         [ 2]  328 ldw x,#width 
      008150 CD 95 09         [ 4]  329 call tv_puts 
      008153 AE 81 5C         [ 2]  330 ldw x,#test 
      008156 CD 95 09         [ 4]  331 call tv_puts 
      008159 CC 95 16         [ 2]  332 jp main  
      00815C 54 48 45 20 51 55 49   333 test: .asciz "THE QUICK BROWN FOX JUMP OVER THE LAZY DOG.\nThe quick bronw fox jump over the lazy dog.\n"
             43 4B 20 42 52 4F 57
             4E 20 46 4F 58 20 4A
             55 4D 50 20 4F 56 45
             52 20 54 48 45 20 4C
             41 5A 59 20 44 4F 47
             2E 0A 54 68 65 20 71
             75 69 63 6B 20 62 72
             6F 6E 77 20 66 6F 78
             20 6A 75 6D 70 20 6F
             76 65 72 20 74 68 65
             20 6C 61 7A 79 20 64
             6F 67 2E 0A 00
      0081B5 31 32 33 34 35 36 37   334 width: .asciz "123456789012345678901234567890123456789012345678901234567890123456789012345"
             38 39 30 31 32 33 34
             35 36 37 38 39 30 31
             32 33 34 35 36 37 38
             39 30 31 32 33 34 35
             36 37 38 39 30 31 32
             33 34 35 36 37 38 39
             30 31 32 33 34 35 36
             37 38 39 30 31 32 33
             34 35 36 37 38 39 30
             31 32 33 34 35 00
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 42.
Hexadecimal [24-Bits]



                                    335 .endif ; TEST CODE 
                                    336 
      008201 CC 95 16         [ 2]  337 	jp main ; in tv_term.asm 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 43.
Hexadecimal [24-Bits]



                                      1 ;;
                                      2 ; Copyright Jacques Deschênes 2019,2022,2023  
                                      3 ; This file is part of stm8_tbi 
                                      4 ;
                                      5 ;     stm8_tbi is free software: you can redistribute it and/or modify
                                      6 ;     it under the terms of the GNU General Public License as published by
                                      7 ;     the Free Software Foundation, either version 3 of the License, or
                                      8 ;     (at your option) any later version.
                                      9 ;
                                     10 ;     stm8_tbi is distributed in the hope that it will be useful,
                                     11 ;     but WITHOUT ANY WARRANTY; without even the implied warranty of
                                     12 ;     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
                                     13 ;     GNU General Public License for more details.
                                     14 ;
                                     15 ;     You should have received a copy of the GNU General Public License
                                     16 ;     along with stm8_tbi.  If not, see <http://www.gnu.org/licenses/>.
                                     17 ;;
                                     18 
                                     19 ;--------------------------
                                     20 ; standards functions
                                     21 ;--------------------------
                                     22 
                                     23 
                                     24 ;--------------------------
                                     25 	.area CODE
                                     26 ;--------------------------
                                     27 
                                     28 ;--------------------------------------
                                     29 ; retrun string length
                                     30 ; input:
                                     31 ;   X         .asciz  pointer 
                                     32 ; output:
                                     33 ;   X         not affected 
                                     34 ;   A         length 
                                     35 ;-------------------------------------
      008204                         36 strlen::
      008204 89               [ 2]   37 	pushw x 
      008205 4F               [ 1]   38 	clr a
      008206 7D               [ 1]   39 1$:	tnz (x) 
      008207 27 04            [ 1]   40 	jreq 9$ 
      008209 4C               [ 1]   41 	inc a 
      00820A 5C               [ 1]   42 	incw x 
      00820B 20 F9            [ 2]   43 	jra 1$ 
      00820D 85               [ 2]   44 9$:	popw x 
      00820E 81               [ 4]   45 	ret 
                                     46 
                                     47 ;------------------------------------
                                     48 ; compare 2 strings
                                     49 ; input:
                                     50 ;   X 		char* first string 
                                     51 ;   Y       char* second string 
                                     52 ; output:
                                     53 ;   Z flag 	0 != | 1 ==  
                                     54 ;-------------------------------------
      00820F                         55 strcmp::
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 44.
Hexadecimal [24-Bits]



      00820F F6               [ 1]   56 	ld a,(x)
      008210 27 09            [ 1]   57 	jreq 5$ 
      008212 90 F1            [ 1]   58 	cp a,(y) 
      008214 26 07            [ 1]   59 	jrne 9$ 
      008216 5C               [ 1]   60 	incw x 
      008217 90 5C            [ 1]   61 	incw y 
      008219 20 F4            [ 2]   62 	jra strcmp 
      00821B                         63 5$: ; end of first string 
      00821B 90 F1            [ 1]   64 	cp a,(y)
      00821D 81               [ 4]   65 9$:	ret 
                                     66 
                                     67 ;---------------------------------------
                                     68 ;  copy src string to dest 
                                     69 ; input:
                                     70 ;   X 		dest 
                                     71 ;   Y 		src 
                                     72 ; output: 
                                     73 ;   X 		dest 
                                     74 ;----------------------------------
      00821E                         75 strcpy::
      00821E 88               [ 1]   76 	push a 
      00821F 89               [ 2]   77 	pushw x 
      008220 90 F6            [ 1]   78 1$: ld a,(y)
      008222 27 06            [ 1]   79 	jreq 9$ 
      008224 F7               [ 1]   80 	ld (x),a 
      008225 5C               [ 1]   81 	incw x 
      008226 90 5C            [ 1]   82 	incw y 
      008228 20 F6            [ 2]   83 	jra 1$ 
      00822A 7F               [ 1]   84 9$:	clr (x)
      00822B 85               [ 2]   85 	popw x 
      00822C 84               [ 1]   86 	pop a 
      00822D 81               [ 4]   87 	ret 
                                     88 
                                     89 ;---------------------------------------
                                     90 ; move memory block 
                                     91 ; input:
                                     92 ;   X 		destination 
                                     93 ;   Y 	    source 
                                     94 ;   acc16	bytes count 
                                     95 ; output:
                                     96 ;   X       destination 
                                     97 ;--------------------------------------
                           000001    98 	INCR=1 ; incrament high byte 
                           000002    99 	LB=2 ; increment low byte 
                           000002   100 	VSIZE=2
      00822E                        101 move::
      00822E 88               [ 1]  102 	push a 
      00822F 89               [ 2]  103 	pushw x 
      0001B0                        104 	_vars VSIZE 
      008230 52 02            [ 2]    1     sub sp,#VSIZE 
      008232 0F 01            [ 1]  105 	clr (INCR,sp)
      008234 0F 02            [ 1]  106 	clr (LB,sp)
      008236 90 89            [ 2]  107 	pushw y 
      008238 13 01            [ 2]  108 	cpw x,(1,sp) ; compare DEST to SRC 
      00823A 90 85            [ 2]  109 	popw y 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 45.
Hexadecimal [24-Bits]



      00823C 27 2F            [ 1]  110 	jreq move_exit ; x==y 
      00823E 2B 0E            [ 1]  111 	jrmi move_down
      008240                        112 move_up: ; start from top address with incr=-1
      008240 72 BB 00 04      [ 2]  113 	addw x,acc16
      008244 72 B9 00 04      [ 2]  114 	addw y,acc16
      008248 03 01            [ 1]  115 	cpl (INCR,sp)
      00824A 03 02            [ 1]  116 	cpl (LB,sp)   ; increment = -1 
      00824C 20 05            [ 2]  117 	jra move_loop  
      00824E                        118 move_down: ; start from bottom address with incr=1 
      00824E 5A               [ 2]  119     decw x 
      00824F 90 5A            [ 2]  120 	decw y
      008251 0C 02            [ 1]  121 	inc (LB,sp) ; incr=1 
      008253                        122 move_loop:	
      0001D3                        123     _ldaz acc16 
      008253 B6 04                    1     .byte 0xb6,acc16 
      008255 CA 00 05         [ 1]  124 	or a, acc8
      008258 27 13            [ 1]  125 	jreq move_exit 
      00825A 72 FB 01         [ 2]  126 	addw x,(INCR,sp)
      00825D 72 F9 01         [ 2]  127 	addw y,(INCR,sp) 
      008260 90 F6            [ 1]  128 	ld a,(y)
      008262 F7               [ 1]  129 	ld (x),a 
      008263 89               [ 2]  130 	pushw x 
      0001E4                        131 	_ldxz acc16 
      008264 BE 04                    1     .byte 0xbe,acc16 
      008266 5A               [ 2]  132 	decw x 
      008267 CF 00 04         [ 2]  133 	ldw acc16,x 
      00826A 85               [ 2]  134 	popw x 
      00826B 20 E6            [ 2]  135 	jra move_loop
      00826D                        136 move_exit:
      0001ED                        137 	_drop VSIZE
      00826D 5B 02            [ 2]    1     addw sp,#VSIZE 
      00826F 85               [ 2]  138 	popw x 
      008270 84               [ 1]  139 	pop a 
      008271 81               [ 4]  140 	ret 	
                                    141 
                                    142 ;-------------------------
                                    143 ;  upper case letter 
                                    144 ; input:
                                    145 ;   A    letter 
                                    146 ; output:
                                    147 ;   A    
                                    148 ;--------------------------
      008272                        149 to_upper:
      008272 A1 61            [ 1]  150     cp a,#'a 
      008274 2B 06            [ 1]  151     jrmi 9$ 
      008276 A1 7B            [ 1]  152     cp a,#'z+1 
      008278 2A 02            [ 1]  153     jrpl 9$ 
      00827A A4 DF            [ 1]  154     and a,#0xDF 
      00827C 81               [ 4]  155 9$: ret 
                                    156 
                                    157 ;-------------------------------------
                                    158 ; check if A is a letter 
                                    159 ; input:
                                    160 ;   A 			character to test 
                                    161 ; output:
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 46.
Hexadecimal [24-Bits]



                                    162 ;   C flag      1 true, 0 false 
                                    163 ;-------------------------------------
      00827D                        164 is_alpha::
      00827D A1 41            [ 1]  165 	cp a,#'A 
      00827F 8C               [ 1]  166 	ccf 
      008280 24 0B            [ 1]  167 	jrnc 9$ 
      008282 A1 5B            [ 1]  168 	cp a,#'Z+1 
      008284 25 07            [ 1]  169 	jrc 9$ 
      008286 A1 61            [ 1]  170 	cp a,#'a 
      008288 8C               [ 1]  171 	ccf 
      008289 24 02            [ 1]  172 	jrnc 9$
      00828B A1 7B            [ 1]  173 	cp a,#'z+1
      00828D 81               [ 4]  174 9$: ret 	
                                    175 
                                    176 ;------------------------------------
                                    177 ; check if character in {'0'..'9'}
                                    178 ; input:
                                    179 ;    A  character to test
                                    180 ; output:
                                    181 ;    Carry  0 not digit | 1 digit
                                    182 ;------------------------------------
      00828E                        183 is_digit::
      00828E A1 30            [ 1]  184 	cp a,#'0
      008290 25 03            [ 1]  185 	jrc 1$
      008292 A1 3A            [ 1]  186     cp a,#'9+1
      008294 8C               [ 1]  187 	ccf 
      008295 8C               [ 1]  188 1$:	ccf 
      008296 81               [ 4]  189     ret
                                    190 
                                    191 ;------------------------------------
                                    192 ; check if character in {'0'..'9','A'..'F'}
                                    193 ; input:
                                    194 ;    A  character to test
                                    195 ; output:
                                    196 ;    Carry  0 not hex_digit | 1 hex_digit
                                    197 ;------------------------------------
      008297                        198 is_hex_digit::
      008297 CD 82 8E         [ 4]  199 	call is_digit 
      00829A 25 08            [ 1]  200 	jrc 9$
      00829C A1 41            [ 1]  201 	cp a,#'A 
      00829E 25 03            [ 1]  202 	jrc 1$
      0082A0 A1 47            [ 1]  203 	cp a,#'G 
      0082A2 8C               [ 1]  204 	ccf 
      0082A3 8C               [ 1]  205 1$: ccf 
      0082A4 81               [ 4]  206 9$: ret 
                                    207 
                                    208 
                                    209 ;-------------------------------------
                                    210 ; return true if character in  A 
                                    211 ; is letter or digit.
                                    212 ; input:
                                    213 ;   A     ASCII character 
                                    214 ; output:
                                    215 ;   A     no change 
                                    216 ;   Carry    0 false| 1 true 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 47.
Hexadecimal [24-Bits]



                                    217 ;--------------------------------------
      0082A5                        218 is_alnum::
      0082A5 CD 82 8E         [ 4]  219 	call is_digit
      0082A8 25 03            [ 1]  220 	jrc 1$ 
      0082AA CD 82 7D         [ 4]  221 	call is_alpha
      0082AD 81               [ 4]  222 1$:	ret 
                                    223 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 48.
Hexadecimal [24-Bits]



                                      1 ;
                                      2 ; Copyright Jacques Deschênes 2023 
                                      3 ; This file is part of stm8_terminal 
                                      4 ;
                                      5 ;     stm8_terminal is free software: you can redistribute it and/or modify
                                      6 ;     it under the terms of the GNU General Public License as published by
                                      7 ;     the Free Software Foundation, either version 3 of the License, or
                                      8 ;     (at your option) any later version.
                                      9 ;
                                     10 ;     stm8_terminal is distributed in the hope that it will be useful,
                                     11 ;     but WITHOUT ANY WARRANTY; without even the implied warranty of
                                     12 ;     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
                                     13 ;     GNU General Public License for more details.
                                     14 ;
                                     15 ;     You should have received a copy of the GNU General Public License
                                     16 ;     along with stm8_terminal.  If not, see <http://www.gnu.org/licenses/>.
                                     17 ;;
                                     18 ;------------------------------------
                                     19 ;   1 start bit 
                                     20 ;   8 data bits 
                                     21 ;   1 parity bit odd 
                                     22 ;   1 stop bit 
                                     23 ;
                                     24 ;   least bit sent first 
                                     25 ;   host read bit when clock low  
                                     26 ;------------------------------------
                                     27 
                                     28 ; keyboard port registers 
                           005005    29 PS2_PORT=PB_BASE
                           005005    30 PS2_ODR=PB_ODR 
                           005006    31 PS2_IDR=PB_IDR 
                           005008    32 PS2_CR1=PB_CR1 
                           005009    33 PS2_CR2=PB_CR2 
                           005007    34 PS2_DDR=PB_DDR 
                                     35 ; keyboard pins 
                           000000    36 PS2_CLK=0  ; PB:0 
                           000001    37 PS2_DATA=1 ; PB:1 
                                     38 
                                     39 ; kbd_state flags 
                           000000    40 F_SEND = 0 ; host sending command to keyboard 
                           000001    41 F_NUM =	1 ; numlock kbd_leds
                           000002    42 F_CAPS = 2 ; capslock kbd_leds
                           000003    43 F_SHIFT =	3  ; SHIFT key down 
                           000004    44 F_CTRL =	4  ; CTRL key down 
                           000005    45 F_ALT =	5  ; ALT key down 
                           000006    46 F_ACK	=	6  ;  ACK code received 
                           000007    47 F_BATOK =	7  ; BAT_OK code received 	
                                     48 	
                                     49 ; rxflags  
                           000001    50 F_XT =	1    ; extended code 
                           000002    51 F_REL =	2    ; key released code 
                           000004    52 F_RX_ERR = 4 ; receive error 
                                     53 
                                     54 ; scan code receive phases 
                           000000    55 WAIT_START=0
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 49.
Hexadecimal [24-Bits]



                           000001    56 DATA_BIT=1 
                           000002    57 PARITY_BIT=2 
                           000003    58 STOP_BIT=3 
                                     59 ; transmit byte to keyboard phases 
                           000000    60 SEND_BITS=0 
                           000001    61 SEND_PARITY=1 
                           000002    62 SEND_STOP=2
                           000003    63 RCV_ACK=3 
                                     64 
                                     65 ;--------------------------------
                                     66     .area CODE 
                                     67 
                                     68 
                                     69 ;--------------------------
                                     70 ; initialize PS/2 keyboard 
                                     71 ; interface 
                                     72 ;--------------------------
      0082AE                         73 ps2_init:
                                     74 ; set external interrupt
                                     75 ; on ps2_clk falling edge 
                                     76 ; set as input 
      0082AE 72 11 50 07      [ 1]   77     bres PS2_DDR,#PS2_CLK 
      0082B2 72 13 50 07      [ 1]   78     bres PS2_DDR,#PS2_DATA
                                     79 ; remove internal pull up
                                     80 ; make it open drain when in output mode      
      0082B6 72 11 50 08      [ 1]   81     bres PS2_CR1,#PS2_CLK 
      0082BA 72 13 50 08      [ 1]   82     bres PS2_CR1,#PS2_DATA 
                                     83 ; enable external interrup on PB falling edge only 
      0082BE 35 08 50 A0      [ 1]   84     mov EXTI_CR1,#(2<<2) 
                                     85 ; enable TIMER4 clock 
      0082C2 72 18 50 C7      [ 1]   86 	bset CLK_PCKENR1,#CLK_PCKENR1_TIM4
                                     87 
                                     88 ; enable external interrupt on PS2_CLK        
      0082C6 72 10 50 09      [ 1]   89     bset PS2_CR2,#PS2_CLK   
                                     90 ; reset all variables      
      00024A                         91     _clrz sc_qhead 
      0082CA 3F 29                    1     .byte 0x3f, sc_qhead 
      00024C                         92     _clrz sc_qtail
      0082CC 3F 2A                    1     .byte 0x3f, sc_qtail 
      00024E                         93     _clrz sc_rx_flags 
      0082CE 3F 2D                    1     .byte 0x3f, sc_rx_flags 
      000250                         94     _clrz sc_rx_phase 
      0082D0 3F 2E                    1     .byte 0x3f, sc_rx_phase 
      000252                         95     _clrz kbd_queue_head 
      0082D2 3F 43                    1     .byte 0x3f, kbd_queue_head 
      000254                         96     _clrz kbd_queue_tail
      0082D4 3F 44                    1     .byte 0x3f, kbd_queue_tail 
      000256                         97     _clrz kbd_state 
      0082D6 3F 45                    1     .byte 0x3f, kbd_state 
      0082D8 81               [ 4]   98     ret 
                                     99 
                                    100 ;------------------------------
                                    101 ;  keyboard received 
                                    102 ;  handler 
                                    103 ;  interrupt on PB:0 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 50.
Hexadecimal [24-Bits]



                                    104 ;-------------------------------
      0082D9                        105 ps2_intr_handler: 
      000259                        106     _ldaz sc_rx_phase
      0082D9 B6 2E                    1     .byte 0xb6,sc_rx_phase 
      0082DB A1 00            [ 1]  107     cp a,#WAIT_START 
      0082DD 27 13            [ 1]  108     jreq rx_start_bit
      0082DF A1 01            [ 1]  109     cp a,#DATA_BIT
      0082E1 27 21            [ 1]  110     jreq rx_data_bit
      0082E3 A1 02            [ 1]  111     cp a,#PARITY_BIT 
      0082E5 27 2D            [ 1]  112     jreq rx_parity_bit 
      0082E7 A1 03            [ 1]  113     cp a,#STOP_BIT 
      0082E9 27 33            [ 1]  114     jreq rx_stop_bit
      0082EB                        115 sc_rx_error:
      0082EB 72 18 00 2D      [ 1]  116     bset sc_rx_flags,#F_RX_ERR 
      00026F                        117     _clrz sc_rx_phase 
      0082EF 3F 2E                    1     .byte 0x3f, sc_rx_phase 
      0082F1 80               [11]  118     iret         
      0082F2                        119 rx_start_bit:
      0082F2 72 02 50 06 F4   [ 2]  120     btjt PS2_IDR,#PS2_DATA,sc_rx_error
      0082F7 72 19 00 2E      [ 1]  121     bres sc_rx_phase,#F_RX_ERR  
      0082FB A6 80            [ 1]  122     ld a,#128 
      00027D                        123     _straz in_byte 
      0082FD B7 2B                    1     .byte 0xb7,in_byte 
      00027F                        124     _clrz parity 
      0082FF 3F 2C                    1     .byte 0x3f, parity 
      000281                        125     _incz sc_rx_phase 
      008301 3C 2E                    1     .byte 0x3c, sc_rx_phase 
      008303 80               [11]  126     iret  
      008304                        127 rx_data_bit:
      008304 72 03 50 06 02   [ 2]  128     btjf PS2_IDR,#PS2_DATA,1$
      000289                        129     _incz parity 
      008309 3C 2C                    1     .byte 0x3c, parity 
      00830B                        130 1$: 
      00830B 72 56 00 2B      [ 1]  131     rrc in_byte 
      00830F 24 02            [ 1]  132     jrnc 9$ 
      000291                        133     _incz sc_rx_phase 
      008311 3C 2E                    1     .byte 0x3c, sc_rx_phase 
      008313 80               [11]  134 9$: iret 
      008314                        135 rx_parity_bit:
      008314 72 03 50 06 02   [ 2]  136     btjf PS2_IDR,#PS2_DATA,1$
      000299                        137     _incz parity 
      008319 3C 2C                    1     .byte 0x3c, parity 
      00831B                        138 1$:      
      00029B                        139     _incz sc_rx_phase 
      00831B 3C 2E                    1     .byte 0x3c, sc_rx_phase 
      00831D 80               [11]  140     iret  
      00831E                        141 rx_stop_bit: 
      00831E 72 03 50 06 C8   [ 2]  142     btjf PS2_IDR,#PS2_DATA,sc_rx_error 
                                    143 ; check parity, bit 0, should be set  
      008323 72 01 00 2C C3   [ 2]  144     btjf parity,#0,sc_rx_error 
      0002A8                        145     _clrz sc_rx_phase 
      008328 3F 2E                    1     .byte 0x3f, sc_rx_phase 
      00832A CD 83 F4         [ 4]  146     call store_scan_code 
      00832D 80               [11]  147     iret 
                                    148 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 51.
Hexadecimal [24-Bits]



                                    149 ;----------------------------------
                                    150 ; host send a byte to keyboard
                                    151 ; input:
                                    152 ;   A      byte to send 
                                    153 ;----------------------------------
                                    154     .macro _wait_ack 
                                    155     btjf kbd_state,#F_ACK,. 
                                    156     .endm 
                                    157 
                                    158     .macro _wait_clk_low
                                    159     btjt PS2_IDR,#PS2_CLK,. 
                                    160     .endm 
                                    161 
                                    162     .macro _wait_clk_high 
                                    163     btjf PS2_IDR,#PS2_CLK,. 
                                    164     .endm 
                                    165 
                                    166     .macro _wait_kbd_clk 
                                    167         _wait_clk_high 
                                    168         _wait_clk_low 
                                    169     .endm 
                                    170 
      00832E                        171 send_to_keyboard:
      0002AE                        172     _straz out_byte 
      00832E B7 2F                    1     .byte 0xb7,out_byte 
      008330 35 08 00 30      [ 1]  173     mov tx_bit_cntr,#8
      0002B4                        174     _clrz tx_parity
      008334 3F 32                    1     .byte 0x3f, tx_parity 
                                    175 ; disable video output 
      008336 4F               [ 1]  176     clr a 
      008337 CD 87 26         [ 4]  177     call video_on_off 
                                    178 ; take control of clock line 
      00833A 72 10 50 07      [ 1]  179     bset PS2_DDR,#PS2_CLK
      00833E 72 11 50 05      [ 1]  180     bres PS2_ODR,#PS2_CLK 
                                    181 ; set TIMER4 for 150µsec delay 
                                    182 ; base on 20Mhz sysclock 
      008342 72 11 53 40      [ 1]  183     bres TIM4_CR1,#TIM4_CR1_CEN
      008346 35 04 53 45      [ 1]  184     mov TIM4_PSCR,#4 ; Fsys/16 
      00834A 35 45 53 46      [ 1]  185     mov TIM4_ARR,#69 
      00834E 72 5F 53 42      [ 1]  186 	clr TIM4_SR 
      008352 35 05 53 40      [ 1]  187     mov TIM4_CR1,#((1<<TIM4_CR1_CEN)|(1<<TIM4_CR1_URS))
      008356 72 01 53 42 FB   [ 2]  188     btjf TIM4_SR,#TIM4_SR_UIF,.
      00835B 72 11 53 40      [ 1]  189 	bres TIM4_CR1,#TIM4_CR1_CEN 
                                    190 ;take control of data line
                                    191 ; and reset it, start bit 
      00835F 72 12 50 07      [ 1]  192     bset PS2_DDR,#PS2_DATA 
      008363 72 13 50 05      [ 1]  193     bres PS2_ODR,#PS2_DATA 
                                    194 ; release clock line 
      008367 72 11 50 07      [ 1]  195     bres PS2_DDR,#PS2_CLK
      00836B                        196 1$: ; data bit loop 
      0002EB                        197     _wait_clk_high  
      00836B 72 01 50 06 FB   [ 2]    1     btjf PS2_IDR,#PS2_CLK,. 
      0002F0                        198     _wait_clk_low
      008370 72 00 50 06 FB   [ 2]    1     btjt PS2_IDR,#PS2_CLK,. 
      008375 72 54 00 2F      [ 1]  199     srl out_byte 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 52.
Hexadecimal [24-Bits]



      008379 90 13 50 05      [ 1]  200     bccm PS2_ODR,#PS2_DATA
      00837D 24 02            [ 1]  201     jrnc 2$ 
      0002FF                        202     _incz tx_parity
      00837F 3C 32                    1     .byte 0x3c, tx_parity 
      008381                        203 2$: 
      000301                        204     _decz tx_bit_cntr 
      008381 3A 30                    1     .byte 0x3a,tx_bit_cntr 
      008383 26 E6            [ 1]  205     jrne 1$ 
                                    206 ; send parity bit
      000305                        207     _wait_kbd_clk 
      000305                          1         _wait_clk_high 
      008385 72 01 50 06 FB   [ 2]    1     btjf PS2_IDR,#PS2_CLK,. 
      00030A                          2         _wait_clk_low 
      00838A 72 00 50 06 FB   [ 2]    1     btjt PS2_IDR,#PS2_CLK,. 
      00838F 72 54 00 32      [ 1]  208     srl tx_parity 
      008393 8C               [ 1]  209     ccf 
      008394 90 13 50 05      [ 1]  210     bccm PS2_ODR,#PS2_DATA 
                                    211 ; send stop bit, release data line  
      000318                        212     _wait_kbd_clk 
      000318                          1         _wait_clk_high 
      008398 72 01 50 06 FB   [ 2]    1     btjf PS2_IDR,#PS2_CLK,. 
      00031D                          2         _wait_clk_low 
      00839D 72 00 50 06 FB   [ 2]    1     btjt PS2_IDR,#PS2_CLK,. 
      0083A2 72 13 50 07      [ 1]  213     bres PS2_DDR,#PS2_DATA
      000326                        214     _wait_clk_high
      0083A6 72 01 50 06 FB   [ 2]    1     btjf PS2_IDR,#PS2_CLK,. 
                                    215 ; wait for both lines low 
      0083AB                        216 3$:
      0083AB C6 50 06         [ 1]  217     ld a,PS2_IDR 
      0083AE A4 03            [ 1]  218     and a,#(1<<PS2_CLK)|(1<<PS2_DATA)
      0083B0 26 F9            [ 1]  219     jrne 3$ 
                                    220 ; wait both lines high 
      0083B2 C6 50 06         [ 1]  221 4$: ld a,PS2_IDR 
      0083B5 A4 03            [ 1]  222     and a,#(1<<PS2_CLK)|(1<<PS2_DATA)
      0083B7 A1 03            [ 1]  223     cp a,#(1<<PS2_CLK)|(1<<PS2_DATA)
      0083B9 26 F7            [ 1]  224     jrne 4$ 
                                    225 ; enable interrupts 
      0083BB A6 01            [ 1]  226     ld a,#1 
      0083BD CD 87 26         [ 4]  227     call video_on_off
      0083C0 81               [ 4]  228     ret 
                                    229 
                                    230 ;------------------------
                                    231 ; expect a ACK from 
                                    232 ; keyboard 
                                    233 ;------------------------
      0083C1                        234 wait_ack:
      0083C1 5F               [ 1]  235     clrw x 
      0083C2 72 0C 00 45 03   [ 2]  236 1$: btjt kbd_state,#F_ACK,9$
      0083C7 5A               [ 2]  237     decw x
      0083C8 26 F8            [ 1]  238     jrne 1$ 
      0083CA                        239 9$:
      0083CA 81               [ 4]  240     ret 
                                    241 
                                    242 ;-------------------------
                                    243 ; set keyboard LED state 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 53.
Hexadecimal [24-Bits]



                                    244 ; input:
                                    245 ;    A    LEDs state 
                                    246 ;         CAPSLOCK bit 0 
                                    247 ;         NUMLOCK  bit 1 
                                    248 ;         SCRLOCK bit 2 
                                    249 ;-------------------------
      0083CB                        250 set_kbd_leds:
      0083CB 88               [ 1]  251     push a 
      0083CC A6 ED            [ 1]  252     ld a,#KBD_LED
      0083CE 72 1D 00 45      [ 1]  253     bres kbd_state,#F_ACK 
      0083D2 CD 83 2E         [ 4]  254     call send_to_keyboard 
      0083D5 CD 83 C1         [ 4]  255     call wait_ack
      0083D8 72 0D 00 45 11   [ 2]  256     btjf kbd_state,#F_ACK,reset_kbd  
      0083DD 84               [ 1]  257     pop a 
      0083DE 72 1D 00 45      [ 1]  258     bres kbd_state,#F_ACK 
      0083E2 CD 83 2E         [ 4]  259     call send_to_keyboard
      0083E5 CD 83 C1         [ 4]  260     call wait_ack 
      0083E8 72 0D 00 45 01   [ 2]  261     btjf kbd_state,#F_ACK,reset_kbd  
      0083ED 81               [ 4]  262     ret 
                                    263 
                                    264 ;--------------------------
                                    265 ; send reset command 
                                    266 ; to keyboard 
                                    267 ;--------------------------
      0083EE                        268 reset_kbd:
      0083EE A6 FF            [ 1]  269     ld a,#KBD_RESET 
      0083F0 CD 83 2E         [ 4]  270     call send_to_keyboard
      0083F3 81               [ 4]  271     ret 
                                    272 
                                    273 
                                    274 ;----------------
                                    275 ; store in_byte 
                                    276 ; in sc_queue 
                                    277 ;---------------
      0083F4                        278 store_scan_code:
      0083F4 A6 FA            [ 1]  279     ld a,#KBD_ACK 
      0083F6 C1 00 2B         [ 1]  280     cp a,in_byte 
      0083F9 26 06            [ 1]  281     jrne 1$
      0083FB 72 1C 00 45      [ 1]  282     bset kbd_state,#F_ACK 
      0083FF 20 1E            [ 2]  283     jra 9$
      008401                        284 1$:
      008401 A6 AA            [ 1]  285     ld a,#BAT_OK 
      008403 C1 00 2B         [ 1]  286     cp a,in_byte 
      008406 26 06            [ 1]  287     jrne 2$ 
      008408 72 1E 00 45      [ 1]  288     bset kbd_state,#F_BATOK 
      00840C 20 11            [ 2]  289     jra 9$ 
      00840E                        290 2$:
      00840E A6 09            [ 1]  291     ld a,#sc_queue
      008410 CB 00 2A         [ 1]  292     add a,sc_qtail 
      008413 5F               [ 1]  293     clrw x 
      008414 97               [ 1]  294     ld xl,a 
      000395                        295     _ldaz in_byte 
      008415 B6 2B                    1     .byte 0xb6,in_byte 
      008417 F7               [ 1]  296     ld (x),a 
      000398                        297     _ldaz sc_qtail
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 54.
Hexadecimal [24-Bits]



      008418 B6 2A                    1     .byte 0xb6,sc_qtail 
      00841A 4C               [ 1]  298     inc a 
      00841B A4 1F            [ 1]  299     and a,#SC_QUEUE_SIZE-1 
      00039D                        300     _straz sc_qtail  
      00841D B7 2A                    1     .byte 0xb7,sc_qtail 
      00841F                        301 9$:
      00841F 81               [ 4]  302     ret 
                                    303 
                                    304 ;----------------------
                                    305 ; get scan code 
                                    306 ; from sc_queue 
                                    307 ; output:
                                    308 ;    A    scan_code 
                                    309 ;----------------------
      008420                        310 fetch_scan_code:
      008420 C6 00 29         [ 1]  311     ld a,sc_qhead 
      008423 C1 00 2A         [ 1]  312     cp a,sc_qtail 
      008426 26 02            [ 1]  313     jrne 1$
      008428 4F               [ 1]  314     clr a 
      008429 81               [ 4]  315     ret 
      00842A 89               [ 2]  316 1$: pushw x 
      00842B AB 09            [ 1]  317     add a,#sc_queue 
      00842D 5F               [ 1]  318     clrw x 
      00842E 97               [ 1]  319     ld xl,a  
      00842F F6               [ 1]  320     ld a,(x)
      008430 88               [ 1]  321     push a 
      0003B1                        322     _ldaz sc_qhead 
      008431 B6 29                    1     .byte 0xb6,sc_qhead 
      008433 4C               [ 1]  323     inc a 
      008434 A4 1F            [ 1]  324     and a,#SC_QUEUE_SIZE-1 
      0003B6                        325     _straz sc_qhead 
      008436 B7 29                    1     .byte 0xb7,sc_qhead 
      008438 84               [ 1]  326     pop a 
      008439 85               [ 2]  327     popw x 
      00843A 4D               [ 1]  328     tnz a 
      00843B 81               [ 4]  329     ret 
                                    330 
                                    331 ;-------------------------------
                                    332 ; wait until scan code available 
                                    333 ;-------------------------------
      00843C                        334 wait_next_code:
      00843C CD 84 20         [ 4]  335     call fetch_scan_code
      00843F 27 FB            [ 1]  336     jreq wait_next_code 
      008441 81               [ 4]  337     ret 
                                    338 
                                    339 ;------------------------
                                    340 ; check if key is any of 
                                    341 ; SHIFT,CTRL,ALT, CAPSLOCK,NUMLOCK   
                                    342 ; set flag if required 
                                    343 ; input:
                                    344 ;   A     code 
                                    345 ; output:
                                    346 ;   A     code|| 0
                                    347 ;------------------------
      008442                        348 state_flag:
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 55.
Hexadecimal [24-Bits]



      008442 A1 A8            [ 1]  349     cp a,#VK_CAPS 
      008444 26 13            [ 1]  350     jrne 0$ 
      008446 72 04 00 2D 55   [ 2]  351     btjt sc_rx_flags,#F_REL,89$
      00844B 90 14 00 45      [ 1]  352     bcpl kbd_state,#F_CAPS 
      00844F                        353 12$:
      00844F C6 00 45         [ 1]  354     ld a,kbd_state
      008452 A4 06            [ 1]  355     and a,#(1<<F_CAPS)|(1<<F_NUM)
      008454 CD 83 CB         [ 4]  356     call set_kbd_leds 
      008457 20 47            [ 2]  357     jra 89$ 
      008459                        358 0$:
      008459 A1 A5            [ 1]  359     cp a,#VK_NUM
      00845B 26 0B            [ 1]  360     jrne 14$
      00845D 72 04 00 2D 3E   [ 2]  361     btjt sc_rx_flags,#F_REL,89$
      008462 90 12 00 45      [ 1]  362     bcpl kbd_state,#F_NUM  
      008466 20 E7            [ 2]  363     jra 12$ 
      008468                        364 14$: 
      008468 A1 9C            [ 1]  365     cp a,#VK_LSHIFT 
      00846A 26 02            [ 1]  366     jrne 1$
      00846C 20 04            [ 2]  367     jra 2$ 
      00846E                        368 1$:    
      00846E A1 9F            [ 1]  369     cp a,#VK_RSHIFT 
      008470 26 04            [ 1]  370     jrne 3$ 
      008472                        371 2$: 
      008472 A6 08            [ 1]  372     ld a,#(1<<F_SHIFT) 
      008474 20 1A            [ 2]  373     jra 84$ 
      008476 A1 9E            [ 1]  374 3$: cp a,#VK_LALT 
      008478 26 02            [ 1]  375     jrne 4$ 
      00847A 20 04            [ 2]  376     jra 5$ 
      00847C A1 A3            [ 1]  377 4$: cp a,#VK_RALT 
      00847E 26 04            [ 1]  378     jrne 6$ 
      008480                        379 5$:
      008480 A6 20            [ 1]  380     ld a,#(1<<F_ALT)
      008482 20 0C            [ 2]  381     jra 84$ 
      008484 A1 9D            [ 1]  382 6$: cp a,#VK_LCTRL 
      008486 26 02            [ 1]  383     jrne 7$ 
      008488 20 04            [ 2]  384     jra 8$ 
      00848A A1 A1            [ 1]  385 7$: cp a,#VK_RCTRL 
      00848C 26 13            [ 1]  386     jrne 9$ 
      00848E A6 10            [ 1]  387 8$: ld a,#(1<<F_CTRL)
      008490                        388 84$:
      008490 72 04 00 2D 05   [ 2]  389     btjt sc_rx_flags,#F_REL,86$  
      008495 CA 00 45         [ 1]  390     or a, kbd_state
      008498 20 04            [ 2]  391     jra 88$ 
      00849A                        392 86$: 
      00849A 43               [ 1]  393     cpl a 
      00849B C4 00 45         [ 1]  394     and a,kbd_state
      00849E                        395 88$:
      00041E                        396      _straz kbd_state 
      00849E B7 45                    1     .byte 0xb7,kbd_state 
      0084A0                        397 89$:
      0084A0 4F               [ 1]  398     clr a 
      0084A1                        399 9$: 
      0084A1 72 05 00 2D 01   [ 2]  400     btjf sc_rx_flags,#F_REL,10$ 
      0084A6 4F               [ 1]  401     clr a 
      0084A7                        402 10$:
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 56.
Hexadecimal [24-Bits]



      0084A7 4D               [ 1]  403     tnz a 
      0084A8 81               [ 4]  404     ret 
                                    405 
                                    406 ;----------------------------------
                                    407 ; modify charcter if 
                                    408 ; SHIFT key is down 
                                    409 ; LEFT and RIGHT keys considered same.
                                    410 ; input:
                                    411 ;   A    character in
                                    412 ; output:
                                    413 ;   A    character out
                                    414 ;   C    set if SHIFT key down   
                                    415 ;----------------------------------- 
                                    416 ; input:
                                    417 ;    A     letter 
                                    418 ; output:
                                    419 ;    A      letter 
                                    420 ;------------------------
      0084A9                        421 if_shifted:
      0084A9 89               [ 2]  422     pushw x 
      0084AA CD 82 7D         [ 4]  423     call is_alpha 
      0084AD 24 13            [ 1]  424     jrnc 4$
      0084AF A8 20            [ 1]  425     xor a,#32 ; default to lower 
      0084B1 72 05 00 45 02   [ 2]  426     btjf kbd_state,#F_CAPS,1$ 
      0084B6 A8 20            [ 1]  427     xor a,#32 
      0084B8                        428 1$:
      0084B8 72 07 00 45 03   [ 2]  429     btjf kbd_state,#F_SHIFT,2$ 
      0084BD A8 20            [ 1]  430     xor a,#32
      0084BF 99               [ 1]  431     scf  
      0084C0 20 0C            [ 2]  432 2$: jra 9$ 
      0084C2                        433 4$: ; not letter search shifted_table 
      0084C2 72 07 00 45 07   [ 2]  434     btjf kbd_state,#F_SHIFT,9$ 
      0084C7 AE 86 47         [ 2]  435     ldw x,#shifted_codes 
      0084CA CD 84 FB         [ 4]  436     call table_lookup 
      0084CD 99               [ 1]  437     scf 
      0084CE 85               [ 2]  438 9$: popw x 
      0084CF 81               [ 4]  439     ret 
                                    440 
                                    441 ;----------------------------------
                                    442 ; modify charcter if 
                                    443 ; CTRL key is down 
                                    444 ; LEFT and RIGHT keys considered same.
                                    445 ; input:
                                    446 ;   A    character in
                                    447 ; output:
                                    448 ;   A    character out
                                    449 ;   C    set if CTRL key down  
                                    450 ;----------------------------------- 
      0084D0                        451 if_ctrl_down:
      0084D0 89               [ 2]  452     pushw x 
      0084D1 98               [ 1]  453     rcf 
      0084D2 72 09 00 45 12   [ 2]  454     btjf kbd_state,#F_CTRL,9$ 
      0084D7 CD 82 7D         [ 4]  455     call is_alpha 
      0084DA 24 06            [ 1]  456     jrnc 2$
      0084DC A4 DF            [ 1]  457     and a,#0xDF ; upper case letter 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 57.
Hexadecimal [24-Bits]



      0084DE A0 40            [ 1]  458     sub a,#'A-1 ; CTRL+letter converted to {1..26}
      0084E0 20 06            [ 2]  459     jra 3$
      0084E2                        460 2$:
      0084E2 AE 86 93         [ 2]  461     ldw x,#control_codes
      0084E5 CD 84 FB         [ 4]  462     call table_lookup
      0084E8                        463 3$: 
      0084E8 99               [ 1]  464     scf 
      0084E9 85               [ 2]  465 9$: popw x 
      0084EA 81               [ 4]  466     ret 
                                    467 
                                    468 ;----------------------------------
                                    469 ; modify charcter if 
                                    470 ; ALT key is down 
                                    471 ; LEFT and RIGHT keys considered same.
                                    472 ; input:
                                    473 ;   A    character in
                                    474 ; output:
                                    475 ;   A    character out
                                    476 ;   C    set if ALT key down   
                                    477 ;----------------------------------- 
      0084EB                        478 if_alt_down:
      0084EB 89               [ 2]  479     pushw x 
      0084EC 98               [ 1]  480     rcf 
      0084ED 72 0B 00 45 07   [ 2]  481     btjf kbd_state,#F_ALT,9$ 
      0084F2 AE 86 84         [ 2]  482     ldw x,#altchar_codes
      0084F5 CD 84 FB         [ 4]  483     call table_lookup
      0084F8 99               [ 1]  484     scf 
      0084F9 85               [ 2]  485 9$: popw x 
      0084FA 81               [ 4]  486     ret 
                                    487 
                                    488 ;-------------------------
                                    489 ; search scan code 
                                    490 ; in table 
                                    491 ; input: 
                                    492 ;   A    scan code 
                                    493 ;   X    table 
                                    494 ; output:
                                    495 ;   A    0||ASCII||VK_KEY 
                                    496 ;   C    0 not found | 1 found 
                                    497 ;-------------------------
      0084FB                        498 table_lookup: 
      0084FB 88               [ 1]  499     push a 
      0084FC                        500 1$:
      0084FC F6               [ 1]  501     ld a,(x)
      0084FD 27 09            [ 1]  502     jreq 7$ 
      0084FF 11 01            [ 1]  503     cp a,(1,sp)
      008501 27 0A            [ 1]  504     jreq 8$ 
      008503 1C 00 02         [ 2]  505     addw x,#2 
      008506 20 F4            [ 2]  506     jra 1$ 
      008508 7B 01            [ 1]  507 7$: ld a,(1,sp)
      00850A 98               [ 1]  508     rcf 
      00850B 20 03            [ 2]  509     jra 9$ 
      00850D E6 01            [ 1]  510 8$: ld a,(1,x)
      00850F 99               [ 1]  511     scf 
      000490                        512 9$: _drop 1 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 58.
Hexadecimal [24-Bits]



      008510 5B 01            [ 2]    1     addw sp,#1 
      008512 81               [ 4]  513     ret 
                                    514 
                                    515 
                                    516 ;---------------------
                                    517 ; translate scan code 
                                    518 ; to ASCII 
                                    519 ; input:
                                    520 ;   A    scan code 
                                    521 ; output:
                                    522 ;   A     ASCII code 
                                    523 ;---------------------
      008513                        524 translate_code:
      008513 89               [ 2]  525     pushw x 
      008514 72 15 00 2D      [ 1]  526     bres sc_rx_flags,#F_REL 
      008518 AE 85 67         [ 2]  527     ldw x,#std_codes 
      00851B A1 E0            [ 1]  528     cp a,#XT_KEY 
      00851D 26 06            [ 1]  529     jrne 1$ 
      00851F AE 86 1A         [ 2]  530     ldw x,#xt_codes
      008522                        531 0$: 
      008522 CD 84 3C         [ 4]  532     call wait_next_code  
      008525                        533 1$:
      008525 A1 F0            [ 1]  534     cp a,#KEY_REL 
      008527 26 06            [ 1]  535     jrne 2$
      008529 72 14 00 2D      [ 1]  536     bset sc_rx_flags,#F_REL 
      00852D 20 F3            [ 2]  537     jra 0$ 
      00852F CD 84 FB         [ 4]  538 2$: call table_lookup
      008532 25 03            [ 1]  539     jrc 3$ 
      008534 4F               [ 1]  540     clr a 
      008535 20 12            [ 2]  541     jra 9$ 
      008537                        542 3$:
      008537 CD 84 42         [ 4]  543     call state_flag 
      00853A 27 0D            [ 1]  544     jreq 9$ 
      00853C CD 84 D0         [ 4]  545     call if_ctrl_down
      00853F 25 08            [ 1]  546     jrc 9$ 
      008541 CD 84 A9         [ 4]  547     call if_shifted
      008544 25 03            [ 1]  548     jrc 9$ 
      008546 CD 84 EB         [ 4]  549     call if_alt_down  
      008549                        550 9$:
      008549 85               [ 2]  551     popw x
      00854A 4D               [ 1]  552     tnz a  
      00854B 81               [ 4]  553     ret 
                                    554 
                                    555 
                                    556 ;---------------------------
                                    557 ;  check sc_queue for code 
                                    558 ;  translate to ASCII 
                                    559 ;  if availaible 
                                    560 ; output:
                                    561 ;   A     ASCII 
                                    562 ;--------------------------
      00854C                        563 keyboard_read:
      00854C CD 84 20         [ 4]  564     call fetch_scan_code
      00854F 27 03            [ 1]  565     jreq 9$ 
      008551 CD 85 13         [ 4]  566     call translate_code 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 59.
Hexadecimal [24-Bits]



      008554                        567 9$:
      008554 81               [ 4]  568     ret 
                                    569 
                                    570 
                                    571 
                                    572  
                                    573 
                                    574 
                                    575 
                                    576     
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 60.
Hexadecimal [24-Bits]



                                      1 ;;
                                      2 ; Copyright Jacques Deschênes 2023 
                                      3 ; This file is part of stm8_terminal 
                                      4 ;
                                      5 ;     stm8_terminal is free software: you can redistribute it and/or modify
                                      6 ;     it under the terms of the GNU General Public License as published by
                                      7 ;     the Free Software Foundation, either version 3 of the License, or
                                      8 ;     (at your option) any later version.
                                      9 ;
                                     10 ;     stm8_terminal is distributed in the hope that it will be useful,
                                     11 ;     but WITHOUT ANY WARRANTY; without even the implied warranty of
                                     12 ;     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
                                     13 ;     GNU General Public License for more details.
                                     14 ;
                                     15 ;     You should have received a copy of the GNU General Public License
                                     16 ;     along with stm8_terminal.  If not, see <http://www.gnu.org/licenses/>.
                                     17 ;;
                                     18 
                                     19 ; table scancode vers ASCII pour clavier MCSaite
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 61.
Hexadecimal [24-Bits]



                                     20     .include "inc/ascii.inc"
                                      1 ;------------------------------------------------------
                                      2 ;   ASCII code list  with symbolic names 
                                      3 ;-------------------------------------------------------
                                      4 
                                      5 ;-------------------------------------------------------
                                      6 ;     ASCII control  values
                                      7 ;     CTRL_x   are VT100 keyboard values  
                                      8 ; REF: https://en.wikipedia.org/wiki/ASCII    
                                      9 ;-------------------------------------------------------
                           000000    10 		NUL = 0  ; null 
                           000001    11 		CTRL_A = 1
                           000001    12 		SOH=CTRL_A  ; start of heading 
                           000002    13 		CTRL_B = 2
                           000002    14 		STX=CTRL_B  ; start of text 
                           000003    15 		CTRL_C = 3
                           000003    16 		ETX=CTRL_C  ; end of text 
                           000004    17 		CTRL_D = 4
                           000004    18 		EOT=CTRL_D  ; end of transmission 
                           000005    19 		CTRL_E = 5
                           000005    20 		ENQ=CTRL_E  ; enquery 
                           000006    21 		CTRL_F = 6
                           000006    22 		ACK=CTRL_F  ; acknowledge
                           000007    23 		CTRL_G = 7
                           000007    24         BELL = 7    ; vt100 terminal generate a sound.
                           000008    25 		CTRL_H = 8  
                           000008    26 		BS = 8     ; back space 
                           000009    27         CTRL_I = 9
                           000009    28     	TAB = 9     ; horizontal tabulation
                           00000A    29         CTRL_J = 10 
                           00000A    30 		LF = 10     ; line feed
                           00000B    31 		CTRL_K = 11
                           00000B    32         VT = 11     ; vertical tabulation 
                           00000C    33 		CTRL_L = 12
                           00000C    34         FF = 12      ; new page
                           00000D    35 		CTRL_M = 13
                           00000D    36 		CR = 13      ; carriage return 
                           00000E    37 		CTRL_N = 14
                           00000E    38 		SO=CTRL_N    ; shift out 
                           00000F    39 		CTRL_O = 15
                           00000F    40 		SI=CTRL_O    ; shift in 
                           000010    41 		CTRL_P = 16
                           000010    42 		DLE=CTRL_P   ; data link escape 
                           000011    43 		CTRL_Q = 17
                           000011    44 		DC1=CTRL_Q   ; device control 1 
                           000011    45 		XON=DC1 
                           000012    46 		CTRL_R = 18
                           000012    47 		DC2=CTRL_R   ; device control 2 
                           000013    48 		CTRL_S = 19
                           000013    49 		DC3=CTRL_S   ; device control 3
                           000013    50 		XOFF=DC3 
                           000014    51 		CTRL_T = 20
                           000014    52 		DC4=CTRL_T   ; device control 4 
                           000015    53 		CTRL_U = 21
                           000015    54 		NAK=CTRL_U   ; negative acknowledge
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 62.
Hexadecimal [24-Bits]



                           000016    55 		CTRL_V = 22
                           000016    56 		SYN=CTRL_V   ; synchronous idle 
                           000017    57 		CTRL_W = 23
                           000017    58 		ETB=CTRL_W   ; end of transmission block
                           000018    59 		CTRL_X = 24
                           000018    60 		CAN=CTRL_X   ; cancel 
                           000019    61 		CTRL_Y = 25
                           000019    62 		EM=CTRL_Y    ; end of medium
                           00001A    63 		CTRL_Z = 26
                           00001A    64 		SUB=CTRL_Z   ; substitute 
                           00001A    65 		EOF=SUB      ; end of text file in MSDOS 
                           00001B    66 		ESC = 27     ; escape 
                           00001C    67 		FS=28        ; file separator 
                           00001D    68 		GS=29        ; group separator 
                           00001E    69 		RS=30		 ; record separator 
                           00001F    70 		US=31 		 ; unit separator 
                           000020    71 		SPACE = 32   ; ' ' 
                           000021    72 		EXCLA	=	33  ; '!'
                           000022    73 		DQUOT	=	34  ; '"'	
                           000023    74 		SHARP =	35  ; '#'
                           000024    75 		DOLLR	=	36  ; '$'
                           000025    76 		PRCNT	=	37  ; '%'
                           000026    77 		AMP	=	38  ; '&'
                           000027    78 		TICK	=	39  ; '\''
                           000028    79 		LPAR	=	40  ; '('
                           000029    80 		RPAR  =	41  ; ')'
                           00002A    81 		STAR  =	42  ; '*'
                           00002B    82 		PLUS	=	43  ; '+'
                           00002C    83 		COMMA = 44  
                           00002D    84 		DASH  =	45  ; '-'
                           00002E    85 		DOT	=	46  ; '.'
                           00002F    86 		SLASH =	47  ; '/'
                           000030    87 		ZERO =	48  ; '0'
                           000031    88 		ONE	=	49  ; '1'
                           000032    89 		TWO 	=	50  ; '2'
                           000033    90 		THREE	=	51  ; '3'	
                           000034    91 		FOUR	=	52  ; '4'
                           000035    92 		FIVE	=	53  ; '5'
                           000036    93 		SIX	=	54  ; '6'
                           000037    94 		SEVEN	=	55  ; '7'
                           000038    95 		EIGHT	=	56  ; '8'
                           000039    96 		NINE	=	57  ; '9'
                           00003A    97 		COLON = 58 
                           00003B    98 		SEMIC = 59  
                           00003C    99 		LT	=	60  ; '<'
                           00003D   100 		EQUAL =	61  ; '='
                           00003E   101 		GT	=	62  ; '>'
                           00003F   102 		QUST	=	63  ; '?'
                           000040   103 		AROB	=	64  ; '@'
                           000041   104 		AU	=	65  ; 'A'
                           000042   105 		BU	=	66  ; 'B'
                           000043   106 		CU	=	67  ; 'C'
                           000044   107 		DU	=	68  ; 'D'
                           000045   108 		EU	=	69  ; 'E'
                           000046   109 		FU	=	70  ; 'F'
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 63.
Hexadecimal [24-Bits]



                           000047   110 		GU	=	71  ; 'G'
                           000048   111 		HU	=	72  ; 'H'
                           000049   112 		IU	=	73  ; 'I'
                           00004A   113 		JU	=	74  ; 'J'
                           00004B   114 		KU	=	75  ; 'K'
                           00004C   115 		LU	=	76  ; 'L'
                           00004D   116 		MU	=	77  ; 'M'
                           00004E   117 		NU	=	78  ; 'N'
                           00004F   118 		OU	=	79  ; 'O'
                           000050   119 		PU	=	80  ; 'P'
                           000051   120 		QU	=	81  ; 'Q'
                           000052   121 		RU	=	82  ; 'R'
                           000053   122 		SU	=	83  ; 'S'
                           000054   123 		TU	=	84  ; 'T'
                           000055   124 		UU	=	85  ; 'U'
                           000056   125 		VU	=	86  ; 'V'
                           000057   126 		WU	=	87  ; 'W'
                           000058   127 		XU	=	88  ; 'X'
                           000059   128 		YU	=	89  ; 'Y'
                           00005A   129 		ZU	=	90  ; 'Z'
                           00005B   130 		LBRK	=	91  ; '['
                           00005C   131 		BSLA	=	92  ; '\\'
                           00005D   132 		RBRK	=	93  ; ']'
                           00005E   133 		CIRC	=	94  ; '^'
                           00005F   134 		UNDR	=	95  ; '_'
                           000060   135 		ACUT	=	96  ; '`'
                           000061   136 		AL	=	97  ; 'a'
                           000062   137 		BL	=	98  ; 'b'
                           000063   138 		CL	=	99  ; 'c'
                           000064   139 		DL	=	100 ; 'd'
                           000065   140 		EL	=	101 ; 'e'
                           000066   141 		FL	=	102 ; 'f'
                           000067   142 		GL	=	103 ; 'g'
                           000068   143 		HL	=	104 ; 'h'
                           000069   144 		IL	=	105 ; 'i'
                           00006A   145 		JL	=	106 ; 'j'
                           00006B   146 		KL	=	107 ; 'k'
                           00006C   147 		LL	=	108 ; 'l'
                           00006D   148 		ML	=	109 ; 'm'
                           00006E   149 		NL	=	110 ; 'n'
                           00006F   150 		OL	=	111 ; 'o'
                           000070   151 		PL	=	112 ; 'p'
                           000071   152 		QL	=	113 ; 'q'
                           000072   153 		RL	=	114 ; 'r'
                           000073   154 		SL	=	115 ; 's'
                           000074   155 		TL	=	116 ; 't'
                           000075   156 		UL	=	117 ; 'u'
                           000076   157 		VL	=	118 ; 'v'
                           000077   158 		WL	=	119 ; 'w'
                           000078   159 		XL	=	120 ; 'x'
                           000079   160 		YL	=	121 ; 'y'
                           00007A   161 		ZL	=	122 ; 'z'
                           00007B   162 		LBRC	=	123 ; '{'
                           00007C   163 		PIPE	=	124 ; '|'
                           00007D   164 		RBRC	=	125 ; '}'
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 64.
Hexadecimal [24-Bits]



                           00007E   165 		TILD	=	126 ; '~'
                           00007F   166 		DEL	=	127 ; DELETE	
                                    167 	
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 65.
Hexadecimal [24-Bits]



                                     21     .include "ps2_codes.inc"
                                      1 
                                      2 ;;
                                      3 ; Copyright Jacques Deschênes 2023  
                                      4 ; This file is part of stm8_terminal 
                                      5 ;
                                      6 ;     stm8_terminal is free software: you can redistribute it and/or modify
                                      7 ;     it under the terms of the GNU General Public License as published by
                                      8 ;     the Free Software Foundation, either version 3 of the License, or
                                      9 ;     (at your option) any later version.
                                     10 ;
                                     11 ;     stm8_terminal is distributed in the hope that it will be useful,
                                     12 ;     but WITHOUT ANY WARRANTY; without even the implied warranty of
                                     13 ;     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
                                     14 ;     GNU General Public License for more details.
                                     15 ;
                                     16 ;     You should have received a copy of the GNU General Public License
                                     17 ;     along with stm8_terminal.  If not, see <http://www.gnu.org/licenses/>.
                                     18 ;;
                                     19 
                                     20 ; PS/2 keyaboard scancode
                                     21     
                                     22 ; keyboard control codes 
                           0000FF    23 KBD_RESET =	0xFF  ; commande RAZ clavier
                           0000ED    24 KBD_LED =	0xED  ; commande de contr�le des LEDS du clavier
                           0000FE    25 KBD_RESEND =  0xFE  ; demande de renvoie de la commande ou le code clavier
                                     26  
                                     27 ; keyboard state codes 
                           0000AA    28 BAT_OK =	0xAA ; basic test ok 
                           0000FA    29 KBD_ACK =	0xFA ; keyboard acknowledge 
                           0000F0    30 KEY_REL =	0xF0 ; key released prefix 
                           0000E0    31 XT_KEY =	0xE0 ; extended key prefix 
                           0000E1    32 XT2_KEY =	0xE1 ; PAUSE key sequence introducer 8 characters 
                                     33  
                                     34 ; control keys 
                           00000D    35 SC_TAB =	    0x0D    ;standard
                           00005A    36 SC_ENTER =	    0x5A    ;standard
                           000058    37 SC_CAPS =	    0x58    ;standard
                           000077    38 SC_NUM =	    0x77    ;standard
                           00007E    39 SC_SCROLL   =	    0x7E    ;standard
                           000012    40 SC_LSHIFT =	    0x12    ;standard
                           000059    41 SC_RSHIFT =	    0x59    ;standard
                           000014    42 SC_LCTRL =	    0x14    ;standard
                           000011    43 SC_LALT =	    0x11    ;standard
                           000066    44 SC_BKSP =	    0x66    ;standard
                           000076    45 SC_ESC =	    0x76    ;standard
                           000005    46 SC_F1 =	    0x05    ;standard
                           000006    47 SC_F2 =	    0x06    ;standard
                           000004    48 SC_F3 =	    0x04    ;standard
                           00000C    49 SC_F4 =	    0x0c    ;standard
                           000003    50 SC_F5 =	    0x03    ;standard
                           00000B    51 SC_F6 =	    0x0b    ;standard
                           000083    52 SC_F7 =	    0x83    ;standard
                           00000A    53 SC_F8 =	    0x0a    ;standard
                           000001    54 SC_F9 =	    0x01    ;standard
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 66.
Hexadecimal [24-Bits]



                           000009    55 SC_F10 =	    0x09    ;standard
                           000078    56 SC_F11 =	    0x78    ;standard
                           000007    57 SC_F12 =	    0x07    ;standard
                           00007C    58 SC_KPMUL =	    0x7c    ;standard
                           00007B    59 SC_KPMINUS =	    0x7b    ;standard
                           000079    60 SC_KPPLUS =	    0x79    ;standard
                           000071    61 SC_KPDOT =	    0x71    ;standard
                           000070    62 SC_KP0 =	    0x70    ;standard
                           000069    63 SC_KP1 =	    0x69    ;standard
                           000072    64 SC_KP2 =	    0x72    ;standard
                           00007A    65 SC_KP3 =	    0x7a    ;standard
                           00006B    66 SC_KP4 =	    0x6b    ;standard
                           000073    67 SC_KP5 =	    0x73    ;standard
                           000074    68 SC_KP6 =	    0x74    ;standard
                           00006C    69 SC_KP7 =	    0x6c    ;standard
                           000075    70 SC_KP8 =	    0x75    ;standard
                           00007D    71 SC_KP9 =	    0x7d    ;standard
                                     72 
                                     73 ; extended codes, i.e. preceded by 0xe0 code. 
                           000014    74 SC_RCTRL =   0x14
                           00001F    75 SC_LGUI =    0x1f
                           000027    76 SC_RGUI =    0x27 
                           000011    77 SC_RALT =    0x11
                           00002F    78 SC_APPS =    0x2f
                           000075    79 SC_UP	 =    0x75
                           000072    80 SC_DOWN =    0x72
                           00006B    81 SC_LEFT =    0x6B
                           000074    82 SC_RIGHT =   0x74
                           000070    83 SC_INSERT =  0x70
                           00006C    84 SC_HOME =    0x6c
                           00007D    85 SC_PGUP =    0x7d
                           00007A    86 SC_PGDN =    0x7a
                           000071    87 SC_DEL	 =    0x71
                           000069    88 SC_END	 =    0x69
                           00004A    89 SC_KPDIV =   0x4a
                           00005A    90 SC_KPENTER = 0x5a
                           00001F    91 SC_LWINDOW = 0x1f
                           000027    92 SC_RWINDOW = 0x27
                           00005D    93 SC_MENU = 0x5d 
                                     94  
                                     95 ;special codes sequences  
      008555 E0 12 E0 7C             96 SC_PRN: .byte 	    0xe0,0x12,0xe0,0x7c
      008559 E0 F0 7C E0 F0 12       97 SC_PRN_REL: .byte  0xe0,0xf0,0x7c,0xe0,0xf0,0x12 
      00855F E1 14 77 E1 F0 14 F0    98 SC_PAUSE: .byte    0xe1,0x14,0x77,0xe1,0xf0,0x14,0xf0,0x77
             77
                                     99 
                                    100  
                                    101 ;virtual keys 
                           000008   102 VK_BACK =	8
                           000009   103 VK_TAB =	9
                           00001B   104 VK_ESC =	27
                           00000D   105 VK_ENTER =	'\r'
                           000020   106 VK_SPACE =	' ' 
                           00007F   107 VK_DELETE =	127 
                           000080   108 VK_F1 =	128
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 67.
Hexadecimal [24-Bits]



                           000081   109 VK_F2 =	129
                           000082   110 VK_F3 =	130
                           000083   111 VK_F4 =	131
                           000084   112 VK_F5 =	132
                           000085   113 VK_F6 =	133
                           000086   114 VK_F7 =	134
                           000087   115 VK_F8 =	135
                           000088   116 VK_F9 =	136
                           00008A   117 VK_F10 =	138
                           00008B   118 VK_F11 =	139
                           00008C   119 VK_F12 =	140
                           00008D   120 VK_UP =	141
                           00008E   121 VK_DOWN =	142
                           00008F   122 VK_LEFT =	143
                           000090   123 VK_RIGHT =	144
                           000091   124 VK_HOME =	145
                           000092   125 VK_END =	146
                           000093   126 VK_PGUP =	147
                           000094   127 VK_PGDN =	148
                           000095   128 VK_INSERT =	149
                           000097   129 VK_APPS =	151
                           000098   130 VK_PRN	=	152
                           000099   131 VK_PAUSE =	153
                           00009A   132 VK_NLOCK =    154 ; numlock
                           00009B   133 VK_CLOCK =	155 ; capslock
                           00009C   134 VK_LSHIFT =	156
                           00009D   135 VK_LCTRL =	157
                           00009E   136 VK_LALT =	158
                           00009F   137 VK_RSHIFT =	159
                           0000A0   138 VK_LGUI =	160
                           0000A1   139 VK_RCTRL =	161
                           0000A2   140 VK_RGUI =	162
                           0000A3   141 VK_RALT =	163
                           0000A4   142 VK_SCROLL =	164
                           0000A5   143 VK_NUM	=	165 
                           0000A8   144 VK_CAPS =	168
                                    145 ;<SHIFT>-<KEY> 
                           0000A9   146 VK_SUP	=	169
                           0000AA   147 VK_SDOWN =	170
                           0000AB   148 VK_SLEFT =	171
                           0000AC   149 VK_SRIGHT =	172
                           0000AD   150 VK_SHOME =	173
                           0000AE   151 VK_SEND	=	174
                           0000AF   152 VK_SPGUP =	175
                           0000B0   153 VK_SPGDN =	176
                           0000BF   154 VK_SDEL  =    191
                                    155 ;<CTRL>-<KEY>
                           0000B1   156 VK_CUP	=	177
                           0000B2   157 VK_CDOWN =	178	
                           0000B3   158 VK_CLEFT =	179
                           0000B4   159 VK_CRIGHT =	180
                           0000B5   160 VK_CHOME =	181
                           0000B6   161 VK_CEND =	182
                           0000B7   162 VK_CPGUP =	183
                           0000B8   163 VK_CPGDN =	184
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 68.
Hexadecimal [24-Bits]



                           0000B9   164 VK_CDEL  =    185
                           0000BA   165 VK_CBACK =    186
                           0000BB   166 VK_LWINDOW =  187
                           0000BC   167 VK_RWINDOW =  188
                           0000BD   168 VK_MENU	=     189
                           0000BE   169 VK_SLEEP =	190	
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 69.
Hexadecimal [24-Bits]



                                     22     
                                     23     
                                     24     .area CODE 
                                     25     
                                     26 ;table de correspondance code clavier -> code ASCII    
                                     27 ;  .byte code_clavier,code_ascii 
      008567                         28 std_codes:
      008567 1C 41                   29    .byte 0x1c,'A' 
      008569 32 42                   30    .byte 0x32,'B'
      00856B 21 43                   31    .byte 0x21,'C'
      00856D 23 44                   32    .byte 0x23,'D'
      00856F 24 45                   33    .byte 0x24,'E'
      008571 2B 46                   34    .byte 0x2b,'F'
      008573 34 47                   35    .byte 0x34,'G'
      008575 33 48                   36    .byte 0x33,'H'
      008577 43 49                   37    .byte 0x43,'I'
      008579 3B 4A                   38    .byte 0x3B,'J'
      00857B 42 4B                   39    .byte 0x42,'K'
      00857D 4B 4C                   40    .byte 0x4b,'L'
      00857F 3A 4D                   41    .byte 0x3a,MU	;'M'
      008581 31 4E                   42    .byte 0x31,NU	;'N'
      008583 44 4F                   43    .byte 0x44,OU	;'O'
      008585 4D 50                   44    .byte 0x4d,PU	;'P'
      008587 15 51                   45    .byte 0x15,QU	;'Q'
      008589 2D 52                   46    .byte 0x2d,RU	;'R'
      00858B 1B 53                   47    .byte 0x1b,SU	;'S'
      00858D 2C 54                   48    .byte 0x2c,TU	;'T'
      00858F 3C 55                   49    .byte 0x3c,UU	;'U'
      008591 2A 56                   50    .byte 0x2a,VU	;'V'
      008593 1D 57                   51    .byte 0x1d,WU	;'W'
      008595 22 58                   52    .byte 0x22,XU	;'X'
      008597 35 59                   53    .byte 0x35,YU	;'Y'
      008599 1A 5A                   54    .byte 0x1a,ZU	;'Z'
      00859B 45 30                   55    .byte 0x45,ZERO	;'0'
      00859D 16 31                   56    .byte 0x16,ONE 	;'1'
      00859F 1E 32                   57    .byte 0x1e,TWO 	;'2'
      0085A1 26 33                   58    .byte 0x26,THREE	;'3'
      0085A3 25 34                   59    .byte 0x25,FOUR 	;'4'
      0085A5 2E 35                   60    .byte 0x2e,FIVE	;'5'
      0085A7 36 36                   61    .byte 0x36,SIX	;'6'
      0085A9 3D 37                   62    .byte 0x3d,SEVEN	;'7'
      0085AB 3E 38                   63    .byte 0x3e,EIGHT	;'8'
      0085AD 46 39                   64    .byte 0x46,NINE	;'9'
      0085AF 0E 60                   65    .byte 0x0e,ACUT   ;'`'
      0085B1 4E 2D                   66    .byte 0x4e,DASH   ;'-'
      0085B3 55 3D                   67    .byte 0x55,EQUAL  ;'='
      0085B5 5D 5C                   68    .byte 0x5d,BSLA   ;'\\'
      0085B7 54 5B                   69    .byte 0x54,LBRK   ;'['
      0085B9 5B 5D                   70    .byte 0x5b,RBRK   ;']'
      0085BB 4C 3B                   71    .byte 0x4c,SEMIC   ;';'
      0085BD 52 27                   72    .byte 0x52,TICK   ;'\''
      0085BF 41 2C                   73    .byte 0x41,COMMA   ;','
      0085C1 49 2E                   74    .byte 0x49,DOT    ;'.'
      0085C3 7C 2A                   75    .byte 0x7c,STAR   ;'*'
      0085C5 79 2B                   76    .byte 0x79,PLUS   ;'+'
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 70.
Hexadecimal [24-Bits]



      0085C7 29 20                   77    .byte 0x29,SPACE  ;' '
      0085C9 5A 0D                   78    .byte SC_ENTER,CR ;'\r'
      0085CB 66 08                   79    .byte SC_BKSP,BS	;back space
      0085CD 0D 09                   80    .byte SC_TAB,TAB  ; tabulation 
      0085CF 76 1B                   81    .byte SC_ESC,ESC  ; escape 
      0085D1 77 A5                   82    .byte SC_NUM,VK_NUM ; num lock
      0085D3 70 30                   83    .byte SC_KP0,ZERO    ;'0'
      0085D5 69 31                   84    .byte SC_KP1,ONE     ;'1'
      0085D7 72 32                   85    .byte SC_KP2,TWO     ;'2'
      0085D9 7A 33                   86    .byte SC_KP3,THREE    ;'3'
      0085DB 6B 34                   87    .byte SC_KP4,FOUR    ;'4'
      0085DD 73 35                   88    .byte SC_KP5,FIVE   ;'5'
      0085DF 74 36                   89    .byte SC_KP6,SIX     ;'6'
      0085E1 6C 37                   90    .byte SC_KP7,SEVEN    ;'7'
      0085E3 75 38                   91    .byte SC_KP8,EIGHT    ;'8'
      0085E5 7D 39                   92    .byte SC_KP9,NINE    ;'9'
      0085E7 7C 2A                   93    .byte SC_KPMUL,STAR	;'*'
      0085E9 4A 2F                   94    .byte SC_KPDIV,SLASH	;'/'
      0085EB 79 2B                   95    .byte SC_KPPLUS,PLUS	;'+'
      0085ED 7B 2D                   96    .byte SC_KPMINUS,DASH	;'-'
      0085EF 71 2E                   97    .byte SC_KPDOT,DOT	;'.'
      0085F1 5A 0D                   98    .byte SC_KPENTER,CR	;'\r'
      0085F3 05 80                   99    .byte SC_F1,VK_F1
      0085F5 06 81                  100    .byte SC_F2,VK_F2
      0085F7 04 82                  101    .byte SC_F3,VK_F3
      0085F9 0C 83                  102    .byte SC_F4,VK_F4
      0085FB 03 84                  103    .byte SC_F5,VK_F5
      0085FD 0B 85                  104    .byte SC_F6,VK_F6
      0085FF 83 86                  105    .byte SC_F7,VK_F7
      008601 0A 87                  106    .byte SC_F8,VK_F8
      008603 01 88                  107    .byte SC_F9,VK_F9
      008605 09 8A                  108    .byte SC_F10,VK_F10
      008607 78 8B                  109    .byte SC_F11,VK_F11
      008609 07 8C                  110    .byte SC_F12,VK_F12
      00860B 12 9C                  111    .byte SC_LSHIFT,VK_LSHIFT
      00860D 59 9F                  112    .byte SC_RSHIFT,VK_RSHIFT
      00860F 14 9D                  113    .byte SC_LCTRL,VK_LCTRL
      008611 11 9E                  114    .byte SC_LALT,VK_LALT
      008613 12 9C                  115    .byte SC_LSHIFT,VK_LSHIFT
      008615 59 9F                  116    .byte SC_RSHIFT,VK_RSHIFT
      008617 58 A8                  117    .byte SC_CAPS,VK_CAPS
      008619 00                     118    .byte 0
                                    119 
                                    120 ;; extended codes table 
      00861A                        121 xt_codes:
      00861A 14 A1                  122     .byte SC_RCTRL,VK_RCTRL
      00861C 1F A0                  123     .byte SC_LGUI,VK_LGUI
      00861E 27 A2                  124     .byte SC_RGUI,VK_RGUI 
      008620 11 A3                  125     .byte SC_RALT,VK_RALT
      008622 2F 97                  126     .byte SC_APPS,VK_APPS
      008624 75 8D                  127     .byte SC_UP,VK_UP
      008626 72 8E                  128     .byte SC_DOWN,VK_DOWN
      008628 6B 8F                  129     .byte SC_LEFT,VK_LEFT
      00862A 74 90                  130     .byte SC_RIGHT,VK_RIGHT
      00862C 70 95                  131     .byte SC_INSERT,VK_INSERT
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 71.
Hexadecimal [24-Bits]



      00862E 6C 91                  132     .byte SC_HOME,VK_HOME
      008630 7D 93                  133     .byte SC_PGUP,VK_PGUP
      008632 7A 94                  134     .byte SC_PGDN,VK_PGDN
      008634 71 7F                  135     .byte SC_DEL,DEL
      008636 69 92                  136     .byte SC_END,VK_END
      008638 4A 2F                  137     .byte SC_KPDIV,'/'
      00863A 5A 0D                  138     .byte SC_KPENTER,'\r'
      00863C 1F BB                  139     .byte SC_LWINDOW, VK_LWINDOW
      00863E 27 BC                  140     .byte SC_RWINDOW, VK_RWINDOW
      008640 5D BD                  141     .byte SC_MENU,VK_MENU
      008642 12 98                  142     .byte 0x12,VK_PRN
      008644 7C 00                  143     .byte 0x7c,0
      008646 00                     144     .byte 0
                                    145     
                                    146    
                                    147 ;;shifted codes 
      008647                        148 shifted_codes:
      008647 31 21                  149    .byte '1,EXCLA   ;'!'
      008649 32 40                  150    .byte '2,AROB    ;'@'
      00864B 33 23                  151    .byte '3,SHARP   ;'#'
      00864D 34 24                  152    .byte '4,DOLLR   ;'$'
      00864F 35 25                  153    .byte '5,PRCNT   ;'%'
      008651 36 5E                  154    .byte '6,CIRC    ;'^'
      008653 37 26                  155    .byte '7,AMP	    ;'&'
      008655 38 2A                  156    .byte '8,STAR    ;'*'
      008657 39 28                  157    .byte '9,LPAR    ;'('
      008659 30 29                  158    .byte '0,RPAR    ;')'
      00865B 2D 5F                  159    .byte DASH,UNDR ;'_'
      00865D 3D 2B                  160    .byte EQUAL,PLUS	;'+'
      00865F 60 7E                  161    .byte ACUT,TILD ;'~'
      008661 27 22                  162    .byte TICK,DQUOT	;'"'
      008663 2C 3C                  163    .byte COMMA,LT   ;'<'
      008665 2E 3E                  164    .byte DOT,GT    ;'>'
      008667 2F 3F                  165    .byte SLASH,QUST	;'?'
      008669 5C 7C                  166    .byte BSLA,PIPE ;'|'
      00866B 3B 3A                  167    .byte SEMIC,COLON  ;':'
      00866D 5B 7B                  168    .byte LBRK,LBRC ;'[','{'
      00866F 5D 7D                  169    .byte RBRK,RBRC ;']','}'
      008671 8D A9                  170    .byte VK_UP,VK_SUP  ; <SHIFT>-<UP>
      008673 8E AA                  171    .byte VK_DOWN,VK_SDOWN ; <SHIFT>-<DOWN>
      008675 8F AB                  172    .byte VK_LEFT,VK_SLEFT ; <SHIFT>-<LEFT>
      008677 90 AC                  173    .byte VK_RIGHT,VK_SRIGHT ; <SHIFT>-<RIGHT>
      008679 91 AD                  174    .byte VK_HOME,VK_SHOME ; <SHIFT>-<HOME>
      00867B 92 AE                  175    .byte VK_END,VK_SEND ; <SHIFT>-<END>
      00867D 93 AF                  176    .byte VK_PGUP,VK_SPGUP ; <SHIFT>-<PGUP>
      00867F 94 B0                  177    .byte VK_PGDN,VK_SPGDN ; <SHIFT>-<PGDN>
      008681 7F BF                  178    .byte VK_DELETE,VK_SDEL ; <SHIFT-<DELETE>
      008683 00                     179    .byte 0
                                    180    
                                    181 ;;altchar codes 
      008684                        182 altchar_codes:
      008684 31 5C                  183    .byte '1,BSLA    ;'\\'
      008686 32 40                  184    .byte '2,AROB    ;'2','@'
      008688 33 2F                  185    .byte '3,SLASH   ;'3','/'
      00868A 36 3F                  186    .byte '6,QUST    ;'6','?'
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 72.
Hexadecimal [24-Bits]



      00868C 37 7C                  187    .byte '7,PIPE    ;'7','|'
      00868E 39 7B                  188    .byte '9,LBRC    ;'9','{'
      008690 30 7D                  189    .byte '0,RBRC    ;'0','}'
      008692 00                     190    .byte 0
                                    191    
                                    192 ; CTRL alternate codes     
      008693                        193 control_codes: 
      008693 08 BA                  194     .byte BS,VK_CBACK  ; <CTRL>-<BACKSPACE>
      008695 8D B1                  195     .byte VK_UP,VK_CUP  ; <CTRL>-<UP>
      008697 8E B2                  196     .byte VK_DOWN,VK_CDOWN ; <CTRL>-<DOWN>
      008699 8F B3                  197     .byte VK_LEFT,VK_CLEFT ; <CTRL>-<LEFT>
      00869B 90 B4                  198     .byte VK_RIGHT,VK_CRIGHT ; <CTRL>-<RIGHT>
      00869D 91 B5                  199     .byte VK_HOME,VK_CHOME ; <CTRL>-<HOME>
      00869F 92 B6                  200     .byte VK_END,VK_CEND ; <CTRL>-<END>
      0086A1 93 B7                  201     .byte VK_PGUP,VK_CPGUP ; <CTRL>-<PGUP>
      0086A3 94 B8                  202     .byte VK_PGDN,VK_CPGDN ; <CTRL>-<PGDN>
      0086A5 7F B9                  203     .byte VK_DELETE,VK_CDEL ; <CTRL>-<DEL>
      0086A7 00                     204     .byte 0
                                    205     
                                    206 
                                    207 
                                    208 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 73.
Hexadecimal [24-Bits]



                                      1 ;
                                      2 ; Copyright Jacques Deschênes 2023 
                                      3 ; This file is part of stm8_terminal 
                                      4 ;
                                      5 ;     stm8_terminal is free software: you can redistribute it and/or modify
                                      6 ;     it under the terms of the GNU General Public License as published by
                                      7 ;     the Free Software Foundation, either version 3 of the License, or
                                      8 ;     (at your option) any later version.
                                      9 ;
                                     10 ;     stm8_terminal is distributed in the hope that it will be useful,
                                     11 ;     but WITHOUT ANY WARRANTY; without even the implied warranty of
                                     12 ;     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
                                     13 ;     GNU General Public License for more details.
                                     14 ;
                                     15 ;     You should have received a copy of the GNU General Public License
                                     16 ;     along with stm8_terminal.  If not, see <http://www.gnu.org/licenses/>.
                                     17 ;;
                                     18 
                           00500A    19 DTR_ODR=PC_ODR 
                           00500C    20 DTR_DDR=PC_DDR 
                           00500D    21 DTR_CR1=PC_CR1 
                           00500E    22 DTR_CR2=PC_CR2
                           000003    23 DTR_PIN=3 ; DTR_PIN on PC:3 
                                     24 
                           000001    25 .if MAX_FREQ 
                           00004B    26 CHAR_PER_LINE=75 ; xtal 24Mhz 
                           000000    27 .else 
                                     28 CHAR_PER_LINE=62  ; xtal 20Mhz 
                                     29 .endif 
                                     30 
                           000019    31 LINE_PER_SCREEN=25 
                           0000C8    32 VISIBLE_SCAN_LINES=200 
                                     33 
                           003D76    34 FR_HORZ=15734
                           0005F4    35 HLINE=(FMSTR*1000000/FR_HORZ-1); horizontal line duration 
                           0002FA    36 HALF_LINE=HLINE/2 ; half-line during sync. 
                           00002F    37 EPULSE=47 ; pulse width during pre and post equalization
                           000222    38 VPULSE=546 ; pulse width during vertical sync. 
                           00005E    39 HPULSE=94 ; 4.7µSec horizontal line sync pulse width. 
                           0000A0    40 LINE_DELAY=(160) 
                                     41 
                                     42 ; ntsc synchro phases 
                           000000    43 PH_VSYNC=0 
                           000001    44 PH_PRE_VIDEO=1
                           000002    45 PH_VIDEO=2 
                           000003    46 PH_POST_VIDEO=3 
                                     47 
                           000032    48 FIRST_VIDEO_LINE=50 
                           0000C8    49 VIDEO_LINES=200 
                                     50 
                                     51 ;ntsc flags 
                           000000    52 F_EVEN=0 ; odd/even field flag 
                           000001    53 F_CURSOR=1 ; tv cursor active 
                           000002    54 F_CUR_VISI=2 ; tv cursor state, 1 visible 
                           000003    55 F_LECHO=3 ; local echo 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 74.
Hexadecimal [24-Bits]



                           000004    56 F_VIDEO=4 ; enable video output 
                           000005    57 F_NO_DTR=5 ; forbid DTR during some operation
                           000006    58 F_CUR_TOGGLE=6 ; time to toggle cursor state 
                                     59 
                                     60 ;-------------------------------
                                     61     .area CODE 
                                     62 ;------------------------------
                                     63 
                                     64 ;------------------------------
                                     65 ; initialize TIMER1 for 
                                     66 ; NTSC synchronisation 
                                     67 ; signal 
                                     68 ;------------------------------
      0086A8                         69 ntsc_init:
      000628                         70     _clrz ntsc_flags 
      0086A8 3F 46                    1     .byte 0x3f, ntsc_flags 
      00062A                         71     _clrz ntsc_phase 
      0086AA 3F 47                    1     .byte 0x3f, ntsc_phase 
                                     72 ; set MOSI pin as output high-speed push-pull 
      0086AC 72 1C 50 0C      [ 1]   73     bset PC_DDR,#6 
      0086B0 72 1D 50 0A      [ 1]   74     bres PC_ODR,#6
      0086B4 72 1C 50 0D      [ 1]   75     bset PC_CR1,#6
      0086B8 72 1C 50 0E      [ 1]   76     bset PC_CR2,#6
                                     77 ; set PC:3 as DTR output 
      0086BC 72 16 50 0D      [ 1]   78     bset DTR_CR1,#DTR_PIN ; push-pull output 
      0086C0 72 16 50 0C      [ 1]   79     bset DTR_DDR,#DTR_PIN 
      0086C4 72 17 50 0A      [ 1]   80     bres DTR_ODR,#DTR_PIN      
      0086C8 72 5F 52 03      [ 1]   81     clr SPI_SR 
      0086CC 35 44 52 00      [ 1]   82     mov SPI_CR1,#(1<<SPI_CR1_SPE)|(1<<SPI_CR1_MSTR) 
      0086D0 72 5F 52 04      [ 1]   83     clr SPI_DR 
                                     84 ; initialize timer1 for pwm
                                     85 ; generate NTSC sync signal  
      0086D4 35 01 52 54      [ 1]   86     mov TIM1_IER,#1 ; UIE set 
      0086D8 72 1E 52 50      [ 1]   87     bset TIM1_CR1,#TIM1_CR1_ARPE ; auto preload enabled 
      0086DC 35 78 52 58      [ 1]   88     mov TIM1_CCMR1,#(7<<TIM1_CCMR1_OCMODE)  |(1<<TIM1_CCMR1_OC1PE)
      0086E0 72 10 52 5C      [ 1]   89     bset TIM1_CCER1,#0
      0086E4 72 1E 52 6D      [ 1]   90     bset TIM1_BKR,#7
                                     91 ; use channel 2 for video stream trigger 
                                     92 ; set pixel out delay   
      0086E8 35 60 52 59      [ 1]   93     mov TIM1_CCMR2,#(6<<TIM1_CCMR2_OCMODE) 
      0086EC 35 00 52 67      [ 1]   94     mov TIM1_CCR2H,#LINE_DELAY>>8 
      0086F0 35 A0 52 68      [ 1]   95     mov TIM1_CCR2L,#LINE_DELAY&0xFF
                                     96 ;    bset TIM1_CCER1,#0      
                                     97 ; begin with PH_PRE_EQU odd field 
      000674                         98     _clrz ntsc_phase 
      0086F4 3F 47                    1     .byte 0x3f, ntsc_phase 
      0086F6 35 05 52 62      [ 1]   99     mov TIM1_ARRH,#HLINE>>8
      0086FA 35 F4 52 63      [ 1]  100     mov TIM1_ARRL,#HLINE&0XFF
      0086FE 35 00 52 65      [ 1]  101     mov TIM1_CCR1H,#HPULSE>>8 
      008702 35 5E 52 66      [ 1]  102     mov TIM1_CCR1L,#HPULSE&0XFF
      008706 CD 87 47         [ 4]  103     call copy_font
                                    104 ; test for local echo option
      008709 72 01 50 10 04   [ 2]  105     btjf ECHO_PORT,#ECHO_BIT,1$
      00870E 72 16 00 46      [ 1]  106     bset ntsc_flags,#F_LECHO ; set local echo 
      008712                        107 1$:    
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 75.
Hexadecimal [24-Bits]



      008712 CD 92 0E         [ 4]  108     call tv_cls 
      008715 CD 91 FE         [ 4]  109     call tv_enable_cursor
      008718 72 10 52 50      [ 1]  110     bset TIM1_CR1,#TIM1_CR1_CEN 
      00871C A6 14            [ 1]  111     ld a,#CURSOR_DELAY
      00069E                        112     _straz cursor_delay
      00871E B7 4E                    1     .byte 0xb7,cursor_delay 
      008720 A6 01            [ 1]  113     ld a,#1
      008722 CD 87 26         [ 4]  114     call video_on_off 
      008725 81               [ 4]  115     ret 
                                    116 
                                    117 ;--------------------
                                    118 ; enable|disable 
                                    119 ; video output 
                                    120 ; input:
                                    121 ;   A    0->off 
                                    122 ;        1->on
                                    123 ;--------------------
      008726                        124 video_on_off:
      008726 4D               [ 1]  125     tnz a 
      008727 27 0D            [ 1]  126     jreq 1$ 
                                    127 ; enable video 
      008729 72 18 00 46      [ 1]  128     bset ntsc_flags,#F_VIDEO 
      00872D 72 12 00 46      [ 1]  129     bset ntsc_flags,#F_CURSOR
      008731 72 10 52 54      [ 1]  130     bset TIM1_IER,#TIM1_IER_UIE 
      008735 81               [ 4]  131     ret     
      008736                        132 1$: ; disable video 
      008736 72 19 00 46      [ 1]  133     bres ntsc_flags,#F_VIDEO 
      00873A 72 13 00 46      [ 1]  134     bres ntsc_flags,#F_CURSOR
      00873E 72 15 52 54      [ 1]  135     bres TIM1_IER,#TIM1_IER_CC2IE 
      008742 72 10 52 54      [ 1]  136     bset TIM1_IER,#TIM1_IER_UIE 
      008746 81               [ 4]  137     ret 
                                    138 
                                    139 
                                    140 ;----------------------------------
                                    141 ; copying font table to RAM 
                                    142 ; save 2µsec per scan line display 
                                    143 ; in ntsc_video_interrupt
                                    144 ;----------------------------------
      008747                        145 copy_font:
      008747 AE 91 CA         [ 2]  146 	ldw x,#font_end 
      00874A 1D 8E 92         [ 2]  147 	subw x,#font_6x8 
      0006CD                        148 	_strxz acc16 
      00874D BF 04                    1     .byte 0xbf,acc16 
      00874F AE 01 00         [ 2]  149 	ldw x,#256 
      008752 90 AE 8E 92      [ 2]  150 	ldw y,#font_6x8 
      008756 CD 82 2E         [ 4]  151 	call move 
      008759 AE 01 00         [ 2]  152 	ldw x,#256 
      0006DC                        153 	_strxz font_addr 
      00875C BF 4A                    1     .byte 0xbf,font_addr 
      00875E 81               [ 4]  154     ret 
                                    155 
                                    156 ;-------------------------------
                                    157 ; TIMER1 update interrupt handler 
                                    158 ; interrupt happend at end 
                                    159 ; of each phase and and pwm 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 76.
Hexadecimal [24-Bits]



                                    160 ; is set for next phase 
                                    161 ;-------------------------------
      00875F                        162 ntsc_sync_interrupt:
      00875F 72 5F 52 55      [ 1]  163     clr TIM1_SR1 
      0006E3                        164     _ldxz scan_line 
      008763 BE 48                    1     .byte 0xbe,scan_line 
      008765 5C               [ 1]  165     incw x 
      0006E6                        166     _strxz scan_line 
      008766 BF 48                    1     .byte 0xbf,scan_line 
      0006E8                        167     _ldaz ntsc_phase 
      008768 B6 47                    1     .byte 0xb6,ntsc_phase 
      00876A A1 00            [ 1]  168     cp a,#PH_VSYNC  
      00876C 26 5D            [ 1]  169     jrne test_pre_video 
      00876E A3 00 01         [ 2]  170     cpw x,#1 
      008771 26 13            [ 1]  171     jrne  1$ 
      008773 35 02 52 62      [ 1]  172     mov TIM1_ARRH,#HALF_LINE>>8 
      008777 35 FA 52 63      [ 1]  173     mov TIM1_ARRL,#HALF_LINE & 0xff 
      00877B 35 00 52 65      [ 1]  174     mov TIM1_CCR1H,#EPULSE>>8 
      00877F 35 2F 52 66      [ 1]  175     mov TIM1_CCR1L,#EPULSE&0xff 
      008783 CC 88 0F         [ 2]  176     jp sync_exit 
      008786 A3 00 07         [ 2]  177 1$: cpw x,#7 
      008789 26 0B            [ 1]  178     jrne 2$ 
      00878B 35 02 52 65      [ 1]  179     mov TIM1_CCR1H,#VPULSE>>8 
      00878F 35 22 52 66      [ 1]  180     mov TIM1_CCR1L,#VPULSE&0xff 
      008793 CC 88 0F         [ 2]  181     jp sync_exit 
      008796                        182 2$:
      008796 A3 00 0D         [ 2]  183     cpw x,#13 
      008799 26 0B            [ 1]  184     jrne 3$ 
      00879B 35 00 52 65      [ 1]  185     mov TIM1_CCR1H,#EPULSE>>8 
      00879F 35 2F 52 66      [ 1]  186     mov TIM1_CCR1L,#EPULSE&0xff 
      0087A3 CC 88 0F         [ 2]  187     jp sync_exit 
      0087A6                        188 3$: 
      0087A6 A3 00 12         [ 2]  189     cpw x,#18 
      0087A9 26 19            [ 1]  190     jrne 5$ 
      0087AB 72 00 00 46 5F   [ 2]  191     btjt ntsc_flags,#F_EVEN,sync_exit 
      0087B0                        192 4$:
      0087B0 35 05 52 62      [ 1]  193     mov TIM1_ARRH,#HLINE>>8 
      0087B4 35 F4 52 63      [ 1]  194     mov TIM1_ARRL,#HLINE & 0xff 
      0087B8 35 00 52 65      [ 1]  195     mov TIM1_CCR1H,#HPULSE>>8 
      0087BC 35 5E 52 66      [ 1]  196     mov TIM1_CCR1L,#HPULSE&0xff 
      0087C0 4C               [ 1]  197     inc a 
      0087C1 CC 88 0F         [ 2]  198     jp sync_exit 
      0087C4                        199 5$: 
      0087C4 A3 00 13         [ 2]  200     cpw x,#19 
      0087C7 27 E7            [ 1]  201     jreq 4$ 
      0087C9 20 44            [ 2]  202     jra sync_exit 
      0087CB                        203 test_pre_video:
      0087CB A1 01            [ 1]  204     cp a,#PH_PRE_VIDEO 
      0087CD 26 1F            [ 1]  205     jrne post_video  
      0087CF A3 00 14         [ 2]  206     cpw x,#20 
      0087D2 26 05            [ 1]  207     jrne 2$
      0087D4 CD 91 CA         [ 4]  208     call cursor_blink_handler
      0087D7 20 36            [ 2]  209     jra sync_exit
      0087D9                        210 2$:
      0087D9 A3 00 32         [ 2]  211     cpw x,#FIRST_VIDEO_LINE
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 77.
Hexadecimal [24-Bits]



      0087DC 26 31            [ 1]  212     jrne sync_exit 
      0087DE 4C               [ 1]  213     inc a 
      0087DF 72 09 00 46 2B   [ 2]  214     btjf ntsc_flags,#F_VIDEO,sync_exit
      0087E4 72 11 52 54      [ 1]  215     bres TIM1_IER,#TIM1_IER_UIE 
      0087E8 72 14 52 54      [ 1]  216     bset TIM1_IER,#TIM1_IER_CC2IE
      0087EC 20 21            [ 2]  217     jra sync_exit
      0087EE                        218 post_video:
      0087EE A3 01 0F         [ 2]  219     cpw x,#271
      0087F1 26 07            [ 1]  220     jrne 2$ 
      0087F3 72 01 00 46 0F   [ 2]  221     btjf ntsc_flags,#F_EVEN,#3$  
      0087F8 20 15            [ 2]  222     jra sync_exit  
      0087FA                        223 2$: 
      0087FA A3 01 10         [ 2]  224     cpw x,#272 
      0087FD 26 10            [ 1]  225     jrne sync_exit 
      0087FF 35 02 52 62      [ 1]  226     mov TIM1_ARRH,#HALF_LINE>>8
      008803 35 FA 52 63      [ 1]  227     mov TIM1_ARRL,#HALF_LINE & 0xff 
      008807                        228 3$: ;field end     
      008807 4F               [ 1]  229     clr a 
      008808 5F               [ 1]  230     clrw x 
      000789                        231     _strxz scan_line
      008809 BF 48                    1     .byte 0xbf,scan_line 
      00880B 90 10 00 46      [ 1]  232     bcpl ntsc_flags,#F_EVEN
      00880F                        233 sync_exit:
      00078F                        234     _straz ntsc_phase
      00880F B7 47                    1     .byte 0xb7,ntsc_phase 
      008811 80               [11]  235     iret 
                                    236 
                                    237 
                                    238 
                                    239 ;----------------------------------
                                    240 ; TIMER1 compare interrupt handler
                                    241 ;----------------------------------
                                    242     .macro _shift_out_scan_line
                                    243         n=0
                                    244 
                                    245         .rept CHAR_PER_LINE
                                    246             ldw y,x  ; 1cy 
                                    247             ldw y,(n,y)  ; 2 cy 
                                    248             addw y,(FONT_ROW,sp) ; 2 cy 
                                    249             ld a,(y) ; 1 cy 
                                    250              btjf SPI_SR,#SPI_SR_TXE,. ; 2 cy 
                                    251              ld SPI_DR,a ; 1 cy 
                                    252             n=n+2 
                                    253         .endm ;
                                    254     .endm  9 cy
                                    255 
                           000001   256     FONT_ROW=1 ; font_char_row  
                           000002   257     VSIZE=2  
      008812                        258 ntsc_video_interrupt:
      000792                        259     _vars VSIZE
      008812 52 02            [ 2]    1     sub sp,#VSIZE 
      008814 0F 01            [ 1]  260     clr (FONT_ROW,sp) 
      008816 72 5F 52 55      [ 1]  261     clr TIM1_SR1
      00881A 72 0A 00 46 04   [ 2]  262     btjt ntsc_flags,#F_NO_DTR,1$
      00881F 72 16 50 0A      [ 1]  263     bset DTR_ODR,#DTR_PIN 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 78.
Hexadecimal [24-Bits]



      008823                        264 1$:
      008823 C6 52 5F         [ 1]  265     ld a,TIM1_CNTRL 
      008826 A4 07            [ 1]  266     and a,#7 
      008828 88               [ 1]  267     push a 
      008829 4B 00            [ 1]  268     push #0 
      00882B AE 88 34         [ 2]  269     ldw x,#jitter_cancel 
      00882E 72 FB 01         [ 2]  270     addw x,(1,sp)
      0007B1                        271     _drop 2 
      008831 5B 02            [ 2]    1     addw sp,#2 
      008833 FC               [ 2]  272     jp (x)
      008834                        273 jitter_cancel:
      008834 9D               [ 1]  274     nop 
      008835 9D               [ 1]  275     nop 
      008836 9D               [ 1]  276     nop 
      008837 9D               [ 1]  277     nop 
      008838 9D               [ 1]  278     nop 
      008839 9D               [ 1]  279     nop 
      00883A 9D               [ 1]  280     nop 
                                    281 ; compute postion in buffer 
                                    282 ; X=scan_line/16*CHAR_PER_LINE+video_buffer  
                                    283 ; FONT_ROW=scan_line%8     
      0007BB                        284     _ldxz scan_line 
      00883B BE 48                    1     .byte 0xbe,scan_line 
      00883D 1D 00 32         [ 2]  285     subw x,#FIRST_VIDEO_LINE
      008840 A6 08            [ 1]  286     ld a,#8 
      008842 62               [ 2]  287     div x,a
      008843 6B 02            [ 1]  288     ld (FONT_ROW+1,sp),a    
      008845 A6 96            [ 1]  289     ld a,#2*CHAR_PER_LINE  
      008847 42               [ 4]  290     mul x,a  ; video_buffer line  
      008848 1C 08 DA         [ 2]  291     addw x,#video_buffer
                                    292 ;    bset SPI_CR1,#SPI_CR1_SPE  
      00884B 72 5F 52 04      [ 1]  293 clr SPI_DR
      0007CF                        294     _shift_out_scan_line
                           000000     1         n=0
                                      2 
                                      3         .rept CHAR_PER_LINE
                                      4             ldw y,x  ; 1cy 
                                      5             ldw y,(n,y)  ; 2 cy 
                                      6             addw y,(FONT_ROW,sp) ; 2 cy 
                                      7             ld a,(y) ; 1 cy 
                                      8              btjf SPI_SR,#SPI_SR_TXE,. ; 2 cy 
                                      9              ld SPI_DR,a ; 1 cy 
                                     10             n=n+2 
                                     11         .endm ;
      00884F 90 93            [ 1]    1             ldw y,x  ; 1cy 
      008851 90 EE 00         [ 2]    2             ldw y,(n,y)  ; 2 cy 
      008854 72 F9 01         [ 2]    3             addw y,(FONT_ROW,sp) ; 2 cy 
      008857 90 F6            [ 1]    4             ld a,(y) ; 1 cy 
      008859 72 03 52 03 FB   [ 2]    5              btjf SPI_SR,#SPI_SR_TXE,. ; 2 cy 
      00885E C7 52 04         [ 1]    6              ld SPI_DR,a ; 1 cy 
                           000002     7             n=n+2 
      008861 90 93            [ 1]    1             ldw y,x  ; 1cy 
      008863 90 EE 02         [ 2]    2             ldw y,(n,y)  ; 2 cy 
      008866 72 F9 01         [ 2]    3             addw y,(FONT_ROW,sp) ; 2 cy 
      008869 90 F6            [ 1]    4             ld a,(y) ; 1 cy 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 79.
Hexadecimal [24-Bits]



      00886B 72 03 52 03 FB   [ 2]    5              btjf SPI_SR,#SPI_SR_TXE,. ; 2 cy 
      008870 C7 52 04         [ 1]    6              ld SPI_DR,a ; 1 cy 
                           000004     7             n=n+2 
      008873 90 93            [ 1]    1             ldw y,x  ; 1cy 
      008875 90 EE 04         [ 2]    2             ldw y,(n,y)  ; 2 cy 
      008878 72 F9 01         [ 2]    3             addw y,(FONT_ROW,sp) ; 2 cy 
      00887B 90 F6            [ 1]    4             ld a,(y) ; 1 cy 
      00887D 72 03 52 03 FB   [ 2]    5              btjf SPI_SR,#SPI_SR_TXE,. ; 2 cy 
      008882 C7 52 04         [ 1]    6              ld SPI_DR,a ; 1 cy 
                           000006     7             n=n+2 
      008885 90 93            [ 1]    1             ldw y,x  ; 1cy 
      008887 90 EE 06         [ 2]    2             ldw y,(n,y)  ; 2 cy 
      00888A 72 F9 01         [ 2]    3             addw y,(FONT_ROW,sp) ; 2 cy 
      00888D 90 F6            [ 1]    4             ld a,(y) ; 1 cy 
      00888F 72 03 52 03 FB   [ 2]    5              btjf SPI_SR,#SPI_SR_TXE,. ; 2 cy 
      008894 C7 52 04         [ 1]    6              ld SPI_DR,a ; 1 cy 
                           000008     7             n=n+2 
      008897 90 93            [ 1]    1             ldw y,x  ; 1cy 
      008899 90 EE 08         [ 2]    2             ldw y,(n,y)  ; 2 cy 
      00889C 72 F9 01         [ 2]    3             addw y,(FONT_ROW,sp) ; 2 cy 
      00889F 90 F6            [ 1]    4             ld a,(y) ; 1 cy 
      0088A1 72 03 52 03 FB   [ 2]    5              btjf SPI_SR,#SPI_SR_TXE,. ; 2 cy 
      0088A6 C7 52 04         [ 1]    6              ld SPI_DR,a ; 1 cy 
                           00000A     7             n=n+2 
      0088A9 90 93            [ 1]    1             ldw y,x  ; 1cy 
      0088AB 90 EE 0A         [ 2]    2             ldw y,(n,y)  ; 2 cy 
      0088AE 72 F9 01         [ 2]    3             addw y,(FONT_ROW,sp) ; 2 cy 
      0088B1 90 F6            [ 1]    4             ld a,(y) ; 1 cy 
      0088B3 72 03 52 03 FB   [ 2]    5              btjf SPI_SR,#SPI_SR_TXE,. ; 2 cy 
      0088B8 C7 52 04         [ 1]    6              ld SPI_DR,a ; 1 cy 
                           00000C     7             n=n+2 
      0088BB 90 93            [ 1]    1             ldw y,x  ; 1cy 
      0088BD 90 EE 0C         [ 2]    2             ldw y,(n,y)  ; 2 cy 
      0088C0 72 F9 01         [ 2]    3             addw y,(FONT_ROW,sp) ; 2 cy 
      0088C3 90 F6            [ 1]    4             ld a,(y) ; 1 cy 
      0088C5 72 03 52 03 FB   [ 2]    5              btjf SPI_SR,#SPI_SR_TXE,. ; 2 cy 
      0088CA C7 52 04         [ 1]    6              ld SPI_DR,a ; 1 cy 
                           00000E     7             n=n+2 
      0088CD 90 93            [ 1]    1             ldw y,x  ; 1cy 
      0088CF 90 EE 0E         [ 2]    2             ldw y,(n,y)  ; 2 cy 
      0088D2 72 F9 01         [ 2]    3             addw y,(FONT_ROW,sp) ; 2 cy 
      0088D5 90 F6            [ 1]    4             ld a,(y) ; 1 cy 
      0088D7 72 03 52 03 FB   [ 2]    5              btjf SPI_SR,#SPI_SR_TXE,. ; 2 cy 
      0088DC C7 52 04         [ 1]    6              ld SPI_DR,a ; 1 cy 
                           000010     7             n=n+2 
      0088DF 90 93            [ 1]    1             ldw y,x  ; 1cy 
      0088E1 90 EE 10         [ 2]    2             ldw y,(n,y)  ; 2 cy 
      0088E4 72 F9 01         [ 2]    3             addw y,(FONT_ROW,sp) ; 2 cy 
      0088E7 90 F6            [ 1]    4             ld a,(y) ; 1 cy 
      0088E9 72 03 52 03 FB   [ 2]    5              btjf SPI_SR,#SPI_SR_TXE,. ; 2 cy 
      0088EE C7 52 04         [ 1]    6              ld SPI_DR,a ; 1 cy 
                           000012     7             n=n+2 
      0088F1 90 93            [ 1]    1             ldw y,x  ; 1cy 
      0088F3 90 EE 12         [ 2]    2             ldw y,(n,y)  ; 2 cy 
      0088F6 72 F9 01         [ 2]    3             addw y,(FONT_ROW,sp) ; 2 cy 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 80.
Hexadecimal [24-Bits]



      0088F9 90 F6            [ 1]    4             ld a,(y) ; 1 cy 
      0088FB 72 03 52 03 FB   [ 2]    5              btjf SPI_SR,#SPI_SR_TXE,. ; 2 cy 
      008900 C7 52 04         [ 1]    6              ld SPI_DR,a ; 1 cy 
                           000014     7             n=n+2 
      008903 90 93            [ 1]    1             ldw y,x  ; 1cy 
      008905 90 EE 14         [ 2]    2             ldw y,(n,y)  ; 2 cy 
      008908 72 F9 01         [ 2]    3             addw y,(FONT_ROW,sp) ; 2 cy 
      00890B 90 F6            [ 1]    4             ld a,(y) ; 1 cy 
      00890D 72 03 52 03 FB   [ 2]    5              btjf SPI_SR,#SPI_SR_TXE,. ; 2 cy 
      008912 C7 52 04         [ 1]    6              ld SPI_DR,a ; 1 cy 
                           000016     7             n=n+2 
      008915 90 93            [ 1]    1             ldw y,x  ; 1cy 
      008917 90 EE 16         [ 2]    2             ldw y,(n,y)  ; 2 cy 
      00891A 72 F9 01         [ 2]    3             addw y,(FONT_ROW,sp) ; 2 cy 
      00891D 90 F6            [ 1]    4             ld a,(y) ; 1 cy 
      00891F 72 03 52 03 FB   [ 2]    5              btjf SPI_SR,#SPI_SR_TXE,. ; 2 cy 
      008924 C7 52 04         [ 1]    6              ld SPI_DR,a ; 1 cy 
                           000018     7             n=n+2 
      008927 90 93            [ 1]    1             ldw y,x  ; 1cy 
      008929 90 EE 18         [ 2]    2             ldw y,(n,y)  ; 2 cy 
      00892C 72 F9 01         [ 2]    3             addw y,(FONT_ROW,sp) ; 2 cy 
      00892F 90 F6            [ 1]    4             ld a,(y) ; 1 cy 
      008931 72 03 52 03 FB   [ 2]    5              btjf SPI_SR,#SPI_SR_TXE,. ; 2 cy 
      008936 C7 52 04         [ 1]    6              ld SPI_DR,a ; 1 cy 
                           00001A     7             n=n+2 
      008939 90 93            [ 1]    1             ldw y,x  ; 1cy 
      00893B 90 EE 1A         [ 2]    2             ldw y,(n,y)  ; 2 cy 
      00893E 72 F9 01         [ 2]    3             addw y,(FONT_ROW,sp) ; 2 cy 
      008941 90 F6            [ 1]    4             ld a,(y) ; 1 cy 
      008943 72 03 52 03 FB   [ 2]    5              btjf SPI_SR,#SPI_SR_TXE,. ; 2 cy 
      008948 C7 52 04         [ 1]    6              ld SPI_DR,a ; 1 cy 
                           00001C     7             n=n+2 
      00894B 90 93            [ 1]    1             ldw y,x  ; 1cy 
      00894D 90 EE 1C         [ 2]    2             ldw y,(n,y)  ; 2 cy 
      008950 72 F9 01         [ 2]    3             addw y,(FONT_ROW,sp) ; 2 cy 
      008953 90 F6            [ 1]    4             ld a,(y) ; 1 cy 
      008955 72 03 52 03 FB   [ 2]    5              btjf SPI_SR,#SPI_SR_TXE,. ; 2 cy 
      00895A C7 52 04         [ 1]    6              ld SPI_DR,a ; 1 cy 
                           00001E     7             n=n+2 
      00895D 90 93            [ 1]    1             ldw y,x  ; 1cy 
      00895F 90 EE 1E         [ 2]    2             ldw y,(n,y)  ; 2 cy 
      008962 72 F9 01         [ 2]    3             addw y,(FONT_ROW,sp) ; 2 cy 
      008965 90 F6            [ 1]    4             ld a,(y) ; 1 cy 
      008967 72 03 52 03 FB   [ 2]    5              btjf SPI_SR,#SPI_SR_TXE,. ; 2 cy 
      00896C C7 52 04         [ 1]    6              ld SPI_DR,a ; 1 cy 
                           000020     7             n=n+2 
      00896F 90 93            [ 1]    1             ldw y,x  ; 1cy 
      008971 90 EE 20         [ 2]    2             ldw y,(n,y)  ; 2 cy 
      008974 72 F9 01         [ 2]    3             addw y,(FONT_ROW,sp) ; 2 cy 
      008977 90 F6            [ 1]    4             ld a,(y) ; 1 cy 
      008979 72 03 52 03 FB   [ 2]    5              btjf SPI_SR,#SPI_SR_TXE,. ; 2 cy 
      00897E C7 52 04         [ 1]    6              ld SPI_DR,a ; 1 cy 
                           000022     7             n=n+2 
      008981 90 93            [ 1]    1             ldw y,x  ; 1cy 
      008983 90 EE 22         [ 2]    2             ldw y,(n,y)  ; 2 cy 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 81.
Hexadecimal [24-Bits]



      008986 72 F9 01         [ 2]    3             addw y,(FONT_ROW,sp) ; 2 cy 
      008989 90 F6            [ 1]    4             ld a,(y) ; 1 cy 
      00898B 72 03 52 03 FB   [ 2]    5              btjf SPI_SR,#SPI_SR_TXE,. ; 2 cy 
      008990 C7 52 04         [ 1]    6              ld SPI_DR,a ; 1 cy 
                           000024     7             n=n+2 
      008993 90 93            [ 1]    1             ldw y,x  ; 1cy 
      008995 90 EE 24         [ 2]    2             ldw y,(n,y)  ; 2 cy 
      008998 72 F9 01         [ 2]    3             addw y,(FONT_ROW,sp) ; 2 cy 
      00899B 90 F6            [ 1]    4             ld a,(y) ; 1 cy 
      00899D 72 03 52 03 FB   [ 2]    5              btjf SPI_SR,#SPI_SR_TXE,. ; 2 cy 
      0089A2 C7 52 04         [ 1]    6              ld SPI_DR,a ; 1 cy 
                           000026     7             n=n+2 
      0089A5 90 93            [ 1]    1             ldw y,x  ; 1cy 
      0089A7 90 EE 26         [ 2]    2             ldw y,(n,y)  ; 2 cy 
      0089AA 72 F9 01         [ 2]    3             addw y,(FONT_ROW,sp) ; 2 cy 
      0089AD 90 F6            [ 1]    4             ld a,(y) ; 1 cy 
      0089AF 72 03 52 03 FB   [ 2]    5              btjf SPI_SR,#SPI_SR_TXE,. ; 2 cy 
      0089B4 C7 52 04         [ 1]    6              ld SPI_DR,a ; 1 cy 
                           000028     7             n=n+2 
      0089B7 90 93            [ 1]    1             ldw y,x  ; 1cy 
      0089B9 90 EE 28         [ 2]    2             ldw y,(n,y)  ; 2 cy 
      0089BC 72 F9 01         [ 2]    3             addw y,(FONT_ROW,sp) ; 2 cy 
      0089BF 90 F6            [ 1]    4             ld a,(y) ; 1 cy 
      0089C1 72 03 52 03 FB   [ 2]    5              btjf SPI_SR,#SPI_SR_TXE,. ; 2 cy 
      0089C6 C7 52 04         [ 1]    6              ld SPI_DR,a ; 1 cy 
                           00002A     7             n=n+2 
      0089C9 90 93            [ 1]    1             ldw y,x  ; 1cy 
      0089CB 90 EE 2A         [ 2]    2             ldw y,(n,y)  ; 2 cy 
      0089CE 72 F9 01         [ 2]    3             addw y,(FONT_ROW,sp) ; 2 cy 
      0089D1 90 F6            [ 1]    4             ld a,(y) ; 1 cy 
      0089D3 72 03 52 03 FB   [ 2]    5              btjf SPI_SR,#SPI_SR_TXE,. ; 2 cy 
      0089D8 C7 52 04         [ 1]    6              ld SPI_DR,a ; 1 cy 
                           00002C     7             n=n+2 
      0089DB 90 93            [ 1]    1             ldw y,x  ; 1cy 
      0089DD 90 EE 2C         [ 2]    2             ldw y,(n,y)  ; 2 cy 
      0089E0 72 F9 01         [ 2]    3             addw y,(FONT_ROW,sp) ; 2 cy 
      0089E3 90 F6            [ 1]    4             ld a,(y) ; 1 cy 
      0089E5 72 03 52 03 FB   [ 2]    5              btjf SPI_SR,#SPI_SR_TXE,. ; 2 cy 
      0089EA C7 52 04         [ 1]    6              ld SPI_DR,a ; 1 cy 
                           00002E     7             n=n+2 
      0089ED 90 93            [ 1]    1             ldw y,x  ; 1cy 
      0089EF 90 EE 2E         [ 2]    2             ldw y,(n,y)  ; 2 cy 
      0089F2 72 F9 01         [ 2]    3             addw y,(FONT_ROW,sp) ; 2 cy 
      0089F5 90 F6            [ 1]    4             ld a,(y) ; 1 cy 
      0089F7 72 03 52 03 FB   [ 2]    5              btjf SPI_SR,#SPI_SR_TXE,. ; 2 cy 
      0089FC C7 52 04         [ 1]    6              ld SPI_DR,a ; 1 cy 
                           000030     7             n=n+2 
      0089FF 90 93            [ 1]    1             ldw y,x  ; 1cy 
      008A01 90 EE 30         [ 2]    2             ldw y,(n,y)  ; 2 cy 
      008A04 72 F9 01         [ 2]    3             addw y,(FONT_ROW,sp) ; 2 cy 
      008A07 90 F6            [ 1]    4             ld a,(y) ; 1 cy 
      008A09 72 03 52 03 FB   [ 2]    5              btjf SPI_SR,#SPI_SR_TXE,. ; 2 cy 
      008A0E C7 52 04         [ 1]    6              ld SPI_DR,a ; 1 cy 
                           000032     7             n=n+2 
      008A11 90 93            [ 1]    1             ldw y,x  ; 1cy 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 82.
Hexadecimal [24-Bits]



      008A13 90 EE 32         [ 2]    2             ldw y,(n,y)  ; 2 cy 
      008A16 72 F9 01         [ 2]    3             addw y,(FONT_ROW,sp) ; 2 cy 
      008A19 90 F6            [ 1]    4             ld a,(y) ; 1 cy 
      008A1B 72 03 52 03 FB   [ 2]    5              btjf SPI_SR,#SPI_SR_TXE,. ; 2 cy 
      008A20 C7 52 04         [ 1]    6              ld SPI_DR,a ; 1 cy 
                           000034     7             n=n+2 
      008A23 90 93            [ 1]    1             ldw y,x  ; 1cy 
      008A25 90 EE 34         [ 2]    2             ldw y,(n,y)  ; 2 cy 
      008A28 72 F9 01         [ 2]    3             addw y,(FONT_ROW,sp) ; 2 cy 
      008A2B 90 F6            [ 1]    4             ld a,(y) ; 1 cy 
      008A2D 72 03 52 03 FB   [ 2]    5              btjf SPI_SR,#SPI_SR_TXE,. ; 2 cy 
      008A32 C7 52 04         [ 1]    6              ld SPI_DR,a ; 1 cy 
                           000036     7             n=n+2 
      008A35 90 93            [ 1]    1             ldw y,x  ; 1cy 
      008A37 90 EE 36         [ 2]    2             ldw y,(n,y)  ; 2 cy 
      008A3A 72 F9 01         [ 2]    3             addw y,(FONT_ROW,sp) ; 2 cy 
      008A3D 90 F6            [ 1]    4             ld a,(y) ; 1 cy 
      008A3F 72 03 52 03 FB   [ 2]    5              btjf SPI_SR,#SPI_SR_TXE,. ; 2 cy 
      008A44 C7 52 04         [ 1]    6              ld SPI_DR,a ; 1 cy 
                           000038     7             n=n+2 
      008A47 90 93            [ 1]    1             ldw y,x  ; 1cy 
      008A49 90 EE 38         [ 2]    2             ldw y,(n,y)  ; 2 cy 
      008A4C 72 F9 01         [ 2]    3             addw y,(FONT_ROW,sp) ; 2 cy 
      008A4F 90 F6            [ 1]    4             ld a,(y) ; 1 cy 
      008A51 72 03 52 03 FB   [ 2]    5              btjf SPI_SR,#SPI_SR_TXE,. ; 2 cy 
      008A56 C7 52 04         [ 1]    6              ld SPI_DR,a ; 1 cy 
                           00003A     7             n=n+2 
      008A59 90 93            [ 1]    1             ldw y,x  ; 1cy 
      008A5B 90 EE 3A         [ 2]    2             ldw y,(n,y)  ; 2 cy 
      008A5E 72 F9 01         [ 2]    3             addw y,(FONT_ROW,sp) ; 2 cy 
      008A61 90 F6            [ 1]    4             ld a,(y) ; 1 cy 
      008A63 72 03 52 03 FB   [ 2]    5              btjf SPI_SR,#SPI_SR_TXE,. ; 2 cy 
      008A68 C7 52 04         [ 1]    6              ld SPI_DR,a ; 1 cy 
                           00003C     7             n=n+2 
      008A6B 90 93            [ 1]    1             ldw y,x  ; 1cy 
      008A6D 90 EE 3C         [ 2]    2             ldw y,(n,y)  ; 2 cy 
      008A70 72 F9 01         [ 2]    3             addw y,(FONT_ROW,sp) ; 2 cy 
      008A73 90 F6            [ 1]    4             ld a,(y) ; 1 cy 
      008A75 72 03 52 03 FB   [ 2]    5              btjf SPI_SR,#SPI_SR_TXE,. ; 2 cy 
      008A7A C7 52 04         [ 1]    6              ld SPI_DR,a ; 1 cy 
                           00003E     7             n=n+2 
      008A7D 90 93            [ 1]    1             ldw y,x  ; 1cy 
      008A7F 90 EE 3E         [ 2]    2             ldw y,(n,y)  ; 2 cy 
      008A82 72 F9 01         [ 2]    3             addw y,(FONT_ROW,sp) ; 2 cy 
      008A85 90 F6            [ 1]    4             ld a,(y) ; 1 cy 
      008A87 72 03 52 03 FB   [ 2]    5              btjf SPI_SR,#SPI_SR_TXE,. ; 2 cy 
      008A8C C7 52 04         [ 1]    6              ld SPI_DR,a ; 1 cy 
                           000040     7             n=n+2 
      008A8F 90 93            [ 1]    1             ldw y,x  ; 1cy 
      008A91 90 EE 40         [ 2]    2             ldw y,(n,y)  ; 2 cy 
      008A94 72 F9 01         [ 2]    3             addw y,(FONT_ROW,sp) ; 2 cy 
      008A97 90 F6            [ 1]    4             ld a,(y) ; 1 cy 
      008A99 72 03 52 03 FB   [ 2]    5              btjf SPI_SR,#SPI_SR_TXE,. ; 2 cy 
      008A9E C7 52 04         [ 1]    6              ld SPI_DR,a ; 1 cy 
                           000042     7             n=n+2 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 83.
Hexadecimal [24-Bits]



      008AA1 90 93            [ 1]    1             ldw y,x  ; 1cy 
      008AA3 90 EE 42         [ 2]    2             ldw y,(n,y)  ; 2 cy 
      008AA6 72 F9 01         [ 2]    3             addw y,(FONT_ROW,sp) ; 2 cy 
      008AA9 90 F6            [ 1]    4             ld a,(y) ; 1 cy 
      008AAB 72 03 52 03 FB   [ 2]    5              btjf SPI_SR,#SPI_SR_TXE,. ; 2 cy 
      008AB0 C7 52 04         [ 1]    6              ld SPI_DR,a ; 1 cy 
                           000044     7             n=n+2 
      008AB3 90 93            [ 1]    1             ldw y,x  ; 1cy 
      008AB5 90 EE 44         [ 2]    2             ldw y,(n,y)  ; 2 cy 
      008AB8 72 F9 01         [ 2]    3             addw y,(FONT_ROW,sp) ; 2 cy 
      008ABB 90 F6            [ 1]    4             ld a,(y) ; 1 cy 
      008ABD 72 03 52 03 FB   [ 2]    5              btjf SPI_SR,#SPI_SR_TXE,. ; 2 cy 
      008AC2 C7 52 04         [ 1]    6              ld SPI_DR,a ; 1 cy 
                           000046     7             n=n+2 
      008AC5 90 93            [ 1]    1             ldw y,x  ; 1cy 
      008AC7 90 EE 46         [ 2]    2             ldw y,(n,y)  ; 2 cy 
      008ACA 72 F9 01         [ 2]    3             addw y,(FONT_ROW,sp) ; 2 cy 
      008ACD 90 F6            [ 1]    4             ld a,(y) ; 1 cy 
      008ACF 72 03 52 03 FB   [ 2]    5              btjf SPI_SR,#SPI_SR_TXE,. ; 2 cy 
      008AD4 C7 52 04         [ 1]    6              ld SPI_DR,a ; 1 cy 
                           000048     7             n=n+2 
      008AD7 90 93            [ 1]    1             ldw y,x  ; 1cy 
      008AD9 90 EE 48         [ 2]    2             ldw y,(n,y)  ; 2 cy 
      008ADC 72 F9 01         [ 2]    3             addw y,(FONT_ROW,sp) ; 2 cy 
      008ADF 90 F6            [ 1]    4             ld a,(y) ; 1 cy 
      008AE1 72 03 52 03 FB   [ 2]    5              btjf SPI_SR,#SPI_SR_TXE,. ; 2 cy 
      008AE6 C7 52 04         [ 1]    6              ld SPI_DR,a ; 1 cy 
                           00004A     7             n=n+2 
      008AE9 90 93            [ 1]    1             ldw y,x  ; 1cy 
      008AEB 90 EE 4A         [ 2]    2             ldw y,(n,y)  ; 2 cy 
      008AEE 72 F9 01         [ 2]    3             addw y,(FONT_ROW,sp) ; 2 cy 
      008AF1 90 F6            [ 1]    4             ld a,(y) ; 1 cy 
      008AF3 72 03 52 03 FB   [ 2]    5              btjf SPI_SR,#SPI_SR_TXE,. ; 2 cy 
      008AF8 C7 52 04         [ 1]    6              ld SPI_DR,a ; 1 cy 
                           00004C     7             n=n+2 
      008AFB 90 93            [ 1]    1             ldw y,x  ; 1cy 
      008AFD 90 EE 4C         [ 2]    2             ldw y,(n,y)  ; 2 cy 
      008B00 72 F9 01         [ 2]    3             addw y,(FONT_ROW,sp) ; 2 cy 
      008B03 90 F6            [ 1]    4             ld a,(y) ; 1 cy 
      008B05 72 03 52 03 FB   [ 2]    5              btjf SPI_SR,#SPI_SR_TXE,. ; 2 cy 
      008B0A C7 52 04         [ 1]    6              ld SPI_DR,a ; 1 cy 
                           00004E     7             n=n+2 
      008B0D 90 93            [ 1]    1             ldw y,x  ; 1cy 
      008B0F 90 EE 4E         [ 2]    2             ldw y,(n,y)  ; 2 cy 
      008B12 72 F9 01         [ 2]    3             addw y,(FONT_ROW,sp) ; 2 cy 
      008B15 90 F6            [ 1]    4             ld a,(y) ; 1 cy 
      008B17 72 03 52 03 FB   [ 2]    5              btjf SPI_SR,#SPI_SR_TXE,. ; 2 cy 
      008B1C C7 52 04         [ 1]    6              ld SPI_DR,a ; 1 cy 
                           000050     7             n=n+2 
      008B1F 90 93            [ 1]    1             ldw y,x  ; 1cy 
      008B21 90 EE 50         [ 2]    2             ldw y,(n,y)  ; 2 cy 
      008B24 72 F9 01         [ 2]    3             addw y,(FONT_ROW,sp) ; 2 cy 
      008B27 90 F6            [ 1]    4             ld a,(y) ; 1 cy 
      008B29 72 03 52 03 FB   [ 2]    5              btjf SPI_SR,#SPI_SR_TXE,. ; 2 cy 
      008B2E C7 52 04         [ 1]    6              ld SPI_DR,a ; 1 cy 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 84.
Hexadecimal [24-Bits]



                           000052     7             n=n+2 
      008B31 90 93            [ 1]    1             ldw y,x  ; 1cy 
      008B33 90 EE 52         [ 2]    2             ldw y,(n,y)  ; 2 cy 
      008B36 72 F9 01         [ 2]    3             addw y,(FONT_ROW,sp) ; 2 cy 
      008B39 90 F6            [ 1]    4             ld a,(y) ; 1 cy 
      008B3B 72 03 52 03 FB   [ 2]    5              btjf SPI_SR,#SPI_SR_TXE,. ; 2 cy 
      008B40 C7 52 04         [ 1]    6              ld SPI_DR,a ; 1 cy 
                           000054     7             n=n+2 
      008B43 90 93            [ 1]    1             ldw y,x  ; 1cy 
      008B45 90 EE 54         [ 2]    2             ldw y,(n,y)  ; 2 cy 
      008B48 72 F9 01         [ 2]    3             addw y,(FONT_ROW,sp) ; 2 cy 
      008B4B 90 F6            [ 1]    4             ld a,(y) ; 1 cy 
      008B4D 72 03 52 03 FB   [ 2]    5              btjf SPI_SR,#SPI_SR_TXE,. ; 2 cy 
      008B52 C7 52 04         [ 1]    6              ld SPI_DR,a ; 1 cy 
                           000056     7             n=n+2 
      008B55 90 93            [ 1]    1             ldw y,x  ; 1cy 
      008B57 90 EE 56         [ 2]    2             ldw y,(n,y)  ; 2 cy 
      008B5A 72 F9 01         [ 2]    3             addw y,(FONT_ROW,sp) ; 2 cy 
      008B5D 90 F6            [ 1]    4             ld a,(y) ; 1 cy 
      008B5F 72 03 52 03 FB   [ 2]    5              btjf SPI_SR,#SPI_SR_TXE,. ; 2 cy 
      008B64 C7 52 04         [ 1]    6              ld SPI_DR,a ; 1 cy 
                           000058     7             n=n+2 
      008B67 90 93            [ 1]    1             ldw y,x  ; 1cy 
      008B69 90 EE 58         [ 2]    2             ldw y,(n,y)  ; 2 cy 
      008B6C 72 F9 01         [ 2]    3             addw y,(FONT_ROW,sp) ; 2 cy 
      008B6F 90 F6            [ 1]    4             ld a,(y) ; 1 cy 
      008B71 72 03 52 03 FB   [ 2]    5              btjf SPI_SR,#SPI_SR_TXE,. ; 2 cy 
      008B76 C7 52 04         [ 1]    6              ld SPI_DR,a ; 1 cy 
                           00005A     7             n=n+2 
      008B79 90 93            [ 1]    1             ldw y,x  ; 1cy 
      008B7B 90 EE 5A         [ 2]    2             ldw y,(n,y)  ; 2 cy 
      008B7E 72 F9 01         [ 2]    3             addw y,(FONT_ROW,sp) ; 2 cy 
      008B81 90 F6            [ 1]    4             ld a,(y) ; 1 cy 
      008B83 72 03 52 03 FB   [ 2]    5              btjf SPI_SR,#SPI_SR_TXE,. ; 2 cy 
      008B88 C7 52 04         [ 1]    6              ld SPI_DR,a ; 1 cy 
                           00005C     7             n=n+2 
      008B8B 90 93            [ 1]    1             ldw y,x  ; 1cy 
      008B8D 90 EE 5C         [ 2]    2             ldw y,(n,y)  ; 2 cy 
      008B90 72 F9 01         [ 2]    3             addw y,(FONT_ROW,sp) ; 2 cy 
      008B93 90 F6            [ 1]    4             ld a,(y) ; 1 cy 
      008B95 72 03 52 03 FB   [ 2]    5              btjf SPI_SR,#SPI_SR_TXE,. ; 2 cy 
      008B9A C7 52 04         [ 1]    6              ld SPI_DR,a ; 1 cy 
                           00005E     7             n=n+2 
      008B9D 90 93            [ 1]    1             ldw y,x  ; 1cy 
      008B9F 90 EE 5E         [ 2]    2             ldw y,(n,y)  ; 2 cy 
      008BA2 72 F9 01         [ 2]    3             addw y,(FONT_ROW,sp) ; 2 cy 
      008BA5 90 F6            [ 1]    4             ld a,(y) ; 1 cy 
      008BA7 72 03 52 03 FB   [ 2]    5              btjf SPI_SR,#SPI_SR_TXE,. ; 2 cy 
      008BAC C7 52 04         [ 1]    6              ld SPI_DR,a ; 1 cy 
                           000060     7             n=n+2 
      008BAF 90 93            [ 1]    1             ldw y,x  ; 1cy 
      008BB1 90 EE 60         [ 2]    2             ldw y,(n,y)  ; 2 cy 
      008BB4 72 F9 01         [ 2]    3             addw y,(FONT_ROW,sp) ; 2 cy 
      008BB7 90 F6            [ 1]    4             ld a,(y) ; 1 cy 
      008BB9 72 03 52 03 FB   [ 2]    5              btjf SPI_SR,#SPI_SR_TXE,. ; 2 cy 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 85.
Hexadecimal [24-Bits]



      008BBE C7 52 04         [ 1]    6              ld SPI_DR,a ; 1 cy 
                           000062     7             n=n+2 
      008BC1 90 93            [ 1]    1             ldw y,x  ; 1cy 
      008BC3 90 EE 62         [ 2]    2             ldw y,(n,y)  ; 2 cy 
      008BC6 72 F9 01         [ 2]    3             addw y,(FONT_ROW,sp) ; 2 cy 
      008BC9 90 F6            [ 1]    4             ld a,(y) ; 1 cy 
      008BCB 72 03 52 03 FB   [ 2]    5              btjf SPI_SR,#SPI_SR_TXE,. ; 2 cy 
      008BD0 C7 52 04         [ 1]    6              ld SPI_DR,a ; 1 cy 
                           000064     7             n=n+2 
      008BD3 90 93            [ 1]    1             ldw y,x  ; 1cy 
      008BD5 90 EE 64         [ 2]    2             ldw y,(n,y)  ; 2 cy 
      008BD8 72 F9 01         [ 2]    3             addw y,(FONT_ROW,sp) ; 2 cy 
      008BDB 90 F6            [ 1]    4             ld a,(y) ; 1 cy 
      008BDD 72 03 52 03 FB   [ 2]    5              btjf SPI_SR,#SPI_SR_TXE,. ; 2 cy 
      008BE2 C7 52 04         [ 1]    6              ld SPI_DR,a ; 1 cy 
                           000066     7             n=n+2 
      008BE5 90 93            [ 1]    1             ldw y,x  ; 1cy 
      008BE7 90 EE 66         [ 2]    2             ldw y,(n,y)  ; 2 cy 
      008BEA 72 F9 01         [ 2]    3             addw y,(FONT_ROW,sp) ; 2 cy 
      008BED 90 F6            [ 1]    4             ld a,(y) ; 1 cy 
      008BEF 72 03 52 03 FB   [ 2]    5              btjf SPI_SR,#SPI_SR_TXE,. ; 2 cy 
      008BF4 C7 52 04         [ 1]    6              ld SPI_DR,a ; 1 cy 
                           000068     7             n=n+2 
      008BF7 90 93            [ 1]    1             ldw y,x  ; 1cy 
      008BF9 90 EE 68         [ 2]    2             ldw y,(n,y)  ; 2 cy 
      008BFC 72 F9 01         [ 2]    3             addw y,(FONT_ROW,sp) ; 2 cy 
      008BFF 90 F6            [ 1]    4             ld a,(y) ; 1 cy 
      008C01 72 03 52 03 FB   [ 2]    5              btjf SPI_SR,#SPI_SR_TXE,. ; 2 cy 
      008C06 C7 52 04         [ 1]    6              ld SPI_DR,a ; 1 cy 
                           00006A     7             n=n+2 
      008C09 90 93            [ 1]    1             ldw y,x  ; 1cy 
      008C0B 90 EE 6A         [ 2]    2             ldw y,(n,y)  ; 2 cy 
      008C0E 72 F9 01         [ 2]    3             addw y,(FONT_ROW,sp) ; 2 cy 
      008C11 90 F6            [ 1]    4             ld a,(y) ; 1 cy 
      008C13 72 03 52 03 FB   [ 2]    5              btjf SPI_SR,#SPI_SR_TXE,. ; 2 cy 
      008C18 C7 52 04         [ 1]    6              ld SPI_DR,a ; 1 cy 
                           00006C     7             n=n+2 
      008C1B 90 93            [ 1]    1             ldw y,x  ; 1cy 
      008C1D 90 EE 6C         [ 2]    2             ldw y,(n,y)  ; 2 cy 
      008C20 72 F9 01         [ 2]    3             addw y,(FONT_ROW,sp) ; 2 cy 
      008C23 90 F6            [ 1]    4             ld a,(y) ; 1 cy 
      008C25 72 03 52 03 FB   [ 2]    5              btjf SPI_SR,#SPI_SR_TXE,. ; 2 cy 
      008C2A C7 52 04         [ 1]    6              ld SPI_DR,a ; 1 cy 
                           00006E     7             n=n+2 
      008C2D 90 93            [ 1]    1             ldw y,x  ; 1cy 
      008C2F 90 EE 6E         [ 2]    2             ldw y,(n,y)  ; 2 cy 
      008C32 72 F9 01         [ 2]    3             addw y,(FONT_ROW,sp) ; 2 cy 
      008C35 90 F6            [ 1]    4             ld a,(y) ; 1 cy 
      008C37 72 03 52 03 FB   [ 2]    5              btjf SPI_SR,#SPI_SR_TXE,. ; 2 cy 
      008C3C C7 52 04         [ 1]    6              ld SPI_DR,a ; 1 cy 
                           000070     7             n=n+2 
      008C3F 90 93            [ 1]    1             ldw y,x  ; 1cy 
      008C41 90 EE 70         [ 2]    2             ldw y,(n,y)  ; 2 cy 
      008C44 72 F9 01         [ 2]    3             addw y,(FONT_ROW,sp) ; 2 cy 
      008C47 90 F6            [ 1]    4             ld a,(y) ; 1 cy 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 86.
Hexadecimal [24-Bits]



      008C49 72 03 52 03 FB   [ 2]    5              btjf SPI_SR,#SPI_SR_TXE,. ; 2 cy 
      008C4E C7 52 04         [ 1]    6              ld SPI_DR,a ; 1 cy 
                           000072     7             n=n+2 
      008C51 90 93            [ 1]    1             ldw y,x  ; 1cy 
      008C53 90 EE 72         [ 2]    2             ldw y,(n,y)  ; 2 cy 
      008C56 72 F9 01         [ 2]    3             addw y,(FONT_ROW,sp) ; 2 cy 
      008C59 90 F6            [ 1]    4             ld a,(y) ; 1 cy 
      008C5B 72 03 52 03 FB   [ 2]    5              btjf SPI_SR,#SPI_SR_TXE,. ; 2 cy 
      008C60 C7 52 04         [ 1]    6              ld SPI_DR,a ; 1 cy 
                           000074     7             n=n+2 
      008C63 90 93            [ 1]    1             ldw y,x  ; 1cy 
      008C65 90 EE 74         [ 2]    2             ldw y,(n,y)  ; 2 cy 
      008C68 72 F9 01         [ 2]    3             addw y,(FONT_ROW,sp) ; 2 cy 
      008C6B 90 F6            [ 1]    4             ld a,(y) ; 1 cy 
      008C6D 72 03 52 03 FB   [ 2]    5              btjf SPI_SR,#SPI_SR_TXE,. ; 2 cy 
      008C72 C7 52 04         [ 1]    6              ld SPI_DR,a ; 1 cy 
                           000076     7             n=n+2 
      008C75 90 93            [ 1]    1             ldw y,x  ; 1cy 
      008C77 90 EE 76         [ 2]    2             ldw y,(n,y)  ; 2 cy 
      008C7A 72 F9 01         [ 2]    3             addw y,(FONT_ROW,sp) ; 2 cy 
      008C7D 90 F6            [ 1]    4             ld a,(y) ; 1 cy 
      008C7F 72 03 52 03 FB   [ 2]    5              btjf SPI_SR,#SPI_SR_TXE,. ; 2 cy 
      008C84 C7 52 04         [ 1]    6              ld SPI_DR,a ; 1 cy 
                           000078     7             n=n+2 
      008C87 90 93            [ 1]    1             ldw y,x  ; 1cy 
      008C89 90 EE 78         [ 2]    2             ldw y,(n,y)  ; 2 cy 
      008C8C 72 F9 01         [ 2]    3             addw y,(FONT_ROW,sp) ; 2 cy 
      008C8F 90 F6            [ 1]    4             ld a,(y) ; 1 cy 
      008C91 72 03 52 03 FB   [ 2]    5              btjf SPI_SR,#SPI_SR_TXE,. ; 2 cy 
      008C96 C7 52 04         [ 1]    6              ld SPI_DR,a ; 1 cy 
                           00007A     7             n=n+2 
      008C99 90 93            [ 1]    1             ldw y,x  ; 1cy 
      008C9B 90 EE 7A         [ 2]    2             ldw y,(n,y)  ; 2 cy 
      008C9E 72 F9 01         [ 2]    3             addw y,(FONT_ROW,sp) ; 2 cy 
      008CA1 90 F6            [ 1]    4             ld a,(y) ; 1 cy 
      008CA3 72 03 52 03 FB   [ 2]    5              btjf SPI_SR,#SPI_SR_TXE,. ; 2 cy 
      008CA8 C7 52 04         [ 1]    6              ld SPI_DR,a ; 1 cy 
                           00007C     7             n=n+2 
      008CAB 90 93            [ 1]    1             ldw y,x  ; 1cy 
      008CAD 90 EE 7C         [ 2]    2             ldw y,(n,y)  ; 2 cy 
      008CB0 72 F9 01         [ 2]    3             addw y,(FONT_ROW,sp) ; 2 cy 
      008CB3 90 F6            [ 1]    4             ld a,(y) ; 1 cy 
      008CB5 72 03 52 03 FB   [ 2]    5              btjf SPI_SR,#SPI_SR_TXE,. ; 2 cy 
      008CBA C7 52 04         [ 1]    6              ld SPI_DR,a ; 1 cy 
                           00007E     7             n=n+2 
      008CBD 90 93            [ 1]    1             ldw y,x  ; 1cy 
      008CBF 90 EE 7E         [ 2]    2             ldw y,(n,y)  ; 2 cy 
      008CC2 72 F9 01         [ 2]    3             addw y,(FONT_ROW,sp) ; 2 cy 
      008CC5 90 F6            [ 1]    4             ld a,(y) ; 1 cy 
      008CC7 72 03 52 03 FB   [ 2]    5              btjf SPI_SR,#SPI_SR_TXE,. ; 2 cy 
      008CCC C7 52 04         [ 1]    6              ld SPI_DR,a ; 1 cy 
                           000080     7             n=n+2 
      008CCF 90 93            [ 1]    1             ldw y,x  ; 1cy 
      008CD1 90 EE 80         [ 2]    2             ldw y,(n,y)  ; 2 cy 
      008CD4 72 F9 01         [ 2]    3             addw y,(FONT_ROW,sp) ; 2 cy 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 87.
Hexadecimal [24-Bits]



      008CD7 90 F6            [ 1]    4             ld a,(y) ; 1 cy 
      008CD9 72 03 52 03 FB   [ 2]    5              btjf SPI_SR,#SPI_SR_TXE,. ; 2 cy 
      008CDE C7 52 04         [ 1]    6              ld SPI_DR,a ; 1 cy 
                           000082     7             n=n+2 
      008CE1 90 93            [ 1]    1             ldw y,x  ; 1cy 
      008CE3 90 EE 82         [ 2]    2             ldw y,(n,y)  ; 2 cy 
      008CE6 72 F9 01         [ 2]    3             addw y,(FONT_ROW,sp) ; 2 cy 
      008CE9 90 F6            [ 1]    4             ld a,(y) ; 1 cy 
      008CEB 72 03 52 03 FB   [ 2]    5              btjf SPI_SR,#SPI_SR_TXE,. ; 2 cy 
      008CF0 C7 52 04         [ 1]    6              ld SPI_DR,a ; 1 cy 
                           000084     7             n=n+2 
      008CF3 90 93            [ 1]    1             ldw y,x  ; 1cy 
      008CF5 90 EE 84         [ 2]    2             ldw y,(n,y)  ; 2 cy 
      008CF8 72 F9 01         [ 2]    3             addw y,(FONT_ROW,sp) ; 2 cy 
      008CFB 90 F6            [ 1]    4             ld a,(y) ; 1 cy 
      008CFD 72 03 52 03 FB   [ 2]    5              btjf SPI_SR,#SPI_SR_TXE,. ; 2 cy 
      008D02 C7 52 04         [ 1]    6              ld SPI_DR,a ; 1 cy 
                           000086     7             n=n+2 
      008D05 90 93            [ 1]    1             ldw y,x  ; 1cy 
      008D07 90 EE 86         [ 2]    2             ldw y,(n,y)  ; 2 cy 
      008D0A 72 F9 01         [ 2]    3             addw y,(FONT_ROW,sp) ; 2 cy 
      008D0D 90 F6            [ 1]    4             ld a,(y) ; 1 cy 
      008D0F 72 03 52 03 FB   [ 2]    5              btjf SPI_SR,#SPI_SR_TXE,. ; 2 cy 
      008D14 C7 52 04         [ 1]    6              ld SPI_DR,a ; 1 cy 
                           000088     7             n=n+2 
      008D17 90 93            [ 1]    1             ldw y,x  ; 1cy 
      008D19 90 EE 88         [ 2]    2             ldw y,(n,y)  ; 2 cy 
      008D1C 72 F9 01         [ 2]    3             addw y,(FONT_ROW,sp) ; 2 cy 
      008D1F 90 F6            [ 1]    4             ld a,(y) ; 1 cy 
      008D21 72 03 52 03 FB   [ 2]    5              btjf SPI_SR,#SPI_SR_TXE,. ; 2 cy 
      008D26 C7 52 04         [ 1]    6              ld SPI_DR,a ; 1 cy 
                           00008A     7             n=n+2 
      008D29 90 93            [ 1]    1             ldw y,x  ; 1cy 
      008D2B 90 EE 8A         [ 2]    2             ldw y,(n,y)  ; 2 cy 
      008D2E 72 F9 01         [ 2]    3             addw y,(FONT_ROW,sp) ; 2 cy 
      008D31 90 F6            [ 1]    4             ld a,(y) ; 1 cy 
      008D33 72 03 52 03 FB   [ 2]    5              btjf SPI_SR,#SPI_SR_TXE,. ; 2 cy 
      008D38 C7 52 04         [ 1]    6              ld SPI_DR,a ; 1 cy 
                           00008C     7             n=n+2 
      008D3B 90 93            [ 1]    1             ldw y,x  ; 1cy 
      008D3D 90 EE 8C         [ 2]    2             ldw y,(n,y)  ; 2 cy 
      008D40 72 F9 01         [ 2]    3             addw y,(FONT_ROW,sp) ; 2 cy 
      008D43 90 F6            [ 1]    4             ld a,(y) ; 1 cy 
      008D45 72 03 52 03 FB   [ 2]    5              btjf SPI_SR,#SPI_SR_TXE,. ; 2 cy 
      008D4A C7 52 04         [ 1]    6              ld SPI_DR,a ; 1 cy 
                           00008E     7             n=n+2 
      008D4D 90 93            [ 1]    1             ldw y,x  ; 1cy 
      008D4F 90 EE 8E         [ 2]    2             ldw y,(n,y)  ; 2 cy 
      008D52 72 F9 01         [ 2]    3             addw y,(FONT_ROW,sp) ; 2 cy 
      008D55 90 F6            [ 1]    4             ld a,(y) ; 1 cy 
      008D57 72 03 52 03 FB   [ 2]    5              btjf SPI_SR,#SPI_SR_TXE,. ; 2 cy 
      008D5C C7 52 04         [ 1]    6              ld SPI_DR,a ; 1 cy 
                           000090     7             n=n+2 
      008D5F 90 93            [ 1]    1             ldw y,x  ; 1cy 
      008D61 90 EE 90         [ 2]    2             ldw y,(n,y)  ; 2 cy 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 88.
Hexadecimal [24-Bits]



      008D64 72 F9 01         [ 2]    3             addw y,(FONT_ROW,sp) ; 2 cy 
      008D67 90 F6            [ 1]    4             ld a,(y) ; 1 cy 
      008D69 72 03 52 03 FB   [ 2]    5              btjf SPI_SR,#SPI_SR_TXE,. ; 2 cy 
      008D6E C7 52 04         [ 1]    6              ld SPI_DR,a ; 1 cy 
                           000092     7             n=n+2 
      008D71 90 93            [ 1]    1             ldw y,x  ; 1cy 
      008D73 90 EE 92         [ 2]    2             ldw y,(n,y)  ; 2 cy 
      008D76 72 F9 01         [ 2]    3             addw y,(FONT_ROW,sp) ; 2 cy 
      008D79 90 F6            [ 1]    4             ld a,(y) ; 1 cy 
      008D7B 72 03 52 03 FB   [ 2]    5              btjf SPI_SR,#SPI_SR_TXE,. ; 2 cy 
      008D80 C7 52 04         [ 1]    6              ld SPI_DR,a ; 1 cy 
                           000094     7             n=n+2 
      008D83 90 93            [ 1]    1             ldw y,x  ; 1cy 
      008D85 90 EE 94         [ 2]    2             ldw y,(n,y)  ; 2 cy 
      008D88 72 F9 01         [ 2]    3             addw y,(FONT_ROW,sp) ; 2 cy 
      008D8B 90 F6            [ 1]    4             ld a,(y) ; 1 cy 
      008D8D 72 03 52 03 FB   [ 2]    5              btjf SPI_SR,#SPI_SR_TXE,. ; 2 cy 
      008D92 C7 52 04         [ 1]    6              ld SPI_DR,a ; 1 cy 
                           000096     7             n=n+2 
      008D95 72 03 52 03 FB   [ 2]  295     btjf SPI_SR,#SPI_SR_TXE,.
      008D9A 72 5F 52 04      [ 1]  296     clr SPI_DR
                                    297 ;    bres SPI_CR1,#SPI_CR1_SPE  
      000D1E                        298     _ldxz scan_line 
      008D9E BE 48                    1     .byte 0xbe,scan_line 
      008DA0 5C               [ 1]  299     incw x 
      000D21                        300     _strxz scan_line 
      008DA1 BF 48                    1     .byte 0xbf,scan_line 
      008DA3 A3 00 FA         [ 2]  301     cpw x,#FIRST_VIDEO_LINE+VIDEO_LINES
      008DA6 2B 08            [ 1]  302     jrmi 3$ 
      008DA8 72 15 52 54      [ 1]  303     bres TIM1_IER,#TIM1_IER_CC2IE
      008DAC 72 10 52 54      [ 1]  304     bset TIM1_IER,#TIM1_IER_UIE
      008DB0 72 0A 00 46 04   [ 2]  305 3$: btjt ntsc_flags,#F_NO_DTR,4$
      008DB5 72 17 50 0A      [ 1]  306     bres DTR_ODR,#DTR_PIN  
      008DB9                        307 4$:
      000D39                        308     _drop VSIZE 
      008DB9 5B 02            [ 2]    1     addw sp,#VSIZE 
      008DBB 80               [11]  309     iret 
                                    310 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 89.
Hexadecimal [24-Bits]



                                      1 ;
                                      2 ; Copyright Jacques Deschênes 2023 
                                      3 ; This file is part of stm8_terminal 
                                      4 ;
                                      5 ;     stm8_terminal is free software: you can redistribute it and/or modify
                                      6 ;     it under the terms of the GNU General Public License as published by
                                      7 ;     the Free Software Foundation, either version 3 of the License, or
                                      8 ;     (at your option) any later version.
                                      9 ;
                                     10 ;     stm8_terminal is distributed in the hope that it will be useful,
                                     11 ;     but WITHOUT ANY WARRANTY; without even the implied warranty of
                                     12 ;     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
                                     13 ;     GNU General Public License for more details.
                                     14 ;
                                     15 ;     You should have received a copy of the GNU General Public License
                                     16 ;     along with stm8_terminal.  If not, see <http://www.gnu.org/licenses/>.
                                     17 ;;
                                     18 
                                     19 
                                     20 
                                     21 ;-------------------------------
                                     22 	.area CODE 
                                     23 
                                     24 ;--------------------------
                                     25 ; UART receive character
                                     26 ; in a FIFO buffer 
                                     27 ; CTRL+C (ASCII 3)
                                     28 ; cancel program execution
                                     29 ; and fall back to command line
                                     30 ; CTRL+X reboot system 
                                     31 ; CTLR+Z erase EEPROM autorun 
                                     32 ;        information and reboot
                                     33 ;--------------------------
      008DBC                         34 UartRxHandler: ; console receive char 
      008DBC 72 0B 52 40 12   [ 2]   35 	btjf UART_SR,#UART_SR_RXNE,5$ 
      008DC1 A6 53            [ 1]   36 	ld a,#rx1_queue 
      008DC3 CB 00 94         [ 1]   37 	add a,rx1_tail 
      008DC6 5F               [ 1]   38 	clrw x 
      008DC7 97               [ 1]   39 	ld xl,a 
      008DC8 C6 52 41         [ 1]   40 	ld a,UART_DR 
      008DCB F7               [ 1]   41 	ld (x),a 
      000D4C                         42 	_ldaz rx1_tail 
      008DCC B6 94                    1     .byte 0xb6,rx1_tail 
      008DCE 4C               [ 1]   43 	inc a 
      008DCF A4 3F            [ 1]   44 	and a,#RX_QUEUE_SIZE-1
      000D51                         45 	_straz rx1_tail
      008DD1 B7 94                    1     .byte 0xb7,rx1_tail 
      008DD3 80               [11]   46 5$:	iret 
                                     47 
                           000000    48 BAUD_9600=0
                           000002    49 BAUD_19200=2
                           000004    50 BAUD_38400=4 
                           000006    51 BAUD_115200=6 
                                     52 
                           000001    53 .if MAX_FREQ 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 90.
Hexadecimal [24-Bits]



                                     54 ; values for 24Mhz FMSTR  
                                     55 ;   			BRR2,BRR1 
      008DD4 04 9C                   56 baud_rate: .byte 0x4,0x9c ; 0x9C4 ; 9600 
      008DD6 02 4E                   57  		   .byte 0x2,0x4e ; 0x4E2 ; 19200
      008DD8 01 27                   58 		   .byte 0x1,0x27 ; 0x271 ; 38400
      008DDA 00 0D                   59 		   .byte 0x0,0x0d ; 0xD0  ; 115200
                           000000    60 .else 
                                     61 baud_rate: ; for 20Mhz 
                                     62 			.byte 0x3,0x82 ; 0x823 ; 9600 
                                     63 			.byte 0x2,0x41 ; 0x412 ; 19200
                                     64 			.byte 0x9,0x20 ; 0x209 ; 38400 
                                     65 			.byte 0xe,0x0a ; 0xae  ; 115200
                                     66 .endif 
                                     67 ;---------------------------------------------
                                     68 ; initialize UART, read external swtiches SW4,SW5 
                                     69 ; to determine required BAUD rate.
                                     70 ; called from cold_start in hardware_init.asm 
                                     71 ; input:
                                     72 ;	none      
                                     73 ; output:
                                     74 ;   none
                                     75 ;---------------------------------------------
                           01C200    76 BAUD_RATE=115200 
      008DDC                         77 uart_init:
                                     78 ; enable UART clock
      008DDC 72 16 50 C7      [ 1]   79 	bset CLK_PCKENR1,#UART_PCKEN
                                     80 ; get BRR value from table 
      008DE0 AE 00 06         [ 2]   81 	ldw x,#BAUD_115200  
      008DE3 D6 8D D4         [ 1]   82 	ld a,(baud_rate,x)
      008DE6 C7 52 43         [ 1]   83 	ld UART_BRR2,a 
      008DE9 D6 8D D5         [ 1]   84 	ld a,(baud_rate+1,x)
      008DEC C7 52 42         [ 1]   85 	ld UART_BRR1,a 
      008DEF 72 5F 52 41      [ 1]   86     clr UART_DR
      008DF3 35 2C 52 45      [ 1]   87 	mov UART_CR2,#((1<<UART_CR2_TEN)|(1<<UART_CR2_REN)|(1<<UART_CR2_RIEN));
      008DF7 72 5F 00 93      [ 1]   88     clr rx1_head 
      008DFB 72 5F 00 94      [ 1]   89 	clr rx1_tail
      008DFF 81               [ 4]   90 	ret
                                     91 
                                     92 
                                     93 ;---------------------------------
                                     94 ; uart_putc
                                     95 ; send a character via UART
                                     96 ; input:
                                     97 ;    A  	character to send
                                     98 ;---------------------------------
      008E00                         99 uart_putc:: 
      008E00 72 0F 52 40 FB   [ 2]  100 	btjf UART_SR,#UART_SR_TXE,.
      008E05 C7 52 41         [ 1]  101 	ld UART_DR,a 
      008E08 81               [ 4]  102 	ret 
                                    103 
                                    104 ;-------------------------
                                    105 ; delete character left 
                                    106 ;-------------------------
      008E09                        107 uart_delback:
      008E09 A6 08            [ 1]  108 	ld a,#BS 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 91.
Hexadecimal [24-Bits]



      008E0B CD 8E 00         [ 4]  109 	call uart_putc  
      008E0E A6 20            [ 1]  110 	ld a,#SPACE 
      008E10 CD 8E 00         [ 4]  111 	call uart_putc 
      008E13 A6 08            [ 1]  112 	ld a,#BS 
      008E15 CD 8E 00         [ 4]  113 	call uart_putc 
      008E18 81               [ 4]  114 	ret 
                                    115 
                                    116 ;------------------------
                                    117 ; clear VT10x terminal 
                                    118 ; screeen 
                                    119 ;------------------------
      008E19                        120 uart_cls:
      008E19 88               [ 1]  121 	push a 
      008E1A A6 1B            [ 1]  122 	ld a,#ESC 
      008E1C CD 8E 00         [ 4]  123 	call uart_putc 
      008E1F A6 63            [ 1]  124 	ld a,#'c 
      008E21 CD 8E 00         [ 4]  125 	call uart_putc 
      008E24 84               [ 1]  126 	pop a 
      008E25 81               [ 4]  127 	ret 
                                    128 
                                    129 ;--------------------
                                    130 ; send blank character 
                                    131 ; to UART 
                                    132 ;---------------------
      008E26                        133 uart_space:
      008E26 A6 20            [ 1]  134 	ld a,#SPACE 
      008E28 CD 8E 00         [ 4]  135 	call uart_putc 
      008E2B 81               [ 4]  136 	ret 
                                    137 
                                    138 ;---------------------------------
                                    139 ; Query for character in rx1_queue
                                    140 ; input:
                                    141 ;   none 
                                    142 ; output:
                                    143 ;   A     0 no charcter available
                                    144 ;   Z     1 no character available
                                    145 ;---------------------------------
      008E2C                        146 qgetc::
      008E2C                        147 uart_qgetc::
      000DAC                        148 	_ldaz rx1_head 
      008E2C B6 93                    1     .byte 0xb6,rx1_head 
      008E2E C1 00 94         [ 1]  149 	cp a,rx1_tail 
      008E31 81               [ 4]  150 	ret 
                                    151 
                                    152 ;---------------------------------
                                    153 ; wait character from UART 
                                    154 ; input:
                                    155 ;   none
                                    156 ; output:
                                    157 ;   A 			char  
                                    158 ;--------------------------------	
      008E32                        159 getc:: ;console input
      008E32                        160 uart_getc::
      008E32 CD 8E 2C         [ 4]  161 	call uart_qgetc
      008E35 27 FB            [ 1]  162 	jreq uart_getc 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 92.
Hexadecimal [24-Bits]



      008E37 89               [ 2]  163 	pushw x 
                                    164 ;; rx1_queue must be in page 0 	
      008E38 A6 53            [ 1]  165 	ld a,#rx1_queue
      008E3A CB 00 93         [ 1]  166 	add a,rx1_head 
      008E3D 5F               [ 1]  167 	clrw x  
      008E3E 97               [ 1]  168 	ld xl,a 
      008E3F F6               [ 1]  169 	ld a,(x)
      008E40 88               [ 1]  170 	push a
      000DC1                        171 	_ldaz rx1_head 
      008E41 B6 93                    1     .byte 0xb6,rx1_head 
      008E43 4C               [ 1]  172 	inc a 
      008E44 A4 3F            [ 1]  173 	and a,#RX_QUEUE_SIZE-1
      000DC6                        174 	_straz rx1_head 
      008E46 B7 93                    1     .byte 0xb7,rx1_head 
      008E48 84               [ 1]  175 	pop a  
      008E49 85               [ 2]  176 	popw x
      008E4A 81               [ 4]  177 	ret 
                                    178 
                                    179 
                                    180 ;--------------------------
                                    181 ; manange control character 
                                    182 ; before calling uart_putc 
                                    183 ; input:
                                    184 ;    A    character 
                                    185 ;---------------------------
      008E4B                        186 uart_print_char:
      008E4B A1 08            [ 1]  187 	cp a,#BS 
      008E4D 26 05            [ 1]  188 	jrne 1$
      008E4F CD 8E 09         [ 4]  189 	call uart_delback 
      008E52 20 03            [ 2]  190 	jra 9$ 
      008E54                        191 1$:
      008E54 CD 8E 00         [ 4]  192 	call uart_putc
      008E57                        193 9$:
      008E57 81               [ 4]  194 	ret 
                                    195 
                                    196 
                                    197 ;------------------------------
                                    198 ;  send string to uart 
                                    199 ; input:
                                    200 ;    X    *string 
                                    201 ; output:
                                    202 ;    X    *after string 
                                    203 ;------------------------------
      008E58                        204 uart_puts:
      008E58 88               [ 1]  205 	push a 
      008E59 F6               [ 1]  206 1$: ld a,(x)
      008E5A 27 06            [ 1]  207 	jreq 9$ 
      008E5C CD 8E 4B         [ 4]  208 	call uart_print_char  
      008E5F 5C               [ 1]  209 	incw x 
      008E60 20 F7            [ 2]  210 	jra 1$ 
      008E62 5C               [ 1]  211 9$: incw x 
      008E63 84               [ 1]  212 	pop a 
      008E64 81               [ 4]  213 	ret 
                                    214 
                                    215 ;-------------------------------
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 93.
Hexadecimal [24-Bits]



                                    216 ; print integer in hexadicimal
                                    217 ; input:
                                    218 ;    X 
                                    219 ;------------------------------- 
      008E65                        220 uart_print_hex:
      008E65 89               [ 2]  221 	pushw x 
      008E66 88               [ 1]  222 	push a 
      008E67 9E               [ 1]  223 	ld a,xh 
      008E68 CD 8E 77         [ 4]  224 	call uart_print_hex_byte 
      008E6B 9F               [ 1]  225 	ld a,xl 
      008E6C CD 8E 77         [ 4]  226 	call uart_print_hex_byte 
      008E6F A6 20            [ 1]  227 	ld a,#SPACE 
      008E71 CD 8E 00         [ 4]  228 	call uart_putc 
      008E74 84               [ 1]  229 	pop a 
      008E75 85               [ 2]  230 	popw x 
      008E76 81               [ 4]  231 	ret 
                                    232 
                                    233 ;----------------------
                                    234 ; print hexadecimal byte 
                                    235 ; input:
                                    236 ;    A    byte to print 
                                    237 ;-----------------------
      008E77                        238 uart_print_hex_byte:
      008E77 88               [ 1]  239 	push a 
      008E78 4E               [ 1]  240 	swap a 
      008E79 CD 8E 87         [ 4]  241 	call hex_digit 
      008E7C CD 8E 00         [ 4]  242 	call uart_putc 
      008E7F 84               [ 1]  243 	pop a 
      008E80 CD 8E 87         [ 4]  244 	call hex_digit 
      008E83 CD 8E 00         [ 4]  245 	call uart_putc 
      008E86 81               [ 4]  246 	ret 
                                    247 
                                    248 ;---------------------------
                                    249 ; convert to hexadecimal digit 
                                    250 ; input:
                                    251 ;    A    value to convert 
                                    252 ; output:
                                    253 ;    A    hex digit character 
                                    254 ;-----------------------------
      008E87                        255 hex_digit:
      008E87 A4 0F            [ 1]  256 	and a,#15 
      008E89 AB 30            [ 1]  257 	add a,#'0 
      008E8B A1 3A            [ 1]  258 	cp a,#'9+1 
      008E8D 2B 02            [ 1]  259 	jrmi 9$ 
      008E8F AB 07            [ 1]  260 	add a,#7 
      008E91 81               [ 4]  261 9$: ret 
                                    262 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 94.
Hexadecimal [24-Bits]



                                      1  
                                      2  ;
                                      3 ; Copyright Jacques Deschênes 2023 
                                      4 ; This file is part of stm8_terminal 
                                      5 ;
                                      6 ;     stm8_terminal is free software: you can redistribute it and/or modify
                                      7 ;     it under the terms of the GNU General Public License as published by
                                      8 ;     the Free Software Foundation, either version 3 of the License, or
                                      9 ;     (at your option) any later version.
                                     10 ;
                                     11 ;     stm8_terminal is distributed in the hope that it will be useful,
                                     12 ;     but WITHOUT ANY WARRANTY; without even the implied warranty of
                                     13 ;     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
                                     14 ;     GNU General Public License for more details.
                                     15 ;
                                     16 ;     You should have received a copy of the GNU General Public License
                                     17 ;     along with stm8_terminal.  If not, see <http://www.gnu.org/licenses/>.
                                     18 ;;
                                     19 
                                     20     .area CODE
                                     21 
                           000008    22 FONT_HEIGHT=8
                           000006    23 FONT_WIDTH=6
      008E92                         24 font_6x8: 
      008E92 00 00 00 00 00 00 00    25 .byte 0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00  ; space ASCII 32
             00
      008E9A 20 20 20 20 20 00 20    26 .byte 0x20,0x20,0x20,0x20,0x20,0x00,0x20,0x00  ; !
             00
      008EA2 50 50 50 00 00 00 00    27 .byte 0x50,0x50,0x50,0x00,0x00,0x00,0x00,0x00  ; "
             00
      008EAA 50 50 F8 50 F8 50 50    28 .byte 0x50,0x50,0xF8,0x50,0xF8,0x50,0x50,0x00  ; #
             00
      008EB2 20 78 A0 70 28 F0 20    29 .byte 0x20,0x78,0xA0,0x70,0x28,0xF0,0x20,0x00  ; $
             00
      008EBA C0 C8 10 20 40 98 18    30 .byte 0xC0,0xC8,0x10,0x20,0x40,0x98,0x18,0x00  ; %
             00
      008EC2 60 90 A0 40 A8 90 68    31 .byte 0x60,0X90,0xA0,0x40,0xA8,0x90,0x68,0x00  ; &
             00
      008ECA 60 20 40 00 00 00 00    32 .byte 0x60,0x20,0x40,0x00,0x00,0x00,0x00,0x00  ; '
             00
      008ED2 10 20 40 40 40 20 10    33 .byte 0x10,0x20,0x40,0x40,0x40,0x20,0x10,0x00  ; (
             00
      008EDA 40 20 10 10 10 20 40    34 .byte 0x40,0x20,0x10,0x10,0x10,0x20,0x40,0x00  ; )
             00
      008EE2 00 20 A8 70 A8 20 00    35 .byte 0x00,0x20,0xA8,0x70,0xA8,0x20,0x00,0x00  ; *
             00
      008EEA 00 20 20 F8 20 20 00    36 .byte 0x00,0x20,0x20,0xF8,0x20,0x20,0x00,0x00  ; +
             00
      008EF2 00 00 00 70 70 30 60    37 .byte 0x00,0x00,0x00,0x70,0x70,0x30,0x60,0x40  ; ,
             40
      008EFA 00 00 00 F0 00 00 00    38 .byte 0x00,0x00,0x00,0xF0,0x00,0x00,0x00,0x00  ; -
             00
      008F02 00 00 00 00 00 60 60    39 .byte 0x00,0x00,0x00,0x00,0x00,0x60,0x60,0x00  ; .
             00
      008F0A 00 06 0C 18 30 60 00    40 .byte 0x00,0x06,0x0c,0x18,0x30,0x60,0x00,0x00  ; /
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 95.
Hexadecimal  00-Bits]



             00
      008F12 70 88 98 A8 C8 88 70    41 .byte 0x70,0x88,0x98,0xA8,0xC8,0x88,0x70,0x00  ; 0
             00
      008F1A 20 60 20 20 20 20 F8    42 .byte 0x20,0x60,0x20,0x20,0x20,0x20,0xF8,0x00  ; 1
             00
      008F22 70 88 10 20 40 80 F8    43 .byte 0x70,0x88,0x10,0x20,0x40,0x80,0xF8,0x00  ; 2
             00
      008F2A F0 08 08 F0 08 08 F0    44 .byte 0xF0,0x08,0x08,0xF0,0x08,0x08,0xF0,0x00  ; 3
             00
      008F32 10 30 50 90 F8 10 10    45 .byte 0x10,0x30,0x50,0x90,0xF8,0x10,0x10,0x00  ; 4
             00
      008F3A F8 80 80 F0 08 08 F0    46 .byte 0xF8,0x80,0x80,0xF0,0x08,0x08,0xF0,0x00  ; 5
             00
      008F42 30 40 80 F0 88 88 70    47 .byte 0x30,0x40,0x80,0xF0,0x88,0x88,0x70,0x00  ; 6
             00
      008F4A F8 08 10 20 40 40 40    48 .byte 0xF8,0x08,0x10,0x20,0x40,0x40,0x40,0x00  ; 7
             00
      008F52 70 88 88 70 88 88 70    49 .byte 0x70,0x88,0x88,0x70,0x88,0x88,0x70,0x00  ; 8
             00
      008F5A 70 88 88 70 08 08 70    50 .byte 0x70,0x88,0x88,0x70,0x08,0x08,0x70,0x00  ; 9
             00
      008F62 00 60 60 00 60 60 00    51 .byte 0x00,0x60,0x60,0x00,0x60,0x60,0x00,0x00  ; :
             00
      008F6A 00 60 60 00 60 60 20    52 .byte 0x00,0x60,0x60,0x00,0x60,0x60,0x20,0x40  ; ;
             40
      008F72 10 20 40 80 40 20 10    53 .byte 0x10,0x20,0x40,0x80,0x40,0x20,0x10,0x00  ; <
             00
      008F7A 00 00 F8 00 F8 00 00    54 .byte 0x00,0x00,0xF8,0x00,0xF8,0x00,0x00,0x00  ; =
             00
      008F82 40 20 10 08 10 20 40    55 .byte 0x40,0x20,0x10,0x08,0x10,0x20,0x40,0x00  ; >
             00
      008F8A 70 88 08 10 20 00 20    56 .byte 0x70,0x88,0x08,0x10,0x20,0x00,0x20,0x00  ; ?
             00
      008F92 70 88 08 68 A8 A8 70    57 .byte 0x70,0x88,0x08,0x68,0xA8,0xA8,0x70,0x00  ; @
             00
      008F9A 70 88 88 F8 88 88 88    58 .byte 0x70,0x88,0x88,0xF8,0x88,0x88,0x88,0x00  ; A
             00
      008FA2 F0 88 88 F0 88 88 F0    59 .byte 0xF0,0x88,0x88,0xF0,0x88,0x88,0xF0,0x00  ; B
             00
      008FAA 78 80 80 80 80 80 78    60 .byte 0x78,0x80,0x80,0x80,0x80,0x80,0x78,0x00  ; C
             00
      008FB2 F0 88 88 88 88 88 F0    61 .byte 0xF0,0x88,0x88,0x88,0x88,0x88,0xF0,0x00  ; D
             00
      008FBA F8 80 80 F8 80 80 F8    62 .byte 0xF8,0x80,0x80,0xF8,0x80,0x80,0xF8,0x00  ; E
             00
      008FC2 F8 80 80 F8 80 80 80    63 .byte 0xF8,0x80,0x80,0xF8,0x80,0x80,0x80,0x00  ; F
             00
      008FCA 78 80 80 B0 88 88 70    64 .byte 0x78,0x80,0x80,0xB0,0x88,0x88,0x70,0x00  ; G
             00
      008FD2 88 88 88 F8 88 88 88    65 .byte 0x88,0x88,0x88,0xF8,0x88,0x88,0x88,0x00  ; H
             00
      008FDA 70 20 20 20 20 20 70    66 .byte 0x70,0x20,0x20,0x20,0x20,0x20,0x70,0x00  ; I
             00
      008FE2 78 08 08 08 08 90 60    67 .byte 0x78,0x08,0x08,0x08,0x08,0x90,0x60,0x00  ; J
             00
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 96.
Hexadecimal [24-Bits]



      008FEA 88 90 A0 C0 A0 90 88    68 .byte 0x88,0x90,0xA0,0xC0,0xA0,0x90,0x88,0x00  ; K
             00
      008FF2 80 80 80 80 80 80 F8    69 .byte 0x80,0x80,0x80,0x80,0x80,0x80,0xF8,0x00  ; L
             00
      008FFA 88 D8 A8 88 88 88 88    70 .byte 0x88,0xD8,0xA8,0x88,0x88,0x88,0x88,0x00  ; M
             00
      009002 88 88 C8 A8 98 88 88    71 .byte 0x88,0x88,0xC8,0xA8,0x98,0x88,0x88,0x00  ; N
             00
      00900A 70 88 88 88 88 88 70    72 .byte 0x70,0x88,0x88,0x88,0x88,0x88,0x70,0x00  ; O
             00
      009012 F0 88 88 F0 80 80 80    73 .byte 0xF0,0x88,0x88,0xF0,0x80,0x80,0x80,0x00  ; P
             00
      00901A 70 88 88 88 A8 90 68    74 .byte 0x70,0x88,0x88,0x88,0xA8,0x90,0x68,0x00  ; Q
             00
      009022 F0 88 88 F0 A0 90 88    75 .byte 0xF0,0x88,0x88,0xF0,0xA0,0x90,0x88,0x00  ; R
             00
      00902A 78 80 80 70 08 08 F0    76 .byte 0x78,0x80,0x80,0x70,0x08,0x08,0xF0,0x00  ; S
             00
      009032 F8 20 20 20 20 20 20    77 .byte 0xF8,0x20,0x20,0x20,0x20,0x20,0x20,0x00  ; T
             00
      00903A 88 88 88 88 88 88 70    78 .byte 0x88,0x88,0x88,0x88,0x88,0x88,0x70,0x00  ; U
             00
      009042 88 88 88 88 88 50 20    79 .byte 0x88,0x88,0x88,0x88,0x88,0x50,0x20,0x00  ; V
             00
      00904A 88 88 88 A8 A8 D8 88    80 .byte 0x88,0x88,0x88,0xA8,0xA8,0xD8,0x88,0x00  ; W
             00
      009052 88 88 50 20 50 88 88    81 .byte 0x88,0x88,0x50,0x20,0x50,0x88,0x88,0x00  ; X
             00
      00905A 88 88 88 50 20 20 20    82 .byte 0x88,0x88,0x88,0x50,0x20,0x20,0x20,0x00  ; Y
             00
      009062 F8 10 20 40 80 80 F8    83 .byte 0xF8,0x10,0x20,0x40,0x80,0x80,0xF8,0x00  ; Z
             00
      00906A 60 40 40 40 40 40 60    84 .byte 0x60,0x40,0x40,0x40,0x40,0x40,0x60,0x00  ; [
             00
      009072 00 80 40 20 10 08 00    85 .byte 0x00,0x80,0x40,0x20,0x10,0x08,0x00,0x00  ; '\'
             00
      00907A 18 08 08 08 08 08 18    86 .byte 0x18,0x08,0x08,0x08,0x08,0x08,0x18,0x00  ; ]
             00
      009082 20 50 88 00 00 00 00    87 .byte 0x20,0x50,0x88,0x00,0x00,0x00,0x00,0x00  ; ^
             00
      00908A 00 00 00 00 00 00 00    88 .byte 0x00,0x00,0x00,0x00,0x00,0x00,0x00,0xFE  ; _
             FE
      009092 40 20 10 00 00 00 00    89 .byte 0x40,0x20,0x10,0x00,0x00,0x00,0x00,0x00  ; `
             00
      00909A 00 00 70 08 78 88 78    90 .byte 0x00,0x00,0x70,0x08,0x78,0x88,0x78,0x00  ; a
             00
      0090A2 80 80 80 B0 C8 88 F0    91 .byte 0x80,0x80,0x80,0xB0,0xC8,0x88,0xF0,0x00  ; b
             00
      0090AA 00 00 70 80 80 88 70    92 .byte 0x00,0x00,0x70,0x80,0x80,0x88,0x70,0x00  ; c
             00
      0090B2 08 08 08 68 98 88 78    93 .byte 0x08,0x08,0x08,0x68,0x98,0x88,0x78,0x00  ; d
             00
      0090BA 00 00 70 88 F8 80 70    94 .byte 0x00,0x00,0x70,0x88,0xF8,0x80,0x70,0x00  ; e
             00
      0090C2 30 48 40 E0 40 40 40    95 .byte 0x30,0x48,0x40,0xE0,0x40,0x40,0x40,0x00  ; f
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 97.
Hexadecimal  00-Bits]



             00
      0090CA 00 00 78 88 88 78 08    96 .byte 0x00,0x00,0x78,0x88,0x88,0x78,0x08,0x70  ; g
             70
      0090D2 80 80 B0 C8 88 88 88    97 .byte 0x80,0x80,0xB0,0xC8,0x88,0x88,0x88,0x00  ; h
             00
      0090DA 00 20 00 20 20 20 20    98 .byte 0x00,0x20,0x00,0x20,0x20,0x20,0x20,0x00  ; i
             00
      0090E2 10 00 30 10 10 90 60    99 .byte 0x10,0x00,0x30,0x10,0x10,0x90,0x60,0x00  ; j
             00
      0090EA 80 80 90 A0 C0 A0 90   100 .byte 0x80,0x80,0x90,0xA0,0xC0,0xA0,0x90,0x00  ; k
             00
      0090F2 60 20 20 20 20 20 70   101 .byte 0x60,0x20,0x20,0x20,0x20,0x20,0x70,0x00  ; l
             00
      0090FA 00 00 D0 A8 A8 88 88   102 .byte 0x00,0x00,0xD0,0xA8,0xA8,0x88,0x88,0x00  ; m
             00
      009102 00 00 B0 C8 88 88 88   103 .byte 0x00,0x00,0xB0,0xC8,0x88,0x88,0x88,0x00  ; n
             00
      00910A 00 00 70 88 88 88 70   104 .byte 0x00,0x00,0x70,0x88,0x88,0x88,0x70,0x00  ; o
             00
      009112 00 00 F0 88 88 F0 80   105 .byte 0x00,0x00,0xF0,0x88,0x88,0xF0,0x80,0x80  ; p
             80
      00911A 00 00 68 90 90 B0 50   106 .byte 0x00,0x00,0x68,0x90,0x90,0xB0,0x50,0x18  ; q
             18
      009122 00 00 B0 C8 80 80 80   107 .byte 0x00,0x00,0xB0,0xC8,0x80,0x80,0x80,0x00  ; r
             00
      00912A 00 00 70 80 70 08 F0   108 .byte 0x00,0x00,0x70,0x80,0x70,0x08,0xF0,0x00  ; s
             00
      009132 40 40 E0 40 40 48 30   109 .byte 0x40,0x40,0xE0,0x40,0x40,0x48,0x30,0x00  ; t
             00
      00913A 00 00 88 88 88 98 68   110 .byte 0x00,0x00,0x88,0x88,0x88,0x98,0x68,0x00  ; u
             00
      009142 00 00 88 88 88 50 20   111 .byte 0x00,0x00,0x88,0x88,0x88,0x50,0x20,0x00  ; v
             00
      00914A 00 00 88 88 A8 A8 50   112 .byte 0x00,0x00,0x88,0x88,0xA8,0xA8,0x50,0x00  ; w
             00
      009152 00 00 88 50 20 50 88   113 .byte 0x00,0x00,0x88,0x50,0x20,0x50,0x88,0x00  ; x
             00
      00915A 00 00 88 88 88 78 08   114 .byte 0x00,0x00,0x88,0x88,0x88,0x78,0x08,0x70  ; y
             70
      009162 00 00 F8 10 20 40 F8   115 .byte 0x00,0x00,0xF8,0x10,0x20,0x40,0xF8,0x00  ; z
             00
      00916A 20 40 40 80 40 40 20   116 .byte 0x20,0x40,0x40,0x80,0x40,0x40,0x20,0x00  ; {
             00
      009172 20 20 20 20 20 20 20   117 .byte 0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x00  ; |
             00
      00917A 40 20 20 10 20 20 40   118 .byte 0x40,0x20,0x20,0x10,0x20,0x20,0x40,0x00  ; }
             00
      009182 00 00 40 A8 10 00 00   119 .byte 0x00,0x00,0x40,0xA8,0x10,0x00,0x00,0x00  ; ~  ASCII 127 
             00
      00918A FC FC FC FC FC FC FC   120 .byte 0xFC,0xFC,0xFC,0xFC,0xFC,0xFC,0xFC,0xFC  ; 95 block cursor  128 
             FC
      009192 40 20 10 F8 10 20 40   121 .byte 0x40,0x20,0x10,0xF8,0x10,0x20,0x40,0x00  ; 96 flèche droite 129 
             00
      00919A 10 20 40 F8 40 20 10   122 .byte 0x10,0x20,0x40,0xF8,0x40,0x20,0x10,0x00  ; 97 flèche gauche 130
             00
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 98.
Hexadecimal [24-Bits]



      0091A2 20 70 A8 20 20 20 00   123 .byte 0x20,0x70,0xA8,0x20,0x20,0x20,0x00,0x00  ; 98 flèche haut   131
             00
      0091AA 00 20 20 20 A8 70 20   124 .byte 0x00,0x20,0x20,0x20,0xA8,0x70,0x20,0x00  ; 99 flèche bas    132
             00
      0091B2 00 70 F8 F8 F8 70 00   125 .byte 0x00,0x70,0xF8,0xF8,0xF8,0x70,0x00,0x00  ; 100 rond		  133 
             00
      0091BA 00 00 00 00 00 00 00   126 .byte 0x00,0x00,0x00,0x00,0x00,0x00,0x00,0xff  ; 101 underline cursor 134
             FF
      0091C2 80 80 80 80 80 80 80   127 .byte 0x80,0x80,0x80,0x80,0x80,0x80,0x80,0x80  ; 102 insert cursor 135 
             80
      0091CA                        128 font_end:
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 99.
Hexadecimal [24-Bits]



                                      1 ;
                                      2 ; Copyright Jacques Deschênes 2023 
                                      3 ; This file is part of stm8_terminal 
                                      4 ;
                                      5 ;     stm8_terminal is free software: you can redistribute it and/or modify
                                      6 ;     it under the terms of the GNU General Public License as published by
                                      7 ;     the Free Software Foundation, either version 3 of the License, or
                                      8 ;     (at your option) any later version.
                                      9 ;
                                     10 ;     stm8_terminal is distributed in the hope that it will be useful,
                                     11 ;     but WITHOUT ANY WARRANTY; without even the implied warranty of
                                     12 ;     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
                                     13 ;     GNU General Public License for more details.
                                     14 ;
                                     15 ;     You should have received a copy of the GNU General Public License
                                     16 ;     along with stm8_terminal.  If not, see <http://www.gnu.org/licenses/>.
                                     17 ;;
                                     18 
                                     19 ;-------------------
                                     20 ;   tv terminal 
                                     21 ;-------------------
                                     22 
                                     23 ; cursor shapes 
                           000020    24 BLANK=SPACE  
                           00007F    25 BLOCK=95+32 
                           000085    26 UNDERLINE=101+32 
                           000086    27 INSERT=102+32 
                                     28 
                           000014    29 CURSOR_DELAY=20 ; msec 
                                     30 ;----------------------------------
                                     31 ; decrement cursro_delay 
                                     32 ; when zero toggle cursor state 
                                     33 ;--------------------------------
      0091CA                         34 cursor_blink_handler:
      0091CA 88               [ 1]   35     push a 
      0091CB 72 03 00 46 1C   [ 2]   36     btjf ntsc_flags,#F_CURSOR,9$ 
      001150                         37     _decz cursor_delay 
      0091D0 3A 4E                    1     .byte 0x3a,cursor_delay 
      0091D2 26 18            [ 1]   38     jrne 9$ 
      0091D4 72 05 00 46 05   [ 2]   39     btjf ntsc_flags,#F_CUR_VISI,2$ 
      0091D9 C6 00 50         [ 1]   40     ld a,char_cursor  
      0091DC 20 03            [ 2]   41     jra 8$ 
      0091DE C6 00 4F         [ 1]   42 2$: ld a,char_under 
      0091E1                         43 8$: 
      0091E1 CD 92 50         [ 4]   44     call tv_put_char 
      0091E4 90 14 00 46      [ 1]   45     bcpl ntsc_flags,#F_CUR_VISI 
      0091E8 A6 14            [ 1]   46     ld a,#CURSOR_DELAY 
      00116A                         47     _straz cursor_delay
      0091EA B7 4E                    1     .byte 0xb7,cursor_delay 
      0091EC 84               [ 1]   48 9$: pop a 
      0091ED 81               [ 4]   49     ret 
                                     50 
                                     51 
                                     52 ;------------------
                                     53 ; disable tv cursor 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 100.
Hexadecimal [24-Bits]



                                     54 ;------------------
      0091EE                         55 tv_disable_cursor:
      0091EE 72 13 00 46      [ 1]   56     bres ntsc_flags,#F_CURSOR 
      0091F2 72 15 00 46      [ 1]   57     bres ntsc_flags,#F_CUR_VISI
      0091F6 88               [ 1]   58     push a 
      001177                         59     _ldaz char_under 
      0091F7 B6 4F                    1     .byte 0xb6,char_under 
      0091F9 CD 92 50         [ 4]   60     call tv_put_char 
      0091FC 84               [ 1]   61     pop a 
      0091FD 81               [ 4]   62     ret 
                                     63 
                                     64 ;------------------------------
                                     65 ; enable tv cursor
                                     66 ;-------------------------------
      0091FE                         67 tv_enable_cursor:
      0091FE 89               [ 2]   68     pushw x 
      0091FF CD 92 6A         [ 4]   69     call get_char_under 
      001182                         70     _straz char_under 
      009202 B7 4F                    1     .byte 0xb7,char_under 
      009204 A6 14            [ 1]   71     ld a,#CURSOR_DELAY  
      001186                         72     _straz cursor_delay 
      009206 B7 4E                    1     .byte 0xb7,cursor_delay 
      009208 72 12 00 46      [ 1]   73     bset ntsc_flags,#F_CURSOR
      00920C 85               [ 2]   74     popw x 
      00920D 81               [ 4]   75     ret 
                                     76 
                                     77 
                                     78 ;--------------------------
                                     79 ;  clear tv screen 
                                     80 ;--------------------------
                           000001    81     CNTR=1 
                           000003    82     CHAR_ADR=CNTR+2
                           000004    83     VSIZE=CHAR_ADR+1
      00920E                         84 tv_cls:
      00920E 89               [ 2]   85     pushw x 
      00920F 90 89            [ 2]   86     pushw y 
      009211 88               [ 1]   87     push a 
      001192                         88     _vars VSIZE 
      009212 52 04            [ 2]    1     sub sp,#VSIZE 
      009214 CD 91 EE         [ 4]   89     call tv_disable_cursor 
      009217 72 1A 00 46      [ 1]   90     bset ntsc_flags,#F_NO_DTR
      00921B A6 7F            [ 1]   91     ld a,#BLOCK 
      00119D                         92     _straz char_cursor
      00921D B7 50                    1     .byte 0xb7,char_cursor 
      00921F A6 20            [ 1]   93     ld a,#BLANK 
      0011A1                         94     _straz char_under  
      009221 B7 4F                    1     .byte 0xb7,char_under 
      009223 CD 92 5F         [ 4]   95     call font_char_address
      009226 1F 03            [ 2]   96     ldw (CHAR_ADR,sp),x 
      009228 AE 07 53         [ 2]   97     ldw x,#CHAR_PER_LINE*LINE_PER_SCREEN
      00922B 1F 01            [ 2]   98     ldw (CNTR,sp),x 
      00922D AE 08 DA         [ 2]   99     ldw x,#video_buffer 
      009230 16 03            [ 2]  100 1$: ldw y,(CHAR_ADR,sp)
      009232 FF               [ 2]  101     ldw (x),y 
      009233 1C 00 02         [ 2]  102     addw x,#2 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 101.
Hexadecimal [24-Bits]



      009236 16 01            [ 2]  103     ldw y,(CNTR,sp)
      009238 90 5A            [ 2]  104     decw y 
      00923A 17 01            [ 2]  105     ldw (CNTR,sp),y 
      00923C 26 F2            [ 1]  106     jrne 1$ 
      0011BE                        107     _clrz cursor_x 
      00923E 3F 4C                    1     .byte 0x3f, cursor_x 
      0011C0                        108     _clrz cursor_y    
      009240 3F 4D                    1     .byte 0x3f, cursor_y 
      009242 CD 91 FE         [ 4]  109     call tv_enable_cursor 
      009245 72 1B 00 46      [ 1]  110     bres ntsc_flags,#F_NO_DTR 
      0011C9                        111     _drop VSIZE 
      009249 5B 04            [ 2]    1     addw sp,#VSIZE 
      00924B 84               [ 1]  112     pop a 
      00924C 90 85            [ 2]  113     popw y 
      00924E 85               [ 2]  114     popw x 
      00924F 81               [ 4]  115     ret 
                                    116 
                                    117 ;-------------------------
                                    118 ; put character to 
                                    119 ; tv screen at current 
                                    120 ; cursor position 
                                    121 ; input:
                                    122 ;    A     character 
                                    123 ; output:
                                    124 ;   none   
                                    125 ;--------------------------
      009250                        126 tv_put_char:
      009250 89               [ 2]  127     pushw x 
      009251 CD 92 5F         [ 4]  128     call font_char_address
      009254 89               [ 2]  129     pushw x 
      009255 CD 92 91         [ 4]  130     call tv_cursor_pos 
      009258 84               [ 1]  131     pop a 
      009259 F7               [ 1]  132     ld (x),a
      00925A 84               [ 1]  133     pop a 
      00925B E7 01            [ 1]  134     ld (1,x),a      
      00925D                        135 9$: 
      00925D 85               [ 2]  136     popw x 
      00925E 81               [ 4]  137     ret 
                                    138 
                                    139 ;----------------------------
                                    140 ; return character address 
                                    141 ; in font table 
                                    142 ; input:
                                    143 ;     A     character 
                                    144 ; output:
                                    145 ;    X      address 
                                    146 ;---------------------------
      00925F                        147 font_char_address:
      00925F A0 20            [ 1]  148     sub a,#32
      009261 AE 00 08         [ 2]  149     ldw x,#8 
      009264 42               [ 4]  150     mul x,a 
      009265 72 BB 00 4A      [ 2]  151     addw x,font_addr 
      009269 81               [ 4]  152     ret 
                                    153 
                                    154 ;-------------------------
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 102.
Hexadecimal [24-Bits]



                                    155 ; get character under cursor 
                                    156 ; output:
                                    157 ;      A    character 
                                    158 ;---------------------------
      00926A                        159 get_char_under:
      00926A CD 92 91         [ 4]  160     call tv_cursor_pos
      00926D FE               [ 2]  161     ldw x,(x)
      00926E 72 B0 00 4A      [ 2]  162     subw x,font_addr
      009272 A6 08            [ 1]  163     ld a,#8
      009274 62               [ 2]  164     div x,a 
      009275 9F               [ 1]  165     ld a,xl 
      009276 AB 20            [ 1]  166     add a,#32 
      009278 81               [ 4]  167     ret 
                                    168 
                                    169 ;-------------------------
                                    170 ; set cursor column 
                                    171 ; input:
                                    172 ;    X   column 
                                    173 ;-------------------------
      009279                        174 set_cursor_column:
      009279 CD 91 EE         [ 4]  175     call tv_disable_cursor 
      00927C A6 4B            [ 1]  176     ld a,#CHAR_PER_LINE
      00927E 62               [ 2]  177     div x,a 
      0011FF                        178     _straz cursor_x 
      00927F B7 4C                    1     .byte 0xb7,cursor_x 
      009281 CD 91 FE         [ 4]  179     call tv_enable_cursor 
      009284 81               [ 4]  180     ret 
                                    181 
                                    182 ;-------------------------
                                    183 ; set cursor line 
                                    184 ; input:
                                    185 ;    X    line 
                                    186 ;------------------------
      009285                        187 set_cursor_line:
      009285 CD 91 EE         [ 4]  188     call tv_disable_cursor
      009288 A6 4B            [ 1]  189     ld a,#CHAR_PER_LINE
      00928A 62               [ 2]  190     div x,a 
      00120B                        191     _straz cursor_y 
      00928B B7 4D                    1     .byte 0xb7,cursor_y 
      00928D CD 91 FE         [ 4]  192     call tv_enable_cursor
      009290 81               [ 4]  193     ret 
                                    194 
                                    195 ;------------------------
                                    196 ; return cursor position 
                                    197 ; in  video_buffer
                                    198 ; output:
                                    199 ;   X     addr in video_buffer  
                                    200 ;------------------------
      009291                        201 tv_cursor_pos:
      009291 88               [ 1]  202     push a 
      001212                        203     _ldaz cursor_y 
      009292 B6 4D                    1     .byte 0xb6,cursor_y 
      009294 AE 00 96         [ 2]  204     ldw x,#2*CHAR_PER_LINE 
      009297 42               [ 4]  205     mul x,a 
      009298 1C 08 DA         [ 2]  206     addw x,#video_buffer 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 103.
Hexadecimal [24-Bits]



      00121B                        207     _ldaz cursor_x 
      00929B B6 4C                    1     .byte 0xb6,cursor_x 
      00929D 48               [ 1]  208     sll a 
      00121E                        209     _straz acc8  
      00929E B7 05                    1     .byte 0xb7,acc8 
      001220                        210     _clrz acc16 
      0092A0 3F 04                    1     .byte 0x3f, acc16 
      0092A2 72 BB 00 04      [ 2]  211     addw x,acc16 
      0092A6 84               [ 1]  212     pop a
      0092A7 81               [ 4]  213     ret 
                                    214 
                                    215 ;-------------------------------
                                    216 ; move cursor 1 character right 
                                    217 ;-------------------------------
      0092A8                        218 tv_cursor_right: 
      0092A8 88               [ 1]  219     push a 
      001229                        220     _incz cursor_x 
      0092A9 3C 4C                    1     .byte 0x3c, cursor_x 
      00122B                        221     _ldaz  cursor_x 
      0092AB B6 4C                    1     .byte 0xb6,cursor_x 
      0092AD A1 4B            [ 1]  222     cp a,#CHAR_PER_LINE 
      0092AF 2B 03            [ 1]  223     jrmi 9$ 
      0092B1 CD 93 03         [ 4]  224     call tv_new_line 
      0092B4                        225 9$: 
      0092B4 84               [ 1]  226     pop a 
      0092B5 81               [ 4]  227     ret 
                                    228 
                                    229 ;-------------------------------
                                    230 ; scroll screen up 1 text line 
                                    231 ;-------------------------------
      0092B6                        232 tv_scroll_up:
      0092B6 89               [ 2]  233     pushw x 
      0092B7 90 89            [ 2]  234     pushw y
      0092B9 88               [ 1]  235     push a  
      0092BA 72 1A 00 46      [ 1]  236     bset ntsc_flags,#F_NO_DTR ; block terminal from receiving characters 
      0092BE 72 16 50 0A      [ 1]  237     bset DTR_ODR,#DTR_PIN 
      0092C2 AE 0E 10         [ 2]  238     ldw x,#2*(CHAR_PER_LINE*LINE_PER_SCREEN-CHAR_PER_LINE)
      001245                        239     _strxz acc16 
      0092C5 BF 04                    1     .byte 0xbf,acc16 
      0092C7 AE 08 DA         [ 2]  240     ldw x,#video_buffer 
      0092CA 90 93            [ 1]  241     ldw y,x 
      0092CC 72 A9 00 96      [ 2]  242     addw y,#2*CHAR_PER_LINE 
      0092D0 CD 82 2E         [ 4]  243     call move
      0092D3 A6 18            [ 1]  244     ld a,#LINE_PER_SCREEN-1 
      0092D5 CD 92 E1         [ 4]  245     call tv_clear_line  
      0092D8 72 1B 00 46      [ 1]  246     bres ntsc_flags,#F_NO_DTR 
      0092DC 84               [ 1]  247     pop a 
      0092DD 90 85            [ 2]  248     popw y 
      0092DF 85               [ 2]  249     popw x
      0092E0 81               [ 4]  250     ret 
                                    251 
                                    252 ;-------------------------------
                                    253 ;  clear tv screen line 
                                    254 ; input:
                                    255 ;   A     line# {0..24}
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 104.
Hexadecimal [24-Bits]



                                    256 ;-------------------------------
      0092E1                        257 tv_clear_line:
      0092E1 89               [ 2]  258     pushw x 
      0092E2 90 89            [ 2]  259     pushw y
      0092E4 88               [ 1]  260     push a 
      0092E5 A6 20            [ 1]  261     ld a,#BLANK 
      0092E7 CD 92 5F         [ 4]  262     call font_char_address
      0092EA 90 93            [ 1]  263     ldw y,x 
      0092EC 84               [ 1]  264     pop a 
      0092ED AE 00 96         [ 2]  265     ldw x,#2*CHAR_PER_LINE 
      0092F0 42               [ 4]  266     mul x,a 
      0092F1 1C 08 DA         [ 2]  267     addw x,#video_buffer 
      0092F4 4B 4B            [ 1]  268     push #CHAR_PER_LINE 
      0092F6                        269 1$:
      0092F6 FF               [ 2]  270     ldw (x),y 
      0092F7 1C 00 02         [ 2]  271     addw x,#2 
      0092FA 0A 01            [ 1]  272     dec (1,sp)
      0092FC 26 F8            [ 1]  273     jrne 1$
      0092FE 84               [ 1]  274     pop a 
      0092FF 90 85            [ 2]  275     popw y 
      009301 85               [ 2]  276     popw x  
      009302 81               [ 4]  277     ret 
                                    278 
                                    279 ;---------------------------
                                    280 ; send cursor at beginning 
                                    281 ; of next line 
                                    282 ;---------------------------
      009303                        283 tv_new_line:
      009303 88               [ 1]  284     push a 
      001284                        285     _clrz cursor_x   
      009304 3F 4C                    1     .byte 0x3f, cursor_x 
      001286                        286     _incz cursor_y
      009306 3C 4D                    1     .byte 0x3c, cursor_y 
      001288                        287     _ldaz cursor_y 
      009308 B6 4D                    1     .byte 0xb6,cursor_y 
      00930A A1 19            [ 1]  288     cp a,#LINE_PER_SCREEN 
      00930C 2B 05            [ 1]  289     jrmi 9$ 
      00128E                        290     _decz cursor_y
      00930E 3A 4D                    1     .byte 0x3a,cursor_y 
      009310 CD 92 B6         [ 4]  291     call tv_scroll_up
      009313                        292 9$: 
      009313 84               [ 1]  293     pop a 
      009314 81               [ 4]  294     ret  
                                    295 
                                    296 ;---------------------------
                                    297 ; if cursor_x>0 delete 
                                    298 ; character left 
                                    299 ;---------------------------
      009315                        300 tv_delback:
      009315 88               [ 1]  301     push a 
      009316 72 5D 00 4C      [ 1]  302     tnz cursor_x 
      00931A 27 07            [ 1]  303     jreq 9$ 
      00129C                        304     _decz cursor_x 
      00931C 3A 4C                    1     .byte 0x3a,cursor_x 
      00931E A6 20            [ 1]  305     ld a,#BLANK 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 105.
Hexadecimal [24-Bits]



      009320 CD 92 50         [ 4]  306     call tv_put_char
      009323 84               [ 1]  307 9$: pop a    
      009324 81               [ 4]  308     ret 
                                    309 
                                    310 ;--------------------------
                                    311 ; print a character to tv 
                                    312 ; screen or execute 
                                    313 ; control sequence 
                                    314 ; input:
                                    315 ;    A     character 
                                    316 ;---------------------------
      009325                        317 tv_print_char:
      009325 CD 91 EE         [ 4]  318     call tv_disable_cursor
                                    319 ;    and a,#127 
      009328 A1 20            [ 1]  320     cp a,#SPACE  
      00932A 2A 35            [ 1]  321     jrpl 8$ 
      00932C A1 08            [ 1]  322     cp a,#BS 
      00932E 26 05            [ 1]  323     jrne 1$ 
      009330 CD 93 15         [ 4]  324     call tv_delback
      009333 20 32            [ 2]  325     jra 9$ 
      009335                        326 1$: 
      009335 A1 0A            [ 1]  327     cp a,#LF 
      009337 26 05            [ 1]  328     jrne 3$ 
      009339                        329 2$:
      009339 CD 93 03         [ 4]  330     call tv_new_line 
      00933C 20 29            [ 2]  331     jra 9$ 
      00933E A1 0D            [ 1]  332 3$: cp a,#CR 
      009340 27 F7            [ 1]  333     jreq 2$
      009342 A1 1B            [ 1]  334     cp a,#ESC 
      009344 26 21            [ 1]  335     jrne 9$ 
      009346 CD 8E 32         [ 4]  336     call uart_getc
      009349 A1 63            [ 1]  337     cp a,#'c 
      00934B 26 06            [ 1]  338     jrne 4$
      00934D 4F               [ 1]  339     clr a  
      00934E CD 92 0E         [ 4]  340     call tv_cls 
      009351 20 14            [ 2]  341     jra 9$
      009353 A1 5B            [ 1]  342 4$: cp a,#'[
      009355 26 05            [ 1]  343     jrne 5$ 
      009357 CD 93 6B         [ 4]  344     call process_csi 
      00935A 20 0B            [ 2]  345     jra 9$ 
      00935C A1 5F            [ 1]  346 5$: cp a,#'_ 
      00935E CD 94 94         [ 4]  347     call process_app_cmd             
      009361                        348 8$: 
      009361 CD 92 50         [ 4]  349     call tv_put_char
      009364 CD 92 A8         [ 4]  350     call tv_cursor_right
      009367                        351 9$:
      009367 CD 91 FE         [ 4]  352     call tv_enable_cursor
      00936A 81               [ 4]  353     ret 
                                    354 
                                    355 
                                    356 ;------------------------------------
                                    357 ; sequence control introducer
                                    358 ; received, process control sequence 
                                    359 ;------------------------------------
                                    360 ; csi parameters 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 106.
Hexadecimal [24-Bits]



                           000001   361     PN=1 ; first parameter 
                           000003   362     PM=PN+2  ; second parameter
                           000004   363     VSIZE=PM+1 
      00936B                        364 process_csi:
      0012EB                        365     _vars VSIZE
      00936B 52 04            [ 2]    1     sub sp,#VSIZE 
                                    366 ; first parameter 
      00936D CD 94 E5         [ 4]  367     call get_parameter 
      009370 1F 01            [ 2]  368     ldw (PN,sp),x
      009372 A1 3B            [ 1]  369     cp a,#';
      009374 26 05            [ 1]  370     jrne 2$      
                                    371 ; second parameter     
      009376 CD 94 E5         [ 4]  372     call get_parameter 
      009379 1F 03            [ 2]  373     ldw (PM,sp),x
      00937B                        374 2$:; recognize 'A','B','C','D','G','d','H','n','s','u'  
      00937B A1 47            [ 1]  375     cp a,#'G 
      00937D 26 0D            [ 1]  376     jrne 3$ 
                                    377 ; put cursor at column PN  
      00937F 1E 01            [ 2]  378     ldw x,(PN,sp) ; Pn e|{1..62}
      009381 27 01            [ 1]  379     jreq 22$ 
      009383 5A               [ 2]  380     decw x 
      009384                        381 22$:
      009384 A6 4B            [ 1]  382     ld a,#CHAR_PER_LINE
      009386 CD 92 79         [ 4]  383     call set_cursor_column
      009389 CC 94 78         [ 2]  384     jp 9$ 
      00938C                        385 3$:    
      00938C A1 64            [ 1]  386     cp a,#'d 
      00938E 26 0B            [ 1]  387     jrne 4$ 
                                    388 ; put cursor at line PN  
      009390 1E 01            [ 2]  389     ldw x,(PN,sp) ; Pn e|{1..25}
      009392 27 01            [ 1]  390     jreq 32$ 
      009394 5A               [ 2]  391     decw x 
      009395                        392 32$:
      009395 CD 92 85         [ 4]  393     call set_cursor_line
      009398 CC 94 78         [ 2]  394     jp 9$ 
      00939B                        395 4$:
      00939B A1 48            [ 1]  396     cp a,#'H 
      00939D 26 13            [ 1]  397     jrne 5$ ; ignore it 
                                    398 ; put cusor at line and column 
      00939F 1E 01            [ 2]  399     ldw x,(PN,sp)
      0093A1 27 01            [ 1]  400     jreq 42$ 
      0093A3 5A               [ 2]  401     decw x 
      0093A4                        402 42$: 
      0093A4 CD 92 85         [ 4]  403     call set_cursor_line
      0093A7 1E 03            [ 2]  404     ldw x,(PM,sp)
      0093A9 27 01            [ 1]  405     jreq 44$ 
      0093AB 5A               [ 2]  406     decw  x 
      0093AC                        407 44$:
      0093AC CD 92 79         [ 4]  408     call set_cursor_column
      0093AF CC 94 78         [ 2]  409     jp 9$ 
      0093B2                        410 5$: ; move cursor n lines up 
      0093B2 A1 41            [ 1]  411     cp a,#'A 
      0093B4 26 14            [ 1]  412     jrne 6$ 
      0093B6 1E 01            [ 2]  413     ldw x,(PN,sp) 
      0093B8 26 01            [ 1]  414     jrne 52$ 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 107.
Hexadecimal [24-Bits]



      0093BA 5C               [ 1]  415     incw x 
      0093BB                        416 52$:
      0093BB A6 19            [ 1]  417     ld a,#LINE_PER_SCREEN 
      0093BD 62               [ 2]  418     div x,a 
      00133E                        419     _straz acc8 
      0093BE B7 05                    1     .byte 0xb7,acc8 
      001340                        420     _ldaz cursor_y  
      0093C0 B6 4D                    1     .byte 0xb6,cursor_y 
      0093C2 C0 00 05         [ 1]  421     sub a,acc8  
      0093C5 24 1D            [ 1]  422     jrnc 66$  
      0093C7 4F               [ 1]  423     clr a 
      0093C8 20 1A            [ 2]  424     jra 66$ 
      0093CA                        425 6$: ; move cursor n line down 
      0093CA A1 42            [ 1]  426     cp a,#'B 
      0093CC 26 1E            [ 1]  427     jrne 7$ 
      0093CE 1E 01            [ 2]  428     ldw x,(PN,sp)
      0093D0 26 01            [ 1]  429     jrne 62$ 
      0093D2 5C               [ 1]  430     incw x
      0093D3                        431 62$: 
      0093D3 A6 19            [ 1]  432     ld a,#LINE_PER_SCREEN 
      0093D5 62               [ 2]  433     div x,a 
      0093D6 CB 00 4D         [ 1]  434     add a,cursor_y 
      0093D9 C1 00 4D         [ 1]  435     cp a,cursor_y 
      0093DC 25 04            [ 1]  436     jrult 64$ 
      0093DE A1 19            [ 1]  437     cp a,#LINE_PER_SCREEN
      0093E0 25 02            [ 1]  438     jrult 66$       
      0093E2                        439 64$: 
      0093E2 A6 18            [ 1]  440     ld a,#LINE_PER_SCREEN-1
      0093E4                        441 66$:
      0093E4 5F               [ 1]  442     clrw x 
      0093E5 97               [ 1]  443     ld xl,a 
      0093E6 CD 92 85         [ 4]  444     call set_cursor_line
      0093E9 CC 94 78         [ 2]  445     jp 9$ 
      0093EC                        446 7$: ; move cursor n spaces right 
      0093EC A1 43            [ 1]  447     cp a,#'C 
      0093EE 26 1D            [ 1]  448     jrne 8$ 
      0093F0 1E 01            [ 2]  449     ldw x,(PN,sp)
      0093F2 26 01            [ 1]  450     jrne 72$ 
      0093F4 5C               [ 1]  451     incw x 
      0093F5                        452 72$:
      0093F5 A6 4B            [ 1]  453     ld a,#CHAR_PER_LINE
      0093F7 62               [ 2]  454     div x,a 
      0093F8 CB 00 4C         [ 1]  455     add a,cursor_x 
      0093FB C1 00 4C         [ 1]  456     cp a, cursor_x 
      0093FE 25 04            [ 1]  457     jrult 74$
      009400 A1 4B            [ 1]  458     cp a,#CHAR_PER_LINE 
      009402 2B 02            [ 1]  459     jrmi 76$
      009404                        460 74$: 
      009404 A6 4A            [ 1]  461     ld a,#CHAR_PER_LINE-1
      009406                        462 76$:
      009406 5F               [ 1]  463     clrw x 
      009407 97               [ 1]  464     ld xl,a 
      009408 CD 92 79         [ 4]  465     call set_cursor_column 
      00940B 20 6B            [ 2]  466     jra 9$ 
      00940D                        467 8$: ; move cursor n spaces left 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 108.
Hexadecimal [24-Bits]



      00940D A1 44            [ 1]  468     cp a,#'D 
      00940F 26 14            [ 1]  469     jrne 84$ 
      009411 1E 01            [ 2]  470     ldw x,(PN,sp) 
      009413 26 01            [ 1]  471     jrne 82$
      009415 5C               [ 1]  472     incw x 
      009416                        473 82$:
      009416 A6 4B            [ 1]  474     ld a,#CHAR_PER_LINE
      009418 62               [ 2]  475     div x,a 
      001399                        476     _straz acc8 
      009419 B7 05                    1     .byte 0xb7,acc8 
      00139B                        477     _ldaz cursor_x  
      00941B B6 4C                    1     .byte 0xb6,cursor_x 
      00941D C0 00 05         [ 1]  478     sub a,acc8  
      009420 24 E4            [ 1]  479     jrnc 76$ 
      009422 4F               [ 1]  480     clr a  
      009423 20 E1            [ 2]  481     jra 76$
      009425                        482 84$:
      009425 A1 73            [ 1]  483     cp a,#'s
      009427 26 0C            [ 1]  484     jrne 86$
      009429 55 00 4C 00 51   [ 1]  485     mov saved_cx,cursor_x 
      00942E 55 00 4D 00 52   [ 1]  486     mov saved_cy,cursor_y
      009433 20 43            [ 2]  487     jra 9$  
      009435                        488 86$: 
      009435 A1 75            [ 1]  489     cp a,#'u
      009437 26 10            [ 1]  490     jrne 88$ 
      0013B9                        491     _ldaz saved_cy 
      009439 B6 52                    1     .byte 0xb6,saved_cy 
      00943B 5F               [ 1]  492     clrw x 
      00943C 97               [ 1]  493     ld xl,a 
      00943D CD 92 85         [ 4]  494     call set_cursor_line
      0013C0                        495     _ldaz saved_cx 
      009440 B6 51                    1     .byte 0xb6,saved_cx 
      009442 5F               [ 1]  496     clrw x
      009443 97               [ 1]  497     ld xl,a 
      009444 CD 92 79         [ 4]  498     call set_cursor_column
      009447 20 2F            [ 2]  499     jra 9$ 
      009449                        500 88$: 
      009449 A1 6E            [ 1]  501     cp a,#'n 
      00944B 26 2B            [ 1]  502     jrne 9$ 
      00944D 1E 01            [ 2]  503     ldw x,(PN,sp)
      00944F A3 00 06         [ 2]  504     cpw x,#6 
      009452 26 24            [ 1]  505     jrne 9$ 
                                    506 ; report cursor position 
      009454 A6 1B            [ 1]  507     ld a,#ESC
      009456 CD 8E 00         [ 4]  508     call uart_putc 
      009459 A6 5B            [ 1]  509     ld a,#'[
      00945B CD 8E 00         [ 4]  510     call uart_putc 
      00945E 5F               [ 1]  511     clrw x 
      0013DF                        512     _ldaz cursor_y 
      00945F B6 4D                    1     .byte 0xb6,cursor_y 
      009461 4C               [ 1]  513     inc a 
      009462 97               [ 1]  514     ld xl,a 
      009463 CD 94 7B         [ 4]  515     call send_parameter  
      009466 A6 3B            [ 1]  516     ld a,#'; 
      009468 CD 8E 00         [ 4]  517     call uart_putc 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 109.
Hexadecimal [24-Bits]



      00946B 5F               [ 1]  518     clrw x 
      0013EC                        519     _ldaz cursor_x 
      00946C B6 4C                    1     .byte 0xb6,cursor_x 
      00946E 4C               [ 1]  520     inc a 
      00946F 97               [ 1]  521     ld xl,a 
      009470 CD 94 7B         [ 4]  522     call send_parameter 
      009473 A6 52            [ 1]  523     ld a,#'R 
      009475 CD 8E 00         [ 4]  524     call uart_putc 
      009478                        525 9$:
      0013F8                        526     _drop VSIZE 
      009478 5B 04            [ 2]    1     addw sp,#VSIZE 
      00947A 81               [ 4]  527     ret 
                                    528 
                                    529 ;----------------
                                    530 ; convert integer 
                                    531 ; to ASCII and 
                                    532 ; send it 
                                    533 ; input:
                                    534 ;   X    integer 
                                    535 ;-----------------
      00947B                        536 send_parameter:
      00947B 90 89            [ 2]  537     pushw y 
      00947D 4B 00            [ 1]  538     push #0 
      00947F                        539 1$:
      00947F A6 0A            [ 1]  540     ld a,#10 
      009481 62               [ 2]  541     div x,a 
      009482 AB 30            [ 1]  542     add a,#'0 
      009484 88               [ 1]  543     push a 
      009485 5D               [ 2]  544     tnzw x 
      009486 26 F7            [ 1]  545     jrne 1$
      009488                        546 2$:
      009488 84               [ 1]  547     pop a 
      009489 4D               [ 1]  548     tnz a 
      00948A 27 05            [ 1]  549     jreq 9$ 
      00948C CD 8E 00         [ 4]  550     call uart_putc 
      00948F 20 F7            [ 2]  551     jra 2$ 
      009491                        552 9$:
      009491 90 85            [ 2]  553     popw y 
      009493 81               [ 4]  554     ret 
                                    555 
                                    556 
                                    557 ;------------------------
                                    558 ;  application program 
                                    559 ;  commande ESC_ 
                                    560 ;  ESC_C  send character under cursor 
                                    561 ;  ESC_V  print terminal firmware version
                                    562 ;------------------------
      009494                        563 process_app_cmd:
      009494 CD 8E 32         [ 4]  564     call uart_getc 
      009497 A1 43            [ 1]  565     cp a,#'C 
      009499 26 07            [ 1]  566     jrne 1$ 
                                    567 ; ESC_C return character at cursor position
      00141B                        568     _ldaz char_under 
      00949B B6 4F                    1     .byte 0xb6,char_under 
      00949D CD 8E 00         [ 4]  569     call uart_putc
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 110.
Hexadecimal [24-Bits]



      0094A0 20 27            [ 2]  570     jra 9$ 
      0094A2                        571 1$: 
      0094A2 A1 56            [ 1]  572     cp a,#'V 
      0094A4 26 23            [ 1]  573     jrne 2$
      0094A6 AE 00 01         [ 2]  574     ldw x,#MAJOR
      0094A9 CD 94 CA         [ 4]  575     call tv_print_int
      0094AC A6 2E            [ 1]  576     ld a,#'. 
      0094AE CD 93 25         [ 4]  577     call tv_print_char 
      0094B1 AE 00 01         [ 2]  578     ldw x,#MINOR 
      0094B4 CD 94 CA         [ 4]  579     call tv_print_int 
      0094B7 A6 52            [ 1]  580     ld a,#'R
      0094B9 CD 93 25         [ 4]  581     call tv_print_char 
      0094BC AE 00 00         [ 2]  582     ldw x,#REV 
      0094BF CD 94 CA         [ 4]  583     call tv_print_int 
      0094C2 A6 0D            [ 1]  584     ld a,#CR 
      0094C4 CD 93 25         [ 4]  585     call tv_print_char
      0094C7 20 00            [ 2]  586     jra 9$ 
      0094C9                        587 2$:
      0094C9                        588 9$: 
      0094C9 81               [ 4]  589     ret 
                                    590 
                                    591 ;-------------------
                                    592 ; print integer in X 
                                    593 ; to terminal 
                                    594 ; INPUT:
                                    595 ;    X   integer 
                                    596 ;--------------------
                           000001   597     DIGIT=1
                           000002   598     VSIZE=DIGIT+1
      0094CA                        599 tv_print_int:
      0094CA 4B 00            [ 1]  600     push #0 
      0094CC 4B 00            [ 1]  601     push #0
      0094CE 4B 00            [ 1]  602     push #0 
      0094D0                        603 1$: 
      0094D0 A6 0A            [ 1]  604     ld a,#10 
      0094D2 62               [ 2]  605     div x,a 
      0094D3 AB 30            [ 1]  606     add a,#'0
      0094D5 88               [ 1]  607     push a 
      0094D6 5D               [ 2]  608     tnzw x 
      0094D7 26 F7            [ 1]  609     jrne 1$
      0094D9                        610 2$:
      0094D9 84               [ 1]  611     pop a 
      0094DA 4D               [ 1]  612     tnz a 
      0094DB 27 05            [ 1]  613     jreq 9$
      0094DD CD 93 25         [ 4]  614     call tv_print_char 
      0094E0 20 F7            [ 2]  615     jra 2$ 
      0094E2                        616 9$:
      001462                        617     _drop 2 
      0094E2 5B 02            [ 2]    1     addw sp,#2 
      0094E4 81               [ 4]  618     ret 
                                    619 
                                    620 
                                    621 ;----------------------
                                    622 ; get control sequence 
                                    623 ; parameter 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 111.
Hexadecimal [24-Bits]



                                    624 ; output:
                                    625 ;    A     last character 
                                    626 ;    X     parameter  
                                    627 ;----------------------
                           000001   628     DIGIT=1 
                           000003   629     PM=DIGIT+2 
                           000004   630     VSIZE=PM+1
      0094E5                        631 get_parameter:
      001465                        632     _vars VSIZE 
      0094E5 52 04            [ 2]    1     sub sp,#VSIZE 
      0094E7 5F               [ 1]  633     clrw x 
      0094E8 1F 01            [ 2]  634     ldw (DIGIT,sp),x 
      0094EA 1F 03            [ 2]  635     ldw (PM,sp),x 
      0094EC                        636 1$: 
      0094EC CD 8E 32         [ 4]  637     call uart_getc 
      0094EF CD 82 8E         [ 4]  638     call is_digit 
      0094F2 24 10            [ 1]  639     jrnc 2$ 
      0094F4 A0 30            [ 1]  640     sub a,#'0
      0094F6 6B 02            [ 1]  641     ld (DIGIT+1,sp),a 
      0094F8 A6 0A            [ 1]  642     ld a,#10
      0094FA 1E 03            [ 2]  643     ldw x,(PM,sp)
      0094FC 42               [ 4]  644     mul x,a 
      0094FD 72 FB 01         [ 2]  645     addw x,(DIGIT,sp)
      009500 1F 03            [ 2]  646     ldw (PM,sp),x 
      009502 20 E8            [ 2]  647     jra 1$ 
      009504                        648 2$:
      009504 1E 03            [ 2]  649     ldw x,(PM,sp)
      001486                        650     _drop VSIZE 
      009506 5B 04            [ 2]    1     addw sp,#VSIZE 
      009508 81               [ 4]  651     ret 
                                    652 
                                    653 
                                    654 ;------------------------
                                    655 ;  print string to tv 
                                    656 ; input:
                                    657 ;   X      *string
                                    658 ;-------------------------
      009509                        659 tv_puts:
      009509 88               [ 1]  660     push a
      00950A                        661 1$:     
      00950A F6               [ 1]  662     ld a,(x)
      00950B 27 06            [ 1]  663     jreq 9$ 
      00950D CD 93 25         [ 4]  664     call tv_print_char  
      009510 5C               [ 1]  665     incw x 
      009511 20 F7            [ 2]  666     jra 1$ 
      009513 84               [ 1]  667 9$: pop a 
      009514 5C               [ 1]  668     incw x 
      009515 81               [ 4]  669     ret 
                                    670 
                                    671 ;-------------------------
                                    672 ; receive characters from 
                                    673 ; translate scan codes 
                                    674 ; from local keyboard and 
                                    675 ; send them to UART TX 
                                    676 ; 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 112.
Hexadecimal [24-Bits]



                                    677 ; character received from 
                                    678 ; UART RX are sent to 
                                    679 ; tv_term for processing. 
                                    680 ; 
                                    681 ; This is the application 
                                    682 ; main program and 
                                    683 ; never exit.
                                    684 ;--------------------------
      009516                        685 main:
      009516 CD 85 4C         [ 4]  686     call keyboard_read
      009519 27 0D            [ 1]  687     jreq 2$
      00951B 72 07 00 46 05   [ 2]  688     btjf ntsc_flags,#F_LECHO,1$ 
      009520 88               [ 1]  689     push a 
      009521 CD 93 25         [ 4]  690     call tv_print_char
      009524 84               [ 1]  691     pop a 
      009525                        692 1$:    
      009525 CD 8E 00         [ 4]  693     call uart_putc
      009528                        694 2$: 
      009528 CD 8E 2C         [ 4]  695     call uart_qgetc
      00952B 27 E9            [ 1]  696     jreq main 
      00952D CD 8E 32         [ 4]  697     call uart_getc  
      009530 CD 93 25         [ 4]  698     call tv_print_char
      009533 20 E1            [ 2]  699     jra main 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 113.
Hexadecimal [24-Bits]

Symbol Table

    .__.$$$.=  002710 L   |     .__.ABS.=  000000 G   |     .__.CPU.=  000000 L
    .__.H$L.=  000001 L   |     ACK     =  000006     |     ACUT    =  000060 
    ADC_CR1 =  005401     |     ADC_CR1_=  000000     |     ADC_CR1_=  000001 
    ADC_CR1_=  000004     |     ADC_CR1_=  000005     |     ADC_CR1_=  000006 
    ADC_CR2 =  005402     |     ADC_CR2_=  000003     |     ADC_CR2_=  000004 
    ADC_CR2_=  000005     |     ADC_CR2_=  000006     |     ADC_CR2_=  000001 
    ADC_CR3 =  005403     |     ADC_CR3_=  000007     |     ADC_CR3_=  000006 
    ADC_CSR =  005400     |     ADC_CSR_=  000006     |     ADC_CSR_=  000004 
    ADC_CSR_=  000000     |     ADC_CSR_=  000001     |     ADC_CSR_=  000002 
    ADC_CSR_=  000003     |     ADC_CSR_=  000007     |     ADC_CSR_=  000005 
    ADC_DRH =  005404     |     ADC_DRL =  005405     |     ADC_TDRH=  005406 
    ADC_TDRL=  005407     |     AFR     =  004803     |     AFR0_ADC=  000000 
    AFR1_TIM=  000001     |     AFR2_CCO=  000002     |     AFR3_TIM=  000003 
    AFR4_TIM=  000004     |     AFR5_TIM=  000005     |     AFR6_I2C=  000006 
    AFR7_BEE=  000007     |     AL      =  000061     |     AMP     =  000026 
    AROB    =  000040     |     AU      =  000041     |     AWU_APR =  0050F1 
    AWU_CSR =  0050F0     |     AWU_CSR_=  000004     |     AWU_TBR =  0050F2 
    B0_MASK =  000001     |     B115200 =  000006     |     B19200  =  000003 
    B1_MASK =  000002     |     B230400 =  000007     |     B2400   =  000000 
    B2_MASK =  000004     |     B38400  =  000004     |     B3_MASK =  000008 
    B460800 =  000008     |     B4800   =  000001     |     B4_MASK =  000010 
    B57600  =  000005     |     B5_MASK =  000020     |     B6_MASK =  000040 
    B7_MASK =  000080     |     B921600 =  000009     |     B9600   =  000002 
    BAT_OK  =  0000AA     |     BAUD_115=  000006     |     BAUD_192=  000002 
    BAUD_384=  000004     |     BAUD_960=  000000     |     BAUD_RAT=  01C200 
    BEEP_BIT=  000004     |     BEEP_CSR=  0050F3     |     BEEP_MAS=  000010 
    BEEP_POR=  00000F     |     BELL    =  000007     |     BIT0    =  000000 
    BIT1    =  000001     |     BIT2    =  000002     |     BIT3    =  000003 
    BIT4    =  000004     |     BIT5    =  000005     |     BIT6    =  000006 
    BIT7    =  000007     |     BL      =  000062     |     BLANK   =  000020 
    BLOCK   =  00007F     |     BLOCK_SI=  000080     |     BOOT_ROM=  006000 
    BOOT_ROM=  007FFF     |     BS      =  000008     |     BSLA    =  00005C 
    BU      =  000042     |     CAN     =  000018     |     CAN_DGR =  005426 
    CAN_FPSR=  005427     |     CAN_IER =  005425     |     CAN_MCR =  005420 
    CAN_MSR =  005421     |     CAN_P0  =  005428     |     CAN_P1  =  005429 
    CAN_P2  =  00542A     |     CAN_P3  =  00542B     |     CAN_P4  =  00542C 
    CAN_P5  =  00542D     |     CAN_P6  =  00542E     |     CAN_P7  =  00542F 
    CAN_P8  =  005430     |     CAN_P9  =  005431     |     CAN_PA  =  005432 
    CAN_PB  =  005433     |     CAN_PC  =  005434     |     CAN_PD  =  005435 
    CAN_PE  =  005436     |     CAN_PF  =  005437     |     CAN_RFR =  005424 
    CAN_TPR =  005423     |     CAN_TSR =  005422     |     CC_C    =  000000 
    CC_H    =  000004     |     CC_I0   =  000003     |     CC_I1   =  000005 
    CC_N    =  000002     |     CC_V    =  000007     |     CC_Z    =  000001 
    CFG_GCR =  007F60     |     CFG_GCR_=  000001     |     CFG_GCR_=  000000 
    CHAR_ADR=  000003     |     CHAR_PER=  00004B     |     CIRC    =  00005E 
    CL      =  000063     |     CLKOPT  =  004807     |     CLKOPT_C=  000002 
    CLKOPT_E=  000003     |     CLKOPT_P=  000000     |     CLKOPT_P=  000001 
    CLK_CCOR=  0050C9     |     CLK_CKDI=  0050C6     |     CLK_CKDI=  000000 
    CLK_CKDI=  000001     |     CLK_CKDI=  000002     |     CLK_CKDI=  000003 
    CLK_CKDI=  000004     |     CLK_CMSR=  0050C3     |     CLK_CSSR=  0050C8 
    CLK_ECKR=  0050C1     |     CLK_ECKR=  000000     |     CLK_ECKR=  000001 
    CLK_HSIT=  0050CC     |     CLK_ICKR=  0050C0     |     CLK_ICKR=  000002 
    CLK_ICKR=  000000     |     CLK_ICKR=  000001     |     CLK_ICKR=  000003 
    CLK_ICKR=  000004     |     CLK_ICKR=  000005     |     CLK_PCKE=  0050C7 
    CLK_PCKE=  000000     |     CLK_PCKE=  000001     |     CLK_PCKE=  000007 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 114.
Hexadecimal [24-Bits]

Symbol Table

    CLK_PCKE=  000005     |     CLK_PCKE=  000006     |     CLK_PCKE=  000004 
    CLK_PCKE=  000002     |     CLK_PCKE=  000003     |     CLK_PCKE=  0050CA 
    CLK_PCKE=  000003     |     CLK_PCKE=  000002     |     CLK_PCKE=  000007 
    CLK_SWCR=  0050C5     |     CLK_SWCR=  000000     |     CLK_SWCR=  000001 
    CLK_SWCR=  000002     |     CLK_SWCR=  000003     |     CLK_SWIM=  0050CD 
    CLK_SWR =  0050C4     |     CLK_SWR_=  0000B4     |     CLK_SWR_=  0000E1 
    CLK_SWR_=  0000D2     |     CNTR    =  000001     |     COLON   =  00003A 
    COMMA   =  00002C     |     CPU_A   =  007F00     |     CPU_CCR =  007F0A 
    CPU_PCE =  007F01     |     CPU_PCH =  007F02     |     CPU_PCL =  007F03 
    CPU_SPH =  007F08     |     CPU_SPL =  007F09     |     CPU_XH  =  007F04 
    CPU_XL  =  007F05     |     CPU_YH  =  007F06     |     CPU_YL  =  007F07 
    CR      =  00000D     |     CTRL_A  =  000001     |     CTRL_B  =  000002 
    CTRL_C  =  000003     |     CTRL_D  =  000004     |     CTRL_E  =  000005 
    CTRL_F  =  000006     |     CTRL_G  =  000007     |     CTRL_H  =  000008 
    CTRL_I  =  000009     |     CTRL_J  =  00000A     |     CTRL_K  =  00000B 
    CTRL_L  =  00000C     |     CTRL_M  =  00000D     |     CTRL_N  =  00000E 
    CTRL_O  =  00000F     |     CTRL_P  =  000010     |     CTRL_Q  =  000011 
    CTRL_R  =  000012     |     CTRL_S  =  000013     |     CTRL_T  =  000014 
    CTRL_U  =  000015     |     CTRL_V  =  000016     |     CTRL_W  =  000017 
    CTRL_X  =  000018     |     CTRL_Y  =  000019     |     CTRL_Z  =  00001A 
    CU      =  000043     |     CURSOR_D=  000014     |     DASH    =  00002D 
    DATA_BIT=  000001     |     DC1     =  000011     |     DC2     =  000012 
    DC3     =  000013     |     DC4     =  000014     |     DEBUG   =  000000 
    DEBUG_BA=  007F00     |     DEBUG_EN=  007FFF     |     DEL     =  00007F 
    DEVID_BA=  0048CD     |     DEVID_EN=  0048D8     |     DEVID_LO=  0048D2 
    DEVID_LO=  0048D3     |     DEVID_LO=  0048D4     |     DEVID_LO=  0048D5 
    DEVID_LO=  0048D6     |     DEVID_LO=  0048D7     |     DEVID_LO=  0048D8 
    DEVID_WA=  0048D1     |     DEVID_XH=  0048CE     |     DEVID_XL=  0048CD 
    DEVID_YH=  0048D0     |     DEVID_YL=  0048CF     |     DEV_ID  =  00000C 
    DEV_ID0_=  000002     |     DEV_ID1_=  000003     |     DEV_ID_P=  005006 
    DIGIT   =  000001     |     DL      =  000064     |     DLE     =  000010 
    DM_BK1RE=  007F90     |     DM_BK1RH=  007F91     |     DM_BK1RL=  007F92 
    DM_BK2RE=  007F93     |     DM_BK2RH=  007F94     |     DM_BK2RL=  007F95 
    DM_CR1  =  007F96     |     DM_CR2  =  007F97     |     DM_CSR1 =  007F98 
    DM_CSR2 =  007F99     |     DM_ENFCT=  007F9A     |     DOLLR   =  000024 
    DOT     =  00002E     |     DQUOT   =  000022     |     DTR_CR1 =  00500D 
    DTR_CR2 =  00500E     |     DTR_DDR =  00500C     |     DTR_ODR =  00500A 
    DTR_PIN =  000003     |     DU      =  000044     |   8 DoNothin   000000 R
    ECHO_BIT=  000000     |     ECHO_POR=  005010     |     EEPROM_B=  004000 
    EEPROM_E=  0043FF     |     EEPROM_S=  000400     |     EIGHT   =  000038 
    EL      =  000065     |     EM      =  000019     |     ENQ     =  000005 
    EOF     =  00001A     |     EOT     =  000004     |     EPULSE  =  00002F 
    EQUAL   =  00003D     |     ESC     =  00001B     |     ETB     =  000017 
    ETX     =  000003     |     EU      =  000045     |     EXCLA   =  000021 
    EXTI_CR1=  0050A0     |     EXTI_CR2=  0050A1     |     FF      =  00000C 
    FHSE    =  7A1200     |     FHSI    =  F42400     |     FIRST_VI=  000032 
    FIVE    =  000035     |     FL      =  000066     |     FLASH_BA=  008000 
    FLASH_CR=  00505A     |     FLASH_CR=  000002     |     FLASH_CR=  000000 
    FLASH_CR=  000003     |     FLASH_CR=  000001     |     FLASH_CR=  00505B 
    FLASH_CR=  000005     |     FLASH_CR=  000004     |     FLASH_CR=  000007 
    FLASH_CR=  000000     |     FLASH_CR=  000006     |     FLASH_DU=  005064 
    FLASH_DU=  0000AE     |     FLASH_DU=  000056     |     FLASH_EN=  017FFF 
    FLASH_FP=  00505D     |     FLASH_FP=  000000     |     FLASH_FP=  000001 
    FLASH_FP=  000002     |     FLASH_FP=  000003     |     FLASH_FP=  000004 
    FLASH_FP=  000005     |     FLASH_IA=  00505F     |     FLASH_IA=  000003 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 115.
Hexadecimal [24-Bits]

Symbol Table

    FLASH_IA=  000002     |     FLASH_IA=  000006     |     FLASH_IA=  000001 
    FLASH_IA=  000000     |     FLASH_NC=  00505C     |     FLASH_NF=  00505E 
    FLASH_NF=  000000     |     FLASH_NF=  000001     |     FLASH_NF=  000002 
    FLASH_NF=  000003     |     FLASH_NF=  000004     |     FLASH_NF=  000005 
    FLASH_PU=  005062     |     FLASH_PU=  000056     |     FLASH_PU=  0000AE 
    FLASH_SI=  010000     |     FLASH_WS=  00480D     |     FLSI    =  01F400 
    FMSTR   =  000018     |     FONT_HEI=  000008     |     FONT_ROW=  000001 
    FONT_WID=  000006     |     FOUR    =  000034     |     FR_HORZ =  003D76 
    FS      =  00001C     |     FU      =  000046     |     F_ACK   =  000006 
    F_ALT   =  000005     |     F_BATOK =  000007     |     F_CAPS  =  000002 
    F_CTRL  =  000004     |     F_CURSOR=  000001     |     F_CUR_TO=  000006 
    F_CUR_VI=  000002     |     F_EVEN  =  000000     |     F_LECHO =  000003 
    F_NO_DTR=  000005     |     F_NUM   =  000001     |     F_REL   =  000002 
    F_RX_ERR=  000004     |     F_SEND  =  000000     |     F_SHIFT =  000003 
    F_VIDEO =  000004     |     F_XT    =  000001     |     GL      =  000067 
    GPIO_BAS=  005000     |     GPIO_CR1=  000003     |     GPIO_CR2=  000004 
    GPIO_DDR=  000002     |     GPIO_IDR=  000001     |     GPIO_ODR=  000000 
    GPIO_SIZ=  000005     |     GS      =  00001D     |     GT      =  00003E 
    GU      =  000047     |     HALF_LIN=  0002FA     |     HL      =  000068 
    HLINE   =  0005F4     |     HPULSE  =  00005E     |     HSE     =  000001 
    HSECNT  =  004809     |     HU      =  000048     |     I2C_BASE=  005210 
    I2C_CCRH=  00521C     |     I2C_CCRH=  000080     |     I2C_CCRH=  0000C0 
    I2C_CCRH=  000080     |     I2C_CCRH=  000000     |     I2C_CCRH=  000001 
    I2C_CCRH=  000000     |     I2C_CCRH=  000006     |     I2C_CCRH=  000007 
    I2C_CCRL=  00521B     |     I2C_CCRL=  00001A     |     I2C_CCRL=  000002 
    I2C_CCRL=  00000D     |     I2C_CCRL=  000050     |     I2C_CCRL=  000090 
    I2C_CCRL=  0000A0     |     I2C_CR1 =  005210     |     I2C_CR1_=  000006 
    I2C_CR1_=  000007     |     I2C_CR1_=  000000     |     I2C_CR2 =  005211 
    I2C_CR2_=  000002     |     I2C_CR2_=  000003     |     I2C_CR2_=  000000 
    I2C_CR2_=  000001     |     I2C_CR2_=  000007     |     I2C_DR  =  005216 
    I2C_FREQ=  005212     |     I2C_ITR =  00521A     |     I2C_ITR_=  000002 
    I2C_ITR_=  000000     |     I2C_ITR_=  000001     |     I2C_OARH=  005214 
    I2C_OARH=  000001     |     I2C_OARH=  000002     |     I2C_OARH=  000006 
    I2C_OARH=  000007     |     I2C_OARL=  005213     |     I2C_OARL=  000000 
    I2C_OAR_=  000813     |     I2C_OAR_=  000009     |     I2C_PECR=  00521E 
    I2C_READ=  000001     |     I2C_SR1 =  005217     |     I2C_SR1_=  000003 
    I2C_SR1_=  000001     |     I2C_SR1_=  000002     |     I2C_SR1_=  000006 
    I2C_SR1_=  000000     |     I2C_SR1_=  000004     |     I2C_SR1_=  000007 
    I2C_SR2 =  005218     |     I2C_SR2_=  000002     |     I2C_SR2_=  000001 
    I2C_SR2_=  000000     |     I2C_SR2_=  000003     |     I2C_SR2_=  000005 
    I2C_SR3 =  005219     |     I2C_SR3_=  000001     |     I2C_SR3_=  000007 
    I2C_SR3_=  000004     |     I2C_SR3_=  000000     |     I2C_SR3_=  000002 
    I2C_TRIS=  00521D     |     I2C_TRIS=  000005     |     I2C_TRIS=  000005 
    I2C_TRIS=  000005     |     I2C_TRIS=  000011     |     I2C_TRIS=  000011 
    I2C_TRIS=  000011     |     I2C_WRIT=  000000     |     IL      =  000069 
    INCR    =  000001     |     INPUT_DI=  000000     |     INPUT_EI=  000001 
    INPUT_FL=  000000     |     INPUT_PU=  000001     |     INSERT  =  000086 
    INT_ADC2=  000016     |     INT_AUAR=  000012     |     INT_AWU =  000001 
    INT_CAN_=  000008     |     INT_CAN_=  000009     |     INT_CLK =  000002 
    INT_EXTI=  000003     |     INT_EXTI=  000004     |     INT_EXTI=  000005 
    INT_EXTI=  000006     |     INT_EXTI=  000007     |     INT_FLAS=  000018 
    INT_I2C =  000013     |     INT_SPI =  00000A     |     INT_TIM1=  00000C 
    INT_TIM1=  00000B     |     INT_TIM2=  00000E     |     INT_TIM2=  00000D 
    INT_TIM3=  000010     |     INT_TIM3=  00000F     |     INT_TIM4=  000017 
    INT_TLI =  000000     |     INT_UART=  000011     |     INT_UART=  000015 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 116.
Hexadecimal [24-Bits]

Symbol Table

    INT_UART=  000014     |     INT_VECT=  008060     |     INT_VECT=  00800C 
    INT_VECT=  008028     |     INT_VECT=  00802C     |     INT_VECT=  008010 
    INT_VECT=  008014     |     INT_VECT=  008018     |     INT_VECT=  00801C 
    INT_VECT=  008020     |     INT_VECT=  008024     |     INT_VECT=  008068 
    INT_VECT=  008054     |     INT_VECT=  008000     |     INT_VECT=  008030 
    INT_VECT=  008038     |     INT_VECT=  008034     |     INT_VECT=  008040 
    INT_VECT=  00803C     |     INT_VECT=  008048     |     INT_VECT=  008044 
    INT_VECT=  008064     |     INT_VECT=  008008     |     INT_VECT=  008004 
    INT_VECT=  008050     |     INT_VECT=  00804C     |     INT_VECT=  00805C 
    INT_VECT=  008058     |     ITC_SPR1=  007F70     |     ITC_SPR2=  007F71 
    ITC_SPR3=  007F72     |     ITC_SPR4=  007F73     |     ITC_SPR5=  007F74 
    ITC_SPR6=  007F75     |     ITC_SPR7=  007F76     |     ITC_SPR8=  007F77 
    ITC_SPR_=  000001     |     ITC_SPR_=  000000     |     ITC_SPR_=  000003 
    IU      =  000049     |     IWDG_KEY=  000055     |     IWDG_KEY=  0000CC 
    IWDG_KEY=  0000AA     |     IWDG_KR =  0050E0     |     IWDG_PR =  0050E1 
    IWDG_RLR=  0050E2     |     JL      =  00006A     |     JU      =  00004A 
    KBD_ACK =  0000FA     |     KBD_LED =  0000ED     |     KBD_QUEU=  000010 
    KBD_RESE=  0000FE     |     KBD_RESE=  0000FF     |     KERNEL_V=  000004 
    KEY_REL =  0000F0     |     KL      =  00006B     |     KU      =  00004B 
    KW_TYPE_=  0000F0     |     LB      =  000002     |     LBRC    =  00007B 
    LBRK    =  00005B     |     LED_BIT =  000005     |     LED_MASK=  000020 
    LED_PORT=  00500A     |     LF      =  00000A     |     LINE_DEL=  0000A0 
    LINE_PER=  000019     |     LL      =  00006C     |     LPAR    =  000028 
    LT      =  00003C     |     LU      =  00004C     |     MAJOR   =  000001 
    MAX_FREQ=  000001     |     MINOR   =  000001     |     ML      =  00006D 
    MU      =  00004D     |     NAFR    =  004804     |     NAK     =  000015 
    NCLKOPT =  004808     |     NFLASH_W=  00480E     |     NHSECNT =  00480A 
    NINE    =  000039     |     NL      =  00006E     |     NLEN_MAS=  00000F 
    NOPT1   =  004802     |     NOPT2   =  004804     |     NOPT3   =  004806 
    NOPT4   =  004808     |     NOPT5   =  00480A     |     NOPT6   =  00480C 
    NOPT7   =  00480E     |     NOPTBL  =  00487F     |     NU      =  00004E 
    NUBC    =  004802     |     NUL     =  000000     |     NWDGOPT =  004806 
    NWDGOPT_=  FFFFFFFD     |     NWDGOPT_=  FFFFFFFC     |     NWDGOPT_=  FFFFFFFF 
    NWDGOPT_=  FFFFFFFE     |   8 NonHandl   000001 R   |     OFS_UART=  000002 
    OFS_UART=  000003     |     OFS_UART=  000004     |     OFS_UART=  000005 
    OFS_UART=  000006     |     OFS_UART=  000007     |     OFS_UART=  000008 
    OFS_UART=  000009     |     OFS_UART=  000001     |     OFS_UART=  000009 
    OFS_UART=  00000A     |     OFS_UART=  000000     |     OL      =  00006F 
    ONE     =  000031     |     OPT0    =  004800     |     OPT1    =  004801 
    OPT2    =  004803     |     OPT3    =  004805     |     OPT4    =  004807 
    OPT5    =  004809     |     OPT6    =  00480B     |     OPT7    =  00480D 
    OPTBL   =  00487E     |     OPTION_B=  004800     |     OPTION_E=  00487F 
    OPTION_S=  000080     |     OU      =  00004F     |     OUTPUT_F=  000001 
    OUTPUT_O=  000000     |     OUTPUT_P=  000001     |     OUTPUT_S=  000000 
    PA      =  000000     |     PARITY_B=  000002     |     PA_BASE =  005000 
    PA_CR1  =  005003     |     PA_CR2  =  005004     |     PA_DDR  =  005002 
    PA_IDR  =  005001     |     PA_ODR  =  005000     |     PB      =  000005 
    PB_BASE =  005005     |     PB_CR1  =  005008     |     PB_CR2  =  005009 
    PB_DDR  =  005007     |     PB_IDR  =  005006     |     PB_ODR  =  005005 
    PC      =  00000A     |     PC_BASE =  00500A     |     PC_CR1  =  00500D 
    PC_CR2  =  00500E     |     PC_DDR  =  00500C     |     PC_IDR  =  00500B 
    PC_ODR  =  00500A     |     PD      =  00000F     |     PD_BASE =  00500F 
    PD_CR1  =  005012     |     PD_CR2  =  005013     |     PD_DDR  =  005011 
    PD_IDR  =  005010     |     PD_ODR  =  00500F     |     PE      =  000014 
    PE_BASE =  005014     |     PE_CR1  =  005017     |     PE_CR2  =  005018 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 117.
Hexadecimal [24-Bits]

Symbol Table

    PE_DDR  =  005016     |     PE_IDR  =  005015     |     PE_ODR  =  005014 
    PF      =  000019     |     PF_BASE =  005019     |     PF_CR1  =  00501C 
    PF_CR2  =  00501D     |     PF_DDR  =  00501B     |     PF_IDR  =  00501A 
    PF_ODR  =  005019     |     PG      =  00001E     |     PG_BASE =  00501E 
    PG_CR1  =  005021     |     PG_CR2  =  005022     |     PG_DDR  =  005020 
    PG_IDR  =  00501F     |     PG_ODR  =  00501E     |     PH      =  000023 
    PH_BASE =  005023     |     PH_CR1  =  005026     |     PH_CR2  =  005027 
    PH_DDR  =  005025     |     PH_IDR  =  005024     |     PH_ODR  =  005023 
    PH_POST_=  000003     |     PH_PRE_V=  000001     |     PH_VIDEO=  000002 
    PH_VSYNC=  000000     |     PI      =  000028     |     PIPE    =  00007C 
    PI_BASE =  005028     |     PI_CR1  =  00502B     |     PI_CR2  =  00502C 
    PI_DDR  =  00502A     |     PI_IDR  =  005029     |     PI_ODR  =  005028 
    PL      =  000070     |     PLUS    =  00002B     |     PM      =  000003 
    PN      =  000001     |     PRCNT   =  000025     |     PS2_CLK =  000000 
    PS2_CR1 =  005008     |     PS2_CR2 =  005009     |     PS2_DATA=  000001 
    PS2_DDR =  005007     |     PS2_IDR =  005006     |     PS2_ODR =  005005 
    PS2_PORT=  005005     |     PU      =  000050     |     QL      =  000071 
    QU      =  000051     |     QUST    =  00003F     |     RAM_BASE=  000000 
    RAM_END =  0017FF     |     RAM_SIZE=  001800     |     RBRC    =  00007D 
    RBRK    =  00005D     |     RCV_ACK =  000003     |     REV     =  000000 
    RL      =  000072     |     ROP     =  004800     |     RPAR    =  000029 
    RS      =  00001E     |     RST_SR  =  0050B3     |     RU      =  000052 
    RX_QUEUE=  000040     |     SC_APPS =  00002F     |     SC_BKSP =  000066 
    SC_CAPS =  000058     |     SC_DEL  =  000071     |     SC_DOWN =  000072 
    SC_END  =  000069     |     SC_ENTER=  00005A     |     SC_ESC  =  000076 
    SC_F1   =  000005     |     SC_F10  =  000009     |     SC_F11  =  000078 
    SC_F12  =  000007     |     SC_F2   =  000006     |     SC_F3   =  000004 
    SC_F4   =  00000C     |     SC_F5   =  000003     |     SC_F6   =  00000B 
    SC_F7   =  000083     |     SC_F8   =  00000A     |     SC_F9   =  000001 
    SC_HOME =  00006C     |     SC_INSER=  000070     |     SC_KP0  =  000070 
    SC_KP1  =  000069     |     SC_KP2  =  000072     |     SC_KP3  =  00007A 
    SC_KP4  =  00006B     |     SC_KP5  =  000073     |     SC_KP6  =  000074 
    SC_KP7  =  00006C     |     SC_KP8  =  000075     |     SC_KP9  =  00007D 
    SC_KPDIV=  00004A     |     SC_KPDOT=  000071     |     SC_KPENT=  00005A 
    SC_KPMIN=  00007B     |     SC_KPMUL=  00007C     |     SC_KPPLU=  000079 
    SC_LALT =  000011     |     SC_LCTRL=  000014     |     SC_LEFT =  00006B 
    SC_LGUI =  00001F     |     SC_LSHIF=  000012     |     SC_LWIND=  00001F 
    SC_MENU =  00005D     |     SC_NUM  =  000077     |   8 SC_PAUSE   0004DF R
    SC_PGDN =  00007A     |     SC_PGUP =  00007D     |   8 SC_PRN     0004D5 R
  8 SC_PRN_R   0004D9 R   |     SC_QUEUE=  000020     |     SC_RALT =  000011 
    SC_RCTRL=  000014     |     SC_RGUI =  000027     |     SC_RIGHT=  000074 
    SC_RSHIF=  000059     |     SC_RWIND=  000027     |     SC_SCROL=  00007E 
    SC_TAB  =  00000D     |     SC_UP   =  000075     |     SEMIC   =  00003B 
    SEND_BIT=  000000     |     SEND_PAR=  000001     |     SEND_STO=  000002 
    SEVEN   =  000037     |     SFR_BASE=  005000     |     SFR_END =  0057FF 
    SHARP   =  000023     |     SI      =  00000F     |     SIX     =  000036 
    SL      =  000073     |     SLASH   =  00002F     |     SO      =  00000E 
    SOH     =  000001     |     SPACE   =  000020     |     SPI_CR1 =  005200 
    SPI_CR1_=  000003     |     SPI_CR1_=  000000     |     SPI_CR1_=  000001 
    SPI_CR1_=  000007     |     SPI_CR1_=  000002     |     SPI_CR1_=  000006 
    SPI_CR2 =  005201     |     SPI_CR2_=  000007     |     SPI_CR2_=  000006 
    SPI_CR2_=  000005     |     SPI_CR2_=  000004     |     SPI_CR2_=  000002 
    SPI_CR2_=  000000     |     SPI_CR2_=  000001     |     SPI_CRCP=  005205 
    SPI_DR  =  005204     |     SPI_ICR =  005202     |     SPI_RXCR=  005206 
    SPI_SR  =  005203     |     SPI_SR_B=  000007     |     SPI_SR_C=  000004 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 118.
Hexadecimal [24-Bits]

Symbol Table

    SPI_SR_M=  000005     |     SPI_SR_O=  000006     |     SPI_SR_R=  000000 
    SPI_SR_T=  000001     |     SPI_SR_W=  000003     |     SPI_TXCR=  005207 
    STACK_EM=  0017FF     |     STACK_SI=  000080     |     STAR    =  00002A 
    STOP_BIT=  000003     |     STX     =  000002     |     SU      =  000053 
    SUB     =  00001A     |     SWIM_CSR=  007F80     |     SYN     =  000016 
    TAB     =  000009     |     TAB_WIDT=  000004     |     THREE   =  000033 
    TICK    =  000027     |     TILD    =  00007E     |     TIM1_ARR=  005262 
    TIM1_ARR=  005263     |     TIM1_BKR=  00526D     |     TIM1_CCE=  00525C 
    TIM1_CCE=  00525D     |     TIM1_CCM=  005258     |     TIM1_CCM=  000000 
    TIM1_CCM=  000001     |     TIM1_CCM=  000004     |     TIM1_CCM=  000005 
    TIM1_CCM=  000006     |     TIM1_CCM=  000007     |     TIM1_CCM=  000002 
    TIM1_CCM=  000003     |     TIM1_CCM=  000007     |     TIM1_CCM=  000002 
    TIM1_CCM=  000004     |     TIM1_CCM=  000005     |     TIM1_CCM=  000006 
    TIM1_CCM=  000003     |     TIM1_CCM=  000004     |     TIM1_CCM=  005259 
    TIM1_CCM=  000000     |     TIM1_CCM=  000001     |     TIM1_CCM=  000004 
    TIM1_CCM=  000005     |     TIM1_CCM=  000006     |     TIM1_CCM=  000007 
    TIM1_CCM=  000002     |     TIM1_CCM=  000003     |     TIM1_CCM=  000007 
    TIM1_CCM=  000002     |     TIM1_CCM=  000004     |     TIM1_CCM=  000005 
    TIM1_CCM=  000006     |     TIM1_CCM=  000003     |     TIM1_CCM=  000004 
    TIM1_CCM=  00525A     |     TIM1_CCM=  000000     |     TIM1_CCM=  000001 
    TIM1_CCM=  000004     |     TIM1_CCM=  000005     |     TIM1_CCM=  000006 
    TIM1_CCM=  000007     |     TIM1_CCM=  000002     |     TIM1_CCM=  000003 
    TIM1_CCM=  000007     |     TIM1_CCM=  000002     |     TIM1_CCM=  000004 
    TIM1_CCM=  000005     |     TIM1_CCM=  000006     |     TIM1_CCM=  000003 
    TIM1_CCM=  000004     |     TIM1_CCM=  00525B     |     TIM1_CCM=  000000 
    TIM1_CCM=  000001     |     TIM1_CCM=  000004     |     TIM1_CCM=  000005 
    TIM1_CCM=  000006     |     TIM1_CCM=  000007     |     TIM1_CCM=  000002 
    TIM1_CCM=  000003     |     TIM1_CCM=  000007     |     TIM1_CCM=  000002 
    TIM1_CCM=  000004     |     TIM1_CCM=  000005     |     TIM1_CCM=  000006 
    TIM1_CCM=  000003     |     TIM1_CCM=  000004     |     TIM1_CCR=  005265 
    TIM1_CCR=  005266     |     TIM1_CCR=  005267     |     TIM1_CCR=  005268 
    TIM1_CCR=  005269     |     TIM1_CCR=  00526A     |     TIM1_CCR=  00526B 
    TIM1_CCR=  00526C     |     TIM1_CNT=  00525E     |     TIM1_CNT=  00525F 
    TIM1_CR1=  005250     |     TIM1_CR1=  000007     |     TIM1_CR1=  000000 
    TIM1_CR1=  000006     |     TIM1_CR1=  000005     |     TIM1_CR1=  000004 
    TIM1_CR1=  000003     |     TIM1_CR1=  000001     |     TIM1_CR1=  000002 
    TIM1_CR2=  005251     |     TIM1_CR2=  000000     |     TIM1_CR2=  000002 
    TIM1_CR2=  000004     |     TIM1_CR2=  000005     |     TIM1_CR2=  000006 
    TIM1_DTR=  00526E     |     TIM1_EGR=  005257     |     TIM1_EGR=  000007 
    TIM1_EGR=  000001     |     TIM1_EGR=  000002     |     TIM1_EGR=  000003 
    TIM1_EGR=  000004     |     TIM1_EGR=  000005     |     TIM1_EGR=  000006 
    TIM1_EGR=  000000     |     TIM1_ETR=  005253     |     TIM1_ETR=  000006 
    TIM1_ETR=  000000     |     TIM1_ETR=  000001     |     TIM1_ETR=  000002 
    TIM1_ETR=  000003     |     TIM1_ETR=  000007     |     TIM1_ETR=  000004 
    TIM1_ETR=  000005     |     TIM1_IER=  005254     |     TIM1_IER=  000007 
    TIM1_IER=  000001     |     TIM1_IER=  000002     |     TIM1_IER=  000003 
    TIM1_IER=  000004     |     TIM1_IER=  000005     |     TIM1_IER=  000006 
    TIM1_IER=  000000     |     TIM1_OIS=  00526F     |     TIM1_PSC=  005260 
    TIM1_PSC=  005261     |     TIM1_RCR=  005264     |     TIM1_SMC=  005252 
    TIM1_SMC=  000007     |     TIM1_SMC=  000000     |     TIM1_SMC=  000001 
    TIM1_SMC=  000002     |     TIM1_SMC=  000004     |     TIM1_SMC=  000005 
    TIM1_SMC=  000006     |     TIM1_SR1=  005255     |     TIM1_SR1=  000007 
    TIM1_SR1=  000001     |     TIM1_SR1=  000002     |     TIM1_SR1=  000003 
    TIM1_SR1=  000004     |     TIM1_SR1=  000005     |     TIM1_SR1=  000006 
    TIM1_SR1=  000000     |     TIM1_SR2=  005256     |     TIM1_SR2=  000001 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 119.
Hexadecimal [24-Bits]

Symbol Table

    TIM1_SR2=  000002     |     TIM1_SR2=  000003     |     TIM1_SR2=  000004 
    TIM2_ARR=  00530D     |     TIM2_ARR=  00530E     |     TIM2_CCE=  005308 
    TIM2_CCE=  000000     |     TIM2_CCE=  000001     |     TIM2_CCE=  000004 
    TIM2_CCE=  000005     |     TIM2_CCE=  005309     |     TIM2_CCM=  005305 
    TIM2_CCM=  005306     |     TIM2_CCM=  005307     |     TIM2_CCM=  000000 
    TIM2_CCM=  000004     |     TIM2_CCM=  000003     |     TIM2_CCR=  00530F 
    TIM2_CCR=  005310     |     TIM2_CCR=  005311     |     TIM2_CCR=  005312 
    TIM2_CCR=  005313     |     TIM2_CCR=  005314     |     TIM2_CNT=  00530A 
    TIM2_CNT=  00530B     |     TIM2_CR1=  005300     |     TIM2_CR1=  000007 
    TIM2_CR1=  000000     |     TIM2_CR1=  000003     |     TIM2_CR1=  000001 
    TIM2_CR1=  000002     |     TIM2_EGR=  005304     |     TIM2_EGR=  000001 
    TIM2_EGR=  000002     |     TIM2_EGR=  000003     |     TIM2_EGR=  000006 
    TIM2_EGR=  000000     |     TIM2_IER=  005301     |     TIM2_PSC=  00530C 
    TIM2_SR1=  005302     |     TIM2_SR2=  005303     |     TIM3_ARR=  00532B 
    TIM3_ARR=  00532C     |     TIM3_CCE=  005327     |     TIM3_CCE=  000000 
    TIM3_CCE=  000001     |     TIM3_CCE=  000004     |     TIM3_CCE=  000005 
    TIM3_CCE=  000000     |     TIM3_CCE=  000001     |     TIM3_CCM=  005325 
    TIM3_CCM=  005326     |     TIM3_CCM=  000000     |     TIM3_CCM=  000004 
    TIM3_CCM=  000003     |     TIM3_CCR=  00532D     |     TIM3_CCR=  00532E 
    TIM3_CCR=  00532F     |     TIM3_CCR=  005330     |     TIM3_CNT=  005328 
    TIM3_CNT=  005329     |     TIM3_CR1=  005320     |     TIM3_CR1=  000007 
    TIM3_CR1=  000000     |     TIM3_CR1=  000003     |     TIM3_CR1=  000001 
    TIM3_CR1=  000002     |     TIM3_EGR=  005324     |     TIM3_IER=  005321 
    TIM3_PSC=  00532A     |     TIM3_SR1=  005322     |     TIM3_SR2=  005323 
    TIM4_ARR=  005346     |     TIM4_CNT=  005344     |     TIM4_CR1=  005340 
    TIM4_CR1=  000007     |     TIM4_CR1=  000000     |     TIM4_CR1=  000003 
    TIM4_CR1=  000001     |     TIM4_CR1=  000002     |     TIM4_EGR=  005343 
    TIM4_EGR=  000000     |     TIM4_IER=  005341     |     TIM4_IER=  000000 
    TIM4_PSC=  005345     |     TIM4_PSC=  000000     |     TIM4_PSC=  000007 
    TIM4_PSC=  000004     |     TIM4_PSC=  000001     |     TIM4_PSC=  000005 
    TIM4_PSC=  000002     |     TIM4_PSC=  000006     |     TIM4_PSC=  000003 
    TIM4_PSC=  000000     |     TIM4_PSC=  000001     |     TIM4_PSC=  000002 
    TIM4_SR =  005342     |     TIM4_SR_=  000000     |     TL      =  000074 
    TU      =  000054     |     TWO     =  000032     |     UART    =  000002 
    UART1   =  000000     |     UART1_BA=  005230     |     UART1_BR=  005232 
    UART1_BR=  005233     |     UART1_CR=  005234     |     UART1_CR=  005235 
    UART1_CR=  005236     |     UART1_CR=  005237     |     UART1_CR=  005238 
    UART1_DR=  005231     |     UART1_GT=  005239     |     UART1_PO=  000000 
    UART1_PS=  00523A     |     UART1_RX=  000004     |     UART1_SR=  005230 
    UART1_TX=  000005     |     UART2   =  000001     |     UART3   =  000002 
    UART3_BA=  005240     |     UART3_BR=  005242     |     UART3_BR=  005243 
    UART3_CR=  005244     |     UART3_CR=  005245     |     UART3_CR=  005246 
    UART3_CR=  005247     |     UART3_CR=  005249     |     UART3_DR=  005241 
    UART3_PO=  00000F     |     UART3_RX=  000006     |     UART3_SR=  005240 
    UART3_TX=  000005     |     UART_BRR=  005242     |     UART_BRR=  005243 
    UART_CR1=  005244     |     UART_CR1=  000004     |     UART_CR1=  000002 
    UART_CR1=  000000     |     UART_CR1=  000001     |     UART_CR1=  000007 
    UART_CR1=  000006     |     UART_CR1=  000005     |     UART_CR1=  000003 
    UART_CR2=  005245     |     UART_CR2=  000004     |     UART_CR2=  000002 
    UART_CR2=  000005     |     UART_CR2=  000001     |     UART_CR2=  000000 
    UART_CR2=  000006     |     UART_CR2=  000003     |     UART_CR2=  000007 
    UART_CR3=  000003     |     UART_CR3=  000001     |     UART_CR3=  000002 
    UART_CR3=  000000     |     UART_CR3=  000006     |     UART_CR3=  000004 
    UART_CR3=  000005     |     UART_CR4=  000000     |     UART_CR4=  000001 
    UART_CR4=  000002     |     UART_CR4=  000003     |     UART_CR4=  000004 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 120.
Hexadecimal [24-Bits]

Symbol Table

    UART_CR4=  000006     |     UART_CR4=  000005     |     UART_CR5=  000003 
    UART_CR5=  000001     |     UART_CR5=  000002     |     UART_CR5=  000004 
    UART_CR5=  000005     |     UART_CR6=  000004     |     UART_CR6=  000007 
    UART_CR6=  000001     |     UART_CR6=  000002     |     UART_CR6=  000000 
    UART_CR6=  000005     |     UART_DR =  005241     |     UART_PCK=  000003 
    UART_POR=  00500D     |     UART_POR=  00500E     |     UART_POR=  00500C 
    UART_POR=  00500B     |     UART_POR=  00500A     |     UART_RX_=  000006 
    UART_SR =  005240     |     UART_SR_=  000001     |     UART_SR_=  000004 
    UART_SR_=  000002     |     UART_SR_=  000003     |     UART_SR_=  000000 
    UART_SR_=  000005     |     UART_SR_=  000006     |     UART_SR_=  000007 
    UART_TX_=  000005     |     UBC     =  004801     |     UL      =  000075 
    UNDERLIN=  000085     |     UNDR    =  00005F     |     US      =  00001F 
    UU      =  000055     |   8 UartRxHa   000D3C R   |     VIDEO_LI=  0000C8 
    VISIBLE_=  0000C8     |     VK_APPS =  000097     |     VK_BACK =  000008 
    VK_CAPS =  0000A8     |     VK_CBACK=  0000BA     |     VK_CDEL =  0000B9 
    VK_CDOWN=  0000B2     |     VK_CEND =  0000B6     |     VK_CHOME=  0000B5 
    VK_CLEFT=  0000B3     |     VK_CLOCK=  00009B     |     VK_CPGDN=  0000B8 
    VK_CPGUP=  0000B7     |     VK_CRIGH=  0000B4     |     VK_CUP  =  0000B1 
    VK_DELET=  00007F     |     VK_DOWN =  00008E     |     VK_END  =  000092 
    VK_ENTER=  00000D     |     VK_ESC  =  00001B     |     VK_F1   =  000080 
    VK_F10  =  00008A     |     VK_F11  =  00008B     |     VK_F12  =  00008C 
    VK_F2   =  000081     |     VK_F3   =  000082     |     VK_F4   =  000083 
    VK_F5   =  000084     |     VK_F6   =  000085     |     VK_F7   =  000086 
    VK_F8   =  000087     |     VK_F9   =  000088     |     VK_HOME =  000091 
    VK_INSER=  000095     |     VK_LALT =  00009E     |     VK_LCTRL=  00009D 
    VK_LEFT =  00008F     |     VK_LGUI =  0000A0     |     VK_LSHIF=  00009C 
    VK_LWIND=  0000BB     |     VK_MENU =  0000BD     |     VK_NLOCK=  00009A 
    VK_NUM  =  0000A5     |     VK_PAUSE=  000099     |     VK_PGDN =  000094 
    VK_PGUP =  000093     |     VK_PRN  =  000098     |     VK_RALT =  0000A3 
    VK_RCTRL=  0000A1     |     VK_RGUI =  0000A2     |     VK_RIGHT=  000090 
    VK_RSHIF=  00009F     |     VK_RWIND=  0000BC     |     VK_SCROL=  0000A4 
    VK_SDEL =  0000BF     |     VK_SDOWN=  0000AA     |     VK_SEND =  0000AE 
    VK_SHOME=  0000AD     |     VK_SLEEP=  0000BE     |     VK_SLEFT=  0000AB 
    VK_SPACE=  000020     |     VK_SPGDN=  0000B0     |     VK_SPGUP=  0000AF 
    VK_SRIGH=  0000AC     |     VK_SUP  =  0000A9     |     VK_TAB  =  000009 
    VK_UP   =  00008D     |     VL      =  000076     |     VPULSE  =  000222 
    VSIZE   =  000004     |     VT      =  00000B     |     VU      =  000056 
    WAIT_STA=  000000     |     WDGOPT  =  004805     |     WDGOPT_I=  000002 
    WDGOPT_L=  000003     |     WDGOPT_W=  000000     |     WDGOPT_W=  000001 
    WL      =  000077     |     WU      =  000057     |     WWDG_CR =  0050D1 
    WWDG_WR =  0050D2     |     XL      =  000078     |     XOFF    =  000013 
    XON     =  000011     |     XT2_KEY =  0000E1     |     XT_KEY  =  0000E0 
    XU      =  000058     |     YL      =  000079     |     YU      =  000059 
    ZERO    =  000030     |     ZL      =  00007A     |     ZU      =  00005A 
  5 acc16      000004 GR  |   5 acc8       000005 GR  |   8 altchar_   000604 R
  8 baud_rat   000D54 R   |   5 char_cur   000050 R   |   5 char_und   00004F R
  8 clock_in   000058 R   |   8 cold_sta   00006E R   |   8 control_   000613 R
  8 copy_fon   0006C7 R   |   8 cursor_b   00114A R   |   5 cursor_d   00004E R
  5 cursor_x   00004C R   |   5 cursor_y   00004D R   |   5 dev_id     000095 R
  8 fetch_sc   0003A0 R   |   5 flags      000008 GR  |   8 font_6x8   000E12 R
  5 font_add   00004A R   |   8 font_cha   0011DF R   |   8 font_end   00114A R
  8 get_char   0011EA R   |   8 get_para   001465 R   |   8 getc       000DB2 GR
  8 hex_digi   000E07 R   |   8 if_alt_d   00046B R   |   8 if_ctrl_   000450 R
  8 if_shift   000429 R   |   5 in_byte    00002B R   |   8 is_alnum   000225 GR
  8 is_alpha   0001FD GR  |   8 is_digit   00020E GR  |   8 is_hex_d   000217 GR
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 121.
Hexadecimal [24-Bits]

Symbol Table

  8 jitter_c   0007B4 R   |   5 kbd_queu   000033 R   |   5 kbd_queu   000043 R
  5 kbd_queu   000044 R   |   5 kbd_stat   000045 R   |   8 keyboard   0004CC R
  8 main       001496 R   |   8 move       0001AE GR  |   8 move_dow   0001CE R
  8 move_exi   0001ED R   |   8 move_loo   0001D3 R   |   8 move_up    0001C0 R
    n       =  000096     |   8 no_ws      000015 R   |   5 ntsc_fla   000046 R
  8 ntsc_ini   000628 R   |   5 ntsc_pha   000047 R   |   8 ntsc_syn   0006DF R
  8 ntsc_vid   000792 R   |   8 opt_done   000034 R   |   5 out_byte   00002F R
  5 parity     00002C R   |   8 post_vid   00076E R   |   8 process_   001414 R
  8 process_   0012EB R   |   8 prog_opt   00001C R   |   8 ps2_init   00022E R
  8 ps2_intr   000259 R   |   5 ptr16      000006 GR  |   5 ptr8       000007 R
  8 qgetc      000DAC GR  |   8 reset_kb   00036E R   |   5 rx1_head   000093 R
  5 rx1_queu   000053 R   |   5 rx1_tail   000094 R   |   8 rx_data_   000284 R
  8 rx_parit   000294 R   |   8 rx_start   000272 R   |   8 rx_stop_   00029E R
  5 saved_cx   000051 R   |   5 saved_cy   000052 R   |   5 sc_qhead   000029 R
  5 sc_qtail   00002A R   |   5 sc_queue   000009 R   |   8 sc_rx_er   00026B R
  5 sc_rx_fl   00002D R   |   5 sc_rx_ph   00002E R   |   5 scan_lin   000048 R
  8 send_par   0013FB R   |   8 send_to_   0002AE R   |   8 set_curs   0011F9 R
  8 set_curs   001205 R   |   8 set_kbd_   00034B R   |   8 set_ws     00000B R
  8 shifted_   0005C7 R   |   2 stack_fu   001780 GR  |   2 stack_un   001800 R
  8 state_fl   0003C2 R   |   8 std_code   0004E7 R   |   8 store_sc   000374 R
  8 strcmp     00018F GR  |   8 strcpy     00019E GR  |   8 strlen     000184 GR
  8 sync_exi   00078F R   |   8 table_lo   00047B R   |   8 test       0000DC R
  8 test_pre   00074B R   |   8 to_upper   0001F2 R   |   8 translat   000493 R
  8 tv_clear   001261 R   |   8 tv_cls     00118E R   |   8 tv_curso   001211 R
  8 tv_curso   001228 R   |   8 tv_delba   001295 R   |   8 tv_disab   00116E R
  8 tv_enabl   00117E R   |   8 tv_new_l   001283 R   |   8 tv_print   0012A5 R
  8 tv_print   00144A R   |   8 tv_put_c   0011D0 R   |   8 tv_puts    001489 R
  8 tv_scrol   001236 R   |   5 tx_bit_c   000030 R   |   5 tx_parit   000032 R
  5 tx_phase   000031 R   |   8 uart_cls   000D99 R   |   8 uart_del   000D89 R
  8 uart_get   000DB2 GR  |   8 uart_ini   000D5C R   |   8 uart_pri   000DCB R
  8 uart_pri   000DE5 R   |   8 uart_pri   000DF7 R   |   8 uart_put   000D80 GR
  8 uart_put   000DD8 R   |   8 uart_qge   000DAC GR  |   8 uart_spa   000DA6 R
  8 unlock_e   000035 R   |   6 user_fon   000100 R   |   7 video_bu   0008DA R
  8 video_on   0006A6 R   |   8 wait_ack   000341 R   |   8 wait_nex   0003BC R
  8 wait_sta   000005 R   |   8 width      000135 R   |   8 xt_codes   00059A R

ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 122.
Hexadecimal [24-Bits]

Area Table

   0 _CODE      size      0   flags    0
   1 SSEG       size      0   flags    8
   2 SSEG0      size     80   flags    8
   3 HOME       size     80   flags    0
   4 DATA       size      0   flags    8
   5 DATA1      size     92   flags    8
   6 DATA2      size      0   flags    8
   7 DATA3      size    EA6   flags    8
   8 CODE       size   14B5   flags    0

