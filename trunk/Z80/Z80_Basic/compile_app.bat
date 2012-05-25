@echo off
del *.rel *.lst *.rst *.ihx *.hex *.map *.o *.sym *.lnk

sdasz80 -o crt0.s

call compile basic.c
call compile io.c
call compile utils.c
call compile utils_b0.c
call compile video.c
call compile malloc.c
call compile mybasic.c
call compile basic_helpers.c
call compile vars.c
call compile ftoa.c

sdcc -mz80 "-Wl -b _CODE2 = 0x8000" --no-std-crt0 --code-loc 0x0290 --code-size 0x6170 --data-loc 0x6400 crt0.rel io.rel utils.rel video.rel malloc.rel mybasic.rel basic_helpers.rel vars.rel ftoa.rel utils_b0.rel basic.rel

ren crt0.ihx basic.ihx

if not exist basic.ihx goto end
..\Tools\ihx2bin basic.ihx basic.bin 640 > ihx2bin.log
REM ..\Tools\DZ80-32.EXE basic.bin basic_dis.asm /m=640
..\Tools\dZ80c basic.bin basic_dis.asm -m=640
:end
