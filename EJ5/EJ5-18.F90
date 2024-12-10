! Aproximacion de la funcion exp(x)

expon(x) = 1 + x + 0.5*x**2 + 1.0/6*x**3 + 1.0/24*x**4 + &
           1.0/120*x**5 + 1.0/720*x**6

DO i = 1, 20
  t = i*0.1
  et = expon(t)
  PRINT*, ' t =', t, '  e^t=', et, '  exp(t)=', EXP(t)
ENDDO
END