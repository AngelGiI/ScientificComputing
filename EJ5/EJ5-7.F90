INTEGER, PARAMETER:: mda=10, mdb=20, mdc=50
REAL a(mda,15), b(mdb,20), c(mdc,25)

! Inicializacion de las matrices a, b

DO i = 1, 2
  DO j = 1, 3
    a(i,j) = i+j-1
  ENDDO
ENDDO
DO i = 1, 3
  DO j = 1, 2
    b(i,j) = i+2*j+1
  ENDDO
ENDDO

CALL mult (a, b, c, mda, mdb, mdc, 2, 3, 2)
PRINT*, ' c = ', c(1,1), c(1,2), c(2,1), c(2,2)
END

! Subrutina que calcula el producto de dos matrices

SUBROUTINE mult (a, b, c, mda, mdb, mdc, n1, n2, n3)
REAL a(mda,*), b(mdb,*), c(mdc,*)

DO i = 1, n1
  DO j = 1, n3
    c(i,j) = 0.0
    DO k = 1, n2
      c(i,j) = c(i,j) + a(i,k)*b(k,j)
    ENDDO
  ENDDO
ENDDO
END