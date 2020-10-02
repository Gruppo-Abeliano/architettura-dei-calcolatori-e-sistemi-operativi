	.text
	.align 2
	.globl main		
main:	lw 	$t0,	A
	lw 	$t1,	B
	beq	$t0, 	$t1,	then
	lw 	$t0,	A
	lw 	$t1,	C
	bne	$t0,	$t1,	then
	j else
then:	lw 	$t0,	A
	addiu	$t0,	$t0,	1
	sw	$t0,	A
	j	end
else:	lw	$t0,	B
	addiu	$t0,	$t0,	1
	sw	$t0,	B
end:	lw	$t0,	C
	li	$t0,	12
	sw	$t0,	C

	li	$v0,	10
	syscall

	.data
A:	.word	1
B:	.word	2
C:	.word	3