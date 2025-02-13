NAME=stm32-pomme
# tools
PREFIX=arm-none-eabi-
CC=$(PREFIX)gcc
AS=$(PREFIX)as 
LD=$(PREFIX)ld
DBG=gdb-multiarch
OBJDUMP=$(PREFIX)objdump
OBJCOPY=$(PREFIX)objcopy

#build directory
BUILD_DIR=build/
#Link file
LD_FILE=stm32g431kb.ld 
#sources
SRC=$(NAME).s terminal.s p2Basic.s
OBJ=$(BUILD_DIR)$(NAME).o $(BUILD_DIR)terminal.o $(BUILD_DIR)p2Basic.o
# programmer
VERSION=STLINKV3 
STV3_PROG_SN=004C00343137510339383538
#NUCLEO-G431KB board 
NUCLEO_G431KB_LD_FILE=stm32g431kb.ld 
NUCLEO_G431KB_FLAGS=-mmcu=stm32g431kb 


SERIAL=$(STV3_PROG_SN)


.PHONY: all 

all: clean build

build:  $(SRC) *.inc Makefile $(LD_FILE)
	$(AS) -a=$(BUILD_DIR)$(NAME).lst $(NAME).s -g -o$(BUILD_DIR)$(NAME).o 
	$(AS) -a=$(BUILD_DIR)terminal.lst terminal.s -g -o$(BUILD_DIR)terminal.o 
	$(AS) -a=$(BUILD_DIR)p2Basic.lst p2Basic.s -g -o$(BUILD_DIR)p2Basic.o 
	$(LD) $(LD_FLAGS) -T $(LD_FILE) -g $(OBJ) -o $(BUILD_DIR)$(NAME).elf
	$(OBJCOPY) -O binary $(BUILD_DIR)$(NAME).elf $(BUILD_DIR)$(NAME).bin 
	$(OBJCOPY) -O ihex $(BUILD_DIR)$(NAME).elf $(BUILD_DIR)$(NAME).hex  
	$(OBJDUMP) -D $(BUILD_DIR)$(NAME).elf > $(BUILD_DIR)$(NAME).dasm


flash: $(BUILD_DIR)$(NAME).bin 
	st-flash --serial=$(SERIAL) erase 
	st-flash  --serial=$(SERIAL)  write $(BUILD_DIR)$(NAME).bin 0x8000000

debug: 
	cd $(BUILD_DIR) &&\
	$(DBG) -tui --eval-command="target remote localhost:4242" $(NAME).elf



.PHONY: clean 

clean:
	$(RM) build/*
