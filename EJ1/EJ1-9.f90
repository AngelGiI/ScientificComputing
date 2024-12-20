MODULE numeroecu
  INTEGER iecu
ENDMODULE numeroecu

! ======================================================================
! PROPOSITO: Resolver la ecuacion f(x)=0 por el metodo de la biseccion

! SUBPROGRAMAS LLAMADOS:
!    DOUBLE PRECISION, EXTERNAL:: f <=> ecuacion a resolver f(x)=0

!    La funcion f(x) debe codificarse como sigue:

!           FUNCTION f(x)
!           DOUBLE PRECISION f, x
!             ...
!           f =
!           END

!    y declararse EXTERNAL en la unidad de programa de llamada.

! ARGUMENTOS DE ENTRADA:
!    DOUBLE PRECISION:: a, b <=> extremos del intervalo
!    DOUBLE PRECISION:: tolx, tolf <=> tolerancias en x, f

! ARGUMENTOS DE SALIDA:
!    DOUBLE PRECISION:: x <=> valor estimado de la raiz
!    DOUBLE PRECISION:: fx <=> f(x)
!    INTEGER:: indice <=> situacion alcanzada
!              indice=0 : f(a) y f(b) tienen el mismo signo
!              indice=1 : se han alcanzado ambas tolerancias
!              indice=2 : solo se ha alcanzado la tolerancia en x
!              indice=3 : solo se ha alcanzado la tolerancia en f
!              indice=4 : no se ha alcanzado la tolerancia en x ni en f

! ARGUMENTOS DE ENTRADA/SALIDA:
!    INTEGER:: niter
!              En entrada: maximo numero de divisiones del intervalo
!              En salida : numero de evaluaciones de f realizadas
! ======================================================================

SUBROUTINE bisec (f, a, b, tolx, tolf, niter, x, fx, indice)
IMPLICIT NONE

! Subprogramas llamados

DOUBLE PRECISION, EXTERNAL:: f

! Argumentos

DOUBLE PRECISION, INTENT(IN):: a, b, tolx, tolf
DOUBLE PRECISION, INTENT(OUT):: x, fx
INTEGER, INTENT(OUT):: indice
INTEGER, INTENT(INOUT):: niter

! Variables locales

INTEGER n
DOUBLE PRECISION x1, x2, f1, f2

! ----------------------------
! Primera sentencia ejecutable

x1 = MIN(a,b) ; f1 = f(x1)
x2 = MAX(a,b) ; f2 = f(x2)
niter = MAX(1,MIN(ABS(niter),50))

indice = 0
IF (f1*f2 > 0) THEN     ! f(a) y f(b) tienen el mismo signo
  niter = 2
  RETURN
ENDIF

! Se realizaran a lo sumo niter iteraciones

DO n = 1, niter
  x = 0.5d0*(x1+x2) ; fx = f(x)
  IF (f1*fx > 0) THEN
    x1 = x ; f1 = fx
  ELSE
    x2 = x ; f2 = fx
  ENDIF
  IF (x2-x1<tolx .AND. ABS(fx)<tolf) THEN
    niter = 2 + n
    indice = 1   ! se han alcanzado ambas tolerancias
    EXIT
  ENDIF
ENDDO

IF (indice == 0) THEN  ! No se han alcanzado las dos tolerancias
  niter = 2 + niter
  IF (x2-x1 < tolx) THEN
    indice = 2   ! solo se ha alcanzado la tolerancia en x
  ELSEIF (MIN(ABS(f1),ABS(f2)) < tolf) THEN
    indice = 3   ! solo se ha alcanzado la tolerancia en f
  ELSE
    indice = 4   ! no se ha alcanzado la tolerancia en x ni en f
  ENDIF
ENDIF

! Mejor punto obtenido

IF (ABS(f1) <= ABS(f2)) THEN
  x = x1 ; fx = f1
ELSE
  x = x2 ; fx = f2
ENDIF

ENDSUBROUTINE bisec

! ======================================================================
! Ecuacion a resolver fun(x)=0

FUNCTION fun(x)
USE numeroecu
DOUBLE PRECISION fun, x

SELECT CASE (iecu)
CASE (1)
  fun = 1 + x*(-6+x*(15+x*(-24+x*(15+x*(-6+x)))))
CASE (2)
  fun = x**4 + 2*x**3 - 36*x**2 - 2*x - 1
ENDSELECT

ENDFUNCTION fun

! ======================================================================
! Programa principal

PROGRAM ecuacion
USE numeroecu
IMPLICIT NONE

INTEGER indice, niter
CHARACTER(LEN=50) caso(0:4)
DOUBLE PRECISION a, b, tolx, tolf, x, fx
DOUBLE PRECISION, EXTERNAL:: fun

! Descripcion de la convergencia alcanzada

caso(0) = 'f(a) y f(b) tienen el mismo signo'
caso(1) = 'se ha alcanzado la precision deseada'
caso(2) = 'solo se ha alcanzado la precision en x'
caso(3) = 'solo se ha alcanzado la precision en f'
caso(4) = 'no se ha alcanzado la precision en x ni en f'

! Lectura del intervalo, tolerancias e iteraciones

DO iecu = 1, 2

  WRITE (*,'(/A,I2)') 'Ecuacion ', iecu
  WRITE (*,'(A)',ADVANCE='NO') ' Extremo a = ' ; READ*, a
  WRITE (*,'(A)',ADVANCE='NO') ' Extremo b = ' ; READ*, b
  WRITE (*,'(A)',ADVANCE='NO') ' Tolerancia para x = ' ; READ*, tolx
  WRITE (*,'(A)',ADVANCE='NO') ' Tolerancia para f = ' ; READ*, tolf
  WRITE (*,'(A)',ADVANCE='NO') ' Iteraciones = ' ; READ*, niter

  CALL bisec (fun, a, b, tolx, tolf, niter, x, fx, indice)

  IF (indice == 0) THEN
    WRITE (*,'(3X,A)') caso(0)
  ELSE
    WRITE (*,'(3X,A,G25.15/3X,A,G25.15/3X,A/3X,A,I2)') 'x = ', x,        &
             'f = ', fx, caso(indice), 'Evaluaciones de f = ', niter
  ENDIF

ENDDO

ENDPROGRAM ecuacion