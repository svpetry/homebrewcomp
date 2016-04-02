@echo off
del *.rel *.lst *.rst *.ihx *.hex *.map *.o *.sym *.lnk

sdasz80 -o crt0.s

call compile space.c
call compile space_main.c
call compile video.c
call compile ..\Lib\bios_text.c
call compile ..\Lib\io.c
call compile ..\Lib\graphics.c
call compile ..\Lib\utils.c
call compile ..\Lib\sound.c

sdcc -mz80 --no-std-crt0 --code-loc 0x1290 --code-size 0x8d70 --data-loc 0xA000 crt0.rel space.rel space_main.rel video.rel bios_text.rel io.rel graphics.rel utils.rel sound.rel

ren crt0.ihx space.ihx

if not exist space.ihx goto end
..\..\Tools\ihx2bin space.ihx space.bin 4736 > ihx2bin.log
..\..\Tools\dZ80c space.bin space_dis.asm -m=4736

copy space.bin ..\..\SDCard
:end

