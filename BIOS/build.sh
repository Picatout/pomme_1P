# build BIOS 

ca65 -l../build/bios.lst -o../build/bios.o bios.s  && cl65 -C bios.cfg  ../build/bios.o 
