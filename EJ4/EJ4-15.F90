n = 25
DO 300 i = 1, n
  PRINT*, ' i =', i

    DO 200 j = 1, n
      DO 100 k = 1, n
        IF (k == i+j) GOTO 300
        IF (k+i+j == 13) GOTO 150
        IF (k+i+j == 10) GOTO 250
  100 CONTINUE
      PRINT*, ' j =', j
      GOTO 200
  150 CONTINUE
      PRINT*, ' i+j+k = 13'
200 CONTINUE

250 PRINT*, ' i+j+k = 10'
300 CONTINUE
END