! ======================================================================
! Algunas estrategias de calculo de n!
! ======================================================================

PROGRAM factorial
IMPLICIT NONE

INTEGER, EXTERNAL:: factn, factr, iranf
DOUBLE PRECISION t0, t1, t
INTEGER numsim, i, j, nfac, n, isem0, isem
INTEGER, PARAMETER:: nsal=11
CHARACTER(LEN=30) fsal

! ----------------------------
! Primera sentencia ejecutable

WRITE (*,'(A)',ADVANCE='NO') 'Semilla inicial = ' ; READ (*,*) isem0
WRITE (*,'(A)',ADVANCE='NO') 'numsim = ' ; READ (*,*) numsim
WRITE (*,'(A)',ADVANCE='NO') 'fichero de salida = '
READ (*,'(A)') fsal ; OPEN (nsal, FILE=fsal)
WRITE (nsal,'(A,T30,I10)') 'numero de iteraciones = ', numsim

! Tiempo de simulacion

isem = isem0
CALL CPU_TIME (t0)
DO i = 1, numsim ; n = iranf(isem, 5, 12) ; ENDDO
CALL CPU_TIME (t1)
t = t1 - t0
WRITE (nsal,'(A,T30,F10.3)') 'tiempo de simulacion = ', t

! Calculo directo

isem = isem0
CALL CPU_TIME (t0)
DO i = 1, numsim
  n = iranf(isem, 5, 12)
  nfac = 1
  DO j = 2, n ; nfac = nfac*j ; ENDDO
ENDDO
CALL CPU_TIME (t1)
WRITE (nsal,'(A,T30,F10.3)') 'tiempo directo = ', t1-t0-t

! Funcion externa no recursiva factn

isem = isem0
CALL CPU_TIME (t0)
DO i = 1, numsim
  n = iranf(isem, 5, 12)
  nfac = factn(n)
ENDDO
CALL CPU_TIME (t1)
WRITE (nsal,'(A,T30,F10.3)') 'tiempo no recursiva = ', t1-t0-t

! Funcion externa recursiva factr

isem = isem0
CALL CPU_TIME (t0)
DO i = 1, numsim
  n = iranf(isem, 5,12)
  nfac = factr(n)
ENDDO
CALL CPU_TIME (t1)
WRITE (nsal,'(A,T30,F10.3)') 'tiempo recursiva = ', t1-t0-t

ENDPROGRAM factorial

! ======================================================================
! Funcion no recursiva = 1*...*n

INTEGER FUNCTION factn (n)
INTEGER n, j
  factn = 1
  DO j = 2, n ; factn = factn * j ; ENDDO
ENDFUNCTION factn

! ======================================================================
! Funcion recursiva: factr(n) = n*factr(n-1)

RECURSIVE FUNCTION factr(n) RESULT(factorial)
INTEGER n, factorial
  IF (n <= 1) THEN
    factorial = 1
  ELSE
    factorial = n * factr(n-1)
  ENDIF
ENDFUNCTION factr

! ======================================================================
! FUNCTION ranf

! PROPOSITO: Genera numeros aleatorios uniformes en (0,1)
!            Adaptacion de: ran0 (NUMERICAL RECIPES)

! ARGUMENTOS DE ENTRADA/SALIDA:
!    INTEGER, INTENT(INOUT):: isem  <=> semilla (>0)

! VALOR DE LA FUNCION:
!    DOBLE:: ranf <=> numero aleatorio en (0,1)
! ======================================================================

DOUBLE PRECISION FUNCTION ranf (isem)
IMPLICIT NONE

! Argumentos

INTEGER, INTENT(INOUT):: isem

! Variables locales

INTEGER, PARAMETER:: ia=16807, im=2147483647, iq=127773, ir=2836
DOUBLE PRECISION, PARAMETER:: am=1.d0/im
INTEGER k

! ----------------------------
! Primera sentencia ejecutable

k = isem / iq
isem = ia*(isem-k*iq) - ir*k
IF (isem < 0) isem = isem + im
ranf = am*isem

ENDFUNCTION ranf

! ======================================================================
! FUNCTION iranf

! PROPOSITO: Genera numeros aleatorios uniformes enteros en (a, b)

! ARGUMENTOS DE ENTRADA:
!    INTEGER, INTENT(IN):: a  <=> extremo inferior
!    INTEGER, INTENT(IN):: b  <=> extremo superior

! ARGUMENTOS DE ENTRADA/SALIDA:
!    INTEGER:: isem  <=> semilla (>0)

! VALOR DE LA FUNCION:
!    INTEGER:: iranf <=> numero entero aleatorio en [a, b]
! ======================================================================

INTEGER FUNCTION iranf (isem, a, b)
IMPLICIT NONE

! Subprogramas llamados

DOUBLE PRECISION, EXTERNAL:: ranf

! Argumentos

INTEGER, INTENT(IN):: a, b
INTEGER, INTENT(INOUT):: isem

! ----------------------------
! Primera sentencia ejecutable

iranf = FLOOR(a + ranf(isem)*(b-a+1))

ENDFUNCTION iranf

