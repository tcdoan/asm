.section .data
mydata:
.ascii "hello world\n\0"

.section .text
.globl _start
_start:
    push $mydata
    call printf
    
    push $0
    call exit
