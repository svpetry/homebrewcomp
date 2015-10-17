@echo off
del *.rel *.lst *.rst *.ihx *.hex *.map *.sym *.lnk *.noi *.o

set AppName=3dtest

sdasz80 -o crt0.s

call compile %AppName%.c
call compile 3dmain.c
call compile ..\Lib\io.c
call compile ..\Lib\utils.c
call compile ..\Lib\graphics.c
call compile ..\Lib\utils3d.c

sdcc -mz80 --no-std-crt0 --code-loc 0x1290 --code-size 0x3d70 --data-loc 0x5000 crt0.rel %AppName%.rel io.rel utils.rel graphics.rel utils3d.rel 3dmain.rel

ren crt0.ihx 3dtest.ihx

if not exist %AppName%.ihx goto end
..\..\Tools\ihx2bin %AppName%.ihx %AppName%.bin 4736 > ihx2bin.log
..\..\Tools\dZ80c %AppName%.bin %AppName%_dis.asm -m=4736

copy %AppName%.bin ..\..\SDCard
:end
