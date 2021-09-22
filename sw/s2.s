	.file	"s2.c"
	.option nopic
	.text
	.align	1
	.globl	out_char
	.type	out_char, @function
out_char:
 #APP
# 5 "s2.c" 1
	 nop
# 0 "" 2
 #NO_APP
	ret
	.size	out_char, .-out_char
	.align	1
	.globl	putStrLn
	.type	putStrLn, @function
putStrLn:
	addi	sp,sp,-16
	sw	s0,8(sp)
	sw	ra,12(sp)
	mv	s0,a0
.L3:
	lbu	a0,0(s0)
	bnez	a0,.L4
	lw	ra,12(sp)
	lw	s0,8(sp)
	addi	sp,sp,16
	jr	ra
.L4:
	call	out_char
	addi	s0,s0,1
	j	.L3
	.size	putStrLn, .-putStrLn
	.section	.text.startup,"ax",@progbits
	.align	1
	.globl	main
	.type	main, @function
main:
	lui	a0,%hi(.LC0)
	addi	sp,sp,-16
	addi	a0,a0,%lo(.LC0)
	sw	ra,12(sp)
	call	putStrLn
	lw	ra,12(sp)
	li	a0,0
	addi	sp,sp,16
	jr	ra
	.size	main, .-main
	.section	.rodata.str1.4,"aMS",@progbits,1
	.align	2
.LC0:
	.string	"Hello, world!"
	.ident	"GCC: (GNU) 8.2.0"
