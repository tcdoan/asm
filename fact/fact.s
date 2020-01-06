# Compute factorial(4)
.section .text
.globl _start
_start:
    pushl $4
    call fact

    movl %eax, %ebx

    movl $1, %eax
    int $0x80

.type fact, @function
fact:
    pushl %ebp
    movl %esp, %ebp

    movl 8(%ebp), %eax
    cmpl $1, %eax
    je end_fact

    decl  %eax          # n-1    
    pushl %eax          # 
    call fact           # evaluate f(n-1)
    
    imull 8(%ebp), %eax    # Compute n * f(n-1)

end_fact:
    movl %ebp, %esp     # we have to restore %ebp and %esp to where
    popl %ebp           # they were before the function started
    ret                 # return to the function (this pops the return value, too)
