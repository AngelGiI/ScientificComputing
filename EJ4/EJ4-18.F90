PRINT*, ' Introducir m, n'
READ*, m, n

IF (m+2**n) 20,30,10
10 PRINT*, ' m+2**n > 0 : ', m+2**n     ! aqui se va si m+2**n > 0
GOTO 40
20 PRINT*, ' m+2**n < 0 : ', m+2**n     ! aqui se va si m+2**n < 0
GOTO 40
30 PRINT*, ' m+2**n = 0 : ', m+2**n     ! aqui se va si m+2**n = 0
40 CONTINUE

END