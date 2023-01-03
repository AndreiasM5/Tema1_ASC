# parcurg vectorii de adiacenta si completez matricea cu 1
xor     %ebx, %ebx
for3:
    cmp     %ebx, -8(%ebp)              # ebx e contor pt nod
    je      end_for3
    xor     %ecx, %ecx
for4:
    pushl   %ebx
    pushl   %ecx
    lea     -12(%ebp), %eax             # iau adresa de inceput a vectorului de marimi
    shl     $2, %ebx                    # fac cnt_nod x 4
    subl    %ebx, %eax                  # in eax am adresa dimensiunii fiecarui vector
    movl    (%eax), %edx
    popl    %ecx
    popl    %ebx

    cmp     %ecx, %edx                  # edx = lungimea fiecarui vector de adiacenta
    je      end_for4

    # todo - adresa de inceput a matricei, pot oare sa fac esp - nr_noduri x nr_noduri?
    # aici ar trb sa fac adresa de inceput a fiecarui rand
    pushl   %eax
    pushl   %ebx
    pushl   %ecx
    call    calc_inceputul_mat
    popl    %ecx
    popl    %ebx
    popl    %eax
    # adresa se afla in edx

    # aici ar trb sa fac ceva de genu: am adresa de inceput a matricei si am vectorul de adiacenta pt fiecare nod
    # de ex vectorul de adiacenta e {1,2} atunci fac {inceput mat + 1 * 4} -> aici pun 1 



    add     $1, %ecx
end_for4:
    add     $1, %ebx
end_for3: