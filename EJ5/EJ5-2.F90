REAL otrafun, x, a, b
INTEGER indice
PRINT*, ' Introducir x,  a,  b,  indice'
READ*, x, a, b, indice
PRINT*, ' x=', x, ' a=', a, ' b=', b, ' indice=', indice
otx = otrafun(x,a,b,indice)
PRINT*, ' otrafun(x,a,b,indice)=', otx
END

FUNCTION otrafun(x,a,b,indice)
REAL otrafun, x, a, b
INTEGER indice
IF (indice < 0) THEN    ! equivalente a:
  otrafun = 1.e30
  RETURN                ! otrafun = 1.e30
ENDIF                   ! IF (indice.LT.0) RETURN
IF (x >= a+b) THEN
  otrafun = x**a / (x+b)
ELSE
  otrafun = (x+a) / (x*b - a)
ENDIF
RETURN   ! es innecesario
END