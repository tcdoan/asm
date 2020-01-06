.section .data
.section .text
.globl _start
_start:
	# compute 2^4 + 3^2
	pushl $4
	pushl $2
	call power	
	addl $8, %esp  				# move stack pointer back
	pushl %eax					# save 2^4 to stack before calling power 

	pushl $2
	pushl $3
	call power
	addl $8, %esp  				# move stack pointer back
	popl %ebx					# pop 2^4 from stack to ebx for addition
	addl %eax, %ebx				# add 3^2 (eax) to %ebx
	movl $1, %eax				
	int $0x80

# POWER: 
#		Compute the value of a number raised to a power.
#
# INPUT:
#		First argument - the base number
#		Second argument - the power to raise it to
#
# OUTPUT:
#		Will give the result as a return value
#
# VARIABLES:
#		%ebx 		- holds the base number
#		%ecx 		- holds the power
#		-4(%ebp) 	- holds the current result
#		%eax 		- is used for temporary storage
#
.type power, @function
power:
	pushl %ebp					# save old base pointer
	movl  %esp, %ebp			# make stack pointer the base pointer
	subl $4, %esp				# get room for our local storage
	
	movl 8(%ebp),  %ebx 		# copy base  (2) to %ebx
	movl 12(%ebp), %ecx 		# copy power (4) to %ecx
	movl $1, -4(%ebp)			# current value = 1

start_loop:
	cmpl $0, %ecx
	je loop_end
	
	movl -4(%ebp), %eax
	imul %ebx, %eax
	movl %eax, -4(%ebp) 		# save multiplication result in local storage
	decl %ecx
	jmp start_loop

loop_end:
	movl -4(%ebp), %eax
	movl %ebp, %esp
	popl %ebp
	ret
