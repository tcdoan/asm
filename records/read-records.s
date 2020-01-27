.include "linux.s"
.include "record-def.s"

.section .data
file_name:
.ascii "test.dat\0"

.section .bss
.lcomm record_buffer, RECORD_SIZE

.section .text
.globl _start
_start:
    movl %esp, %ebp
    subl $8, %esp                   # space to hold IN & OUT file descriptors

    movl  $5,           %eax
    movl  $file_name,   %ebx   
    movl  $0,           %ecx        # Open mode.  0 means open read-only      
    movl  $0600,        %edx
    int   $0x80

    movl %eax, -4(%ebp)             # Save INPUT file descriptor
    movl $1,   -8(%ebp)             # Save output file descriptor to local variable

record_read_loop:
    pushl -4(%ebp)
    pushl $record_buffer
    call read_record

    addl $8, %esp
    cmpl $RECORD_SIZE, %eax
    jne  finished_reading

    pushl $RECORD_LASTNAME + record_buffer
    call count_chars
    addl $4, %esp

    movl %eax,      %edx            # number of bytes to write
    movl $4,        %eax            # 4 is syscall to write 
    movl -8(%ebp),  %ebx            # file desc to write 
    movl  $RECORD_LASTNAME + record_buffer, %ecx
    int $0x80

    pushl  -8(%ebp)
    call write_newline
    addl $4, %esp

    jmp record_read_loop

finished_reading:
    movl    $1, %eax
    movl    $0, %ebx
    int     $0x80
