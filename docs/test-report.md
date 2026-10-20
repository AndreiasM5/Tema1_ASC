# Tema1_ASC — raport de testare

Repository: https://github.com/AndreiasM5/Tema1_ASC
Commit analizat: 1965a73 (+makefile). Sursa Cerinta1.s nu a fost modificată.

Mediu: Linux x86 pe Compiler Explorer, GCC 13.2, compilare și execuție a sursei originale cu opțiunile -x assembler -m32 -no-pie. Execuția a fost remote; calculatorul Windows nu are WSL/Docker instalat.

**Rezultat: 16/16 teste trecute.**

- PASS — Exemplul din repository 1
- PASS — Exemplul din repository 2
- PASS — Exemplul din repository 3
- PASS — Un nod fără muchii
- PASS — Un nod cu buclă
- PASS — Două noduri, arc într-un singur sens
- PASS — 100 de noduri izolate
- PASS — Lanț orientat de 100 de noduri
- PASS — 100 de bucle proprii
- PASS — Graf complet cu 100 de noduri, fără bucle
- PASS — Matrice plină 100 × 100, inclusiv bucle
- PASS — Graf pseudoaleator 2 noduri
- PASS — Graf pseudoaleator 7 noduri
- PASS — Graf pseudoaleator 17 noduri
- PASS — Graf pseudoaleator 31 noduri
- PASS — Graf pseudoaleator 100 noduri

Rezultatele sunt comparate linie cu linie cu matricea așteptată. Se ignoră doar spațiile de formatare, inclusiv spațiul suplimentar imprimat la finalul fiecărui rând. Grafurile pseudoaleatoare folosesc o sămânță fixă.

Limite: testele verifică intrări valide pentru cerința 1. Nu reprezintă verificare exhaustivă, validare a intrărilor incorecte sau verificare completă a convențiilor ABI. Makefile-ul local Windows nu a fost executat; s-a folosit aceeași sursă și aceleași opțiuni esențiale de compilare în Linux.
