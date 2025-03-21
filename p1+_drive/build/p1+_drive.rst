ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 1.
Hexadecimal [24-Bits]



                                      1 ;;
                                      2 ; Copyright Jacques Deschênes 2025  
                                      3 ; This file is part of p1+_drive 
                                      4 ;
                                      5 ;     p1+_drive is free software: you can redistribute it and/or modify
                                      6 ;     it under the terms of the GNU General Public License as published by
                                      7 ;     the Free Software Foundation, either version 3 of the License, or
                                      8 ;     (at your option) any later version.
                                      9 ;
                                     10 ;     p1+_drive is distributed in the hope that it will be useful,
                                     11 ;     but WITHOUT ANY WARRANTY; without even the implied warranty of
                                     12 ;     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
                                     13 ;     GNU General Public License for more details.
                                     14 ;
                                     15 ;     You should have received a copy of the GNU General Public License
                                     16 ;     along with p1+_drive.  If not, see <http://www.gnu.org/licenses/>.
                                     17 ;;
                                     18 
                                     19 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                                     20 ;;; hardware initialization
                                     21 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 
                                     22 
                                     23     .module HW_INIT 
                                     24 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 2.
Hexadecimal [24-Bits]



                                     25     .include "config.inc"
                                      1 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                                      2 ;;  configuration parameters 
                                      3 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                                      4 
                                      5 ;     MCU STM88S207K8T 
                                      6 
                           000000     7 DEBUG=0 ; set to 1 to include debugging code 
                                      8 
                                      9 ; version 
                           000001    10     MAJOR=1 
                           000000    11     MINOR=0 
                           000000    12     REV=0
                                     13     
                           000010    14 FMSTR=16 ; MHZ
                                     15 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 3.
Hexadecimal [24-Bits]



                                     16     .include "inc/stm8s207.inc" 
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



                                     17     .include "inc/nucleo_8s207.inc"
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



                                     18 	.include "inc/ascii.inc"
                                      1 ;;
                                      2 ; Copyright Jacques Deschênes 2021
                                      3 ; This file is part of stm32-tbi 
                                      4 ;
                                      5 ;     stm32-tbi is free software: you can redistribute it and/or modify
                                      6 ;     it under the terms of the GNU General Public License as published by
                                      7 ;     the Free Software Foundation, either version 3 of the License, or
                                      8 ;     (at your option) any later version.
                                      9 ;
                                     10 ;     stm32-tbi is distributed in the hope that it will be useful,
                                     11 ;     but WITHOUT ANY WARRANTY; without even the implied warranty of
                                     12 ;     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
                                     13 ;     GNU General Public License for more details.
                                     14 ;
                                     15 ;     You should have received a copy of the GNU General Public License
                                     16 ;     along with stm32-tbi.  If not, see <http:;www.gnu.org/licenses/>.
                                     17 ;;
                                     18 
                                     19 ;-------------------------------------------------------
                                     20 ;     ASCII control  values
                                     21 ;     CTRL_x   are VT100 keyboard values  
                                     22 ; REF: https:;en.wikipedia.org/wiki/ASCII    
                                     23 ;-------------------------------------------------------
                           000001    24 	 CTRL_A = 1
                           000001    25 	 SOH=CTRL_A  ; start of heading 
                           000002    26 	 CTRL_B = 2
                           000002    27 	 STRX = CTRL_B  ; start of text 
                           000003    28 	 CTRL_C = 3
                           000003    29 	 ETX=CTRL_C  ; end of text 
                           000004    30 	 CTRL_D = 4
                           000004    31 	 EOT=CTRL_D  ; end of transmission 
                           000005    32 	 CTRL_E = 5
                           000005    33 	 ENQ=CTRL_E  ; enquery 
                           000006    34 	 CTRL_F = 6
                           000006    35 	 ACK=CTRL_F  ; acknowledge
                           000007    36 	 CTRL_G = 7
                           000007    37 	 BELL = 7    ; vt100 terminal generate a sound.
                           000008    38 	 CTRL_H = 8  
                           000008    39 	 BS = 8     ; back space 
                           000009    40 	 CTRL_I = 9
                           000009    41 	 TAB = 9     ; horizontal tabulation
                           00000A    42 	 CTRL_J = 10 
                           00000A    43 	 LF = 10     ; line feed
                           00000B    44 	 CTRL_K = 11
                           00000B    45 	 VT = 11     ; vertical tabulation 
                           00000C    46 	 CTRL_L = 12
                           00000C    47 	 FF = 12      ; new page
                           00000D    48 	 CTRL_M = 13
                           00000D    49 	 CR = 13      ; carriage return 
                           00000E    50 	 CTRL_N = 14
                           00000E    51 	 SO=CTRL_N    ; shift out 
                           00000F    52 	 CTRL_O = 15
                           00000F    53 	 SI=CTRL_O    ; shift in 
                           000010    54 	 CTRL_P = 16
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 27.
Hexadecimal [24-Bits]



                           000010    55 	 DLE=CTRL_P   ; data link escape 
                           000011    56 	 CTRL_Q = 17
                           000011    57 	 DC1=CTRL_Q   ; device control 1 
                           000011    58 	 XON=DC1 
                           000012    59 	 CTRL_R = 18
                           000012    60 	 DC2=CTRL_R   ; device control 2 
                           000013    61 	 CTRL_S = 19
                           000013    62 	 DC3=CTRL_S   ; device control 3
                           000013    63 	 XOFF=DC3 
                           000014    64 	 CTRL_T = 20
                           000014    65 	 DC4=CTRL_T   ; device control 4 
                           000015    66 	 CTRL_U = 21
                           000015    67 	 NAK=CTRL_U   ; negative acknowledge
                           000016    68 	 CTRL_V = 22
                           000016    69 	 SYN=CTRL_V   ; synchronous idle 
                           000017    70 	 CTRL_W = 23
                           000017    71 	 ETB=CTRL_W   ; end of transmission block
                           000018    72 	 CTRL_X = 24
                           000018    73 	 CAN=CTRL_X   ; cancel 
                           000019    74 	 CTRL_Y = 25
                           000019    75 	 EM=CTRL_Y    ; end of medium
                           00001A    76 	 CTRL_Z = 26
                           00001A    77 	 SUB=CTRL_Z   ; substitute 
                           00001A    78 	 EOF=SUB      ; end of text file in MSDOS 
                           00001B    79 	 ESC = 27     ; escape 
                           00001C    80 	 FS=28        ; file separator 
                           00001D    81 	 GS=29        ; group separator 
                           00001E    82 	 RS=30  ; record separator 
                           00001F    83 	 US=31  ; unit separator 
                           000020    84 	 SPACE = 32
                           00002C    85 	 COMMA = 44 
                           000023    86 	 SHARP = 35
                           000027    87 	 TICK = 39
                                     88 ;	 DOT = $2E
                                     89 ;	 COLUMN = $3A
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 28.
Hexadecimal [24-Bits]



                                     19 	.include "inc/gen_macros.inc" 
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
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 29.
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
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 30.
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
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 31.
Hexadecimal [24-Bits]



                                     20 	.include "app_macros.inc" 
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
                                     22 
                                     23 
                           000080    24 	STACK_SIZE=128
                           0017FF    25 	STACK_EMPTY=RAM_SIZE-1  
                                     26 	
                                     27 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 32.
Hexadecimal [24-Bits]



                                     21 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 33.
Hexadecimal [24-Bits]



                                     26 
                           000080    27 STACK_SIZE=128   
                                     28 ;;-----------------------------------
                                     29     .area SSEG (ABS)
                                     30 ;; working buffers and stack at end of RAM. 	
                                     31 ;;-----------------------------------
      001780                         32     .org RAM_SIZE-STACK_SIZE
      001780                         33 stack_full:: .ds STACK_SIZE   ; control stack full 
      001800                         34 stack_unf: ; stack underflow ; RAM end +1 -> 0x1800
                                     35 
                                     36 
                                     37 ;;--------------------------------------
                                     38     .area HOME 
                                     39 ;; interrupt vector table at 0x8000
                                     40 ;;--------------------------------------
                                     41 
      008000 82 00 80 9A             42     int cold_start			; RESET vector 
      008004 82 00 80 80             43 	int NonHandledInterrupt ; trap instruction 
      008008 82 00 80 80             44 	int NonHandledInterrupt ;int0 TLI   external top level interrupt
      00800C 82 00 80 80             45 	int NonHandledInterrupt ;int1 AWU   auto wake up from halt
      008010 82 00 80 80             46 	int NonHandledInterrupt ;int2 CLK   clock controller
      008014 82 00 80 80             47 	int NonHandledInterrupt ;int3 EXTI0 gpio A external interrupts
      008018 82 00 80 80             48 	int NonHandledInterrupt    ;int4 EXTI1 gpio B external interrupts
      00801C 82 00 80 80             49 	int NonHandledInterrupt ;int5 EXTI2 gpio C external interrupts
      008020 82 00 80 80             50 	int NonHandledInterrupt ;int6 EXTI3 gpio D external interrupts
      008024 82 00 80 80             51 	int NonHandledInterrupt ;int7 EXTI4 gpio E external interrupts
      008028 82 00 80 80             52 	int NonHandledInterrupt ;int8 beCAN RX interrupt
      00802C 82 00 80 80             53 	int NonHandledInterrupt ;int9 beCAN TX/ER/SC interrupt
      008030 82 00 80 80             54 	int NonHandledInterrupt ;int10 SPI End of transfer
      008034 82 00 80 80             55 	int NonHandledInterrupt ;int11 TIM1 update/overflow/underflow/trigger/break
      008038 82 00 80 80             56 	int NonHandledInterrupt ; int12 TIM1 capture/compare
      00803C 82 00 80 80             57 	int NonHandledInterrupt ;int13 TIM2 update /overflow
      008040 82 00 80 80             58 	int NonHandledInterrupt ;int14 TIM2 capture/compare
      008044 82 00 80 80             59 	int NonHandledInterrupt ;int15 TIM3 Update/overflow
      008048 82 00 80 80             60 	int NonHandledInterrupt ;int16 TIM3 Capture/compare
      00804C 82 00 80 80             61 	int NonHandledInterrupt ;int17 UART1 TX completed
      008050 82 00 80 80             62 	int NonHandledInterrupt ;int18 UART1 RX full 
      008054 82 00 80 80             63 	int NonHandledInterrupt ;int19 I2C 
      008058 82 00 80 80             64 	int NonHandledInterrupt ;int20 UART3 TX completed
      00805C 82 00 81 E4             65 	int UartRxHandler 		;int21 UART3 RX full
      008060 82 00 80 80             66 	int NonHandledInterrupt ;int22 ADC2 end of conversion
      008064 82 00 80 80             67 	int NonHandledInterrupt	;int23 TIM4 update/overflow ; use to blink tv cursor 
      008068 82 00 80 80             68 	int NonHandledInterrupt ;int24 flash writing EOP/WR_PG_DIS
      00806C 82 00 80 80             69 	int NonHandledInterrupt ;int25  not used
      008070 82 00 80 80             70 	int NonHandledInterrupt ;int26  not used
      008074 82 00 80 80             71 	int NonHandledInterrupt ;int27  not used
      008078 82 00 80 80             72 	int NonHandledInterrupt ;int28  not used
      00807C 82 00 80 80             73 	int NonHandledInterrupt ;int29  not used
                                     74 
                                     75 
                           000004    76 KERNEL_VAR_ORG=4
                                     77 ;--------------------------------------
                                     78     .area DATA (ABS)
      000004                         79 	.org KERNEL_VAR_ORG 
                                     80 ;--------------------------------------	
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 34.
Hexadecimal [24-Bits]



                                     81 
                                     82 ; keep the following 3 variables in this order 
      000004                         83 acc16:: .blkb 1 ; 16 bits accumulator, acc24 high-byte
      000005                         84 acc8::  .blkb 1 ;  8 bits accumulator, acc24 low-byte  
      000006                         85 ptr16::  .blkb 1 ; 16 bits pointer , farptr high-byte 
      000007                         86 ptr8:   .blkb 1 ; 8 bits pointer, farptr low-byte  
      000008                         87 flags:: .blkb 1 ; various boolean flags
                                     88 
                                     89 
                                     90 ; uart variable 
                           000040    91 RX_QUEUE_SIZE=64
      000009                         92 rx1_queue: .ds RX_QUEUE_SIZE ; UART1 receive circular queue 
      000049                         93 rx1_head:  .blkb 1 ; rx1_queue head pointer
      00004A                         94 rx1_tail:   .blkb 1 ; rx1_queue tail pointer  
                                     95 
                                     96 
                                     97 	.area CODE 
                                     98 
                                     99 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                                    100 ; non handled interrupt 
                                    101 ; reset MCU
                                    102 ;;;;;;;;;;;;;;;;;;;;;;;;;;;
      008080                        103 NonHandledInterrupt:
      000000                        104 	_swreset ; see "inc/gen_macros.inc"
      008080 35 80 50 D1      [ 1]    1     mov WWDG_CR,#0X80
                                    105 
                                    106 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                                    107 ;    peripherals initialization
                                    108 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                                    109 
                                    110 ;----------------------------------------
                                    111 ; inialize MCU clock 
                                    112 ; input:
                                    113 ;   A      CLK_CKDIVR , clock divisor
                                    114 ;   XL     HSI|HSE   
                                    115 ; output:
                                    116 ;   none 
                                    117 ;----------------------------------------
      008084                        118 clock_init:	
                                    119 ; cpu clock divisor 
      008084 88               [ 1]  120 	push a   
      008085 9F               [ 1]  121 	ld a,xl ; clock source CLK_SWR_HSI|CLK_SWR_HSE 
      008086 72 17 50 C5      [ 1]  122 	bres CLK_SWCR,#CLK_SWCR_SWIF 
      00808A C1 50 C3         [ 1]  123 	cp a,CLK_CMSR 
      00808D 27 07            [ 1]  124 	jreq 2$ ; no switching required 
                                    125 ; select clock source 
      00808F 72 12 50 C5      [ 1]  126 	bset CLK_SWCR,#CLK_SWCR_SWEN
      008093 C7 50 C4         [ 1]  127 	ld CLK_SWR,a
      008096                        128 2$: 
      008096 32 50 C6         [ 1]  129 	pop CLK_CKDIVR   	
      008099 81               [ 4]  130 	ret
                                    131 
                           000000   132 .if 0	
                                    133 ;--------------------------
                                    134 ; set software interrupt 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 35.
Hexadecimal [24-Bits]



                                    135 ; priority 
                                    136 ; input:
                                    137 ;   A    priority 1,2,3 
                                    138 ;   X    vector 
                                    139 ;---------------------------
                                    140 	SPR_ADDR=1 
                                    141 	PRIORITY=3
                                    142 	SLOT=4
                                    143 	MASKED=5  
                                    144 	VSIZE=5
                                    145 set_int_priority::
                                    146 	_vars VSIZE
                                    147 	and a,#3  
                                    148 	ld (PRIORITY,sp),a 
                                    149 	ld a,#4 
                                    150 	div x,a 
                                    151 	sll a  ; slot*2 
                                    152 	ld (SLOT,sp),a
                                    153 	addw x,#ITC_SPR1 
                                    154 	ldw (SPR_ADDR,sp),x 
                                    155 ; build mask
                                    156 	ldw x,#0xfffc 	
                                    157 	ld a,(SLOT,sp)
                                    158 	jreq 2$ 
                                    159 	scf 
                                    160 1$:	rlcw x 
                                    161 	dec a 
                                    162 	jrne 1$
                                    163 2$:	ld a,xl 
                                    164 ; apply mask to slot 
                                    165 	ldw x,(SPR_ADDR,sp)
                                    166 	and a,(x)
                                    167 	ld (MASKED,sp),a 
                                    168 ; shift priority to slot 
                                    169 	ld a,(PRIORITY,sp)
                                    170 	ld xl,a 
                                    171 	ld a,(SLOT,sp)
                                    172 	jreq 4$
                                    173 3$:	sllw x 
                                    174 	dec a 
                                    175 	jrne 3$
                                    176 4$:	ld a,xl 
                                    177 	or a,(MASKED,sp)
                                    178 	ldw x,(SPR_ADDR,sp)
                                    179 	ld (x),a 
                                    180 	_drop VSIZE 
                                    181 	ret 
                                    182 .endif 
                                    183 
                                    184 ;-------------------------------------
                                    185 ;  initialization entry point 
                                    186 ;-------------------------------------
      00809A                        187 cold_start:
                                    188 ;set stack 
      00809A AE 17 FF         [ 2]  189 	ldw x,#STACK_EMPTY
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 36.
Hexadecimal [24-Bits]



      00809D 94               [ 1]  190 	ldw sp,x
                                    191 ; clear all ram 
      00809E 7F               [ 1]  192 0$: clr (x)
      00809F 5A               [ 2]  193 	decw x 
      0080A0 26 FC            [ 1]  194 	jrne 0$
                                    195 ; clock HSI 16 Mhz 
      0080A2 72 5F 50 C6      [ 1]  196 	clr CLK_CKDIVR 
                                    197 ; activate pull up on all inputs 
      0080A6 A6 FF            [ 1]  198 	ld a,#255 
      0080A8 C7 50 03         [ 1]  199 	ld PA_CR1,a 
      0080AB C7 50 08         [ 1]  200 	ld PB_CR1,a 
      0080AE C7 50 0D         [ 1]  201 	ld PC_CR1,a 
      0080B1 C7 50 12         [ 1]  202 	ld PD_CR1,a
      0080B4 C7 50 17         [ 1]  203 	ld PE_CR1,a 
      0080B7 C7 50 1C         [ 1]  204 	ld PF_CR1,a 
      0080BA C7 50 21         [ 1]  205 	ld PG_CR1,a 
      0080BD C7 50 2B         [ 1]  206 	ld PI_CR1,a
                                    207 ; disable schmitt triggers on Arduino CN4 analog inputs
      0080C0 55 00 3F 54 07   [ 1]  208 	mov ADC_TDRL,0x3f
      0080C5 CD 81 FC         [ 4]  209 	call uart_init
      0080C8 9A               [ 1]  210 	rim ; enable interrupts 
                                    211 
                           000001   212 .if 1 ; TEST CODE 
      0080C9 A6 1B            [ 1]  213 ld a,#ESC 
      0080CB CD 82 1B         [ 4]  214 call uart_putc 
      0080CE A6 63            [ 1]  215 ld a,#'c 
      0080D0 CD 82 1B         [ 4]  216 call uart_putc
      0080D3 AE 80 E1         [ 2]  217 ldw x,#test 
      0080D6 CD 82 73         [ 4]  218 call uart_puts 
      0080D9                        219 1$:
      0080D9 CD 82 4D         [ 4]  220 call uart_getc 
      0080DC CD 82 1B         [ 4]  221 call uart_putc
      0080DF 20 F8            [ 2]  222 jra 1$   
      0080E1 54 48 45 20 51 55 49   223 test: .asciz "THE QUICK BROWN FOX JUMP OVER THE LAZY DOG.\nThe quick bronw fox jump over the lazy dog.\n"
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
                                    224 .endif ; TEST CODE 
                                    225 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 37.
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
      00813A                         36 strlen::
      00813A 89               [ 2]   37 	pushw x 
      00813B 4F               [ 1]   38 	clr a
      00813C 7D               [ 1]   39 1$:	tnz (x) 
      00813D 27 04            [ 1]   40 	jreq 9$ 
      00813F 4C               [ 1]   41 	inc a 
      008140 5C               [ 1]   42 	incw x 
      008141 20 F9            [ 2]   43 	jra 1$ 
      008143 85               [ 2]   44 9$:	popw x 
      008144 81               [ 4]   45 	ret 
                                     46 
                                     47 ;------------------------------------
                                     48 ; compare 2 strings
                                     49 ; input:
                                     50 ;   X 		char* first string 
                                     51 ;   Y       char* second string 
                                     52 ; output:
                                     53 ;   Z flag 	0 != | 1 ==  
                                     54 ;-------------------------------------
      008145                         55 strcmp::
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 38.
Hexadecimal [24-Bits]



      008145 F6               [ 1]   56 	ld a,(x)
      008146 27 09            [ 1]   57 	jreq 5$ 
      008148 90 F1            [ 1]   58 	cp a,(y) 
      00814A 26 07            [ 1]   59 	jrne 9$ 
      00814C 5C               [ 1]   60 	incw x 
      00814D 90 5C            [ 1]   61 	incw y 
      00814F 20 F4            [ 2]   62 	jra strcmp 
      008151                         63 5$: ; end of first string 
      008151 90 F1            [ 1]   64 	cp a,(y)
      008153 81               [ 4]   65 9$:	ret 
                                     66 
                                     67 ;---------------------------------------
                                     68 ;  copy src string to dest 
                                     69 ; input:
                                     70 ;   X 		dest 
                                     71 ;   Y 		src 
                                     72 ; output: 
                                     73 ;   X 		dest 
                                     74 ;----------------------------------
      008154                         75 strcpy::
      008154 88               [ 1]   76 	push a 
      008155 89               [ 2]   77 	pushw x 
      008156 90 F6            [ 1]   78 1$: ld a,(y)
      008158 27 06            [ 1]   79 	jreq 9$ 
      00815A F7               [ 1]   80 	ld (x),a 
      00815B 5C               [ 1]   81 	incw x 
      00815C 90 5C            [ 1]   82 	incw y 
      00815E 20 F6            [ 2]   83 	jra 1$ 
      008160 7F               [ 1]   84 9$:	clr (x)
      008161 85               [ 2]   85 	popw x 
      008162 84               [ 1]   86 	pop a 
      008163 81               [ 4]   87 	ret 
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
      008164                        101 move::
      008164 88               [ 1]  102 	push a 
      008165 89               [ 2]  103 	pushw x 
      0000E6                        104 	_vars VSIZE 
      008166 52 02            [ 2]    1     sub sp,#VSIZE 
      008168 0F 01            [ 1]  105 	clr (INCR,sp)
      00816A 0F 02            [ 1]  106 	clr (LB,sp)
      00816C 90 89            [ 2]  107 	pushw y 
      00816E 13 01            [ 2]  108 	cpw x,(1,sp) ; compare DEST to SRC 
      008170 90 85            [ 2]  109 	popw y 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 39.
Hexadecimal [24-Bits]



      008172 27 2F            [ 1]  110 	jreq move_exit ; x==y 
      008174 2B 0E            [ 1]  111 	jrmi move_down
      008176                        112 move_up: ; start from top address with incr=-1
      008176 72 BB 00 04      [ 2]  113 	addw x,acc16
      00817A 72 B9 00 04      [ 2]  114 	addw y,acc16
      00817E 03 01            [ 1]  115 	cpl (INCR,sp)
      008180 03 02            [ 1]  116 	cpl (LB,sp)   ; increment = -1 
      008182 20 05            [ 2]  117 	jra move_loop  
      008184                        118 move_down: ; start from bottom address with incr=1 
      008184 5A               [ 2]  119     decw x 
      008185 90 5A            [ 2]  120 	decw y
      008187 0C 02            [ 1]  121 	inc (LB,sp) ; incr=1 
      008189                        122 move_loop:	
      000109                        123     _ldaz acc16 
      008189 B6 04                    1     .byte 0xb6,acc16 
      00818B CA 00 05         [ 1]  124 	or a, acc8
      00818E 27 13            [ 1]  125 	jreq move_exit 
      008190 72 FB 01         [ 2]  126 	addw x,(INCR,sp)
      008193 72 F9 01         [ 2]  127 	addw y,(INCR,sp) 
      008196 90 F6            [ 1]  128 	ld a,(y)
      008198 F7               [ 1]  129 	ld (x),a 
      008199 89               [ 2]  130 	pushw x 
      00011A                        131 	_ldxz acc16 
      00819A BE 04                    1     .byte 0xbe,acc16 
      00819C 5A               [ 2]  132 	decw x 
      00819D CF 00 04         [ 2]  133 	ldw acc16,x 
      0081A0 85               [ 2]  134 	popw x 
      0081A1 20 E6            [ 2]  135 	jra move_loop
      0081A3                        136 move_exit:
      000123                        137 	_drop VSIZE
      0081A3 5B 02            [ 2]    1     addw sp,#VSIZE 
      0081A5 85               [ 2]  138 	popw x 
      0081A6 84               [ 1]  139 	pop a 
      0081A7 81               [ 4]  140 	ret 	
                                    141 
                                    142 ;-------------------------
                                    143 ;  upper case letter 
                                    144 ; input:
                                    145 ;   A    letter 
                                    146 ; output:
                                    147 ;   A    
                                    148 ;--------------------------
      0081A8                        149 to_upper:
      0081A8 A1 61            [ 1]  150     cp a,#'a 
      0081AA 2B 06            [ 1]  151     jrmi 9$ 
      0081AC A1 7B            [ 1]  152     cp a,#'z+1 
      0081AE 2A 02            [ 1]  153     jrpl 9$ 
      0081B0 A4 DF            [ 1]  154     and a,#0xDF 
      0081B2 81               [ 4]  155 9$: ret 
                                    156 
                                    157 ;-------------------------------------
                                    158 ; check if A is a letter 
                                    159 ; input:
                                    160 ;   A 			character to test 
                                    161 ; output:
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 40.
Hexadecimal [24-Bits]



                                    162 ;   C flag      1 true, 0 false 
                                    163 ;-------------------------------------
      0081B3                        164 is_alpha::
      0081B3 A1 41            [ 1]  165 	cp a,#'A 
      0081B5 8C               [ 1]  166 	ccf 
      0081B6 24 0B            [ 1]  167 	jrnc 9$ 
      0081B8 A1 5B            [ 1]  168 	cp a,#'Z+1 
      0081BA 25 07            [ 1]  169 	jrc 9$ 
      0081BC A1 61            [ 1]  170 	cp a,#'a 
      0081BE 8C               [ 1]  171 	ccf 
      0081BF 24 02            [ 1]  172 	jrnc 9$
      0081C1 A1 7B            [ 1]  173 	cp a,#'z+1
      0081C3 81               [ 4]  174 9$: ret 	
                                    175 
                                    176 ;------------------------------------
                                    177 ; check if character in {'0'..'9'}
                                    178 ; input:
                                    179 ;    A  character to test
                                    180 ; output:
                                    181 ;    Carry  0 not digit | 1 digit
                                    182 ;------------------------------------
      0081C4                        183 is_digit::
      0081C4 A1 30            [ 1]  184 	cp a,#'0
      0081C6 25 03            [ 1]  185 	jrc 1$
      0081C8 A1 3A            [ 1]  186     cp a,#'9+1
      0081CA 8C               [ 1]  187 	ccf 
      0081CB 8C               [ 1]  188 1$:	ccf 
      0081CC 81               [ 4]  189     ret
                                    190 
                                    191 ;------------------------------------
                                    192 ; check if character in {'0'..'9','A'..'F'}
                                    193 ; input:
                                    194 ;    A  character to test
                                    195 ; output:
                                    196 ;    Carry  0 not hex_digit | 1 hex_digit
                                    197 ;------------------------------------
      0081CD                        198 is_hex_digit::
      0081CD CD 81 C4         [ 4]  199 	call is_digit 
      0081D0 25 08            [ 1]  200 	jrc 9$
      0081D2 A1 41            [ 1]  201 	cp a,#'A 
      0081D4 25 03            [ 1]  202 	jrc 1$
      0081D6 A1 47            [ 1]  203 	cp a,#'G 
      0081D8 8C               [ 1]  204 	ccf 
      0081D9 8C               [ 1]  205 1$: ccf 
      0081DA 81               [ 4]  206 9$: ret 
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
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 41.
Hexadecimal [24-Bits]



                                    217 ;--------------------------------------
      0081DB                        218 is_alnum::
      0081DB CD 81 C4         [ 4]  219 	call is_digit
      0081DE 25 03            [ 1]  220 	jrc 1$ 
      0081E0 CD 81 B3         [ 4]  221 	call is_alpha
      0081E3 81               [ 4]  222 1$:	ret 
                                    223 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 42.
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
      0081E4                         34 UartRxHandler: ; console receive char 
      0081E4 72 0B 52 40 12   [ 2]   35 	btjf UART_SR,#UART_SR_RXNE,5$ 
      0081E9 A6 09            [ 1]   36 	ld a,#rx1_queue 
      0081EB CB 00 4A         [ 1]   37 	add a,rx1_tail 
      0081EE 5F               [ 1]   38 	clrw x 
      0081EF 97               [ 1]   39 	ld xl,a 
      0081F0 C6 52 41         [ 1]   40 	ld a,UART_DR 
      0081F3 F7               [ 1]   41 	ld (x),a 
      000174                         42 	_ldaz rx1_tail 
      0081F4 B6 4A                    1     .byte 0xb6,rx1_tail 
      0081F6 4C               [ 1]   43 	inc a 
      0081F7 A4 3F            [ 1]   44 	and a,#RX_QUEUE_SIZE-1
      000179                         45 	_straz rx1_tail
      0081F9 B7 4A                    1     .byte 0xb7,rx1_tail 
      0081FB 80               [11]   46 5$:	iret 
                                     47 
                                     48 ;---------------------------------------------
                                     49 ; initialize UART, read external swtiches SW4,SW5 
                                     50 ; to determine required BAUD rate.
                                     51 ; called from cold_start in hardware_init.asm 
                                     52 ; input:
                                     53 ;	none      
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 43.
Hexadecimal [24-Bits]



                                     54 ; output:
                                     55 ;   none
                                     56 ;---------------------------------------------
                           01C200    57 BAUD_RATE=115200 
      0081FC                         58 uart_init:
                                     59 ; enable UART clock
      0081FC 72 16 50 C7      [ 1]   60 	bset CLK_PCKENR1,#UART_PCKEN
                                     61 ; get BRR value from table 
      008200 A6 0B            [ 1]   62 	ld a,#0xB
      008202 C7 52 43         [ 1]   63 	ld UART_BRR2,a 
      008205 A6 08            [ 1]   64 	ld a,#0x8
      008207 C7 52 42         [ 1]   65 	ld UART_BRR1,a 
      00820A 72 5F 52 41      [ 1]   66     clr UART_DR
      00820E 35 2C 52 45      [ 1]   67 	mov UART_CR2,#((1<<UART_CR2_TEN)|(1<<UART_CR2_REN)|(1<<UART_CR2_RIEN));
      008212 72 5F 00 49      [ 1]   68     clr rx1_head 
      008216 72 5F 00 4A      [ 1]   69 	clr rx1_tail
      00821A 81               [ 4]   70 	ret
                                     71 
                                     72 
                                     73 ;---------------------------------
                                     74 ; uart_putc
                                     75 ; send a character via UART
                                     76 ; input:
                                     77 ;    A  	character to send
                                     78 ;---------------------------------
      00821B                         79 uart_putc:: 
      00821B 72 0F 52 40 FB   [ 2]   80 	btjf UART_SR,#UART_SR_TXE,.
      008220 C7 52 41         [ 1]   81 	ld UART_DR,a 
      008223 81               [ 4]   82 	ret 
                                     83 
                                     84 ;-------------------------
                                     85 ; delete character left 
                                     86 ;-------------------------
      008224                         87 uart_delback:
      008224 A6 08            [ 1]   88 	ld a,#BS 
      008226 CD 82 1B         [ 4]   89 	call uart_putc  
      008229 A6 20            [ 1]   90 	ld a,#SPACE 
      00822B CD 82 1B         [ 4]   91 	call uart_putc 
      00822E A6 08            [ 1]   92 	ld a,#BS 
      008230 CD 82 1B         [ 4]   93 	call uart_putc 
      008233 81               [ 4]   94 	ret 
                                     95 
                                     96 ;------------------------
                                     97 ; clear VT10x terminal 
                                     98 ; screeen 
                                     99 ;------------------------
      008234                        100 uart_cls:
      008234 88               [ 1]  101 	push a 
      008235 A6 1B            [ 1]  102 	ld a,#ESC 
      008237 CD 82 1B         [ 4]  103 	call uart_putc 
      00823A A6 63            [ 1]  104 	ld a,#'c 
      00823C CD 82 1B         [ 4]  105 	call uart_putc 
      00823F 84               [ 1]  106 	pop a 
      008240 81               [ 4]  107 	ret 
                                    108 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 44.
Hexadecimal [24-Bits]



                                    109 ;--------------------
                                    110 ; send blank character 
                                    111 ; to UART 
                                    112 ;---------------------
      008241                        113 uart_space:
      008241 A6 20            [ 1]  114 	ld a,#SPACE 
      008243 CD 82 1B         [ 4]  115 	call uart_putc 
      008246 81               [ 4]  116 	ret 
                                    117 
                                    118 ;---------------------------------
                                    119 ; Query for character in rx1_queue
                                    120 ; input:
                                    121 ;   none 
                                    122 ; output:
                                    123 ;   A     0 no charcter available
                                    124 ;   Z     1 no character available
                                    125 ;---------------------------------
      008247                        126 qgetc::
      008247                        127 uart_qgetc::
      0001C7                        128 	_ldaz rx1_head 
      008247 B6 49                    1     .byte 0xb6,rx1_head 
      008249 C1 00 4A         [ 1]  129 	cp a,rx1_tail 
      00824C 81               [ 4]  130 	ret 
                                    131 
                                    132 ;---------------------------------
                                    133 ; wait character from UART 
                                    134 ; input:
                                    135 ;   none
                                    136 ; output:
                                    137 ;   A 			char  
                                    138 ;--------------------------------	
      00824D                        139 getc:: ;console input
      00824D                        140 uart_getc::
      00824D CD 82 47         [ 4]  141 	call uart_qgetc
      008250 27 FB            [ 1]  142 	jreq uart_getc 
      008252 89               [ 2]  143 	pushw x 
                                    144 ;; rx1_queue must be in page 0 	
      008253 A6 09            [ 1]  145 	ld a,#rx1_queue
      008255 CB 00 49         [ 1]  146 	add a,rx1_head 
      008258 5F               [ 1]  147 	clrw x  
      008259 97               [ 1]  148 	ld xl,a 
      00825A F6               [ 1]  149 	ld a,(x)
      00825B 88               [ 1]  150 	push a
      0001DC                        151 	_ldaz rx1_head 
      00825C B6 49                    1     .byte 0xb6,rx1_head 
      00825E 4C               [ 1]  152 	inc a 
      00825F A4 3F            [ 1]  153 	and a,#RX_QUEUE_SIZE-1
      0001E1                        154 	_straz rx1_head 
      008261 B7 49                    1     .byte 0xb7,rx1_head 
      008263 84               [ 1]  155 	pop a  
      008264 85               [ 2]  156 	popw x
      008265 81               [ 4]  157 	ret 
                                    158 
                                    159 
                                    160 ;--------------------------
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 45.
Hexadecimal [24-Bits]



                                    161 ; manange control character 
                                    162 ; before calling uart_putc 
                                    163 ; input:
                                    164 ;    A    character 
                                    165 ;---------------------------
      008266                        166 uart_print_char:
      008266 A1 08            [ 1]  167 	cp a,#BS 
      008268 26 05            [ 1]  168 	jrne 1$
      00826A CD 82 24         [ 4]  169 	call uart_delback 
      00826D 20 03            [ 2]  170 	jra 9$ 
      00826F                        171 1$:
      00826F CD 82 1B         [ 4]  172 	call uart_putc
      008272                        173 9$:
      008272 81               [ 4]  174 	ret 
                                    175 
                                    176 
                                    177 ;------------------------------
                                    178 ;  send string to uart 
                                    179 ; input:
                                    180 ;    X    *string 
                                    181 ; output:
                                    182 ;    X    *after string 
                                    183 ;------------------------------
      008273                        184 uart_puts:
      008273 88               [ 1]  185 	push a 
      008274 F6               [ 1]  186 1$: ld a,(x)
      008275 27 06            [ 1]  187 	jreq 9$ 
      008277 CD 82 66         [ 4]  188 	call uart_print_char  
      00827A 5C               [ 1]  189 	incw x 
      00827B 20 F7            [ 2]  190 	jra 1$ 
      00827D 5C               [ 1]  191 9$: incw x 
      00827E 84               [ 1]  192 	pop a 
      00827F 81               [ 4]  193 	ret 
                                    194 
                                    195 ;-------------------------------
                                    196 ; print integer in hexadicimal
                                    197 ; input:
                                    198 ;    X 
                                    199 ;------------------------------- 
      008280                        200 uart_print_hex:
      008280 89               [ 2]  201 	pushw x 
      008281 88               [ 1]  202 	push a 
      008282 9E               [ 1]  203 	ld a,xh 
      008283 CD 82 92         [ 4]  204 	call uart_print_hex_byte 
      008286 9F               [ 1]  205 	ld a,xl 
      008287 CD 82 92         [ 4]  206 	call uart_print_hex_byte 
      00828A A6 20            [ 1]  207 	ld a,#SPACE 
      00828C CD 82 1B         [ 4]  208 	call uart_putc 
      00828F 84               [ 1]  209 	pop a 
      008290 85               [ 2]  210 	popw x 
      008291 81               [ 4]  211 	ret 
                                    212 
                                    213 ;----------------------
                                    214 ; print hexadecimal byte 
                                    215 ; input:
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 46.
Hexadecimal [24-Bits]



                                    216 ;    A    byte to print 
                                    217 ;-----------------------
      008292                        218 uart_print_hex_byte:
      008292 88               [ 1]  219 	push a 
      008293 4E               [ 1]  220 	swap a 
      008294 CD 82 A2         [ 4]  221 	call hex_digit 
      008297 CD 82 1B         [ 4]  222 	call uart_putc 
      00829A 84               [ 1]  223 	pop a 
      00829B CD 82 A2         [ 4]  224 	call hex_digit 
      00829E CD 82 1B         [ 4]  225 	call uart_putc 
      0082A1 81               [ 4]  226 	ret 
                                    227 
                                    228 ;---------------------------
                                    229 ; convert to hexadecimal digit 
                                    230 ; input:
                                    231 ;    A    value to convert 
                                    232 ; output:
                                    233 ;    A    hex digit character 
                                    234 ;-----------------------------
      0082A2                        235 hex_digit:
      0082A2 A4 0F            [ 1]  236 	and a,#15 
      0082A4 AB 30            [ 1]  237 	add a,#'0 
      0082A6 A1 3A            [ 1]  238 	cp a,#'9+1 
      0082A8 2B 02            [ 1]  239 	jrmi 9$ 
      0082AA AB 07            [ 1]  240 	add a,#7 
      0082AC 81               [ 4]  241 9$: ret 
                                    242 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 47.
Hexadecimal [24-Bits]

Symbol Table

    .__.$$$.=  002710 L   |     .__.ABS.=  000000 G   |     .__.CPU.=  000000 L
    .__.H$L.=  000001 L   |     ACK     =  000006     |     ADC_CR1 =  005401 
    ADC_CR1_=  000000     |     ADC_CR1_=  000001     |     ADC_CR1_=  000004 
    ADC_CR1_=  000005     |     ADC_CR1_=  000006     |     ADC_CR2 =  005402 
    ADC_CR2_=  000003     |     ADC_CR2_=  000004     |     ADC_CR2_=  000005 
    ADC_CR2_=  000006     |     ADC_CR2_=  000001     |     ADC_CR3 =  005403 
    ADC_CR3_=  000007     |     ADC_CR3_=  000006     |     ADC_CSR =  005400 
    ADC_CSR_=  000006     |     ADC_CSR_=  000004     |     ADC_CSR_=  000000 
    ADC_CSR_=  000001     |     ADC_CSR_=  000002     |     ADC_CSR_=  000003 
    ADC_CSR_=  000007     |     ADC_CSR_=  000005     |     ADC_DRH =  005404 
    ADC_DRL =  005405     |     ADC_TDRH=  005406     |     ADC_TDRL=  005407 
    AFR     =  004803     |     AFR0_ADC=  000000     |     AFR1_TIM=  000001 
    AFR2_CCO=  000002     |     AFR3_TIM=  000003     |     AFR4_TIM=  000004 
    AFR5_TIM=  000005     |     AFR6_I2C=  000006     |     AFR7_BEE=  000007 
    AWU_APR =  0050F1     |     AWU_CSR =  0050F0     |     AWU_CSR_=  000004 
    AWU_TBR =  0050F2     |     B0_MASK =  000001     |     B115200 =  000006 
    B19200  =  000003     |     B1_MASK =  000002     |     B230400 =  000007 
    B2400   =  000000     |     B2_MASK =  000004     |     B38400  =  000004 
    B3_MASK =  000008     |     B460800 =  000008     |     B4800   =  000001 
    B4_MASK =  000010     |     B57600  =  000005     |     B5_MASK =  000020 
    B6_MASK =  000040     |     B7_MASK =  000080     |     B921600 =  000009 
    B9600   =  000002     |     BAUD_RAT=  01C200     |     BEEP_BIT=  000004 
    BEEP_CSR=  0050F3     |     BEEP_MAS=  000010     |     BEEP_POR=  00000F 
    BELL    =  000007     |     BIT0    =  000000     |     BIT1    =  000001 
    BIT2    =  000002     |     BIT3    =  000003     |     BIT4    =  000004 
    BIT5    =  000005     |     BIT6    =  000006     |     BIT7    =  000007 
    BLOCK_SI=  000080     |     BOOT_ROM=  006000     |     BOOT_ROM=  007FFF 
    BS      =  000008     |     CAN     =  000018     |     CAN_DGR =  005426 
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
    CLKOPT  =  004807     |     CLKOPT_C=  000002     |     CLKOPT_E=  000003 
    CLKOPT_P=  000000     |     CLKOPT_P=  000001     |     CLK_CCOR=  0050C9 
    CLK_CKDI=  0050C6     |     CLK_CKDI=  000000     |     CLK_CKDI=  000001 
    CLK_CKDI=  000002     |     CLK_CKDI=  000003     |     CLK_CKDI=  000004 
    CLK_CMSR=  0050C3     |     CLK_CSSR=  0050C8     |     CLK_ECKR=  0050C1 
    CLK_ECKR=  000000     |     CLK_ECKR=  000001     |     CLK_HSIT=  0050CC 
    CLK_ICKR=  0050C0     |     CLK_ICKR=  000002     |     CLK_ICKR=  000000 
    CLK_ICKR=  000001     |     CLK_ICKR=  000003     |     CLK_ICKR=  000004 
    CLK_ICKR=  000005     |     CLK_PCKE=  0050C7     |     CLK_PCKE=  000000 
    CLK_PCKE=  000001     |     CLK_PCKE=  000007     |     CLK_PCKE=  000005 
    CLK_PCKE=  000006     |     CLK_PCKE=  000004     |     CLK_PCKE=  000002 
    CLK_PCKE=  000003     |     CLK_PCKE=  0050CA     |     CLK_PCKE=  000003 
    CLK_PCKE=  000002     |     CLK_PCKE=  000007     |     CLK_SWCR=  0050C5 
    CLK_SWCR=  000000     |     CLK_SWCR=  000001     |     CLK_SWCR=  000002 
    CLK_SWCR=  000003     |     CLK_SWIM=  0050CD     |     CLK_SWR =  0050C4 
    CLK_SWR_=  0000B4     |     CLK_SWR_=  0000E1     |     CLK_SWR_=  0000D2 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 48.
Hexadecimal [24-Bits]

Symbol Table

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
    DC1     =  000011     |     DC2     =  000012     |     DC3     =  000013 
    DC4     =  000014     |     DEBUG   =  000000     |     DEBUG_BA=  007F00 
    DEBUG_EN=  007FFF     |     DEVID_BA=  0048CD     |     DEVID_EN=  0048D8 
    DEVID_LO=  0048D2     |     DEVID_LO=  0048D3     |     DEVID_LO=  0048D4 
    DEVID_LO=  0048D5     |     DEVID_LO=  0048D6     |     DEVID_LO=  0048D7 
    DEVID_LO=  0048D8     |     DEVID_WA=  0048D1     |     DEVID_XH=  0048CE 
    DEVID_XL=  0048CD     |     DEVID_YH=  0048D0     |     DEVID_YL=  0048CF 
    DLE     =  000010     |     DM_BK1RE=  007F90     |     DM_BK1RH=  007F91 
    DM_BK1RL=  007F92     |     DM_BK2RE=  007F93     |     DM_BK2RH=  007F94 
    DM_BK2RL=  007F95     |     DM_CR1  =  007F96     |     DM_CR2  =  007F97 
    DM_CSR1 =  007F98     |     DM_CSR2 =  007F99     |     DM_ENFCT=  007F9A 
    EEPROM_B=  004000     |     EEPROM_E=  0043FF     |     EEPROM_S=  000400 
    EM      =  000019     |     ENQ     =  000005     |     EOF     =  0000FF 
    EOT     =  000004     |     ESC     =  00001B     |     ETB     =  000017 
    ETX     =  000003     |     EXTI_CR1=  0050A0     |     EXTI_CR2=  0050A1 
    FF      =  00000C     |     FHSE    =  7A1200     |     FHSI    =  F42400 
    FLASH_BA=  008000     |     FLASH_CR=  00505A     |     FLASH_CR=  000002 
    FLASH_CR=  000000     |     FLASH_CR=  000003     |     FLASH_CR=  000001 
    FLASH_CR=  00505B     |     FLASH_CR=  000005     |     FLASH_CR=  000004 
    FLASH_CR=  000007     |     FLASH_CR=  000000     |     FLASH_CR=  000006 
    FLASH_DU=  005064     |     FLASH_DU=  0000AE     |     FLASH_DU=  000056 
    FLASH_EN=  017FFF     |     FLASH_FP=  00505D     |     FLASH_FP=  000000 
    FLASH_FP=  000001     |     FLASH_FP=  000002     |     FLASH_FP=  000003 
    FLASH_FP=  000004     |     FLASH_FP=  000005     |     FLASH_IA=  00505F 
    FLASH_IA=  000003     |     FLASH_IA=  000002     |     FLASH_IA=  000006 
    FLASH_IA=  000001     |     FLASH_IA=  000000     |     FLASH_NC=  00505C 
    FLASH_NF=  00505E     |     FLASH_NF=  000000     |     FLASH_NF=  000001 
    FLASH_NF=  000002     |     FLASH_NF=  000003     |     FLASH_NF=  000004 
    FLASH_NF=  000005     |     FLASH_PU=  005062     |     FLASH_PU=  000056 
    FLASH_PU=  0000AE     |     FLASH_SI=  010000     |     FLASH_WS=  00480D 
    FLSI    =  01F400     |     FMSTR   =  000010     |     FS      =  00001C 
    GPIO_BAS=  005000     |     GPIO_CR1=  000003     |     GPIO_CR2=  000004 
    GPIO_DDR=  000002     |     GPIO_IDR=  000001     |     GPIO_ODR=  000000 
    GPIO_SIZ=  000005     |     GS      =  00001D     |     HSECNT  =  004809 
    I2C_BASE=  005210     |     I2C_CCRH=  00521C     |     I2C_CCRH=  000080 
    I2C_CCRH=  0000C0     |     I2C_CCRH=  000080     |     I2C_CCRH=  000000 
    I2C_CCRH=  000001     |     I2C_CCRH=  000000     |     I2C_CCRH=  000006 
    I2C_CCRH=  000007     |     I2C_CCRL=  00521B     |     I2C_CCRL=  00001A 
    I2C_CCRL=  000002     |     I2C_CCRL=  00000D     |     I2C_CCRL=  000050 
    I2C_CCRL=  000090     |     I2C_CCRL=  0000A0     |     I2C_CR1 =  005210 
    I2C_CR1_=  000006     |     I2C_CR1_=  000007     |     I2C_CR1_=  000000 
    I2C_CR2 =  005211     |     I2C_CR2_=  000002     |     I2C_CR2_=  000003 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 49.
Hexadecimal [24-Bits]

Symbol Table

    I2C_CR2_=  000000     |     I2C_CR2_=  000001     |     I2C_CR2_=  000007 
    I2C_DR  =  005216     |     I2C_FREQ=  005212     |     I2C_ITR =  00521A 
    I2C_ITR_=  000002     |     I2C_ITR_=  000000     |     I2C_ITR_=  000001 
    I2C_OARH=  005214     |     I2C_OARH=  000001     |     I2C_OARH=  000002 
    I2C_OARH=  000006     |     I2C_OARH=  000007     |     I2C_OARL=  005213 
    I2C_OARL=  000000     |     I2C_OAR_=  000813     |     I2C_OAR_=  000009 
    I2C_PECR=  00521E     |     I2C_READ=  000001     |     I2C_SR1 =  005217 
    I2C_SR1_=  000003     |     I2C_SR1_=  000001     |     I2C_SR1_=  000002 
    I2C_SR1_=  000006     |     I2C_SR1_=  000000     |     I2C_SR1_=  000004 
    I2C_SR1_=  000007     |     I2C_SR2 =  005218     |     I2C_SR2_=  000002 
    I2C_SR2_=  000001     |     I2C_SR2_=  000000     |     I2C_SR2_=  000003 
    I2C_SR2_=  000005     |     I2C_SR3 =  005219     |     I2C_SR3_=  000001 
    I2C_SR3_=  000007     |     I2C_SR3_=  000004     |     I2C_SR3_=  000000 
    I2C_SR3_=  000002     |     I2C_TRIS=  00521D     |     I2C_TRIS=  000005 
    I2C_TRIS=  000005     |     I2C_TRIS=  000005     |     I2C_TRIS=  000011 
    I2C_TRIS=  000011     |     I2C_TRIS=  000011     |     I2C_WRIT=  000000 
    INCR    =  000001     |     INPUT_DI=  000000     |     INPUT_EI=  000001 
    INPUT_FL=  000000     |     INPUT_PU=  000001     |     INT_ADC2=  000016 
    INT_AUAR=  000012     |     INT_AWU =  000001     |     INT_CAN_=  000008 
    INT_CAN_=  000009     |     INT_CLK =  000002     |     INT_EXTI=  000003 
    INT_EXTI=  000004     |     INT_EXTI=  000005     |     INT_EXTI=  000006 
    INT_EXTI=  000007     |     INT_FLAS=  000018     |     INT_I2C =  000013 
    INT_SPI =  00000A     |     INT_TIM1=  00000C     |     INT_TIM1=  00000B 
    INT_TIM2=  00000E     |     INT_TIM2=  00000D     |     INT_TIM3=  000010 
    INT_TIM3=  00000F     |     INT_TIM4=  000017     |     INT_TLI =  000000 
    INT_UART=  000011     |     INT_UART=  000015     |     INT_UART=  000014 
    INT_VECT=  008060     |     INT_VECT=  00800C     |     INT_VECT=  008028 
    INT_VECT=  00802C     |     INT_VECT=  008010     |     INT_VECT=  008014 
    INT_VECT=  008018     |     INT_VECT=  00801C     |     INT_VECT=  008020 
    INT_VECT=  008024     |     INT_VECT=  008068     |     INT_VECT=  008054 
    INT_VECT=  008000     |     INT_VECT=  008030     |     INT_VECT=  008038 
    INT_VECT=  008034     |     INT_VECT=  008040     |     INT_VECT=  00803C 
    INT_VECT=  008048     |     INT_VECT=  008044     |     INT_VECT=  008064 
    INT_VECT=  008008     |     INT_VECT=  008004     |     INT_VECT=  008050 
    INT_VECT=  00804C     |     INT_VECT=  00805C     |     INT_VECT=  008058 
    ITC_SPR1=  007F70     |     ITC_SPR2=  007F71     |     ITC_SPR3=  007F72 
    ITC_SPR4=  007F73     |     ITC_SPR5=  007F74     |     ITC_SPR6=  007F75 
    ITC_SPR7=  007F76     |     ITC_SPR8=  007F77     |     ITC_SPR_=  000001 
    ITC_SPR_=  000000     |     ITC_SPR_=  000003     |     IWDG_KEY=  000055 
    IWDG_KEY=  0000CC     |     IWDG_KEY=  0000AA     |     IWDG_KR =  0050E0 
    IWDG_PR =  0050E1     |     IWDG_RLR=  0050E2     |     KERNEL_V=  000004 
    LB      =  000002     |     LED_BIT =  000005     |     LED_MASK=  000020 
    LED_PORT=  00500A     |     LF      =  00000A     |     MAJOR   =  000001 
    MINOR   =  000000     |     NAFR    =  004804     |     NAK     =  000015 
    NCLKOPT =  004808     |     NFLASH_W=  00480E     |     NHSECNT =  00480A 
    NLEN_MAS=  00000F     |     NOPT1   =  004802     |     NOPT2   =  004804 
    NOPT3   =  004806     |     NOPT4   =  004808     |     NOPT5   =  00480A 
    NOPT6   =  00480C     |     NOPT7   =  00480E     |     NOPTBL  =  00487F 
    NUBC    =  004802     |     NWDGOPT =  004806     |     NWDGOPT_=  FFFFFFFD 
    NWDGOPT_=  FFFFFFFC     |     NWDGOPT_=  FFFFFFFF     |     NWDGOPT_=  FFFFFFFE 
  6 NonHandl   000000 R   |     OFS_UART=  000002     |     OFS_UART=  000003 
    OFS_UART=  000004     |     OFS_UART=  000005     |     OFS_UART=  000006 
    OFS_UART=  000007     |     OFS_UART=  000008     |     OFS_UART=  000009 
    OFS_UART=  000001     |     OFS_UART=  000009     |     OFS_UART=  00000A 
    OFS_UART=  000000     |     OPT0    =  004800     |     OPT1    =  004801 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 50.
Hexadecimal [24-Bits]

Symbol Table

    OPT2    =  004803     |     OPT3    =  004805     |     OPT4    =  004807 
    OPT5    =  004809     |     OPT6    =  00480B     |     OPT7    =  00480D 
    OPTBL   =  00487E     |     OPTION_B=  004800     |     OPTION_E=  00487F 
    OPTION_S=  000080     |     OUTPUT_F=  000001     |     OUTPUT_O=  000000 
    OUTPUT_P=  000001     |     OUTPUT_S=  000000     |     PA      =  000000 
    PA_BASE =  005000     |     PA_CR1  =  005003     |     PA_CR2  =  005004 
    PA_DDR  =  005002     |     PA_IDR  =  005001     |     PA_ODR  =  005000 
    PB      =  000005     |     PB_BASE =  005005     |     PB_CR1  =  005008 
    PB_CR2  =  005009     |     PB_DDR  =  005007     |     PB_IDR  =  005006 
    PB_ODR  =  005005     |     PC      =  00000A     |     PC_BASE =  00500A 
    PC_CR1  =  00500D     |     PC_CR2  =  00500E     |     PC_DDR  =  00500C 
    PC_IDR  =  00500B     |     PC_ODR  =  00500A     |     PD      =  00000F 
    PD_BASE =  00500F     |     PD_CR1  =  005012     |     PD_CR2  =  005013 
    PD_DDR  =  005011     |     PD_IDR  =  005010     |     PD_ODR  =  00500F 
    PE      =  000014     |     PE_BASE =  005014     |     PE_CR1  =  005017 
    PE_CR2  =  005018     |     PE_DDR  =  005016     |     PE_IDR  =  005015 
    PE_ODR  =  005014     |     PF      =  000019     |     PF_BASE =  005019 
    PF_CR1  =  00501C     |     PF_CR2  =  00501D     |     PF_DDR  =  00501B 
    PF_IDR  =  00501A     |     PF_ODR  =  005019     |     PG      =  00001E 
    PG_BASE =  00501E     |     PG_CR1  =  005021     |     PG_CR2  =  005022 
    PG_DDR  =  005020     |     PG_IDR  =  00501F     |     PG_ODR  =  00501E 
    PH      =  000023     |     PH_BASE =  005023     |     PH_CR1  =  005026 
    PH_CR2  =  005027     |     PH_DDR  =  005025     |     PH_IDR  =  005024 
    PH_ODR  =  005023     |     PI      =  000028     |     PI_BASE =  005028 
    PI_CR1  =  00502B     |     PI_CR2  =  00502C     |     PI_DDR  =  00502A 
    PI_IDR  =  005029     |     PI_ODR  =  005028     |     RAM_BASE=  000000 
    RAM_END =  0017FF     |     RAM_SIZE=  001800     |     REV     =  000000 
    ROP     =  004800     |     RS      =  00001E     |     RST_SR  =  0050B3 
    RX_QUEUE=  000040     |     SFR_BASE=  005000     |     SFR_END =  0057FF 
    SHARP   =  000023     |     SI      =  00000F     |     SO      =  00000E 
    SOH     =  000001     |     SPACE   =  000020     |     SPI_CR1 =  005200 
    SPI_CR1_=  000003     |     SPI_CR1_=  000000     |     SPI_CR1_=  000001 
    SPI_CR1_=  000007     |     SPI_CR1_=  000002     |     SPI_CR1_=  000006 
    SPI_CR2 =  005201     |     SPI_CR2_=  000007     |     SPI_CR2_=  000006 
    SPI_CR2_=  000005     |     SPI_CR2_=  000004     |     SPI_CR2_=  000002 
    SPI_CR2_=  000000     |     SPI_CR2_=  000001     |     SPI_CRCP=  005205 
    SPI_DR  =  005204     |     SPI_ICR =  005202     |     SPI_RXCR=  005206 
    SPI_SR  =  005203     |     SPI_SR_B=  000007     |     SPI_SR_C=  000004 
    SPI_SR_M=  000005     |     SPI_SR_O=  000006     |     SPI_SR_R=  000000 
    SPI_SR_T=  000001     |     SPI_SR_W=  000003     |     SPI_TXCR=  005207 
    STACK_EM=  0017FF     |     STACK_SI=  000080     |     STRX    =  000002 
    SUB     =  00001A     |     SWIM_CSR=  007F80     |     SYN     =  000016 
    TAB     =  000009     |     TAB_WIDT=  000004     |     TICK    =  000027 
    TIM1_ARR=  005262     |     TIM1_ARR=  005263     |     TIM1_BKR=  00526D 
    TIM1_CCE=  00525C     |     TIM1_CCE=  00525D     |     TIM1_CCM=  005258 
    TIM1_CCM=  000000     |     TIM1_CCM=  000001     |     TIM1_CCM=  000004 
    TIM1_CCM=  000005     |     TIM1_CCM=  000006     |     TIM1_CCM=  000007 
    TIM1_CCM=  000002     |     TIM1_CCM=  000003     |     TIM1_CCM=  000007 
    TIM1_CCM=  000002     |     TIM1_CCM=  000004     |     TIM1_CCM=  000005 
    TIM1_CCM=  000006     |     TIM1_CCM=  000003     |     TIM1_CCM=  000004 
    TIM1_CCM=  005259     |     TIM1_CCM=  000000     |     TIM1_CCM=  000001 
    TIM1_CCM=  000004     |     TIM1_CCM=  000005     |     TIM1_CCM=  000006 
    TIM1_CCM=  000007     |     TIM1_CCM=  000002     |     TIM1_CCM=  000003 
    TIM1_CCM=  000007     |     TIM1_CCM=  000002     |     TIM1_CCM=  000004 
    TIM1_CCM=  000005     |     TIM1_CCM=  000006     |     TIM1_CCM=  000003 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 51.
Hexadecimal [24-Bits]

Symbol Table

    TIM1_CCM=  000004     |     TIM1_CCM=  00525A     |     TIM1_CCM=  000000 
    TIM1_CCM=  000001     |     TIM1_CCM=  000004     |     TIM1_CCM=  000005 
    TIM1_CCM=  000006     |     TIM1_CCM=  000007     |     TIM1_CCM=  000002 
    TIM1_CCM=  000003     |     TIM1_CCM=  000007     |     TIM1_CCM=  000002 
    TIM1_CCM=  000004     |     TIM1_CCM=  000005     |     TIM1_CCM=  000006 
    TIM1_CCM=  000003     |     TIM1_CCM=  000004     |     TIM1_CCM=  00525B 
    TIM1_CCM=  000000     |     TIM1_CCM=  000001     |     TIM1_CCM=  000004 
    TIM1_CCM=  000005     |     TIM1_CCM=  000006     |     TIM1_CCM=  000007 
    TIM1_CCM=  000002     |     TIM1_CCM=  000003     |     TIM1_CCM=  000007 
    TIM1_CCM=  000002     |     TIM1_CCM=  000004     |     TIM1_CCM=  000005 
    TIM1_CCM=  000006     |     TIM1_CCM=  000003     |     TIM1_CCM=  000004 
    TIM1_CCR=  005265     |     TIM1_CCR=  005266     |     TIM1_CCR=  005267 
    TIM1_CCR=  005268     |     TIM1_CCR=  005269     |     TIM1_CCR=  00526A 
    TIM1_CCR=  00526B     |     TIM1_CCR=  00526C     |     TIM1_CNT=  00525E 
    TIM1_CNT=  00525F     |     TIM1_CR1=  005250     |     TIM1_CR1=  000007 
    TIM1_CR1=  000000     |     TIM1_CR1=  000006     |     TIM1_CR1=  000005 
    TIM1_CR1=  000004     |     TIM1_CR1=  000003     |     TIM1_CR1=  000001 
    TIM1_CR1=  000002     |     TIM1_CR2=  005251     |     TIM1_CR2=  000000 
    TIM1_CR2=  000002     |     TIM1_CR2=  000004     |     TIM1_CR2=  000005 
    TIM1_CR2=  000006     |     TIM1_DTR=  00526E     |     TIM1_EGR=  005257 
    TIM1_EGR=  000007     |     TIM1_EGR=  000001     |     TIM1_EGR=  000002 
    TIM1_EGR=  000003     |     TIM1_EGR=  000004     |     TIM1_EGR=  000005 
    TIM1_EGR=  000006     |     TIM1_EGR=  000000     |     TIM1_ETR=  005253 
    TIM1_ETR=  000006     |     TIM1_ETR=  000000     |     TIM1_ETR=  000001 
    TIM1_ETR=  000002     |     TIM1_ETR=  000003     |     TIM1_ETR=  000007 
    TIM1_ETR=  000004     |     TIM1_ETR=  000005     |     TIM1_IER=  005254 
    TIM1_IER=  000007     |     TIM1_IER=  000001     |     TIM1_IER=  000002 
    TIM1_IER=  000003     |     TIM1_IER=  000004     |     TIM1_IER=  000005 
    TIM1_IER=  000006     |     TIM1_IER=  000000     |     TIM1_OIS=  00526F 
    TIM1_PSC=  005260     |     TIM1_PSC=  005261     |     TIM1_RCR=  005264 
    TIM1_SMC=  005252     |     TIM1_SMC=  000007     |     TIM1_SMC=  000000 
    TIM1_SMC=  000001     |     TIM1_SMC=  000002     |     TIM1_SMC=  000004 
    TIM1_SMC=  000005     |     TIM1_SMC=  000006     |     TIM1_SR1=  005255 
    TIM1_SR1=  000007     |     TIM1_SR1=  000001     |     TIM1_SR1=  000002 
    TIM1_SR1=  000003     |     TIM1_SR1=  000004     |     TIM1_SR1=  000005 
    TIM1_SR1=  000006     |     TIM1_SR1=  000000     |     TIM1_SR2=  005256 
    TIM1_SR2=  000001     |     TIM1_SR2=  000002     |     TIM1_SR2=  000003 
    TIM1_SR2=  000004     |     TIM2_ARR=  00530D     |     TIM2_ARR=  00530E 
    TIM2_CCE=  005308     |     TIM2_CCE=  000000     |     TIM2_CCE=  000001 
    TIM2_CCE=  000004     |     TIM2_CCE=  000005     |     TIM2_CCE=  005309 
    TIM2_CCM=  005305     |     TIM2_CCM=  005306     |     TIM2_CCM=  005307 
    TIM2_CCM=  000000     |     TIM2_CCM=  000004     |     TIM2_CCM=  000003 
    TIM2_CCR=  00530F     |     TIM2_CCR=  005310     |     TIM2_CCR=  005311 
    TIM2_CCR=  005312     |     TIM2_CCR=  005313     |     TIM2_CCR=  005314 
    TIM2_CNT=  00530A     |     TIM2_CNT=  00530B     |     TIM2_CR1=  005300 
    TIM2_CR1=  000007     |     TIM2_CR1=  000000     |     TIM2_CR1=  000003 
    TIM2_CR1=  000001     |     TIM2_CR1=  000002     |     TIM2_EGR=  005304 
    TIM2_EGR=  000001     |     TIM2_EGR=  000002     |     TIM2_EGR=  000003 
    TIM2_EGR=  000006     |     TIM2_EGR=  000000     |     TIM2_IER=  005301 
    TIM2_PSC=  00530C     |     TIM2_SR1=  005302     |     TIM2_SR2=  005303 
    TIM3_ARR=  00532B     |     TIM3_ARR=  00532C     |     TIM3_CCE=  005327 
    TIM3_CCE=  000000     |     TIM3_CCE=  000001     |     TIM3_CCE=  000004 
    TIM3_CCE=  000005     |     TIM3_CCE=  000000     |     TIM3_CCE=  000001 
    TIM3_CCM=  005325     |     TIM3_CCM=  005326     |     TIM3_CCM=  000000 
    TIM3_CCM=  000004     |     TIM3_CCM=  000003     |     TIM3_CCR=  00532D 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 52.
Hexadecimal [24-Bits]

Symbol Table

    TIM3_CCR=  00532E     |     TIM3_CCR=  00532F     |     TIM3_CCR=  005330 
    TIM3_CNT=  005328     |     TIM3_CNT=  005329     |     TIM3_CR1=  005320 
    TIM3_CR1=  000007     |     TIM3_CR1=  000000     |     TIM3_CR1=  000003 
    TIM3_CR1=  000001     |     TIM3_CR1=  000002     |     TIM3_EGR=  005324 
    TIM3_IER=  005321     |     TIM3_PSC=  00532A     |     TIM3_SR1=  005322 
    TIM3_SR2=  005323     |     TIM4_ARR=  005346     |     TIM4_CNT=  005344 
    TIM4_CR1=  005340     |     TIM4_CR1=  000007     |     TIM4_CR1=  000000 
    TIM4_CR1=  000003     |     TIM4_CR1=  000001     |     TIM4_CR1=  000002 
    TIM4_EGR=  005343     |     TIM4_EGR=  000000     |     TIM4_IER=  005341 
    TIM4_IER=  000000     |     TIM4_PSC=  005345     |     TIM4_PSC=  000000 
    TIM4_PSC=  000007     |     TIM4_PSC=  000004     |     TIM4_PSC=  000001 
    TIM4_PSC=  000005     |     TIM4_PSC=  000002     |     TIM4_PSC=  000006 
    TIM4_PSC=  000003     |     TIM4_PSC=  000000     |     TIM4_PSC=  000001 
    TIM4_PSC=  000002     |     TIM4_SR =  005342     |     TIM4_SR_=  000000 
    UART    =  000002     |     UART1   =  000000     |     UART1_BA=  005230 
    UART1_BR=  005232     |     UART1_BR=  005233     |     UART1_CR=  005234 
    UART1_CR=  005235     |     UART1_CR=  005236     |     UART1_CR=  005237 
    UART1_CR=  005238     |     UART1_DR=  005231     |     UART1_GT=  005239 
    UART1_PO=  000000     |     UART1_PS=  00523A     |     UART1_RX=  000004 
    UART1_SR=  005230     |     UART1_TX=  000005     |     UART2   =  000001 
    UART3   =  000002     |     UART3_BA=  005240     |     UART3_BR=  005242 
    UART3_BR=  005243     |     UART3_CR=  005244     |     UART3_CR=  005245 
    UART3_CR=  005246     |     UART3_CR=  005247     |     UART3_CR=  005249 
    UART3_DR=  005241     |     UART3_PO=  00000F     |     UART3_RX=  000006 
    UART3_SR=  005240     |     UART3_TX=  000005     |     UART_BRR=  005242 
    UART_BRR=  005243     |     UART_CR1=  005244     |     UART_CR1=  000004 
    UART_CR1=  000002     |     UART_CR1=  000000     |     UART_CR1=  000001 
    UART_CR1=  000007     |     UART_CR1=  000006     |     UART_CR1=  000005 
    UART_CR1=  000003     |     UART_CR2=  005245     |     UART_CR2=  000004 
    UART_CR2=  000002     |     UART_CR2=  000005     |     UART_CR2=  000001 
    UART_CR2=  000000     |     UART_CR2=  000006     |     UART_CR2=  000003 
    UART_CR2=  000007     |     UART_CR3=  000003     |     UART_CR3=  000001 
    UART_CR3=  000002     |     UART_CR3=  000000     |     UART_CR3=  000006 
    UART_CR3=  000004     |     UART_CR3=  000005     |     UART_CR4=  000000 
    UART_CR4=  000001     |     UART_CR4=  000002     |     UART_CR4=  000003 
    UART_CR4=  000004     |     UART_CR4=  000006     |     UART_CR4=  000005 
    UART_CR5=  000003     |     UART_CR5=  000001     |     UART_CR5=  000002 
    UART_CR5=  000004     |     UART_CR5=  000005     |     UART_CR6=  000004 
    UART_CR6=  000007     |     UART_CR6=  000001     |     UART_CR6=  000002 
    UART_CR6=  000000     |     UART_CR6=  000005     |     UART_DR =  005241 
    UART_PCK=  000003     |     UART_POR=  00500D     |     UART_POR=  00500E 
    UART_POR=  00500C     |     UART_POR=  00500B     |     UART_POR=  00500A 
    UART_RX_=  000006     |     UART_SR =  005240     |     UART_SR_=  000001 
    UART_SR_=  000004     |     UART_SR_=  000002     |     UART_SR_=  000003 
    UART_SR_=  000000     |     UART_SR_=  000005     |     UART_SR_=  000006 
    UART_SR_=  000007     |     UART_TX_=  000005     |     UBC     =  004801 
    US      =  00001F     |   6 UartRxHa   000164 R   |     VSIZE   =  000002 
    VT      =  00000B     |     WDGOPT  =  004805     |     WDGOPT_I=  000002 
    WDGOPT_L=  000003     |     WDGOPT_W=  000000     |     WDGOPT_W=  000001 
    WWDG_CR =  0050D1     |     WWDG_WR =  0050D2     |     XOFF    =  000013 
    XON     =  000011     |   5 acc16      000004 GR  |   5 acc8       000005 GR
  6 clock_in   000004 R   |   6 cold_sta   00001A R   |   5 flags      000008 GR
  6 getc       0001CD GR  |   6 hex_digi   000222 R   |   6 is_alnum   00015B GR
  6 is_alpha   000133 GR  |   6 is_digit   000144 GR  |   6 is_hex_d   00014D GR
  6 move       0000E4 GR  |   6 move_dow   000104 R   |   6 move_exi   000123 R
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 53.
Hexadecimal [24-Bits]

Symbol Table

  6 move_loo   000109 R   |   6 move_up    0000F6 R   |   5 ptr16      000006 GR
  5 ptr8       000007 R   |   6 qgetc      0001C7 GR  |   5 rx1_head   000049 R
  5 rx1_queu   000009 R   |   5 rx1_tail   00004A R   |   2 stack_fu   001780 GR
  2 stack_un   001800 R   |   6 strcmp     0000C5 GR  |   6 strcpy     0000D4 GR
  6 strlen     0000BA GR  |   6 test       000061 R   |   6 to_upper   000128 R
  6 uart_cls   0001B4 R   |   6 uart_del   0001A4 R   |   6 uart_get   0001CD GR
  6 uart_ini   00017C R   |   6 uart_pri   0001E6 R   |   6 uart_pri   000200 R
  6 uart_pri   000212 R   |   6 uart_put   00019B GR  |   6 uart_put   0001F3 R
  6 uart_qge   0001C7 GR  |   6 uart_spa   0001C1 R

ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 54.
Hexadecimal [24-Bits]

Area Table

   0 _CODE      size      0   flags    0
   1 SSEG       size      0   flags    8
   2 SSEG0      size     80   flags    8
   3 HOME       size     80   flags    0
   4 DATA       size      0   flags    8
   5 DATA1      size     47   flags    8
   6 CODE       size    22D   flags    0

