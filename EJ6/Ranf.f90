! ======================================================================
! PROPOSITO: Genera numeros aleatorios uniformes en (0,1)
!            Adaptacion de: ran0 (NUMERICAL RECIPES)

! ARGUMENTOS DE ENTRADA/SALIDA:
!    INTEGER, INTENT(INOUT):: isem  <=> semilla (>0)

! VALOR DE LA FUNCION:
!    DOBLE:: ranf <=> numero aleatorio en (0,1)
! ======================================================================

DOUBLE PRECISION FUNCTION ranf (isem)
IMPLICIT NONE

! Argumentos de entrada/salida

INTEGER, INTENT(INOUT):: isem

! Variables locales

INTEGER, PARAMETER:: ia=16807, im=2147483647, iq=127773, ir=2836
DOUBLE PRECISION, PARAMETER:: am=1.d0/im
INTEGER k

! ----------------------------------------------------------------------
! Primera sentencia ejecutable

k = isem / iq
isem = ia*(isem-k*iq) - ir*k
IF (isem .LT. 0) isem = isem + im
ranf = am*isem

ENDFUNCTION ranf