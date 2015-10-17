@echo off
del *.rel *.lst *.rst *.ihx *.hex *.map *.rel *.sym *.lnk *.noi

sdasz80 -o crt0.s

call compile bios.c
call compile video.c
call compile ..\Lib\io.c
call compile selftest.c

sdcc -mz80 "-Wl -b _CODE2 = 0x2000" --no-std-crt0 --code-loc 0x0a58 --code-size 0x2008 --data-loc 0x4000 crt0.rel bios.rel video.rel io.rel selftest.rel
ren crt0.ihx bios.ihx

if not exist bios.ihx goto end
..\..\Tools\ihx2bin bios.ihx bios.bin > ihx2bin.log
..\..\Tools\dZ80c bios.bin bios_dis.asm
:end

copy bios.bin ..\..\SDCard
