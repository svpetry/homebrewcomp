@echo off
del *.rel *.lst *.rst *.ihx *.hex *.map *.o *.sym *.lnk

sdasz80 -o crt0.s

call compile main.c
call compile terminal.c
call compile io.c
call compile utils.c
call compile video.c

sdcc -mz80 --no-std-crt0 --code-loc 0x0290 --code-size 0x2d70 --data-loc 0x3000 crt0.rel io.rel utils.rel video.rel terminal.rel main.rel

ren crt0.ihx terminal.ihx

if not exist terminal.ihx goto end
..\Tools\ihx2bin terminal.ihx terminal.bin 640 > ihx2bin.log
..\Tools\dZ80c terminal.bin terminal_dis.asm -m=640
:end
