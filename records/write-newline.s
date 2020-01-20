.include "linux.s"

.globl write_newline
.type write_newline, @function
.section .data
newline:
.ascii "\n"

.section .text
write_newline:
    pushl %ebp
    movl %esp, %ebp

    movl  $4,       %eax      # SYS_WRITE = 4
    movl  8(%ebp),  %ebx      # file descriptor   
    movl  $newline, %ecx   
    movl  $1,       %edx  
    int   $0x80

    movl  %ebp, %esp
    popl  %ebp
    ret