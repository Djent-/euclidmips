#	s/my name/censorbar/;	Program 3
#	Performs the Euclidian Algorithm to find the greatest common denominator
#	of two positive integers
.data
	LargerSmallerRemainder:		.asciiz	"Larger\t\tSmaller\t\tRemainder\n"
	Tab:		.asciiz "\t\t"
	Newline:	.asciiz "\n"
	Number1:	.word	114	#	whatever number
	Number2:	.word	42	#	another number
	TheGCDIs:	.asciiz "The greatest common denominator is: "
#	$t0	Number1			#	$t1	Number2
#	$t2	remainder
.text
	lw	$t1, Number1
	lw	$t2, Number2
	li	$v0, 4
	la	$a0, LargerSmallerRemainder	#the table headings
	syscall
	bge	$t1, $t2, loop
	move	$t4, $t1	#fix the order
	move	$t1, $t2
	move	$t2, $t4
	j	loop
loop:
	#	remainder goes in hi
	div	$t1, $t2		#	divide the numbers
	mfhi	$t3			#	store remainder
	li	$v0, 1
	move	$a0, $t1
	syscall
	li	$v0, 4
	la	$a0, Tab
	syscall
	li	$v0, 1
	move	$a0, $t2
	syscall
	li	$v0, 4
	la	$a0, Tab
	syscall
	li	$v0, 1
	move	$a0, $t3
	syscall
	li	$v0, 4
	la	$a0, Newline
	syscall
	beqz	$t3, end		#	if remainder = 0
	move	$t1, $t2		#	swap smaller with greater
	move	$t2, $t3		#	and smaller with remainder
	j	loop			#	repeat
end:
	li	$v0, 4
	la	$a0, TheGCDIs
	syscall
	li	$v0, 1
	move	$a0, $t2
	syscall
	li	$v0, 10
	syscall
# Output
# Larger		Smaller		Remainder
# 114		42		30
# 42		30		12
# 30		12		6
# 12		6		0
# The greatest common denominator is: 6
