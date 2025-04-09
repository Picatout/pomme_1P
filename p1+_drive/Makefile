#############################
# p1+_terminal make file
#############################
NAME=p1+_drive
SDAS=sdasstm8
SDCC=sdcc
SDAR=sdar
OBJCPY=objcpy 
CFLAGS=-mstm8 -lstm8
INC=inc/
INCLUDES=$(MCU_INC) $(INC)ascii.inc $(INC)gen_macros.inc app_macros.inc 
BUILD=build/
SRC=hardware_init.asm std_func.asm uart.asm spi.asm  
OBJECT=$(BUILD)$(NAME).rel
OBJECTS=$(BUILD)$(SRC:.asm=.rel)
LIST=$(BUILD)$(NAME).lst
FLASH=stm8flash


.PHONY: all

all: clean 
	#
	# "*************************************"
	# "compiling $(NAME)  for $(MCU)      "
	# "*************************************"
	$(SDAS) -g -l -o $(BUILD)$(NAME).rel $(SRC) 
	$(SDCC) $(CFLAGS) -Wl-u -o $(BUILD)$(NAME).ihx $(OBJECT) 
	objcopy -Iihex -Obinary  $(BUILD)$(NAME).ihx $(BUILD)$(NAME).bin 
	# 
	@ls -l  $(BUILD)$(NAME).bin 
	# 


.PHONY: clean 
clean:
	#
	# "***************"
	# "cleaning files"
	# "***************"
	rm -f $(BUILD)*


flash: $(LIB)
	#
	# "******************"
	# "flashing $(MCU) "
	# "******************"
	$(FLASH) -c $(PROGRAMMER) -p $(MCU) -s flash -w $(BUILD)$(NAME).ihx 

# read flash memory 
read: 
	$(FLASH) -c $(PROGRAMMER) -p $(MCU) -s flash -b 16384 -r flash.dat 

# erase flash memory from 0x8000-0xffff 
erase:
	dd if=/dev/zero bs=1 count=32768 of=zero.bin
	$(FLASH) -c $(PROGRAMMER) -p$(MCU) -s flash -b 32768 -w zero.bin 
	rm -f zero.bin 

.PHONY: ee_clear 
# erase eeprom 
ee_clear: 
	dd if=/dev/zero bs=1 count=16 of=zero.bin
	$(FLASH) -c $(PROGRAMMER) -p$(MCU) -s eeprom 16 -w zero.bin 
	rm -f zero.bin 
 
