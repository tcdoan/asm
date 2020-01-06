# compute max from {1, 4, 6, 8, 7, 5, 15, 8, 4, 2, 5, 0};
.section .text
.globl _start
_start:
    pushl $0
    pushl $5
    pushl $2
    pushl $4
    pushl $8
    pushl $15
    pushl $5
    pushl $7
    pushl $8
    pushl $6
    pushl $4
    pushl $1

    call find_max

    movl %eax, %ebx
    movl $1, %eax
    int $0x80

.type find_max, @function
find_max:
    pushl %ebp
    movl %esp, %ebp
    
    subl $8, %ebp
    movl %ebp, %eax
    movl $0, %edi

loop_start:
    cmpl $0, %ebx
    je end_loop
    subl $4, %ebp
    movl %ebp, %ebx
    cmpl %ebx, %eax
    jg loop_start
    movl %ebx, %eax
    jmp loop_start
end_loop:
    movl %ebp, %esp
    popl %ebp
    ret 
