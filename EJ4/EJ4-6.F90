REAL x, f

PRINT*, ' valor de x = ' ; READ*, x

IF (0<=x .AND. x<=1) THEN
  f = 3*x**2 - 1
ELSEIF (5<=x .AND. x<=10) THEN
  f = 6*x + 4
ELSEIF (20<=x .AND. x<=40) THEN
  f = -7*x + 1
ELSE
  f = 0
ENDIF

PRINT*, ' x = ', x, ' f = ', f
END