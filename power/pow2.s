.section .text
.globl _start
_start:

    movl    $2, %edi
    movl    $4, %esi
    callq   power
    movl $1, %eax
    int $0x80 

power:
	push	%rbp
	mov		%rsp, %rbp
	movl	$1, %eax

.loop_start:
	cmpl	$0, %esi
	je		.loop_end
	imul	%edi, %eax
	subl	$1, %esi
	jmp	.loop_start

.loop_end:
    movl %eax, %ebx
	popq	%rbp
	retq
