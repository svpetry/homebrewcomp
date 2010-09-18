@echo off
del *.rel *.lst *.rst *.ihx *.hex *.map *.o *.sym *.lnk

as-z80 -o crt0.o crt0.s

call compile basic.c
call compile io.c
call compile utils.c
call compile video.c
call compile malloc.c
call compile mybasic.c
call compile basic_helpers.c
call compile vars.c

sdcc -mz80 "-Wl -b _CODE2 = 0x8000" --no-std-crt0 --code-loc 0x0290 --code-size 0x5d70 --data-loc 0x6000 crt0.o io.o utils.o video.o malloc.o mybasic.o basic_helpers.o vars.o basic.o

ren crt0.ihx basic.ihx

if not exist basic.ihx goto end
ihx2bin basic.ihx basic.bin 640 > ihx2bin.log
DZ80-32.EXE basic.bin basic_dis.asm /m=640
:end
