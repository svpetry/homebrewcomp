@echo off
del *.rel *.lst *.rst *.ihx *.hex *.map *.rel *.sym *.lnk *.noi

sdasz80 -o crt0.s

call compile ..\Lib\bios_text.c
call compile ..\Lib\malloc.c
call compile ..\Lib\utils.c
call compile test.c

sdcc -mz80 --no-std-crt0 --code-loc 0x1290 --code-size 0x2000 --data-loc 0x4000 crt0.rel test.rel bios_text.rel malloc.rel utils.rel
ren crt0.ihx test.ihx

if not exist test.ihx goto end
..\Tools\ihx2bin test.ihx test.bin 4736 > ihx2bin.log
..\Tools\dZ80c test.bin test.asm -m=4736

copy test.bin ..\SDCard
:end
