.section .data

mydata:
.ascii "Hello Quang \n\0"

.section .text
.globl _start

_start:
    pushl $mydata 
    call printf

    pushl $0
    call exit
