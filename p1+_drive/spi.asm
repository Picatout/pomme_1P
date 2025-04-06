;;
; Copyright Jacques Deschênes 2025 
; This file is part of pomme_1+ 
;
;     pomme_1+ is free software: you can redistribute it and/or modify
;     it under the terms of the GNU General Public License as published by
;     the Free Software Foundation, either version 3 of the License, or
;     (at your option) any later version.
;
;     pomme_1+ is distributed in the hope that it will be useful,
;     but WITHOUT ANY WARRANTY; without even the implied warranty of
;     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;     GNU General Public License for more details.
;
;     You should have received a copy of the GNU General Public License
;     along with pomme_1+.  If not, see <http://www.gnu.org/licenses/>.
;;

;-------------------------------
;  SPI peripheral support
;  low level driver 
;--------------------------------

	.module SPI 


    .module SPI    

;-------------------------
;  SPI interface 
;-------------------------
; SPI port 
SPI_PORT= PC_BASE
SPI_ODR=PC_ODR 
SPI_IDR=PC_IDR 
SPI_DDR=PC_DDR 
SPI_CR1=PC_CR1 
SPI_CR2=PC_CR2 
; spi pins bits 
SPI_MISO= 7;PC7 
SPI_MOSI= 6;PC6
SPI_CLK=  5;PC5 
; SPI channel select pins 
SPI_CS0=3   ; PC3 FLASH0  
SPI_CS1=4   ; PC4 FLASH1  
FLASH0=SPI_CS0 ; fixed internal
FLASH1=SPI_CS1 ; removable external 


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; W25Q FLASH memory parameters 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
W25Q_PAGE_SIZE=256 ; bytes 
W25Q_ERASE_BLOCK_SIZE=4096 ; byts 
W25Q_ADR_SIZE=3 ; address size in bytes 
;-----------------------------------------------
; W25Q80DV programming
; 1) set /CS TO 0  
; 2) enable FLASH WRITE with WREN cmd 
; 3) send 24 bits address most significant byte first  
; 4) send data bytes up to W25Q_PAGE_SIZE 
; 5) rise /CS to 1  
;-----------------------------------------------
W25Q_SECTOR_SIZE=4096 ; bytes 
SR1_BUSY=0  ; busy writting/erasing bit position in SR1   
SR1_WEL=1  ; write enable bit position in SR1  
; W25Q commands 
W25Q_WREN=6      ; set WEL bit 
W25Q_READ=3  ; can read sequential address no size limit.
W25Q_WRITE=2 ; program up to W25_PAGE_SIZE at once.
W25Q_B4K_ERASE=0x20   ; erase 4KB block   
W25Q_B32K_ERASE=0x52 ; erase 32KB block 
W25Q_B64K_ERASE=0XD8 ; erase 64KB block 
W25Q_CHIP_ERASE=0xC7   ; whole memory  
W25Q_READ_SR1=6 ; read status register 1
W25Q_JEDEC_ID=0x9F ; 
	.area DATA 
flash_size: .blkb 1 ; in MB
spi_device: .blkb 1 ; selected spi device 

	.area DATA 
	.org 0x100  

flash_buffer: .blkb W25Q_SECTOR_SIZE ; 4096 bytes 


    .area CODE 


;---------------------------------
; enable SPI peripheral to maximum 
; frequency = Fspi=Fmstr/2 
; input:
;    none  
; output:
;    none 
;--------------------------------- 
spi_init::
	bset CLK_PCKENR1,#CLK_PCKENR1_SPI ; enable clock signal 
; configure ~CS  
;	bres SPI_CR1,#SPI_CS0 ; 10K external pull up  
	bset SPI_DDR,#SPI_CS0 
	bset SPI_ODR,#SPI_CS0   ; deselet channel 
;	bres SPI_CR1,#SPI_CS1 ; 10K external pull up  
	bset SPI_DDR,#SPI_CS1  
	bset SPI_ODR,#SPI_CS1  ; deselect channel 
; interrupts not used 
	clr SPI_ICR ; no interrupt enabled 
; master/slave mode controlled by sofware 	
ret 
	ld a,#(1<<SPI_CR2_SSM)+(1<<SPI_CR2_SSI) ; master mode 
	ld SPI_CR2,a 
ld a,SPI_CR2
call uart_print_hex_byte 	
; configure SPI as master mode 0 and enable.	
	ld a,#(1<<SPI_CR1_MSTR)+(1<<SPI_CR1_SPE)
	ld SPI_CR1,a 
	btjf SPI_SR,#SPI_SR_RXNE,9$ 
	ld a,SPI_DR 
;select default device 
9$:	ld a,#FLASH0  ; internal flash memory 
	call create_bit_mask
	_straz spi_device 
	ret 

;----------------------------
; disable SPI peripheral 
;----------------------------
spi_disable::
; wait spi idle 
	btjf SPI_SR,#SPI_SR_TXE,. 
	btjf SPI_SR,#SPI_SR_RXNE,. 
	btjt SPI_SR,#SPI_SR_BSY,.
	bres SPI_CR1,#SPI_CR1_SPE
	bres CLK_PCKENR1,#CLK_PCKENR1_SPI 
	bres SPI_DDR,#SPI_CS0 
	bres SPI_DDR,#SPI_CS1  
	ret 

;------------------------
; clear SPI error 
;-----------------------
spi_clear_error::
	ld a,#0x78 
	bcp a,SPI_SR 
	jreq 1$
	clr SPI_SR 
1$: ret 

;----------------------
; send byte 
; input:
;   A     byte to send 
; output:
;   A     byte received 
;----------------------
spi_send_byte::
	push a 
	call spi_clear_error
	pop a 
	btjf SPI_SR,#SPI_SR_TXE,.
	ld SPI_DR,a
	btjf SPI_SR,#SPI_SR_RXNE,.  
	ld a,SPI_DR 
	ret 

;------------------------------
;  receive SPI byte 
; output:
;    A 
;------------------------------
spi_rcv_byte::
	clr a 
	btjf SPI_SR,#SPI_SR_RXNE,spi_send_byte 
	ld a,SPI_DR 
	ret

;----------------------------
;  create bit mask
;  input:
;     A     bit 
;  output:
;     A     2^bit 
;-----------------------------
create_bit_mask::
	push a 
	ld a,#1 
	tnz (1,sp)
	jreq 9$
1$:
	sll a 
	dec (1,sp)
	jrne 1$
9$: _drop 1
	ret 

;-------------------------------
; SPI select device  
; input:
;   A    device FLASH0 || 
;               FLASH1 
;--------------------------------
spi_select_device::
	call create_bit_mask
	_straz spi_device 
	ret 

;--------------------------
; open selected channel 
;--------------------------
open_channel:
	push a 
	_ldaz spi_device 
	cpl a  
	and a,SPI_ODR 
	ld SPI_ODR,a 
	pop a  
	ret 


;------------------------------
; SPI deselect channel 
;-------------------------------
close_channel::
	push a 
	btjt SPI_SR,#SPI_SR_BSY,.
	_ldaz spi_device 
	or a,SPI_ODR 
	ld SPI_ODR,a 
	pop a  
	ret 

;-----------------------------
; send 24 bits address to 
; opened device,  
; input:
;   farptr   address 
;------------------------------
spi_send_addr::
	_ldaz farptr 
	call spi_send_byte 
	_ldaz ptr16 
	call spi_send_byte 
	_ldaz ptr8 
	call spi_send_byte 
	ret 

;---------------------
; enable write to flash  
;----------------------
flash_enable_write:
	call open_channel 
	ld a,#W25Q_WREN 
	call spi_send_byte 
	call close_channel 
	ret 

;----------------------------
;  read flash status register
;----------------------------
flash_read_status:
	call open_channel 
	ld a,#W25Q_READ_SR1 
	call spi_send_byte
	call spi_rcv_byte 
	call close_channel
	ret

;------------------------------
;  poll busy bit in SR1 
;  of selected channel 
;  until operation end 
;-------------------------------
busy_polling:
1$:	call flash_read_status 
	bcp a,#(1<<SR1_BUSY)
	jrne 1$
	ret 

;----------------------------
; write data to W25Q80DV
; selected device  
; input:
;   farptr  address 
;   A       byte count, 0 == 256
;   X       buffer address 
; output:
;   none 
;----------------------------
	BUF_ADR=1 
	COUNT=BUF_ADR+2
	VSIZE=COUNT 
flash_write::
	push a 
	pushw x
	call flash_enable_write
	call open_channel 
	ld a,#W25Q_WRITE 
	call spi_send_byte 
	call spi_send_addr 
	ldw x,(BUF_ADR,sp)
1$:
	ld a,(x)
	call spi_send_byte
	incw x
	dec (COUNT,sp) 
	jrne 1$ 
6$: 
	call close_channel
	call busy_polling ; wait completion 
	_drop VSIZE
	ret 

;-------------------------- 
; read bytes from flash 
; memory in buffer 
; input:
;   farptr flash memory address  
;   x     count, {0..4095],0=W25_BUFFER_SIZE
;   y     buffer addr
;---------------------------
flash_read::
	pushw x 
	call open_channel
	ld a,#W25Q_READ 
	call spi_send_byte
	call spi_send_addr  
1$: call spi_rcv_byte 
	ld (y),a 
	incw y 
	ldw x,(1,sp)
	decw x
	ldw (1,sp),x 
	jrne 1$ 
9$: 
	call close_channel
	_drop 2 
	ret 

;--------------------
; return true if 
; page empty 
; input:
;    X   page# 
; output:
;    A   -1 true||0 false 
;    X   not changed 
;-------------------------
flash_page_empty:
	pushw x 
	call page_addr 
	call open_channel
	ld a,#W25Q_READ  
	call spi_send_byte 
	call spi_send_addr
	push #0 
1$:	call spi_rcv_byte 
	cp a,#0xff 
	jrne 8$ 
	dec (1,sp)
	jrne 1$ 
	cpl (1,sp) 
	jra 9$
8$: clr (1,sp) 
9$: 
	call close_channel
	pop a 
	popw x 
	ret 

;--------------------------
; compute 4KB block address 
; input:
;    X   block number {0..255}
; output:
;    farptr  address 
;--------------------------
b4k_address:
	push a 
	ld a,xl
	push a
	and a,#15
	swap a  
	ld xh,a 
	clr a 
	ld xl,a 
	pop a 
	and a,#0xf0 
	swap a 
; A:X=X*4096
	jra stor_addr 

;---------------------------
; compute 32KB block address 
; input:
;    X    block number {0..31}
; output:
;    farptr   address 
;----------------------------
b32k_address:
	push a 
	clr a 
	swapw x ; X*256 
	srlw x  ; X/2  
	rlwa x  ; A:X =X*32767
	jra stor_addr  

;---------------------------
; compute 64KB block address 
; input:
;    X    block number {0..15}
; output:
;    farptr   address 
;----------------------------
b64k_address:
	push a 
	ld a,xl
	clrw x  ; A:X=X*65536
stor_addr:	 
	_straz farptr 
	_strxz ptr16 
	pop a 
	ret 


;----------------------
; erase 32KB|64KB block  
; device already selected 
; input:
;   A    W25Q_B4K_ERASE||W25Q_B32K_ERASE||W25Q_B64K_ERASE 
;   X    block number 
;			4KB->{0.255}
;			32KB->{0..31}
;			64KB->{0..15}
; output:
;   none 
;----------------------
flash_block_erase:
	cp a,#W25Q_B4K_ERASE 
	jrne 1$ 
	call b4k_address
	jra flash_erase 
1$:
	cp a,#W25Q_B32K_ERASE
	jrne 2$ 
	call b32k_address
	jra flash_erase 
2$:
	call b64k_address 
flash_erase: 
	call open_channel 
	call spi_send_byte 
	call spi_send_addr 
	call close_channel
	call busy_polling
	ret 

;-----------------------------
; erase whole flash memory 
;-----------------------------
flash_chip_erase::
	call open_channel 
	ld a,#W25Q_CHIP_ERASE
	call spi_send_byte  
	call close_channel
	call busy_polling
	ret 

;----------------------------
; get JEDEC chip identifier 
; output:
;    A     memory size in MB 
;    XH    manufacturer ID 
;    XL    device ID 
;---------------------------
	MSIZE=3 
	MFG_ID=2 
	DEV_ID=1
	VSIZE=3
flash_chip_id:
	_vars VSIZE 
	call open_channel
	ld a,#W25Q_JEDEC_ID 
	call spi_send_byte
	call spi_rcv_byte
	ld (MFG_ID,sp),a 
	call spi_rcv_byte
	ld (DEV_ID,sp),a
	call spi_rcv_byte  
	call close_channel 
	ldw x,(DEV_ID,sp)
	_drop VSIZE 
	ret 

;---------------------------
; convert page number 
; to address addr=256*page#
; input:
;   X     page {0..511}
; ouput:
;   A:X    address
;   farptr address  
;---------------------------
page_addr:
	clr a 
	rlwa x
	_straz farptr 
	_strxz ptr16   
	ret 

;----------------------------
; convert address to page#
; expect 256 bytes page  
; input:
;   farptr   address 
; output:
;   X       page  {0..4095}
;----------------------------
addr_to_page::
	_ldxz farptr 
	ret 

;---- test code -----

; ----- spi FLASH test ---------
.if 1
flash_test_msg: .byte 27,'c 
.asciz "spi flash test\n"
jedec_id_msg: .asciz "JEDEC ID: "
no_empty_msg: .asciz " no empty page "
writing_msg: .asciz "\nwriting 256 bytes in page " 
reading_msg: .asciz "\nreading back\n" 
repeat_msg: .asciz "\nkey to repeat"
flash_test:
3$:
	ldw x,#jedec_id_msg 
	call uart_puts 
	call flash_chip_id
	call uart_print_hex_byte 
	call uart_space
	ld a,xh 
	call uart_print_hex_byte 
	call uart_space 
	ld a,xl 
	call uart_print_hex_byte  
	call uart_new_line
.endif 
.if 0	 
	ldw x,#flash_test_msg 
	call uart_puts 
	ldw x,#writing_msg   
	call uart_puts 
; search empty page 
	clrw x
7$:
	pushw x 
	call uart_print_hex 
	popw x 
	call flash_page_empty
	tnz a 
	jrmi 5$
	incw x 
	cpw x,#512
	jrmi 7$
	ld a,#W25Q_B4K_ERASE
	call flash_block_erase
	ldw x,#no_empty_msg 
	call uart_puts 
	call prng
	rlwa x 
	and a,#1 
	rrwa x 
5$: pushw x  
	call uart_print_hex 
	call uart_new_line 
	popw x 
	call page_addr 
; fill buffer with 256 random byte 
0$:
	push #256
	ldw y,#flash_buffer  
1$:
	call prng 
	ldw (y),x
	ld a,xh 
	call uart_print_hex_byte
	call uart_space  
	ld a,xl 
	call uart_print_hex_byte 
	call uart_space 
	addw y,#2 
	pop a 
	dec a 
	jreq 4$
	push a 
	and a,#7 
	jrne 1$ 
	call uart_new_line 
	jra 1$ 
4$:
	ld a,#256 
	ldw x,#flash_buffer 
	call flash_write
; clear tib
	ldw x,#flash_buffer
	ld a,#256
6$:	clr (x)
	incw x 
	dec a 
	jrne 6$
;read back written data 
	ldw x,#reading_msg 
	call uart_puts 
	ldw y,#flash_buffer 
	ldw x,#256 
	call flash_read 
	push #256
	ldw y,#flash_buffer 
2$: ld a,(y)
	call uart_print_hex_byte 
	call uart_space 
	incw y
	pop a 
	dec a
	jreq 9$  
	push a  
	and a,#15 
	jrne 2$
	call uart_new_line
	jra 2$  
9$:	
	ldw x,#repeat_msg
	call uart_puts 
	call getc
	jp 3$
.endif 
