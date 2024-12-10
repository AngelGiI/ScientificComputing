PRINT*, ' Introducir x  a  b'
READ*, x, a, b
PRINT*, ' x=', x, ' a=', a, ' b=', b, ' fun(x,a,b)=', fun(x,a,b)
END

FUNCTION fun(x,a,b)
IF (x >= a+b) THEN
  fun = x**a / (x+b)
ELSE
  fun = (x+a) / (x*b - a)
ENDIF
END