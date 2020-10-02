	.data
vett:	.word	2, 1, 0, 4, 5, 6, 7, 2, 3, -2
max:	.space	4
i:	.space	4

	.text
	.globl main
main:	lw	$t0,	vett
	sw	$t0,	max		# max = vett[0];
	li	$t0,	1
	sw	$t0,	i		# i = 1;
for:	lw	$t0,	i
	li	$t1,	10
	bge	$t0,	$t1,	end	# i < 0;
	lw	$t0,	i 
	sll	$t0,	$t0,	2 	# Moltiplico (tramite shift) per 4
	lw	$t0,	vett($t0)
	lw	$t1,	max
	ble	$t0,	$t1,	endif	# vett[i] > max;
	sw	$t0,	max		# max = vett[i];
endif:	lw	$t0,	i
	addi	$t0, 	$t0, 1
	sw	$t0,	i		# i++;
	j	for
end:	li	$v0, 10
	syscall
