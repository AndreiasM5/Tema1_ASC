.data
    x: .space 4
    printEbx: .asciz "contorul EBX este = %d\n"
    formatString: .asciz "%d"
    errorPrintf: .asciz "Contorul meu edx este = %d\n"
    printfor1: .asciz "Sunt in for 1 cu ebx = %d\n"
    printfor2: .asciz "Sunt in for 2 cu ecx = %d\n"
    printedi: .asciz "Edi este egal cu %d\n"
    printadresainceputvector: .asciz "inceputul este egal cu %d si ar trebuie sa fie 2.\n"
    printecx: .asciz "ECX este egal cu %d\n"
.text

.global main
main:
pushl %ebp
movl %esp, %ebp

# pasul 1

# todo - citesc nr cerintei ||  apelez scanf ca sa citesc
 
pushl   $x                      # incarcam in stiva NU x, ci ADRESA lui x || adica nu x, ci £x
pushl   $formatString           # incarcam adresa formatului
call    scanf                   # apelam scanf
popl    %ebx                    # descarcam ce am incarcat in stiva
popl    %ebx

# pun pe stiva
subl    $4, %esp                # alocam un spatiu pe stiva
movl    x, %ecx                 # iau valoarea intr o variabila
movl    %ecx, -4(%ebp)          # o pun la adressa  -4(%ebp) || primul element gen || nr cerintei


# pasul 2

# todo - citesc nr de noduri (sa nu ma folosesc de .data sa citesc pe stiva) || apelez scanf ca sa citesc

pushl   $x                      # incarcam in stiva NU x, ci ADRESA lui x || adica nu x, ci £x
pushl   $formatString           # incarcam adresa formatului
call    scanf                   # apelam scanf
popl    %ebx                    # descarcam ce am incarcat in stiva
popl    %ebx

# pun pe stiva
subl    $4, %esp                # alocam un spatiu pe stiva
movl    x, %ecx                 # iau valoarea intr o variabila
movl    %ecx, -8(%ebp)          # o pun la adressa  -8(%ebp) || al doilea element gen || nr de noduri

# pasul 3

# facem un for de la 0 la nr de noduri (in cazul nostru este -8(%ebp)) si citiim cu scanf 

movl $0, %edx
lea -12(%ebp), %eax             # pun in %eax adresa de inceput a vectorului "plm" ??????????????????????????????????????????

iteratie:
    cmp %edx, -8(%ebp)          # conditie de iteratie
    je  end_iteratie
    

    pushl   %edx                # pun pe stiva ca se fute

    pushl   $x                  # pun parametrii ca sa apelez scanf
    pushl   $formatString
    call    scanf
    popl    %ebx
    popl    %ebx

    popl    %edx                # scot de pe stiva ce am pus sa nu se futa

    # aloc memorie pe stiva
    subl    $4, %esp
    movl    x, %ecx

    # printez ecx care ar trebui sa fie valoarea tocmai citita de la tastatura

    pushl %eax                      # am pus toti registrii pe stiva ca sa fac printare
    pushl %ebx
    pushl %ecx
    pushl %edx

    pushl %ecx
    pushl $printecx
    call printf
    popl %ebx
    popl %ebx
    pushl $0
    call fflush
    popl %ebx

     
    popl    %edx                     # iau registrii de pe stiva dupa printare
    popl    %ecx
    popl    %ebx
    popl    %eax

    
    # vreau sa l pun pe %ecx la adresa (%eax - 4 * edx)
    lea -12(%ebp), %eax

    movl    %edx, %ebx             # copy the value of edx to ebx
    shl     $2, %ebx               # multiply ebx by 4 (shift left by 2 places)
    subl    %ebx, %eax             # subtract the value in ebx from the address in eax
    movl    %ecx, (%eax)            # add the value in ecx to the address in eax

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



# printez ce se afla la -12(%ebp)
    xor %eax, %eax
    xor %ecx, %ecx
    lea -12(%ebp), %eax
    movl (%eax), %ecx
    pushl %ecx                  
    pushl $printadresainceputvector
    call printf
    popl %ebx
    popl %ebx
    pushl $0
    call fflush
    popl %ebx


# pasul 4

# un for de la primul pana la ultimul element din vectorul nostru
# pentru a citii cate un vector de adiacenta pentru fiecare nod in parte
# o sa avem nevoie de 3 contori, ebx, ecx, edx pt for1 for2 si pt adaugare de elemente

# ebx contorul pt for1
# ecx contorul pt for2
# edx contorul pt adautare de elemente

xor %eax, %eax
xor %ebx, %ebx
xor %ecx, %ecx
xor %edx, %edx

lea -12(%ebp), %eax         # pun in %eax adresa de inceput a vectorului "plm"

for1:

    cmp %ebx, -8(%ebp)      # compar contorul ebx cu nr de noduri
    je end_for1

    
    pushl %eax                      # am pus toti registrii pe stiva ca sa fac scriere
    pushl %ebx
    pushl %ecx
    pushl %edx

    xor %ecx, %ecx
    movl %ebx, %ecx
    pushl %ecx                      # printez contorul ebx din primul for
    pushl $printfor1
    call printf
    popl %ebx
    popl %ebx
    pushl $0
    call fflush
    popl %ebx

    
    popl    %edx                     # iau registrii de pe stiva dupa scriere
    popl    %ecx
    popl    %ebx
    popl    %eax

for2:

    
    pushl %eax                      # am pus toti registrii pe stiva ca sa fac scriere
    pushl %ebx
    pushl %ecx
    pushl %edx


    pushl %ecx                      # printez ecx
    pushl $printfor2
    call printf
    popl %ebx
    popl %ebx
    pushl $0
    call fflush
    popl %ebx

   
    popl    %edx                     # iau registrii de pe stiva dupa scriere
    popl    %ecx
    popl    %ebx
    popl    %eax

    pushl %eax                      # am pus toti registrii pe stiva ca sa fac calculul
    pushl %ebx
    pushl %ecx
    pushl %edx

    lea     -12(%ebp), %ecx              # pun in ecx adresa de inceput a vectorului
    xor     %eax, %eax
    xor     %edx, %edx
    movl    $4, %edx
    movl    %ebx, %eax
    mull    %edx
    subl    %eax, %ecx
    movl    (%ecx), %edi              # teoretic ar trb ca in edi sa am (%ecx - 4 * %ebx)

    popl    %edx                     # iau registrii de pe stiva
    popl    %ecx
    popl    %ebx
    popl    %eax

    pushl %edi
    pushl %eax                      # am pus toti registrii pe stiva ca sa fac scriere si edi
    pushl %ebx
    pushl %ecx
    pushl %edx

    xor %ecx, %ecx
    movl %edi, %ecx
    pushl %ecx                   # printez edi
    pushl $printedi
    call printf
    popl %ebx
    popl %ebx
    pushl $0
    call fflush
    popl %ebx

   
    popl    %edx                     # iau registrii de pe stiva dupa scriere si edi
    popl    %ecx
    popl    %ebx
    popl    %eax
    popl    %edi

    cmp     %ecx, %edi            # compar contorul ecx cu elementul[ebx] din vector <=> (%eax - 4 * ebx)
    je      end_for2

    # sa pun pe stiva tot ca se fute
    pushl %eax
    pushl %ebx
    pushl %ecx
    pushl %edx

    pushl   $x                 # pun parametrii ca sa apelez scanf
    pushl   $formatString
    call    scanf
    popl    %ebx
    popl    %ebx

    # aloc memorie pe stiva
    subl    $4, %esp
    movl    x, %edi             # o sa pun de data asta valoarea in edi ca de restul parametrilor am nevoie

    popl    %edx                     # iau registrii de pe stiva
    popl    %ecx
    popl    %ebx
    popl    %eax

    # sa pun pe stiva tot ca se fute
    pushl %eax
    pushl %ebx
    pushl %ecx
    pushl %edx

    # vreau sa l pun pe %edi la adresa (-12(%ebp) - -8(%ebp) * 4 - 4 * edx) => %ebp - 12 - (ebp - 8) * 4 - 4 * edx
    # adresa de inceput a vectorului plm (%eax) - nr_de noduri * 4 (-8(%ebp) * 4) - 4 * edx
    # teoretic carnatul asta e adresa de inceput a " matricei"

    # simplificam carnatul
    # %ebp - 12 - (ebp - 8) * 4 - 4 * edx => %ebp - 12 - 4 * ebp + 32 - 4 * edx => (%ebp + 20 - 4 * ebp - 4 * edx)

    # simplificam carnatul v2
    # %eax - -8(%ebp) * 4 - 4 * edx 
    # %eax - -8(%ebp) * 4 - esi
    # %eax - ebx - esi

    movl    %edx, %esi
    shl     $2, %esi
    movl    -8(%ebp), %ebx
    shl     $2, %ebx
    subl    %eax, %ebx
    subl    %eax, %esi              # carnatul se afla in eax

    movl    %edi, %eax


    # TODO
   

    popl    %edx                     # iau registrii de pe stiva
    popl    %ecx
    popl    %ebx
    popl    %eax

    add     $1, %edx                # incrementez iteratorul
    add     $1, %ecx                # incrementez iteratorul
    jmp     for2

end_for2:

    add     $1, %ebx                # incrementez iteratorul
    jmp     for1

end_for1:


popl %ebp
et_exit:
    movl $1, %eax
    xorl %ebx, %ebx
    int $0x80
