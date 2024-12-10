PROGRAM ejercicio2_examen_angel
IMPLICIT NONE 

INTEGER, PARAMETER :: m=20, n=10, k = 5
INTEGER i, j, r, s, rmejor, smejor
DOUBLE PRECISION A(m,n), tros, trosMin, B(k,k)

! Abrimos el fichero de datos y el de resultados.   

OPEN (13, FILE='ejercicio2.DAT')
OPEN (14, FILE='ejercicio2.RESULT')

WRITE (14, '(3X,A/16X,A)') 'Ejercicio 2: SUBMATRIZ DE MENOR TRAZA OSCILANTE',  &
                         & '=================================='
WRITE (14, '(/3X,A)') 'Alumno: GIL ALAMO ANGEL, AMANDO'

DO i = 1, 20
  READ (13, *)  (A(i,j), j = 1,10)
ENDDO

trosMin = 100.d0
DO r = 1, m - (k-1)
  DO s = 1, n - (k-1)
  
    tros = A(r,s) - A(r+1,s+1) + A(r+2,s+2) - A(r+3,s+3) + A(r+4,s+4)
	IF (tros < trosMin) THEN
	   trosMin = tros
	   rmejor = r
	   smejor = s
	ENDIF
  ENDDO
ENDDO

WRITE (14, '(/3X,A,I2,A,I2,A)',ADVANCE='NO') 'i= ', rmejor,', j=', smejor, ';'
WRITE (14, '(1X,A,F8.4/)') 'tros(B) = tros(A(i:i+4,j:j+4)) = ', trosMin

! A ** 2
B = MATMUL(A(rmejor:rmejor+4,smejor:smejor+4),A(rmejor:rmejor+4,smejor:smejor+4))
! A ** 4
B = MATMUL(B,B)
! A ** 8
B = MATMUL(B,B)
! Finalmente, A ** 9
B = MATMUL(A(rmejor:rmejor+4,smejor:smejor+4),B)

WRITE (14, '(3X,A/)') 'Calculamos C = B ** 9 y escribimos los componentes de la diagonal:'
DO i = 1, k
  WRITE (14, '(3X,A,I1,A,I1,A,F15.4)') 'C(', i, ',', i, ') = ', B(i,i)
ENDDO

ENDPROGRAM ejercicio2_examen_angel