@echo off
del *.rel *.lst *.rst *.ihx *.hex *.map *.o *.sym *.lnk

as-z80 -o crt0.o crt0.s

call compile systest.c
call compile io.c
call compile utils.c
call compile video.c

sdcc -mz80 --no-std-crt0 --code-loc 0x0290 --code-size 0x5d70 --data-loc 0x6000 crt0.o io.o utils.o video.o systest.o

ren crt0.ihx systest.ihx

if not exist systest.ihx goto end
ihx2bin systest.ihx systest.bin 640 > ihx2bin.log
DZ80-32.EXE systest.bin systest_dis.asm /m=640
:end
