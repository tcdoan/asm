# PURPOSE: Count the characters until a null byte is reached.
#
# INPUT:
#       The address of the character string
#
# OUTPUT:
#       Returns the count in %eax
#
# PROCESS:
#       Registers used:
#           %ecx - character count
#           %al  - current character
#           %edx - current character address

.type count_chars, @function
.globl count_chars
count_chars:
    pushl %ebp
    movl %esp, %ebp
    
    movl $0, %ecx           # Counter starts at zero
    movl 8(%ebp), %edx      # Start address of data

count_loop_begin:
    movb (%edx), %al        # Grab the current character    
    cmpb $0, %al            # Is it null?
    je count_loop_end       # If yes, we’re done

    incl %ecx               # Otherwise, increment the counter 
    incl %edx               # and the pointer    

    jmp count_loop_begin    # Go back to the beginning of the loop

count_loop_end:
    movl %ecx, %eax
    popl %ebp
    ret    