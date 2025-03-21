;;
; Copyright Jacques Deschênes 2023  
; This file is part of stm8_terminal 
;
;     stm8_terminal is free software: you can redistribute it and/or modify
;     it under the terms of the GNU General Public License as published by
;     the Free Software Foundation, either version 3 of the License, or
;     (at your option) any later version.
;
;     stm8_terminal is distributed in the hope that it will be useful,
;     but WITHOUT ANY WARRANTY; without even the implied warranty of
;     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;     GNU General Public License for more details.
;
;     You should have received a copy of the GNU General Public License
;     along with stm8_terminal.  If not, see <http://www.gnu.org/licenses/>.
;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; hardware initialization
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 

;------------------------
; if unified compilation 
; must be first in list 
;-----------------------

    .module HW_INIT 

    .include "config.inc"

STACK_SIZE=128   
;;-----------------------------------
    .area SSEG (ABS)
;; working buffers and stack at end of RAM. 	
;;-----------------------------------
    .org RAM_SIZE-STACK_SIZE
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
	int ps2_intr_handler    ;int4 EXTI1 gpio B external interrupts
	int NonHandledInterrupt ;int5 EXTI2 gpio C external interrupts
	int NonHandledInterrupt ;int6 EXTI3 gpio D external interrupts
	int NonHandledInterrupt ;int7 EXTI4 gpio E external interrupts
	int NonHandledInterrupt ;int8 beCAN RX interrupt
	int NonHandledInterrupt ;int9 beCAN TX/ER/SC interrupt
	int NonHandledInterrupt ;int10 SPI End of transfer
	int ntsc_sync_interrupt ;int11 TIM1 update/overflow/underflow/trigger/break
	int ntsc_video_interrupt ; int12 TIM1 capture/compare
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
	int NonHandledInterrupt ;int26  not used
	int NonHandledInterrupt ;int27  not used
	int NonHandledInterrupt ;int28  not used
	int NonHandledInterrupt ;int29  not used


KERNEL_VAR_ORG=4
;--------------------------------------
    .area DATA (ABS)
	.org KERNEL_VAR_ORG 
;--------------------------------------	

; keep the following 3 variables in this order 
acc16:: .blkb 1 ; 16 bits accumulator, acc24 high-byte
acc8::  .blkb 1 ;  8 bits accumulator, acc24 low-byte  
ptr16::  .blkb 1 ; 16 bits pointer , farptr high-byte 
ptr8:   .blkb 1 ; 8 bits pointer, farptr low-byte  
flags:: .blkb 1 ; various boolean flags

; keyboard variables
; received scan codes queue 
SC_QUEUE_SIZE=32  
sc_queue: .blkb SC_QUEUE_SIZE ; scan codes queue 
sc_qhead: .blkb 1  ; sc_queue head index 
sc_qtail: .blkb 1  ; sc_queue tail index 
in_byte:  .blkb 1 ; shift in byte buffer 
parity:   .blkb 1 ; parity bit 
sc_rx_flags: .blkb 1 ; receive code flags 
sc_rx_phase: .blkb 1 ; scan code receive phase 
;; transmission to keyboard variables 
out_byte: .blkb 1 ; send byte to keyboard 
tx_bit_cntr: .blkb 1 ;bit counter for out_byte shifting.
tx_phase: .blkb 1 ; sending to keyboard phases 
tx_parity: .blkb 1 ; parity counter  

KBD_QUEUE_SIZE=16
kbd_queue: .blkb KBD_QUEUE_SIZE 
kbd_queue_head: .blkb 1 
kbd_queue_tail: .blkb 1 
kbd_state: .blkb 1 ; keyboard state flags 

; tvout variables 
ntsc_flags: .blkb 1 
ntsc_phase: .blkb 1 ; 
scan_line: .blkw 1 ; video lines {0..262} 
font_addr: .blkw 1 ; font table address 

; tv terminal variables 
cursor_x: .blkb 1 
cursor_y: .blkb 1 
cursor_delay: .blkb 1 ;  20/60 sec delay 
char_under: .blkb 1 ; character under cursor 
char_cursor: .blkb 1 ; character used for cursor 
saved_cx: .blkb 1 ; saved cursor position
saved_cy: .blkb 1 ; restored cursor position 

; uart variable 
RX_QUEUE_SIZE=64
rx1_queue: .ds RX_QUEUE_SIZE ; UART1 receive circular queue 
rx1_head:  .blkb 1 ; rx1_queue head pointer
rx1_tail:   .blkb 1 ; rx1_queue tail pointer  
dev_id:  .blkb 1 ; device identifier {0..3}, default 3  

; free ram for user font 
	.org 256 
user_font:

	.org RAM_SIZE-STACK_SIZE-(2*CHAR_PER_LINE*LINE_PER_SCREEN)
video_buffer: .blkw CHAR_PER_LINE*LINE_PER_SCREEN


	.area CODE 

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; do nothing interrupt UartRxHandler
; debug support 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
DoNothing:
	iret 

;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; non handled interrupt 
; reset MCU
;;;;;;;;;;;;;;;;;;;;;;;;;;;
NonHandledInterrupt:
	_swreset ; see "inc/gen_macros.inc"

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;    peripherals initialization
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;----------------------------
; if FMSTR>16Mhz 
; program 1 wait state in OPT7 
;----------------------------
wait_state:
	ld a,#FMSTR 
	cp a,#16 
	jrule no_ws 
set_ws:	; for FMSTR>16Mhz 1 wait required 
	tnz FLASH_WS ; OPT7  
	jrne opt_done ; already set  
	ld a,#1 
	jra prog_opt7 	
no_ws: ; FMSTR<=16Mhz no wait required 
	tnz FLASH_WS 
	jreq opt_done ; already cleared 
	clr a 
prog_opt7:
	call unlock_eeprom 
	ld FLASH_WS,a 
	cpl a 
	ld FLASH_WS+1,a 
	btjf FLASH_IAPSR,#FLASH_IAPSR_EOP,.
	btjf FLASH_IAPSR,#FLASH_IAPSR_HVOFF,.
	_swreset 
opt_done:
	ret  

unlock_eeprom:
	btjt FLASH_IAPSR,#FLASH_IAPSR_DUL,9$
	mov FLASH_CR2,#0 
	mov FLASH_NCR2,#0xFF 
	mov FLASH_DUKR,#FLASH_DUKR_KEY1
    mov FLASH_DUKR,#FLASH_DUKR_KEY2
	btjf FLASH_IAPSR,#FLASH_IAPSR_DUL,.
9$:	
    bset FLASH_CR2,#FLASH_CR2_OPT
    bres FLASH_NCR2,#FLASH_CR2_OPT 
	ret

;----------------------------------------
; inialize MCU clock 
; input:
;   A      CLK_CKDIVR , clock divisor
;   XL     HSI|HSE   
; output:
;   none 
;----------------------------------------
clock_init:	
; cpu clock divisor 
	push a   
	ld a,xl ; clock source CLK_SWR_HSI|CLK_SWR_HSE 
	bres CLK_SWCR,#CLK_SWCR_SWIF 
	cp a,CLK_CMSR 
	jreq 2$ ; no switching required 
; select clock source 
	bset CLK_SWCR,#CLK_SWCR_SWEN
	ld CLK_SWR,a
2$: 
	pop CLK_CKDIVR   	
	ret

.if 0	
;--------------------------
; set software interrupt 
; priority 
; input:
;   A    priority 1,2,3 
;   X    vector 
;---------------------------
	SPR_ADDR=1 
	PRIORITY=3
	SLOT=4
	MASKED=5  
	VSIZE=5
set_int_priority::
	_vars VSIZE
	and a,#3  
	ld (PRIORITY,sp),a 
	ld a,#4 
	div x,a 
	sll a  ; slot*2 
	ld (SLOT,sp),a
	addw x,#ITC_SPR1 
	ldw (SPR_ADDR,sp),x 
; build mask
	ldw x,#0xfffc 	
	ld a,(SLOT,sp)
	jreq 2$ 
	scf 
1$:	rlcw x 
	dec a 
	jrne 1$
2$:	ld a,xl 
; apply mask to slot 
	ldw x,(SPR_ADDR,sp)
	and a,(x)
	ld (MASKED,sp),a 
; shift priority to slot 
	ld a,(PRIORITY,sp)
	ld xl,a 
	ld a,(SLOT,sp)
	jreq 4$
3$:	sllw x 
	dec a 
	jrne 3$
4$:	ld a,xl 
	or a,(MASKED,sp)
	ldw x,(SPR_ADDR,sp)
	ld (x),a 
	_drop VSIZE 
	ret 
.endif 

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
; activate pull up on all inputs 
	ld a,#255 
	ld PA_CR1,a 
	ld PB_CR1,a 
	ld PC_CR1,a 
	ld PD_CR1,a
	ld PE_CR1,a 
	ld PF_CR1,a 
	ld PG_CR1,a 
	ld PI_CR1,a
	bres PD_CR1,#5 ; uart_tx 
    bres PD_CR1,#3 ; connected to PC6 
    bres PE_CR1,#5 ; connected to PD4 
; read device id switches 
	ld a,#DEV_ID_PORT
	and a, #((1<<DEV_ID0_BIT)+(1<<DEV_ID1_BIT))
	srl a 
	srl a 
	_straz dev_id  
; set user LED pin as output 
    bset LED_PORT+GPIO_CR1,#LED_BIT
    bset LED_PORT+GPIO_CR2,#LED_BIT
    bset LED_PORT+ GPIO_DDR,#LED_BIT
	_led_off 
; disable schmitt triggers on Arduino CN4 analog inputs
	mov ADC_TDRL,0x3f
    call wait_state 
; select external clock no divisor	
	clr a ; FMSTR no divisor 
    ldw x,#CLK_SWR_HSE ; external clock 
	call clock_init	
	call uart_init
	call ps2_init    
	rim ; enable interrupts 
	call ntsc_init ;

.if 1 ; TEST CODE 
ldw x,#width 
call tv_puts 
ldw x,#test 
call tv_puts 
jp main  
test: .asciz "THE QUICK BROWN FOX JUMP OVER THE LAZY DOG.\nThe quick bronw fox jump over the lazy dog.\n"
width: .asciz "123456789012345678901234567890123456789012345678901234567890123456789012345"
.endif ; TEST CODE 

	jp main ; in tv_term.asm 
