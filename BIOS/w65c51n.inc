;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; W65C51N
;; registers and bits fields
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; registers addresses, base address 
; defined before including this file
	ACIA_DATA = ACIA_BASE+0 ; input|output data register 
	ACIA_STATUS = ACIA_BASE+1 ; status register 
	ACIA_CMD = ACIA_BASE+2  ; 
	ACIA_CTRL = ACIA_BASE+3

; ACIA_STATUS bit fields 
    ACIA_STATUS_PARITY=0 ; parity error 
    ACIA_STATUS_FRAME=1  ; framing error 
    ACIA_STATUS_OVER=2   ; overrun error 
	ACIA_STATUS_RX_FULL = 3 ; receive buffer full 
    ACIA_STATUS_TX_EMPTY= 4 ; transmit register empty (buggy dont't use )
    ACIA_STATUS_DCD=5 ; carrier detect 
    ACIA_STATUS_DSR=6 ; data set ready 
    ACIA_STATUS_IRQ=7 ; set when rx full 

; ACIA_CTRL bit fields 
    ACIA_CTRL_BAUD=0 ; 4 bits field 3..0, baud rate
    ACIA_CTRL_RX_CLK=4 ; receive clock, 0 external, 1 rx baud 
    ACIA_CTRL_WL=5     ; 2 bits field 6..5,  word length {8,7,6,5}  
    ACIA_CTRL_SBN=7    ; stop bits {1,2,1.5 if WL=5}

; ACIA_CMD bit fields 
    ACIA_CMD_DTR=0     ; control DTR output 0->DTRB=HIGH, 1->DTRB=LOW 
    ACIA_CMD_RX_IE=1   ; set interrupt on receive 
    ACIA_CMD_TX_IE=2   ; 2 bits field 3..2, transmit interrupt control (buggy dont't use )
    ACIA_CMD_REM=4     ; echo received character, 0->disabled 
    ACIA_CMD_PME=5     ; parity mode, 0-> disabled, (not supported)
    ACIA_CMD_PMC=6     ; 2 bits field 7..6, parity control mode, (not supported)
    
     
