! ======================================================================
! Suma de los elementos de un vector de gran dimension.
! Bloque DO y funcion SUM. Tiempo de calculo, precisión.
! ======================================================================

PROGRAM sumavec
IMPLICIT NONE

INTEGER, PARAMETER:: n=5e7
REAL a(n), s, t1, t2
INTEGER i

CALL CPU_TIME (t1)
CALL RANDOM_NUMBER (a)
CALL CPU_TIME (t2)
PRINT '(/A,I10,A,F10.3)', 'n = ', n, ' Tiempo RANDOM_NUMBER : ', t2-t1

CALL CPU_TIME (t1)
s = 0.0
DO i = 1, n
  s = s + a(i)
ENDDO
CALL CPU_TIME (t2)
s = s / n
PRINT '(A,F10.3,3X,A,G20.10)', 'Tiempo DO  : ', t2-t1, 's = ', s
 
CALL CPU_TIME (t1)
s = SUM(a)
CALL CPU_TIME (t2)
s = s / n
PRINT '(A,F10.3,3X,A,G20.10)', 'Tiempo SUM : ', t2-t1, 's = ', s

ENDPROGRAM sumavec

