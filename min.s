# PURPOSE:  This program finds the maximum number of a
#           set of data items.
#
#
# VARIABLES: The registers have the following uses:
#
# %edi - Holds the index of the data item being examined
# %ebx - Largest data item found
# %eax - Current data item
#
# The following memory locations are used:
#
# data_items - contains the item data. A 0 is used to terminate the data
#
.section .data
data_items:
.long 50,67,34,253,45,75,255

.section .text
.globl _start

##############
_start:
##############    
    movl $0, %edi                                                             
    movl data_items(, %edi, 4), %eax
    movl %eax, %ebx

##############
start_loop:
##############
    cmpl $255, %eax
    je loop_exit                        
    incl %edi                           
    movl data_items(, %edi, 4), %eax    
    cmpl %ebx, %eax                     
    jge start_loop                      
    movl %eax, %ebx                     
    jmp start_loop                      

##############
loop_exit:
##############
    movl $1, %eax
    int $0x80    
