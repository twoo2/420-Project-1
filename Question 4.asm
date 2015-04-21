# write program to find fix(i,x), where fix(i,x) is defined as
# int fix(int i, int x) //assume i>0, x>0
# {
#	if (x>0)
#		return fix(i, x-1)+1;
#	else if (i>0)
#		return fix(i-1, i-1)+1;
#	else
#		return 0;
# }
# the values for i, and x are user inputs to the program
# you may set upper-bounds for the values input for these variables

.data

prompti: .asciiz "Enter variable i: "
promptx: .asciiz "Enter variable x: "

.text
	.globl main
main:
	li $v0, 4 # load to print prompt
	la $a0, prompti # print prompt i
	syscall
	
	li $v0, 5 # load to read input
	syscall
	move $s0, $v0 # store i in $s0
	
	
	li $v0, 4 # load to print prompt
	la $a0, promptx # print prompt x
	syscall
	
	li $v0, 5 # load to read input
	syscall
	move $s1, $v0 # store x in $s1
	
	move $a0, $s0 # store i in argument
	move $a1, $s1 # store x in argument
	jal if # jump and link to fixfunc
	move $s0, $v0 # store final fix value in $s0

	li $v0, 1 # load to print integer
	move $a0, $s0 # store final fix value in arugment
	syscall
	
	j end

if:
	add $sp, $sp, -12 # set stack pointer to accept 12 bits
	sw $ra, 0($sp) # store return address in stack pointer
	sw $a0, 4($sp) # store i value in stack pointer
	sw $a1, 8($sp) # store x value in stack pointer
	
	blez $a1, elseif # branch if x <=0
	addi $a1, $a1, -1 # decrement x by 1
	
	jal if # jump and link to fixfunc
	addi $v0, $v0, 1 # increment fix by 1
	j ret # jump to restore stack pointer
	
elseif:
	blez $a0, else # branch if i <= 0
	addi $a0, $a0, -1 # decrement i by 1
	move $a1, $a0 # set i-1 to x #### CHECK TO SEE IF $A0 --> $A1
	
	jal if # jump and link to fixfunc
	addi $v0, $v0, 1 # increment fix by 1
	j ret # jump to restore stack pointer
	
else:
	li $v0, 0 # return 0
	
ret:
	lw $ra, 0($sp) # load value at address into $ra
	lw $a0, 4($sp) # load value at address into $a0
	lw $a1, 8($sp) # load value at address into $a1
	add $sp, $sp, 12 # restore stack pointer
	jr $ra # jump return to address stored in $ra

end:
	li $v0, 10 # program exit
	syscall
	
