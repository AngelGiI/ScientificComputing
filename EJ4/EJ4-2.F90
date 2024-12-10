REAL x, y, h, v(30,20)
INTEGER i
LOGICAL xmenory

10 PRINT*, ' Introducir i entre 1 y 30: '
READ*, i
IF (i<=0 .OR. i>30) GOTO 10

x = 3.5; y = 5.6; v(i,3) = 1.4*i
xmenory = x < y
IF (x+y < v(i,3)) h = h + 1.5
IF (i == 4) STOP   ! Detiene la ejecucion del programa
IF (xmenory) PRINT*, x, y, v(i,3)
END