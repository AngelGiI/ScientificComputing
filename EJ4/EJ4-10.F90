INTEGER, PARAMETER:: n=100000
REAL x(n), suma1, suma2, suma3

DO i = 1, n
  x(i) = 1.0/i
ENDDO

suma1 = 0.0
DO i = 1, n
  suma1 = suma1 + x(i)
ENDDO
suma2 = 0.0
DO i = n, 1, -1
  suma2 = suma2 + x(i)
ENDDO
PRINT*, ' suma1 = ', suma1, ' suma2 = ', suma2

suma3 = 0
DO i = 1, 100000, 3    ! i toma los valores 1, 4, 7,...
  IF (suma3 <= 5) THEN
    suma3 = suma3 + x(i)
    PRINT*, ' i =', i, ' suma3 = ', suma3
  ELSE
    PRINT*, ' suma3 > 5'
    STOP
  ENDIF
ENDDO

END