PRINT*, ' Introducir i, j, k =' ; READ*, i, j, k

IF (i < 100) THEN
  PRINT*, ' i<100'
  IF (j < 10) THEN
    PRINT*, ' i<100 y j<10'
  ENDIF
ELSE
  IF (k >= 50) THEN
    PRINT*, ' i>=100 y k>=50'
  ENDIF
  PRINT*, 'i>=100'
ENDIF

END