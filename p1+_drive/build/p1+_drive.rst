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
                                      7 ; version 
                           000001     8     MAJOR=1 
                           000000     9     MINOR=0 
                           000000    10     REV=0
                                     11     
                           000010    12 FMSTR=16 ; MHZ
                                     13 
                                     14 ; flags 
                           000000    15 FTX=0 ; set to 1 when transmitting data to computer, otherwise reset  
                           000001    16 FCOMP_RDY=1 ; set this bit when computer is ready to receive, otherwise reset 
                                     17 
                                     18 
                                     19 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 3.
Hexadecimal [24-Bits]



                                     20     .include "inc/stm8s207.inc" 
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
                                    549 
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



                                     21 	.include "inc/ascii.inc"
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
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 25.
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
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 26.
Hexadecimal [24-Bits]



                                     22 	.include "inc/gen_macros.inc" 
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
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 27.
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
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 28.
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
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 29.
Hexadecimal [24-Bits]



                                     23 	.include "app_macros.inc" 
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
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 30.
Hexadecimal [24-Bits]



                                     24 
                                     25 ;UART=UART3 
                                     26 
                                     27 ; interface port 
                                     28 ; communication with computer PIA W65C22 PORT A 
                                     29 ; using 8 bits bus. 
                           00500F    30 ITF_PORT=PD_BASE ; data transfert bus 
                           005011    31 ITF_DDR=PD_DDR 
                           00500F    32 ITF_ODR=PD_ODR 
                           005010    33 ITF_IDR=PD_IDR 
                           005012    34 ITF_CR1=PD_CR1 
                           005013    35 ITF_CR2=PD_CR2 
                                     36 ; handshake 
                           005005    37 ITF_CTRL_PORT=PB_BASE 
                           005005    38 ITF_CTRL_ODR=PB_ODR 
                           005006    39 ITF_CTRL_IDR=PB_IDR 
                           005007    40 ITF_CTRL_DDR=PB_DDR 
                           005008    41 ITF_CTRL_CR1=PB_CR1 
                           005009    42 ITF_CTRL_CR2=PB_CR2
                                     43 ; handshake control lines 
                           000001    44 ITF_CA1=BIT1 ; drive ready signal on PB1 
                           000000    45 ITF_CA2=BIT0 ; computer ready signal on PB0 
                           0050A0    46 EXTI_CR=EXTI_CR1 ; external interrupt control register 
                           000002    47 ITF_CA2_PBIS=BIT2 ; EXTI_CR1 ext. int. control bits 2:3 
                           000005    48 ITF_SELECT=BIT5 ; serial/parallel interface select
                                     49 
                                     50 ; clock enable bit 
                           000003    51 UART_PCKEN=CLK_PCKENR1_UART3 
                                     52 
                                     53 ; uart registers 
                           005240    54 UART_SR=UART3_SR
                           005241    55 UART_DR=UART3_DR
                           005242    56 UART_BRR1=UART3_BRR1
                           005243    57 UART_BRR2=UART3_BRR2
                           005244    58 UART_CR1=UART3_CR1
                           005245    59 UART_CR2=UART3_CR2
                                     60 
                                     61 ; TX, RX pin
                           000005    62 UART_TX_PIN=UART3_TX_PIN 
                           000006    63 UART_RX_PIN=UART3_RX_PIN 
                                     64 ;-------------------------
                                     65 ;  SPI interface 
                                     66 ;-------------------------
                                     67 ; SPI port 
                           00500A    68 SPI_PORT= PC_BASE
                           00500A    69 SPI_PORT_ODR=PC_ODR 
                           00500B    70 SPI_PORT_IDR=PC_IDR 
                           00500C    71 SPI_PORT_DDR=PC_DDR 
                           00500D    72 SPI_PORT_CR1=PC_CR1 
                           00500E    73 SPI_PORT_CR2=PC_CR2 
                                     74 ; spi pins bits 
                           000007    75 SPI_MISO= 7;PC7 
                           000006    76 SPI_MOSI= 6;PC6
                           000005    77 SPI_CLK=  5;PC5 
                                     78 ; SPI channel select pins 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 31.
Hexadecimal [24-Bits]



                           000003    79 SPI_CS0=3   ; PC3 FLASH0  
                           000004    80 SPI_CS1=4   ; PC4 XRAM 
                           000002    81 SPI_CS2=2   ; PC2 external device 
                           000001    82 SPI_CS3=1   ; PC1 external device 
                           000003    83 FLASH0=SPI_CS0 ; fixed internal
                           000004    84 XRAM=SPI_CS1 ; extended RAM  
                                     85 
                                     86 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 32.
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
      008000 82 00 80 98             42     int cold_start			; RESET vector 
      008004 82 00 80 80             43 	int NonHandledInterrupt ; trap instruction 
      008008 82 00 80 80             44 	int NonHandledInterrupt ;int0 TLI   external top level interrupt
      00800C 82 00 80 80             45 	int NonHandledInterrupt ;int1 AWU   auto wake up from halt
      008010 82 00 80 80             46 	int NonHandledInterrupt ;int2 CLK   clock controller
      008014 82 00 80 80             47 	int NonHandledInterrupt ;int3 EXTI0 gpio A external interrupts
      008018 82 00 84 CA             48 	int PBusIntHandler      ;int4 EXTI1 gpio B external interrupts
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
      00805C 82 00 81 86             65 	int UartRxHandler 		;int21 UART3 RX full
      008060 82 00 80 80             66 	int NonHandledInterrupt ;int22 ADC2 end of conversion
      008064 82 00 80 80             67 	int NonHandledInterrupt	;int23 TIM4 update/overflow ; use to blink tv cursor 
      008068 82 00 80 80             68 	int NonHandledInterrupt ;int24 flash writing EOP/WR_PG_DIS
      00806C 82 00 80 80             69 	int NonHandledInterrupt ;int25  not used
      008070 82 00 80 80             70 	int NonHandledInterrupt ;int26  not used ;
      008074 82 00 80 80             71 	int NonHandledInterrupt ;int27  not used ; 
      008078 82 00 80 80             72 	int NonHandledInterrupt ;int28  not used
      00807C 82 00 80 80             73 	int NonHandledInterrupt ;int29  not used
                                     74 
                                     75 
                                     76 
                                     77 ;--------------------------------------
                                     78     .area DATA (ABS)
      000000                         79 	.org 0 
                                     80 ;--------------------------------------	
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 33.
Hexadecimal [24-Bits]



                                     81 
                                     82 ; keep the following 3 variables in this order 
      000000                         83 acc16:: .blkb 1 ; 16 bits accumulator, acc24 high-byte
      000001                         84 acc8::  .blkb 1 ;  8 bits accumulator, acc24 low-byte  
      000002                         85 farptr:: .blkb 1; 24 bits pointer 
      000003                         86 ptr16::  .blkb 1 ; 16 bits pointer , farptr high-byte 
      000004                         87 ptr8::   .blkb 1 ; 8 bits pointer, farptr low-byte  
      000005                         88 flags:: .blkb 1 ; various boolean flags
      000006                         89 prng_seed:: .blkb 2 ; 
                                     90 
                                     91 ; communication queue 
                                     92 ; used by UART and parallel bus interface 
                           000040    93 RX_QUEUE_SIZE=64 ; bytes 
      000008                         94 rx_queue:: .ds RX_QUEUE_SIZE ; receive circular queue 
      000048                         95 rx_head::  .blkb 1 ; rx_queue head pointer
      000049                         96 rx_tail::   .blkb 1 ; rx_queue tail pointer  
                                     97 
                                     98 ; SPI variables 
      00004A                         99 device_size:: .blkb 1 ; in MB
      00004B                        100 spi_device:: .blkb 1 ; selected spi device 
                                    101 
      000100                        102 	.org 0x100  
      000100                        103 flash_buffer:: .blkb W25Q_SECTOR_SIZE ; 4096 bytes 
                                    104 
                                    105 
                                    106 	.area CODE 
                                    107 
                                    108 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                                    109 ; non handled interrupt 
                                    110 ; reset MCU
                                    111 ;;;;;;;;;;;;;;;;;;;;;;;;;;;
      008080                        112 NonHandledInterrupt:
      000000                        113 	_swreset ; see "inc/gen_macros.inc"
      008080 35 80 50 D1      [ 1]    1     mov WWDG_CR,#0X80
                                    114 
                                    115 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                                    116 ;    peripherals initialization
                                    117 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                                    118 
                                    119 ;--------------------------
                                    120 ; pseudo random number 
                                    121 ; Galois LFSR 
                                    122 ; generator 
                                    123 ; output:
                                    124 ;    X     prng value 
                                    125 ;--------------------------
      008084                        126 prng:
                                    127 ; 5 times right shift 
      008084 4B 05            [ 1]  128 	push #5
      000006                        129 	_ldxz prng_seed
      008086 BE 06                    1     .byte 0xbe,prng_seed 
      008088                        130 1$:
      008088 54               [ 2]  131 	srlw x 
      008089 24 04            [ 1]  132 	jrnc 2$
      00808B 9E               [ 1]  133 	ld a, xh 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 34.
Hexadecimal [24-Bits]



      00808C A8 B4            [ 1]  134 	xor a,#0XB4 
      00808E 95               [ 1]  135 	ld xh, a
      00808F                        136 2$: 	
      00808F 0A 01            [ 1]  137 	dec (1,sp)
      008091 26 F5            [ 1]  138 	jrne 1$  
      000013                        139 9$: _strxz prng_seed 
      008093 BF 06                    1     .byte 0xbf,prng_seed 
      000015                        140 	_drop 1 
      008095 5B 01            [ 2]    1     addw sp,#1 
      008097 81               [ 4]  141 	ret 
                                    142 
                                    143 ;-------------------------------------
                                    144 ;  initialization entry point 
                                    145 ;-------------------------------------
      008098                        146 cold_start:
                                    147 ;set stack 
      008098 AE 17 FF         [ 2]  148 	ldw x,#STACK_EMPTY
      00809B 94               [ 1]  149 	ldw sp,x
                                    150 ; clear all ram 
      00809C 7F               [ 1]  151 0$: clr (x)
      00809D 5A               [ 2]  152 	decw x 
      00809E 26 FC            [ 1]  153 	jrne 0$
                                    154 ; clock HSI 16 Mhz 
      0080A0 72 5F 50 C6      [ 1]  155 	clr CLK_CKDIVR 
                                    156 ; disable all peripherals clock
                                    157 ; to reduce power consumption
      0080A4 72 5F 50 C7      [ 1]  158 	clr CLK_PCKENR1
      0080A8 72 5F 50 CA      [ 1]  159 	clr CLK_PCKENR2 
                                    160 ; activate pull up on all inputs 
                                    161 ; to reduce input noise.
                           000001   162 .if 1
      0080AC A6 FF            [ 1]  163 	ld a,#255 
      0080AE C7 50 03         [ 1]  164 	ld PA_CR1,a 
      0080B1 C7 50 08         [ 1]  165 	ld PB_CR1,a 
      0080B4 C7 50 0D         [ 1]  166 	ld PC_CR1,a 
      0080B7 C7 50 12         [ 1]  167 	ld PD_CR1,a
      0080BA C7 50 17         [ 1]  168 	ld PE_CR1,a 
      0080BD C7 50 1C         [ 1]  169 	ld PF_CR1,a 
                                    170 .endif 
                                    171 ; disable schmitt triggers on Arduino CN4 analog inputs
      0080C0 A6 3F            [ 1]  172 	ld a,#0x3f 
      0080C2 C7 54 07         [ 1]  173 	ld ADC_TDRL,a  
                                    174 ; init prng seed 
                                    175 ; only used in tests 
      0080C5 AE AC E1         [ 2]  176 	ldw x,#0xACE1
      000048                        177 	_strxz prng_seed
      0080C8 BF 06                    1     .byte 0xbf,prng_seed 
                                    178 ; initialized peripherals 
      0080CA CD 81 AC         [ 4]  179 	call uart_init
      0080CD CD 82 9C         [ 4]  180 	call spi_init
      0080D0 CD 84 E5         [ 4]  181 	call itf_init 
      0080D3 9A               [ 1]  182 	rim ; enable interrupts 
                                    183 
                           000000   184 UART_TEST=0
                           000000   185 .if UART_TEST  
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 35.
Hexadecimal [24-Bits]



                                    186 	call uart_test 
                                    187 .endif 
                                    188 
                           000000   189 FLASH_TEST=0
                           000000   190 .if FLASH_TEST 
                                    191 	call flash_test 
                                    192 .endif 
                                    193 
                           000001   194 XRAM_TEST=1
                           000001   195 .if XRAM_TEST
      0080D4 CD 85 67         [ 4]  196 	call xram_test 
                                    197 .endif 
                                    198 
                           000001   199 DRV_CMD_TEST=1
                           000001   200 .if DRV_CMD_TEST 
      0080D7 CD 85 AE         [ 4]  201 	call drive_cmd_test
                                    202 .endif // DRV_CMD_TEST 
                                    203 
      0080DA                        204 main:
      0080DA 20 FE            [ 2]  205 	jra . 
                                    206 
                                    207 
                                    208 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 36.
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
      0080DC                         36 strlen::
      0080DC 89               [ 2]   37 	pushw x 
      0080DD 4F               [ 1]   38 	clr a
      0080DE 7D               [ 1]   39 1$:	tnz (x) 
      0080DF 27 04            [ 1]   40 	jreq 9$ 
      0080E1 4C               [ 1]   41 	inc a 
      0080E2 5C               [ 1]   42 	incw x 
      0080E3 20 F9            [ 2]   43 	jra 1$ 
      0080E5 85               [ 2]   44 9$:	popw x 
      0080E6 81               [ 4]   45 	ret 
                                     46 
                                     47 ;------------------------------------
                                     48 ; compare 2 strings
                                     49 ; input:
                                     50 ;   X 		char* first string 
                                     51 ;   Y       char* second string 
                                     52 ; output:
                                     53 ;   Z flag 	0 != | 1 ==  
                                     54 ;-------------------------------------
      0080E7                         55 strcmp::
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 37.
Hexadecimal [24-Bits]



      0080E7 F6               [ 1]   56 	ld a,(x)
      0080E8 27 09            [ 1]   57 	jreq 5$ 
      0080EA 90 F1            [ 1]   58 	cp a,(y) 
      0080EC 26 07            [ 1]   59 	jrne 9$ 
      0080EE 5C               [ 1]   60 	incw x 
      0080EF 90 5C            [ 1]   61 	incw y 
      0080F1 20 F4            [ 2]   62 	jra strcmp 
      0080F3                         63 5$: ; end of first string 
      0080F3 90 F1            [ 1]   64 	cp a,(y)
      0080F5 81               [ 4]   65 9$:	ret 
                                     66 
                                     67 ;---------------------------------------
                                     68 ;  copy src string to dest 
                                     69 ; input:
                                     70 ;   X 		dest 
                                     71 ;   Y 		src 
                                     72 ; output: 
                                     73 ;   X 		dest 
                                     74 ;----------------------------------
      0080F6                         75 strcpy::
      0080F6 88               [ 1]   76 	push a 
      0080F7 89               [ 2]   77 	pushw x 
      0080F8 90 F6            [ 1]   78 1$: ld a,(y)
      0080FA 27 06            [ 1]   79 	jreq 9$ 
      0080FC F7               [ 1]   80 	ld (x),a 
      0080FD 5C               [ 1]   81 	incw x 
      0080FE 90 5C            [ 1]   82 	incw y 
      008100 20 F6            [ 2]   83 	jra 1$ 
      008102 7F               [ 1]   84 9$:	clr (x)
      008103 85               [ 2]   85 	popw x 
      008104 84               [ 1]   86 	pop a 
      008105 81               [ 4]   87 	ret 
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
      008106                        101 move::
      008106 88               [ 1]  102 	push a 
      008107 89               [ 2]  103 	pushw x 
      000088                        104 	_vars VSIZE 
      008108 52 02            [ 2]    1     sub sp,#VSIZE 
      00810A 0F 01            [ 1]  105 	clr (INCR,sp)
      00810C 0F 02            [ 1]  106 	clr (LB,sp)
      00810E 90 89            [ 2]  107 	pushw y 
      008110 13 01            [ 2]  108 	cpw x,(1,sp) ; compare DEST to SRC 
      008112 90 85            [ 2]  109 	popw y 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 38.
Hexadecimal [24-Bits]



      008114 27 2F            [ 1]  110 	jreq move_exit ; x==y 
      008116 2B 0E            [ 1]  111 	jrmi move_down
      008118                        112 move_up: ; start from top address with incr=-1
      008118 72 BB 00 00      [ 2]  113 	addw x,acc16
      00811C 72 B9 00 00      [ 2]  114 	addw y,acc16
      008120 03 01            [ 1]  115 	cpl (INCR,sp)
      008122 03 02            [ 1]  116 	cpl (LB,sp)   ; increment = -1 
      008124 20 05            [ 2]  117 	jra move_loop  
      008126                        118 move_down: ; start from bottom address with incr=1 
      008126 5A               [ 2]  119     decw x 
      008127 90 5A            [ 2]  120 	decw y
      008129 0C 02            [ 1]  121 	inc (LB,sp) ; incr=1 
      00812B                        122 move_loop:	
      0000AB                        123     _ldaz acc16 
      00812B B6 00                    1     .byte 0xb6,acc16 
      00812D CA 00 01         [ 1]  124 	or a, acc8
      008130 27 13            [ 1]  125 	jreq move_exit 
      008132 72 FB 01         [ 2]  126 	addw x,(INCR,sp)
      008135 72 F9 01         [ 2]  127 	addw y,(INCR,sp) 
      008138 90 F6            [ 1]  128 	ld a,(y)
      00813A F7               [ 1]  129 	ld (x),a 
      00813B 89               [ 2]  130 	pushw x 
      0000BC                        131 	_ldxz acc16 
      00813C BE 00                    1     .byte 0xbe,acc16 
      00813E 5A               [ 2]  132 	decw x 
      00813F CF 00 00         [ 2]  133 	ldw acc16,x 
      008142 85               [ 2]  134 	popw x 
      008143 20 E6            [ 2]  135 	jra move_loop
      008145                        136 move_exit:
      0000C5                        137 	_drop VSIZE
      008145 5B 02            [ 2]    1     addw sp,#VSIZE 
      008147 85               [ 2]  138 	popw x 
      008148 84               [ 1]  139 	pop a 
      008149 81               [ 4]  140 	ret 	
                                    141 
                                    142 ;-------------------------
                                    143 ;  upper case letter 
                                    144 ; input:
                                    145 ;   A    letter 
                                    146 ; output:
                                    147 ;   A    
                                    148 ;--------------------------
      00814A                        149 to_upper:
      00814A A1 61            [ 1]  150     cp a,#'a 
      00814C 2B 06            [ 1]  151     jrmi 9$ 
      00814E A1 7B            [ 1]  152     cp a,#'z+1 
      008150 2A 02            [ 1]  153     jrpl 9$ 
      008152 A4 DF            [ 1]  154     and a,#0xDF 
      008154 81               [ 4]  155 9$: ret 
                                    156 
                                    157 ;-------------------------------------
                                    158 ; check if A is a letter 
                                    159 ; input:
                                    160 ;   A 			character to test 
                                    161 ; output:
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 39.
Hexadecimal [24-Bits]



                                    162 ;   C flag      1 true, 0 false 
                                    163 ;-------------------------------------
      008155                        164 is_alpha::
      008155 A1 41            [ 1]  165 	cp a,#'A 
      008157 8C               [ 1]  166 	ccf 
      008158 24 0B            [ 1]  167 	jrnc 9$ 
      00815A A1 5B            [ 1]  168 	cp a,#'Z+1 
      00815C 25 07            [ 1]  169 	jrc 9$ 
      00815E A1 61            [ 1]  170 	cp a,#'a 
      008160 8C               [ 1]  171 	ccf 
      008161 24 02            [ 1]  172 	jrnc 9$
      008163 A1 7B            [ 1]  173 	cp a,#'z+1
      008165 81               [ 4]  174 9$: ret 	
                                    175 
                                    176 ;------------------------------------
                                    177 ; check if character in {'0'..'9'}
                                    178 ; input:
                                    179 ;    A  character to test
                                    180 ; output:
                                    181 ;    Carry  0 not digit | 1 digit
                                    182 ;------------------------------------
      008166                        183 is_digit::
      008166 A1 30            [ 1]  184 	cp a,#'0
      008168 25 03            [ 1]  185 	jrc 1$
      00816A A1 3A            [ 1]  186     cp a,#'9+1
      00816C 8C               [ 1]  187 	ccf 
      00816D 8C               [ 1]  188 1$:	ccf 
      00816E 81               [ 4]  189     ret
                                    190 
                                    191 ;------------------------------------
                                    192 ; check if character in {'0'..'9','A'..'F'}
                                    193 ; input:
                                    194 ;    A  character to test
                                    195 ; output:
                                    196 ;    Carry  0 not hex_digit | 1 hex_digit
                                    197 ;------------------------------------
      00816F                        198 is_hex_digit::
      00816F CD 81 66         [ 4]  199 	call is_digit 
      008172 25 08            [ 1]  200 	jrc 9$
      008174 A1 41            [ 1]  201 	cp a,#'A 
      008176 25 03            [ 1]  202 	jrc 1$
      008178 A1 47            [ 1]  203 	cp a,#'G 
      00817A 8C               [ 1]  204 	ccf 
      00817B 8C               [ 1]  205 1$: ccf 
      00817C 81               [ 4]  206 9$: ret 
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
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 40.
Hexadecimal [24-Bits]



                                    217 ;--------------------------------------
      00817D                        218 is_alnum::
      00817D CD 81 66         [ 4]  219 	call is_digit
      008180 25 03            [ 1]  220 	jrc 1$ 
      008182 CD 81 55         [ 4]  221 	call is_alpha
      008185 81               [ 4]  222 1$:	ret 
                                    223 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 41.
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
                                     31 ;--------------------------
      008186                         32 UartRxHandler: ; console receive char 
      008186 72 0B 52 40 0E   [ 2]   33 	btjf UART_SR,#UART_SR_RXNE,5$ 
      00818B C6 52 41         [ 1]   34 	ld a,UART_DR 
      00818E A1 18            [ 1]   35 	cp a,#CTRL_X 
      008190 26 04            [ 1]   36 	jrne 1$ 
      000112                         37 	_swreset
      008192 35 80 50 D1      [ 1]    1     mov WWDG_CR,#0X80
      008196                         38 1$:	
      008196 CD 81 9A         [ 4]   39 	call store_byte_in_queue
      008199 80               [11]   40 5$:	iret 
                                     41 
                                     42 ;--------------------------------
                                     43 ; store received byte in queue 
                                     44 ; used by serial and parrallel 
                                     45 ; interface 
                                     46 ;  input:
                                     47 ;     A    byte to store 
                                     48 ;-------------------------------
      00819A                         49 store_byte_in_queue:
      00819A 88               [ 1]   50 	push a
      00819B A6 08            [ 1]   51 	ld a,#rx_queue 
      00819D CB 00 49         [ 1]   52 	add a,rx_tail 
      0081A0 5F               [ 1]   53 	clrw x 
      0081A1 97               [ 1]   54 	ld xl,a 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 42.
Hexadecimal [24-Bits]



      0081A2 84               [ 1]   55 	pop a  
      0081A3 F7               [ 1]   56 	ld (x),a 
      000124                         57 	_ldaz rx_tail 
      0081A4 B6 49                    1     .byte 0xb6,rx_tail 
      0081A6 4C               [ 1]   58 	inc a 
      0081A7 A4 3F            [ 1]   59 	and a,#RX_QUEUE_SIZE-1
      000129                         60 	_straz rx_tail
      0081A9 B7 49                    1     .byte 0xb7,rx_tail 
      0081AB 81               [ 4]   61 	ret 
                                     62 
                                     63 
                                     64 ;---------------------------------------------
                                     65 ; initialize UART, read external swtiches SW4,SW5 
                                     66 ; to determine required BAUD rate.
                                     67 ; called from cold_start in hardware_init.asm 
                                     68 ; input:
                                     69 ;	none      
                                     70 ; output:
                                     71 ;   none
                                     72 ;---------------------------------------------
                           01C200    73 BAUD_RATE=115200 
      0081AC                         74 uart_init:
                                     75 ; enable UART clock
      0081AC 72 16 50 C7      [ 1]   76 	bset CLK_PCKENR1,#UART_PCKEN
                                     77 ; get BRR value from table 
      0081B0 35 0B 52 43      [ 1]   78 	mov UART_BRR2,#0xB 
      0081B4 35 08 52 42      [ 1]   79 	mov UART_BRR1,#0x8 
      0081B8 72 5F 52 41      [ 1]   80     clr UART_DR
      0081BC 35 2C 52 45      [ 1]   81 	mov UART_CR2,#((1<<UART_CR2_TEN)|(1<<UART_CR2_REN)|(1<<UART_CR2_RIEN));
      0081C0 72 5F 00 48      [ 1]   82     clr rx_head 
      0081C4 72 5F 00 49      [ 1]   83 	clr rx_tail
      0081C8 81               [ 4]   84 	ret
                                     85 
                                     86 
                                     87 ;---------------------------------
                                     88 ; uart_putc
                                     89 ; send a character via UART
                                     90 ; input:
                                     91 ;    A  	character to send
                                     92 ;---------------------------------
      0081C9                         93 uart_putc:: 
      0081C9 72 0F 52 40 FB   [ 2]   94 	btjf UART_SR,#UART_SR_TXE,.
      0081CE C7 52 41         [ 1]   95 	ld UART_DR,a 
      0081D1 81               [ 4]   96 	ret 
                                     97 
                                     98 ;------------------------------
                                     99 ; send line feed ASCII 
                                    100 ; to terminal 
                                    101 ;-------------------------------
      0081D2                        102 uart_new_line:
      0081D2 A6 0A            [ 1]  103 	ld a,#LF
      0081D4 20 F3            [ 2]  104 	jra uart_putc 
                                    105 
                                    106 ;--------------------------
                                    107 ; send carriage return 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 43.
Hexadecimal [24-Bits]



                                    108 ; to terminal
                                    109 ;--------------------------
      0081D6                        110 uart_cr:
      0081D6 A6 0D            [ 1]  111 	ld a,#CR 
      0081D8 20 EF            [ 2]  112 	jra uart_putc 
                                    113 
                                    114 
                                    115 ;-------------------------
                                    116 ; delete character left 
                                    117 ;-------------------------
      0081DA                        118 uart_delback:
      0081DA A6 08            [ 1]  119 	ld a,#BS 
      0081DC CD 81 C9         [ 4]  120 	call uart_putc  
      0081DF A6 20            [ 1]  121 	ld a,#SPACE 
      0081E1 CD 81 C9         [ 4]  122 	call uart_putc 
      0081E4 A6 08            [ 1]  123 	ld a,#BS 
      0081E6 CD 81 C9         [ 4]  124 	call uart_putc 
      0081E9 81               [ 4]  125 	ret 
                                    126 
                                    127 ;------------------------
                                    128 ; clear VT10x terminal 
                                    129 ; screeen 
                                    130 ;------------------------
      0081EA                        131 uart_cls:
      0081EA 88               [ 1]  132 	push a 
      0081EB A6 1B            [ 1]  133 	ld a,#ESC 
      0081ED CD 81 C9         [ 4]  134 	call uart_putc 
      0081F0 A6 63            [ 1]  135 	ld a,#'c 
      0081F2 CD 81 C9         [ 4]  136 	call uart_putc 
      0081F5 84               [ 1]  137 	pop a 
      0081F6 81               [ 4]  138 	ret 
                                    139 
                                    140 ;--------------------
                                    141 ; send blank character 
                                    142 ; to UART 
                                    143 ;---------------------
      0081F7                        144 uart_space:
      0081F7 A6 20            [ 1]  145 	ld a,#SPACE 
      0081F9 CD 81 C9         [ 4]  146 	call uart_putc 
      0081FC 81               [ 4]  147 	ret 
                                    148 
                                    149 
                                    150 
                                    151 ;---------------------------------
                                    152 ; Query for character in rx_queue
                                    153 ; input:
                                    154 ;   none 
                                    155 ; output:
                                    156 ;   A     0 no charcter available
                                    157 ;   Z     1 no character available
                                    158 ;---------------------------------
      0081FD                        159 qgetc::
      0081FD                        160 uart_qgetc::
      00017D                        161 	_ldaz rx_head 
      0081FD B6 48                    1     .byte 0xb6,rx_head 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 44.
Hexadecimal [24-Bits]



      0081FF C1 00 49         [ 1]  162 	cp a,rx_tail 
      008202 81               [ 4]  163 	ret 
                                    164 
                                    165 ;---------------------------------
                                    166 ; wait character from UART 
                                    167 ; input:
                                    168 ;   none
                                    169 ; output:
                                    170 ;   A 			char  
                                    171 ;--------------------------------	
      008203                        172 getc:: ;console input
      008203                        173 uart_getc::
      008203 CD 81 FD         [ 4]  174 	call uart_qgetc
      008206 27 FB            [ 1]  175 	jreq uart_getc 
      008208 89               [ 2]  176 	pushw x 
                                    177 ;; rx_queue must be in page 0 	
      008209 A6 08            [ 1]  178 	ld a,#rx_queue
      00820B CB 00 48         [ 1]  179 	add a,rx_head 
      00820E 5F               [ 1]  180 	clrw x  
      00820F 97               [ 1]  181 	ld xl,a 
      008210 F6               [ 1]  182 	ld a,(x)
      008211 88               [ 1]  183 	push a
      000192                        184 	_ldaz rx_head 
      008212 B6 48                    1     .byte 0xb6,rx_head 
      008214 4C               [ 1]  185 	inc a 
      008215 A4 3F            [ 1]  186 	and a,#RX_QUEUE_SIZE-1
      000197                        187 	_straz rx_head 
      008217 B7 48                    1     .byte 0xb7,rx_head 
      008219 84               [ 1]  188 	pop a  
      00821A 85               [ 2]  189 	popw x
      00821B 81               [ 4]  190 	ret 
                                    191 
                                    192 
                                    193 ;--------------------------
                                    194 ; manange control character 
                                    195 ; before calling uart_putc 
                                    196 ; input:
                                    197 ;    A    character 
                                    198 ;---------------------------
      00821C                        199 uart_print_char:
      00821C A1 08            [ 1]  200 	cp a,#BS 
      00821E 26 05            [ 1]  201 	jrne 1$
      008220 CD 81 DA         [ 4]  202 	call uart_delback 
      008223 20 03            [ 2]  203 	jra 9$ 
      008225                        204 1$:
      008225 CD 81 C9         [ 4]  205 	call uart_putc
      008228                        206 9$:
      008228 81               [ 4]  207 	ret 
                                    208 
                                    209 
                                    210 ;------------------------------
                                    211 ;  send string to uart 
                                    212 ; input:
                                    213 ;    X    *string 
                                    214 ; output:
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 45.
Hexadecimal [24-Bits]



                                    215 ;    X    *after string 
                                    216 ;------------------------------
      008229                        217 uart_puts:
      008229 88               [ 1]  218 	push a 
      00822A F6               [ 1]  219 1$: ld a,(x)
      00822B 27 06            [ 1]  220 	jreq 9$ 
      00822D CD 82 1C         [ 4]  221 	call uart_print_char  
      008230 5C               [ 1]  222 	incw x 
      008231 20 F7            [ 2]  223 	jra 1$ 
      008233 5C               [ 1]  224 9$: incw x 
      008234 84               [ 1]  225 	pop a 
      008235 81               [ 4]  226 	ret 
                                    227 
                                    228 ;-------------------------------
                                    229 ; print integer in hexadicimal
                                    230 ; input:
                                    231 ;    X 
                                    232 ;------------------------------- 
      008236                        233 uart_print_hex:
      008236 89               [ 2]  234 	pushw x 
      008237 88               [ 1]  235 	push a 
      008238 9E               [ 1]  236 	ld a,xh 
      008239 CD 82 48         [ 4]  237 	call uart_print_hex_byte 
      00823C 9F               [ 1]  238 	ld a,xl 
      00823D CD 82 48         [ 4]  239 	call uart_print_hex_byte 
      008240 A6 20            [ 1]  240 	ld a,#SPACE 
      008242 CD 81 C9         [ 4]  241 	call uart_putc 
      008245 84               [ 1]  242 	pop a 
      008246 85               [ 2]  243 	popw x 
      008247 81               [ 4]  244 	ret 
                                    245 
                                    246 ;----------------------
                                    247 ; print hexadecimal byte 
                                    248 ; input:
                                    249 ;    A    byte to print 
                                    250 ;-----------------------
      008248                        251 uart_print_hex_byte:
      008248 88               [ 1]  252 	push a 
      008249 4E               [ 1]  253 	swap a 
      00824A CD 82 58         [ 4]  254 	call hex_digit 
      00824D CD 81 C9         [ 4]  255 	call uart_putc 
      008250 84               [ 1]  256 	pop a 
      008251 CD 82 58         [ 4]  257 	call hex_digit 
      008254 CD 81 C9         [ 4]  258 	call uart_putc 
      008257 81               [ 4]  259 	ret 
                                    260 
                                    261 ;---------------------------
                                    262 ; convert to hexadecimal digit 
                                    263 ; input:
                                    264 ;    A    value to convert 
                                    265 ; output:
                                    266 ;    A    hex digit character 
                                    267 ;-----------------------------
      008258                        268 hex_digit:
      008258 A4 0F            [ 1]  269 	and a,#15 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 46.
Hexadecimal [24-Bits]



      00825A AB 30            [ 1]  270 	add a,#'0 
      00825C A1 3A            [ 1]  271 	cp a,#'9+1 
      00825E 2B 02            [ 1]  272 	jrmi 9$ 
      008260 AB 07            [ 1]  273 	add a,#7 
      008262 81               [ 4]  274 9$: ret 
                                    275 
                                    276 
                                    277 ;------------------------------
                                    278 ; print integer in decimal 
                                    279 ; input:
                                    280 ;    X   integer 
                                    281 ;-----------------------------
                           000001   282 	DCNT=1 
                           000002   283 	NEG=2
                           000003   284 	DIGITS=3
                           000007   285 	VSIZE = 7 
      008263                        286 uart_print_int:
      008263 90 89            [ 2]  287 	pushw y 
      0001E5                        288 	_vars VSIZE
      008265 52 07            [ 2]    1     sub sp,#VSIZE 
      008267 0F 01            [ 1]  289 	clr (DCNT,sp) 
      008269 90 96            [ 1]  290 	ldw y,sp 
      00826B 72 A9 00 07      [ 2]  291 	addw y,#VSIZE 
      00826F 5D               [ 2]  292 	tnzw x 
      008270 2A 03            [ 1]  293 	jrpl 1$ 
      008272 03 02            [ 1]  294 	cpl (NEG,sp) 
      008274 50               [ 2]  295 	negw x 
      008275                        296 1$:
      008275 A6 0A            [ 1]  297 	ld a,#10 
      008277 62               [ 2]  298 	div x,a 
      008278 90 F7            [ 1]  299 	ld (y),a 
      00827A 90 5A            [ 2]  300 	decw y
      00827C 0C 01            [ 1]  301 	inc (DCNT,sp) 
      00827E 5D               [ 2]  302 	tnzw x 
      00827F 26 F4            [ 1]  303 	jrne 1$ 
      008281 0D 02            [ 1]  304 	tnz (NEG,sp)
      008283 27 05            [ 1]  305 	jreq 2$ 
      008285 A6 2D            [ 1]  306 	ld a,#'- 
      008287 CD 81 C9         [ 4]  307 	call uart_putc  
      00828A                        308 2$: 
      00828A 90 5C            [ 1]  309 	incw y 
      00828C 90 F6            [ 1]  310 	ld a,(y)
      00828E AB 30            [ 1]  311 	add a,#'0 
      008290 CD 81 C9         [ 4]  312 	call uart_putc 
      008293 0A 01            [ 1]  313 	dec (DCNT,sp)
      008295 26 F3            [ 1]  314 	jrne 2$ 	
      000217                        315 	_drop VSIZE 
      008297 5B 07            [ 2]    1     addw sp,#VSIZE 
      008299 90 85            [ 2]  316 	popw y 
      00829B 81               [ 4]  317 	ret 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 47.
Hexadecimal [24-Bits]



                                      1 ;;
                                      2 ; Copyright Jacques Deschênes 2025 
                                      3 ; This file is part of pomme_1+ 
                                      4 ;
                                      5 ;     pomme_1+ is free software: you can redistribute it and/or modify
                                      6 ;     it under the terms of the GNU General Public License as published by
                                      7 ;     the Free Software Foundation, either version 3 of the License, or
                                      8 ;     (at your option) any later version.
                                      9 ;
                                     10 ;     pomme_1+ is distributed in the hope that it will be useful,
                                     11 ;     but WITHOUT ANY WARRANTY; without even the implied warranty of
                                     12 ;     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
                                     13 ;     GNU General Public License for more details.
                                     14 ;
                                     15 ;     You should have received a copy of the GNU General Public License
                                     16 ;     along with pomme_1+.  If not, see <http://www.gnu.org/licenses/>.
                                     17 ;;
                                     18 
                                     19 ;-------------------------------
                                     20 ;  SPI peripheral support
                                     21 ;  low level driver 
                                     22 ;--------------------------------
                                     23 
                                     24 	.module SPI
                                     25 
                                     26 
                                     27 
                                     28 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                                     29 ; W25Q FLASH memory parameters 
                                     30 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                           000100    31 W25Q_PAGE_SIZE=256 ; bytes 
                           001000    32 W25Q_ERASE_BLOCK_SIZE=4096 ; byts 
                           000003    33 W25Q_ADR_SIZE=3 ; address size in bytes 
                                     34 ;-----------------------------------------------
                                     35 ; W25Q80DV programming
                                     36 ; 1) set /CS TO 0  
                                     37 ; 2) enable FLASH WRITE with WREN cmd 
                                     38 ; 3) send 24 bits address most significant byte first  
                                     39 ; 4) send data bytes up to W25Q_PAGE_SIZE 
                                     40 ; 5) rise /CS to 1  
                                     41 ;-----------------------------------------------
                           001000    42 W25Q_SECTOR_SIZE=4096 ; bytes 
                           000000    43 SR1_BUSY=0  ; busy writting/erasing bit position in SR1   
                           000001    44 SR1_WEL=1  ; write enable bit position in SR1  
                                     45 ; W25Q commands 
                           000006    46 W25Q_WREN=6      ; set WEL bit 
                           000003    47 W25Q_READ=3  ; can read sequential address no size limit.
                           000002    48 W25Q_WRITE=2 ; program up to W25_PAGE_SIZE at once.
                           000020    49 W25Q_B4K_ERASE=0x20   ; erase 4KB block   
                           000052    50 W25Q_B32K_ERASE=0x52 ; erase 32KB block 
                           0000D8    51 W25Q_B64K_ERASE=0XD8 ; erase 64KB block 
                           0000C7    52 W25Q_CHIP_ERASE=0xC7   ; whole memory  
                           000005    53 W25Q_READ_SR1=5 ; read status register 1
                           000035    54 W25Q_READ_SR2=0x35 ; read status register 2
                           000090    55 W25Q_MFG_ID=0x90 ; read manufacturer device id 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 48.
Hexadecimal [24-Bits]



                           000013    56 W25Q_080_ID=0x13 ; device id for 1MB type 
                           000017    57 W25Q_128_ID=0x17 ; device id for 16MB type  
                                     58 
                                     59 ; xram functions 
                           000003    60 XRAM_READ=3 
                           000002    61 XRAM_WRITE=2 
                                     62 
                                     63     .area CODE 
                                     64 
                                     65 
                                     66 ;---------------------------------
                                     67 ; enable SPI peripheral to maximum 
                                     68 ; frequency = Fspi=Fmstr/2 
                                     69 ; input:
                                     70 ;    none  
                                     71 ; output:
                                     72 ;    none 
                                     73 ;--------------------------------- 
      00829C                         74 spi_init::
      00829C 72 12 50 C7      [ 1]   75 	bset CLK_PCKENR1,#CLK_PCKENR1_SPI ; enable clock signal 
                                     76 ; configure ~CS pins as output open drain  
      0082A0 A6 1E            [ 1]   77 	ld a,#(1<<SPI_CS0)+(1<<SPI_CS1)+(1<<SPI_CS2)+(1<<SPI_CS3)
      0082A2 C7 50 0C         [ 1]   78 	ld SPI_PORT_DDR,a ; pins as output 
      0082A5 C7 50 0A         [ 1]   79 	ld SPI_PORT_ODR,a ; high level 
      0082A8 C7 50 0E         [ 1]   80 	ld SPI_PORT_CR2,a ; fast speed 
                                     81 ; interrupts not used 
      0082AB 72 5F 52 02      [ 1]   82 	clr SPI_ICR ; no interrupt enabled 
                                     83 ; software controlled MSTR/SLAVE mode 
      0082AF A6 03            [ 1]   84 	ld a,#(1<<SPI_CR2_SSM)+(1<<SPI_CR2_SSI)
      0082B1 C7 52 01         [ 1]   85 	ld SPI_CR2,a 
                                     86 ; configure SPI as master mode 0 and enable.	
      0082B4 A6 44            [ 1]   87 	ld a,#(1<<SPI_CR1_MSTR)+(1<<SPI_CR1_SPE)
      0082B6 C7 52 00         [ 1]   88 	ld SPI_CR1,a 
                                     89 ; clear status register 
      0082B9 72 0E 52 03 FB   [ 2]   90 1$: btjt SPI_SR,#SPI_SR_BSY,.
      0082BE 72 01 52 03 04   [ 2]   91 	btjf SPI_SR,#SPI_SR_RXNE,9$
      0082C3 A6 04            [ 1]   92 	ld a,#SPI_DR 
      0082C5 20 F2            [ 2]   93 	jra 1$ 
                                     94 ;select default device 
      0082C7 A6 03            [ 1]   95 9$:	ld a,#FLASH0  ; internal flash memory 
      0082C9 CD 83 1E         [ 4]   96 	call spi_select_device
      0082CC 81               [ 4]   97 	ret 
                                     98 
                                     99 ;----------------------------
                                    100 ; disable SPI peripheral 
                                    101 ;----------------------------
      0082CD                        102 spi_disable::
                                    103 ; wait spi idle 
      0082CD 72 03 52 03 FB   [ 2]  104 	btjf SPI_SR,#SPI_SR_TXE,. 
      0082D2 72 01 52 03 FB   [ 2]  105 	btjf SPI_SR,#SPI_SR_RXNE,. 
      0082D7 72 0E 52 03 FB   [ 2]  106 	btjt SPI_SR,#SPI_SR_BSY,.
      0082DC 72 1D 52 00      [ 1]  107 	bres SPI_CR1,#SPI_CR1_SPE
      0082E0 72 13 50 C7      [ 1]  108 	bres CLK_PCKENR1,#CLK_PCKENR1_SPI 
      0082E4 72 17 50 0C      [ 1]  109 	bres SPI_PORT_DDR,#SPI_CS0 
      0082E8 72 19 50 0C      [ 1]  110 	bres SPI_PORT_DDR,#SPI_CS1  
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 49.
Hexadecimal [24-Bits]



      0082EC 81               [ 4]  111 	ret 
                                    112 
                                    113 ;------------------------
                                    114 ; clear SPI error 
                                    115 ;-----------------------
      0082ED                        116 spi_clear_error::
      0082ED C6 52 03         [ 1]  117 	ld a,SPI_SR 
      0082F0 C6 52 04         [ 1]  118 	ld a,SPI_DR 
      0082F3 81               [ 4]  119 1$: ret 
                                    120 
                                    121 ;----------------------
                                    122 ; send byte 
                                    123 ; input:
                                    124 ;   A     byte to send 
                                    125 ; output:
                                    126 ;   A     byte received 
                                    127 ;----------------------
      0082F4                        128 spi_send_byte::
      0082F4 72 03 52 03 FB   [ 2]  129 	btjf SPI_SR,#SPI_SR_TXE,.
      0082F9 C7 52 04         [ 1]  130 	ld SPI_DR,a
      0082FC 72 01 52 03 FB   [ 2]  131 	btjf SPI_SR,#SPI_SR_RXNE,.  
      008301 C6 52 04         [ 1]  132 	ld a,SPI_DR 
      008304 81               [ 4]  133 	ret 
                                    134 
                                    135 ;------------------------------
                                    136 ;  receive SPI byte 
                                    137 ; output:
                                    138 ;    A 
                                    139 ;------------------------------
      008305                        140 spi_rcv_byte::
      008305 4F               [ 1]  141 	clr a 
      008306 72 01 52 03 E9   [ 2]  142 	btjf SPI_SR,#SPI_SR_RXNE,spi_send_byte 
      00830B C6 52 04         [ 1]  143 	ld a,SPI_DR 
      00830E 81               [ 4]  144 	ret
                                    145 
                                    146 ;----------------------------
                                    147 ;  create bit mask
                                    148 ;  input:
                                    149 ;     A     bit 
                                    150 ;  output:
                                    151 ;     A     2^bit 
                                    152 ;-----------------------------
      00830F                        153 create_bit_mask::
      00830F 88               [ 1]  154 	push a 
      008310 A6 01            [ 1]  155 	ld a,#1 
      008312 0D 01            [ 1]  156 	tnz (1,sp)
      008314 27 05            [ 1]  157 	jreq 9$
      008316                        158 1$:
      008316 48               [ 1]  159 	sll a 
      008317 0A 01            [ 1]  160 	dec (1,sp)
      008319 26 FB            [ 1]  161 	jrne 1$
      00029B                        162 9$: _drop 1
      00831B 5B 01            [ 2]    1     addw sp,#1 
      00831D 81               [ 4]  163 	ret 
                                    164 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 50.
Hexadecimal [24-Bits]



                                    165 ;-------------------------------
                                    166 ; SPI select device  
                                    167 ; input:
                                    168 ;   A    device FLASH0 || 
                                    169 ;--------------------------------
      00831E                        170 spi_select_device::
      00831E CD 83 0F         [ 4]  171 	call create_bit_mask
      0002A1                        172 	_straz spi_device
      008321 B7 4B                    1     .byte 0xb7,spi_device 
      008323 CD 84 4F         [ 4]  173 	call device_id
      008326 A1 13            [ 1]  174 	cp a,#W25Q_080_ID
      008328 26 06            [ 1]  175 	jrne 1$ 
      00832A 35 01 00 4A      [ 1]  176 	mov device_size,#1 
                                    177 ;	ld a,#1  ; MB
                                    178 ;	_straz device_size  
      00832E 20 08            [ 2]  179 	jra 9$
      008330 A1 17            [ 1]  180 1$:	cp a,#W25Q_128_ID
      008332 26 04            [ 1]  181 	jrne 9$ 
      008334 A6 10            [ 1]  182 	ld a,#16
      0002B6                        183 	_straz device_size ; 16MB  
      008336 B7 4A                    1     .byte 0xb7,device_size 
      008338                        184 9$: 
      008338 81               [ 4]  185 	ret 
                                    186 
                                    187 ;--------------------------
                                    188 ; open selected channel 
                                    189 ;--------------------------
      008339                        190 open_channel:
      008339 88               [ 1]  191 	push a 
      0002BA                        192 	_ldaz spi_device 
      00833A B6 4B                    1     .byte 0xb6,spi_device 
      00833C 43               [ 1]  193 	cpl a  
      00833D C4 50 0A         [ 1]  194 	and a,SPI_PORT_ODR 
      008340 C7 50 0A         [ 1]  195 	ld SPI_PORT_ODR,a 
      008343 84               [ 1]  196 	pop a  
      008344 81               [ 4]  197 	ret 
                                    198 
                                    199 
                                    200 ;------------------------------
                                    201 ; SPI deselect channel 
                                    202 ;-------------------------------
      008345                        203 close_channel::
      008345 88               [ 1]  204 	push a 
      008346 72 0E 52 03 FB   [ 2]  205 	btjt SPI_SR,#SPI_SR_BSY,.
      0002CB                        206 	_ldaz spi_device 
      00834B B6 4B                    1     .byte 0xb6,spi_device 
      00834D CA 50 0A         [ 1]  207 	or a,SPI_PORT_ODR 
      008350 C7 50 0A         [ 1]  208 	ld SPI_PORT_ODR,a 
      008353 84               [ 1]  209 	pop a  
      008354 81               [ 4]  210 	ret 
                                    211 
                                    212 ;-----------------------------
                                    213 ; send 24 bits address to 
                                    214 ; opened device,  
                                    215 ; input:
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 51.
Hexadecimal [24-Bits]



                                    216 ;   farptr   address 
                                    217 ;------------------------------
      008355                        218 spi_send_addr::
      0002D5                        219 	_ldaz farptr 
      008355 B6 02                    1     .byte 0xb6,farptr 
      008357 CD 82 F4         [ 4]  220 	call spi_send_byte 
      0002DA                        221 	_ldaz ptr16 
      00835A B6 03                    1     .byte 0xb6,ptr16 
      00835C CD 82 F4         [ 4]  222 	call spi_send_byte 
      0002DF                        223 	_ldaz ptr8 
      00835F B6 04                    1     .byte 0xb6,ptr8 
      008361 CD 82 F4         [ 4]  224 	call spi_send_byte 
      008364 81               [ 4]  225 	ret 
                                    226 
                                    227 ;---------------------
                                    228 ; enable write to flash  
                                    229 ;----------------------
      008365                        230 flash_enable_write:
      008365 CD 83 39         [ 4]  231 	call open_channel 
      008368 A6 06            [ 1]  232 	ld a,#W25Q_WREN 
      00836A CD 82 F4         [ 4]  233 	call spi_send_byte 
      00836D CD 83 45         [ 4]  234 	call close_channel 
      008370 81               [ 4]  235 	ret 
                                    236 
                                    237 ;----------------------------
                                    238 ;  read flash status register
                                    239 ;----------------------------
      008371                        240 flash_read_status:
      008371 CD 83 39         [ 4]  241 	call open_channel 
      008374 A6 05            [ 1]  242 	ld a,#W25Q_READ_SR1 
      008376 CD 82 F4         [ 4]  243 	call spi_send_byte
      008379 CD 83 05         [ 4]  244 	call spi_rcv_byte 
      00837C CD 83 45         [ 4]  245 	call close_channel
      00837F 81               [ 4]  246 	ret
                                    247 
                                    248 ;------------------------------
                                    249 ;  poll busy bit in SR1 
                                    250 ;  of selected channel 
                                    251 ;  until operation end 
                                    252 ;-------------------------------
      008380                        253 busy_polling:
      008380 CD 83 71         [ 4]  254 1$:	call flash_read_status 
      008383 A5 01            [ 1]  255 	bcp a,#(1<<SR1_BUSY)
      008385 26 F9            [ 1]  256 	jrne 1$
      008387 81               [ 4]  257 	ret 
                                    258 
                                    259 ;----------------------------
                                    260 ; write data to W25Q80DV
                                    261 ; selected device  
                                    262 ; input:
                                    263 ;   farptr  address 
                                    264 ;   A       byte count, 0 == 256
                                    265 ;   X       buffer address 
                                    266 ; output:
                                    267 ;   none 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 52.
Hexadecimal [24-Bits]



                                    268 ;----------------------------
                           000001   269 	BUF_ADR=1 
                           000003   270 	COUNT=BUF_ADR+2
                           000003   271 	VSIZE=3 
      008388                        272 flash_write::
      008388 88               [ 1]  273 	push a 
      008389 89               [ 2]  274 	pushw x
      00838A CD 83 65         [ 4]  275 	call flash_enable_write
      00838D CD 83 39         [ 4]  276 	call open_channel 
      008390 A6 02            [ 1]  277 	ld a,#W25Q_WRITE 
      008392 CD 82 F4         [ 4]  278 	call spi_send_byte 
      008395 CD 83 55         [ 4]  279 	call spi_send_addr 
      008398 1E 01            [ 2]  280 	ldw x,(BUF_ADR,sp)
      00839A                        281 1$:
      00839A F6               [ 1]  282 	ld a,(x)
      00839B CD 82 F4         [ 4]  283 	call spi_send_byte
      00839E 5C               [ 1]  284 	incw x
      00839F 0A 03            [ 1]  285 	dec (COUNT,sp) 
      0083A1 26 F7            [ 1]  286 	jrne 1$ 
      0083A3                        287 6$: 
      0083A3 CD 83 45         [ 4]  288 	call close_channel
      0083A6 CD 83 80         [ 4]  289 	call busy_polling ; wait completion 
      000329                        290 	_drop VSIZE
      0083A9 5B 03            [ 2]    1     addw sp,#VSIZE 
      0083AB 81               [ 4]  291 	ret 
                                    292 
                                    293 ;-------------------------- 
                                    294 ; read bytes from flash 
                                    295 ; memory in buffer 
                                    296 ; input:
                                    297 ;   farptr flash memory address  
                                    298 ;   x     count, {0..4095},0=4096 bytes 
                                    299 ;   y     buffer addr
                                    300 ;---------------------------
      0083AC                        301 flash_read::
      0083AC 90 89            [ 2]  302 	pushw y 
      0083AE 89               [ 2]  303 	pushw x 
      0083AF CD 83 39         [ 4]  304 	call open_channel
      0083B2 A6 03            [ 1]  305 	ld a,#W25Q_READ 
      0083B4 CD 82 F4         [ 4]  306 	call spi_send_byte
      0083B7 CD 83 55         [ 4]  307 	call spi_send_addr  
      0083BA CD 83 05         [ 4]  308 1$: call spi_rcv_byte 
      0083BD 90 F7            [ 1]  309 	ld (y),a 
      0083BF 90 5C            [ 1]  310 	incw y 
      0083C1 1E 01            [ 2]  311 	ldw x,(1,sp)
      0083C3 5A               [ 2]  312 	decw x
      0083C4 1F 01            [ 2]  313 	ldw (1,sp),x 
      0083C6 26 F2            [ 1]  314 	jrne 1$ 
      0083C8                        315 9$: 
      0083C8 CD 83 45         [ 4]  316 	call close_channel
      00034B                        317 	_drop 2 
      0083CB 5B 02            [ 2]    1     addw sp,#2 
      0083CD 90 85            [ 2]  318 	popw y 
      0083CF 81               [ 4]  319 	ret 
                                    320 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 53.
Hexadecimal [24-Bits]



                                    321 ;--------------------
                                    322 ; return true if 
                                    323 ; page empty 
                                    324 ; input:
                                    325 ;    X   page# 
                                    326 ; output:
                                    327 ;    A   -1 true||0 false 
                                    328 ;    X   not changed 
                                    329 ;-------------------------
      0083D0                        330 flash_page_empty:
      0083D0 89               [ 2]  331 	pushw x 
      0083D1 CD 84 6A         [ 4]  332 	call page_addr 
      0083D4 CD 83 39         [ 4]  333 	call open_channel
      0083D7 A6 03            [ 1]  334 	ld a,#W25Q_READ  
      0083D9 CD 82 F4         [ 4]  335 	call spi_send_byte 
      0083DC CD 83 55         [ 4]  336 	call spi_send_addr
      0083DF 4B 00            [ 1]  337 	push #0 
      0083E1 CD 83 05         [ 4]  338 1$:	call spi_rcv_byte 
      0083E4 A1 FF            [ 1]  339 	cp a,#0xff 
      0083E6 26 08            [ 1]  340 	jrne 8$ 
      0083E8 0A 01            [ 1]  341 	dec (1,sp)
      0083EA 26 F5            [ 1]  342 	jrne 1$ 
      0083EC 03 01            [ 1]  343 	cpl (1,sp) 
      0083EE 20 02            [ 2]  344 	jra 9$
      0083F0 0F 01            [ 1]  345 8$: clr (1,sp) 
      0083F2                        346 9$: 
      0083F2 CD 83 45         [ 4]  347 	call close_channel
      0083F5 84               [ 1]  348 	pop a 
      0083F6 85               [ 2]  349 	popw x 
      0083F7 81               [ 4]  350 	ret 
                                    351 
                                    352 ;--------------------------
                                    353 ; compute 4KB block address 
                                    354 ; input:
                                    355 ;    X   block number {0..255}
                                    356 ; output:
                                    357 ;    farptr  address 
                                    358 ;--------------------------
      0083F8                        359 b4k_address:
      0083F8 9F               [ 1]  360 	ld a,xl
      0083F9 88               [ 1]  361 	push a
      0083FA A4 0F            [ 1]  362 	and a,#15
      0083FC 4E               [ 1]  363 	swap a  
      0083FD 95               [ 1]  364 	ld xh,a 
      0083FE 4F               [ 1]  365 	clr a 
      0083FF 97               [ 1]  366 	ld xl,a 
      008400 84               [ 1]  367 	pop a 
      008401 A4 F0            [ 1]  368 	and a,#0xf0 
      008403 4E               [ 1]  369 	swap a 
                                    370 ; A:X=X*4096
      008404 20 08            [ 2]  371 	jra stor_addr 
                                    372 
                                    373 ;---------------------------
                                    374 ; compute 32KB block address 
                                    375 ; input:
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 54.
Hexadecimal [24-Bits]



                                    376 ;    X    block number {0..31}
                                    377 ; output:
                                    378 ;    farptr   address 
                                    379 ;----------------------------
      008406                        380 b32k_address:
      008406 4F               [ 1]  381 	clr a 
      008407 5E               [ 1]  382 	swapw x ; X*256 
      008408 54               [ 2]  383 	srlw x  ; X/2  
      008409 02               [ 1]  384 	rlwa x  ; A:X =X*32767
      00840A 20 02            [ 2]  385 	jra stor_addr  
                                    386 
                                    387 ;---------------------------
                                    388 ; compute 64KB block address 
                                    389 ; input:
                                    390 ;    X    block number {0..15}
                                    391 ; output:
                                    392 ;    farptr   address 
                                    393 ;----------------------------
      00840C                        394 b64k_address:
      00840C 9F               [ 1]  395 	ld a,xl
      00840D 5F               [ 1]  396 	clrw x  ; A:X=X*65536
      00840E                        397 stor_addr:	 
      00038E                        398 	_straz farptr 
      00840E B7 02                    1     .byte 0xb7,farptr 
      000390                        399 	_strxz ptr16 
      008410 BF 03                    1     .byte 0xbf,ptr16 
      008412 81               [ 4]  400 	ret 
                                    401 
                                    402 
                                    403 ;----------------------
                                    404 ; erase 32KB|64KB block  
                                    405 ; device already selected 
                                    406 ; input:
                                    407 ;   A    W25Q_B4K_ERASE||W25Q_B32K_ERASE||W25Q_B64K_ERASE 
                                    408 ;   X    block number 
                                    409 ;			4KB->{0.255}
                                    410 ;			32KB->{0..31}
                                    411 ;			64KB->{0..15}
                                    412 ; output:
                                    413 ;   none 
                                    414 ;----------------------
      008413                        415 flash_block_erase:
      008413 88               [ 1]  416 	push a 
      008414 CD 83 65         [ 4]  417 	call flash_enable_write
      008417 A1 20            [ 1]  418 	cp a,#W25Q_B4K_ERASE 
      008419 26 05            [ 1]  419 	jrne 1$ 
      00841B CD 83 F8         [ 4]  420 	call b4k_address
      00841E 20 0C            [ 2]  421 	jra flash_erase 
      008420                        422 1$:
      008420 A1 52            [ 1]  423 	cp a,#W25Q_B32K_ERASE
      008422 26 05            [ 1]  424 	jrne 2$ 
      008424 CD 84 06         [ 4]  425 	call b32k_address
      008427 20 03            [ 2]  426 	jra flash_erase 
      008429                        427 2$:
      008429 CD 84 0C         [ 4]  428 	call b64k_address 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 55.
Hexadecimal [24-Bits]



      00842C                        429 flash_erase: 
      00842C 84               [ 1]  430 	pop a 
      00842D CD 83 39         [ 4]  431 	call open_channel 
      008430 CD 82 F4         [ 4]  432 	call spi_send_byte 
      008433 CD 83 55         [ 4]  433 	call spi_send_addr 
      008436 CD 83 45         [ 4]  434 	call close_channel
      008439 CD 83 80         [ 4]  435 	call busy_polling
      00843C 81               [ 4]  436 	ret 
                                    437 
                                    438 
                                    439 ;-----------------------------
                                    440 ; erase whole flash memory 
                                    441 ;-----------------------------
      00843D                        442 flash_chip_erase::
      00843D CD 83 65         [ 4]  443 	call flash_enable_write 
      008440 CD 83 39         [ 4]  444 	call open_channel 
      008443 A6 C7            [ 1]  445 	ld a,#W25Q_CHIP_ERASE
      008445 CD 82 F4         [ 4]  446 	call spi_send_byte  
      008448 CD 83 45         [ 4]  447 	call close_channel
      00844B CD 83 80         [ 4]  448 	call busy_polling
      00844E 81               [ 4]  449 	ret 
                                    450 
                                    451 ;----------------------------
                                    452 ; read device ID 
                                    453 ; cmd: W25Q_MFG_ID 
                                    454 ;---------------------------
      00844F                        455 device_id:
      0003CF                        456 	_clrz farptr 
      00844F 3F 02                    1     .byte 0x3f, farptr 
      0003D1                        457 	_clrz ptr16 
      008451 3F 03                    1     .byte 0x3f, ptr16 
      0003D3                        458 	_clrz ptr8 
      008453 3F 04                    1     .byte 0x3f, ptr8 
      008455 CD 83 39         [ 4]  459 	call open_channel 
      008458 A6 90            [ 1]  460 	ld a,#W25Q_MFG_ID
      00845A CD 82 F4         [ 4]  461 	call spi_send_byte 
      00845D CD 83 55         [ 4]  462 	call spi_send_addr
      008460 CD 83 05         [ 4]  463 	call spi_rcv_byte  
      008463 CD 83 05         [ 4]  464 	call spi_rcv_byte 
      008466 CD 83 45         [ 4]  465 	call close_channel 
      008469 81               [ 4]  466 	ret 
                                    467 
                                    468 ;---------------------------
                                    469 ; convert page number 
                                    470 ; to address addr=256*page#
                                    471 ; input:
                                    472 ;   X     page {0..511}
                                    473 ; ouput:
                                    474 ;   A:X    address
                                    475 ;   farptr address  
                                    476 ;---------------------------
      00846A                        477 page_addr:
      00846A 4F               [ 1]  478 	clr a 
      00846B 02               [ 1]  479 	rlwa x
      0003EC                        480 	_straz farptr 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 56.
Hexadecimal [24-Bits]



      00846C B7 02                    1     .byte 0xb7,farptr 
      0003EE                        481 	_strxz ptr16   
      00846E BF 03                    1     .byte 0xbf,ptr16 
      008470 81               [ 4]  482 	ret 
                                    483 
                                    484 ;----------------------------
                                    485 ; convert address to page#
                                    486 ; expect 256 bytes page  
                                    487 ; input:
                                    488 ;   farptr   address 
                                    489 ; output:
                                    490 ;   X       page  {0..4095}
                                    491 ;----------------------------
      008471                        492 addr_to_page::
      0003F1                        493 	_ldxz farptr 
      008471 BE 02                    1     .byte 0xbe,farptr 
      008473 81               [ 4]  494 	ret 
                                    495 
                                    496 ;;;;;;;;;;;;;;;;;;;;;;;
                                    497 ;;  XRAM  23LC1024 
                                    498 ;;  access 
                                    499 ;;;;;;;;;;;;;;;;;;;;;;;
                                    500 
                                    501 ;------------------------
                                    502 ; read from XRAM 
                                    503 ; input:
                                    504 ;    A:X   address  {0..131071}
                                    505 ;    Y     count   {0..4095}  
                                    506 ; output:
                                    507 ;    buffer  
                                    508 ;-------------------------
      008474                        509 xram_read:
      0003F4                        510     _straz farptr 
      008474 B7 02                    1     .byte 0xb7,farptr 
      0003F6                        511 	_strxz ptr16 
      008476 BF 03                    1     .byte 0xbf,ptr16 
      0003F8                        512 	_ldaz spi_device 
      008478 B6 4B                    1     .byte 0xb6,spi_device 
      00847A 88               [ 1]  513 	push a 
      00847B A6 04            [ 1]  514 	ld a,#XRAM
      00847D CD 83 1E         [ 4]  515 	call spi_select_device 
      008480 CD 83 39         [ 4]  516 	call open_channel 
      008483 AE 01 00         [ 2]  517 	ldw x,#flash_buffer
      008486 A6 03            [ 1]  518 	ld a,#XRAM_READ 
      008488 CD 82 F4         [ 4]  519 	call spi_send_byte
      00848B CD 83 55         [ 4]  520 	call spi_send_addr 
      00848E CD 83 05         [ 4]  521 1$: call spi_rcv_byte 
      008491 F7               [ 1]  522 	ld (x),a 
      008492 5C               [ 1]  523 	incw x 
      008493 90 5A            [ 2]  524 	decw y 
      008495 26 F7            [ 1]  525 	jrne 1$ 
      008497 CD 83 45         [ 4]  526 	call close_channel 
      00849A 84               [ 1]  527 	pop a 
      00849B CD 83 1E         [ 4]  528 	call spi_select_device
      00849E 81               [ 4]  529 	ret 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 57.
Hexadecimal [24-Bits]



                                    530 
                                    531 ;-------------------------------
                                    532 ; write to XRAM 
                                    533 ; input:
                                    534 ;    A:X   address  {0..131071}
                                    535 ;    Y     count   {0..4095}  
                                    536 ;    buffer  data to write   
                                    537 ;-------------------------------
      00849F                        538 xram_write:
      00041F                        539 	_straz farptr 
      00849F B7 02                    1     .byte 0xb7,farptr 
      000421                        540 	_strxz ptr16 
      0084A1 BF 03                    1     .byte 0xbf,ptr16 
      000423                        541 	_ldaz spi_device 
      0084A3 B6 4B                    1     .byte 0xb6,spi_device 
      0084A5 88               [ 1]  542 	push a 
      0084A6 A6 04            [ 1]  543 	ld a,#XRAM 
      0084A8 CD 83 1E         [ 4]  544 	call spi_select_device
      0084AB CD 83 39         [ 4]  545 	call open_channel 
      0084AE AE 01 00         [ 2]  546 	ldw x,#flash_buffer 
      0084B1 A6 02            [ 1]  547 	ld a,#XRAM_WRITE 
      0084B3 CD 82 F4         [ 4]  548 	call spi_send_byte
      0084B6 CD 83 55         [ 4]  549 	call spi_send_addr 
      0084B9 F6               [ 1]  550 1$: ld a,(x)
      0084BA CD 82 F4         [ 4]  551 	call spi_send_byte 
      0084BD 5C               [ 1]  552 	incw x 
      0084BE 90 5A            [ 2]  553 	decw y 
      0084C0 26 F7            [ 1]  554 	jrne 1$
      0084C2 CD 83 45         [ 4]  555 	call close_channel 
      0084C5 84               [ 1]  556 	pop a 
      0084C6 CD 83 1E         [ 4]  557 	call spi_select_device
      0084C9 81               [ 4]  558 	ret 
                                    559 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 58.
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
                                     19 ;-------------------------------------------------------------
                                     20 ; Parallel interface handshaking 
                                     21 ; reveiving:
                                     22 ; 	when the computer write un byte to PIA port A it signal it 
                                     23 ; 	by a pulse on CA2. The falling edge trigger an interrupt. 
                                     24 ; 	PBusIntHandler read the byte and store it in rx_queue.
                                     25 ; 	It signal that it is ready for next byte 
                                     26 ; 	by a pulse on CA1
                                     27 ; Transmitting:
                                     28 ;   To transmit to computer the drive wait that CA2 is low 
                                     29 ;   it write to ITF_ODR and pulse ITF_CTRL_CA1 to signal 
                                     30 ;   computer and store byte in PIA input register. 
                                     31 ;   The computer pulse CA2 to signal ready for next transmit. 
                                     32 ;
                                     33 ; The drive works in slave mode it stay idle until it receive 
                                     34 ; a command. 
                                     35 ;--------------------------------------------------------------
                                     36 
                                     37 ;----------------------------------
                                     38 ;    file system 
                                     39 ; file header:
                                     40 ;   sign field:  2 bytes .ascii "PB" 
                                     41 ;   program size: 1 word 
                                     42 ;   file name: 12 bytes 
                                     43 ;      name is 11 charaters maximum to be zero terminated  
                                     44 ;   data: n bytes 
                                     45 ;  
                                     46 ;   file sector is 256 bytes, this is 
                                     47 ;   minimum allocation unit.   
                                     48 ;----------------------------------
                                     49 
                                     50     .module FILES
                                     51 
                                     52 	.area CODE 
                                     53 
                                     54 ;--------------------------------
                                     55 ; data received from computer 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 59.
Hexadecimal [24-Bits]



                                     56 ; store it in queue
                                     57 ; and signal ready for next 
                                     58 ; byte  
                                     59 ;--------------------------------
      0084CA                         60 PBusIntHandler:
      0084CA 72 12 50 05      [ 1]   61 	bset ITF_CTRL_ODR,#ITF_CA1
      0084CE 72 01 00 05 07   [ 2]   62 	btjf flags,#FTX,1$ 
                                     63 ; delay for pulse length
                                     64 ; ~1µsec 
      0084D3 A6 05            [ 1]   65 	ld a,#5 
      0084D5 4A               [ 1]   66 0$: dec a 
      0084D6 26 FD            [ 1]   67 	jrne 0$ 
      0084D8 20 06            [ 2]   68 	jra 2$ 
      0084DA                         69 1$:
      0084DA C6 50 10         [ 1]   70 	ld a,ITF_IDR
      0084DD CD 81 9A         [ 4]   71 	call store_byte_in_queue
      0084E0                         72 2$:	
      0084E0 72 13 50 05      [ 1]   73 	bres ITF_CTRL_ODR,#ITF_CA1
      0084E4 80               [11]   74 	iret 
                                     75 
                                     76 
                                     77 ;-------------------------------
                                     78 ; initialize parrallel interface 
                                     79 ; with computer. 
                                     80 ; 8 bits bus transfert 
                                     81 ; with 2 control lines  
                                     82 ; ITF_PORT stay as input as default mode 
                                     83 ; ITF_CTRL_CA2 stay as input 
                                     84 ;-------------------------------
      0084E5                         85 itf_init:
                                     86 ; ITF_CA1 as output push-pull 
      0084E5 72 12 50 08      [ 1]   87 	bset ITF_CTRL_CR1,#ITF_CA1 ; push pull output 
      0084E9 72 12 50 07      [ 1]   88 	bset ITF_CTRL_DDR,#ITF_CA1; output mode
      0084ED 72 13 50 05      [ 1]   89 	bres ITF_CTRL_ODR,#ITF_CA1
                                     90 ; set external interrupt on ITF_CA2 
                                     91 ; to signal byte received on bus
      0084F1 72 14 50 A0      [ 1]   92 	bset EXTI_CR,#ITF_CA2_PBIS ; rising edge on CA2 trigger interrupt 
                                     93 ; enable external interrupt on ITF_CA2 
      0084F5 72 10 50 13      [ 1]   94 	bset ITF_CR2,#ITF_CA2 
                                     95 ; reset transmit flag 
      0084F9 72 11 00 05      [ 1]   96 	bres flags,#FTX 
      0084FD 81               [ 4]   97 	ret 
                                     98 
                                     99 
                           000000   100 .if 0
                                    101 ;-------------------------------
                                    102 ;  file operation entry function 
                                    103 ; input:
                                    104 ;    X    pointer to FCB 
                                    105 ;-------------------------------
                                    106 file_op::
                                    107 	pushw y 
                                    108 	ld a,(FCB_OPERATION,x)
                                    109 	cp a,#FILE_SAVE 
                                    110 	jrne 1$ 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 60.
Hexadecimal [24-Bits]



                                    111 	call  save_file 
                                    112 	jra 9$ 
                                    113 1$: cp a,#FILE_LOAD 
                                    114 	jrne 2$ 
                                    115 	call load_file
                                    116 	jra 9$ 
                                    117 2$: cp a,#FILE_ERASE 
                                    118 	jrne 3$ 
                                    119 	call erase_file 
                                    120 	jra 9$ 
                                    121 3$: cp a,#FILE_LIST 
                                    122 	jrne 4$ 
                                    123 	call list_files 
                                    124 	jra 9$
                                    125 4$: cp a,#FILE_ERASE_ALL
                                    126 	jrne 8$
                                    127 	call erase_all
                                    128 	jra 9$  	 
                                    129 8$: 
                                    130 	pushw x 
                                    131 	ldw x,#file_bad_op 
                                    132 	call puts
                                    133 	popw x  
                                    134 9$:	
                                    135 	popw y 
                                    136 	ret 
                                    137 file_bad_op: .asciz "bad file operation code\r"
                                    138 
                                    139 ;----------------------
                                    140 ; copy .asciz name 
                                    141 ; to fcb->FILE_NAME_FIELD
                                    142 ; input:
                                    143 ;     X  *FCB
                                    144 ;     Y  *.asciz name 
                                    145 ; output:
                                    146 ;     X  *FCB    
                                    147 ;-------------------------
                                    148 name_to_fcb::
                                    149 	pushw x 
                                    150 	push #FNAME_MAX_LEN 
                                    151 	addw x, #FCB_NAME
                                    152 1$:	ld a,(y)
                                    153 	jreq 2$
                                    154 	ld (X),a 
                                    155 	incw y 
                                    156 	incw x 
                                    157 	dec (1,sp)
                                    158 	jrne 1$
                                    159 	jra 4$  
                                    160 ; pad with SPACE 	
                                    161 2$: ld a,#SPACE 
                                    162 3$: ld (x),a 
                                    163 	incw x
                                    164 	dec (1,sp)
                                    165 	jrne 3$
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 61.
Hexadecimal [24-Bits]



                                    166 4$:
                                    167 	_drop 1 
                                    168 	popw x 
                                    169 	ret 
                                    170 
                                    171 ;----------------------------
                                    172 ; compare 2 spaces padded 
                                    173 ; file name 
                                    174 ; FNAME_MAX_LEN 
                                    175 ; input:
                                    176 ;   X    *fname1 
                                    177 ;   Y    *fname2
                                    178 ;---------------------------
                                    179 cmp_fname:
                                    180 	push #FNAME_MAX_LEN
                                    181 1$: ld a,(x)
                                    182 	cp a,(y)
                                    183 	jrne 9$ 
                                    184 	incw x 
                                    185 	incw y 
                                    186 	dec (1,sp)
                                    187 	jrne 1$
                                    188 9$: _drop 1 
                                    189 	ret 
                                    190 
                                    191 .if 1
                                    192 ;------------------------------
                                    193 ; copy space padded file name 
                                    194 ; input:
                                    195 ;   X      destination 
                                    196 ;   Y      source  
                                    197 ;------------------------------
                                    198 fname_cpy:
                                    199 	push #FNAME_MAX_LEN 
                                    200 1$: ld a,(y)
                                    201 	ld (x),a 
                                    202 	incw x 
                                    203 	incw y 
                                    204 	dec (1,sp)
                                    205 	jrne 1$ 
                                    206 	_drop 1 
                                    207 	ret 
                                    208 .endif 
                                    209 
                                    210 ;--------------------------
                                    211 ; write file header to eeprom 
                                    212 ; input:
                                    213 ;    farptr   file address 
                                    214 ;    file_heder  data 
                                    215 ;------------------------------
                                    216 write_header:
                                    217 	ld a,#FILE_HEADER_SIZE 
                                    218 	ldw x,#file_header 
                                    219 	call eeprom_write 
                                    220 	ldw x,#FILE_HEADER_SIZE 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 62.
Hexadecimal [24-Bits]



                                    221 	call incr_farptr
                                    222 	ret 
                                    223 
                                    224 ;-----------------------------
                                    225 ; print file name 
                                    226 ; input:
                                    227 ;    X    *FNAME 
                                    228 ;-----------------------------
                                    229 print_fname::
                                    230 	push #FNAME_MAX_LEN
                                    231 1$: ld a,(x)
                                    232 	call putc 
                                    233 	incw x 
                                    234 	dec (1,sp)
                                    235 	jrne 1$ 	
                                    236 	ld a,#SPACE 
                                    237 	call putc 
                                    238 	_drop 1
                                    239 	ret 
                                    240 
                                    241 ;-------------------------------
                                    242 ; search a file in spi eeprom  
                                    243 ; 
                                    244 ; input:
                                    245 ;    x      *FCB 
                                    246 ; output: 
                                    247 ;    A        0 not found | 1 found file
                                    248 ;    X        *FCB  
                                    249 ;    farptr   file address in eeprom   
                                    250 ;-------------------------------
                                    251 	FNAME=1 
                                    252 	YSAVE=FNAME+2 
                                    253 	FCB_REC=YSAVE+2
                                    254 	VSIZE=FCB_REC+1 
                                    255 search_file::
                                    256 	_vars VSIZE
                                    257 	ldw (YSAVE,sp),y  
                                    258 	ldw (FCB_REC,sp),x
                                    259 	call first_file  
                                    260     jreq 7$  
                                    261 1$:
                                    262     ldw x,#file_header+FILE_NAME_FIELD  
                                    263 	ldw y,(FCB_REC,sp)
                                    264 	addw y,#FCB_NAME
                                    265 	call cmp_fname 
                                    266 	jreq 4$
                                    267 	ldw x,#file_header  
                                    268 	call skip_to_next
                                    269 	call next_file 
                                    270 	jreq 7$
                                    271 	jra 1$   
                                    272 4$: ; file found  
                                    273 	ld a,#1 
                                    274 	jra 8$  
                                    275 7$: ; not found 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 63.
Hexadecimal [24-Bits]



                                    276 	clr a 
                                    277 8$:	
                                    278 	ldw y,(YSAVE,sp)
                                    279 	ldw x,(FCB_REC,sp)
                                    280 	tnz a 
                                    281 	_drop VSIZE 
                                    282 	ret 
                                    283 
                                    284 ;-----------------------------------
                                    285 ; erase file
                                    286 ; replace signature by "XX. 
                                    287 ; input:
                                    288 ;   X    *FCB
                                    289 ; output:
                                    290 ;   X    *FCB    
                                    291 ;-----------------------------------
                                    292 erase_file:: 
                                    293 	call search_file 
                                    294 	jrne 1$ 
                                    295 	ld a,#FILE_OP_NOT_FOUND
                                    296 	jra 9$
                                    297 1$:	 
                                    298 	pushw x 
                                    299 	ldw x,#FILE_ERASED 
                                    300 	_strxz file_header+FILE_SIGN_FIELD 
                                    301 	ldw x,#file_header  
                                    302 	ld a,#2 
                                    303 	call eeprom_write 
                                    304 	ld a,#FILE_OP_SUCCESS
                                    305 	popw x 
                                    306 9$: call file_op_report 
                                    307 	ret 
                                    308 
                                    309 ;--------------------------------------
                                    310 ; reclaim erased file space that 
                                    311 ; fit size 
                                    312 ; input:
                                    313 ;    X     minimum size to reclaim 
                                    314 ; output:
                                    315 ;    A     0 no fit | 1 fit found 
                                    316 ;    farptr   fit address 
                                    317 ;--------------------------------------
                                    318 	NEED=1
                                    319 	SMALL_FIT=NEED+2
                                    320 	YSAVE=SMALL_FIT+2 
                                    321 	VSIZE=YSAVE+1
                                    322 reclaim_space:
                                    323 	_vars VSIZE 
                                    324 	ldw (YSAVE,sp),y 
                                    325 	ldw (NEED,sp),x 
                                    326 	ldw x,#-1 
                                    327 	ldw (SMALL_FIT,sp),x 
                                    328 	_clrz farptr  
                                    329 	clrw x
                                    330 	_strxz ptr16 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 64.
Hexadecimal [24-Bits]



                                    331 1$:	
                                    332 	call addr_to_page
                                    333 	cpw x,#512 
                                    334 	jrpl 7$ ; to end  
                                    335 	ldw x,#FILE_HEADER_SIZE
                                    336 	ldw y,#fcb
                                    337 	call eeprom_read 
                                    338 	ldw x,#fcb  
                                    339 	ldw x,(x)
                                    340 	cpw x,#FILE_ERASED 
                                    341 	jreq 4$ 
                                    342 3$:	call skip_to_next
                                    343 	jra 1$ 
                                    344 4$: ; check size 
                                    345 	ldw x,#fcb  
                                    346 	ldw x,(FILE_SIZE_FIELD,x)
                                    347 	cpw x,(NEED,sp)
                                    348 	jrult 3$ 
                                    349 	cpw x,(SMALL_FIT,sp)
                                    350 	jrugt 3$ 
                                    351 	ldw (SMALL_FIT,sp),x  
                                    352 	jra 3$ 
                                    353 7$: ; to end of file system 
                                    354 	clr a 
                                    355 	ldw x,(SMALL_FIT,sp)
                                    356 	cpw x,#-1
                                    357 	jreq 9$ 
                                    358 	ld a,#1
                                    359 9$:	
                                    360 	ldw y,(YSAVE,sp)
                                    361 	_drop VSIZE  
                                    362 	ret 
                                    363 
                                    364 ;--------------------------
                                    365 ; load file in RAM 
                                    366 ; file already searched 
                                    367 ; input:
                                    368 ;    X   *FCB 
                                    369 ; output:
                                    370 ;    X   *FCB 
                                    371 ;--------------------------
                                    372 	FSIZE=1
                                    373 	YSAVE=FSIZE+2
                                    374 	FCB_REC=YSAVE+2
                                    375 	VSIZE=FCB_REC+1
                                    376 load_file::
                                    377 	_vars VSIZE 
                                    378 	ldw (YSAVE,sp),y
                                    379 	ldw (FCB_REC,sp),x 
                                    380 	call search_file 
                                    381 	jrne 1$ 
                                    382 	ld a,#FILE_OP_NOT_FOUND
                                    383 	ldw x,(FCB_REC,sp)
                                    384 	jra 9$ 
                                    385 1$:	
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 65.
Hexadecimal [24-Bits]



                                    386 	ldw x,#FILE_HEADER_SIZE 
                                    387 	call incr_farptr 	
                                    388 	ldw x,file_header+FILE_SIZE_FIELD 
                                    389 	ldw (FSIZE,sp),x 
                                    390 	ldw y,(FCB_REC,sp)
                                    391 	ldw y,(FCB_BUFFER,y)   
                                    392 	call eeprom_read 
                                    393 	ldw y,(FSIZE,sp)
                                    394 	ldw x,(FCB_REC,sp)
                                    395 	ldw (FCB_DATA_SIZE,x),y 
                                    396 	ld a,#FILE_OP_SUCCESS
                                    397 9$:
                                    398 	call file_op_report 
                                    399 	ldw y,(YSAVE,sp)
                                    400 	ldw x,(FCB_REC,sp)
                                    401 	_drop VSIZE 
                                    402 	ret 
                                    403 
                                    404 ;--------------------------------------
                                    405 ; save program file 
                                    406 ; input:
                                    407 ;    X          *FCB  
                                    408 ;--------------------------------------
                                    409 	TO_WRITE=1
                                    410 	DONE=TO_WRITE+2
                                    411 	FNAME=DONE+2 
                                    412 	FCB_REC=FNAME+2
                                    413 	BUF_ADR=FCB_REC+2 
                                    414 	YSAVE=BUF_ADR+2
                                    415 	VSIZE=YSAVE+1
                                    416 save_file::
                                    417 	_vars VSIZE 
                                    418 	ldw (YSAVE,sp),y
                                    419 	ldw (FCB_REC,sp),x  
                                    420 ; check if file exist 
                                    421 	call search_file 
                                    422 	jreq 1$
                                    423 	ld a,#FILE_OP_CLASH 
                                    424 	ldw x,(FCB_REC,sp) 
                                    425 	jra 9$ 
                                    426 1$:	
                                    427 	call search_free 
                                    428 	jrne 11$
                                    429 	ld a,#FILE_OP_SPACE
                                    430 	ldw x,(FCB_REC,sp)
                                    431 	jra 9$
                                    432 11$:	
                                    433 	ldw x,#FILE_SIGN 
                                    434 	_strxz file_header+FILE_SIGN_FIELD 
                                    435 	ldw x,(FCB_REC,sp)
                                    436 	ldw y,x
                                    437 	ldw y,(FCB_DATA_SIZE,y)
                                    438 	_stryz file_header+FILE_SIZE_FIELD 
                                    439 	ldw (TO_WRITE,sp),y 
                                    440 	addw x,#FCB_NAME
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 66.
Hexadecimal [24-Bits]



                                    441 	ldw y,x 
                                    442 	ldw x,#file_header+FILE_NAME_FIELD
                                    443 	call fname_cpy  
                                    444 	call write_header 
                                    445 	ldw x,(FCB_REC,sp)
                                    446 	ldw x,(FCB_BUFFER,x)
                                    447 	ldw (BUF_ADR,sp),x 
                                    448 	ldw x,#FSECTOR_SIZE-FILE_HEADER_SIZE 
                                    449 2$: 
                                    450 	cpw x,(TO_WRITE,sp)
                                    451 	jrule 3$ 
                                    452 	ldw x,(TO_WRITE,sp)
                                    453 3$: ldw (DONE,sp),x
                                    454 	ld a,xl 
                                    455 	ldw x,(BUF_ADR,sp)
                                    456 	call eeprom_write 
                                    457 	ldw x,(DONE,sp)
                                    458 	call incr_farptr
                                    459 	ldw x,(TO_WRITE,sp)
                                    460 	subw x,(DONE,sp)
                                    461 	ldw (TO_WRITE,sp),x 
                                    462 	jreq 8$ 
                                    463 	ldw x,(BUF_ADR,sp)
                                    464 	addw x,(DONE,sp)
                                    465 	ldw (BUF_ADR,sp),x 
                                    466 	ldw x,#FSECTOR_SIZE
                                    467 	jra 2$
                                    468 8$:	 
                                    469 	ld a,#FILE_OP_SUCCESS
                                    470 	ldw x,(FCB_REC,sp)
                                    471 9$:
                                    472 	call file_op_report  
                                    473 	ldw y,(YSAVE,sp)
                                    474 	_drop VSIZE 
                                    475 	ret 
                                    476 
                                    477 ;--------------------------------
                                    478 ; report file operation status 
                                    479 ; input:
                                    480 ;    A     op_code 
                                    481 ;    X     *FCB 
                                    482 ; output:
                                    483 ;    X     *FCB 
                                    484 ;-------------------------------
                                    485 file_op_report:
                                    486 	pushw x 
                                    487 	ld (FCB_OP_STATUS,x),a 
                                    488 	sll a 
                                    489 	clrw x 
                                    490     ld xl,a  
                                    491 	ldw x,(status_msg,x) 
                                    492 	call puts
                                    493 	popw x  
                                    494 	ret 
                                    495 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 67.
Hexadecimal [24-Bits]



                                    496 status_msg: .word op_success,no_space,file_exist,not_found
                                    497 
                                    498 op_success: .asciz "operation completed\n"
                                    499 no_space: .asciz "File system full.\n" 
                                    500 file_exist: .asciz "Duplicate name.\n"
                                    501 not_found: .asciz "File not found.\n" 
                                    502 
                                    503 
                                    504 ;------------------------
                                    505 ; diplay list of files 
                                    506 ; in files system 
                                    507 ;------------------------
                                    508 	FCNT=1 
                                    509 	SCTR_CNT=FCNT+2
                                    510 	VSIZE=SCTR_CNT+1
                                    511 list_files::
                                    512 	_vars VSIZE 
                                    513 	clrw x 
                                    514 	ldw (FCNT,sp),x 
                                    515 	ldw (SCTR_CNT,sp),x 
                                    516 	call first_file 
                                    517 	jreq 9$ 
                                    518 1$:
                                    519 	ldw x,(FCNT,sp)
                                    520 	incw x 
                                    521 	ldw (FCNT,sp),x
                                    522 	ldw x,file_header+FILE_SIZE_FIELD
                                    523 	addw x,#FILE_HEADER_SIZE
                                    524 	call sector_align
                                    525 	call size_to_sector 
                                    526 	addw x,(SCTR_CNT,sp)
                                    527 	ldw (SCTR_CNT,sp),x 
                                    528 	ldw x,#file_header+FILE_NAME_FIELD 
                                    529 	call print_fname
                                    530 	ldw x,file_header+FILE_SIZE_FIELD
                                    531 	call print_int
                                    532 	ldw x,#file_size 
                                    533 	call puts 
                                    534 	ldw x,#file_header 
                                    535 	call skip_to_next 
                                    536 	call next_file 
                                    537 	jrne 1$  
                                    538 9$:
                                    539 	call new_line
                                    540 	ldw x,(FCNT,sp) 	
                                    541 	call print_int
                                    542 	ldw x,#files_count 
                                    543 	call puts 
                                    544 	ldw x,(SCTR_CNT,sp)
                                    545 	call print_int
                                    546 	ldw x,#sectors_used 
                                    547 	call puts  
                                    548 	_drop VSIZE 
                                    549 	ret 
                                    550 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 68.
Hexadecimal [24-Bits]



                                    551 file_size: .asciz "bytes\n"
                                    552 files_count: .asciz "files\n"
                                    553 sectors_used: .asciz "sectors used\n" 
                                    554 
                                    555 ;---------------------------
                                    556 ; search free page in eeprom 
                                    557 ; output:
                                    558 ;    A     0 no free | 1 free 
                                    559 ;    farptr  address free 
                                    560 ;---------------------------
                                    561 search_free:
                                    562 	pushw x 
                                    563 	pushw y 
                                    564 	_clrz farptr 
                                    565 	clrw x 
                                    566 	_strxz ptr16 
                                    567 1$:	
                                    568 	ldw y,#file_header 
                                    569 	ldw x,#FILE_HEADER_SIZE 
                                    570 	call eeprom_read 
                                    571 	ldw x,#-1 
                                    572 	cpw x,file_header+FILE_SIGN_FIELD
                                    573 	jreq 6$   ; empty page, take it 
                                    574 .if 0
                                    575 	ldw x,#FILE_SIGN
                                    576 	cpw x,file_header+FILE_SIGN_FIELD 
                                    577 	jreq 4$
                                    578 .endif 	 
                                    579 4$: ; try next 
                                    580 	ldw x,#file_header  
                                    581 	call skip_to_next 
                                    582 	call addr_to_page 
                                    583 	cpw x,#512 
                                    584 	jrmi 1$
                                    585 	clr a  
                                    586 	jra 9$ 
                                    587 6$: ; found free 
                                    588 	ld a,#1
                                    589 9$:	
                                    590 	popw y 
                                    591 	popw x 
                                    592 	ret 
                                    593 
                                    594 
                                    595 ;---------------------------------------
                                    596 ;  search first file 
                                    597 ;  input: 
                                    598 ;    none 
                                    599 ;  output:
                                    600 ;     A     0 none | 1 found file 
                                    601 ; farptr	file address 
                                    602 ;     X     file read buffer
                                    603 ;-----------------------------------------
                                    604 first_file::
                                    605 	_clrz farptr 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 69.
Hexadecimal [24-Bits]



                                    606 	clrw x 
                                    607 	_strxz ptr16 
                                    608 ; search next file 
                                    609 next_file::  
                                    610 	pushw y 
                                    611 1$:	
                                    612 	call addr_to_page
                                    613 	cpw x,#512
                                    614 	jrpl 4$ 
                                    615 	ldw x,#FILE_HEADER_SIZE ; bytes to read 
                                    616 	ldw y,#file_header  ; epprom read buffer 
                                    617 	call eeprom_read 
                                    618 	_ldxz file_header+FILE_SIGN_FIELD   
                                    619 	_strxz acc16 
                                    620 	ldw x,#FILE_SIGN  
                                    621 	cpw x,acc16 
                                    622 	jreq 8$  
                                    623 	ldw x,#-1 
                                    624 	cpw x,acc16 
                                    625 	jreq 4$ ; end of files 	
                                    626 2$:
                                    627 	ldw x,#file_header  
                                    628 	call skip_to_next 
                                    629 	jra 1$ 
                                    630 4$: ; no more file 
                                    631 	clr a
                                    632 	jra 9$  
                                    633 8$: ld a,#1
                                    634 9$:
                                    635 	ldw x,#file_header 
                                    636     tnz a 	
                                    637 	popw y 
                                    638 	ret 
                                    639 
                                    640 ;--------------------------
                                    641 ; erase all files by 
                                    642 ; by bulk_erasing 25LC1024
                                    643 ;-----------------------------
                                    644 erase_all::
                                    645 	ldw x,#confirm_msg 
                                    646 	call puts 
                                    647 	call getc 
                                    648 	and a,#0XDF
                                    649 	cp a,#'Y 
                                    650 	jrne 9$ 
                                    651 	jp eeprom_erase_chip
                                    652 9$: ret 	
                                    653 confirm_msg: .asciz "\nDo you really want to erase all files? (N/Y)"
                                    654 
                                    655 
                                    656 
                                    657 ;-----------------------------
                                    658 ;  compute sector used 
                                    659 ;  size/SECTOR_SIZE
                                    660 ;  expect FSECTOR_SIZE=256  
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 70.
Hexadecimal [24-Bits]



                                    661 ; input:
                                    662 ;    X   data size  
                                    663 ; ouput:
                                    664 ;    X    sector count 
                                    665 ;------------------------------
                                    666 size_to_sector:
                                    667 	clr a 
                                    668 	rrwa x 
                                    669 	ret 
                                    670 
                                    671 ;-------------------------------
                                    672 ;  round up size to n*sector 
                                    673 ;  expect FSECTOR_SIZE=256 
                                    674 ; input:
                                    675 ;     X   size 
                                    676 ; output:
                                    677 ;     X   rounded up to n*sector 
                                    678 ;-------------------------------
                                    679 sector_align:
                                    680 	addw x,#FSECTOR_SIZE-1 
                                    681 	clr a 
                                    682 	ld xl,a 
                                    683 	ret 
                                    684 
                                    685 ;----------------------------
                                    686 ;  skip to next program
                                    687 ;  in file system  
                                    688 ; input:
                                    689 ;     X       address of buffer containing file HEADER data 
                                    690 ;    farptr   actual program address in eeprom 
                                    691 ; output:
                                    692 ;    farptr   updated to next sector after program   
                                    693 ;----------------------------
                                    694 skip_to_next::
                                    695 	ldw x,(FILE_SIZE_FIELD,x)
                                    696 	call sector_align  
                                    697 
                                    698 ;----------------------
                                    699 ; input: 
                                    700 ;    X     increment 
                                    701 ; output:
                                    702 ;   farptr += X 
                                    703 ;---------------------
                                    704 incr_farptr:
                                    705 	addw x,ptr16 
                                    706 	_strxz ptr16  
                                    707 	clr a 
                                    708 	adc a,farptr 
                                    709 	_straz farptr 
                                    710 	ret 
                                    711 
                                    712 .endif 
                                    713 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 71.
Hexadecimal [24-Bits]



                                      1 ;--------------------------
                                      2 ;   tests unit 
                                      3 ;--------------------------
                                      4 
                           000000     5 .if UART_TEST  
                                      6 ;-----------------------
                                      7 ; UART test code 
                                      8 ; print message 
                                      9 ; then echo entered 
                                     10 ; characters
                                     11 ; qui when 'Q' entered 
                                     12 ;------------------------
                                     13 uart_test:
                                     14 	call uart_cls 
                                     15 	ldw x,#qbf 
                                     16 	call uart_puts
                                     17 	call uart_new_line
                                     18 1$:
                                     19 	call uart_getc
                                     20 	cp a,#'Q
                                     21 	jreq 9$ 
                                     22 	call uart_putc
                                     23 	jra 1$   
                                     24 9$:	ret 
                                     25 .endif ; UART_TEST  
      0084FE 54 48 45 20 51 55 49    26 qbf: .asciz "THE QUICK BROWN FOX JUMP OVER THE LAZY DOG.\rThe quick brown fox jump over the lazy dog.\recho test 'Q'uit"
             43 4B 20 42 52 4F 57
             4E 20 46 4F 58 20 4A
             55 4D 50 20 4F 56 45
             52 20 54 48 45 20 4C
             41 5A 59 20 44 4F 47
             2E 0D 54 68 65 20 71
             75 69 63 6B 20 62 72
             6F 77 6E 20 66 6F 78
             20 6A 75 6D 70 20 6F
             76 65 72 20 74 68 65
             20 6C 61 7A 79 20 64
             6F 67 2E 0D 65 63 68
             6F 20 74 65 73 74 20
             27 51 27 75 69 74 00
                                     27 
                                     28 ; ----- spi FLASH test ---------
                           000000    29 .if FLASH_TEST 
                                     30 dev_id: .asciz "device id: " 
                                     31 dev_size: .asciz ", device size MB: "
                                     32 no_empty_msg: .asciz " no empty page "
                                     33 writing_msg: .asciz "writing 256 bytes in page " 
                                     34 reading_msg: .asciz "reading back\r" 
                                     35 erase_msg: .asciz "erasing block 0\r"
                                     36 done_msg: .asciz "test completed\r"
                                     37 flash_test:
                                     38 	call uart_cls 
                                     39 	ldw x,#dev_id  
                                     40 	call uart_puts 
                                     41 	call device_id
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 72.
Hexadecimal [24-Bits]



                                     42 	call uart_print_hex_byte 
                                     43 	ldw x,#dev_size 
                                     44 	call uart_puts 
                                     45 	clrw x 
                                     46 	_ldaz device_size 
                                     47 	ld xl,a 
                                     48 	call uart_print_int 
                                     49 	call next_test 
                                     50 	ldw x,#writing_msg   
                                     51 	call uart_puts 
                                     52 ; search empty page 
                                     53 	clrw x
                                     54 7$:
                                     55 	call flash_page_empty
                                     56 	tnz a 
                                     57 	jrmi 5$
                                     58 	incw x 
                                     59 	cpw x,#512
                                     60 	jrmi 7$
                                     61 	ld a,#W25Q_B4K_ERASE
                                     62 	call flash_block_erase
                                     63 	ldw x,#no_empty_msg 
                                     64 	call uart_puts 
                                     65 	call prng
                                     66 	rlwa x 
                                     67 	and a,#1 
                                     68 	rrwa x 
                                     69 5$: pushw x  
                                     70 	call uart_print_hex 
                                     71 	call uart_new_line 
                                     72 	popw x 
                                     73 	call page_addr 
                                     74 ; fill buffer with 256 random bytes 
                                     75 0$:
                                     76 	push #0
                                     77 	ldw y,#flash_buffer  
                                     78 1$: 
                                     79 	call prng 
                                     80 	ld a,xl 
                                     81 	ld (y),a 
                                     82 	incw y 
                                     83 	dec (1,sp)
                                     84 	jrne 1$
                                     85 	call print_buffer 
                                     86 	clr a 
                                     87 	ldw x,#flash_buffer 
                                     88 	call flash_write
                                     89 ; clear buffer 
                                     90 	ld a,#255 
                                     91 	ldw x,#flash_buffer
                                     92 6$:	clr (x)
                                     93 	incw x 
                                     94 	dec a 
                                     95 	cp a,#255 
                                     96 	jrne 6$ 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 73.
Hexadecimal [24-Bits]



                                     97 ;read back written data 
                                     98 	ldw x,#reading_msg 
                                     99 	call uart_puts 
                                    100 	ldw y,#flash_buffer 
                                    101 	ldw x,#256 
                                    102 	call flash_read 
                                    103 	call print_buffer 
                                    104 ; erasing block 0
                                    105 	_clrz farptr 
                                    106 	clrw x 
                                    107 	_strxz ptr16
                                    108 	ldw x,#erase_msg 
                                    109 	call uart_puts 
                                    110 	ld a,#W25Q_B4K_ERASE
                                    111 	clrw x 
                                    112 	call flash_block_erase
                                    113 ; reaading page 0
                                    114 	_clrz farptr 
                                    115 	clrw x  
                                    116 	_strxz ptr16
                                    117 	ldw x,#reading_msg
                                    118 	call uart_puts 
                                    119 	ldw x,#256
                                    120 	call flash_read 
                                    121 	call print_buffer 
                                    122 	ldw x,#done_msg 
                                    123 	call uart_puts 
                                    124 	jra . 
                                    125 
                                    126 
                                    127 prompt: .asciz "any key for next test."
                                    128 next_test:
                                    129 	call uart_new_line
                                    130 	ldw x,#prompt
                                    131 	call uart_puts 
                                    132 	call uart_getc 
                                    133 	call uart_new_line	
                                    134 	ret
                                    135 
                                    136 ; print 256 byte in buffer 
                                    137 print_buffer:
                                    138 	call uart_new_line
                                    139 	push #0 
                                    140 	ldw x,#flash_buffer 
                                    141 1$: 
                                    142 	ld a,(x)
                                    143 	call uart_print_hex_byte
                                    144 	call uart_space 
                                    145 	incw x 
                                    146 	dec (1,sp)
                                    147 	ld a,(1,sp) 
                                    148 	cp a,#0
                                    149 	jreq 9$ 
                                    150 	and a,#0xF 
                                    151 	jrne 1$ 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 74.
Hexadecimal [24-Bits]



                                    152 	call uart_new_line
                                    153 	jra 1$
                                    154 9$: 
                                    155 	call uart_new_line
                                    156 	pop a	
                                    157 	ret 
                                    158 
                                    159 .endif 
                                    160 
                           000001   161 .if XRAM_TEST 
      008567                        162 xram_test:
      008567 CD 81 EA         [ 4]  163 	call uart_cls
      00856A AE 85 A3         [ 2]  164 	ldw x,#xram_test_msg 
      00856D CD 82 29         [ 4]  165 	call uart_puts
      008570 AE 84 FE         [ 2]  166 	ldw x,#qbf 
      008573 90 AE 01 00      [ 2]  167 	ldw y,#flash_buffer 
      008577 F6               [ 1]  168 1$: ld a,(x)
      008578 90 F7            [ 1]  169 	ld (y),a 
      00857A 5C               [ 1]  170 	incw x 
      00857B 90 5C            [ 1]  171 	incw y 
      00857D 4D               [ 1]  172 	tnz a 
      00857E 26 F7            [ 1]  173 	jrne 1$ 
      008580 4F               [ 1]  174 	clr a 
      008581 5F               [ 1]  175 	clrw x 
      008582 90 AE 00 58      [ 2]  176 	ldw y,#88 
      008586 CD 84 9F         [ 4]  177 	call xram_write 
      008589 A6 64            [ 1]  178 	ld a,#100
      00858B AE 01 00         [ 2]  179 	ldw x,#flash_buffer 
      00858E 7F               [ 1]  180 2$: clr (x)
      00858F 5C               [ 1]  181 	incw x 
      008590 4A               [ 1]  182 	dec a 
      008591 26 FB            [ 1]  183 	jrne 2$ 
      008593 4F               [ 1]  184 	clr a 
      008594 5F               [ 1]  185 	clrw x 
      008595 90 AE 00 58      [ 2]  186 	ldw y,#88
      008599 CD 84 74         [ 4]  187 	call xram_read 
      00859C AE 01 00         [ 2]  188 	ldw x,#flash_buffer 
      00859F CD 82 29         [ 4]  189 	call uart_puts 
      0085A2 81               [ 4]  190 	ret 
      0085A3 58 52 41 4D 20 74 65   191 xram_test_msg: .asciz "XRAM test\r" 
             73 74 0D 00
                                    192 .endif 
                                    193 
                                    194 
                           000001   195 .if DRV_CMD_TEST 
      0085AE                        196 drive_cmd_test:
                                    197 
      0085AE 81               [ 4]  198     ret 
                                    199 
                                    200 .endif 
                                    201 
                                    202 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 75.
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
    B6_MASK =  000040     |     B7_MASK =  000080     |     B9600   =  000002 
    BAUD_RAT=  01C200     |     BEEP_BIT=  000004     |     BEEP_CSR=  0050F3 
    BEEP_MAS=  000010     |     BEEP_POR=  00000F     |     BELL    =  000007 
    BIT0    =  000000     |     BIT1    =  000001     |     BIT2    =  000002 
    BIT3    =  000003     |     BIT4    =  000004     |     BIT5    =  000005 
    BIT6    =  000006     |     BIT7    =  000007     |     BLOCK_SI=  000080 
    BOOT_ROM=  006000     |     BOOT_ROM=  007FFF     |     BS      =  000008 
    BUF_ADR =  000001     |     CAN     =  000018     |     CAN_DGR =  005426 
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
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 76.
Hexadecimal [24-Bits]

Symbol Table

    COMMA   =  00002C     |     COUNT   =  000003     |     CPU_A   =  007F00 
    CPU_CCR =  007F0A     |     CPU_PCE =  007F01     |     CPU_PCH =  007F02 
    CPU_PCL =  007F03     |     CPU_SPH =  007F08     |     CPU_SPL =  007F09 
    CPU_XH  =  007F04     |     CPU_XL  =  007F05     |     CPU_YH  =  007F06 
    CPU_YL  =  007F07     |     CR      =  00000D     |     CTRL_A  =  000001 
    CTRL_B  =  000002     |     CTRL_C  =  000003     |     CTRL_D  =  000004 
    CTRL_E  =  000005     |     CTRL_F  =  000006     |     CTRL_G  =  000007 
    CTRL_H  =  000008     |     CTRL_I  =  000009     |     CTRL_J  =  00000A 
    CTRL_K  =  00000B     |     CTRL_L  =  00000C     |     CTRL_M  =  00000D 
    CTRL_N  =  00000E     |     CTRL_O  =  00000F     |     CTRL_P  =  000010 
    CTRL_Q  =  000011     |     CTRL_R  =  000012     |     CTRL_S  =  000013 
    CTRL_T  =  000014     |     CTRL_U  =  000015     |     CTRL_V  =  000016 
    CTRL_W  =  000017     |     CTRL_X  =  000018     |     CTRL_Y  =  000019 
    CTRL_Z  =  00001A     |     DC1     =  000011     |     DC2     =  000012 
    DC3     =  000013     |     DC4     =  000014     |     DCNT    =  000001 
    DEBUG_BA=  007F00     |     DEBUG_EN=  007FFF     |     DEVID_BA=  0048CD 
    DEVID_EN=  0048D8     |     DEVID_LO=  0048D2     |     DEVID_LO=  0048D3 
    DEVID_LO=  0048D4     |     DEVID_LO=  0048D5     |     DEVID_LO=  0048D6 
    DEVID_LO=  0048D7     |     DEVID_LO=  0048D8     |     DEVID_WA=  0048D1 
    DEVID_XH=  0048CE     |     DEVID_XL=  0048CD     |     DEVID_YH=  0048D0 
    DEVID_YL=  0048CF     |     DIGITS  =  000003     |     DLE     =  000010 
    DM_BK1RE=  007F90     |     DM_BK1RH=  007F91     |     DM_BK1RL=  007F92 
    DM_BK2RE=  007F93     |     DM_BK2RH=  007F94     |     DM_BK2RL=  007F95 
    DM_CR1  =  007F96     |     DM_CR2  =  007F97     |     DM_CSR1 =  007F98 
    DM_CSR2 =  007F99     |     DM_ENFCT=  007F9A     |     DRV_CMD_=  000001 
    EEPROM_B=  004000     |     EEPROM_E=  0043FF     |     EEPROM_S=  000400 
    EM      =  000019     |     ENQ     =  000005     |     EOF     =  0000FF 
    EOT     =  000004     |     ESC     =  00001B     |     ETB     =  000017 
    ETX     =  000003     |     EXTI_CR =  0050A0     |     EXTI_CR1=  0050A0 
    EXTI_CR2=  0050A1     |     FCOMP_RD=  000001     |     FF      =  00000C 
    FHSI    =  F42400     |     FLASH0  =  000003     |     FLASH_BA=  008000 
    FLASH_CR=  00505A     |     FLASH_CR=  000002     |     FLASH_CR=  000000 
    FLASH_CR=  000003     |     FLASH_CR=  000001     |     FLASH_CR=  00505B 
    FLASH_CR=  000005     |     FLASH_CR=  000004     |     FLASH_CR=  000007 
    FLASH_CR=  000000     |     FLASH_CR=  000006     |     FLASH_DU=  005064 
    FLASH_DU=  0000AE     |     FLASH_DU=  000056     |     FLASH_EN=  017FFF 
    FLASH_FP=  00505D     |     FLASH_FP=  000000     |     FLASH_FP=  000001 
    FLASH_FP=  000002     |     FLASH_FP=  000003     |     FLASH_FP=  000004 
    FLASH_FP=  000005     |     FLASH_IA=  00505F     |     FLASH_IA=  000003 
    FLASH_IA=  000002     |     FLASH_IA=  000006     |     FLASH_IA=  000001 
    FLASH_IA=  000000     |     FLASH_NC=  00505C     |     FLASH_NF=  00505E 
    FLASH_NF=  000000     |     FLASH_NF=  000001     |     FLASH_NF=  000002 
    FLASH_NF=  000003     |     FLASH_NF=  000004     |     FLASH_NF=  000005 
    FLASH_PU=  005062     |     FLASH_PU=  000056     |     FLASH_PU=  0000AE 
    FLASH_SI=  010000     |     FLASH_TE=  000000     |     FLASH_WS=  00480D 
    FLSI    =  01F400     |     FMSTR   =  000010     |     FS      =  00001C 
    FTX     =  000000     |     GPIO_BAS=  005000     |     GPIO_CR1=  000003 
    GPIO_CR2=  000004     |     GPIO_DDR=  000002     |     GPIO_IDR=  000001 
    GPIO_ODR=  000000     |     GPIO_SIZ=  000005     |     GS      =  00001D 
    HSECNT  =  004809     |     I2C_BASE=  005210     |     I2C_CCRH=  00521C 
    I2C_CCRH=  000080     |     I2C_CCRH=  0000C0     |     I2C_CCRH=  000080 
    I2C_CCRH=  000000     |     I2C_CCRH=  000001     |     I2C_CCRH=  000000 
    I2C_CCRH=  000006     |     I2C_CCRH=  000007     |     I2C_CCRL=  00521B 
    I2C_CCRL=  00001A     |     I2C_CCRL=  000002     |     I2C_CCRL=  00000D 
    I2C_CCRL=  000050     |     I2C_CCRL=  000090     |     I2C_CCRL=  0000A0 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 77.
Hexadecimal [24-Bits]

Symbol Table

    I2C_CR1 =  005210     |     I2C_CR1_=  000006     |     I2C_CR1_=  000007 
    I2C_CR1_=  000000     |     I2C_CR2 =  005211     |     I2C_CR2_=  000002 
    I2C_CR2_=  000003     |     I2C_CR2_=  000000     |     I2C_CR2_=  000001 
    I2C_CR2_=  000007     |     I2C_DR  =  005216     |     I2C_FREQ=  005212 
    I2C_ITR =  00521A     |     I2C_ITR_=  000002     |     I2C_ITR_=  000000 
    I2C_ITR_=  000001     |     I2C_OARH=  005214     |     I2C_OARH=  000001 
    I2C_OARH=  000002     |     I2C_OARH=  000006     |     I2C_OARH=  000007 
    I2C_OARL=  005213     |     I2C_OARL=  000000     |     I2C_OAR_=  000813 
    I2C_OAR_=  000009     |     I2C_PECR=  00521E     |     I2C_READ=  000001 
    I2C_SR1 =  005217     |     I2C_SR1_=  000003     |     I2C_SR1_=  000001 
    I2C_SR1_=  000002     |     I2C_SR1_=  000006     |     I2C_SR1_=  000000 
    I2C_SR1_=  000004     |     I2C_SR1_=  000007     |     I2C_SR2 =  005218 
    I2C_SR2_=  000002     |     I2C_SR2_=  000001     |     I2C_SR2_=  000000 
    I2C_SR2_=  000003     |     I2C_SR2_=  000005     |     I2C_SR3 =  005219 
    I2C_SR3_=  000001     |     I2C_SR3_=  000007     |     I2C_SR3_=  000004 
    I2C_SR3_=  000000     |     I2C_SR3_=  000002     |     I2C_TRIS=  00521D 
    I2C_TRIS=  000005     |     I2C_TRIS=  000005     |     I2C_TRIS=  000005 
    I2C_TRIS=  000011     |     I2C_TRIS=  000011     |     I2C_TRIS=  000011 
    I2C_WRIT=  000000     |     INCR    =  000001     |     INPUT_DI=  000000 
    INPUT_EI=  000001     |     INPUT_FL=  000000     |     INPUT_PU=  000001 
    INT_ADC2=  000016     |     INT_AUAR=  000012     |     INT_AWU =  000001 
    INT_CAN_=  000008     |     INT_CAN_=  000009     |     INT_CLK =  000002 
    INT_EXTI=  000003     |     INT_EXTI=  000004     |     INT_EXTI=  000005 
    INT_EXTI=  000006     |     INT_EXTI=  000007     |     INT_FLAS=  000018 
    INT_I2C =  000013     |     INT_SPI =  00000A     |     INT_TIM1=  00000C 
    INT_TIM1=  00000B     |     INT_TIM2=  00000E     |     INT_TIM2=  00000D 
    INT_TIM3=  000010     |     INT_TIM3=  00000F     |     INT_TIM4=  000017 
    INT_TLI =  000000     |     INT_UART=  000011     |     INT_UART=  000015 
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
    ITF_CA1 =  000001     |     ITF_CA2 =  000000     |     ITF_CA2_=  000002 
    ITF_CR1 =  005012     |     ITF_CR2 =  005013     |     ITF_CTRL=  005008 
    ITF_CTRL=  005009     |     ITF_CTRL=  005007     |     ITF_CTRL=  005006 
    ITF_CTRL=  005005     |     ITF_CTRL=  005005     |     ITF_DDR =  005011 
    ITF_IDR =  005010     |     ITF_ODR =  00500F     |     ITF_PORT=  00500F 
    ITF_SELE=  000005     |     IWDG_KEY=  000055     |     IWDG_KEY=  0000CC 
    IWDG_KEY=  0000AA     |     IWDG_KR =  0050E0     |     IWDG_PR =  0050E1 
    IWDG_RLR=  0050E2     |     LB      =  000002     |     LF      =  00000A 
    MAJOR   =  000001     |     MINOR   =  000000     |     NAFR    =  004804 
    NAK     =  000015     |     NCLKOPT =  004808     |     NEG     =  000002 
    NFLASH_W=  00480E     |     NHSECNT =  00480A     |     NLEN_MAS=  00000F 
    NOPT1   =  004802     |     NOPT2   =  004804     |     NOPT3   =  004806 
    NOPT4   =  004808     |     NOPT5   =  00480A     |     NOPT6   =  00480C 
    NOPT7   =  00480E     |     NOPTBL  =  00487F     |     NUBC    =  004802 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 78.
Hexadecimal [24-Bits]

Symbol Table

    NWDGOPT =  004806     |     NWDGOPT_=  FFFFFFFD     |     NWDGOPT_=  FFFFFFFC 
    NWDGOPT_=  FFFFFFFF     |     NWDGOPT_=  FFFFFFFE     |   7 NonHandl   000000 R
    OFS_UART=  000002     |     OFS_UART=  000003     |     OFS_UART=  000004 
    OFS_UART=  000005     |     OFS_UART=  000006     |     OFS_UART=  000007 
    OFS_UART=  000008     |     OFS_UART=  000009     |     OFS_UART=  000001 
    OFS_UART=  000009     |     OFS_UART=  00000A     |     OFS_UART=  000000 
    OPT0    =  004800     |     OPT1    =  004801     |     OPT2    =  004803 
    OPT3    =  004805     |     OPT4    =  004807     |     OPT5    =  004809 
    OPT6    =  00480B     |     OPT7    =  00480D     |     OPTBL   =  00487E 
    OPTION_B=  004800     |     OPTION_E=  00487F     |     OPTION_S=  000080 
    OUTPUT_F=  000001     |     OUTPUT_O=  000000     |     OUTPUT_P=  000001 
    OUTPUT_S=  000000     |     PA      =  000000     |     PA_BASE =  005000 
    PA_CR1  =  005003     |     PA_CR2  =  005004     |     PA_DDR  =  005002 
    PA_IDR  =  005001     |     PA_ODR  =  005000     |     PB      =  000005 
    PB_BASE =  005005     |     PB_CR1  =  005008     |     PB_CR2  =  005009 
    PB_DDR  =  005007     |     PB_IDR  =  005006     |     PB_ODR  =  005005 
  7 PBusIntH   00044A R   |     PC      =  00000A     |     PC_BASE =  00500A 
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
    SOH     =  000001     |     SPACE   =  000020     |     SPI_CLK =  000005 
    SPI_CR1 =  005200     |     SPI_CR1_=  000003     |     SPI_CR1_=  000000 
    SPI_CR1_=  000001     |     SPI_CR1_=  000007     |     SPI_CR1_=  000002 
    SPI_CR1_=  000006     |     SPI_CR2 =  005201     |     SPI_CR2_=  000007 
    SPI_CR2_=  000006     |     SPI_CR2_=  000005     |     SPI_CR2_=  000004 
    SPI_CR2_=  000002     |     SPI_CR2_=  000000     |     SPI_CR2_=  000001 
    SPI_CRCP=  005205     |     SPI_CS0 =  000003     |     SPI_CS1 =  000004 
    SPI_CS2 =  000002     |     SPI_CS3 =  000001     |     SPI_DR  =  005204 
    SPI_ICR =  005202     |     SPI_MISO=  000007     |     SPI_MOSI=  000006 
    SPI_PORT=  00500A     |     SPI_PORT=  00500D     |     SPI_PORT=  00500E 
    SPI_PORT=  00500C     |     SPI_PORT=  00500B     |     SPI_PORT=  00500A 
    SPI_RXCR=  005206     |     SPI_SR  =  005203     |     SPI_SR_B=  000007 
    SPI_SR_C=  000004     |     SPI_SR_M=  000005     |     SPI_SR_O=  000006 
    SPI_SR_R=  000000     |     SPI_SR_T=  000001     |     SPI_SR_W=  000003 
    SPI_TXCR=  005207     |     SR1_BUSY=  000000     |     SR1_WEL =  000001 
    STACK_EM=  0017FF     |     STACK_SI=  000080     |     STRX    =  000002 
    SUB     =  00001A     |     SWIM_CSR=  007F80     |     SYN     =  000016 
    TAB     =  000009     |     TAB_WIDT=  000004     |     TICK    =  000027 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 79.
Hexadecimal [24-Bits]

Symbol Table

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
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 80.
Hexadecimal [24-Bits]

Symbol Table

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
    UART_CR4=  000006     |     UART_CR4=  000005     |     UART_CR5=  000003 
    UART_CR5=  000001     |     UART_CR5=  000002     |     UART_CR5=  000004 
    UART_CR5=  000005     |     UART_CR6=  000004     |     UART_CR6=  000007 
    UART_CR6=  000001     |     UART_CR6=  000002     |     UART_CR6=  000000 
    UART_CR6=  000005     |     UART_DR =  005241     |     UART_PCK=  000003 
    UART_RX_=  000006     |     UART_SR =  005240     |     UART_SR_=  000001 
    UART_SR_=  000004     |     UART_SR_=  000002     |     UART_SR_=  000003 
    UART_SR_=  000000     |     UART_SR_=  000005     |     UART_SR_=  000006 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 81.
Hexadecimal [24-Bits]

Symbol Table

    UART_SR_=  000007     |     UART_TES=  000000     |     UART_TX_=  000005 
    UBC     =  004801     |     US      =  00001F     |   7 UartRxHa   000106 R
    VSIZE   =  000003     |     VT      =  00000B     |     W25Q_080=  000013 
    W25Q_128=  000017     |     W25Q_ADR=  000003     |     W25Q_B32=  000052 
    W25Q_B4K=  000020     |     W25Q_B64=  0000D8     |     W25Q_CHI=  0000C7 
    W25Q_ERA=  001000     |     W25Q_MFG=  000090     |     W25Q_PAG=  000100 
    W25Q_REA=  000003     |     W25Q_REA=  000005     |     W25Q_REA=  000035 
    W25Q_SEC=  001000     |     W25Q_WRE=  000006     |     W25Q_WRI=  000002 
    WDGOPT  =  004805     |     WDGOPT_I=  000002     |     WDGOPT_L=  000003 
    WDGOPT_W=  000000     |     WDGOPT_W=  000001     |     WWDG_CR =  0050D1 
    WWDG_WR =  0050D2     |     XOFF    =  000013     |     XON     =  000011 
    XRAM    =  000004     |     XRAM_REA=  000003     |     XRAM_TES=  000001 
    XRAM_WRI=  000002     |   5 acc16      000000 GR  |   5 acc8       000001 GR
  7 addr_to_   0003F1 GR  |   7 b32k_add   000386 R   |   7 b4k_addr   000378 R
  7 b64k_add   00038C R   |   7 busy_pol   000300 R   |   7 close_ch   0002C5 GR
  7 cold_sta   000018 R   |   7 create_b   00028F GR  |   7 device_i   0003CF R
  5 device_s   00004A GR  |   7 drive_cm   00052E R   |   5 farptr     000002 GR
  5 flags      000005 GR  |   7 flash_bl   000393 R   |   6 flash_bu   000100 GR
  7 flash_ch   0003BD GR  |   7 flash_en   0002E5 R   |   7 flash_er   0003AC R
  7 flash_pa   000350 R   |   7 flash_re   00032C GR  |   7 flash_re   0002F1 R
  7 flash_wr   000308 GR  |   7 getc       000183 GR  |   7 hex_digi   0001D8 R
  7 is_alnum   0000FD GR  |   7 is_alpha   0000D5 GR  |   7 is_digit   0000E6 GR
  7 is_hex_d   0000EF GR  |   7 itf_init   000465 R   |   7 main       00005A R
  7 move       000086 GR  |   7 move_dow   0000A6 R   |   7 move_exi   0000C5 R
  7 move_loo   0000AB R   |   7 move_up    000098 R   |   7 open_cha   0002B9 R
  7 page_add   0003EA R   |   7 prng       000004 R   |   5 prng_see   000006 GR
  5 ptr16      000003 GR  |   5 ptr8       000004 GR  |   7 qbf        00047E R
  7 qgetc      00017D GR  |   5 rx_head    000048 GR  |   5 rx_queue   000008 GR
  5 rx_tail    000049 GR  |   7 spi_clea   00026D GR  |   5 spi_devi   00004B GR
  7 spi_disa   00024D GR  |   7 spi_init   00021C GR  |   7 spi_rcv_   000285 GR
  7 spi_sele   00029E GR  |   7 spi_send   0002D5 GR  |   7 spi_send   000274 GR
  2 stack_fu   001780 GR  |   2 stack_un   001800 R   |   7 stor_add   00038E R
  7 store_by   00011A R   |   7 strcmp     000067 GR  |   7 strcpy     000076 GR
  7 strlen     00005C GR  |   7 to_upper   0000CA R   |   7 uart_cls   00016A R
  7 uart_cr    000156 R   |   7 uart_del   00015A R   |   7 uart_get   000183 GR
  7 uart_ini   00012C R   |   7 uart_new   000152 R   |   7 uart_pri   00019C R
  7 uart_pri   0001B6 R   |   7 uart_pri   0001C8 R   |   7 uart_pri   0001E3 R
  7 uart_put   000149 GR  |   7 uart_put   0001A9 R   |   7 uart_qge   00017D GR
  7 uart_spa   000177 R   |   7 xram_rea   0003F4 R   |   7 xram_tes   0004E7 R
  7 xram_tes   000523 R   |   7 xram_wri   00041F R

ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 82.
Hexadecimal [24-Bits]

Area Table

   0 _CODE      size      0   flags    0
   1 SSEG       size      0   flags    8
   2 SSEG0      size     80   flags    8
   3 HOME       size     80   flags    0
   4 DATA       size      0   flags    8
   5 DATA1      size     4C   flags    8
   6 DATA2      size   1000   flags    8
   7 CODE       size    52F   flags    0

