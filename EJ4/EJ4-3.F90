REAL x, y, temp
PRINT*, ' Valor de x = '
READ*, x
PRINT*, ' Valor de y = '
READ*, y
PRINT*, x, y

IF (x > y) THEN    ! intercambio: IF (...
  temp = x
  x = y
  y = temp
ENDIF                   ! ENDIF intercambio

PRINT*, 'Si x>y se han intercambiado x, y'
PRINT*, ' x = ', x, ' y = ', y

END