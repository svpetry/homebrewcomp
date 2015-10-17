@echo off
del *.rel *.lst *.rst *.ihx *.hex *.map *.o *.sym *.lnk

sdasz80 -o crt0.s

call compile gol.c
call compile golmain.c
call compile ..\Lib\io.c
call compile ..\Lib\utils.c
call compile ..\Lib\graphics2b.c
call compile ..\Lib\rand.c

sdcc -mz80 --no-std-crt0 --code-loc 0x1290 --code-size 0x1570 --data-loc 0x2800 crt0.rel io.rel utils.rel graphics2b.rel golmain.rel gol.rel rand.rel

ren crt0.ihx gol.ihx

if not exist gol.ihx goto end
..\..\Tools\ihx2bin gol.ihx gol.bin 4736 > ihx2bin.log
..\..\Tools\dZ80c gol.bin gol_dis.asm -m=4736

copy gol.bin ..\..\SDCard
:end
