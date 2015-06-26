@echo off
del *.rel *.lst *.rst *.ihx *.hex *.map *.o *.sym *.lnk

sdasz80 -o crt0.s

call compile 3dviewer.c
call compile 3dmain.c
call compile io.c
call compile utils.c
call compile video.c
call compile utils3d.c

sdcc -mz80 --no-std-crt0 --code-loc 0x0290 --code-size 0x7d70 --data-loc 0x8000 crt0.rel io.rel utils.rel video.rel utils3d.rel 3dmain.rel 3dviewer.rel

ren crt0.ihx 3dviewer.ihx

if not exist 3dviewer.ihx goto end
..\Tools\ihx2bin 3dviewer.ihx 3dviewer.bin 640 > ihx2bin.log
..\Tools\dZ80c 3dviewer.bin 3dviewer_dis.asm -m=640
:end
