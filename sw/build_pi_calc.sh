#!/bin/sh

PREFIX=riscv32-unknown-elf
CC=$PREFIX-gcc
OBJDUMP=$PREFIX-objdump

$CC -march=rv32imc -Os -c pi_calc.c init.c start.S
$CC -march=rv32imc -nostdlib pi_calc.o init.o start.o -lm -lgcc -Wl,-T,s3.lds -o pi_calc

$OBJDUMP -D pi_calc > pi_calc.list

