.include "record-def.s"
.include "linux.s"

# PURPOSE: 
#       Reads a record from the file descriptor
#
# INPUT:
#       The file descriptor and a buffer
#
# OUTPUT:
#       Writes the data to the buffer and returns a status code.
#
.section .text
.globl read_record
.type read_record, @function
read_record:
    pushl %ebp
    movl %esp, %ebp
    pushl %ebx

    movl $3,            %eax    # %eax has the return value, which will give back to calling program
    movl 12(%ebp),      %ebx
    movl 8(%ebp),       %ecx    
    movl $RECORD_SIZE,  %edx
    int  $0x80   

    popl %ebx
    movl %ebp, %esp
    popl %ebp
    ret
