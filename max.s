.section .data
data_items:
.long 50,67,34,253,45,75
.section .text
.globl _start
_start:
    movl $0, %edi
    movl data_items(, %edi, 4), %eax
    movl %eax, %ebx

start_loop:
    cmpl $6, %edi
    je loop_exit
    incl %edi                           
    movl data_items(, %edi, 4), %eax    
    cmpl %ebx, %eax                     
    jle start_loop
    movl %eax, %ebx                     
    jmp start_loop                      

loop_exit:
    movl $1, %eax
    int $0x80    