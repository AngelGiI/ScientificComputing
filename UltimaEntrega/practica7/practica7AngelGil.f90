! ===================================================================================
! PRACTICA 7: SISTEMAS DE ECUACIONES NO LINEALES - ANGEL A. GIL (Numero de orden: 44)

! PROPOSITO: Resolver un sistema de dos ecuaciones no lineales.

! PROBLEMA:  Resolver el siguiente sistema de ecuaciones no lineales:

!   (a1*x + a2*y + a3)*SQRT(1+x**2) + a4*(1+x**2) +
!                a3*y*(x+1) + 2*y**2 = 0

!   (b1*x + b2*y + b3)*SQRT(x**2+2*y**2) + b4*x**2 +
!                 b5*y**2 + b6*x*(2*y+1) + b7 = 0

!   donde los coeficientes ai, bj son:

!             a1=   -31.65295408930232
!             a2=    9.251045079200942
!             a3=   -8.730590899261227
!             a4=    33.20021804771679

!             b1=   -5.534958192726608
!             b2=    2.626656522701029
!             b3=    1.089778653368430
!             b4=    6.539398458019447
!             b5=    4.392125177389407
!             b6=   -2.292010699233766
!             b7=    1.313328261350515

!   Escribir la solucion (x,y) con 5 decimales.

! ELEMENTOS DEL PROBLEMA:

! ENTERAS:
!   n : numero de ecuaciones
!   i : para el bucle en el que llamo a HYBRD1 reiteradas veces (*)

! DOBLE PRECISION: 
!   tol    : tolerancia fijada para las soluciones
!   x(n)   : array, x(i) sera la coordenada i de la solucion del sistema
!   ecs(n) : array, ecs(i) contiene la ecuacion i

! SUBPROGRAMAS LLAMADOS:

!   HYBRD1  : resuelve las ecuaciones no lineales dadas
!   sistema : subrutina en la que creamos el sistema a resolver por HYBRD1

! VARIABLES AUXILIARES DEFINIDAS PARA ENTRADA EN LAS LIBRERIAS:

!   info    : entrada/salida de HYBRD1. Su valor tras llamar a HYBRD1 puede informar
!             de algun problema

! ===================================================================================

! (*) IMPORTANTE: ESTIMACION INICIAL DE (x,y), info = 4...
!                 ========================================

!    No he sido capaz de lograr que info me devuelva 1 en lugar de 4. He probado a
!    definir sistema como un calco de la indicada en HYBRD1 (real ( kind=kind(0d0) )
!    en lugar de DOUBLE PRECISION, etc.), asi como los argumentos del programa
!    principal.

!    Sin embargo, tras probar numerosos valores iniciales de (x,y), si que parecia
!    haber una convergencia bastante fiable hacia (2.8, 1.4), si redondeamos en los
!    decimales. Asi, he decidido ejecutar HYBRD1 con estos valores y valores cercanos
!    llegando a la conclusion de que muy probablemente, con 3 cifras de precision
!    (x,y) = (2.773, 1.418).

!    Por ultimo, he probado tambien con numerosos valores cercanos, escribiendo los
!    resultados con 10 cifras decimales, con secuencias como la que sigue:

!    (2.773, 1.418) => (2.7728774084, 1.4176356683) => (2.7728579463, 1.4176639191) 
!     => (2.7728579044, 1.4176639318) => (2.7728579044, 1.4176639318) => SE REPITE

!    El proceso que he seguido es: primero tomo  como valor inicial la que parece la
!    aproximacion con 3 cifras decimales (2.773, 1.418). A partir de ahi, tomo como
!    valor inicial el resultado obtenido en la ejecucion anterior hasta que devuelve
!    (con diez decimales) el mismo valor que el valor inicial dado.

!    Asi, he intentado que este proceso manual se vea 'recreado' creando un bucle que
!    llame a HYBRD1 unas cuantas veces, con valor inicial (2.8, 1.4), que devolvia:
!    (x,y) = (2.77298, 1.41748) != (2.77286, 1.41766), que es lo que devuelve con
!    valores iniciales (2.773,1.418).

!    Asi, concluyo que, probablemente, la aproximacion con 2 cifras decimales es
!    (x,y) = (2.77, 1.42), pero me ha resultado imposible alcanzar la precision
!    deseada.
! ===================================================================================

PROGRAM practica7_angel_gil
IMPLICIT NONE 

EXTERNAL sistema

INTEGER, PARAMETER :: n = 2
INTEGER info, i
DOUBLE PRECISION, PARAMETER :: tol = 10.d0**(-10)
DOUBLE PRECISION x(n), ecs(n)

! Abrimos el fichero de resultados y lo comenzamos a rellenar.   
OPEN (20, FILE='practica7.RESULT')
WRITE (20, '(3X,A/17X,A//17X,A,10X,A/A/17X,A,10X,A//)')                             &
    'PRACTICA   7: SISTEMAS DE ECUACIONES NO LINEALES',                             &
    '==================================', '=====','===========================',    &
    'Numero de orden: | 44|  Alumno: | GIL ALAMO ANGEL, AMANDO |', '=====',         &
    '==========================='

! Iniciamos x(n) como hemos decidido. Llamamos a la subrutina que estima las
! soluciones reiteradas veces, comprobamos que todo haya salido bien (aunque sabemos
! que info = 4), y finalmente, escribimos la solucion estimada 'a lo bruto' con
! 5 cifras decimales. VER: 'ESTIMACION INICIAL DE (x,y), info = 4...'

x = (/ 2.8, 1.4 /)

DO i = 1, 10 !Ejecutamos HYBRD1 varias veces con vector inicial el resultado anterior
  CALL hybrd1 ( sistema, n, x, ecs, tol, info )
ENDDO

! Escribimos segun el resultado de 'info'.
WRITE (20, '(3X,A,I1,A)',ADVANCE='NO') 'info = ', info, ', es decir '
IF (info == 1) THEN
  WRITE (20, '(A)') 'se ha alcanzado la tolerancia'
ELSEIF (info == 0) THEN
  WRITE (20, '(A)') 'error en los parametros de entrada.'
ELSEIF (info == 2) THEN
  WRITE (20, '(A)') 'limite de iteraciones alcanzado, no se llega a la tolerancia'
ELSEIF (info == 3) THEN
  WRITE (20, '(A)') 'tolerancia demasiado pequeña, no se puede aproximar mas.'
ELSE
  WRITE (20, '(A)') 'la iteracion no esta haciendo buen progreso (*).'
ENDIF

! Finalmente, escribimos la solucion con 5 cifras decimales.
WRITE (20, '(/7X,A,F7.5,A,F7.5,A)') '(x,y) = (', x(1), ', ', x(2), ')'

ENDPROGRAM practica7_angel_gil

! ===================================================================================
! SUBROUTINE sistema

! PROPOSITO: plantear un sistema de ecuaciones (no lineales) a ser resuelto

! ARGUMENTOS:
!    INTEGER : n     <=> numero de ecuaciones del sistema
!              iflag <=> definido pero inalterado, es utilizado por HYBRD1, HYBRD 
!    DOUBLE PRECISION : x   <=> array, x(i) sera la coordenada i de la solucion del
!                               sistema
!						ecs <=> array, ecs(i) contiene la ecuacion i

! ===================================================================================
! IMPORTANTE: SOBRE LOS COEFICIENTES DEL SISTEMA
!             ==================================

! Sistema es llamada por HYBRD (a su vez llamada por HYBRD1), no podemos alterar los
! argumentos de entrada (porque eso conllevaria alterar HYBRD/HYBRD1), por lo que he
! decidido escribir los coeficientes explicitamente en lugar de leerlos.

! ===================================================================================
SUBROUTINE sistema (n, x, ecs, iflag)

IMPLICIT NONE
INTEGER n, iflag
DOUBLE PRECISION x(n), ecs(n)

! Para no alterar la subrutina a la que llama HYBRD (llamada por HYBRD1), escribimos
! los coeficientes aqui directamente.
DOUBLE PRECISION, PARAMETER :: a1=   -31.65295408930232, a2=    9.251045079200942, &
  a3=   -8.730590899261227, a4=    33.20021804771679, b1=   -5.534958192726608,    &
  b2=    2.626656522701029, b3=    1.089778653368430, b4=    6.539398458019447,    &
  b5=    4.392125177389407, b6=   -2.292010699233766, b7=    1.313328261350515

! Escribimos las dos ecuaciones no lineales a resolver.
ecs(1) = (a1*x(1) + a2*x(2) + a3) * SQRT(1 + x(1)**2) + a4*(1 + x(1)**2) +         &
         a3*x(2)*(x(1) + 1) + 2*x(2)**2
		 
ecs(2) = (b1*x(1) + b2*x(2) + b3) * SQRT(x(1)**2 + 2*x(2)**2) + b4*x(1)**2 +       &
         b5*x(2)**2 + b6*x(1)*(2*x(2) + 1) + b7

RETURN

ENDSUBROUTINE sistema