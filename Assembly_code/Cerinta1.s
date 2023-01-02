.data
    x: .space 4
    printEbx: .asciz "contorul EBX este = %d\n"
    formatString: .asciz "%d"
    errorPrintf: .asciz "Contorul meu edx este = %d\n"
    printfor1: .asciz "Contorul ebx pt for1 este = %d\n"
    printfor2: .asciz "Contorul ecx pt for2 este = %d\n"
    printeax: .asciz "Eax este egal cu %d\n"
    printadresainceputvector: .asciz "Inceputul este egal cu %d si ar trebuie sa fie 2.\n\n\n"
    printecx: .asciz "ECX este egal cu %d\n"
.text

.global main
main:
pushl %ebp
movl %esp, %ebp

# pasul 1
# todo - citesc nr cerintei ||  apelez scanf ca sa citesc
 
pushl   $x                          # incarcam in stiva NU x, ci ADRESA lui x || adica nu x, ci £x
pushl   $formatString               # incarcam adresa formatului
call    scanf                       # apelam scanf
popl    %ebx                        # descarcam ce am incarcat in stiva
popl    %ebx

# pun pe stiva
subl    $4, %esp                    # alocam un spatiu pe stiva
movl    x, %ecx                     # iau valoarea intr o variabila
movl    %ecx, -4(%ebp)              # o pun la adressa  -4(%ebp) || primul element gen || nr cerintei

# pasul 2
# todo - citesc nr de noduri (sa nu ma folosesc de .data sa citesc pe stiva) || apelez scanf ca sa citesc

pushl   $x                          # incarcam in stiva NU x, ci ADRESA lui x || adica nu x, ci £x
pushl   $formatString               # incarcam adresa formatului
call    scanf                       # apelam scanf
popl    %ebx                        # descarcam ce am incarcat in stiva
popl    %ebx

# pun pe stiva
subl    $4, %esp                    # alocam un spatiu pe stiva
movl    x, %ecx                     # iau valoarea intr o variabila
movl    %ecx, -8(%ebp)              # o pun la adressa  -8(%ebp) || al doilea element gen || nr de noduri

# pasul 3
# facem un for de la 0 la nr de noduri (in cazul nostru este -8(%ebp)) si citiim cu scanf 

movl $0, %edx
lea -12(%ebp), %eax                 # pun in %eax adresa de inceput a vectorului "plm"

iteratie:
    cmp     %edx, -8(%ebp)          # conditie de iteratie
    je      end_iteratie
    
    pushl   %edx                    # pun pe stiva ca se fute

    pushl   $x                      # pun parametrii ca sa apelez scanf
    pushl   $formatString
    call    scanf
    popl    %ebx
    popl    %ebx

    popl    %edx                    # scot de pe stiva ce am pus sa nu se futa

    # aloc memorie pe stiva
    subl    $4, %esp
    movl    x, %ecx

    pushl   %eax                      # am pus toti registrii pe stiva ca sa fac printare
    pushl   %ebx
    pushl   %ecx
    pushl   %edx
    pushl   %ecx
    pushl   $printecx
    call    printf                    # printez ecx care ar trebui sa fie valoarea tocmai citita de la tastatura
    popl    %ebx
    popl    %ebx
    pushl   $0
    call    fflush
    popl    %ebx
    popl    %edx                     # iau registrii de pe stiva dupa printare
    popl    %ecx
    popl    %ebx
    popl    %eax

    
    # vreau sa l pun pe %ecx la adresa (%eax - 4 * edx)
    lea     -12(%ebp), %eax

    movl    %edx, %ebx              # copy the value of edx to ebx
    shl     $2, %ebx                # multiply ebx by 4 (shift left by 2 places)
    subl    %ebx, %eax              # subtract the value in ebx from the address in eax
    movl    %ecx, (%eax)            # add the value in ecx to the address in eax

    add     $1, %edx                # incrementez iteratorul

    pushl   %eax
    pushl   %edx
    xor     %ecx, %ecx
    pushl   %edx
    pushl   $errorPrintf            # printez sa verific iteratorul mamei lui ca nu mi iese din loop     
    call    printf
    popl    %ebx
    popl    %ebx
    pushl   $0
    call    fflush
    popl    %ebx
    popl    %edx
    popl    %eax

    jmp     iteratie                # fac loop

end_iteratie:

# printez ce se afla la -12(%ebp)
    xor     %eax, %eax
    xor     %ecx, %ecx
    lea     -12(%ebp), %eax
    movl    (%eax), %ecx
    pushl   %ecx                  
    pushl   $printadresainceputvector
    call    printf
    popl    %ebx
    popl    %ebx
    pushl   $0
    call    fflush
    popl    %ebx


# pasul 4
# un for de la primul pana la ultimul element din vectorul nostru
# pentru a citii cate un vector de adiacenta pentru fiecare nod in parte
# o sa avem nevoie de 3 contori, ebx, ecx, edx pt for1 for2 si pt adaugare de elemente
# ebx contorul pt for1
# ecx contorul pt for2
# edx contorul pt adautare de elemente

xor     %eax, %eax
xor     %ebx, %ebx
xor     %ecx, %ecx
xor     %edx, %edx
xor     %edi, %edi

lea     -12(%ebp), %eax                     # pun in %eax adresa de inceput a vectorului "plm"

for1:
    cmp     %ebx, -8(%ebp)                  # compar contorul ebx cu nr de noduri
    je      end_for1

    xor     %ecx, %ecx
for2:
    pushl   %ebx                            # am pus toti registrii pe stiva ca sa fac calculul
    pushl   %ecx
    pushl   %edx
    xor     %ecx, %ecx
    lea     -12(%ebp), %ecx                 # pun in ecx adresa de inceput a vectorului
    xor     %eax, %eax
    shl     $2, %ebx
    subl    %ebx, %ecx
    movl    (%ecx), %eax                    # teoretic ar trb ca in eax sa am (%ecx - 4 * %ebx) fiecare element din vector
    popl    %edx                            # iau registrii de pe stiva
    popl    %ecx
    popl    %ebx

    pushl   %eax                            # am pus toti registrii pe stiva ca sa fac printf
    pushl   %ebx
    pushl   %ecx
    pushl   %edx
    xor     %ecx, %ecx
    movl    %eax, %ecx
    pushl   %ecx                            # printez eax
    pushl   $printeax
    call    printf
    popl    %ebx
    popl    %ebx
    pushl   $0
    call    fflush
    popl    %ebx
    popl    %edx                            # iau registrii de pe stiva dupa scriere
    popl    %ecx
    popl    %ebx
    popl    %eax

    cmp     %ecx, %eax                      # compar contorul ecx cu elementul[ebx] din vector <=> (%eax - 4 * ebx)
    je      end_for2

    pushl   %eax                            # sa pun pe stiva tot ca se fute
    pushl   %ebx
    pushl   %ecx
    pushl   %edx
    pushl   $x                              # pun parametrii ca sa apelez scanf
    pushl   $formatString
    call    scanf
    popl    %ebx
    popl    %ebx
    popl    %edx                            # iau registrii de pe stiva
    popl    %ecx
    popl    %ebx
    popl    %eax

    pushl   %eax                            # am pus toti registrii pe stiva ca sa fac scriere
    pushl   %ebx
    pushl   %ecx
    pushl   %edx
    pushl   %ecx                            # printez ecx
    pushl   $printfor2
    call    printf
    popl    %ebx
    popl    %ebx
    pushl   $0
    call    fflush
    popl    %ebx
    popl    %edx                            # iau registrii de pe stiva dupa scriere
    popl    %ecx
    popl    %ebx
    popl    %eax

    # aloc memorie pe stiva
    subl    $4, %esp                        # eax asta nu are treaba cu eax de sus 
    movl    x, %eax                         # o sa pun de data asta valoarea in eax ca de restul parametrilor am nevoie
    
    pushl   %eax                            # sa pun pe stiva tot ca se fute
    pushl   %ebx
    pushl   %ecx
    pushl   %edx

    lea     -12(%ebp), %ecx                 # pun valoarea lui x care se afla in %eax 
    movl    %edx, %esi                      # la adresa (-12(%ebp) - -8(%ebp) * 4 - 4 * edx)
    shl     $2, %esi                        # adica adresa de inceput a {vect plm - nr_noduri * 4 - 4 * contor}
    movl    -8(%ebp), %ebx
    shl     $2, %ebx
    subl    %ebx, %ecx
    subl    %esi, %ecx                      # carnatul de adr se afla in %ecx
    movl    %eax, (%ecx)                    # pun %eax in (%ecx)

    popl    %edx                            # iau registrii de pe stiva
    popl    %ecx
    popl    %ebx
    popl    %eax

    add     $1, %edx                        # incrementez iteratorul edx pt alocare de mem
    add     $1, %ecx                        # incrementez iteratorul ecx pt for2

    jmp     for2

end_for2:
    pushl   %eax                      # am pus toti registrii pe stiva ca sa fac scriere
    pushl   %ebx
    pushl   %ecx
    pushl   %edx

    xor     %ecx, %ecx
    movl    %ebx, %ecx
    pushl   %ecx                      # printez contorul ebx din primul for
    pushl   $printfor1
    call    printf
    popl    %ebx
    popl    %ebx
    pushl   $0
    call    fflush
    popl    %ebx
    
    popl    %edx                     # iau registrii de pe stiva dupa scriere
    popl    %ecx
    popl    %ebx
    popl    %eax
    
    add     $1, %ebx                 # incrementez iteratorul
    jmp     for1

end_for1:


    popl    %ebp
et_exit:
    movl    $1, %eax
    xorl    %ebx, %ebx
    int $0x80
