PRINT*, ' Introducir n>0'
READ*, n
IF (n <= 0) STOP ' volver a ejecutar el programa'

50 IF (1<=n .AND. n<=9) THEN
     ASSIGN 1 TO ncifras
   ELSEIF (10<=n .AND. n<=99) THEN
     ASSIGN 2 TO ncifras
   ELSEIF (100<=n .AND. n<=999) THEN
     ASSIGN 3 TO ncifras
   ELSE
     ASSIGN 4 TO ncifras
   ENDIF

GOTO 100

1 n = n +1
GOTO 50
2 n = 2*n
GOTO 50
3 n = 3*n
GOTO 50

100 PRINT*, ' n = ', n, '    n*n = ', n*n, '    n*n*n = ', n*n*n
GOTO ncifras (1,2,3,4)

4 PRINT*, ' n ya tiene mas de 3 cifras, n = ', n
END