.include "record-def.s"
.include "linux.s"

# PURPOSE: 
#       Write a record from buffer to file
#
# INPUT:
#       The file descriptor and a buffer
#
# OUTPUT:
#       This function produces a status code
#
.section .text
.globl write_record
.type write_record, @function
write_record:
    pushl %ebp
    movl %esp, %ebp

    pushl %ebx

    movl $4, %eax
    movl 12(%ebp), %ebx
    movl 8(%ebp),  %ecx    
    movl $RECORD_SIZE, %edx
    int  $0x80   

    popl %ebx
    movl %ebp, %esp
    popl %ebp
    ret
