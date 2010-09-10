@echo off
del *.rel *.lst *.rst *.ihx *.hex *.map *.o *.sym *.lnk *.noi

as-z80 -o crt0.o crt0.s

call compile bios.c
call compile cmdline.c
call compile bios_cmd.c
call compile io.c
call compile utils.c
call compile video.c
call compile std_utils.c

sdcc -mz80 --no-std-crt0 --code-loc 0x0290 --code-size 0x3d70 --data-loc 0x4000 crt0.o bios.o cmdline.o bios_cmd.o io.o utils.o video.o
ren crt0.ihx bios.ihx

if not exist bios.ihx goto end
ihx2bin bios.ihx bios.bin > ihx2bin.log
DZ80-32.EXE bios.bin bios_dis.asm
:end
