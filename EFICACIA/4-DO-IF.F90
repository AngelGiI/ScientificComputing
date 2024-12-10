! ======================================================================
! Quitar IF dentro de DO
! ======================================================================

PROGRAM quitar_IF
IMPLICIT NONE

INTEGER, PARAMETER:: n=50000000
REAL a(n), b(n), c(n), t1, t2
INTEGER i, condicion

PRINT*, 'condicion (0: terminar)' ; READ*, condicion
IF (condicion == 0) STOP 'O.K'

CALL CPU_TIME (t1)
CALL RANDOM_NUMBER (b)
CALL RANDOM_NUMBER (c)
CALL CPU_TIME (t2)
PRINT '(/A,I10,A,F10.3)', 'n = ', n, ' Tiempo RANDOM_NUMBER : ', t2-t1

CALL CPU_TIME (t1)
DO i = 1, n
  IF (condicion > 0) THEN
    a(i) = b(i) + c(i)
  ELSE
    a(i) = b(i) - c(i)
  ENDIF
ENDDO
PRINT*, a(n)
CALL CPU_TIME (t2)
PRINT '(A,F10.3)', 'Tiempo IF dentro de DO : ', t2-t1
 
CALL CPU_TIME (t1)
IF (condicion > 0) THEN
  DO i = 1, n
    a(i) = b(i) + c(i)
  ENDDO
ELSE
  DO i = 1, n
    a(i) = b(i) - c(i)
  ENDDO
ENDIF
PRINT*, a(n)
CALL CPU_TIME (t2)
PRINT '(A,F10.3)', 'Tiempo IF fuera de DO  : ', t2-t1

ENDPROGRAM quitar_IF

