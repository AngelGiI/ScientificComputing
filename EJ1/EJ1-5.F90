PROGRAM ejemplo5
INTEGER n, i
REAL, DIMENSION(100):: x        ! equivalente a REAL x(100)
REAL:: suma, media, varianza

! Lectura por teclado de los numeros x(i). Para terminar poner 9999

!i = 0
!10 i = i + 1
!PRINT*, 'i = ', i
!READ*, x(i)
!IF (x(i) .NE. 9999) GOTO 10
!n = i - 1        ! el ultimo numero, 9999, no se considera

! Codificacion equivalente y mejor que la anterior

i = 0
DO
  i = i + 1
  PRINT*, 'i = ', i
  READ*, x(i)
  IF (x(i) == 9999) EXIT
ENDDO
n = i - 1        ! el ultimo numero, 9999, no se considera

! Calculo de la suma, media y varianza

suma = 0
DO i = 1, n
  suma = suma + x(i)
ENDDO

media = suma / n

varianza = 0
DO i = 1, n
  varianza = varianza + (x(i)-media)**2
ENDDO
varianza = varianza / n

! Escritura de resultados

PRINT 9000, 'Se han leido ', n, ' numeros'
9000 FORMAT (5X,A,I4,A)
PRINT 9010, 'suma = ', suma, 'media = ', media, 'varianza = ', varianza
9010 FORMAT (//2X,A,F10.4,3X,A,F10.4,3X,A,F14.5)

END