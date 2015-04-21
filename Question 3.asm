## Problem 3 ##


.data
	result:	.asciiz 	"Sum = "
	sum:		.word 	0 	#initial sum value
	size:		.word	5 	#number of slots in the array 
	.align 4
	space:		.space	40	#each byte is 4 -- 4*10=40
	

.text
.globl main 

main:		la $s0, space	#sets $s0 to the beginning of the array
		lw $s1, size	#loads the size of the array 
		move $t0, $s0	#sets up the pointer 
		li $t1, 0	#counter for the for-loops
		li $t2, 1	#intial value for the array
	
loop1:		bge $t1, 5, endLoop1	#for (int i=0; i<5; i++)
		sw $s1, ($t0) 
	
		addi $t0, $t0, 4 	#Increment to the next element
 
		add $t2, $t2, $t2	#Double the array element

		addi $t1, $t1, 1	#Counter++

		j loop1  
	
endLoop1:	li $t1, 0		#clears the contents of $t1
		li $t2, 0		#clears the contents of $t2
		la $s2, sum		#sump
		move $a0, $s2		#($a0) = sump
		move $a1, $s0		#($a1) = array	
		
loop2:		bge $t1, 5, endLoop2	#for (int i=0; i<5; i++)
		lw $t2, ($a1)  
		add $t2, $t2, $t1	#adds a+i
		sw $t2, ($a1)		
		jal pSum		#jumps to the PSum function

		addi $a1, $a1, 4	#Increment to the next element

		addi $t1, $t1, 1	#Counter++
		j loop2

endLoop2:
		# print string
		li $v0, 4
		la $a0, result
		syscall

		# print the sum
		li $v0, 1
		lw $a0, ($s2)
		syscall

		# Exit
		li $v0, 10
		syscall
		
pSum:		# save register values on stack
		add $sp, $sp, -12
		sw $ra, 0($sp)
		sw $t0, 4($sp)
		sw $t1, 8($sp)
		
		lw $t0, ($a0)	#($t0) = *s
		lw $t1, ($a1)	#($t1) = *e
		add $t0, $t0, $t1	#($t0) = ($t0) + ($t1)
		sw $t0, ($a0)	#*s = ($t0)

		# restore registers from previous routine
		lw $t1, 8($sp)
		lw $t0, 4($sp)
		lw $ra, 0($sp)
		add $sp, $sp, 12
		jr $ra
