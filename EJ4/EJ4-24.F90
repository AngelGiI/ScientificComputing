PRINT*, ' Introducir n'
READ*, n

IF (n > 10) GOTO 100
IF (n < 5) THEN
  STOP ' n<5'
ELSE
  STOP ' 5<=n<=10'
  100 ENDIF    ! Deberia ponerse la etiqueta 100 en
PRINT*, ' n>10'! la sentencia PRINT

END