@echo off
del *.rel *.lst *.rst *.ihx *.hex *.map *.o *.sym *.lnk

sdasz80 -o crt0.s

call compile edit.c
call compile io.c
call compile utils.c
call compile video.c
call compile malloc.c
call compile editor.c
call compile sound.c

sdcc -mz80 --no-std-crt0 --code-loc 0x0290 --code-size 0x2d70 --data-loc 0x3000 crt0.rel io.rel utils.rel video.rel malloc.rel sound.rel editor.rel edit.rel

ren crt0.ihx edit.ihx

if not exist edit.ihx goto end
..\Tools\ihx2bin edit.ihx edit.bin 640 > ihx2bin.log
..\Tools\dZ80c edit.bin edit_dis.asm -m=640
:end
