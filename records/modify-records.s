.include "linux.s"
.include "record-def.s"

.section .data
input_file_name:
.ascii "test.dat\0"

output_file_name:
.ascii "testout.dat\0"

.section .bss
.lcomm record_buffer, RECORD_SIZE

.section .text
.globl _start
_start:    
    movl %esp, %ebp                 # Copy stack pointer 
    subl $8, %esp                   # Make room for local variables

    movl $5,                %eax    # Open file for reading
    movl $input_file_name,  %ebx
    movl $0,                %ecx   
    movl $0666,             %edx
    int  $0x80
    movl %eax,           -4(%ebp)   # store FD for inputfile to local variable

    
    movl $5,                %eax    # OPEN file for writing   
    movl $output_file_name, %ebx
    movl $0101,             %ecx    
    movl $0766,             %edx
    int  $0x80
    movl %eax,          -8(%ebp)    # store FD for output file to local variable

loop_begin:
    pushl -4(%ebp)
    pushl $record_buffer
    call read_record
    addl $8, %esp

    # %eax returns the number of bytes read.
    # If it isn’t the same number we  requested, then it’s either an
    # end-of-file, or an error, so we’re quitting.
    #
    cmpl $RECORD_SIZE, %eax
    jne loop_end

    # Increment the age
    incl record_buffer + RECORD_AGE

    # Write the record out
    pushl -8(%ebp)
    pushl $record_buffer
    call write_record

    addl $8, %esp
    jmp loop_begin

loop_end:
    movl $1, %eax
    movl $0, %ebx
    int $0x80 
