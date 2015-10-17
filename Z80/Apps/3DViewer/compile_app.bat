@echo off
del *.rel *.lst *.rst *.ihx *.hex *.map *.o *.sym *.lnk

sdasz80 -o crt0.s

call compile ..\Lib\bios_text.c
call compile ..\Lib\bios_file.c
call compile ..\Lib\io.c
call compile ..\Lib\utils.c
call compile ..\Lib\graphics.c
call compile ..\Lib\utils3d.c
call compile 3dviewer.c
call compile 3dmain.c

sdcc -mz80 --no-std-crt0 --code-loc 0x1290 --code-size 0x6d70 --data-loc 0x8000 crt0.rel io.rel utils.rel graphics.rel utils3d.rel 3dmain.rel 3dviewer.rel bios_text.rel bios_file.rel

ren crt0.ihx 3dviewer.ihx

if not exist 3dviewer.ihx goto end
..\..\Tools\ihx2bin 3dviewer.ihx 3dviewer.bin 4736 > ihx2bin.log
..\..\Tools\dZ80c 3dviewer.bin 3dviewer_dis.asm -m=4736

copy 3dviewer.bin ..\..\SDCard
:end
