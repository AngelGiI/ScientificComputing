PRINT*, ' Valores de x, y' ; READ*, x, y

IF (x > y) THEN
  x = x - 1.0
ELSE
  x = 2.*x
  IF (y >= 50) THEN
    z = x + y
    GOTO 500
  ENDIF
ENDIF

PRINT*, ' Inicialmente era x>y o {x<=y, y<50}'
500 PRINT*, x, y, z   ! z puede no tener valor asignado
END