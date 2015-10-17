@echo off
del *.rel *.lst *.rst *.ihx *.hex *.map *.o *.sym *.lnk

sdasz80 -o crt0.s

call compile terminal.c
call compile main.c
call compile ..\Lib\bios_text.c
call compile ..\Lib\utils.c
call compile ..\Lib\textutils.c
call compile ..\Lib\io.c

sdcc -mz80 --no-std-crt0 --code-loc 0x1290 --code-size 0x1d70 --data-loc 0x3000 crt0.rel terminal.rel main.rel bios_text.rel utils.rel textutils.rel io.rel

ren crt0.ihx terminal.ihx

if not exist terminal.ihx goto end
..\..\Tools\ihx2bin terminal.ihx terminal.bin 4736 > ihx2bin.log
..\..\Tools\dZ80c terminal.bin terminal_dis.asm -m=4736

copy terminal.bin ..\..\SDCard
:end
