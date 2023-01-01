print gen sa verifici

 xor %ecx, %ecx
 movl -8(%ebp), %ecx
 pushl %ecx
 pushl $formatString
 call printf
 popl %ebx
 popl %ebx
 pushl $0
 call fflush
 popl %ebx


 
    # printez contorul ebx bagamias pulan el

    pushl %ecx
    pushl %ebx

    xor %ecx, %ecx
    movl %ebx, %ecx
    pushl %ecx
    pushl $printEbx
    call printf
    popl %ebx
    popl %ebx
    pushl $0
    call fflush
    popl %ebx

    popl %ebx
    popl %ecx