@echo off
del *.rel *.lst *.rst *.ihx *.hex *.map *.o *.sym *.lnk

sdasz80 -o crt0.s

call compile space.c
call compile io.c
call compile utils.c
call compile video.c
call compile space_main.c
call compile utils3d.c
call compile sound.c

sdcc -mz80 --no-std-crt0 --code-loc 0x0290 --code-size 0x9d70 --data-loc 0xA000 crt0.rel io.rel utils.rel video.rel space_main.rel utils3d.rel space.rel sound.rel

ren crt0.ihx space.ihx

if not exist space.ihx goto end
..\Tools\ihx2bin space.ihx space.bin 640 > ihx2bin.log
..\Tools\dZ80c space.bin space_dis.asm -m=640
copy space.bin ..\SDCard\
:end

