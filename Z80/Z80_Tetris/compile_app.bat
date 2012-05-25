@echo off
del *.rel *.lst *.rst *.ihx *.hex *.map *.o *.sym *.lnk

sdasz80 -o crt0.s

call compile tetris.c
call compile io.c
call compile utils.c
call compile video.c
call compile tmain.c
call compile utils3d.c
call compile splashscreen.c
call compile sound.c

sdcc -mz80 --no-std-crt0 --code-loc 0x0290 --code-size 0x9d70 --data-loc 0xA000 crt0.rel io.rel utils.rel video.rel tmain.rel utils3d.rel tetris.rel splashscreen.rel sound.rel

ren crt0.ihx tetris.ihx

if not exist tetris.ihx goto end
..\Tools\ihx2bin tetris.ihx tetris.bin 640 > ihx2bin.log
..\Tools\dZ80c tetris.bin tetris_dis.asm -m=640
:end
