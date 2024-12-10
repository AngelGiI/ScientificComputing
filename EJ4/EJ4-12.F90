nimpar = 0
DO
  PRINT*, ' Introducir numero = '; READ*, n
  IF (n < 0) THEN
    EXIT
  ELSEIF (n-(n/2)*2 == 0) THEN
    CYCLE
  ELSE
    nimpar = nimpar + 1
  ENDIF
ENDDO

PRINT*, ' Cantidad de impares = ', nimpar
END