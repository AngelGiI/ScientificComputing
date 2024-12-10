PROGRAM principal
COMMON a, b, c(100), d(10,5)
COMMON /ctes/ nvar, ncasos, nfilas
a=1; b=2
nvar=5; ncasos=100
CALL calculo
CALL eval(9.0, 8.0, 7.0)
PRINT*, ' nvar, ncasos, nfilas = ', nvar, ncasos, nfilas
END

SUBROUTINE calculo
COMMON x, y, z(100), u(10,5)
COMMON /ctes/ n, m, l
l = 2000
END

SUBROUTINE eval (x,y,z)
COMMON r, s
PRINT*, ' a, b = ', r, s
PRINT*, x, y, z
END