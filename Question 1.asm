# convert lower-case string to upper case characters
# to convert subtract 0x20 from the character in the string

.data 
	string: .asciiz "mynameisvondoom"
.text
main:
	la $t0, string # load the address of string into $t0
chgCase:
	lb $t2, ($t0) # load first byte from address
	beqz $t2, end # branch if 0
	sub $t2, $t2, 32 # set $t2 to $t2 - 32
	sb $t2, ($t0) # store changed char in string
	add $t0, $t0, 1 # else increment
	j chgCase # loop
end:
	li $v0, 4 # load sys call into reg $v0
	la $a0, string
	syscall
