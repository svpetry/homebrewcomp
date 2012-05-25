@echo off
del *.rel *.lst *.rst *.ihx *.hex *.map *.o *.sym *.lnk

sdasz80 -o crt0.s

call compile 3dtest.c
call compile 3dmain.c
call compile io.c
call compile utils.c
call compile video.c
call compile utils3d.c

sdcc -mz80 --no-std-crt0 --code-loc 0x0290 --code-size 0x9d70 --data-loc 0xA000 crt0.rel io.rel utils.rel video.rel utils3d.rel 3dmain.rel 3dtest.rel

ren crt0.ihx 3dtest.ihx

if not exist 3dtest.ihx goto end
..\Tools\ihx2bin 3dtest.ihx 3dtest.bin 640 > ihx2bin.log
..\Tools\dZ80c 3dtest.bin 3dtest_dis.asm -m=640
:end
