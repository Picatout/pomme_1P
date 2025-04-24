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

;-------------------------------------------------------------
; Parallel interface handshaking 
; reveiving:
; 	when the computer write un byte to PIA port A it signal it 
; 	by a pulse on CA2. The falling edge trigger an interrupt. 
; 	PBusIntHandler read the byte and store it in rx_queue.
; 	It signal that it is ready for next byte 
; 	by a pulse on CA1
; Transmitting:
;   To transmit to computer the drive wait that CA2 is low 
;   it write to ITF_ODR and pulse ITF_CTRL_CA1 to signal 
;   The computer pulse CA2 to signal ready for next transmit. 
;
; The drive works in slave mode it stay idle until it receive 
; a command. 
;--------------------------------------------------------------

;------------------------------------------
;  COMMANDS 
;  'S'    dev   select device 
;  'W'    sect  count data write device  
;  'R'    sect  count  read device 
;  'X'    sect  count  mark as erased 
;  '?'    device size in sectors count
;  '!'     addr   count, write to xram 
;  '@'    addr   count, read from xram 
;  each sector is 256 bytes 
;  sector format 
;  FIELD    SIZE    DESCRIPTION 
;    0        3     erased counter, how many times 4096 bytes block was erazed 
;    1        1     0 if sector erased, 0xff otherwise   
;    2        1     count of actual data bytes 
;    3        2     next sector link, 0 mark end of file 
;    4        1     free   
;    5       248    data bytes    
;-------------------------------------------------------------
;  commands format
;  SOH  command letter parameters [data] EOT 
;  SOH  is ASCII start of heading  0x01
;  EOT  is ASCII end of transmission  0x04
;  when a write as been completed then send next free sector #
;  used in link field.   
;-------------------------------------------------------------
    .module DRV_CMD 

	.area CODE 

;-------------------------------
;  devices map 
;-------------------------------
DEV_A=0 ; A: 
DEV_B=2 ; B: 
DEV_C=3 ; C: 
; XRAM not mapped as file device 
drives_map: .byte FLASH0,FLASH1,FLASH2,FLASH3 

;--------------------------------
; data received from computer 
; store it in queue
; and signal ready for next 
; byte  
;--------------------------------
PBusIntHandler:
	bset ITF_CTRL_ODR,#ITF_CA1
	btjf flags,#FTX,1$ 
; delay for pulse length
; ~1µsec 
	ld a,#5 
0$: dec a 
	jrne 0$ 
	jra 2$ 
1$:
	ld a,ITF_IDR
	call store_byte_in_queue
2$:	
	bres ITF_CTRL_ODR,#ITF_CA1
	iret 


;-------------------------------
; initialize parrallel interface 
; with computer. 
; 8 bits bus transfert 
; with 2 control lines  
; ITF_PORT stay as input as default mode 
; ITF_CTRL_CA2 stay as input 
;-------------------------------
itf_init:
; ITF_CA1 as output push-pull 
	bset ITF_CTRL_CR1,#ITF_CA1 ; push pull output 
	bset ITF_CTRL_DDR,#ITF_CA1; output mode
	bres ITF_CTRL_ODR,#ITF_CA1
; set external interrupt on ITF_CA2 
; to signal byte received on bus
	bset EXTI_CR,#ITF_CA2_PBIS ; rising edge on CA2 trigger interrupt 
; enable external interrupt on ITF_CA2 
	bset ITF_CR2,#ITF_CA2 
; reset transmit flag 
	bres flags,#FTX 
	ret 


;----------------------------------
; write byte to parallel interface 
; input:
;   A    byte to write 
;---------------------------------
itf_write_byte:
    bset flags,#FTX  
    btjf flags,#FCOMP_RDY,.
    ld ITF_ODR,a 
    bset ITF_CTRL_ODR,#ITF_CA1 
    ld a,#5 
1$: dec a 
    jrne 1$ 
    bres ITF_CTRL_ODR,#ITF_CA1 
	ret 

