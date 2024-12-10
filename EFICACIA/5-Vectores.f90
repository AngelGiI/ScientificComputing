! ======================================================================
! Operaciones con subindices en vectores de gran dimension.
! ======================================================================

PROGRAM vectores_subindices
IMPLICIT NONE

INTEGER, PARAMETER:: n=100000000
REAL a(n), b(n), c(n), d(n), t1, t2
INTEGER i

CALL CPU_TIME (t1)
CALL RANDOM_NUMBER (b)
CALL RANDOM_NUMBER (c)
CALL RANDOM_NUMBER (d)
CALL CPU_TIME (t2)
PRINT '(/A,I10,A,F10.3)', 'n = ', n, ' Tiempo RANDOM_NUMBER : ', t2-t1

CALL CPU_TIME (t1)
DO i = 1, n
  a(i) = b(i)*c(i) + d(i)
ENDDO
CALL CPU_TIME (t2)
PRINT '(A,F10.3)', 'Tiempo subindices  : ', t2-t1
 
CALL CPU_TIME (t1)
a = b*c + d
CALL CPU_TIME (t2)
PRINT '(A,F10.3)', 'Tiempo vectores : ', t2-t1

ENDPROGRAM vectores_subindices

