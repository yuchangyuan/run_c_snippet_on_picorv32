#!/bin/sh

PREFIX=riscv32-unknown-elf
CC=$PREFIX-gcc
OBJDUMP=$PREFIX-objdump

$CC -march=rv32imc -Os -c s3.c init.c start.S
$CC -nostdlib s3.o init.o start.o -Wl,-T,s3.lds -o s3

$OBJDUMP -D s3 > s3.list
