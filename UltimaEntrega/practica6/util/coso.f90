PROGRAM practica6_angel_gil
IMPLICIT NONE 
INTEGER i, j, n, k, l, info, lwork
INTEGER, ALLOCATABLE :: ipiv(:)
DOUBLE PRECISION, ALLOCATABLE :: a(:,:), x(:), b(:,:), work(:), c(:,:), d(:,:)

!Abrimos el fichero de datos y el de resultados.   

OPEN (17, FILE='Practica6.DAT')
OPEN (18, FILE='Practica6.RESULT')

READ (17, '(/15X,I1,6X,I1/)') n, k

lwork = n; ALLOCATE(work(lwork))
ALLOCATE(a(n,k)); ALLOCATE(x(n)); ALLOCATE(b(k,k)); ALLOCATE(ipiv(k)); ALLOCATE(c(n,k)); ALLOCATE(d(n,n))
WRITE (18, '(/3X,A,I1,A,I1)') 'Caso A: n = ', n, ' k = ', k

DO j = 1, k
  DO i = 1, n
    IF (i == 1) THEN
	  READ (17, '(36X,F3.0)', ADVANCE='NO') a(i,j)
	  WRITE (18, '(I4)',ADVANCE='NO') INT(a(i,j))
    ELSEIF (i == n) THEN
	  READ (17, '(1X, F3.0/)') a(i,j)
	  WRITE (18, '(I4/)') INT(a(i,j))
	ELSE
	  READ (17, '(1X, F3.0)', ADVANCE='NO') a(i,j)
	  WRITE (18, '(I4)',ADVANCE='NO') INT(a(i,j))
	ENDIF
  ENDDO
ENDDO
  
DO i = 1, n
  WRITE (18, *) a(i,1:3)
ENDDO

CALL DGEMM ('T','N', k, k, n, 1.d0, a, n, a, n, 0.d0, b, k)

CALL DGETRF (k,k,b,k,ipiv,info)

CALL DGETRI (k,b,k,ipiv,work,lwork,info)
DO i = 1, k
  WRITE (18, '(/)')
  WRITE (18, *) b(i,1), b(i,2), b(i,3)
ENDDO

CALL DGEMM ('N','N',n,k,k,1.d0,a,n,b,k,0.d0,c,n)

CALL DGEMM ('N','T',n,n,k,1.d0,c,n,a,n,0.d0,d,n)

  
DO j = 1, 4
  READ (17, '(16X)', ADVANCE='NO')
  WRITE (18, '(8X,A)', ADVANCE='NO') 'x  = ('
  DO l = 1, n-1
    READ (17, '(F10.6,2X)',ADVANCE='NO') x(l)
    WRITE (18, '(F10.6,2X)',ADVANCE='NO') x(l)
  ENDDO
  READ (17, '(F10.6,2/)') x(n)
  WRITE (18, '(F10.6,A)') x(n), ')'
  IF (i == 1) THEN
    WRITE(18, '(8X,A/)') 'Px = '
  ELSE
    WRITE(18, '(8X,A/)') 'Qx = '
  ENDIF
ENDDO
  
DEALLOCATE(a); DEALLOCATE(x); DEALLOCATE(b); DEALLOCATE(ipiv); DEALLOCATE(work); DEALLOCATE(c); DEALLOCATE(d)

ENDPROGRAM practica6_angel_gil