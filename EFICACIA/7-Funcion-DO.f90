! ======================================================================
! Llamadas a funciones en bloques DO.
! ======================================================================

PROGRAM funciones_DO
IMPLICIT NONE

INTEGER, PARAMETER:: n=750
REAL a(n,n,n), b(n), c(n), fun, t1, t2
INTEGER i, j, k

CALL CPU_TIME (t1)
CALL RANDOM_NUMBER (b)
CALL RANDOM_NUMBER (c)
CALL CPU_TIME (t2)
PRINT '(/A,I10,A,F10.3)', 'n = ', n, ' Tiempo RANDOM_NUMBER : ', t2-t1

CALL CPU_TIME (t1)
DO k = 1, n
  DO j = 1, n
    DO i = 1, n
      a(i,j,k) = fun(b(i), c(j), k)
    ENDDO
  ENDDO
ENDDO
CALL CPU_TIME (t2)
PRINT '(/A,F10.3)', 'Tiempo llamada funcion : ', t2-t1
 
CALL CPU_TIME (t1)
DO k = 1, n
  DO j = 1, n
    DO i = 1, n
      a(i,j,k) = b(i)*k - c(j)
    ENDDO
  ENDDO
ENDDO
CALL CPU_TIME (t2)
PRINT '(/A,F10.3)', 'Tiempo sin llamar a funcion : ', t2-t1

ENDPROGRAM funciones_DO             

! ======================================================================

REAL FUNCTION fun (x,y,k)
REAL x, y
INTEGER k

  fun = x*k - y

ENDFUNCTION fun

