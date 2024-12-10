REAL a(5,7), b(7,4), c(5,4)

! Inicializacion de las matrices a, b

DO 10 i = 1, 5
DO 10 k = 1, 7
10 a(i,k) = 2.3*i + 4.1*k

DO 20 k = 1, 7
DO 20 j = 1, 4
20 b(k,j) = 1.7*k - 3.2*j

! Calculo de la matriz producto

DO 30 i = 1, 5
DO 30 j = 1, 4
c(i,j) = 0
DO 30 k = 1, 7
30 c(i,j) = c(i,j) + a(i,k)*b(k,j)

PRINT*, c
END