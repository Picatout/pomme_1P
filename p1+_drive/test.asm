;--------------------------
;   tests unit 
;--------------------------

.if UART_TEST  
;-----------------------
; UART test code 
; print message 
; then echo entered 
; characters
; qui when 'Q' entered 
;------------------------
uart_test:
	call uart_cls 
	ldw x,#qbf 
	call uart_puts
	call uart_new_line
1$:
	call uart_getc
	cp a,#'Q
	jreq 9$ 
	call uart_putc
	jra 1$   
9$:	ret 
.endif ; UART_TEST  
qbf: .asciz "THE QUICK BROWN FOX JUMP OVER THE LAZY DOG.\rThe quick brown fox jump over the lazy dog.\recho test 'Q'uit"

; ----- spi FLASH test ---------
.if FLASH_TEST 
dev_id: .asciz "device id: " 
dev_size: .asciz ", device size MB: "
no_empty_msg: .asciz " no empty page "
writing_msg: .asciz "writing 256 bytes in page " 
reading_msg: .asciz "reading back\r" 
erase_msg: .asciz "erasing block 0\r"
done_msg: .asciz "test completed\r"
flash_test:
	call uart_cls 
	ldw x,#dev_id  
	call uart_puts 
	call device_id
	call uart_print_hex_byte 
	ldw x,#dev_size 
	call uart_puts 
	clrw x 
	_ldaz device_size 
	ld xl,a 
	call uart_print_int 
	call next_test 
	ldw x,#writing_msg   
	call uart_puts 
; search empty page 
	clrw x
7$:
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
; fill buffer with 256 random bytes 
0$:
	push #0
	ldw y,#flash_buffer  
1$: 
	call prng 
	ld a,xl 
	ld (y),a 
	incw y 
	dec (1,sp)
	jrne 1$
	call print_buffer 
	clr a 
	ldw x,#flash_buffer 
	call flash_write
; clear buffer 
	ld a,#255 
	ldw x,#flash_buffer
6$:	clr (x)
	incw x 
	dec a 
	cp a,#255 
	jrne 6$ 
;read back written data 
	ldw x,#reading_msg 
	call uart_puts 
	ldw y,#flash_buffer 
	ldw x,#256 
	call flash_read 
	call print_buffer 
; erasing block 0
	_clrz farptr 
	clrw x 
	_strxz ptr16
	ldw x,#erase_msg 
	call uart_puts 
	ld a,#W25Q_B4K_ERASE
	clrw x 
	call flash_block_erase
; reaading page 0
	_clrz farptr 
	clrw x  
	_strxz ptr16
	ldw x,#reading_msg
	call uart_puts 
	ldw x,#256
	call flash_read 
	call print_buffer 
	ldw x,#done_msg 
	call uart_puts 
	jra . 


prompt: .asciz "any key for next test."
next_test:
	call uart_new_line
	ldw x,#prompt
	call uart_puts 
	call uart_getc 
	call uart_new_line	
	ret

; print 256 byte in buffer 
print_buffer:
	call uart_new_line
	push #0 
	ldw x,#flash_buffer 
1$: 
	ld a,(x)
	call uart_print_hex_byte
	call uart_space 
	incw x 
	dec (1,sp)
	ld a,(1,sp) 
	cp a,#0
	jreq 9$ 
	and a,#0xF 
	jrne 1$ 
	call uart_new_line
	jra 1$
9$: 
	call uart_new_line
	pop a	
	ret 

.endif 

.if XRAM_TEST 
xram_test:
	call uart_cls
	ldw x,#xram_test_msg 
	call uart_puts
	ldw x,#qbf 
	ldw y,#flash_buffer 
1$: ld a,(x)
	ld (y),a 
	incw x 
	incw y 
	tnz a 
	jrne 1$ 
	clr a 
	clrw x 
	ldw y,#88 
	call xram_write 
	ld a,#100
	ldw x,#flash_buffer 
2$: clr (x)
	incw x 
	dec a 
	jrne 2$ 
	clr a 
	clrw x 
	ldw y,#88
	call xram_read 
	ldw x,#flash_buffer 
	call uart_puts 
	ret 
xram_test_msg: .asciz "XRAM test\r" 
.endif 


.if DRV_CMD_TEST 
drive_cmd_test:

    ret 

.endif 


