@echo off
del *.rel *.lst *.rst *.ihx *.hex *.map *.o *.sym *.lnk

as-z80 -o crt0.o crt0.s

call compile basic.c
call compile malloc.c

sdcc "-Wl -b _CODE2 = 0x8000" -mz80 --no-std-crt0 --code-loc 0x0290 --code-size 0x5d70 --data-loc 0x6000 crt0.o malloc.o basic.o

ren crt0.ihx basic.ihx

if not exist basic.ihx goto end
..\Tools\ihx2bin basic.ihx basic.bin 640 > ihx2bin.log
..\Tools\DZ80-32.EXE basic.bin basic_dis.asm /m=640
:end
