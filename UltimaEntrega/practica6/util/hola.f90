program hola
IMPLICIT NONE 
INTEGER i, j, n, k, l
DOUBLE PRECISION, ALLOCATABLE :: a(:,:), x(:), b(:,:)

!Abrimos el fichero de datos y el de resultados.   

OPEN (17, FILE='Practica6.DAT')
OPEN (18, FILE='Practica6.RESULT')

DO i = 1, 2
  READ (17, '(/15X,I1,6X,I1/)') n, k
  ALLOCATE (a(n,k)); ALLOCATE (x(n)); ALLOCATE (b(k,k))
  IF (i == 1) THEN
    WRITE (18, '(/3X,A,I1,A,I1)') 'Caso A: n = ', n, ' k = ', k
  ELSE
    WRITE (18, '(/3X,A,I1,A,I1)') 'Caso B: n = ', n, ' k = ', k
  ENDIF
  
  DO j = 1, k
    IF (i == 1) THEN
      READ (17, '(36X)',ADVANCE='NO')
      WRITE (18, '(29X,A,I1,A)',ADVANCE='NO') 'a', j, ' = ('
    ELSE
      READ (17, '(40X)',ADVANCE='NO')
      WRITE (18, '(29X,A,I1,A)',ADVANCE='NO') 'B(', j, ',:) = ('
    ENDIF  
    DO l = 1, n-1
      READ (17, '(F3.0,1X)',ADVANCE='NO') a(l,j)
      WRITE (18, '(I3,1X)',ADVANCE='NO') INT(a(l,j))
    ENDDO
    READ (17, '(F3.0/)') a(n,k)
    WRITE (18, '(I3,A/)') INT(a(n,k)), ')'
  ENDDO
  
  !
  WRITE (18, '(3X,2F8.0)') a(1,1), a(1,2)
  WRITE (18, '(3X,2F8.0)') a(2,1), a(2,2)
  CALL DGEMM ('N','T', k, k, n, 1.d0, a, n, a, n, 0.d0, b, k)
  WRITE (18, *) b(1,1), b(1,2)
  WRITE (18, *) b(2,1), b(2,2)
  
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
  
  DEALLOCATE (a); DEALLOCATE (x); DEALLOCATE (b)
ENDDO
end