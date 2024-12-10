! ======================================================================
! Suprimir un bloque DO.
! ======================================================================

PROGRAM quitar_DO
IMPLICIT NONE

INTEGER, PARAMETER:: n=12000
REAL a(n,n,2), b(n,n), c(n), t1, t2
INTEGER i, j, k

CALL CPU_TIME (t1)
CALL RANDOM_NUMBER (b)
CALL RANDOM_NUMBER (c)
CALL CPU_TIME (t2)
PRINT '(/A,I10,A,F10.3)', 'n = ', n, ' Tiempo RANDOM_NUMBER : ', t2-t1

CALL CPU_TIME (t1)
DO j = 1, n
  DO i = 1, n
    DO k = 1, 2
      a(i,j,k) = b(i,j) + c(k)
    ENDDO
  ENDDO
ENDDO
CALL CPU_TIME (t2)
PRINT '(/A,F10.3)', 'Tiempo 3 DOs : ', t2-t1
 
CALL CPU_TIME (t1)
DO j = 1, n
  DO i = 1, n
    a(i,j,1) = b(i,j) + c(1)
    a(i,j,2) = b(i,j) + c(2)
  ENDDO
ENDDO
CALL CPU_TIME (t2)
PRINT '(/A,F10.3)', 'Tiempo 2 DOs : ', t2-t1

ENDPROGRAM quitar_DO

