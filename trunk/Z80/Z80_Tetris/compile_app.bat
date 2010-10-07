@echo off
del *.rel *.lst *.rst *.ihx *.hex *.map *.o *.sym *.lnk

as-z80 -o crt0.o crt0.s

call compile tetris.c
call compile io.c
call compile utils.c
call compile video.c
call compile tmain.c

sdcc -mz80 --no-std-crt0 --code-loc 0x0290 --code-size 0x9d70 --data-loc 0xA000 crt0.o io.o utils.o video.o tmain.o tetris.o

ren crt0.ihx edit.ihx

if not exist edit.ihx goto end
ihx2bin edit.ihx edit.bin 640 > ihx2bin.log
DZ80-32.EXE edit.bin edit_dis.asm /m=640
:end
