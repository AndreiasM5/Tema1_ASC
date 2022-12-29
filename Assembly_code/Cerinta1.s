.data
    x: .space 4
    formatString: .asciz "%d"
    errorPrintf: .asciz "Contorul meu edx este = %d\n"
.text

.global main
main:
pushl %ebp
movl %esp, %ebp

# pasul 1

# todo - citesc nr cerintei ||  apelez scanf ca sa citesc

 
pushl   $x                    # incarcam in stiva NU x, ci ADRESA lui x || adica nu x, ci £x
pushl   $formatString         # incarcam adresa formatului
call    scanf                  # apelam scanf
popl    %ebx                   # descarcam ce am incarcat in stiva
popl    %ebx

# pun pe stiva
subl    $4, %esp               # alocam un spatiu pe stiva
movl    x, %ecx                # iau valoarea intr o variabila
movl    %ecx, -4(%ebp)         # o pun la adressa  -4(%ebp) || primul element gen


# pasul 2

# todo - citesc nr de noduri (sa nu ma folosesc de .data sa citesc pe stiva) || apelez scanf ca sa citesc


pushl   $x                    # incarcam in stiva NU x, ci ADRESA lui x || adica nu x, ci £x
pushl   $formatString         # incarcam adresa formatului
call    scanf                  # apelam scanf
popl    %ebx                   # descarcam ce am incarcat in stiva
popl    %ebx

# pun pe stiva
subl    $4, %esp               # alocam un spatiu pe stiva
movl    x, %ecx                # iau valoarea intr o variabila
movl    %ecx, -8(%ebp)         # o pun la adressa  -8(%ebp) || al doilea element gen

# pasul 3

# facem un for de la 0 la nr de noduri (in cazul nostru este -8(%ebp)) si citiim cu scanf 

movl $0, %edx
lea -12(%ebp), %eax         # pun in %eax adresa de inceput a vectorului "plm"

iteratie:
    cmp %edx, -8(%ebp)      # conditie de iteratie
    je  end_iteratie

    pushl   %edx             # pun pe stiva ca se fute

    pushl   $x                 # pun parametrii ca sa apelez scanf
    pushl   $formatString
    call    scanf
    popl    %ebx
    popl    %ebx

    popl    %edx            # scot de pe stiva ce am pus sa nu se futa

    # aloc memorie pe stiva
    subl    $4, %esp
    movl    x, %ecx
    
    # vreau sa l pun pe %ecx la adresa (%eax - 4 * edx)

    movl    %edx, %ebx             # copy the value of edx to ebx
    shl     $2, %ebx               # multiply ebx by 4 (shift left by 2 places)
    subl    %ebx, %eax             # subtract the value in ebx from the address in eax
    movl    %ecx, %eax             # add the value in ecx to the address in eax

    add     $1, %edx                # incrementez iteratorul

    pushl %eax
    pushl %edx

    # printez sa verific iteratorul mamei lui ca nu mi iese din loop
    xor %ecx, %ecx
    pushl %edx
    pushl $errorPrintf
    call printf
    popl %ebx
    popl %ebx
    pushl $0
    call fflush
    popl %ebx

    popl %edx
    popl %eax

    jmp     iteratie                # fac loop

end_iteratie:




popl %ebp
et_exit:
    movl $1, %eax
    xorl %ebx, %ebx
    int $0x80
