@echo off
del *.rel *.lst *.rst *.ihx *.hex *.map *.o *.sym *.lnk

sdasz80 -o crt0.s

call compile systest.c
call compile io.c
call compile utils.c
call compile video.c

sdcc -mz80 --no-std-crt0 --code-loc 0x0290 --code-size 0x5d70 --data-loc 0x6000 crt0.rel io.rel utils.rel video.rel systest.rel

ren crt0.ihx systest.ihx

if not exist systest.ihx goto end
..\Tools\ihx2bin systest.ihx systest.bin 640 > ihx2bin.log
..\Tools\dZ80c systest.bin systest_dis.asm -m=640
:end
