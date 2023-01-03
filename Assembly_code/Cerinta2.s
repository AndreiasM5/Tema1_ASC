.data
x: .long 2
y: .long 3
s: .space 4
.text

add_a_b:

add %ebx, %eax

ret



.global main
main:
movl $4, %eax
movl $5, %ebx


call add_a_b



mov $1, %eax
xor %ebx, %ebx
int $0x80
