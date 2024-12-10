PRINT*, ' Introducir n>0'
READ*, n
IF (n <= 0) STOP ' volver a ejecutar el programa'

DO
  PRINT*, ' n = ', n, '    n*n = ', n*n, '    n*n*n = ', n*n*n

  IF (n >= 1000) THEN
    PRINT*, ' n tiene mas de 3 cifras, n = ', n
    STOP
  ENDIF

  IF (1<=n .AND. n<=9) THEN
    n = n + 1
  ELSEIF (10<=n .AND. n<=99) THEN
    n = 2*n
  ELSEIF (100<=n .AND. n<=999) THEN
    n = 3*n
  ENDIF

ENDDO

END