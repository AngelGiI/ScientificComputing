PROGRAM practica4_angel_gil

IMPLICIT NONE

INTEGER m, n, i, j, k, cp, cm, cr
INTEGER, ALLOCATABLE :: X(:,:)
CHARACTER, ALLOCATABLE :: Y(:,:)
DOUBLE PRECISION vp, vm, vr, sp, sm, sr, a, b, med
DOUBLE PRECISION , PARAMETER :: tol = 10.d0**(-10)

!Abrimos el fichero de datos y el de resultados.

OPEN (17, FILE='Practica4.DAT')
OPEN (18, FILE='Practica4.RESULT')

DO k = 1, 4

  ! Leemos, escribimos y asignamos las dimensiones de cada caso.

  READ (17, '(29X,I4,4X,I5)') m, n 
  WRITE (18,'(3X,A,1X,I1,A,I4,2X,A,I4,/)') 'Caso', k, '. Matrix X(m,n); m =', m, 'n =', n  
  ALLOCATE (X(m,n),Y(m,n))

  ! Leemos, asignamos y escribimos los valores de X(i,j) en cada caso.
  
  IF (k < 4) THEN   ! Para los casos del 1 al 3 escribimos explicitamente las matrices.
    READ (17, *)
    DO j = 1, m
      READ (17, '(9X)',ADVANCE='NO')
      IF (j == 1) THEN
        WRITE (18, '(7X,A,1X)',ADVANCE='NO') '/'
      ELSEIF (j == m) THEN
        WRITE (18, '(7X,A,1X)',ADVANCE='NO') '\'
      ELSEIF (j == 1+INT(m/2)) THEN   !Escribimos 'X = ' centrado en la matriz.
        WRITE (18, '(3X,A,1X)',ADVANCE='NO') 'X = |' 
      ELSE
        WRITE (18, '(7X,A,1X)',ADVANCE='NO') '|'
      ENDIF 
      DO i = 1, (n-1)
        READ (17, '(I1,1X)', ADVANCE='NO') X(j,i)
        WRITE (18, '(I1,1X)', ADVANCE='NO') X(j,i)
      ENDDO
      READ (17, '(I1)') X(j,n)
      WRITE (18, '(I1)', ADVANCE='NO') X(j,n)
      IF (j == 1) THEN
        WRITE (18, '(1X,A)') '\'
      ELSEIF (j == m) THEN
        WRITE (18, '(1X,A)') '/'
      ELSE
        WRITE (18, '(1X,A)') '|'
      ENDIF 
    ENDDO
    READ (17, '(3/)')
    
  ELSE     ! El caso 4 es distinto, tenemos una fórmula para calcular cada X(i,j).
  
    READ (17, '(2/,7X,F7.5,5X,F7.5)') a, b
    WRITE (18, '(/,3X,A,/,3X,A,F7.5,1X,A,F7.5)') 'X(i,j) = FLOOR (7*i*MOD(8*i,7)/(1+a*i) +  2*TANH(j*MOD(j,5)/(4+b*j)))', &
    & 'a = ', a, 'b = ', b
    DO j = 1, m
      DO i = 1, m
        X(j,i) = FLOOR (7*j*MOD(8*j,7)/(1+a*j) +  2*TANH(i*MOD(i,5)/(4+b*i)))
      ENDDO
    ENDDO
  ENDIF
  
  WRITE (18, '(/,5X,A,/)') 'Solucion:'
 
  ! (Re)iniciamos para cada caso los valores de cp, cm, cr, vp, vm, vr.
  cp = 0; cm = 0; cr = 0; sp = 0.0; sm = 0.0; sr = 0.0

  ! Calculamos las medias de las celdas adyacentes a la celda X(i,j) para asignar '+', '=' o '-'.
  
  DO i = 1 , m
    DO j = 1 , n
      IF (i == 1) THEN
        IF (j == 1) THEN
           med = DBLE( X(i+1, j) + X(i+1, j+1) + X(i, j+1)) / 3.d0
        ELSEIF (j == n) THEN
           med = DBLE( X(i+1, j) + X(i+1, j-1) + X(i, j-1) ) / 3.d0
        ELSE
          med = DBLE( X(i, j-1) + X(i, j+1) + X(i+1, j-1) + X(i+1, j) + X(i+1, j+1) ) / 5.d0
        ENDIF
      
      ELSEIF (i == m) THEN 
        IF (j==1) THEN
          med = DBLE( X(i-1 , j) + X(i-1 , j+1) + X(i, j+1)) / 3.d0
        ELSEIF (j==n) THEN
          med = DBLE( X(i-1 , j) + X(i-1 , j-1) + X(i, j-1) ) / 3.d0
        ELSE
          med = DBLE( X(i,j-1) + X(i,j+1) + X(i-1,j-1) + X(i-1,j) + X(i-1,j+1) ) / 5.d0
        ENDIF
         
      ELSE
        IF (j==1) THEN
          med = DBLE( X(i-1, j) + X(i-1,j+1) + X(i,j+1) + X(i+1,j+1) + X(i+1,j)) / 5.d0
        ELSEIF (j==n) THEN
          med = DBLE( X(i-1, j) + X(i-1,j-1) + X(i,j-1) + X(i+1,j-1) + X(i+1,j)) / 5.d0       
        ELSE
          med = DBLE( X(i-1,j) + X(i-1,j+1) + X(i, j+1) + X(i+1,j+1)+ X(i+1,j) + X(i+1, j-1) + X(i,j-1) + &
               X(i-1,j-1)) / 8.d0
        ENDIF
      ENDIF
		
      ! Calculamos el numero de celdas de cada tipo y asignamos el signo a Y.

      IF ( abs(DBLE(X(i,j)) - med) < tol ) THEN
        cm = cm +1
        sm = sm + DBLE(X(i ,j))
        IF (k < 4) THEN
          Y(i,j) = '='
        ENDIF
      ELSEIF ( DBLE(X(i,j)) > med ) THEN
        cr = cr + 1
        sr = sr + DBLE(X(i,j))
        IF (k < 4) THEN      
          Y(i,j) = '+'
		ENDIF
      ELSEIF ( med > DBLE(X(i,j)) ) THEN
        cp = cp + 1
        sp = sp + DBLE(X(i,j))
        IF (k < 4) THEN  
          Y(i,j) = '-'
        ENDIF
      ENDIF   
    ENDDO
  ENDDO
    
  IF (k < 4) THEN    ! En los casos 1 a 3 escribimos la matriz de signos.
    DO i = 1, m
      IF (i == 1) THEN
        WRITE (18, '(7X,A,1X)',ADVANCE='NO') '/'
      ELSEIF (i == m) THEN
        WRITE (18, '(7X,A,1X)',ADVANCE='NO') '\'
      ELSEIF (i == 1+INT(m/2)) THEN
        WRITE (18, '(3X,A,1X)',ADVANCE='NO') 'Y = |'    ! Escribimos 'Y = ' centrado.
      ELSE
        WRITE (18, '(7X,A,1X)',ADVANCE='NO') '|'
      ENDIF
	  
      DO j = 1, n
        WRITE (18, '(A,1X)',ADVANCE='NO') Y(i,j)
      ENDDO
	  
      IF (i == 1) THEN
        WRITE (18, '(A)') '\'
      ELSEIF (i == m) THEN
        WRITE (18, '(A)') '/'
      ELSE
        WRITE (18, '(A)') '|'
      ENDIF 
    ENDDO
  ENDIF
   
  ! Escribimos la parte final de la solucion en el fichero de salida.
  
  ! Numero de celdas de cada tipo.
  IF (k < 4) THEN    !Para los casos 1 a 3 solo necesitamos longitud 3 en los valores cp, cm, cr.
    WRITE (18, '(/,3X,A,1X,I3,1X,A,1X,I3,1X,A,1X,I3,1X,A)') 'La matriz X tiene:', cp, 'celda(s) pobre(s)', &
    & cm, 'celda(s) media(s) y', cr, 'celda(s) rica(s).'
    
  ELSE    ! Para el caso 4 necesitamos longitud 7.
    WRITE (18, '(/,3X,A,1X,I7,1X,A,1X,I7,1X,A,1X,I7,1X,A)') 'La matriz X tiene:', cp, 'celda(s) pobre(s)', &
    & cm, 'celda(s) media(s) y', cr, 'celda(s) rica(s).'
  ENDIF
  
  ! Media de cada tipo de celda.
  
  IF (cr > 0) THEN   ! Si una matriz no tiene determinadas celdas, no tiene sentido calcular su valor medio.
    vr = sr / DBLE(cr)    ! Calculamos el valor medio (valor total de las celdas / numero de celdas).
    WRITE (18, '(3X,A,1X,F9.6)' ) 'El valor medio de las celdas ricas es:', vr
  ENDIF
  IF (cm > 0) THEN
    vm = sm / DBLE(cm)
    WRITE (18, '(3X,A,1X,F9.6)' ) 'El valor medio de las celdas medias es:', vm
  ENDIF
  IF (cp > 0) THEN
    vp = sp / DBLE(cp)
    WRITE (18, '(3X,A,1X,F9.6)' ) 'El valor medio de las celdas pobres es:', vp
  ENDIF
  
  IF (k == 4) EXIT    ! En el caso 4 no hacemos la separacion.
  WRITE (18, '(2/,3X,A)') '-------------------------------------------------------------------------------' 
  DEALLOCATE (Y,X)      

ENDDO

ENDPROGRAM practica4_angel_gil    