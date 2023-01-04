# Tema1_ASC

-12(ebp) - contor nod x 4  
_______________
|     $s      |
| nr_cerinta  |                         -4(%ebp)
| nr_noduri   |                         -8
|      2      |     v0 lenght           -12
|      2      |     v1 lenght           -16
|      1      |     v2 lenght           -20
|      0      |     v3 lenght           -24
|      1      |     v0[0]               -28      nr nod 0 primul element    ebx = 0     ecx = 0
|      2      |     v0[1]               -32           ebx = 0      ecx = 1
|      2      |     v1[0]               -36           ebx = 1      ecx = 0
|      3      |     v1[1]               -40
|      3      |     v2[1]               -44
|      0      |          0 1 1 0        -48 -16-12 = -28
|      1      |          0 0 1 1
|      1      |          0 0 0 1           
|      0      |          0 0 0 0            
|      0      |                             
|      0      |
|      1      |
|      1      |
|      0      |
|      0      |
|      0      |
|      1      |
|      0      |
|      0      |
|      0      |
|      0      |
|             |

0 1 1 0
0 0 1 1
0 0 0 1
0 0 0 0