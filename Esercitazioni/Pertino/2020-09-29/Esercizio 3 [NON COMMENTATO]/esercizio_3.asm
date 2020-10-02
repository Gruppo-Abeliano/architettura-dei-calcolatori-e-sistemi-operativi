.data
VETT: .word 1,2,3,4,5,6,7,8,9,10
MAX: .space 4
I: .space 4
P: .space 4

.text
.globl MAIN
MAIN:
  lw $t0, VETT
  sw $t0, MAX
  la $t0, VETT
  sw $t0, P
  #i=0
  sw $zero, I
LOOP:
  #i<10
  lw $t0, I
  li $t1, 10
  bge $t0, $t1, END_LOOP
  #if(*p > max)
  lw $t0, P
  lw $t0, 0($t0)
  lw $t1, MAX
  bge $t1, $t0, END_IF
  sw $t0, MAX
END_IF:
  #p++
  lw $t0, P
  addiu $t0, $t0, 4
  sw $t0, P
  #i++
  lw $t0, I
  addiu $t0,$t0, 1
  sw $t0, I
  j LOOP
END_LOOP:
  # syscall to exit (10)
  li $v0, 10
  syscall
