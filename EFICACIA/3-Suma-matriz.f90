! ======================================================================
! Suma de los elementos de una matriz de grandes dimensiones.
! Bloques DO's i-j, j-i y funcion SUM. Tiempo de calculo, precisión.
! ======================================================================

PROGRAM sumamat
IMPLICIT NONE

! Probar el programa con n=6000,7000,...

INTEGER, PARAMETER:: n=10000
REAL a(n,n), s, t1, t2
INTEGER i, j

CALL CPU_TIME (t1)
CALL RANDOM_NUMBER (a)
CALL CPU_TIME (t2)
PRINT '(/A,I10,A,F10.3)', 'n = ', n, ' Tiempo RANDOM_NUMBER : ', t2-t1

CALL CPU_TIME (t1)
s = 0.0
DO i = 1, n
  DO j = 1, n
    s = s + a(i,j)
  ENDDO
ENDDO
CALL CPU_TIME (t2)
s = s / (n*n)
PRINT '(A,F10.3,3X,A,G20.10)', 'Tiempo i-j : ', t2-t1, 's = ', s

CALL CPU_TIME (t1)
s = 0.0
DO j = 1, n
  DO i = 1, n
    s = s + a(i,j)
  ENDDO
ENDDO
CALL CPU_TIME (t2)
s = s / (n*n)
PRINT '(A,F10.3,3X,A,G20.10)', 'Tiempo j-i : ', t2-t1, 's = ', s
 
CALL CPU_TIME (t1)
s = SUM(a)
CALL CPU_TIME (t2)
s = s / (n*n)
PRINT '(A,F10.3,3X,A,G20.10)', 'Tiempo SUM : ', t2-t1, 's = ', s

ENDPROGRAM sumamat

