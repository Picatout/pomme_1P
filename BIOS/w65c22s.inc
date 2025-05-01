;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;  W65C22S 
;;  registers and bit fields 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; registers, VIA_BASE address define before including this file.
    VIA_IORB = VIA_BASE+0 ; input/output data register port B 
    VIA_IORA = VIA_BASE+1 ; input/output data register port A
    VIA_DDRB = VIA_BASE+2 ; Data direction register port B 
    VIA_DDRA = VIA_BASE+3 ; Data direction register port A
    VIA_T1CL =  VIA_BASE+4 ; timer1 low order counter 
    VIA_T1CH =  VIA_BASE+5 ; timer1 high order counter 
    VIA_T1LL =  VIA_BASE+6 ; timer1 low order latch 
    VIA_T1LH =  VIA_BASE+7 ; timer 1 high order latch 
    VIA_T2CL =  VIA_BASE+8 ; timer 2 low order counter 
    VIA_T2CH = VIA_BASE+9  ; timere 2 high order counter 
    VIA_SR  =  VIA_BASE+$A  ; shift register 
    VIA_ACR =  VIA_BASE+$B  ; auxiliary control register 
    VIA_PCR =  VIA_BASE+$C  ; peripheral control register 
    VIA_IFR =  VIA_BASE+$D  ; interrupt flags register 
    VIA_IER =  VIA_BASE+$E  ; interrupt enable register 
    VIA_IORA_NHS = VIA_BASE+$F ; input/output data register A, no handshake 

; VIA_IER bits 
    VIA_CA2_IE=(1<<0)   ; CA1 interrupt enable 
    VIA_CA1_IE=(1<<1)   ; CA2 interrupt enable 
    VIA_SR_IE=(1<<2) ; to set interrupt on shift register in VIA_IER 
    VIA_CB2_IE=(1<<3) ; CB2 interrupt enable 
    VIA_T2_IE=(1<<5) ; timer 2 interrupt enable bit in VIA_IER 
    VIA_T1_IE=(1<<6) ; timer 1 interrupt enable bit in VIA_IER 
    VIA_SET_IE=(1<<7) ; bit 7==1 , set interrupt bit, 0 clear it.
    
; VIA_IFR bits 
    VIA_CA2_IF=(1<<0)   ; CA1 interrupt flag 
    VIA_CA1_IF=(1<<1)   ; CA2 interrupt flag 
    VIA_SR_IF=(1<<2) ; shift register interrupt flag in VIA_IFR 
    VIA_CB2_IF=(1<<3) ; CB2 interrupt flag 
    VIA_T2_IF=(1<<5) ; timer 2 interrupt flag bit in VIA_IFR 
    VIA_T1_IF=(1<<6) ; timer 1 interrupt flag bit in VIA_IFR 
    VIA_IRQ_IF=(1<<7) ; set when IRQ pin is low

; VIA_PCR bit fields 
    CA1_EDGE=0 ; edge triggerred interrupt, 0 negative, 1 positive 
    CA2_MODE=1 ; 3 bits field 3..1, select pin mode 
    CB1_EDGE=4 ; edge triggered interrtupt, 0 negative, 1 positive
    CB2_MODE=5 ; 3 bits field 7..5, select pin mode 

 ; CB2 pin modes 
    CB2_NEDGE_ACT=0 ; Input-negative active edge
    CB2_IND_NEDGE=1 ; Independent interrupt input-negative edge
    CB2_PEDGE_ACT=2 ; Input-positive active edge
    CB2_IND_PEDGE=3 ; Independent interrupt input-positive edge
    CB2_HS_OUT=4    ;  Handshake output
    CB2_PULSE_OUT=5 ; Pulse output
    CB2_LOW_OUT=6   ; Low output
    CB2_HIGH_OUT=7  ; high output 

;  CA2 pin modes 
    CA2_NEDGE_ACT=0 ; Input-negative active edge
    CA2_IND_NEDGE=1 ; Independent interrupt input-negative edge
    CA2_PEDGE_ACT=2 ; Input-positive active edge
    CA2_IND_PEDGE=3 ; Independent interrupt input-positive edge
    CA2_HS_OUT=4    ;  Handshake output
    CA2_PULSE_OUT=5 ; Pulse output
    CA2_LOW_OUT=6   ; Low output
    CA2_HIGH_OUT=7  ; high output 

; VIA_ACR bits fields 
    ACR_PB_LATCH=0 ; enable disable latch  on PB 
    ACR_PA_LATCH=1 ; enable disable latcth on PA 
    ACR_SR_MODE=2  ; 3 bits fields 4..2
    ACR_T2_CTRL=3  ; timer 2 control  
    ACR_T1_CTRL=4  ; 2 bits field 5..4, timer 1 control 
    ACR_T1_MODE=6  ; 2 bits field 7..6, timer 1 operating mode 

; VIA_ACR shift register mode 
    SHIFT_DISABLE=0  ; disable shift register 
    SHIFT_IN_T2=1    ; Shift in, T2 clock 
    SHIFT_IN_PHI2=2  ; shift in, PHI2 clock 
    SHIFT_IN_EXT=3   ; Shift in, external clock
    SHIFT_OUT_T2=4   ; shift out, T2 clock free running 
    SHIFT_OUT_T2C=5  ; shift out, T2 clock controlled  
    SHIFT_OUT_PHI2=6 ; shift out, PHI2 clock
    SHIFT_OUT_EXT=7  ; shift out, external clock   
    SHIFT_MASK = (7<<ACR_SR_MODE) ; field mask

; VIA_ACR timer 1 operation modes
    T1_INTR_LOAD=0 ; Timed interrupt each time T1 is loaded     
    T1_INTR_CONT=1 ; Continuous interrupts
    T1_PB7_PULSE=2 ; PB7 One pulse output 
    T1_PB7_SQRWAV=3 ; PB7 square wave output 

