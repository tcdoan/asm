# Compute factorial(5)
.section .text
.globl _start
_start:
    pushl $5
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
    je  end_fact

    decl %eax
    pushl %eax
    call fact               # evaluate f(n-1)

    imul 8(%ebp), %eax      # eax = n*f(n-1)
    
end_fact:
    movl %ebp, %esp
    popl %ebp
    ret 
