x = 0.0
DO
  x = x + 0.1
  PRINT*, ' x = ', x
  IF (x == 1.2) STOP ' x = 1.2'

! Sin la siguiente sentencia este bucle no terminaria nunca

  IF (x >= 4.0) STOP ' No ha ocurrido x = 1.2'
ENDDO
END