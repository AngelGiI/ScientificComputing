! ==================================================================================
! PRACTICA 6: MATRIZ PROYECCION - ANGEL A. GIL (Numero de orden: 44)

! PROPOSITO: Calcular la proyeccion ortogonal de un vector de Rn sobre distintas
!            variedades lineales.

! PROBLEMA:  Calcular la proyeccion ortogonal en los siguientes casos:

!         (A) Dados los vectores linealmente independientes a1,...,ak en Rn sea L la
!             variedad lineal generada por ellos. Sea A la matriz cuyas columnas son
!             a1,...,ak.

!             La proyeccion ortogonal de un vector x de Rn sobre L es pr(x|L) = Px
!             donde P es la matriz P = A(A'A)(**-1)A'.

!         (B) Sea B(k,n) una matriz de rango maximo k<n y S la variedad lineal
!             definida implicitamente como S = {y en Rn | By=0}. 

!             La proyeccion ortogonal de un vector x de Rn sobre S es pr(x|S) = Qx
!             donde Q es la matriz Q = I - B'(BB')(**-1)B.

!         Nota.- La notacion ' significa traspuesta y (**-1) inversa.

! ELEMENTOS DEL PROBLEMA:

! ENTERAS:
!   n, k    : dimensiones de la matriz asociada la variedad lineal
!   i, j, l : indices utilizados en bucles

! ENTERAS, ALLOCATABLE:
!   iden : matriz identidad de dimension n

! DOBLE PRECISION, ALLOCATABLE: 
!   a, b, c, p : matrices utilizadas en el programa
!   x, y       : vectores utilizados en el programa

! SUBPROGRAMAS LLAMADOS (LIBRERIAS):

!   DGEMM  : operaciones  matriz-matriz
!   DGETRF : factorizacion LU de una matriz
!   DGETRI : inversa de una matriz usando la factorizacion LU dada por DGETRF
!   DGEMV  : operaciones matriz-vector

! VARIABLES AUXILIARES DEFINIDAS PARA ENTRADA EN LAS LIBRERIAS:

!   info    : entrada/salida de DGETRI y DGETRF. Su valor tras llamar a una de estas
!             subrutinas indica si hubo algun problema

!   lwork   : entrada de DGETRI. Dimension del array work (lwork >= n)

!   work    : salida/espacio de trabajo de DGETRI. Si en la salida, info = 0 (es
!             decir, si todo sale bien), work(1) indica el tamaño optimo de lwork

!   ipiv    : variable de salida de DGETRF, entrada de DGETRI. Le indica al segundo
!             subprograma las permutaciones de fila realizadas por el primero
 
! ==================================================================================

! IMPORTANTE: ACLARACION SOBRE EL CASO (B)
!            =============================

!   En el programa, leemos B como una matriz n*k en lugar de k*n, de manera que
!   obtenemos C = B'. 

!   Si reescribimos la matriz de la proyeccion ortogonal:

!           Q = I - B'(BB')(**-1)B  = I - C(C'C)(**-1)C'. 

!   Tenemos que C(C'C)(**-1)C' es precisamente la matriz que queremos obtener en el 
!   caso (A), por lo que podemos realizar los mismos calculos con la diferencia que 
!   en (B) faltaria restar la matriz obtenida a la identidad.

! ==================================================================================

PROGRAM practica6_angel_gil
IMPLICIT NONE 
INTEGER i, j, n, k, l, info, lwork
INTEGER, ALLOCATABLE :: ipiv(:), iden(:,:)
DOUBLE PRECISION, ALLOCATABLE :: a(:,:), x(:), b(:,:), work(:), c(:,:), p(:,:), y(:)

! Abrimos el fichero de datos y el de resultados.   

OPEN (17, FILE='Practica6.DAT')
OPEN (18, FILE='Practica6.RESULT')

DO i = 1, 2   ! Ejecutamos el programa una vez para cada caso.
  READ (17, '(/15X,I1,6X,I1/)') n, k
  
  ! Una vez leidas las dimensiones del problema, las asignamos a cada variable segun
  ! corresponda.
  lwork = n; ALLOCATE(work(lwork))
  ALLOCATE(a(n,k), b(k,k), c(n,k), p(n,n), x(n), y(n), ipiv(k))

  ! En el caso (B), fijamos el tamaño de la matriz identidad y la construimos.
  IF (i == 2) THEN
    ALLOCATE(iden(n,n))
	
	DO j = 1, n
	  DO l = 1, n
	    IF (j == l) THEN
		  iden(j,l) = 1
		ELSE
		  iden(j,l) = 0
        ENDIF 
	  ENDDO
	ENDDO

	! Comenzamos a rellenar el fichero de salida (distinguiendo los casos).
	WRITE (18, '(/3X,A,I1,A,I1)') 'Caso B: n = ', n, ' k = ', k
  ELSE
    WRITE (18, '(3X,A/17X,A//17X,A,10X,A/A/17X,A,10X,A/)') 'PRACTICA   6: MATRIZ PROYECCION', &
    '=================', '=====','===========================',      &
    'Numero de orden: | 44|  Alumno: | GIL ALAMO ANGEL, AMANDO |', '=====', &
    '==========================='
    WRITE (18, '(/3X,A,I1,A,I1)') 'Caso A: n = ', n, ' k = ', k
  ENDIF
  
  ! Leemos, asignamos y escribimos la matriz asociada a la variedad lineal.
  DO j = 1, k
    DO l = 1, n
      IF (l == 1) THEN
	  
	    IF (i == 1) THEN
          READ (17, '(36X,F3.0)', ADVANCE='NO') a(l,j)
	      WRITE (18, '(29X,A,I1,A,I4)',ADVANCE='NO') 'a', j, ' = (', INT(a(l,j))
        ELSE
          READ (17, '(40X,F3.0)',ADVANCE='NO') a(l,j)
          WRITE (18, '(29X,A,I1,A,I4)',ADVANCE='NO') 'B(', j, ',:) = (', INT(a(l,j))
		ENDIF
		
      ELSEIF (l == n) THEN
	    READ (17, '(1X, F3.0/)') a(l,j)
	    WRITE (18, '(I4,A/)') INT(a(l,j)), ')'
	  ELSE
	    READ (17, '(1X, F3.0)', ADVANCE='NO') a(l,j)
	    WRITE (18, '(I4)',ADVANCE='NO') INT(a(l,j))
	  ENDIF
    ENDDO
  ENDDO
  
  ! --------------------------------------------------------------------------------
  ! Breve descripcion sobre las operaciones realizadas por las librerias llamadas:
  !   Teniendo A, queremos obtener P, donde P = A(A'A)(**-1)A'.

  !   Primera llamada a DGEMM: 
  !     Calculamos B = A' * A
  
  !   Llamadas a DGETRF y DGETRI:
  !     Factorizacion LU de B y posterior inversion ( = (A'A)(**-1) )
  
  !   Segunda llamada a DGEMM:
  !     Calculamos C = A * B  ( = A(A'A)(**-1) )
  
  !   Tercera llamada a DGEMM:
  !     Calculamos P = C * A' ( = A(A'A)(**-1)A' )
  ! --------------------------------------------------------------------------------
  
  CALL DGEMM ('T','N', k, k, n, 1.d0, a, n, a, n, 0.d0, b, k)

  CALL DGETRF (k,k,b,k,ipiv,info)

  CALL DGETRI (k,b,k,ipiv,work,lwork,info)

  CALL DGEMM ('N','N',n,k,k,1.d0,a,n,b,k,0.d0,c,n)

  CALL DGEMM ('N','T',n,n,k,1.d0,c,n,a,n,0.d0,p,n)

  ! Como hemos comentado (ver: Aclaracion), en el caso (B) no hemos terminado:
  !   Q = I - A(A'A)(**-1)A' = iden - p
  IF (i == 2) THEN
    p = DBLE(iden) - p
  ENDIF
  
  ! Leemos, asignamos y escribimos el vector X.
  DO j = 1, 4
    READ (17, '(16X)', ADVANCE='NO')
    WRITE (18, '(8X,A)', ADVANCE='NO') 'x  = ('
    DO l = 1, n-1
      READ (17, '(F10.6,2X)',ADVANCE='NO') x(l)
      WRITE (18, '(F10.6,2X)',ADVANCE='NO') x(l)
    ENDDO
    READ (17, '(F10.6,2/)') x(n)
    WRITE (18, '(F10.6,A)') x(n), ')'
	
	! Una vez obtenidos P (resp. Q) y X, solo queda multiplicarlos.
	
	! Llamamos a DGEMV:
	!   Calcula y = p * x, la proyeccion de X sobre la subvariedad deseada.
	CALL DGEMV ('N', n, n, 1.d0, p, n, x, 1, 0.d0, y, 1)
	
	! Escribimos la proyeccion devuelta por DGEMV.
    IF (l == 1) THEN
      WRITE(18, '(8X,A)', ADVANCE='NO') 'Px = ('
    ELSE
      WRITE(18, '(8X,A)', ADVANCE='NO') 'Qx = ('
    ENDIF
	DO l = 1, n-1
	  WRITE (18, '(F10.6,2X)',ADVANCE='NO') y(l)
	ENDDO
	WRITE (18, '(F10.6,A/)') y(n), ')'
  ENDDO
  
  ! En el caso (B), deasignamos la matriz unidad.
  IF (i == 2) THEN
    DEALLOCATE(iden)
  ENDIF
  
  ! Finalmente, deasignamos las demas variables.
  DEALLOCATE(a, b, c, p, x, y, ipiv, work);
ENDDO

ENDPROGRAM practica6_angel_gil