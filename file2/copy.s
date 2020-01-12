.equ NUMBER_ARGUMENTS, 2
.section .bss
.equ BUFFER_SIZE, 500
.lcomm BUFFER_DATA, BUFFER_SIZE

.section .text
.globl _start
_start:
    movl %esp, %ebp             # save the stack pointer
    subl $8, %esp               # Allocate space for file descriptors on stack

open_files:
open_fd_in:
    movl $5, %eax               # Setup sys call 5 to open file
    movl 8(%ebp), %ebx          # 8(%ebp) is address of first letter of input filename
    movl $0, %ecx               # open input file for read-only
    movl $0777, %edx            # This file perm mode does not matter
    int  $0x80                  # call Linux to open the file

store_fd_in:
    movl %eax, -4(%ebp)         # copy/save file desc from eax to stack 

open_fd_out:
    movl $5,       %eax         # Setup sys call 5 to open file
    movl 12(%ebp), %ebx         # 12(%ebp) is address of first letter of Output filename
    movl $03101,   %ecx         # open for write / output 
    movl $0600,    %edx         # output file permission 
    int  $0x80                  # call Linux to open the output file

store_fd_out:
    movl %eax, -8(%ebp)         # copy/save file desc from eax to stack 

read_loop_begin:
    movl $3,       %eax         # Setup sys call 3 to read file
    movl $0,       %ebx         # file descriptor 
    movl $BUFFER_DATA, %ecx     # address of the read buffer 
    movl $BUFFER_SIZE, %edx     # buffer size 500
    int  $0x80                  # eax returns number of bytes that has read

    cmpl $0, %eax               # if %eax == 0 then no more data to read
    jle end_loop

continue_read_loop:
    pushl $BUFFER_DATA          # push location of buffer to stack 
    push  %eax                  # push the actual nunber of READ bytes to stack
    call convert_func           # convert BUFFER_DATA to upper case
    popl %eax                       
    
    addl $4, %esp               # restore stack pointer %esp

    movl %eax, %edx             # copy the number of bytes in buffer to %edx    
    movl $4, %eax               # copy write sys call to %eax
    movl -8(%ebp), %ebx         # copy output file descriptor to %ebx 
    movl $BUFFER_DATA, %ecx     # copy the address of the buffer to %ecx 
    int $0x80
    
    jmp read_loop_begin

end_loop:
    movl $6, %eax               # close output file
    movl -8(%ebp), %ebx         # -8(%ebp) hold file descriptor for 2nd file
    int $0x80                   

    movl $6, %eax               # close input file
    movl -4(%ebp), %ebx         # -8(%ebp) hold file descriptor for first file
    int $0x80

    movl $1, %eax
    movl $0, %ebx
    int $0x80
    
# INPUT:
        # First parameter is the location of the block of memory to convert
        # The second parameter is the length of that buffer
# OUTPUT:
        # This function overwrites current buffer with upper-casified version.
# VARIABLES:
        # %eax - beginning of buffer
        # %ebx - length of buffer
        # %edi - current buffer offset
        # %cl  - current byte being examined 

.type convert_func, @function
convert_func:
    pushl %ebp
    movl %esp, %ebp

    movl 12(%ebp), %eax          # buffer location, i.e. beginning of buffer  
    movl 8(%ebp), %ebx           # length of buffer     
    movl $0, %edi

    cmpl $0, %ebx
    je end_convert_loop

convert_loop:
    movb (%eax,%edi,1), %cl          # get the current byte
    cmpb $'a', %cl                   # to the next byte unless it is between ’a’ and ’z’
    jl next_byte

    cmpb $'z', %cl
    jg  next_byte

    addb $-32, %cl
    movb %cl, (%eax,%edi,1)

next_byte:
    incl %edi
    cmpl %edi, %ebx
    jg convert_loop

       
end_convert_loop:
    movl %ebp, %esp
    popl %ebp
    ret
