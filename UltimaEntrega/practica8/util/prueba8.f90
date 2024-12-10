! ==================================================================================
! PRACTICA 8: PROBLEMA NO LINEAL ENTERO - ANGEL A. GIL (Numero de orden: 44)

! PROPOSITO: Adaptar el algoritmo de enumeracion explicita para resolver un problema
!            de programacion no lineal entera con variables acotadas mostrando solo
!            la solucion optima para los casos de minimizacion y maximizacion.

! PROBLEMA: maximizar y minimizar  z = SUMA ( sen(aj*xj) / (1+exp(aj*xj)), j=1:n )

!                            sujeto a:
!                                      SUMA ( aj*xj, j=1:n ) <= b1                                           
 
!                                      SUMA ( xj**2, j=1:n ) <= b2                                           
  
!                                      SUMA ( xj**3, j=1:n ) <= b3                                           

!                                      rj <= xj <= sj; xj entera  para j=1:n

! ELEMENTOS DEL PROBLEMA:

! CONSTANTES:
!   n : numero de variables
!   m : numero de restricciones

! ENTERAS:
!   a, b : coeficientes de las restricciones
!   r, s : cotas inferiores y superiores
!   sol : solucion optima de X con valor z

! DOBLE PRECISION: 
!   c : coeficientes de la funcion objetivo
!   z : valor de la solucion optima (funcion objetivo optimizada)

! VARIABLES AUXILIARES:

!   iz      : subindice que toma los valores -1 para maximizar y 1 para minimizar
!   i, j, k : resto de subindices utilizados en bucles
!   nfac    : numero de soluciones factibles
!   total   : numero de soluciones que satisfacen las cotas

! SUBPROGRAMAS LLAMADOS:

!   todas : algoritmo de enumeracion explicita

! ======================================================================
PROGRAM practica8_angel_gil
IMPLICIT NONE

INTEGER, PARAMETER:: n=8, m=3
INTEGER i, iz, a(n), b(m), r(n), s(n), sol(n), nfac
DOUBLE PRECISION z, total

EXTERNAL todas              ! esta sentencia se puede suprimir
! ----------------------------------------------------------------------
! Abrimos el fichero de datos y el de resultados.   

OPEN (21, FILE='Practica8javi.DAT')
OPEN (22, FILE='Prueba8.RESULT')

!Leemos los datos y los asignamos a sus respectivas variables.

READ (21, '(23X)',ADVANCE='NO')
READ (21, '(8I3)') a(1:8)

READ (21, '(/,23X)',ADVANCE='NO')
READ (21, '(3I5)') b(1:3)

READ (21, '(/,23X)',ADVANCE='NO')
READ (21, '(8I3)') r(1:8)

READ (21, '(/,23X)',ADVANCE='NO')
READ (21, '(8I3)') s(1:8)

! El problema ya esta definido

! Si hay muchas soluciones que cumplen las cotas el tiempo de calculo
! puede ser grande. El mayor numero entero valido es 2**31-1=2147483647

total = PRODUCT(s(1:n)-r(1:n)+1.d0)

WRITE (22,'(/5X,A,G23.15,A,/5X,A)',ADVANCE='NO') 'Hay ', total,          &
         ' soluciones que cumplen las cotas'



!  Solucion del problema

DO iz = -1, 1, 2
  CALL todas (iz, n, m, a, b, r, s, z, nfac, sol)

  IF (nfac == 0) THEN       ! problema infactible

    WRITE (22,'(//3X,A,G16.9/3X,A)')                                       &
             'numero de soluciones entre las cotas = ', total,            &
             'El problema NO tiene solucion factible'

  ELSE                          ! solucion optima encontrada

    WRITE (22,'(//5X,A,G16.9,//5X,A,I10//5X,A,G16.9//5X,A,(T23,10I4))')             &
             'numero de soluciones entre las cotas = ', total,            &
             'numero de soluciones factibles = ', nfac,                   &
             'valor optimo = ', z,                                        &
             'solucion optima = ', sol(1:n)

  ENDIF
ENDDO

ENDPROGRAM practica8_angel_gil


! ======================================================================
! SUBROUTINE todas

! PROPOSITO: Enumera todas las soluciones enteras que satisfacen las
!            cotas, comprueba si ademas cumplen las otras restricciones
!            y encuentra una solucion optima, si existe

! ARGUMENTOS DE ENTRADA:
!    INTEGER:: iz                     <=> opcion de minimizar/maximizar
!    INTEGER:: n, m                   <=> dimensiones del problema
!    INTEGER:: a(*), b(*), r(*), s(*) <=> problema

! ARGUMENTOS DE SALIDA:
!    DOUBLE PRECISION:: z   <=> valor optimo del problema (si nfac>0)
!    INTEGER:: nfac         <=> numero de soluciones factibles
!    INTEGER:: sol(*)       <=> solucion optima

! VARIABLES LOCALES A DESTACAR:
!    INTEGER:: infto           <=> numero "enorme", valor inicial de la
!								   funcion objetivo.
!    DOUBLE PRECISION:: suma   <=> valor de "sum(c(j)*x(j))".
! ======================================================================

SUBROUTINE todas (iz, n, m, a, b, r, s, z, nfac, sol)
IMPLICIT NONE

! Subprogramas llamados

EXTERNAL siguiente

! Argumentos de entrada

INTEGER, INTENT(IN):: iz, n, m
INTEGER, INTENT(IN):: a(*), b(*), r(*), s(*)
INTEGER, INTENT(OUT):: nfac
DOUBLE PRECISION, INTENT(OUT) :: z
INTEGER, INTENT(OUT):: sol(*)

! Variables locales

INTEGER i, infto
LOGICAL fin
INTEGER x(n)
DOUBLE PRECISION suma

! ----------------------------
! Primera sentencia ejecutable

nfac = 0
infto = HUGE(1)
z = iz*infto
x(1:n) = r(1:n)     ! primera solucion a probar

DO   ! analisis de las soluciones

! Comprobar si x es factible

  DO i = 1, m
    IF (i == 1) THEN
      suma = DOT_PRODUCT(a(1:n),x(1:n))
	ELSE
	  suma = SUM(x**i)
	ENDIF
    IF (suma>b(i)) GOTO 10    ! NO factible
  ENDDO

! La solucion x es factible. Se evalua la funcion objetivo

  nfac = nfac + 1       ! nueva solucion factible
  suma = SUM(SIN(DBLE(a(1:n))*DBLE(x))/(1.d0+EXP(DBLE(a(1:n))*DBLE(x))))

! Comprobar si x es la mejor solucion hasta el momento. Si lo es, se
! actualiza z, x se guarda en sol.

  IF (iz*suma < iz*z) THEN
    z = suma
    sol(1:n) = x(1:n)
  ENDIF

!  Siguiente vector a x en la seudobase [r,s]

  10  CONTINUE
  CALL siguiente (n, r, s, x, fin)
  IF (fin) RETURN  ! Se han examinado todas las soluciones entre r y s
ENDDO

ENDSUBROUTINE todas

! ======================================================================
! SUBROUTINE siguiente

! PROPOSITO: Encuentra el siguiente vector entero en una seudobase

! ARGUMENTOS DE ENTRADA:
!    INTEGER:: n <=> dimension del problema
!    INTEGER:: menor(n), mayor(n) <=> cotas de las variables

! ARGUMENTOS DE SALIDA:
!    LOGICAL:: fin = .TRUE. si en entrada x(j) = mayor(j) para todo j
!              fin = .FALSE. en otro caso

! ARGUMENTOS DE ENTRADA/SALIDA
!    INTEGER:: x(n)
!              En entrada:  menor(j) <= x(j) <= mayor(j)
!              En salida:   el siguiente vector al de entrada.
!                           Si en entrada es x(j) = mayor(j) para todo j
!                             en salida sera x(j) = menor(j) para todo j
! ======================================================================

SUBROUTINE siguiente (n, menor, mayor, x, fin)
IMPLICIT NONE

! Argumentos

INTEGER, INTENT(IN):: n
INTEGER, INTENT(IN):: menor(*), mayor(*)
LOGICAL, INTENT(OUT):: fin
INTEGER, INTENT(INOUT):: x(*)

! Variables locales

INTEGER j

! ----------------------------
! Primera sentencia ejecutable

fin = .TRUE.

DO j = n, 1, -1
  IF (x(j) == mayor(j)) THEN
    x(j) = menor(j)
  ELSE
    x(j) = x(j) + 1 ; fin = .false.
    EXIT          ! ya esta construido el vector siguiente a x
  ENDIF
ENDDO

ENDSUBROUTINE siguiente
