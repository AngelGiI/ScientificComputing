INTEGER n, m, suma

PRINT*, ' Introducir n, m (0,0 para terminar)'
READ*, n, m
IF (n==0 .AND. m==0) STOP

suma = 0
DO i = n*m, n+m+n*m, MIN(n,m)
  suma = suma + i
  PRINT*, ' n = ', n, ' m = ', m, ' Suma = ', suma
  n = 2*n - 3
ENDDO
END