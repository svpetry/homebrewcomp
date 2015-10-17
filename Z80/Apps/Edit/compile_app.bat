@echo off
del *.rel *.lst *.rst *.ihx *.hex *.map *.o *.sym *.lnk

sdasz80 -o crt0.s

call compile edit.c
call compile ..\Lib\bios_text.c
call compile ..\Lib\bios_file.c
call compile ..\Lib\io.c
call compile ..\Lib\utils.c
call compile ..\Lib\textutils.c
call compile ..\Lib\malloc.c
call compile ..\Lib\sound.c
call compile editor.c

sdcc -mz80 --no-std-crt0 --code-loc 0x1290 --code-size 0x2170 --data-loc 0x3400 crt0.rel edit.rel editor.rel bios_text.rel bios_file.rel io.rel utils.rel textutils.rel malloc.rel sound.rel

ren crt0.ihx edit.ihx

if not exist edit.ihx goto end
..\..\Tools\ihx2bin edit.ihx edit.bin 4736 > ihx2bin.log
..\..\Tools\dZ80c edit.bin edit_dis.asm -m=4736

copy edit.bin ..\..\SDCard
:end
