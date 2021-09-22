    .section .text
    .global _start
    .global main
    .global init

_start:
    lui sp, %hi(512*1024)
    addi sp, sp, %lo(512*1024)
    
    jal ra, init
    jal ra, main
    ebreak
