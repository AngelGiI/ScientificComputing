DO x = 0.4, 3, 0.2
  PRINT*, ' x = ', x
  IF (x == 1.8) STOP ' x = 1.8'
ENDDO
PRINT*, ' No ha ocurrido x = 1.8'
END