REAL x(20,30,40), y(15), maxymin, prodysum

DO i=1,20; DO j=1,30; DO k=1,40; x(i,j,k)=i+j-k**2; ENDDO; ENDDO; ENDDO
DO i=1,15; y(i)= 1.3*i-1.9; ENDDO

maxymin = MAXVAL(x) + MINVAL(y)
PRINT*, ' maxymin=', maxymin
prodysum = PRODUCT(y) + SUM(x)
PRINT*, ' prodysum=', prodysum

END