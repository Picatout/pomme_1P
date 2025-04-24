;;
; Copyright Jacques Deschênes 2025  
; This file is part of p1+_drive 
;
;     p1+_drive is free software: you can redistribute it and/or modify
;     it under the terms of the GNU General Public License as published by
;     the Free Software Foundation, either version 3 of the License, or
;     (at your option) any later version.
;
;     p1+_drive is distributed in the hope that it will be useful,
;     but WITHOUT ANY WARRANTY; without even the implied warranty of
;     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;     GNU General Public License for more details.
;
;     You should have received a copy of the GNU General Public License
;     along with p1+_drive.  If not, see <http://www.gnu.org/licenses/>.
;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; hardware initialization
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 

    .module HW_INIT 

    .include "config.inc"

STACK_SIZE=128
TIB_SIZE=256    
;;-----------------------------------
    .area SSEG (ABS)
;; working buffers and stack at end of RAM. 	
;;-----------------------------------
    .org RAM_SIZE-STACK_SIZE
tib:: .ds TIB_SIZE 
stack_full:: .ds STACK_SIZE   ; control stack full 
stack_unf: ; stack underflow ; RAM end +1 -> 0x1800


;;--------------------------------------
    .area HOME 
;; interrupt vector table at 0x8000
;;--------------------------------------

    int cold_start			; RESET vector 
	int NonHandledInterrupt ; trap instruction 
	int NonHandledInterrupt ;int0 TLI   external top level interrupt
	int NonHandledInterrupt ;int1 AWU   auto wake up from halt
	int NonHandledInterrupt ;int2 CLK   clock controller
	int NonHandledInterrupt ;int3 EXTI0 gpio A external interrupts
	int PBusIntHandler      ;int4 EXTI1 gpio B external interrupts
	int NonHandledInterrupt ;int5 EXTI2 gpio C external interrupts
	int NonHandledInterrupt ;int6 EXTI3 gpio D external interrupts
	int NonHandledInterrupt ;int7 EXTI4 gpio E external interrupts
	int NonHandledInterrupt ;int8 beCAN RX interrupt
	int NonHandledInterrupt ;int9 beCAN TX/ER/SC interrupt
	int NonHandledInterrupt ;int10 SPI End of transfer
	int NonHandledInterrupt ;int11 TIM1 update/overflow/underflow/trigger/break
	int NonHandledInterrupt ; int12 TIM1 capture/compare
	int NonHandledInterrupt ;int13 TIM2 update /overflow
	int NonHandledInterrupt ;int14 TIM2 capture/compare
	int NonHandledInterrupt ;int15 TIM3 Update/overflow
	int NonHandledInterrupt ;int16 TIM3 Capture/compare
	int NonHandledInterrupt ;int17 UART1 TX completed
	int NonHandledInterrupt ;int18 UART1 RX full 
	int NonHandledInterrupt ;int19 I2C 
	int NonHandledInterrupt ;int20 UART3 TX completed
	int UartRxHandler 		;int21 UART3 RX full
	int NonHandledInterrupt ;int22 ADC2 end of conversion
	int NonHandledInterrupt	;int23 TIM4 update/overflow ; use to blink tv cursor 
	int NonHandledInterrupt ;int24 flash writing EOP/WR_PG_DIS
	int NonHandledInterrupt ;int25  not used
	int NonHandledInterrupt ;int26  not used ;
	int NonHandledInterrupt ;int27  not used ; 
	int NonHandledInterrupt ;int28  not used
	int NonHandledInterrupt ;int29  not used



;--------------------------------------
    .area DATA (ABS)
	.org 0 
;--------------------------------------	

; keep the following 3 variables in this order 
acc16:: .blkb 1 ; 16 bits accumulator, acc24 high-byte
acc8::  .blkb 1 ;  8 bits accumulator, acc24 low-byte  
farptr:: .blkb 1; 24 bits pointer 
ptr16::  .blkb 1 ; 16 bits pointer , farptr high-byte 
ptr8::   .blkb 1 ; 8 bits pointer, farptr low-byte  
flags:: .blkb 1 ; various boolean flags
prng_seed:: .blkb 2 ; 

; communication queue 
; used by UART and parallel bus interface 
RX_QUEUE_SIZE=64 ; bytes 
rx_queue:: .ds RX_QUEUE_SIZE ; receive circular queue 
rx_head::  .blkb 1 ; rx_queue head pointer
rx_tail::   .blkb 1 ; rx_queue tail pointer  

; SPI variables 
device_size:: .blkb 1 ; in MB
spi_device:: .blkb 1 ; selected spi device 

	.org 0x100  
flash_buffer:: .blkb W25Q_SECTOR_SIZE ; 4096 bytes 


	.area CODE 

;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; non handled interrupt 
; reset MCU
;;;;;;;;;;;;;;;;;;;;;;;;;;;
NonHandledInterrupt:
	_swreset ; see "inc/gen_macros.inc"

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;    peripherals initialization
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;--------------------------
; pseudo random number 
; Galois LFSR 
; generator 
; output:
;    X     prng value 
;--------------------------
prng:
; 5 times right shift 
	push #5
	_ldxz prng_seed
1$:
	srlw x 
	jrnc 2$
	ld a, xh 
	xor a,#0XB4 
	ld xh, a
2$: 	
	dec (1,sp)
	jrne 1$  
9$: _strxz prng_seed 
	_drop 1 
	ret 

;-------------------------------------
;  initialization entry point 
;-------------------------------------
cold_start:
;set stack 
	ldw x,#STACK_EMPTY
	ldw sp,x
; clear all ram 
0$: clr (x)
	decw x 
	jrne 0$
; clock HSI 16 Mhz 
	clr CLK_CKDIVR 
; disable all peripherals clock
; to reduce power consumption
	clr CLK_PCKENR1
	clr CLK_PCKENR2 
; activate pull up on all inputs 
; to reduce input noise.
.if 1
	ld a,#255 
	ld PA_CR1,a 
	ld PB_CR1,a 
	ld PC_CR1,a 
	ld PD_CR1,a
	ld PE_CR1,a 
	ld PF_CR1,a 
.endif 
; disable schmitt triggers on Arduino CN4 analog inputs
	ld a,#0x3f 
	ld ADC_TDRL,a  
; init prng seed 
; only used in tests 
	ldw x,#0xACE1
	_strxz prng_seed
; interface selector 
	bset ITF_CTRL_CR1,#ITF_SELECT ; set pull up on input 
	bres flags,#FITF 
	ld a,#(1<<ITF_SELECT)
	and a,ITF_CTRL_IDR 
	or a,flags 
	_straz flags  
; initialize peripherals 
	btjf flags,#FITF, use_parallel 
	call uart_init ; only if use serial interface
	jra use_serial 
use_parallel: ; interface 
	call itf_init 
use_serial: ; interface 
	call spi_init
	rim ; enable interrupts 

UART_TEST=0
.if UART_TEST  
	call uart_test 
.endif 

FLASH_TEST=0
.if FLASH_TEST 
	call flash_test 
.endif 

XRAM_TEST=1
.if XRAM_TEST
	call xram_test 
.endif 

DRV_CMD_TEST=1
.if DRV_CMD_TEST 
	call drive_cmd_test
.endif // DRV_CMD_TEST 

;-------------------------------
; read command line 
; and execute action 
;-------------------------------
main:
	call uart_cls 
1$:	ld a,#'# 
	call uart_putc 
	call get_command 
	call exec_command
	jra 1$


get_command:
	ldw x,#tib 
	call uart_getc
	cp a,#SOH 
	jrne get_command
	call uart_getc 
	cp a,#EOT 
	jreq 9$
	ld (x),a 
	incw x  
9$:	 
	ret 

exec_command:
	ldw x,#tib 
	ld a,(x)
	cp a,#'? 
	jreq enquiry 
	cp a,#'S 
	jreq dev_sel 
	cp a,#'R 
	jreq read_sector 
	cp a,#'W 
	jreq write_sector 
	cp a,#'X 
	jreq erase_sector 
	cp a,#'@ 
	jreq xram_fetch 
	cp a,#'! 
	jreq xram_store 
enquiry: parameters: none | output: dev_Id, total_sector_count, first free sector#

dev_sel: parameters: drive letter | output dev_id, ACK 
	
read_sector: ; parameters: sector_number count | output: count bytes sent back to computer

write_sector: ; parameters: sector_number, byte_count, data...

erase_sector: ; parameters: sector_number | sector_number ACK 

xram_fetch: ; parameters: address, byte_count | count bytes sent back to computer 

xram_store: ; parameters: address byte_count data... | output  count, ACK 

	ret 





