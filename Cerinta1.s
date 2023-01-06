# Copyright 2023 Ivascu Ioan-Andrei (143)
.data
    x: .space 4                     # spatiul necesar pentru un numar citit
    formatString: .asciz "%d"       # formatul de citire
    formatPrint: .asciz "%d "       # formatul de printare un numar cu spatiu dupa el
    format_new_line: .asciz "\n"    # formatul de printare un new line
.text

.global main
main:
pushl   %ebp                        # pun ebp pe stiva pentru a nu ii pierde valoarea
movl    %esp, %ebp                  # creez spatiul de memorie egaland esp cu ebp si incepand sa scad esp

# pasul 1
# citesc nr cerintei
 
pushl   $x                          # incarcam in stiva NU x, ci ADRESA lui x || adica nu x, ci $x
pushl   $formatString               # incarcam adresa formatului
call    scanf                       # apelam scanf
popl    %ebx                        # descarcam ce am incarcat in stiva
popl    %ebx

# pun pe stiva numarul tocami citit
subl    $4, %esp                    # alocam un spatiu pe stiva de 4 cat are si numarul tocmai citit
movl    x, %ecx                     # pun valoarea in registrul %ecx
movl    %ecx, -4(%ebp)              # o pun la adressa  -4(%ebp) || nr cerintei

# pasul 2
# citesc nr de noduri

pushl   $x                          # incarcam in stiva NU x, ci ADRESA lui x || adica nu x, ci £x
pushl   $formatString               # incarcam adresa formatului
call    scanf                       # apelam scanf
popl    %ebx                        # descarcam ce am incarcat in stiva
popl    %ebx

# pun pe stiva numarul tocami citit
subl    $4, %esp                    # alocam un spatiu pe stiva
movl    x, %ecx                     # pun valoarea in registrul %ecx
movl    %ecx, -8(%ebp)              # o pun la adressa  -8(%ebp) || nr de noduri

# pasul 3
# facem un for de la 0 la nr de noduri (in cazul nostru este -8(%ebp))

movl    $0, %edx                    # contorul pentru iteratie o sa fie edx care incepe de la 0
lea     -12(%ebp), %eax             # pun in %eax adresa de inceput a vectorului cu lungimile vectorilor de adiacenta

iteratie:
    cmp     %edx, -8(%ebp)          # conditie pentru iteratie
    je      end_iteratie            # daca contorul edx este egal cu nr de noduri ies din loop
    
    pushl   %edx                    # pun pe stiva pentru a nu pierde valoarea lui edx

    pushl   $x                      # pun parametrii ca sa apelez scanf
    pushl   $formatString
    call    scanf
    popl    %ebx
    popl    %ebx

    popl    %edx                    # scot de pe stiva ce am pus pentru a revenii la valoarea inainte de scanf

    # aloc memorie pe stiva
    subl    $4, %esp
    movl    x, %ecx
    
    # vreau sa l pun pe %ecx la adresa (%eax - 4 * edx)
    lea     -12(%ebp), %eax         # pun in eax adresa de start a vectorului

    movl    %edx, %ebx              # copiez valoarea lui edx in ebx
    shl     $2, %ebx                # shiftez ebx cu 2 pozitii, adica il inmultesc cu 4
    subl    %ebx, %eax              # scad din eax pe ebx(eax = eax - ebx)
    movl    %ecx, (%eax)            # pun pe ecx la valoarea de la adresa lui eax

    add     $1, %edx                # incrementez ebx (iteratorul)

    jmp     iteratie                # fac loop

end_iteratie:

# pasul 4
# un for de la primul pana la ultimul element din vectorul nostru
# pentru a citii cate un vector de adiacenta pentru fiecare nod in parte
# o sa avem nevoie de 3 contori, ebx, ecx, edx pt for1 for2 si pt adaugare de elemente
# ebx contorul pt for1
# ecx contorul pt for2
# edx contorul pt adautare de elemente

xor     %eax, %eax                  # fac xor registru, registru pentru a egala cu 0
xor     %ebx, %ebx                  # toti registrii de care nu mai am nevoie si
xor     %ecx, %ecx                  # urmeaza sa ii folosesc in urmatoarea parte
xor     %edx, %edx                  # din cod
xor     %edi, %edi

lea     -12(%ebp), %eax             # pun in %eax adresa de inceput a vectorului de vectori

for1:

    cmp     %ebx, -8(%ebp)          # compar contorul ebx cu nr de noduri
    je      end_for1                # sar la iesire din for daca contorul ajunge egal cu nr de noduri

    xor     %ecx, %ecx
for2:
    pushl   %ebx                    # am pus toti registrii pe stiva ca sa fac
    pushl   %ecx                    # un calcul cu ajutorul lor si sa nu le
    pushl   %edx                    # schimb valorile
    
    xor     %ecx, %ecx              # il fac pe ecx egal cu 0
    lea     -12(%ebp), %ecx         # pun in ecx adresa de inceput a vectorului
    xor     %eax, %eax              # il fac pe eax egal cu 0
    shl     $2, %ebx                # ebx = ebx x 4
    subl    %ebx, %ecx              # din ecx il scad pe ebx
    movl    (%ecx), %eax            # eax = %ecx - 4 * %ebx (lungimile fiecarui vector de adiacenta)
    
    popl    %edx                    # iau registrii de pe stiva
    popl    %ecx                    # pentru a ii intoarce la valoarea 
    popl    %ebx                    # pe care o aveau inainte de calcule

    cmp     %ecx, %eax              # compar contorul ecx cu elementul[ebx] 
    je      end_for2                # din vector <=> eax = %eax - 4 * ebx

    pushl   %eax                    # pun pe stiva registrii inainte de scanf
    pushl   %ebx
    pushl   %ecx
    pushl   %edx

    pushl   $x                      # pun parametrii ca sa apelez scanf
    pushl   $formatString
    call    scanf
    popl    %ebx                    # scot parametrii dupa scanf
    popl    %ebx
    
    popl    %edx                    # iau registrii de pe stiva dupa scanf
    popl    %ecx
    popl    %ebx
    popl    %eax

    # aloc memorie pe stiva
    subl    $4, %esp                # eax asta nu are treaba cu eax de sus 
    movl    x, %eax                 # o sa pun de data asta valoarea in eax ca de restul parametrilor am nevoie
    
    pushl   %eax                    # sa pun pe stiva tot pentru a nu pierde valorile
    pushl   %ebx
    pushl   %ecx
    pushl   %edx
    pushl   %esi

    lea     -12(%ebp), %ecx         # pun valoarea lui x care se afla in %eax 
    movl    %edx, %esi              # la adresa (-12(%ebp) - -8(%ebp) * 4 - 4 * edx)
    shl     $2, %esi                # adica adresa de inceput a vectorului - nr_noduri * 4 - 4 * contor
    movl    -8(%ebp), %ebx
    shl     $2, %ebx
    subl    %ebx, %ecx
    subl    %esi, %ecx              # toata adresa calculata se afla in %ecx
    movl    %eax, (%ecx)            # pun %eax in locul valorii de la adresa lui ecx

    popl    %esi                    # iau registrii de pe stiva dupa calcule
    popl    %edx                           
    popl    %ecx
    popl    %ebx
    popl    %eax

    add     $1, %edx                # incrementez iteratorul edx pt alocare de mem
    add     $1, %ecx                # incrementez iteratorul ecx pt for2

    jmp     for2                    # fac loop for2

end_for2:
    add     $1, %ebx                # incrementez iteratorul ebx
    jmp     for1                    # fac loop for1

end_for1:

movl    %esp, %edi                  # in edi se afla finalul citirii, adica de unde incepe
subl    $4, %edi                    # matricea in memorie
# sourcery (este decalat cu 4)

# pasul 5
# aloc pe stiva nr_noduri x nr_noduri toate cu valoarea 0

movl    -8(%ebp), %eax              # pun in eax numarul de noduri
movl    -8(%ebp), %ecx              # pun in ecx numarul de noduri
mull    %ecx                        # in eax am nr_noduri x nr_noduri

xor     %ebx, %ebx                  # edx = 0, o sa fie contorul pentru

calloc:                             # fac un calloc de nr_noduri x nr_noduri

    cmp     %ebx, %eax              # compar contorul ebx cu marimea matricei
    je      end_calloc

    subl     $4, %esp               # aloc memorie
    movl     $0, (%esp)             # initializez fiecare element din matrice cu valoarea 0

    add     $1, %ebx                # cresc contorul cu 1 la fiecare iteratie
    jmp     calloc                  # fac loop calloc

end_calloc:

# pasul 6 - populez matricea cu 1 acolo unde nodul este adiacent
# eax contor trecut prin toti vectorii
lea     -12(%ebp), %eax             # pun in eax adresa de inceput a primului vector
movl    -8(%ebp), %ecx              # pun in ecx nr_noduri
shl     $2, %ecx                    # ecx = ecx x 4
subl    %ecx, %eax                  # eax = eax - ecx

xor     %ebx, %ebx                  # ebx = 0, urmeaza sa fie contorul pentru for 3

for3:
    cmp     %ebx, -8(%ebp)          # compar contorul ebx cu nr de noduri  
    je      end_for3                # for de la 0 la nr de noduri
    
    pushl   %ecx                    # pun registrii pe stiva
    pushl   %ebx

    xor     %edx, %edx
    lea    -12(%ebp), %edx
    movl    %ebx, %ecx
    shl     $2, %ecx                # edx = -12(ebp) - ebx x 4
    subl    %ecx, %edx              # calculez in edx lungimea fiecarui vector de adiacenta
    movl    (%edx), %ecx
    movl    %ecx, %edx

    popl    %ebx                    # scot registrii de pe stiva
    popl    %ecx

    xor     %ecx, %ecx              # la fiecare intrare in for 3, ecx incepe de la 0
for4:

    cmp     %ecx, %edx              # compar contorul ecx cu marimea vectorului de adiacenta
    je      end_for4

    pushl   %eax                    # pun registrii pe stiva
    pushl   %ebx
    pushl   %ecx
    pushl   %edx
    pushl   %edi
    
    movl    -8(%ebp), %ecx
    shl     $2, %ecx
    movl    %eax,%edx
    movl    %ebx, %eax
    pushl   %edx                    # pun 1 la inceput matrice - (contor nod x nr noduri x 4) - ( valoare din v_adi x 4 )
    mull    %ecx                    # %edi =  %edi - (ebx x -8(ebp) x 4) - ( (eax) x 4 )
    popl    %edx                    # (edi) = 1
    subl    %eax, %edi
    movl    (%edx), %eax   
    shl     $2, %eax
    subl    %eax, %edi
    movl    $1, (%edi)

    popl    %edi                    # scot registrii de pe stiva
    popl    %edx
    popl    %ecx
    popl    %ebx
    popl    %eax

    
    addl    $1, %ecx                # ecx creste cu 1
    subl    $4, %eax                # eax scade cu 4 deoarece merg un element mai jos pe stiva
    jmp     for4                    # fac loop for4

end_for4:

    addl    $1, %ebx                # ebx creste cu 1
    jmp     for3                    # fac loop for3

end_for3:

# pasul 7 - printez matricea

movl    -8(%ebp), %eax              # in eax am nr_noduri
movl    -8(%ebp), %ecx              # in ecx am nr_noduri
mull    %ecx                        # in eax am nr_noduri x nr_noduri
movl    %eax, %ecx                  # in ecx am nr_noduri x nr_noduri

xor     %ebx, %ebx                  # ebx = 0, contor pentru print

print:
    cmp     %ebx, %ecx              # compar ebx cu nr_noduri
    je      end_print               # daca sunt egale ies din loop

    pushl   %edi                    # pun registrii pe stiva
    pushl   %ebx                  
    pushl   %ecx
    pushl   %edx
                                
    shl     $2, %ebx                # fac ebx = ebx * 4
    subl    %ebx, %edi              # edi = edi - ebx => imi rezulta o adresa pentru care edx e adresa
    movl    (%edi), %eax            # iau valoarea de la adresa aia cu () si o pun in eax
    
    popl    %edx                    # scot registrii de pe stiva
    popl    %ecx
    popl    %ebx
    popl    %edi

    # printez pe rand numerele

    pushl   %edi                    # pun registrii pe stiva
    pushl   %eax
    pushl   %ebx
    pushl   %ecx
    pushl   %edx

    pushl   %eax                    # elementul printat = edx - ebx * 4 = eax
    pushl   $formatPrint
    call    printf
    popl    %edx
    popl    %edx

    pushl   $0
    call    fflush
    popl    %edx

    popl    %edx                    # scot registrii de pe stiva
    popl    %ecx
    popl    %ebx
    popl    %eax
    popl    %edi

    add     $1, %ebx                # ebx creste cu 1

    # cand ebx este multiplu de nr noduri trebuie printat un new line

    pushl   %edi                    # pun registrii pe stiva
    pushl   %eax
    pushl   %ebx
    pushl   %ecx
    pushl   %edx

    movl    -8(%ebp), %ecx          # pun in ecx numarul de noduri
    movl    %ebx, %eax              # pun in eax contorul din print1, respectiv ebx
    divl    %ecx                    # impart eax la ecx, adica contorul la numarul de noduri
    
    cmp     $0, %edx                # compar 0 cu edx, adica restul impartirii cu 0
    jne     fara_endl               # daca restul este egal cu 0 inseamana ca am contor divizibil cu nr de noduri

    pushl   $format_new_line
    call    printf                  # printez un new line
    popl    %ebx

    pushl   $0
    call    fflush
    popl    %ebx

    fara_endl:

    popl    %edx                    # scot registrii de pe stiva
    popl    %ecx
    popl    %ebx
    popl    %eax
    popl    %edi

    jmp     print                   # fac loop print

end_print:

    popl    %ebp                    # il scot pe ebp de pe stiva si ma intorc la stiva initiala

et_exit:
    movl    $1, %eax
    xorl    %ebx, %ebx
    int     $0x80
