@echo off
del *.rel *.lst *.rst *.ihx *.hex *.map *.o *.sym *.lnk

as-z80 -o crt0.o crt0.s

sdcc -mz80 --portmode=z80 --fverbose-asm --verbose --no-std-crt0 --code-loc 0x0100 --code-size 0x2000 --data-loc 0x2000 crt0.o main.c

if not exist main.ihx goto end
ihx2bin main.ihx main.bin
DZ80-32.EXE main.bin main_dis.asm
:end
