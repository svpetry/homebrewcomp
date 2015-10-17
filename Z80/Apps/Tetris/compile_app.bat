@echo off
del *.rel *.lst *.rst *.ihx *.hex *.map *.o *.sym *.lnk

sdasz80 -o crt0.s

call compile tetris.c
call compile ..\Lib\io.c
call compile ..\Lib\utils.c
call compile ..\Lib\graphics.c
call compile ..\Lib\sound.c
call compile ..\Lib\rand.c
call compile ..\Lib\bios_text.c
call compile sintable.c
call compile tmain.c
call compile tsound.c
call compile splashscreen.c

sdcc -mz80 --no-std-crt0 --code-loc 0x1290 --code-size 0x2d70 --data-loc 0x4000 crt0.rel tetris.rel io.rel utils.rel graphics.rel sound.rel sintable.rel tmain.rel splashscreen.rel rand.rel bios_text.rel tsound.rel

ren crt0.ihx tetris.ihx

if not exist tetris.ihx goto end
..\..\Tools\ihx2bin tetris.ihx tetris.bin 4736 > ihx2bin.log
..\..\Tools\dZ80c tetris.bin tetris_dis.asm -m=4736

copy tetris.bin ..\..\SDCard
:end
