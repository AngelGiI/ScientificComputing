PROGRAM ordenar
IMPLICIT NONE
INTEGER num(100), cpos, cneg, ceros, temp, n, i, j

PRINT*, 'cantidad de numeros (<=100)'
READ*, n
IF (n > 100) STOP ' n debe ser <=100'
DO i = 1, n
  PRINT*, 'numero ', i
  READ*, num(i)
ENDDO

!  ordenacion de menor a mayor

DO i = 1, n-1
  DO j = i+1, n
    IF (num(i) > num(j)) THEN
      temp = num(i)
      num(i) = num(j)
      num(j) = temp
    ENDIF
  ENDDO
ENDDO

!  escritura en la pantalla de los numeros de lugar par

DO i = 2, n, 2
  PRINT*, num(i)
ENDDO

!  conteo de positivos, negativos y ceros

cpos = 0
cneg = 0
ceros = 0
DO i = 1, n                   ! Otra forma equivalente es:
 IF (num(i) > 0) THEN         ! IF (num(i) > 0)  cpos=cpos+1
   cpos=cpos+1                ! IF (num(i) == 0) ceros=ceros+1
  ELSEIF (num(i) == 0) THEN   ! IF (num(i) < 0)  cneg=cneg+1
    ceros = ceros + 1
  ELSE
    cneg = cneg + 1
  ENDIF
ENDDO

PRINT*, ' cpos=', cpos
PRINT*, ' ceros=', ceros
PRINT*, ' cneg=', cneg

ENDPROGRAM ordenar