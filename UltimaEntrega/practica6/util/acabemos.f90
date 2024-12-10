PROGRAM practica6_angel_gil
IMPLICIT NONE 
INTEGER i, j, n, k, l, info, lwork
INTEGER, ALLOCATABLE :: ipiv(:), i5(:,:)
DOUBLE PRECISION, ALLOCATABLE :: a(:,:), x(:), b(:,:), work(:), c(:,:), p(:,:), y(:)

!Abrimos el fichero de datos y el de resultados.   

OPEN (17, FILE='Practica6javi.DAT')
OPEN (18, FILE='Practica6javi.RESULT')

DO i = 1, 2
  READ (17, '(/15X,I1,6X,I1/)') n, k

  lwork = n; ALLOCATE(work(lwork))
  ALLOCATE(a(n,k)); ALLOCATE(x(n)); ALLOCATE(b(k,k)); ALLOCATE(ipiv(k)); ALLOCATE(c(n,k)); ALLOCATE(p(n,n)); ALLOCATE(y(n))
  IF (i == 2) THEN
    ALLOCATE(i5(n,n))
  ENDIF
  WRITE (18, '(/3X,A,I1,A,I1)') 'Caso A: n = ', n, ' k = ', k

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
  
  if (i == 2) then
    do j = 1, n
	  write (18, '()')
	  write (18, '(2f10.6)') a(j,1:k)
	enddo
  endif

  CALL DGEMM ('T','N', k, k, n, 1.d0, a, n, a, n, 0.d0, b, k)
  
  if (i == 2) then
    do j = 1, k
	  write (18, '()')
	  write (18, *) b(j,1:k)
	enddo
  endif
  
  CALL DGETRF (k,k,b,k,ipiv,info)

  CALL DGETRI (k,b,k,ipiv,work,lwork,info)

  if (i == 2) then
    do j = 1, k
	  write (18, '()')
	  write (18, *) b(j,1:k)
	enddo
  endif
  
  CALL DGEMM ('N','N',n,k,k,1.d0,a,n,b,k,0.d0,c,n)
  
  if (i == 2) then
    do j = 1, n
	  write (18, '()')
	  write (18, *) c(j,1:k)
	enddo
  endif

  CALL DGEMM ('N','T',n,n,k,1.d0,c,n,a,n,0.d0,p,n)
  
  if (i == 2) then
    do j = 1, n
	  write (18, '()')
	  write (18, *) p(j,1:n)
	enddo
  endif
  
  IF (i == 2) THEN
    DO j = 1, n
	  DO l = 1, n
	    IF (j == l) THEN
		  i5(j,l) = 1
		ELSE
		  i5(j,l) = 0
        ENDIF 
	  ENDDO
	ENDDO
    p = DBLE(i5) - p
  ENDIF
  
  if (i == 2) then
    write (18, '(3/)')
    do j = 1, n
	  write (18, '()')
	  write (18, *) p(j,1:n)
	enddo
  endif
  
  
  DO j = 1, 4
    READ (17, '(16X)', ADVANCE='NO')
    WRITE (18, '(8X,A)', ADVANCE='NO') 'x  = ('
    DO l = 1, n-1
      READ (17, '(F10.6,2X)',ADVANCE='NO') x(l)
      WRITE (18, '(F10.6,2X)',ADVANCE='NO') x(l)
    ENDDO
    READ (17, '(F10.6,2/)') x(n)
    WRITE (18, '(F10.6,A)') x(n), ')'
	CALL DGEMV ('N', n, n, 1.d0, p, n, x, 1, 0.d0, y, 1)
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
  
  IF (i == 2) THEN
    DEALLOCATE(i5)
  ENDIF
  DEALLOCATE(a); DEALLOCATE(x); DEALLOCATE(b); DEALLOCATE(ipiv); DEALLOCATE(work); DEALLOCATE(c); DEALLOCATE(p); DEALLOCATE(y)
ENDDO

ENDPROGRAM practica6_angel_gil