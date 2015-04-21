# write a program to evaluate the following funnction u and v:
# 9u^2 - 14uv + v^2
# u and v are user inputs
# create two subroutines for this program
# 	1) int square(a): return a^2
# 	2) int multiply (a,b): return a*b

.data

uprompt: .asciiz "Enter variable u: "
vprompt: .asciiz "Enter variable v: "
newline: .asciiz "\n"

.text
	.globl main
main:
	li $v0, 4
	la $a0, uprompt # prompt for variable u
	syscall
	
	li $v0, 5 # listen for user input
	syscall
	move $s0, $v0 # store u in $s0
	
	li $v0, 4
	la $a0, vprompt # prompt for variable v
	syscall
	
	li $v0, 5 # listen for user input
	syscall
	move $s1, $v0 # store v in $s1
	
	move $a0, $s0 # load u as argument
	jal subsquare # jump and link to subroutine subsquare
	move $t0, $v0 # store subroutine value into $t0
	mulu $t0, $t0, 9 # u^2 * 9
	
	move $a0, $s0 # load u as argument
	move $a1, $s1 # load v as argument
	jal submult # jump and link to subroutine submult
	move $t1, $v0 # store subroutine value into $t1
	mulu $t1, $t1, 14 # u*v*14
	
	move $a0, $s1 # load v as arugment
	jal subsquare # jump and link to subroutine subsquare
	move $t2, $v0  # store subroutine value into $t2
	
	li $v0, 1 
	sub $t3, $t0, $t1 # 9u^2 - 14uv
	add $a0, $t3, $t2 # 9u^2 - 14uv + v^2
	syscall
	
	li $v0, 4
	la $a0, newline # create new line
	syscall
	
	j end # jump to end of program
	
subsquare:
	add $sp, $sp, -8
	sw $ra, 0($sp) # store 4 bit return address
	sw $a2, 4($sp) # store $a2 into 4 bits of stack pointer
	
	move $a2, $a0 # store value to be squared into $a2
	mul $v0, $a2, $a2 # square value
	
	add $sp, $sp, 8 # restore stack pointer
	jr $ra # return to address stored in $ra

submult:
	add $sp, $sp, -12
	sw $ra, 0($sp) # store 4 bit return address
	sw $a2, 4($sp) # store $a2 into 4 bits of stack pointer
	sw $a3, 8($sp) # store $a3 into 4 bits of stack pointer
	
	move $a2, $a0 # store first value into $a0
	move $a3, $a1 # store second value into $a1
	mul $v0, $a2, $a3 # multiply values and store into $v0
	
	add $sp, $sp, 12 # restore stack pointer
	jr $ra # return to address stored in $ra

end:
	li $v0, 10 # end program
	syscall
