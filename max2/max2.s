# Find max value from list below
.section .data
array:
.long 2, 5, 6, 7, 9, 11, 24, 22, 21, 24, 7, 7, 0
.section .text
.globl _start

# Register %eax is used to hold max
_start:
    movl $0, %edi
    movl array(,%edi,4), %eax

loop_start:
    incl %edi
    cmpl  $0, array(,%edi,4)
    je loop_end

    cmpl array(,%edi,4), %eax
    jge loop_start
    movl array(,%edi,4), %eax
    jmp loop_start

loop_end:
    movl %eax, %ebx
    movl $1, %eax
    int $0x80
