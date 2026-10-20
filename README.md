# ASC — Liste de adiacență → matrice de adiacență

Tema 1 de laborator, **cerința 1**, pentru disciplina **Arhitectura Sistemelor de Calcul (ASC / Computer Systems Architecture)**, anul universitar **2022–2023**, Facultatea de Matematică și Informatică, Universitatea din București.

Program scris în **Assembly x86 pe 32 de biți, sintaxă AT&T**, care citește listele de adiacență ale unui graf orientat și afișează matricea sa de adiacență. Implementarea folosește stiva pentru stocarea datelor și apelează scanf, printf și fflush din biblioteca C.

## Compilare și rulare

Este necesar un mediu **Linux x86 cu suport pentru executabile pe 32 de biți**, GCC și GNU Make. Pe un Ubuntu/Debian x86-64, dependențele pot fi instalate cu:

~~~bash
sudo apt update
sudo apt install gcc-multilib make
make -B
./Cerinta1 < input/input1.txt
~~~

Opțiunea -B forțează recompilarea sursei, deoarece repository-ul include și un executabil precompilat. Comanda din makefile este:

~~~bash
gcc -o Cerinta1 Cerinta1.s -m32 -no-pie
~~~

Programul folosește apelul Linux int 0x80 pentru terminare, deci GCC pentru Windows/MinGW nu este un înlocuitor direct. Pe Windows se poate folosi un mediu Linux compatibil, cum ar fi WSL cu dependențele de mai sus.

## Formatul datelor

- Prima valoare: 1, numărul cerinței implementate.
- A doua valoare: N, numărul de noduri, cel mult 100.
- Următoarele N valori: numărul vecinilor fiecărui nod.
- Urmează vecinii nodului 0, apoi ai nodului 1 etc.; nodurile sunt numerotate de la 0 la N−1.
- Rezultat: N rânduri a câte N valori; poziția (i, j) este 1 dacă există arcul i → j, altfel 0.

Repository-ul implementează numai cerința 1; referințele la cerințele 2 și 3 din enunț fac parte din tema originală.

## Fișiere

| Fișier/director | Rol |
| --- | --- |
| Cerinta1.s | Sursa Assembly comentată |
| makefile | Compilare cu GCC pe 32 de biți |
| Cerinta1 | Executabilul precompilat original |
| input/ | Trei exemple de intrare |
| output/ | Matricele așteptate pentru exemple |
| docs/test-report.md | Rezultatele verificării sursei originale |

Numele fișierelor de ieșire păstrează forma originală: outpu1.txt, outpu2.txt și output3.txt.

## Verificare

**16/16 teste trecute** la compilarea și executarea sursei originale pe Linux, prin Compiler Explorer, cu GCC 13.2 și opțiunile -x assembler -m32 -no-pie. Au fost verificate cele trei exemple, noduri fără muchii, bucle, grafuri complete, limita de 100 de noduri și grafuri pseudoaleatoare cu sămânță fixă.

Comparația păstrează structura matricei și ignoră numai spațiile de formatare. Testele acoperă intrări valide pentru cerința 1; nu sunt o verificare exhaustivă sau o validare a intrărilor incorecte. Execuția a fost într-un mediu Linux remote, nu nativ pe Windows. Detalii în [raportul de testare](docs/test-report.md).

## Enunțul și explicațiile originale

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

---
Copyright 2023 Ivascu Ioan-Andrei (143).
