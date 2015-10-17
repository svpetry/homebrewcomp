@echo off
del *.rel *.lst *.rst *.ihx *.hex *.map *.o *.sym *.lnk

sdasz80 -o crt0.s

sdcc -mz80 --fverbose-asm --no-std-crt0 --code-loc 0x0008 --code-size 0x07f7 --data-loc 0x0800 crt0.rel main.c

if not exist main.ihx goto end
..\Tools\ihx2bin main.ihx main.bin > ihx2bin.log
..\Tools\dZ80c main.bin main_dis.asm
:end
