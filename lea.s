.section .data
myByte:
.long 56

.section .text
.globl _start
_start:
    lea myByte, %rax
    movl $7, (%eax)
    mov $0, %edi
    mov myByte(, %edi, 4), %ebx
    mov $1, %eax
    int $0x80
