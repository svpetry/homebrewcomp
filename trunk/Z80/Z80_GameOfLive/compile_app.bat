@echo off
del *.rel *.lst *.rst *.ihx *.hex *.map *.o *.sym *.lnk

sdasz80 -o crt0.s

call compile gol.c
call compile golmain.c
call compile io.c
call compile utils.c
call compile video.c

sdcc -mz80 --no-std-crt0 --code-loc 0x0290 --code-size 0x9d70 --data-loc 0xA000 crt0.rel io.rel utils.rel video.rel golmain.rel gol.rel

ren crt0.ihx gol.ihx

if not exist gol.ihx goto end
..\Tools\ihx2bin gol.ihx gol.bin 640 > ihx2bin.log
..\Tools\dZ80c gol.bin gol.asm -m=640
:end
