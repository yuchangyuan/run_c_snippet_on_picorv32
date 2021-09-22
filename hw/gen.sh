#!/bin/sh

PREFIX=riscv32-unknown-elf
OBJCOPY=$PREFIX-objcopy

$OBJCOPY -j .init -j .text -j .rodata -O binary ../sw/s3 rom0.bin
$OBJCOPY -j .data -O binary ../sw/s3 rom1.bin

gcc -o rom_gen rom_gen.c

./rom_gen rom0 < rom0.bin > rom0.v
./rom_gen rom1 < rom1.bin > rom1.v

iverilog rom0.v rom1.v ram.v top.v tb.v ../picorv32/picorv32.v -o tb
