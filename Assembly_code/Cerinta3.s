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