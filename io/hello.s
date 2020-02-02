.section .data

data_start:
.ascii "Hello World\n"
data_end:

filename_start:
.ascii "hello.out"
filename_end:

.equ data_len, data_end - data_start

.section .text
.globl _start

_start:
    movl $5, %eax     
    movl $filename_start, %ebx
    movl $03101, %ecx
    movl $0666, %edx
    int $0x80

    movl %eax, %ebx
    movl $4, %eax     
    movl $data_start, %ecx
    movl $data_len, %edx
    int $0x80

    movl $6, %eax
    int $0x80

    movl $1, %eax
    movl $0, %ebx
    int $0x80
