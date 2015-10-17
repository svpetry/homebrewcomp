@echo off
del *.rel *.lst *.rst *.ihx *.hex *.map *.o *.sym *.lnk

sdasz80 -o crt0.s

call compile basic.c
call compile ..\Lib\io.c
call compile ..\Lib\utils.c
call compile ..\Lib\bios_text.c
call compile ..\Lib\bios_file.c
call compile ..\Lib\malloc.c
call compile utils_b0.c
call compile mybasic.c
call compile basic_helpers.c
call compile vars.c
call compile ftoa.c

sdcc -mz80 "-Wl -b _CODE2 = 0x8000" --no-std-crt0 --code-loc 0x1290 --code-size 0x5370 --data-loc 0x6800 crt0.rel basic.rel io.rel utils.rel bios_text.rel bios_file.rel malloc.rel utils_b0.rel mybasic.rel basic_helpers.rel vars.rel ftoa.rel

ren crt0.ihx basic.ihx

if not exist basic.ihx goto end
..\..\Tools\ihx2bin basic.ihx basic.bin 4736 > ihx2bin.log
..\..\Tools\dZ80c basic.bin basic_dis.asm -m=4736

copy basic.bin ..\..\SDCard
:end
