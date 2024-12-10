n = 0; suma = 0

DO WHILE (suma <= 5)
  n = n + 1
  suma = suma + 1.0/n
  PRINT*, ' n =', n, ' suma = ', suma
ENDDO

STOP ' suma > 5'
END