# compute 7^2 = 49
.section .text
.globl _start
_start:
    pushl $7
    call square

    movl %eax, %ebx
    movl $1, %eax
    int $0x80

.type square, @function
square:
    pushl %ebp
    movl %esp, %ebp
    movl 8(%ebp), %eax
    imul %eax, %eax
    movl %ebp, %esp
    popl %ebp
    ret 
