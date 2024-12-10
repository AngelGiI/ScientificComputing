! ======================================================================
! ALGORITMO DE ENUMERACION EXPLICITA

! PROPOSITO: Resuelve un problema de programacion lineal entera con
!            variables acotadas enumerando todas las soluciones

! PROBLEMA: opt  z = SUMA (c(j) * x(j), j=1..n)

!           sujeto a:
!                    SUMA (a(i,j)*x(j), j=1..n)  (<= | = | >=)  b(i)
!                                                  para i=1..m

!                    v(j) <= x(j) <= u(j);  x(j) entera;  para j=1..n

! ELEMENTOS DEL PROBLEMA:

!   ma : maximo valor permitido para m
!   na : maximo valor permitido para n
!   a, b, c, u, v, n, m : definicion del problema
!   ibt(i) : TIPO DE RESTRICCION i=1..m
!            0 : .EQ.
!            1 : .LE.
!            2 : .GE.
!   sol : solucion optima con valor z

! VARIABLES AUXILIARES:

!   i, j, k : subindices
!   nfac    : numero de soluciones factibles
!   total   : numero de soluciones que satisfacen las cotas
!   fdatos  : nombre del fichero de datos
!   fresul  : nombre del fichero de resultados
!   isem0   : semilla inicial del generador de numeros aleatorios
!   isem    : semilla iterativa del generador de numeros aleatorios
!   cont    : usada para decidir si se desea resolver el problema

! OPCIONES DEL PROGRAMA:

!   id : TIPO DE DATOS
!        0 : se leen de un fichero asociado al numero de unidad ndat
!        1 : se generan aleatoriamente (con restricciones .LE.)

!   ir : SALIDA DE RESULTADOS
!        1 : mostrar los resultados en pantalla
!        2 : guardar los resultados en un fichero

!   is : ESCRITURA DE LAS SOLUCIONES
!        0 : no escribir las soluciones intermedias
!        1 : escribir todas las soluciones factibles
!        2 : escribir cada mejor solucion encontrada

!   iz : FUNCION OBJETIVO
!        1 : minimizar
!       -1 : maximizar

! SUBPROGRAMAS LLAMADOS:

!   iranf : generador de numeros enteros uniformes
!   todas : algoritmo de enumeracion explicita

! ======================================================================
PROGRAM enumerar
IMPLICIT NONE    ! obliga a declarar todas las variables

INTEGER, PARAMETER:: ndat=11, ma=20, na=10
INTEGER a(ma,na), b(ma), ibt(ma), c(na), u(na), v(na), sol(na)
INTEGER n, m, id ,ir, is, iz, z, nfac, i, j, k, isem0, isem
DOUBLE PRECISION total
CHARACTER (LEN=15) fdatos, fresul
CHARACTER (LEN=1) cont

EXTERNAL todas              ! esta sentencia se puede suprimir
INTEGER, EXTERNAL:: iranf

! ----------------------------------------------------------------------
! Primera sentencia ejecutable

WRITE (*,'(/2X,A/5X,A/5X,A/10X,A)',ADVANCE='NO') 'TIPO DE DATOS',       &
         '0: se leen de un fichero', '1: se generan aleatoriamente',    &
         'opcion = '
READ*, id

IF (id == 0) THEN            ! lectura de datos de un fichero

  WRITE (*,'(/5X,A)',ADVANCE='NO') 'Nombre del fichero de datos = '
  READ (*,'(A)') fdatos ; OPEN (ndat, FILE=fdatos, STATUS='OLD')

  READ (ndat, *) n, m, iz
  DO i = 1, m
    READ (ndat,'(20I4)') a(i,1:n), b(i), ibt(i)
  ENDDO
  READ (ndat,'(20I4)') c(1:n)
  READ (ndat,'(20I4)') v(1:n)
  READ (ndat,'(20I4)') u(1:n)

ELSE                         ! generacion de datos aleatorios

  WRITE (*,'(/5X,A,I2,A)',ADVANCE='NO') 'n (<=', na, ') = '
  READ*, n ; IF (n > na) STOP ' el valor (n) NO es valido'

  WRITE (*,'(/5X,A,I2,A)',ADVANCE='NO') 'm (<=', ma, ') = '
  READ*, m ; IF (m > ma) STOP ' el valor (m) NO es valido'

  WRITE (*,'(/5X,A)',ADVANCE='NO') 'iz (1:min, -1:max) = '
  READ*, iz ; IF (ABS(iz) /= 1) STOP ' el valor (iz) NO es valido'

  WRITE (*,'(/5X,A)',ADVANCE='NO') 'semilla (INTEGER) = '
  READ*, isem0 ; isem = isem0

  k = m + n
  DO i = 1, m
    ibt(i) = 1
    b(i) = iranf(isem, 0, k)                !  b(i) ~ UI(0,k)
    DO j = 1, n
      a(i,j) = iranf(isem, -k, k)           !  a(i,j) ~ UI(-k,k)
    ENDDO
  ENDDO
  DO j = 1, n
    c(j) = iranf(isem, -k, k)               !  c(j) ~ UI(-k,k)
    v(j) = 0
    u(j) = iranf(isem, 1, n/2)              !  u(j) ~ UI(1,n/2)
  ENDDO

ENDIF  !  El problema ya esta definido

!  Si hay muchas soluciones que cumplen las cotas el tiempo de calculo
!  puede ser grande. El mayor numero entero valido es 2**31-1=2147483647

total = PRODUCT(u(1:n)-v(1:n)+1.d0)

WRITE (*,'(/5X,A,G23.15,A,/5X,A)',ADVANCE='NO') 'Hay ', total,          &
         ' soluciones que cumplen las cotas', 'continuar (S/N) ? '
READ (*,'(A)') cont
IF (cont/='s' .AND. cont/='S') STOP ' PROBLEMA NO RESUELTO'

!  Escritura de soluciones

WRITE (*,'(/2X,A,3(/5X,A)/10X,A)',ADVANCE='NO')                         &
         'ESCRITURA DE SOLUCIONES', '0: ninguna', '1: las factibles',   &
         '2: solo las mejores', 'opcion = '
READ*, is

! Salida de resultados

WRITE (*,'(/2X,A,2(/5X,A)/10X,A)',ADVANCE='NO') 'RESULTADOS',           &
         '1: pantalla', '2: fichero', 'opcion = '
READ*, ir

IF (ir == 2) THEN    ! resultados en un fichero
  WRITE (*,'(/5X,A)',ADVANCE='NO') 'nombre del fichero de salida = '
  READ (*,'(A)') fresul ; OPEN (6, FILE=fresul)
ENDIF

! TRUCO: El numero de unidad 6 esta inicialmente asignado a la pantalla.
!        Despues de una sentencia OPEN (6...) toda la escritura con
!        PRINT o WRITE (*...) se envia al fichero asociado a la unidad 6

IF (id == 1) THEN          ! escritura del problema
  WRITE (6,'(5X,A,I10//3(5X,A,I2))') 'isem0 = ', isem0, 'n = ', n,      &
            'm = ', m, 'iz = ', iz
  WRITE (6,'(/5X,A,(T30,10I5))') 'funcion objetivo : ', c(1:n)
  WRITE (6,*)
  DO i = 1, m
    WRITE (6,'(5X,A,I2,A,I5,A,I2,A,(T30,10I5))') 'b(', i, ') =', b(i),  &
             ' ; a(', i, ',.) =', a(i,1:n)
  ENDDO
  WRITE (6,'(/5X,A,(T30,10I5))') 'cotas superiores : ', u(1:n)
  WRITE (6,*)
ENDIF

!  Solucion del problema

CALL todas (is, iz, n, m, ma, a, b, ibt, c, v, u, z, nfac, sol)

IF (nfac == 0) THEN       ! problema infactible

  WRITE (6,'(//3X,A,G16.9/3X,A)')                                       &
           'numero de soluciones entre las cotas = ', total,            &
           'El problema NO tiene solucion factible'

ELSE                          ! solucion optima encontrada

  WRITE (6,'(//5X,A,G16.9,2(//5X,A,I10)//5X,A,(T23,10I4))')             &
           'numero de soluciones entre las cotas = ', total,            &
           'numero de soluciones factibles = ', nfac,                   &
           'valor optimo = ', z,                                        &
           'solucion optima = ', sol(1:n)

ENDIF

STOP ' O.K.'
ENDPROGRAM enumerar

! ======================================================================
! SUBROUTINE todas

! PROPOSITO: Enumera todas las soluciones enteras que satisfacen las
!            cotas, comprueba si ademas cumplen las otras restricciones
!            y encuentra una solucion optima, si existe

! ARGUMENTOS DE ENTRADA:
!    INTEGER:: is   <=> opcion de escritura de soluciones
!    INTEGER:: iz   <=> opcion de minimizar/maximizar
!    INTEGER:: n, m <=> dimensiones del problema
!    INTEGER:: ma   <=> dimension de filas de la matriz a
!    INTEGER:: a(ma,*), b(*), ibt(*), c(*), v(*), u(*) <=> problema

! ARGUMENTOS DE SALIDA:
!    INTEGER:: z      <=> valor optimo del problema (si nfac>0)
!    INTEGER:: nfac   <=> numero de soluciones factibles
!    INTEGER:: sol(*) <=> solucion optima
! ======================================================================

SUBROUTINE todas (is, iz, n, m, ma, a, b, ibt, c, v, u, z, nfac, sol)
IMPLICIT NONE

! Subprogramas llamados

EXTERNAL siguiente

! Argumentos de entrada

INTEGER, INTENT(IN):: is, iz, n, m, ma
INTEGER, INTENT(IN):: a(ma,*), b(*), ibt(*), c(*), v(*), u(*)
INTEGER, INTENT(OUT):: z, nfac
INTEGER, INTENT(OUT):: sol(*)

! Variables locales

INTEGER i, infto, suma
LOGICAL mejor, fin
INTEGER x(n)

! ----------------------------
! Primera sentencia ejecutable

nfac = 0
infto = HUGE(1)
z = iz*infto
x(1:n) = v(1:n)     ! primera solucion a probar

DO   ! analisis de las soluciones

  mejor = .false.

! Comprobar si x es factible

  DO i = 1, m
    suma = DOT_PRODUCT(a(i,1:n),x(1:n))
    IF (ibt(i)==0 .AND. suma/=b(i)) GOTO 10   ! NO factible
    IF (ibt(i)==1 .AND. suma>b(i)) GOTO 10    ! NO factible
    IF (ibt(i)==2 .AND. suma<b(i)) GOTO 10    ! NO factible
  ENDDO

! La solucion x es factible. Se evalua la funcion objetivo

  nfac = nfac + 1       ! nueva solucion factible
  suma = DOT_PRODUCT(c(1:n),x(1:n))

! Comprobar si x es la mejor solucion hasta el momento. Si lo es, se
! actualiza z, x se guarda en sol y se escribe segun la opcion is.

  IF (iz*suma < iz*z) THEN
    mejor = .true.      ! mejor solucion factible hasta el momento
    z = suma
    sol(1:n) = x(1:n)
    IF (is >= 1) WRITE (6,'(/5X,A)') '*** MEJOR SOLUCION'
  ENDIF

  IF (is==1 .OR. is==2.AND.mejor) WRITE (6,'(5X,A,I9,3X,A,(T30,10I4))') &
                                  'z = ', suma, 'x = ', x(1:n)
  IF (mejor) WRITE (6,*)

!  Siguiente vector a x en la seudobase [v,u]

  10  CONTINUE
  CALL siguiente (n, v, u, x, fin)
  IF (fin) RETURN  ! Se han examinado todas las soluciones entre v y u
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