@echo off
del *.rel *.lst *.rst *.ihx *.hex *.map *.o *.sym *.lnk

sdasz80 -o crt0.s

call compile systest.c
call compile ..\Lib\bios_text.c
call compile ..\Lib\io.c
call compile ..\Lib\utils.c
call compile ..\Lib\textutils.c

sdcc -mz80 --no-std-crt0 --code-loc 0x1290 --code-size 0x1170 --data-loc 0x2400 crt0.rel systest.rel bios_text.rel io.rel utils.rel textutils.rel

ren crt0.ihx systest.ihx

if not exist systest.ihx goto end
..\..\Tools\ihx2bin systest.ihx systest.bin 4736 > ihx2bin.log
..\..\Tools\dZ80c systest.bin systest_dis.asm -m=4736

copy systest.bin ..\..\SDCard
:end
