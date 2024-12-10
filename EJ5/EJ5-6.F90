REAL x(100)
INTEGER, PARAMETER:: imat=10, iterna=5, jterna=6
INTEGER mat(imat,20), terna(iterna,jterna,7)

DO i=1,100; x(i) = 1./i; ENDDO
DO i=1,8; DO j=1,15; mat(i,j)=i+j; ENDDO; ENDDO
DO i=1,3; DO j=1,2; DO k=1,4; terna(i,j,k)=i-j+2*k; ENDDO; ENDDO; ENDDO
fval = f(x, mat, terna)
PRINT*, ' f(x,mat,terna) = ', fval
CALL subrut (mat, imat, 8, 15, terna, iterna, jterna, 3, 2, 4, salida)
PRINT*, ' salida =', salida
END

FUNCTION f(a, m2, m3)
REAL a(*)
INTEGER m2(10,*), m3(5,6,*)
  f = a(30) + m2(4,5) + m3(1,2,3)
END

SUBROUTINE subrut (mat, im, n, m, terna, it, jt, ti, tj, tk, salida)
INTEGER im, n, m, it, jt, ti, tj, tk, mat(im,*), terna(it,jt,*)
  salida = mat(n,m) + terna(ti,tj,tk)
END