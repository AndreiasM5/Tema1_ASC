// Copyright 2023 Ivascu Ioan-Andrei (143)
# Tema1_ASC
Tema 1 de laborator ASC 2022-2023

Acesta este un cod scris in Assembly x86 32-bit AT&T care primeste drept input un numar cerinta, respectiv 1,
dupa numarul de noduri al unu graf orientat, un vector de nr_noduri elemente la care fiecare element din vector
reprezinta lungimea fiecarui vector de adiacenta a nodului respectiv, adica cu cate noduri mai are acesta conexiuni,
dupa acest vector primeste nr_noduri de vectori in care se afla nodurile adiacente fiecarui nod.
In final cu acest input acesta stocheaza in memorie matricea de adiacenta dupa care o printeaza pe ecran

Cerinta primita:
Se citesc de la tastatura (STDIN) listele de adiacenta ale grafului orientat G si se cere sa se
afiseze matricea de adiacenta. Astfel, se vor citi, cate o valoare pe linie:
• 1 reprezentand numarul cerintei; pentru cerintele 2 si 3, aceasta valoare va fi 2, respectiv 3;
• N <= 100 numarul de noduri ale grafului;
• N linii pe care se vor afla valorile M0, M1, ..., MN−1, reprezentand numarul de legaturi pentru
fiecare nod in parte;
• M0 linii pe care se vor afla vecinii nodului 0, apoi M1 linii pe care se vor afla vecinii nodului
1, ..., apoi MN−1 linii pe care se vor afla vecinii nodului N-1.
De exemplu, pentru graful din Sectiunea 2, considerand nodurile A = 0, B = 1, C = 2, D =
3, inputul ar avea urmatoarea forma (evident, fara comentariile din dreapta, acestea au fost puse
pentru a va fi clar ce inseamna fiecare valoare):
1 // numarul cerintei
4 // nr. noduri
2 // 0 are 2 legaturi (cu 1 si 2)
2 // 1 are 2 legaturi (cu 2 si 3)
1 // 2 are 1 legatura (cu 3)
0 // 3 nu are nicio legatura
1 // legaturile
2 // nodului 0
2 // legaturile
3 // nodului 1
3 // legatura nodului 2
In urma primirii acestui input, se va afisa la STDOUT urmatorul output:
0 1 1 0
0 0 1 1
0 0 0 1
0 0 0 0
reprezentand matricea de adiacenta construita

O reprezentare a stivei mele pentru exemplul dat: 
_______________
|     $s      |                          0(%ebp)
|      1      |     nr_cerinta          -4(%ebp)
|      4      |     nr_noduri           -8(%ebp)
|      2      |     v0 lenght           -12(%ebp)
|      2      |     v1 lenght           -16(%ebp)
|      1      |     v2 lenght           -20(%ebp)
|      0      |     v3 lenght           -24(%ebp)
|      1      |     v0[0]               -28(%ebp)   
|      2      |     v0[1]               -32(%ebp)           
|      2      |     v1[0]               -36(%ebp)           
|      3      |     v1[1]               -40(%ebp)
|      3      |     v2[1]               -44(%ebp)
|      0      |                         -48(%ebp) 
|      1      |                         -52(%ebp)
|      1      |                         -56(%ebp)
|      0      |                         -60(%ebp)
|      0      |                         -64(%ebp)
|      0      |                         -68(%ebp)
|      1      |                         -72(%ebp)
|      1      |                         -76(%ebp)
|      0      |                         -80(%ebp)
|      0      |                         -84(%ebp)
|      0      |                         -88(%ebp)
|      1      |                         -92(%ebp)
|      0      |                         -96(%ebp)
|      0      |                         -100(%ebp)
|      0      |                         -104(%ebp)
|      0      |                         -108(%ebp) - %esp
