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

! !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

! ANTES DE COMENZAR, MODIFICACIONES A TENER EN CUENTA:

!   He decidido eliminar las variables referentes a la eleccion de casos: id, ir, is
!   ya que en esta practica  leeremos y escribiremos en ficheros solo la solucion 
!   optima de cada caso (entendemos por casos: 1.minimizar, 2.maximizar).

!   He borrado las funciones "ranf", "iranf", ya que tendremos datos concretos, no 
!   los generaremos aleatoriamente. De igual manera, he borrado las variables 
!   auxiliares asociadas "isem0" e "isem".

!   Siguiendo lo mencionado en los dos parrafos anteriores, se han suprimido las 
!   variables "ma", "na", ya que no hay duda del numero de restricciones/variables,
!   asi como "fdatos", "fresult". Tambien "ibt", ya que diferencia en casos segun el
!   signo de las restricciones y las nuestras son todas "<=".

! !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

! ELEMENTOS DEL PROBLEMA:

! CONSTANTES:
!   n : numero de variables
!   m : numero de restricciones

! ENTERAS:
!   a, b : coeficientes de las restricciones
!   r, s : cotas inferiores y superiores
!   sol  : solucion optima de X con valor z

! DOBLE PRECISION: 
!   c : coeficientes de la funcion objetivo
!   z : valor de la solucion optima (funcion objetivo optimizada)

! VARIABLES AUXILIARES:

!   iz      : toma los valores -1 para maximizar y 1 para minimizar
!   i       : indice utilizado en bucles
!   nfac    : numero de soluciones factibles
!   total   : numero de soluciones que satisfacen las cotas

! SUBPROGRAMAS LLAMADOS:

!   todas : algoritmo de enumeracion explicita

! ==================================================================================

PROGRAM practica8_angel_gil
IMPLICIT NONE

INTEGER, PARAMETER:: n=8, m=3
INTEGER i, iz, a(n), b(m), r(n), s(n), sol(n), nfac
DOUBLE PRECISION z, total

EXTERNAL todas_adaptada   ! esta sentencia se puede suprimir
! ----------------------------------------------------------------------------------
! Abrimos el fichero de datos y el de resultados.   

OPEN (21, FILE='Practica8.DAT')
OPEN (22, FILE='Practica8.RESULT')

! Leemos los datos y los asignamos a sus respectivas variables.

READ (21, '(23X)',ADVANCE='NO')
READ (21, '(8I3)') a(1:8)

READ (21, '(/,23X)',ADVANCE='NO')
READ (21, '(3I5)') b(1:3)

READ (21, '(/,23X)',ADVANCE='NO')
READ (21, '(8I3)') r(1:8)

READ (21, '(/,23X)',ADVANCE='NO')
READ (21, '(8I3)') s(1:8)

! Comenzamos a rellenar el fichero de salida.

WRITE (22, '(3X,A/17X,A//17X,A,10X,A/A/17X,A,10X,A/)') 'PRACTICA   8: PROBLEMA NO LINEAL ENTERO', &
    '=========================', '=====','===========================',      &
    'Numero de orden: | 44|  Alumno: | GIL ALAMO ANGEL, AMANDO |', '=====', &
    '==========================='

! Calculamos el numero total de soluciones entre las cotas y lo escribimos.

total = PRODUCT(s(1:n)-r(1:n)+1.d0)
WRITE (22, '(37X,A/A,I8,A/37X,A)') '==================', &
    'Numero de soluciones entre las cotas | total =', INT(total),'|', '=================='

! Solucion del problema, "iz" toma los valores "-1" y "1", de manera que primero maximizamos
! y a continuacion minimizamos.

DO iz = -1, 1, 2
  ! Subrutina en la que se resuelve el problema.
  CALL todas_adaptada (iz, n, m, a, b, r, s, z, nfac, sol)
  
  IF (nfac == 0) THEN ! Nos aseguramos de que no sea infactible

    WRITE (22,'(//3X,A)') 'El problema NO tiene solucion factible'

  ELSE  ! solucion optima encontrada, terminamos de escribir en el fichero de salida.
	
	IF (iz == -1) THEN
	  
	  ! Escribimos el numero de soluciones factibles y el valor maximo obtenido.
	  ! Como no especificaba la precision con la que se debia dar el valor optimo,
	  ! hemos decidido dar 10 decimales, pero podriamos haber elegido cualquier otro.
      WRITE (22,'(/37X,A/A,I8,A/37X,A//14X,A/A,F14.10,A/14X,A)') '==================', &
          'Numero de soluciones factibles       | nfac  =', nfac, '|',                &
		  '==================', '========================', 'Valor maximo  | zmax =', &
		  z,' |', '========================'
	  
	  !Escribimos el vector en el que se alcanza el valor maximo.
	  WRITE (22, '(3(/25X,A)/10X,A)',ADVANCE='NO') '=========================================', &
	      '|  x1|  x2|  x3|  x4|  x5|  x6|  x7|  x8|', &
		  '=========================================', 'maximo global  |'
	  DO i = 1, n
	    WRITE (22, '(I4,A)',ADVANCE='NO') sol(i), '|'
	  ENDDO
	  WRITE (22, '(/25X,A)') '========================================='
	  
	ELSE
	  
	  ! Escribimos el valor minimo obtenido.
	  WRITE (22,  '(//14X,A/A,F14.10,A/14X,A)') '========================', &
	      'Valor minimo  | zmin =', z,' |', '========================'
	  
      ! Escribimos el vector en el que se alcanza el valor minimo.	  
	  WRITE (22, '(3(/25X,A)/10X,A)',ADVANCE='NO') '=========================================', &
	      '|  x1|  x2|  x3|  x4|  x5|  x6|  x7|  x8|', &
		  '=========================================', 'minimo global  |'
	  DO i = 1, n
	    WRITE (22, '(I4,A)',ADVANCE='NO') sol(i), '|'
	  ENDDO
	  WRITE (22, '(/25X,A)') '========================================='
	ENDIF
	
  ENDIF

ENDDO

ENDPROGRAM practica8_angel_gil

! !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

! NOTA : En la subrutinas 'todas' apenas hemos hecho cambios: adaptamos
!        las variables de entrada (eliminamos is, ma, ibt y c; v -> r,
!		 u -> s) y las variables locales (suma pasa de ser entero a
!		 doble precision, eliminamos mejor ya que se utilizaba para ir
!        sacando mejores soluciones y nosotros solo queremos la mejor.

!        La subrutina 'enumerar' se ha dejado intacta ya que funciona
!        tal y como queremos. Además, ya la usamos (adaptamos mas bien)
!        en la practica 5 para construir la rejilla de puntos del hiper-
!        rectangulo.

! !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

! ======================================================================
! SUBROUTINE todas_adaptada

! PROPOSITO: Enumera todas las soluciones enteras que satisfacen las
!            cotas, comprueba si ademas cumplen las otras restricciones
!            y encuentra una solucion optima, si existe.

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

SUBROUTINE todas_adaptada (iz, n, m, a, b, r, s, z, nfac, sol)
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
! Primera sentencia ejecutable.

nfac = 0
infto = HUGE(1)
z = iz*infto
x(1:n) = r(1:n)     ! primera solucion a probar.

DO   ! analisis de las soluciones.

! Comprobamos si x es factible.

  DO i = 1, m
    IF (i == 1) THEN
      suma = DOT_PRODUCT(a(1:n),x(1:n))
	ELSE
	  suma = SUM(x**i)
	ENDIF
    IF (suma>b(i)) GOTO 10    ! Si no es factible, no evaluamos la 
  ENDDO						  ! funcion objetivo.

! La solucion x es factible. Se evalua la funcion objetivo.

  nfac = nfac + 1       ! nueva solucion factible.
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

ENDSUBROUTINE todas_adaptada

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