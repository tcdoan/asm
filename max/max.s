.section .data
nums:
.byte 1, 4, 3, 7, 9, 10, 6, 8, 9, 0
.section .text
.globl _start
_start:
    movl $0, %edi
    movl nums(,%edi,4), %eax

loop_start:
    cmpl $0, nums(,%edi,4)
    je loop_end
    incl %edi
    cmpl nums(,%edi,4), %eax
    jge loop_start
    movl nums(,%edi,4), %eax
    jmp loop_start

loop_end:
    movl %eax, %ebx
    movl $1, %eax
    int $0x80
