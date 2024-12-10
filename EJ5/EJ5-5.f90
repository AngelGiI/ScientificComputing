INTEGER, PARAMETER:: n=100
REAL, DIMENSION(n):: x, y
DO i = 1, n
  x(i) = 1.76*i
  y(i) = x(i)**2./3 - i
ENDDO
xty = escalar(x,y,n)
PRINT*, ' xty =', xty
END

REAL FUNCTION escalar (x,y,n)
REAL x(*), y(*)       ! tamaño asumido
escalar = 0.0
DO i = 1, n
  escalar = escalar + x(i)*y(i)
ENDDO
END FUNCTION escalar