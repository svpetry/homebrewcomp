@echo off
del *.rel *.lst *.rst *.ihx *.hex *.map *.rel *.sym *.lnk *.noi

sdasz80 -o crt0.s

call compile bios.c
call compile cmdline.c
call compile bios_cmd.c
call compile io.c
call compile utils.c
call compile video.c
call compile std_utils.c

sdcc -mz80 --no-std-crt0 --code-loc 0x0290 --code-size 0x3d70 --data-loc 0x4000 crt0.rel bios.rel cmdline.rel bios_cmd.rel io.rel utils.rel video.rel
ren crt0.ihx bios.ihx

if not exist bios.ihx goto end
..\Tools\ihx2bin bios.ihx bios.bin > ihx2bin.log
..\Tools\dZ80c bios.bin bios.asm -m=640
:end
