MODULE datos
  INTEGER numval
  INTEGER valores(100)
ENDMODULE datos

PROGRAM compartir
  USE datos
  IMPLICIT NONE
  INTEGER i

  PRINT*, ' numero de valores = '
  READ*, numval
  numval = MIN(numval, 100)
  DO i = 1, numval
    valores(i)=i**i
  ENDDO
  CALL escribe
ENDPROGRAM compartir

SUBROUTINE escribe
  USE datos
  IMPLICIT NONE
  INTEGER i
  DO i = 1, numval
    PRINT*, valores(i)    ! caracter global
  ENDDO
ENDSUBROUTINE escribe