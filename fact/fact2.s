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
    movl  %esp, %ebp

    movl 8(%ebp), %eax
    cmpl $1, %eax
    je end_fact

    decl %eax
    pushl %eax
    call fact

    movl 8(%ebp), %ebx
    imull %ebx, %eax
      
end_fact:
    movl  %ebp, %esp
    popl  %ebp 
    ret 
    