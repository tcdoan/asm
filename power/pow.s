.section .text

.globl _start
_start:

push $2
push $4
call power

movl $1, %eax
int $0x80 

power:
mov -0x14(%rbp), %edi
mov -0x18(%rbp), %esi
movl $1, %eax

cmpl $0, %esi
je .loop_end
subl $1, %esi
imul %edi, %eax
jmp power

.loop_end:
movl %eax, %ebx
ret
