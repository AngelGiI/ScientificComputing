PRINT*, ' Introducir n, nfin'
READ*, n, nfin

DO i = 10, n, 5
  PRINT*, ' i = ', i
  IF (i == nfin) EXIT
ENDDO

PRINT*, ' Valor de i al salir del DO = ', i
END